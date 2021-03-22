Include Ensemble

Class ISSAS.Common.Adapter.MTS.Message.Message Extends (%RegisteredObject, %XML.Adaptor)
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/Adapter/MTS/Message/Message.xml#3 $";

/// List of segments to define a message
Property ListOfSegment As ISSAS.Common.Adapter.MTS.Message.ListOfSegment;

/// Current message GUID
Property GUID As %String;

/// Current message id with 3 characters : min value = 1, max value = 999
Property MessageId As %String;

/// Business Service/Operation name
Property BSBOName As %String(MAXLEN = "");

/// Inbound or Outbound side
Property IsInbound As %String(MAXLEN = "");

/// An error occurred receiving segment count
Property InvalidSegmentCount As %Integer [ InitialExpression = 0 ];

Method %OnNew(initvalue As %CacheString) As %Status [ Private, ProcedureBlock = 1, ServerOnly = 1 ]
{
	Set ..ListOfSegment = ##class(ISSAS.Common.Adapter.MTS.Message.ListOfSegment).%New()
	Set ..GUID = ##class(%SYSTEM.Util).CreateGUID()
	Quit $$$OK
}

/// Insert a segment into the current message
Method InsertSegment(segment As %String, bPersist As %Boolean) As %Status
{
	If ($L(segment) < ##class(ISSAS.Common.Adapter.MTS.Message.Segment).#MINLENGTH)
	{ Quit $$$ERROR($$$GeneralError, "MTS Segment : segment size is not valid ("_$L(segment)_")") }

	Set newSegment = ##class(ISSAS.Common.Adapter.MTS.Message.Segment).%New()
	Set newSegment.MessageGUID = ..GUID
	Set newSegment.BSBOName = ..BSBOName
	Set newSegment.IsInbound = ..IsInbound

	Set newSegment.Header.MessageType = $E(segment, 1, 3)
	Set newSegment.Header.SegmentCount = $E(segment, 4, 6)
	Set newSegment.Header.MessageId = $E(segment, 7, 9)
	Set newSegment.Header.IsLastSegment = $E(segment, 10, 12)
	Set newSegment.Header.DataSize = $E(segment, 13, 16)

	If (newSegment.Header.DataSize > 0)
	{ Set newSegment.Data = $E(segment, 17, *) }

	If ((..ListOfSegment.Count() < 999) && ($NUMBER(newSegment.Header.SegmentCount) '= $NUMBER((..ListOfSegment.Count() + 1))))
	{
		Set ..InvalidSegmentCount = 1
		$$$LOGWARNING("MTS Segment : segment count is not valid (get "_newSegment.Header.SegmentCount_" instead of "_(..ListOfSegment.Count() + 1)_")")

		// JIRA CCOMTCC-20 : Traitement des segments dupliqués sur Adapter MTS
		If (..ListOfSegment.Count() > 0) { Quit $$$OK }
		/*
		Set lastSegment = ..ListOfSegment.GetLast()
		If ((lastSegment '= "") && (lastSegment.Data = newSegment.Data))
		{
			$$$LOGWARNING("MTS Segment : current received segment is equal to the last inserted segment, replace the last segment in the message")
			Do ..ListOfSegment.RemoveAt(..ListOfSegment.Count())
		}
		*/
	}

	Set sc = newSegment.IsValid()
	If ($$$ISERR(sc)) { $$$LOGWARNING($$$StatusDisplayString(sc)) }

	If (bPersist)
	{
		Set sc = newSegment.%Save()
		If ($$$ISERR(sc)) { $$$LOGERROR($$$StatusDisplayString(sc)) }
	}

	Do ..ListOfSegment.Insert(newSegment)
	Quit sc
}

/// Build a segment with parameter data (with a default header) and insert it into the current message
Method InsertData(data As %String) As %Status
{
	Set newSegment = ##class(ISSAS.Common.Adapter.MTS.Message.Segment).%New()
	Set newSegment.MessageGUID = ..GUID
	Set newSegment.BSBOName = ..BSBOName
	Set newSegment.IsInbound = ..IsInbound
	Set newSegment.Data = data

	Set newSegment.Header.MessageType = "DAT"
	Set newSegment.Header.SegmentCount = $TR($J((..ListOfSegment.Count() + 1), 3), " ", "0")
	Set newSegment.Header.MessageId = $TR($J(..MessageId, 3), " ", "0")
	Set newSegment.Header.IsLastSegment = "NLS"
	Set newSegment.Header.DataSize = $TR($J($L(data), 4), " ", "0")

	Do ..ListOfSegment.Insert(newSegment)
	Quit $$$OK
}

Method BuildACK(index As %Integer) As %String
{
	If ((index <= 0) || (index > ..ListOfSegment.Count())) { Quit "" }
	Set segment = ..ListOfSegment.GetAt(index)
	If (segment = "") { Quit "" }
	Set segmentCount = $E($TR($J(segment.Header.SegmentCount, 3), " ", "0"), 1, 3)
	Set msgId = $E($TR($J(segment.Header.MessageId, 3), " ", "0"), 1, 3)
	Set ack = "ACK"  // If (..InvalidSegmentCount) { Set ack = "NAK" }
	Quit ack_segmentCount_msgId_"END"_"0000"
}

Method FromStream(pInput As %IO.DeviceStream, bPersist As %Boolean) As %Status
{
	#Dim tSC As %Status = $$$OK
	#Dim currSegCount As %Integer = 1

	// Read file and build all MTS segments
	Do ..ListOfSegment.Clear()
	While (' pInput.AtEnd)
	{
		Set line = pInput.ReadLine()
		$$$TRACE("read MTS line : "_line)
		Set tSC = ..InsertData(line)
		If ($$$ISERR(tSC)) { Quit }
	}
	If ($$$ISERR(tSC)) { Quit tSC }

	// Iterate over all segments into MTS message
	For I=1:1:..ListOfSegment.Count()
	{
		// Retrieve and prepare segment to send
		Set segment = ..ListOfSegment.GetAt(I)
		Set segment.Header.SegmentCount = $TR($J(currSegCount, 3), " ", "0")
		If ($NUMBER(I) = $NUMBER(..ListOfSegment.Count()))
		{ Set segment.Header.IsLastSegment = "END" }

		// Check if segment to send is valid
		Set tSC = segment.IsValid()
		If ($$$ISERR(tSC)) { $$$LOGWARNING($$$StatusDisplayString(tSC)) }

		If (bPersist)
		{
			// Persist segment into database
			Set tSC = segment.%Save()
			If ($$$ISERR(tSC)) { $$$LOGERROR($$$StatusDisplayString(tSC))  Quit }
		}

		// Increment segment count (max value = 999)
		Set currSegCount = (currSegCount + 1)
		If (currSegCount > 999) { Set currSegCount = 1 }
		Do ..ListOfSegment.%UnSwizzleAt(I)
	}

	Quit tSC
}

}
