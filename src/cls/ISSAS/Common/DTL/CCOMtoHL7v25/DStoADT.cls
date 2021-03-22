Class ISSAS.Common.DTL.CCOMtoHL7v25.DStoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v25/DStoADT.xml#11 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:DS" targetClass="EnsLib.HL7.Message" targetDocType="HL7v25IHE:ADT_AXX" create="new" language="objectscript" >
<code>
<![CDATA[ Set strAssigningAuthority = $G(^ISSAS.Config("DTL", "AssigningAuthority", "2.5"))
 If (' $L(strAssigningAuthority)) { Set strAssigningAuthority = "CLINICOM" }
 Set target.Separators = "|^~\&"
 Set strNow = $ZDATE($PIECE($HOROLOG,",",1),8)_$E($TR($ZTIME($PIECE($HOROLOG,",",2)),":",""),1,6)_"."_$PIECE($ZTS,".",2)
 Set strGUID = ##class(%SYSTEM.Util).CreateGUID()
 Set strGUID = $REPLACE(strGUID, "{", "")
 Set strGUID = $REPLACE(strGUID, "}", "")
 Set strGUID = $REPLACE(strGUID, "-", "")
 Set strGUID = $REPLACE(strGUID, "|", "")
 Set strGUID = $EXTRACT(strGUID, 1, 16) ]]>
</code>

<!-- segment MSH -->
<assign value="$ZCVT(source.{MSH:MSH03SendingApplication},&quot;U&quot;)" property="target.{MSH:SendingApplication}" key="&quot;&quot;" action="set" />
<assign value="$ZCVT(source.{MSH:MSH04SendingFacility},&quot;U&quot;)" property="target.{MSH:SendingFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MSH:DateTimeOfMessage}" key="&quot;&quot;" action="set" />
<assign value="&quot;ADT&quot;" property="target.{MSH:MessageType.MessageCode}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","DS"_source.GetValueAt("DS:DS01Mode")),"MSH:MessageType.TriggerEvent","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","DS"_source.GetValueAt("DS:DS01Mode")),"MSH:MessageType.MessageStructure","set","")]]>
</code>
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value='"2.5"' property="target.{MSH:VersionID}" key="&quot;&quot;" action="set" />
<assign value="&quot;FRA&quot;" property="target.{MSH:CountryCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<assign value="&quot;FR&quot;" property="target.{MSH:PrincipalLanguageOfMessage}" key="&quot;&quot;" action="set" />

<!-- segment EVN -->
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","DS"_source.GetValueAt("DS:DS01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS07DateHeureSortie}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS28Utilisateur.Username}" property="target.{EVN:OperatorID.IDNumber}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS05IPP}" property="target.{PID:PatientIdentifierList(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : on envoie toujours nom de naissance en L et nom usuel en D pour être conforme IHE PAM -->
<assign value="source.{DS:DS19NomUsuel.Nom}" property="target.{PID:PatientName(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS20Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value='"D"' property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS22NomDeNaissance.Nom}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS20Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
<assign value='"L"' property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : par précaution, dans le cas improbable où le nom de naissance serait vide, on envoie le nom usuel en L aussi -->
<if condition="$L(source.{DS:DS22NomDeNaissance.Nom})">
<false>
<assign value="source.{DS:DS19NomUsuel.Nom}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{DS:DS24DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{DS:DS23Sexe})" property="target.{PID:AdministrativeSex}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS06NumeroEpisode}" property="target.{PID:PatientAccountNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<if condition="##class(ISSAS.Common.Tools.ClassODBC).IsDeceased(source.{DS:DS05IPP})=1">
<true>
<assign value="&quot;Y&quot;" property="target.{PID:PatientDeathIndicator}" key="&quot;&quot;" action="set" />
<assign value="##class(ISSAS.Common.Tools.ClassODBC).DeceaseDate(source.{DS:DS05IPP})" property="target.{PID:PatientDeathDateandTime.Time}" key="&quot;&quot;" action="set" />
<assign value="&quot;D&quot;" property="target.{PID:PatientDeathDateandTime.DegreeofPrecision}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;N&quot;" property="target.{PID:PatientDeathIndicator}" key="&quot;&quot;" action="set" />
</false>
</if>

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<if condition='source.{DS:DS26IndicateurEpisodeRecurre} = "1"'>
<true>
<assign value="&quot;R&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;I&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{DS:DS06NumeroEpisode}" property="target.{PV1:VisitNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS14CodeUS}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS21Chambre}" property="target.{PV1:AssignedPatientLocation.room}" key="&quot;&quot;" action="set" />
<assign value='source.{DS:DS02Hopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.Facility}' action='set' />
<assign value="source.{DS:DS10ModeSortie}" property="target.{PV1:DischargeDisposition}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS25MedecinResponsable.CodeClinicom}" property="target.{PV1:AttendingDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS25MedecinResponsable.Nom}" property="target.{PV1:AttendingDoctor(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS25MedecinResponsable.Prenom}" property="target.{PV1:AttendingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS25MedecinResponsable.Qualite}" property="target.{PV1:AttendingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS25MedecinResponsable.Titre}" property="target.{PV1:AttendingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:AttendingDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassDate).CvtFRToCCOM(##class(ISSAS.Common.Tools.ClassODBC).AdmDate(source.{DS:DS06NumeroEpisode}),2)' property="target.{PV1:AdmitDateTime}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS07DateHeureSortie}" property="target.{PV1:DischargeDateTime}" key="&quot;&quot;" action="set" />
<assign value='"D"' property="target.{PV1:AccountStatus}" key="&quot;&quot;" action="set" />

<!-- segment ZBE -->
<assign value="source.{DS:DS27IdentifiantUniqueDeMouve}" property="target.{ZBE:MovementID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{ZBE:MovementID.NamespaceID}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS07DateHeureSortie}" property="target.{ZBE:StartMovementDateTime}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MovementAction",source.GetValueAt("DS:DS01Mode")),"ZBE:MovementAction","set","")]]>
</code>
<if condition='source.{DS:DS01Mode} = "01"'>
<false>
<assign value="&quot;A03&quot;" property="target.{ZBE:Originaltriggereventcode}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="&quot;N&quot;" property="target.{ZBE:HistoricalMovementIndicator}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS13CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationName}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS13CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationIdentifier}" key="&quot;&quot;" action="set" />
<assign value='"HMS"' property="target.{ZBE:NatureMouvement}" key="&quot;&quot;" action="set" />

<!-- segment ZFM -->
<!-- requete vers CLINICOM : SELECT Mode_PMSI FROM ClinicomSQL.Sortie_Mode WHERE ID='?' -->
<assign value="##class(ISSAS.Common.Tools.ClassODBC).ClinicomSortieMode(source.{DS:DS10ModeSortie})" property="target.{ZFM:ModeSortiePMSI}" key="&quot;&quot;" action="set" />
<assign value="source.{DS:DS09EtablissementDestination.PropositionMTPMSI}" property="target.{ZFM:ModeDestinationPMSI}" key="&quot;&quot;" action="set" />

<!-- segment ZFV -->
<assign value="source.{DS:DS10ModeSortie}" property="target.{ZFV:Modesortiepersonnalise}" key="&quot;&quot;" action="set" />

<if condition="$L(source.{DS:DS09EtablissementDestination.CodeEtablissement})">
<true>
<!-- requete vers CLINICOM : SELECT TXT_DON_Finess FROM ClinicomSQL.FDB_NOY_EtablissementExterieur WHERE TXT_COD_EtablissementExterieur='?' -->
<!-- <assign value="##class(ISSAS.Common.Tools.ClassODBC).ClinicomEtablissementExterieur(source.{DS:DS09EtablissementDestination.CodeEtablissement})" property="target.{ZFV:Etbprovenance}" key="&quot;&quot;" action="set" />-->
<assign value="##class(ISSAS.Common.Tools.ClassODBC).ClinicomEtablissementExterieur(source.{DS:DS09EtablissementDestination.CodeEtablissement})" property="target.{PV1:DischargedtoLocation.DischargeLocation}" key="&quot;&quot;" action="set" />
</true>
</if>


</transform>
}

}
