Class ISSAS.Common.DTL.CCOMtoHL7v231.TRtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v231/TRtoADT.xml#5 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:TR" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
<code>
<![CDATA[ Set strAssigningAuthority = $G(^ISSAS.Config("DTL", "AssigningAuthority", "2.3.1"))
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

<!-- MSH -->
<assign value="$ZCVT(source.{MSH:MSH03SendingApplication},&quot;U&quot;)" property="target.{MSH:SendingApplication}" key="&quot;&quot;" action="set" />
<assign value="$ZCVT(source.{MSH:MSH04SendingFacility},&quot;U&quot;)" property="target.{MSH:SendingFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MSH:DateTimeOfMessage}" key="&quot;&quot;" action="set" />
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt("ADT^"_..Lookup("CCOM_HL7_MessageType_v231","TR"_source.GetValueAt("TR:TR01Mode")),"MSH:MessageType","set","")]]>
</code>

<!-- EVN -->
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v231","TR"_source.GetValueAt("TR:TR01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="source.{TR:TR07DateHeureMutation}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />

<!-- PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR05IPP}" property="target.{PID:PatientIdentifierList(1).ID}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR27NomUsuel.Nom}" property="target.{PID:PatientName(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR27NomUsuel.NameTypeCode}" property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR28Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{TR:TR29NomDeNaissance.Nom}) &amp;&amp; (source.{TR:TR27NomUsuel.Nom} '= source.{TR:TR29NomDeNaissance.Nom})">
<true>
<assign value="source.{TR:TR29NomDeNaissance.Nom}" property="target.{PID:PatientName(2).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR29NomDeNaissance.NameTypeCode}" property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR28Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{TR:TR31DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{TR:TR30Sexe})" property="target.{PID:Sex}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR06NumeroEpisode}" property="target.{PID:PatientAccountNumber.ID}" key="&quot;&quot;" action="set" />

<!-- PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value="&quot;I&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR34IdentifiantUniqueDeMouve}" property="target.{PV1:AlternateVisitID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR06NumeroEpisode}" property="target.{PV1:VisitNumber.ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value='source.{TR:TR02CodeHopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.FacilityHD}' action='set' />
<assign value="source.{TR:TR09CodeUS}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR10Chambre}" property="target.{PV1:AssignedPatientLocation.room}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR14Lit}" property="target.{PV1:AssignedPatientLocation.bed}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR15MedecinResponsable.CodeClinicom}" property="target.{PV1:AttendingDoctor(1).IDnumberST}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR15MedecinResponsable.Nom}" property="target.{PV1:AttendingDoctor(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR15MedecinResponsable.Prenom}" property="target.{PV1:AttendingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR15MedecinResponsable.Qualite}" property="target.{PV1:AttendingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR15MedecinResponsable.Titre}" property="target.{PV1:AttendingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR23CodeUSPrecedente}" property="target.{PV1:PriorPatientLocation.PointofCare}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR33ChambrePrecedente}" property="target.{PV1:PriorPatientLocation.Room}" key="&quot;&quot;" action="set" />

<!-- ZFU -->
<assign value="source.{TR:TR13CodeUF}" property="target.{ZFU:MedicalFunctionalUnit}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR07DateHeureMutation}" property="target.{ZFU:MedicalFunctionalUnitStartDa}" key="&quot;&quot;" action="set" />

<if condition='source.{TR:TR01Mode} = "03"'>
<true>
<assign value="source.{TR:TR21CodeUFPrecedente}" property="target.{ZFU:MedicalFunctionalUnit}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR23CodeUSPrecedente}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{TR:TR33ChambrePrecedente}" property="target.{PV1:AssignedPatientLocation.room}" key="&quot;&quot;" action="set" />
<assign value='""' property="target.{PV1:AssignedPatientLocation.bed}" key="&quot;&quot;" action="set" />
</true>
</if>

	
</transform>
}

}
