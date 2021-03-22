Include Ensemble

Class ISSAS.Common.Message.HPRIMv2HL7 Extends EnsLib.HL7.Message [ ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/Message/HPRIMv2HL7.xml#4 $";

Method UpdateMSHFromSegmentH(segmentH As %String) As %Status
{
	If ($L(segmentH) <= 0)
	{ Quit $$$ERROR($$$GeneralError, "HPRIMv2 segment H is empty") }

	// Define HPRIMv2 HL7 separators
	Set ..Separators = $E(segmentH, 2, 6)
	Set firstSep = $E(..Separators, 1, 1)
	Set secondSep = $E(..Separators, 2, 2)
	$$$TRACE("HPRIMv2 delimiters : "_..Separators)
	$$$TRACE("Field delimiter : "_firstSep)
	$$$TRACE("Component delimiter : "_secondSep)
	If (secondSep = firstSep)
	{
		Set ..Separators = "|^~\&"
		Set secondSep = $E(..Separators, 2, 2)
		$$$TRACE("HPRIMv2 delimiters : "_..Separators)
		$$$TRACE("Field delimiter : "_firstSep)
		$$$TRACE("Component delimiter : "_secondSep)
	}

	// Define HPRIMv2 document type
	Set msgType = $P(segmentH, firstSep, 7)
	$$$TRACE("HPRIMv2 message type : "_msgType)
	If ($L(msgType) <= 0) { Quit $$$ERROR($$$GeneralError, "HPRIMv2 message type is empty") }
	Set ..DocType = "HPRIMV2:"_msgType

	// Update MSH segment from H segment
	Set tSC = ..SetValueAt($P($P(segmentH, firstSep, 5), secondSep, 1), "MSH:MSH03SendingApplication")  If ($$$ISERR(tSC)) { Quit tSC }
	Set tSC = ..SetValueAt($P($P(segmentH, firstSep, 5), secondSep, 2), "MSH:MSH04SendingFacility")  If ($$$ISERR(tSC)) { Quit tSC }
	Set tSC = ..SetValueAt($P($P(segmentH, firstSep, 10), secondSep, 1), "MSH:MSH05ReceivingApplication")  If ($$$ISERR(tSC)) { Quit tSC }
	Set tSC = ..SetValueAt($P($P(segmentH, firstSep, 10), secondSep, 2), "MSH:MSH06ReceivingFacility")  If ($$$ISERR(tSC)) { Quit tSC }
	Set tSC = ..SetValueAt(msgType, "MSH:MSH09MessageType")  If ($$$ISERR(tSC)) { Quit tSC }
	Set tSC = ..SetValueAt($P(segmentH, firstSep, 12), "MSH:MSH11ProcessingID")  If ($$$ISERR(tSC)) { Quit tSC }
	Set tSC = ..SetValueAt($P(segmentH, firstSep, 13), "MSH:MSH12VersionID")  If ($$$ISERR(tSC)) { Quit tSC }
	Set tSC = ..SetValueAt($ZDATE($PIECE($HOROLOG,",",1),8)_$E($TR($ZTIME($PIECE($HOROLOG,",",2)),":",""),1,6), "MSH:MSH07DateTimeOfMessage")  If ($$$ISERR(tSC)) { Quit tSC }

	Quit tSC
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
