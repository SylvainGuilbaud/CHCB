Class ISSAS.Common.BO.HL7.FileOperation Extends Ens.BusinessOperation [ ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/BO/HL7/FileOperation.xml#9 $";

/// Define sending application to insert into MSH segment (MSH-3)
Property MSHSendingApp As %String;

/// Define sending facility to insert into MSH segment (MSH-4)
Property MSHSendingFacility As %String;

/// Define receiving application to insert into MSH segment (MSH-5)
Property MSHReceivingApp As %String;

/// Define receiving facility to insert into MSH segment (MSH-6)
Property MSHReceivingFacility As %String;

/// Define processing ID to insert into MSH segment (Environment) (MSH-11)
Property MSHProcessingId As %String [ InitialExpression = "P" ];

/// Define version ID to insert into MSH segment (MSH-12)
Property MSHVersionId As %String [ InitialExpression = "2.3.1" ];

/// Add MSH segment
Property MSHAddMSH As %Boolean [ InitialExpression = 1 ];

/// File name format can include any of the following keywords :<br/>
/// - %datetime% : will be replaced by the current date-time in the format 'yyyymmddhhmmss'<br/>
/// - %date% : will be replaced by the current date in the format 'yyyymmdd'<br/>
/// - %year% : will be replaced by the 4-digit year of the current date in the format 'yyyy'<br/>
/// - %month% : will be replaced by the 2-digit month of the current date in the format 'mm'<br/>
/// - %day% : will be replaced by the 2-digit day of the current date in the format 'dd'<br/>
/// - %time% : will be replaced by the current time in the format 'hhmmss'<br/>
/// - %hour% : will be replaced by the 2-digit hour of the current time in the format 'hh'<br/>
/// - %minute% : will be replaced by the 2-digit minute of the current time in the format 'mm'<br/>
/// - %second% : will be replaced by the 2-digit second of the current time in the format 'ss'<br/>
/// - %cpt01% : will be replaced by a 1-digit numeric transaction number starting at 1 and wrapping at 9<br/>
/// - %cpt02% : will be replaced by a 2-digit numeric transaction number starting at 01 and wrapping at 99<br/>
/// - %cpt03% : will be replaced by a 3-digit numeric transaction number starting at 001 and wrapping at 999<br/>
/// - %cpt04% : will be replaced by a 4-digit numeric transaction number starting at 0001 and wrapping at 9999<br/>
/// - %cpt05% : will be replaced by a 5-digit numeric transaction number starting at 00001 and wrapping at 99999<br/>
/// - %cpt06% : will be replaced by a 6-digit numeric transaction number starting at 000001 and wrapping at 999999<br/>
/// - %cpt07% : will be replaced by a 7-digit numeric transaction number starting at 0000001 and wrapping at 9999999<br/>
/// - %cpt08% : will be replaced by a 8-digit numeric transaction number starting at 00000001 and wrapping at 99999999<br/>
/// - %cpt09% : will be replaced by a 9-digit numeric transaction number starting at 000000001 and wrapping at 999999999<br/>
Property FileNameFormat As %String [ InitialExpression = "%datetime%_%cpt04%.txt" ];

/// Send file ok 'filename'.ok when process is finished
Property SendFileOk As %Boolean [ InitialExpression = 0 ];

/// Si SendFileOk est coché, indique le format du fichier .ok<BR/><BR/>
/// Si le format choisi est NomFichier.ok, alors le fichier Test.xml sera associé au fichier Test.ok<BR/>
/// Si le format choisi est NomFichier.ext.ok, alors le fichier Test.xml sera associé au fichier Test.xml.ok<BR/><BR/>
/// Le défaut est NomFichier.ok
Property FormatFileOk As %String(DISPLAYLIST = ",NomFichier.ok,NomFichier.ext.ok", VALUELIST = ",FILE_OK,FILE_EXT_OK") [ InitialExpression = "FILE_OK" ];

/// Execute a pre-script before processing message (using same process). <br/>
/// Put into this field a ClassMethod to call, for example : <i>##class(myClass).myClassMethod</i> <br/>
/// The signature of the ClassMethod must have 3 parameters and must return a <i>%Status</i> value, for example : <br/>
/// <i>ClassMethod myClassMethod(pCaller As Ens.BusinessOperation, pRequest As EnsLib.HL7.Message, Output pResponse As Ens.Response) As %Status;</i>
Property PreScript As %String(MAXLEN = "");

/// Execute a post-script after processing message (using same process). <br/>
/// Put into this field a ClassMethod to call, for example : <i>##class(myClass).myClassMethod</i> <br/>
/// The signature of the ClassMethod must have 3 parameters and must return a <i>%Status</i> value, for example : <br/>
/// <i>ClassMethod myClassMethod(pCaller As Ens.BusinessOperation, pRequest As EnsLib.HL7.Message, Output pResponse As Ens.Response) As %Status;</i>
Property PostScript As %String(MAXLEN = "");

/// Number of days to keep messages stored into database. <br/>
/// Each messages status are separated by a comma : <i>'msg completed', 'msg error', 'msg aborted', 'msg suspended', 'msg discarded'</i>. <br/>
/// If this parameter is empty (or equal to 0), messages are never removed from database. <br/>
/// Note : messages are automatically deleted by the scheduled task <i>ISSAS.Common.SysTask.PurgeMsg</i>. <br/>
/// Examples : <br/>
/// * <i>60, 120</i> => delete completed messages after 60 days, and error messages after 120 days. <br/>
/// * <i>30, 0, 180</i> => delete completed messages after 30 days, and aborted messages after 180 days. <br/>
/// * <i>120</i> => delete completed messages after 120 days.
Property DaysToKeepMessages As %String;

/// Store a set of searchable properties associated with each HL7 message processed. <br/>
/// These records will be stored in the named SearchTable class, if any.
Property SearchTableClass As %String(MAXLEN = 128);

/// Log warnings in journal when an error occurred storing message searchable properties in SearchTable class.
Property EnableSearchTableWarning As %Boolean [ InitialExpression = 1 ];

/// How long to keep retrying before giving up and returning an error code. <br/>
/// -1 means never give up.
Property FailureTimeout As %Numeric(MINVAL = -1) [ InitialExpression = -1 ];

/// How frequently to retry access to the output system
Property RetryInterval As %Numeric(MINVAL = 0) [ InitialExpression = 10 ];

/// Comma-separated list of codes specifying what action this Operation will take on various reply status conditions. <br/>
/// The format of the list is: <br/>
/// &lt;code&gt;=&lt;actions&gt;,(&lt;code&gt;,&lt;code&gt;)=&lt;actions&gt;,... <br/>
/// Types of reply status condition are identified by a specification code: <br/>
/// <br/>
/// E - Error status returned from message handler <br/>
/// E#<statuscode> - Error status returned from message handler has status code equal to <statuscode> <br/>
/// E*<text> - Error status returned from message handler contains text string <text> <br/>
/// X - there is no reply message at all <br/>
/// <br/>
/// The following values for <action> may be used alone or in combinations: <br/>
/// <br/>
/// C - Treat the message as Completed OK. <br/>
/// W - Log a warning but treat the message as Completed OK. <br/>
/// R - Retry the message according to the configured RetryInterval and FailureTimeout; finally Fail unless a different action is also specified <br/>
/// S - Suspend the message, log an error, and move on to try the next message <br/>
/// D - Disable the Operation, log an error and restore the outbound message to the front of the Operation's queue <br/>
/// F - Fail with an error and move on to try the next message <br/>
/// <br/>
/// For example:'E#6301=R,E#<Ens>ErrGeneral=R,E=F' The default behavior is 'E=F' <br/>
/// <br/>
/// All codes where the <actions> consists of only 'W' (for 'log a Warning') will be evaluated and warnings generated if they trigger. <br/>
/// Other codes will be evaluated in left-to-right order, executing the first one that triggers that has a non-warning <actions> value.	
Property ReplyCodeActions As %String(MAXLEN = 100) [ InitialExpression = "E=R" ];

Property LineTerminator As %String;

Parameter ADAPTER = "ISSAS.Common.Adapter.HL7.File.OutboundAdapter";

Property Adapter As ISSAS.Common.Adapter.HL7.File.OutboundAdapter;

Parameter INVOCATION = "Queue";

Parameter SETTINGS = "MSHSendingApp, MSHSendingFacility, MSHReceivingApp, MSHReceivingFacility, MSHProcessingId, MSHVersionId, MSHAddMSH, FileNameFormat:Basic, SendFileOk, FormatFileOk, PreScript, PostScript, DaysToKeepMessages, SearchTableClass::selector?context={Ens.ContextSearch/SearchTableClasses?host=EnsLib.HL7.Service.Standard}, EnableSearchTableWarning, LineTerminator";

Method OnProcessHL7(pRequest As EnsLib.HL7.Message, Output pResponse As Ens.Response) As %Status
{
	#Dim tSC As %Status = $$$OK
	#Dim clsFormat As ISSAS.Common.Tools.ClassFormat = ""
	#Dim pClone As EnsLib.HL7.Message = ""

	Try
	{
		// Check if adapter is ok before processing message
		Set tSC = ..Adapter.OnBeforeProcessExecute()
		If ($$$ISERR(tSC)) { Quit }

		// Build a clone request
		Set pClone = pRequest.%ConstructClone(1)
		Set tSC = pClone.%Save()  If ($$$ISERR(tSC)) { Quit }

		// Execute pre-script before processing message
		If ($L(..PreScript) > 0)
		{
			Set tSC = ##class(ISSAS.Common.Tools.ClassScript).ExecuteClassMethod(..PreScript, ##this, pClone, .pResponse)
			If ($$$ISERR(tSC)) { Quit }
		}

		// Verify that the file path is not empty
		If (' $L(..Adapter.FilePath))
		{ Set tSC = $$$ERROR($$$GeneralError, "File path parameter must not be empty : file cannot be created")  Quit }

		// Build a new file name
		Set fileName = ##class(ISSAS.Common.Tools.ClassFormat).BuildString(..%ConfigName, ..FileNameFormat, .clsFormat)

		// Initialize HL7 segment header
		If (..MSHAddMSH)
		{
			If (..MSHSendingApp '= "") { Set tSC = pClone.SetValueAt(..MSHSendingApp, "MSH:3")  If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) } }
			If (..MSHSendingFacility '= "") { Set tSC = pClone.SetValueAt(..MSHSendingFacility, "MSH:4")  If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) } }
			Set tSC = pClone.SetValueAt(..MSHReceivingApp, "MSH:5")  If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }
			Set tSC = pClone.SetValueAt(..MSHReceivingFacility, "MSH:6")  If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }
			Set tSC = pClone.SetValueAt(..MSHProcessingId, "MSH:11")  If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }
			Set tSC = pClone.SetValueAt(..MSHVersionId, "MSH:12")  If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }
		}

		// Need to copy some informations from MSH segment to H segment for "HPRIMV2:ADT" message
		If (pClone.DocType = "HPRIMV2:ADT")
		{
			Set tSC = pClone.SetValueAt(..MSHReceivingApp, "H:9.1")  If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }
			Set tSC = pClone.SetValueAt(..MSHReceivingFacility, "H:9.2")  If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }
			Set tSC = pClone.SetValueAt(..MSHProcessingId, "H:11")  If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }
			Set tSC = pClone.SetValueAt(..MSHVersionId, "H:12")  If ($$$ISERR(tSC)) { $$$LOGWARNING(tSC) }
		}

		// Write or not MSH segment to output
		Set firstSegment = 1
		If (' ..MSHAddMSH) { Set firstSegment = 2 }
		
		// CCOMTCC-901 : custom line terminator
		If (..LineTerminator '= "") {
			Set ..Adapter.LineTerminator = $Select(..LineTerminator="CR":$char(13), ..LineTerminator="LF":$char(10), ..LineTerminator="CR/LF":$char(13,10), 1:$char(13))
		}
		
		// Iterate over all segments into HL7 message
		For I=firstSegment:1:pClone.SegCount
		{
			Set line = pClone.GetValueAt(I)
			Set tSC = ..Adapter.PutLine(fileName, line)
			If ($$$ISERR(tSC)) { $$$LOGERROR(tSC)  Quit }
			Do pClone.commitSegmentByIndex(I)
		}

		// If an error occured, stop process
		If ($$$ISERR(tSC)) { Quit }

		// Send file ok : <filename>.ok
		If (..SendFileOk && $$$ISOK(tSC))
		{
			if ..FormatFileOk = "FILE_EXT_OK"
			{
				// On ne fait rien
			}
			else
			{
				// Remove extension
				Set position = $FIND($REVERSE(fileName), ".")
				If (position > 0) { Set fileName = $E(fileName, 1, ($L(fileName) - position + 1)) }
			}

			// Send file ok : <filename>.ok
			Set fileName = fileName_".ok"
			Set tSC = ..Adapter.PutLine(fileName, "ok")
			If ($$$ISERR(tSC)) { Quit }
		}

		// Execute post-script after processing message
		If ($L(..PostScript) > 0)
		{
			Set tSC = ##class(ISSAS.Common.Tools.ClassScript).ExecuteClassMethod(..PostScript, ##this, pClone, .pResponse)
			If ($$$ISERR(tSC)) { Quit }
		}

		// Build index for search table
		Do ##class(ISSAS.Common.SearchTable.BaseClass).IndexDocHelper(..SearchTableClass, pClone, ..EnableSearchTableWarning)
	}
	Catch(exc)
	{ Set tSC = $System.Status.AppendStatus(tSC, exc.AsStatus()) }

	// JIRA CCOMTCC-17 : réinitialise le compteur en cas d'erreur
	If (($$$ISERR(tSC)) && (clsFormat '= ""))
	{ Do clsFormat.RestoreOldTransactionCount() }

	Quit tSC
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="EnsLib.HL7.Message">
		<Method>OnProcessHL7</Method>
	</MapItem>
</MapItems>
}

}
