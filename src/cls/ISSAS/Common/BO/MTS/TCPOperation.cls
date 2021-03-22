Class ISSAS.Common.BO.MTS.TCPOperation Extends Ens.BusinessOperation [ ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/BO/MTS/TCPOperation.xml#4 $";

/// Add MSH segment to MTS message
Property MSHAddToMTS As %Boolean [ InitialExpression = 1 ];

/// Define sending application to insert into MSH segment
Property MSHSendingApp As %String;

/// Define sending facility to insert into MSH segment
Property MSHSendingFacility As %String;

/// Define receiving application to insert into MSH segment
Property MSHReceivingApp As %String;

/// Define receiving facility to insert into MSH segment
Property MSHReceivingFacility As %String;

/// Define processing ID to insert into MSH segment (Environment)
Property MSHProcessingId As %String;

/// How long to keep retrying before giving up and returning an error code. <br/>
/// -1 means never give up.
Property FailureTimeout As %Numeric(MINVAL = -1) [ InitialExpression = -1 ];

/// How frequently to retry access to the output system
Property RetryInterval As %Numeric(MINVAL = 0) [ InitialExpression = 10 ];

/// Store a set of searchable properties associated with each HL7 message processed. <br/>
/// These records will be stored in the named SearchTable class, if any.
Property SearchTableClass As %String(MAXLEN = 128) [ InitialExpression = "ISSAS.Common.SearchTable.ClinicomReceiver" ];

/// Log warnings in journal when an error occurred storing message searchable properties in SearchTable class.
Property EnableSearchTableWarning As %Boolean [ InitialExpression = 1 ];

/// Number of days to keep messages stored into database. <br/>
/// Each messages status are separated by a comma : <i>'msg completed', 'msg error', 'msg aborted', 'msg suspended', 'msg discarded'</i>. <br/>
/// If this parameter is empty (or equal to 0), messages are never removed from database. <br/>
/// Note : messages are automatically deleted by the scheduled task <i>ISSAS.Common.SysTask.PurgeMsg</i>. <br/>
/// Examples : <br/>
/// * <i>60, 120</i> => delete completed messages after 60 days, and error messages after 120 days. <br/>
/// * <i>30, 0, 180</i> => delete completed messages after 30 days, and aborted messages after 180 days. <br/>
/// * <i>120</i> => delete completed messages after 120 days.
Property DaysToKeepMessages As %String;

Parameter ADAPTER = "ISSAS.Common.Adapter.MTS.TCP.OutboundAdapter";

Property Adapter As ISSAS.Common.Adapter.MTS.TCP.OutboundAdapter;

Parameter INVOCATION = "Queue";

Parameter SETTINGS = "MSHAddToMTS, MSHSendingApp, MSHSendingFacility, MSHReceivingApp, MSHReceivingFacility, MSHProcessingId, SearchTableClass::selector?context={Ens.ContextSearch/SearchTableClasses?host=EnsLib.HL7.Service.Standard}, EnableSearchTableWarning, DaysToKeepMessages";

Method OnProcessClinicomHL7(pRequest As ISSAS.Common.Message.ClinicomHL7, Output pResponse As Ens.Response) As %Status
{
	#Dim tSC As %Status = $$$OK
	#Dim pMTS As ISSAS.Common.Adapter.MTS.Message.Message = ##class(ISSAS.Common.Adapter.MTS.Message.Message).%New()

	// Initialize HL7 parameters
	Set pRequest.MSHAddToMTS = ..MSHAddToMTS
	Set pRequest.MSHSendingApp = ..MSHSendingApp
	Set pRequest.MSHSendingFacility = ..MSHSendingFacility
	Set pRequest.MSHReceivingApp = ..MSHReceivingApp
	Set pRequest.MSHReceivingFacility = ..MSHReceivingFacility
	Set pRequest.MSHProcessingId = ..MSHProcessingId
	Set tSC = pRequest.UpdateMSHToSendToClinicom()

	// Initialize MTS parameters
	Set pMTS.BSBOName = ..%ConfigName
	Set pMTS.IsInbound = "OUT"

	// Convert from HL7 to MTS
	Set tSC = pRequest.ToMTS(pMTS)

	// If an error occured, don't send message to outbound adapter
	If ($$$ISERR(tSC)) { Quit tSC }

	// Send MTS message to outbound adapter
	Set tSC = ..Adapter.SendMessage(pMTS)
	If ($$$ISERR(tSC)) { Quit tSC }

	// Build index for search table
	Do ##class(ISSAS.Common.SearchTable.BaseClass).IndexDocHelper(..SearchTableClass, pRequest, ..EnableSearchTableWarning)

	Quit tSC
}

Method OnProcessHPRIMv2HL7(pRequest As ISSAS.Common.Message.HPRIMv2HL7, Output pResponse As Ens.Response) As %Status
{
	Quit ..OnProcessHL7(pRequest, .pResponse)
}

Method OnProcessHL7(pRequest As EnsLib.HL7.Message, Output pResponse As Ens.Response) As %Status
{
	// This case should never happen
	$$$LOGWARNING("Bad target class defined into DTL : must be 'ISSAS.Common.Message.ClinicomHL7' instead of '"_$CLASSNAME(pRequest)_"'")

	// Clone HL7 message
	Set pClinicomHL7 = ##class(ISSAS.Common.Message.ClinicomHL7).%New()
	Set tSC = pClinicomHL7.CloneFromHL7(pRequest)
	If ($$$ISERR(tSC)) { Quit tSC }

	Quit ..OnProcessClinicomHL7(pClinicomHL7, .pResponse)
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="ISSAS.Common.Message.ClinicomHL7">
		<Method>OnProcessClinicomHL7</Method>
	</MapItem>
	<MapItem MessageType="ISSAS.Common.Message.HPRIMv2HL7">
		<Method>OnProcessHPRIMv2HL7</Method>
	</MapItem>
	<MapItem MessageType="EnsLib.HL7.Message">
		<Method>OnProcessHL7</Method>
	</MapItem>
</MapItems>
}

}
