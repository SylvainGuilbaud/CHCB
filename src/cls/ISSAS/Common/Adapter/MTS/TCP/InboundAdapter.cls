Class ISSAS.Common.Adapter.MTS.TCP.InboundAdapter Extends EnsLib.TCP.CountedInboundAdapter [ ClassType = "", Inheritance = right, ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/Adapter/MTS/TCP/InboundAdapter.xml#3 $";

/// Character encoding scheme used for decoding incoming data and encoding outgoing data. For no encoding, use 'Binary'.
/// Other choices include: <br/>
///  Native - the default character encoding of the installed locale of the Ensemble server <br/>
///  latin1 - the ISO Latin1 8-bit encoding <br/>
///  ISO-8859-1 - the ISO Latin1 8-bit encoding <br/>
///  UTF-8 - the Unicode 8-bit encoding <br/>
///  Unicode - the Unicode 16-bit encoding  (Little-Endian) <br/>
///  UnicodeBig - the Unicode 16-bit encoding (Big-Endian) <br/>
///  @&lt;ttable&gt; - &lt;ttable&gt; means a raw InterSystems character translation table name. A prefix of '@' means to use the named table.
Property Charset As %String [ InitialExpression = "ISO-8859-1" ];

/// The minimum interval between invocations of the adapter by the Ensemble framework. For adapters that poll for
/// external events, this is the polling interval. However, most polling adapters will process all inputs immediately
/// if several are detected at one time. This is also the interval at which each Business Service will check for shutdown requests.
Property CallInterval As %Numeric(MINVAL = 0.1) [ InitialExpression = 5 ];

/// Current MTS message
Property CurrentMessage As ISSAS.Common.Adapter.MTS.Message.Message;

Method OnConnected() As %Status
{
	Set tQuitErr = 1
	Set bContinue = 0
	$$$TRACE("MTS OnConnected started : clear current message")
	Set ..CurrentMessage = ""

	Do {
		Set tCharset=..Charset  Set:$Case($ZCVT(..Charset,"L"),"default":1,"auto":1,:0) tCharset="UTF-8"
		Set tString=$$$NULLOREF, tSC=..ReadCountedString(.tString,tCharset,..CallInterval,..ReadTimeout,1)

		If $$$ISERR(tSC) {
			If ..IsReadError(tSC) {
				Set tSC=$$$ERROR($$$EnsErrInConnectionLost,"TCP Counted Read",..IOAddr,$$$StatusDisplayString(tSC))
				Set tQuitErr=0  Do ..Disconnect()
				If '$L(tString) Set tTxt=$$$StatusText(tSC), tSC=$$$OK  If ..StayConnected<0 { $$$LOGWARNING(tTxt) } ElseIf ..%logConnections { $$$LOGINFO(tTxt) } Else { $$$sysTRACE(tTxt) } ; change error to info if lost connection with no data and trying to stay connected
			} ElseIf $$$StatusEquals(tSC,$$$EnsErrTCPReadBlockSizeTimeoutExpired) {
				If '$L(tString) { Set tSC=$$$OK } ; no error if timed out with no data
				Else { Set tQuitErr=0 }
			}
			Quit
		}

		Set tStringOut = ""
		Set tSC = ..CollectMessage(tString, .tStringOut, .bContinue)
		If ($$$ISERR(tSC)) { $$$TRACE("MTS Collect Error : "_$$$StatusDisplayString(tSC))  Quit }

		If ($L(tStringOut))
		{
			Set tSC=..WriteCountedString(tStringOut,tCharset,1)
			If $$$ISERR(tSC) {
				If ..IsWriteError(tSC) {
					Set tSC=$$$ERROR($$$EnsErrInConnectionLost,"TCP Counted Write",..IOAddr,$$$StatusDisplayString(tSC))
					Set tQuitErr=0  Do ..Disconnect()
				}
				$$$ACLOSEIOLOGENTRY(tSC,"after TCP WriteCountedStream error on :"_..IOAddr,tStringOut)
				Quit
			}
			$$$ACLOSEIOLOGENTRY(tSC,"after TCP WriteCountedStream on :"_..IOAddr,tStringOut)
		} Else {
			$$$ACLOSEIOLOGENTRY(tSC,"after TCP ProcessInput on :"_..IOAddr,$$$NULLOREF)
		}
	} While (bContinue)

	#; Returning error status would cause this listener job to terminate
	If $$$ISERR(tSC) {
		#; Never quit the listener, but drop the connection on unrecognized error
		If tQuitErr&&..Connected&&..StayConnected { $$$LOGERROR("Disconnecting due to "_$$$StatusDisplayString(tSC)) Set tSC=$$$OK  Do ..Disconnect() }
		If $$$ISERR(tSC) $$$LOGSTATUS(tSC)
	}
	ElseIf (..CurrentMessage '= "")
	{ Set tSC = ..BusinessHost.ProcessInput(..CurrentMessage) }

	$$$TRACE("MTS OnConnected finished : clear current message")
	Set ..CurrentMessage = ""
	Quit $$$OK
}

/// Read a counted block from the TCP socket into the Stream using a Charset for translation.
/// (logs errors except for <READ> errors after the initial blocksize read.)
Method ReadCountedString(ByRef pString As %String, pCharset As %String = "", pStartTimeout As %Numeric = -1, pChunkTimeout As %Numeric = 60, pInbound As %Boolean = 0) As %Status
{
	Set tSC=$$$OK, pString="", $ZT="Trap"
	Do {
		If 'pInbound $$$catTRACE("protocol","Waiting to read string counted data block from "_..IOAddr_" using charset '"_pCharset_"' with timeout="_pStartTimeout)
		Do SetIO^%NLS("RAW")  ; Switch to RAW input mode

		If -1=pStartTimeout { Read tHeader#16  Set tTimedOut = 0 }
		Else { Read tHeader#16:pStartTimeout  Set tTimedOut = '$Test }
		If tTimedOut { Set tSC = $$$ERROR($$$EnsErrTCPReadBlockSizeTimeoutExpired,pStartTimeout, 16) Quit }
		Set tLenStr = $E(tHeader, 13, 16)
		Set tLen = tLenStr
		$$$TRACE("read MTS header : "_tHeader)

		#; Convert to integer
		//Set tLen = $Case(..Endian,"Little":$ZLAscii(tLenStr), :$Ascii(tLenStr)*256+$Ascii(tLenStr,2)*256+$Ascii(tLenStr,3)*256+$Ascii(tLenStr,4))
		If 'tLen {
			If $$$ISOK(tSC) { $$$catTRACE("protocol","Got inbound string data block (size=0) from "_..IOAddr_", Status OK") }
			Quit
		}
		Set tTable = ##class(%IO.I.TranslationDevice).GetCharEncodingTable(pCharset)
		If "RAW"=tTable {
			$$$catTRACE("protocol","Got block count="_tLen_", waiting to read (raw) string with timeout="_pChunkTimeout)
			If -1=pChunkTimeout { Read pString#tLen  Set tTimedOut = 0 }
			Else { Read pString#tLen:pChunkTimeout  Set tTimedOut = '$Test }
		} Else {
			Set tLeft = tLen, tMaxChunk=$$$GetClassParameter("%Library.FileCharacterStream","MAXLOCALSIZE")
			$$$catTRACE("protocol","Got string block count="_tLen_", waiting to read in "_tMaxChunk_"-byte chunks using charset '"_pCharset_"' with chunk timeout="_pChunkTimeout)
			While tLeft>0 {
				Set tChunkSize = $select(tLeft>tMaxChunk:tMaxChunk,1:tLeft)
				Set tStartTime=$zh
				Read data#tChunkSize:pChunkTimeout  Set tTimedOut='$Test
				If tTimedOut {
					If $zh-tStartTime < pChunkTimeout { Set tSC = $$$EnsError($$$EnsErrTCPReadBlockSize,pChunkTimeout,tChunkSize,"("_$L(data)_"):"_data)  Quit }
					Else { Set tSC = $$$EnsError($$$EnsErrTCPReadTimeoutExpired,pChunkTimeout,tChunkSize,pCharset)  Quit }
				}
				$$$catTRACE("protocol","Got string data chunk, size="_$L(data)_"/"_tChunkSize)
				Set tLeft = tLeft-$L(data)
				Set pString=pString_$ZCVT(data,"I",tTable)
			}
			$$$catTRACE("protocol","Converted("_tLen_") input string bytes to ("_$L(pString)_") characters using charset '"_pCharset_"', table '"_tTable_"'")
		}
		$$$catTRACE("protocol","Got inbound string data (size="_$L(pString)_") from "_..IOAddr_" : "_$E(pString,1,1000))
	} While (0)

Exit
	If ($$$ISERR(tSC)) { $$$TRACE("MTS ReadCountedString Error : "_$$$StatusDisplayString(tSC))  Set ..CurrentMessage = "" }
	If ($L(pString) > 0) { $$$TRACE("read MTS data ("_$L(pString)_")"_" : "_pString) }
	If ($L($G(tHeader)) > 0) { Set pString = tHeader_pString }
	Quit tSC

Trap
	Set $ZT="", tSC=$$$SystemError
	$$$TRACE("MTS ReadCountedString Trap : clear current message")
	Set ..CurrentMessage = ""
	If ..IsReadError(tSC) {
		Set tSC=$$$ERROR($S(pInbound:$$$EnsErrInConnectionLost,1:$$$EnsErrOutConnectionLost),$S('$D(tLenStr):"BlockCount Read",1:"Counted Read"), ..IOAddr, $$$StatusDisplayString(tSC))
		Set:'pInbound ..BusinessHost.Retry=1
		Do ..Disconnect()
	}
	Goto Exit
}

/// Write the stream contents as a counted block on the TCP socket
/// (logs errors except for <WRITE> error.)
Method WriteCountedString(pString As %String, pCharset As %String = "", pInbound As %Boolean = 0) As %Status
{
	Set tSC=$$$OK, $ZT="Trap"
	Do {
		Set tTable = ##class(%IO.I.TranslationDevice).GetCharEncodingTable(pCharset)
		Do SetIO^%NLS("RAW")
		Set tmp(1) = ""

		$$$TRACE("write MTS segment ("_$L(pString)_") : "_pString)
		Set tLen=$L(pString)
		Write pString
		Write *-3 // flush buffer
		Quit

		If "RAW"=tTable {
			Set tLenStr=$Case(..Endian,"JavaUTF":$Reverse($ZWChar(tLen)),"Little":$ZLChar(tLen), :$Reverse($ZLChar(tLen)))
			Write tLenStr,pString
		} Else {
			#; Use 8k chunks to allow up to 4x expansion in $ZCVT
			Set tLeft=tLen, tLen=0, tMaxChunk=$$$GetClassParameter("%Library.FileCharacterStream","MAXLOCALSIZE") \ 4
			For iChunk=1:1 {
				Set tChunkSize = $S(tLeft>tMaxChunk:tMaxChunk,1:tLeft)
				Set tmp(iChunk) = $ZCVT($E(pString,1,tChunkSize),"O",tTable), tLen=tLen+$L(tmp(iChunk)), $E(pString,1,tChunkSize)=""
				Set tLeft = tLeft-tChunkSize  Quit:tLeft<=0
			}
			$$$catTRACE("protocol","Converted("_tLen_") characters to ("_tLen_") output string bytes using charset '"_pCharset_"', table '"_tTable_"'")
			Set tLenStr=$Case(..Endian,"JavaUTF":$Reverse($ZWChar(tLen)),"Little":$ZLChar(tLen), :$Reverse($ZLChar(tLen)))
			Write tLenStr  For i=1:1:iChunk Write tmp(i)
		}
		Write *-3 // flush buffer
	} While (0)
	If $$$ISOK(tSC) {
		$$$catTRACE("protocol","Wrote output string data block(size="_tLen_") to "_..IOAddr_": "_$E($S("RAW"=tTable:pString,1:tmp(1)),1,1000))
	}

Exit
	If ($$$ISERR(tSC)) { $$$TRACE("MTS WriteCountedString Error : "_$$$StatusDisplayString(tSC))  Set ..CurrentMessage = "" }
	Quit tSC

Trap
	Set $ZT="", tSC=$$$SystemError
	$$$TRACE("MTS WriteCountedString Trap : clear current message")
	Set ..CurrentMessage = ""
	If ..IsWriteError(tSC) {
		Set tSC=$$$ERROR($S(pInbound:$$$EnsErrInConnectionLost,1:$$$EnsErrOutConnectionLost),$S('$D(tLenStr):"BlockCount Write",1:"Counted Write"), ..IOAddr, $$$StatusDisplayString(tSC))
		Set:'pInbound ..BusinessHost.Retry=1
		Do ..Disconnect()
	}
	Goto Exit
}

Method CollectMessage(pInput As %String, pOutput As %String, ByRef bOutContinue As %Boolean) As %Status
{
	#Dim tSC As %Status = $$$OK
	#Dim pSegment As ISSAS.Common.Adapter.MTS.Message.Segment = ""
	Set bOutContinue = 0

	// Create and initialize a new MTS message
	If (..CurrentMessage = "")
	{
		$$$TRACE("MTS CollectMessage : create new message")
		Set ..CurrentMessage = ##class(ISSAS.Common.Adapter.MTS.Message.Message).%New()
		Set ..CurrentMessage.BSBOName = ..BusinessHost.%ConfigName
		Set ..CurrentMessage.IsInbound = "IN"
	}

	// Create a new segment, insert it into the message and build last insert ACK
	Set tSC = ..CurrentMessage.InsertSegment(pInput, 1)
	If (' $$$ISERR(tSC)) { Set pSegment = ..CurrentMessage.ListOfSegment.GetLast() }
	If (' $$$ISERR(tSC)) { Set pOutput = ..CurrentMessage.BuildACK(..CurrentMessage.ListOfSegment.Count()) }
	If (pSegment '= "") { Set bOutContinue = (' pSegment.IsLast()) }

	// Send a NAK to CCOM instead of ACK
	If ($E($G(pOutput), 1, 3) = "NAK")
	{ $$$TRACE("MTS : send a NAK ("_pOutput_")")  Set bOutContinue = 1 }

	Quit tSC
}

}
