Class ISSAS.Common.DTL.CCOMtoHL7v231.URtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v231/URtoADT.xml#5 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:UR" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
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
<![CDATA[ Set tSC1=target.SetValueAt("ADT^"_..Lookup("CCOM_HL7_MessageType_v231","UR"_source.GetValueAt("UR:UR01Mode")),"MSH:MessageType","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v231","UR"_source.GetValueAt("UR:UR01Mode")),"EVN:EventTypeCode","set","")]]>
</code>

<!-- EVN -->
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR307DateHeureEnregistrement}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />

<!-- PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR03IPP}" property="target.{PID:PatientIdentifierList(1).ID}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR04NomUsuel.Nom}" property="target.{PID:PatientName(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR04NomUsuel.NameTypeCode}" property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR05Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR318AutresPrenoms}" property="target.{PID:PatientName(1).middleinitialorname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR06Qualite}" property="target.{PID:PatientName(1).prefix}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{UR:UR07NomDeNaissance.Nom}) &amp;&amp; (source.{UR:UR04NomUsuel.Nom} '= source.{UR:UR07NomDeNaissance.Nom})">
<true>
<assign value="source.{UR:UR07NomDeNaissance.Nom}" property="target.{PID:PatientName(2).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR07NomDeNaissance.NameTypeCode}" property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR05Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{UR:UR09DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{UR:UR10Sexe})" property="target.{PID:Sex}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR11NoRueAdresse}" property="target.{PID:PatientAddress(1).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR12CodePostalAdresse}" property="target.{PID:PatientAddress(1).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{UR2:UR201LocaliteAdresse}" property="target.{PID:PatientAddress(1).city}" key="&quot;&quot;" action="set" />
<assign value="source.{UR2:UR206ComplementAdresse}" property="target.{PID:PatientAddress(1).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{UR2:UR207PaysAdresse}" property="target.{PID:PatientAddress(1).country}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{UR2:UR202TelephoneDomicile})">
<true>
<assign value="source.{UR2:UR202TelephoneDomicile}" property="target.{PID:PhoneNumberHome($I(nbtel)).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{UR2:UR208TelephoneProfessionnel})">
<true>
<assign value="source.{UR2:UR208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;WPN&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{UR2:UR209TelephonePortable})">
<true>
<assign value="source.{UR2:UR209TelephonePortable}" property="target.{PID:PhoneNumberHome($I(nbtel)).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;CP&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{UR2:UR203Nationalite}" property="target.{PID:Nationality}" key="&quot;&quot;" action="set" />
<assign value="source.{UR2:UR212NumeroSSDernierEpisode}" property="target.{PID:SSNNumberPatient}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR303NumeroEpisode}" property="target.{PID:PatientAccountNumber.ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="..Lookup($G(^ISSAS.Config(&quot;LUT&quot;, &quot;CCOM_HL7_MaritalStatus&quot;)),source.{UR3:UR309SituationFamiliale})" property="target.{PID:MaritalStatus.identifier}" key="&quot;&quot;" action="set" />

<!-- PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value="&quot;E&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
<assign value="&quot;E&quot;" property="target.{PV1:AdmissionType}" key="&quot;&quot;" action="set" />
<assign value="source.{UR2:UR210IdentifiantUniqueDeMouv}" property="target.{PV1:AlternateVisitID}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR303NumeroEpisode}" property="target.{PV1:VisitNumber.ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value='source.{UR3:UR301CodeHopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.FacilityHD}' action='set' />
<assign value="source.{UR3:UR305CodeUS}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR315MedecinResponsable.CodeClinicom}" property="target.{PV1:AttendingDoctor(1).IDnumberST}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR315MedecinResponsable.Nom}" property="target.{PV1:AttendingDoctor(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR315MedecinResponsable.Prenom}" property="target.{PV1:AttendingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR315MedecinResponsable.Qualite}" property="target.{PV1:AttendingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR315MedecinResponsable.Titre}" property="target.{PV1:AttendingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR307DateHeureEnregistrement}" property="target.{PV1:AdmitDateTime.timeofanevent}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR319ModeEntree}" property="target.{PV1:AdmitSource}" key="&quot;&quot;" action="set" />

<!-- ZFU -->
<assign value="source.{UR3:UR306CodeUF}" property="target.{ZFU:MedicalFunctionalUnit}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR307DateHeureEnregistrement}" property="target.{ZFU:MedicalFunctionalUnitStartDa}" key="&quot;&quot;" action="set" />

</transform>
}

}
