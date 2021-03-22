Include (Constantes, %sySite)

Class ISSAS.Common.DTL.Doctolib.TCSIUtoCCOMSIU Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.HL7.Message, ISSAS.Common.Message.ClinicomHL7) ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/MAIN/cls/ISSAS/Common/DTL/Doctolib/TCSIUtoCCOMSIU.xml#4 $";

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='ISSAS.Common.Message.ClinicomHL7' sourceDocType='TrakCare:SIU_S12' targetDocType='ClinicomReceiver:SIU' create='new' language='objectscript' >
<if condition='+##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "TraceTransformations", $$$FALSE)'>
<true>
<trace value='"Dans " _ $ClassName() _ ", MsgId=" _ source.%Id()'/>
<code>
<![CDATA[
	set strBuffer = "En entrée de " _ $$$CURRENTMETHOD _ $char(13, 10)
	For I=1:1:source.SegCount
	{ set strBuffer = strBuffer _ source.GetValueAt(I) _ $char(13, 10) }
	$$$TRACE(strBuffer)
]]>
</code>
</true>
</if>

<assign value='##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "RessourceSeparator", "-")' property='RessourceSeparator' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "FormatRessources", "UF_RESSOURCE")' property='FormatRessources' action='set' />
<assign value='source.{RGSgrp(1).AILgrp(1).AIL:LocationResourceID(1).PointofCare}' property='PointofCare' action='set' />

<if condition='FormatRessources = "UF_US_RESSOURCE"'>
<true>
<assign value='$PIECE(PointofCare, RessourceSeparator, 1)' property='UF' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 2)' property='UC' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 3)' property='Ressource' action='set' />
<assign value='""' property='CodeAgenda01' action='set' />
</true>
</if>
<if condition='FormatRessources = "UF_RESSOURCE"'>
<true>
<assign value='""' property='UF' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 1)' property='UC' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 2)' property='Ressource' action='set' />
<assign value='""' property='CodeAgenda01' action='set' />
</true>
</if>
<if condition='(FormatRessources = "UF_US_RESSOURCE_OTHERAGD") || (FormatRessources = "UF_US_RESSOURCE_OTHERAGD_SCH_AIG")'>
<true>
<assign value='$PIECE(PointofCare, RessourceSeparator, 1)' property='UF' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 2)' property='UC' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 3)' property='Ressource' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 4)' property='CodeAgenda01' action='set' />
</true>
</if>

<!-- entête -->
<assign value='source.{MSH}' property='target.{MSH}' action='set' />
<assign value='"SIU"' property='target.{MSH:MSH09MessageType}' action='set' />

<!-- segment SIU : code action -->
<if condition='source.{MSH:MessageType.triggerevent}="S12"'>
<true>
<assign value='"01"' property='target.{SIU:SIU01CodeAction}' action='set' />
</true>
</if>
<if condition='",S13,S14," [ ("," _ source.{MSH:MessageType.triggerevent} _ ",")'>
<true>
<assign value='"02"' property='target.{SIU:SIU01CodeAction}' action='set' />
</true>
</if>
<if condition='",S15,S17," [ ("," _ source.{MSH:MessageType.triggerevent} _ ",")'>
<true>
<assign value='"03"' property='target.{SIU:SIU01CodeAction}' action='set' />
</true>
</if>

<!-- segment SIU : other fields -->
<assign value='"Docotlib"' property='target.{SIU:SIU02IdentifiantModuleProduc}' action='set' />
<assign value='$REPLACE(source.{SCH:FillerAppointmentID}, "\", ".")' property='target.{SIU:SIU03IdentifiantUniqueRDV}' action='set' />
<assign value='"P"' property='target.{SIU:SIU04TypeEntiteAttendue}' action='set' />
<if condition='",2.5:SIU_S12,2.5.1:SIU_S12," [ ("," _ source.DocType _ ",")' >
<true>
<assign value='source.{PIDgrp(1).PID:PatientIdentifierList(1).IDNumber}' property='target.{SIU:SIU05IPP}' action='set' />
</true>
<false>
<assign value='source.{PIDgrp(1).PID:PatientIdentifierList(1).ID}' property='target.{SIU:SIU05IPP}' action='set' />
</false>
</if>
<assign value='source.{SCH:AppointmentTimingQuantity(1).startdatetime}' property='DateHeureDebutRDV' action='set' />
<code>
<![CDATA[
	// On vérifie que l'heure de début n'est pas 0000
	IF $EXTRACT(DateHeureDebutRDV, 9, 12) = "0000"
	{
		SET $EXTRACT(DateHeureDebutRDV, 12, 12) = "1" // => 0001
	}
]]>
</code>
<assign value='$EXTRACT(DateHeureDebutRDV, 1, 12)' property='target.{SIU:SIU07DateHeureDebutRDV}' action='set' />
<assign value='source.{SCH:AppointmentTimingQuantity(1).AppointmentDuration}' property='DureeRDV' action='set' />

<code>
<![CDATA[
	SET DateODBC = $ZDATEH($EXTRACT(DateHeureDebutRDV, 1, 8), 8) _ "," _ $ZTIMEH($EXTRACT(DateHeureDebutRDV, 9, 10) _ ":" _ $EXTRACT(DateHeureDebutRDV, 11, 12) _ ":00", 1)
	SET DateODBC = $ZDATETIME(DateODBC, 3, 1) // Conversion en ODBC
	SET DateODBC = $ZDATETIMEH($SYSTEM.SQL.DATEADD("mi", 15, DateODBC), 3, 1)
	SET DateHeureFinRDV = $ZDATETIME(DateODBC, 3, 2) // Conversion en YYYMMDDHHmm
	SET DateHeureFinRDV = $TRANSLATE(DateHeureFinRDV, "-: ", "")
]]>
</code>
<assign value='DateHeureFinRDV' property='target.{SIU:SIU08DateHeureFinRDV}' action='set' />

<!-- *****************  -->
<assign property="TCSIUtoCCOMSIURessourcesLut" value='##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "TCSIUtoCCOMSIURessourcesLut", "")' action="set" />
<if condition='TCSIUtoCCOMSIURessourcesLut = ""' >
<true>
<assign property="tSC1" value='$$$ERROR($$$GeneralError, "Le nom du LUT n&apos;est pas renseignée dans " _ $CLASSNAME())' action="set"/>
</true>
<false>

<!-- code agenda -->
<trace value='"Ressource Doctolib=" _ Ressource'/>
<assign value='..Lookup(TCSIUtoCCOMSIURessourcesLut, Ressource)' property='CodeRessource' action='set' />
<if condition='CodeRessource = ""'>
<true>
<assign property="Erreur" value='"La valeur dans " _ TCSIUtoCCOMSIURessourcesLut _ ".LUT n&apos;est pas renseignée pour la ressource """ _ Ressource _ """ dans " _ $CLASSNAME() _ " -1-"' action="set"/>
<assign property="(tSC, tSCTrans)" value='$$$ERROR($$$GeneralError, Erreur)' action="set"/>
<assign property="TargetEMails" value='##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "TargetEMails", "")' action="set" />
<if condition='TargetEMails &apos;= ""'>
<true>
<assign property="Erreur" value='$$$FormatText("%1 (SessionId=%2)", Erreur, %Ensemble("%Process").%SessionId)' action="set"/>
<assign property="bidon" value='##class(ISSAS.Common.Tools.ClassTools).SendMail("Valeur Ressource absente dans " _ TCSIUtoCCOMSIURessourcesLut, TargetEMails, Erreur)' action="set"/>
</true>
</if>
<assign property="bidon" value='##class(%Monitor.Alert).External("SNMP", $EXTRACT("BPLDoctolib " _ $CLASSNAME(), 20), 3, Erreur)' action="set"/>
<if condition="$$$ISWINDOWS">
<true>
<assign property="bidon" value='##class(%Monitor.Alert).External("WMI", $EXTRACT("BPLDoctolib " _ $CLASSNAME(), 20), 3, Erreur)' action="set"/>
</true>
</if>
</true>
<false>
<trace value='"Code Ressource Clinicom=" _ CodeRessource'/>
<assign value='CodeRessource' property='target.{SIU:SIU12CodeRessource}' action='set' />
</false>
</if>
</false>
</if>
<!-- *****************  -->

<assign value='source.{RGSgrp(1).AISgrp(1).AIS:UniversalServiceIdentifier.identifierST}' property='target.{SIU:SIU10PrestationAgenda}' action='set' />
<assign value='"0"' property='target.{SIU:SIU11TypeRessource}' action='set' />
<if condition='",2.5:SIU_S12,2.5.1:SIU_S12," [ ("," _ source.DocType _ ",")' >
<true>
<assign value='source.{SCH:EnteredByPerson(1).IDnumber}' property='target.{SIU:SIU16CodeUtilisateur}' action='set' />
</true>
<false>
<assign value='source.{SCH:EnteredByPerson(1).IDnumberST}' property='target.{SIU:SIU16CodeUtilisateur}' action='set' />
</false>
</if>

<!-- segment SIU : RDV status -->
<assign value='..Lookup("Doctolib_CCOM_StatutRDV",source.{SCH:FillerStatusCode.Identifier})' property='target.{SIU:SIU09StatutRDV}' action='set' />

<!-- segment SIU : comment -->
<assign value='source.{NTE(1):Comment(1)}' property='Commentaire' action='set' />
<assign value='$REPLACE(Commentaire, "\.br\", "-")' property='Commentaire' action='set' />
<assign value='$REPLACE(Commentaire, "\X000d\.", "-")' property='Commentaire' action='set' />
<assign value='Commentaire' property='target.{SIU:SIU14Commentaire}' action='set' />
<if condition='",2.5:SIU_S12,2.5.1:SIU_S12," [ ("," _ source.DocType _ ",")' >
<true>
<assign value='source.{SCH:EventReason.Identifier}' property='target.{SIU:SIU10PrestationAgenda}' action='set' />
</true>
<false>
<assign value='source.{SCH:EventReason.identifierST}' property='target.{SIU:SIU10PrestationAgenda}' action='set' />
</false>
</if>

<assign property="TCSIUtoCCOMSIULut" value='##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "TCSIUtoCCOMSIULut", "")' action="set" />
<if condition='TCSIUtoCCOMSIULut = ""' >
<true>
<assign property="tSC1" value='$$$ERROR($$$GeneralError, "Le nom du LUT n&apos;est pas renseignée dans " _ $CLASSNAME())' action="set"/>
</true>
<false>
<!-- code agenda -->
<trace value='"Ressource Doctolib=" _ Ressource'/>
<assign value='..Lookup(TCSIUtoCCOMSIULut, Ressource)' property='CodeAgenda' action='set' />
<if condition='CodeAgenda = ""'>
<true>
<assign property="Erreur" value='"La valeur dans " _ TCSIUtoCCOMSIULut _ ".LUT n&apos;est pas renseignée pour la ressource """ _ Ressource _ """ dans " _ $CLASSNAME() _ " -2-"' action="set"/>
<assign property="(tSC, tSCTrans)" value='$$$ERROR($$$GeneralError, Erreur)' action="set"/>
<assign property="TargetEMails" value='##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "TargetEMails", "")' action="set" />
<if condition='TargetEMails &apos;= ""'>
<true>
<assign property="Erreur" value='$$$FormatText("%1 (SessionId=%2)", Erreur, %Ensemble("%Process").%SessionId)' action="set"/>
<assign property="bidon" value='##class(ISSAS.Common.Tools.ClassTools).SendMail("Valeur Ressource absente dans " _ TCSIUtoCCOMSIULut, TargetEMails, Erreur)' action="set"/>
</true>
</if>
<assign property="bidon" value='##class(%Monitor.Alert).External("SNMP", $EXTRACT("BPLDoctolib " _ $CLASSNAME(), 20), 3, Erreur)' action="set"/>
<if condition="$$$ISWINDOWS">
<true>
<assign property="bidon" value='##class(%Monitor.Alert).External("WMI", $EXTRACT("BPLDoctolib " _ $CLASSNAME(), 20), 3, Erreur)' action="set"/>
</true>
</if>
</true>
<false>
<trace value='"Code Agenda Clinicom=" _ CodeAgenda'/>
<assign value='CodeAgenda' property='target.{SIU:SIU06CodeAgenda}' action='set' />
</false>
</if>
</false>
</if>
<if condition='+##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "TraceTransformations", $$$FALSE)'>
<true>
<code>
<![CDATA[
	set strBuffer = "En sortie de " _ $$$CURRENTMETHOD _ $char(13, 10)
	For I=1:1:target.SegCount
	{ set strBuffer = strBuffer _ target.GetValueAt(I) _ $char(13, 10) }
	$$$TRACE(strBuffer)
]]>
</code>
</true>
</if>

</transform>
}

}
