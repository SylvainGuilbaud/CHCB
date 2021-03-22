Class ISSAS.Common.DTL.CCOMtoHL7v231.NRtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v231/NRtoADT.xml#6 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:NR" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
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

<!-- segment MSH -->
<assign value="$ZCVT(source.{MSH:MSH03SendingApplication},&quot;U&quot;)" property="target.{MSH:SendingApplication}" key="&quot;&quot;" action="set" />
<assign value="$ZCVT(source.{MSH:MSH04SendingFacility},&quot;U&quot;)" property="target.{MSH:SendingFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MSH:DateTimeOfMessage}" key="&quot;&quot;" action="set" />
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt("ADT^"_..Lookup("CCOM_HL7_MessageType_v231","NR"_source.GetValueAt("NR:NR01Mode")),"MSH:MessageType","set","")]]>
</code>

<!-- segment EVN -->
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v231","NR"_source.GetValueAt("NR:NR01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="source.{NR4:NR411DateHeureAdmission}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR306Utilisateur.Username}" property="target.{EVN:OperatorID(1).IDNumberST}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR03IPP}" property="target.{PID:PatientIdentifierList(1).ID}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR04NomUsuel.Nom}" property="target.{PID:PatientName(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR04NomUsuel.NameTypeCode}" property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR05Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR06AutresPrenoms}" property="target.{PID:PatientName(1).middleinitialorname}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR07Qualite}" property="target.{PID:PatientName(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR10DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{NR:NR11Sexe})" property="target.{PID:Sex}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR12NoRueAdresse}" property="target.{PID:PatientAddress(1).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR13CodePostalAdresse}" property="target.{PID:PatientAddress(1).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{NR2:NR201LocaliteAdresse}" property="target.{PID:PatientAddress(1).city}" key="&quot;&quot;" action="set" />
<assign value="source.{NR2:NR206ComplementAdresse}" property="target.{PID:PatientAddress(1).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{NR2:NR202PaysAdresse}" property="target.{PID:PatientAddress(1).country}" key="&quot;&quot;" action="set" />
<assign value="source.{NR2:NR203Telephone}" property="target.{PID:PhoneNumberHome(1).phonenumber1}" key="&quot;&quot;" action="set" />
<assign value="source.{NR2:NR204Nationalite}" property="target.{PID:Nationality}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR303NumeroEpisode}" property="target.{PID:PatientAccountNumber.ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{NR4:NR415IPPMere}" property="target.{PID:MothersIdentifier}" key="&quot;&quot;" action="set" />

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value="&quot;I&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
<assign value="&quot;R&quot;" property="target.{PV1:AdmissionType}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR307IdentifiantUniqueDeMouv}" property="target.{PV1:AlternateVisitID}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR303NumeroEpisode}" property="target.{PV1:VisitNumber.ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value='source.{NR3:NR301CodeHopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.FacilityHD}' action='set' />
<assign value="source.{NR4:NR408CodeUS}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR304Chambre}" property="target.{PV1:AssignedPatientLocation.room}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR305MedecinResponsable.CodeClinicom}" property="target.{PV1:AttendingDoctor(1).IDnumberST}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR305MedecinResponsable.Nom}" property="target.{PV1:AttendingDoctor(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR305MedecinResponsable.Prenom}" property="target.{PV1:AttendingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR305MedecinResponsable.Qualite}" property="target.{PV1:AttendingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR305MedecinResponsable.Titre}" property="target.{PV1:AttendingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value="source.{NR4:NR411DateHeureAdmission}" property="target.{PV1:AdmitDateTime.timeofanevent}" key="&quot;&quot;" action="set" />

<!-- segment ZFU -->
<assign value="source.{NR4:NR411DateHeureAdmission}" property="target.{ZFU:MedicalFunctionalUnitStartDa}" key="&quot;&quot;" action="set" />
<assign value="source.{NR4:NR409CodeUF}" property="target.{ZFU:MedicalFunctionalUnit}" key="&quot;&quot;" action="set" />

</transform>
}

}
