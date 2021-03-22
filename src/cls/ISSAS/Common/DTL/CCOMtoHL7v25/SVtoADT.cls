Class ISSAS.Common.DTL.CCOMtoHL7v25.SVtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v25/SVtoADT.xml#10 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:TR" targetClass="EnsLib.HL7.Message" targetDocType="HL7v25IHE:ADT_AXX" create="new" language="objectscript" >
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
<if condition='source.{TR:TR01Mode} = "01" '>
<true>
<assign value="&quot;A03&quot;" property="target.{MSH:MessageType.TriggerEvent}" key="&quot;&quot;" action="set" />
<assign value="&quot;ADT_A03&quot;" property="target.{MSH:MessageType.MessageStructure}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{TR:TR01Mode} = "02" '>
<true>
<assign value="&quot;Z99&quot;" property="target.{MSH:MessageType.TriggerEvent}" key="&quot;&quot;" action="set" />
<assign value="&quot;ADT_A01&quot;" property="target.{MSH:MessageType.MessageStructure}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{TR:TR01Mode} = "03" '>
<true>
<assign value="&quot;A13&quot;" property="target.{MSH:MessageType.TriggerEvent}" key="&quot;&quot;" action="set" />
<assign value="&quot;ADT_A01&quot;" property="target.{MSH:MessageType.MessageStructure}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value='"2.5"' property="target.{MSH:VersionID}" key="&quot;&quot;" action="set" />
<assign value="&quot;FRA&quot;" property="target.{MSH:CountryCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<assign value="&quot;FR&quot;" property="target.{MSH:PrincipalLanguageOfMessage}" key="&quot;&quot;" action="set" />

<!-- segment EVN -->
<if condition='source.{TR:TR01Mode} = "01" '>
<true>
<assign value="&quot;A03&quot;" property="target.{EVN:EventTypeCode}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{TR:TR01Mode} = "02" '>
<true>
<assign value="&quot;Z99&quot;" property="target.{EVN:EventTypeCode}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{TR:TR01Mode} = "03" '>
<true>
<assign value="&quot;A13&quot;" property="target.{EVN:EventTypeCode}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR07DateHeureMutation}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR05IPP}" property="target.{PID:PatientIdentifierList(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : on envoie toujours nom de naissance en L et nom usuel en D pour être conforme IHE PAM -->
<assign value="source.{TR:TR27NomUsuel.Nom}" property="target.{PID:PatientName(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR28Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value='"D"' property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR29NomDeNaissance.Nom}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR28Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
<assign value='"L"' property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : par précaution, dans le cas improbable où le nom de naissance serait vide, on envoie le nom usuel en L aussi -->
<if condition="$L(source.{TR:TR29NomDeNaissance.Nom})">
<false>
<assign value="source.{TR:TR27NomUsuel.Nom}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{TR:TR31DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{TR:TR30Sexe})" property="target.{PID:AdministrativeSex}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR06NumeroEpisode}" property="target.{PID:PatientAccountNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value="&quot;R&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
<assign value="&quot;R&quot;" property="target.{PV1:AdmissionType}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR06NumeroEpisode}" property="target.{PV1:VisitNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value='source.{TR:TR02CodeHopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.Facility}' action='set' />
<assign value="source.{TR:TR09CodeUS}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR10Chambre}" property="target.{PV1:AssignedPatientLocation.room}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR14Lit}" property="target.{PV1:AssignedPatientLocation.bed}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR15MedecinResponsable.CodeClinicom}" property="target.{PV1:AttendingDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR15MedecinResponsable.Nom}" property="target.{PV1:AttendingDoctor(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR15MedecinResponsable.Prenom}" property="target.{PV1:AttendingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR15MedecinResponsable.Qualite}" property="target.{PV1:AttendingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR15MedecinResponsable.Titre}" property="target.{PV1:AttendingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:AttendingDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR07DateHeureMutation}" property="target.{PV1:DischargeDateTime}" key="&quot;&quot;" action="set" />
<assign value='"V"' property="target.{PV1:VisitIndicator}" key="&quot;&quot;" action="set" />
<assign value='"N"' property="target.{PV1:AccountStatus}" key="&quot;&quot;" action="set" />

<!-- Attention : IHE PAM préconise Y / N , mais certains éditeurs attendent 0, 1 ou 2 --> 
<assign value="source.{TR:TR12SupplementChambre}" property="target.{PV1:CourtesyCode}" key="&quot;&quot;" action="set" />


<!-- segment ZBE -->
<assign value="source.{TR:TR34IdentifiantUniqueDeMouve}" property="target.{ZBE:MovementID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{ZBE:MovementID.NamespaceID}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR07DateHeureMutation}" property="target.{ZBE:StartMovementDateTime}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MovementAction",source.GetValueAt("TR:TR01Mode")),"ZBE:MovementAction","set","")]]>
</code>
<!-- pour modif (02) et annulation (03) renseigner le code évènement modifié ou annulé (A03) -->
<if condition='(source.{TR:TR01Mode} = "02")||(source.{TR:TR01Mode} = "03") '>
<true>
<assign value="&quot;A03&quot;" property="target.{ZBE:Originaltriggereventcode}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{TR:TR26IndicateurDernierMouveme} = "1"'>
<true>
<assign value="&quot;N&quot;" property="target.{ZBE:HistoricalMovementIndicator}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;Y&quot;" property="target.{ZBE:HistoricalMovementIndicator}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{TR:TR13CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationName}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR13CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationIdentifier}" key="&quot;&quot;" action="set" />
<assign value='"HMS"' property="target.{ZBE:NatureMouvement}" key="&quot;&quot;" action="set" />

<!-- Annulation de mutation : UF et US de CCOM sont celles annulées -->
<!-- HL/7 attend celles courantes, qui sont les précédentes pour CCOM -->
<if condition='source.{TR:TR01Mode} = "03"'>
<true>
<assign value="source.{TR:TR21CodeUFPrecedente}" property="target.{ZBE:ResponsibleWard.OrganizationName}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR21CodeUFPrecedente}" property="target.{ZBE:ResponsibleWard.OrganizationIdentifier}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR23CodeUSPrecedente}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR33ChambrePrecedente}" property="target.{PV1:AssignedPatientLocation.room}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- segment ZFM -->

</transform>
}

}
