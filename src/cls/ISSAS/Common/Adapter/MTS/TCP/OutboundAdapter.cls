Class ISSAS.Common.Adapter.MTS.TCP.OutboundAdapter Extends EnsLib.TCP.CountedOutboundAdapter [ ClassType = "", Inheritance = right, ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/Adapter/MTS/TCP/OutboundAdapter.xml#3 $";

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

/// If TCP adapter has been disconnected, need to reinit message counter to synchronize with MTS side
Property ReinitMsgCount As %Boolean [ InitialExpression = 0 ];

Method SendMessage(pInput As ISSAS.Common.Adapter.MTS.Message.Message) As %Status
{
	#Dim tSC As %Status = $$$OK
	#Dim currSegCount As %Integer = 1
	#Dim segment As ISSAS.Common.Adapter.MTS.Message.Segment
	#Dim %MSGCount = $I(%MSGCount)

	// Message count limited to 999
	If (%MSGCount > 999) { Set %MSGCount = 1 }
	If (..ReinitMsgCount) { Set %MSGCount = 1 }
	Set ..ReinitMsgCount = 0

	// Iterate over all segments to send
	For I=1:1:pInput.ListOfSegment.Count()
	{
		// Retrieve and prepare segment to send
		Set segment = pInput.ListOfSegment.GetAt(I)
		Set segment.Header.SegmentCount = $TR($J(currSegCount, 3), " ", "0")
		Set segment.Header.MessageId = $TR($J(%MSGCount, 3), " ", "0")
		If ($NUMBER(I) = $NUMBER(pInput.ListOfSegment.Count()))
		{ Set segment.Header.IsLastSegment = "END" }

		// Check if segment to send is valid
		Set tSC = segment.IsValid()
		If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }

		// Send segment and receive ACK
		Set ack = ""
		Set lineToSend = segment.ToString()
		Set tSC = ..SendMessageString(lineToSend, .ack)
		If ($$$ISERR(tSC)) { $$$LOGERROR(tSC)  Quit }

		// Verify that received ACK is valid
		Set validAck = pInput.BuildACK(I)
		If (ack '= validAck) { $$$LOGWARNING("MTS : received ACK is not valid ("_ack_")") }

		// Persist segment into database
		Set tSC = segment.%Save()
		If ($$$ISERR(tSC)) { $$$LOGERROR(tSC)  Quit }

		// Increment segment count (max value = 999)
		Set currSegCount = currSegCount + 1
		If (currSegCount > 999) { Set currSegCount = 1 }
	}

	Quit tSC
}

Method Connect(pTimeout As %Numeric) As %Status
{
	// If TCP adapter has been disconnected, need to reinit message counter to synchronize with MTS side
	If ((' ..Connected) && (' ..ReinitMsgCount))
	{ $$$LOGINFO("MTS : init message counter to value '1'")  Set ..ReinitMsgCount = 1 }
	Quit ##super(pTimeout)
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
	If ($L(pString) > 0) { $$$TRACE("read MTS data ("_$L(pString)_")"_" : "_pString) }
	Set pString = tHeader_pString
	Quit tSC

Trap
	Set $ZT="", tSC=$$$SystemError
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
	Quit tSC

Trap
	Set $ZT="", tSC=$$$SystemError
	If ..IsWriteError(tSC) {
		Set tSC=$$$ERROR($S(pInbound:$$$EnsErrInConnectionLost,1:$$$EnsErrOutConnectionLost),$S('$D(tLenStr):"BlockCount Write",1:"Counted Write"), ..IOAddr, $$$StatusDisplayString(tSC))
		Set:'pInbound ..BusinessHost.Retry=1
		Do ..Disconnect()
	}
	Goto Exit
}

}
