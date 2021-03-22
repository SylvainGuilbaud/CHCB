Include Ensemble

Class ISSAS.Common.Message.ClinicomHL7 Extends EnsLib.HL7.Message [ ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/Message/ClinicomHL7.xml#4 $";

/// Add MSH segment to MTS message
Property MSHAddToMTS As %Boolean [ InitialExpression = 1, Transient ];

/// Define fields separators to parse a segment
Property MSHDelimiter As %String [ InitialExpression = "\^~|&", Transient ];

/// Define document type <=> application name (caller)
Property MSHDocType As %String [ InitialExpression = "Clinicom", Transient ];

/// Define piece index where we can find the message type
Property MSHPieceMessageType As %Integer [ InitialExpression = 1, Transient ];

/// Define sending application to insert into MSH segment
Property MSHSendingApp As %String [ Transient ];

/// Define sending facility to insert into MSH segment
Property MSHSendingFacility As %String [ Transient ];

/// Define receiving application to insert into MSH segment
Property MSHReceivingApp As %String [ Transient ];

/// Define receiving facility to insert into MSH segment
Property MSHReceivingFacility As %String [ Transient ];

/// Define processing ID to insert into MSH segment (Environment)
Property MSHProcessingId As %String [ Transient ];

Method UpdateMSH() As %Status
{
	Do ..SetValueAt(..MSHSendingApp, "MSH:MSH03SendingApplication")
	Do ..SetValueAt(..MSHSendingFacility, "MSH:MSH04SendingFacility")
	Do ..SetValueAt(..MSHReceivingApp, "MSH:MSH05ReceivingApplication")
	Do ..SetValueAt(..MSHReceivingFacility, "MSH:MSH06ReceivingFacility")
	Do ..SetValueAt(..MSHProcessingId, "MSH:MSH11ProcessingID")
	Do ..SetValueAt($ZDATE($PIECE($HOROLOG,",",1),8)_$E($TR($ZTIME($PIECE($HOROLOG,",",2)),":",""),1,6), "MSH:MSH07DateTimeOfMessage")

	Quit $$$OK
}

Method UpdateMSHToSendToClinicom() As %Status
{
	// Clinicom doesn't parse MSH using separators
	// All informations into MSH must have same position and length
	Set (strSendingApp, strSendingFacility, strReceivingApp) = ""
	Set (strReceivingFacility, strProcessingId, strMessageType) = ""

	If ($L(..MSHSendingApp)) { Set strSendingApp = $E(..MSHSendingApp, 1, 12) }
	Else { Set strSendingApp = $E(..GetValueAt("MSH:MSH03SendingApplication"), 1, 12) }
	While ($L(strSendingApp) < 12) { Set strSendingApp = strSendingApp_" " }
	Set tSC = ..SetValueAt(strSendingApp, "MSH:MSH03SendingApplication")
	If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }

	If ($L(..MSHSendingFacility)) { Set strSendingFacility = $E(..MSHSendingFacility, 1, 12) }
	Else { Set strSendingFacility = $E(..GetValueAt("MSH:MSH04SendingFacility"), 1, 12) }
	While ($L(strSendingFacility) < 12) { Set strSendingFacility = strSendingFacility_" " }
	Set tSC = ..SetValueAt(strSendingFacility, "MSH:MSH04SendingFacility")
	If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }

	If ($L(..MSHReceivingApp)) { Set strReceivingApp = $E(..MSHReceivingApp, 1, 12) }
	Else { Set strReceivingApp = $E(..GetValueAt("MSH:MSH05ReceivingApplication"), 1, 12) }
	While ($L(strReceivingApp) < 12) { Set strReceivingApp = strReceivingApp_" " }
	Set tSC = ..SetValueAt(strReceivingApp, "MSH:MSH05ReceivingApplication")
	If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }

	If ($L(..MSHReceivingFacility)) { Set strReceivingFacility = $E(..MSHReceivingFacility, 1, 12) }
	Else { Set strReceivingFacility = $E(..GetValueAt("MSH:MSH06ReceivingFacility"), 1, 12) }
	While ($L(strReceivingFacility) < 12) { Set strReceivingFacility = strReceivingFacility_" " }
	Set tSC = ..SetValueAt(strReceivingFacility, "MSH:MSH06ReceivingFacility")
	If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }

	If ($L(..MSHProcessingId)) { Set strProcessingId = $E(..MSHProcessingId, 1, 3) }
	Else { Set strProcessingId = $E(..GetValueAt("MSH:MSH11ProcessingID"), 1, 3) }
	While ($L(strProcessingId) < 3) { Set strProcessingId = strProcessingId_" " }
	Set tSC = ..SetValueAt(strProcessingId, "MSH:MSH11ProcessingID")
	If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }

	If ($L(..DocTypeName)) { Set strMessageType = $E(..DocTypeName, 1, 3) }
	Else { Set strMessageType = $E(..GetValueAt("MSH:MSH09MessageType"), 1, 3) }
	While ($L(strMessageType) < 3) { Set strMessageType = strMessageType_" " }
	Set tSC = ..SetValueAt(strMessageType, "MSH:MSH09MessageType")
	If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }

	Set strNow = $ZDATE($PIECE($HOROLOG,",",1),8)_$E($TR($ZTIME($PIECE($HOROLOG,",",2)),":",""),1,6)
	Set tSC = ..SetValueAt(strNow, "MSH:MSH07DateTimeOfMessage")
	If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }

	Quit $$$OK
}

Method FromMTS(ByRef pMTS As ISSAS.Common.Adapter.MTS.Message.Message) As %Status
{
	#Dim tSC As %Status = $$$OK

	// Check if input parameter is valid
	If (pMTS = "") { Quit $$$ERROR($$$GeneralError, "MTS message parameter must be instantiated") }
	If (pMTS.ListOfSegment.Count() <= 0) { Quit $$$ERROR($$$GeneralError, "MTS message parameter must have at least 1 segment") }

	// Define all separators to parse the message
	Set ..Separators = ..MSHDelimiter
	Set tSC = ..SetValueAt("MSH"_..MSHDelimiter, 1)
	If ($$$ISERR(tSC)) { $$$LOGERROR(tSC)  Quit tSC }

	// Retrieve the doc type of the message
	Set firstSeg = pMTS.ListOfSegment.GetAt(1)
	Set firstSep = $E(..MSHDelimiter, 1, 1)
	Set docType = $P(firstSeg.Data, firstSep, ..MSHPieceMessageType)
	Set ..DocType = ..MSHDocType_":"_docType

	// Retrieve the message type to put into MSH segment
	If (..MSHPieceMessageType = 1) { Set msgType = docType_$P(firstSeg.Data, firstSep, 2) }
	Else { Set msgType = docType }
	Do ..SetValueAt(msgType, "MSH:MSH09MessageType")

	// Add some informations into MSH segment
	Do ..UpdateMSH()

	// Iterate over all segments into the message
	For I=1:1:pMTS.ListOfSegment.Count()
	{
		Set tSC = ..AppendSegment(##class(EnsLib.HL7.Segment).%New())
		If ($$$ISERR(tSC)) { $$$LOGERROR(tSC)  Quit }

		// Build a fake HL7 message
		Set segment = pMTS.ListOfSegment.GetAt(I)
		Set tSC = ..SetValueAt(segment.Data, (I + 1))
		If ($$$ISERR(tSC)) { $$$LOGERROR(tSC)  Quit }
		Do ..commitSegmentByIndex(I + 1)
	}

	Quit tSC
}

Method ToMTS(ByRef pMTS As ISSAS.Common.Adapter.MTS.Message.Message) As %Status
{
	#Dim tSC As %Status = $$$OK

	// Check if input parameter is valid
	If (pMTS = "") { Quit $$$ERROR($$$GeneralError, "MTS message parameter must be instantiated") }
	Do pMTS.ListOfSegment.Clear()

	// First index to iterare over : exclude or not MSH segment
	Set firstIndex = 2
	If (..MSHAddToMTS) { Set firstIndex = 1 }

	// Iterate over all segments into HL7 message and build MTS message
	For I=firstIndex:1:..SegCount
	{
		Set line = ..GetValueAt(I)
		Set tSC = pMTS.InsertData(line)
		If ($$$ISERR(tSC)) { $$$LOGERROR(tSC)  Quit }
		Do ..commitSegmentByIndex(I)
	}

	Quit tSC
}

Method CloneFromHL7(pHL7 As EnsLib.HL7.Message) As %Status
{
	#Dim tSC As %Status = $$$OK

	// Clear current HL7 message
	If (..SegCount > 1) { Do ..Clear() }

	// Clone HL7 parameters
	Set ..Separators = pHL7.Separators
	Set ..DocType = pHL7.DocType

	// Clone MSH segment
	Set tSC = ..SetValueAt(pHL7.GetValueAt("MSH"), "MSH")
	If ($$$ISERR(tSC)) { Quit tSC }

	// Copy all segments into Clinicom HL7 message
	For I=2:1:pHL7.SegCount
	{
		Set pSegment = ##class(EnsLib.HL7.Segment).%New()
		Set tSC = ..AppendSegment(pSegment)  If ($$$ISERR(tSC)) { Quit }
		Set tSC = ..SetValueAt(pHL7.GetValueAt(I), I)  If ($$$ISERR(tSC)) { Quit }
		Do pHL7.commitSegmentByIndex(I)
		Do ..commitSegmentByIndex(I)
	}

	Quit tSC
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
