Class ISSAS.Common.BS.MTS.TCPServiceKSC Extends Ens.BusinessService [ ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/BS/MTS/TCPService.xml#4 $";

/// Define fields separators to parse a segment
Property MSHDelimiter As %String [ InitialExpression = "\^~|&" ];

/// Define document type <=> application name (caller)
Property MSHDocType As %String [ InitialExpression = "ClinicomReceiver" ];

/// Define piece index where we can find the message type
Property MSHPieceMessageType As %Integer [ InitialExpression = 1 ];

/// Define sending application to insert into MSH segment
Property MSHSendingApp As %String [ InitialExpression = "Clinicom" ];

/// Define sending facility to insert into MSH segment
Property MSHSendingFacility As %String [ InitialExpression = "ISSAS" ];

/// Define processing ID to insert into MSH segment (Environment)
Property MSHProcessingId As %String;

/// Configuration item(s) to which to send messages
Property TargetConfigNames As %String(MAXLEN = 2000);

/// Put some text into this field to simulate a message when the business service is started
Property TestInputString As %String(MAXLEN = 999999999);

/// Store a set of searchable properties associated with each HL7 message processed. <br/>
/// These records will be stored in the named SearchTable class, if any.
Property SearchTableClass As %String(MAXLEN = 128) [ InitialExpression = "ISSAS.Common.SearchTable.Clinicom" ];

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

Parameter ADAPTER = "ISSAS.Common.Adapter.MTS.TCP.InboundAdapter";

Parameter SETTINGS = "TargetConfigNames, MSHDelimiter, MSHDocType, MSHPieceMessageType, MSHSendingApp, MSHSendingFacility, MSHProcessingId, TestInputString, SearchTableClass::selector?context={Ens.ContextSearch/SearchTableClasses?host=EnsLib.HL7.Service.Standard}, EnableSearchTableWarning, DaysToKeepMessages";

Method OnProcessInput(pInput As ISSAS.Common.Adapter.MTS.Message.Message, pOutput As %RegisteredObject) As %Status
{
	#Dim tSC As %Status = $$$OK
	#Dim pHL7 As ISSAS.Common.Message.ClinicomHL7 = ##class(ISSAS.Common.Message.ClinicomHL7).%New()

	// Initialize Clinicom HL7 parameters
	Set pHL7.MSHDelimiter = ..MSHDelimiter
	Set pHL7.MSHDocType = ..MSHDocType
	Set pHL7.MSHPieceMessageType = ..MSHPieceMessageType
	Set pHL7.MSHSendingApp = ..MSHSendingApp
	Set pHL7.MSHSendingFacility = ..MSHSendingFacility
	Set pHL7.MSHProcessingId = ..MSHProcessingId

	// Convert from MTS to HL7
	Set tSC = pHL7.FromMTS(pInput)

	// If an error occured, don't send message to targets
	If ($$$ISERR(tSC)) { Quit tSC }

	// Send HL7 message to all targets
	For iTarget=1:1:$L(..TargetConfigNames, ",")
	{
		Set tOneTarget=$ZStrip($P(..TargetConfigNames,",",iTarget),"<>W")  Continue:""=tOneTarget
		$$$sysTRACE("Sending HL7 Message "_pHL7_" / "_pHL7.%Id()_" from "_pHL7.Source_" to '"_tOneTarget_"'")
		Set tSC1=..SendRequestAsync(tOneTarget,pHL7)  Set:$$$ISERR(tSC1) tSC=$$$ADDSC(tSC,tSC1)
	}
	If ($$$ISERR(tSC)) { Quit tSC }

	// Build index for search table
	Do ##class(ISSAS.Common.SearchTable.BaseClass).IndexDocHelper(..SearchTableClass, pHL7, ..EnableSearchTableWarning)

	Quit tSC
}

/// Return an array of connections for drawing lines on the config diagram
ClassMethod OnGetConnections(Output pArray As %String, pItem As Ens.Config.Item)
{
	Do pItem.PopulateModifiedSettings()
	Set (tValue,tIndex)="" For {
		Set tSetting = pItem.ModifiedSettings.GetNext(.tIndex) Quit:tIndex=""
		If tSetting.Name="TargetConfigNames" Set tValue=tSetting.Value  Quit
	}
	For i=1:1:$L(tValue,",") { Set tOne=$ZStrip($P(tValue,",",i),"<>W")  Continue:""=tOne  Set pArray(tOne)="" }
}

Method OnInit() As %Status
{
	If ($L(..TestInputString))
	{
		// The user writes a text to simulate a message
		$$$LOGINFO("'TestInputString' property found to simulate a message : "_..TestInputString)

		// Build a stream from 'TestInputString' property
		Set pStream = ##class(%GlobalCharacterStream).%New()
		Do pStream.LineTerminatorSet($C(10))
		Do pStream.Write(..TestInputString)

		// Message count limited to 999
		Set %MSGCount = $I(%MSGCount)
		If (%MSGCount > 999) { Set %MSGCount = 1 }

		// Build a MTS message from the stream
		Set pMTS = ##class(ISSAS.Common.Adapter.MTS.Message.Message).%New()
		Set pMTS.BSBOName = ..%ConfigName
		Set pMTS.IsInbound = "IN"
		Set pMTS.MessageId = $TR($J(%MSGCount, 3), " ", "0")
		Set tSC = pMTS.FromStream(pStream, 1)
		If ($$$ISERR(tSC)) { $$$LOGERROR(tSC) }

		// Call OnProcessInput() method to send the message
		Set tSC = ..OnProcessInput(pMTS, "")
		If ($$$ISERR(tSC)) { $$$LOGERROR(tSC) }
		Set ..TestInputString = ""
	}

	Quit ##super()
}

}
