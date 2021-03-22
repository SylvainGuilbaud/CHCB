Class ISSAS.Common.DTL.CCOMtoHL7v231.ORtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v231/ORtoADT.xml#8 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:OR" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
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
<![CDATA[ Set tSC1=target.SetValueAt("ADT^"_..Lookup("CCOM_HL7_MessageType_v231","OR"_source.GetValueAt("OR:OR01Mode")),"MSH:MessageType","set","")]]>
</code>

<!-- segment EVN -->
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v231","OR"_source.GetValueAt("OR:OR01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="source.{OR3:OR307DateHeureEnregistrement}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR320Utilisateur.Username}" property="target.{EVN:OperatorID(1).IDNumberST}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR03IPP}" property="target.{PID:PatientIdentifierList(1).ID}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR04NomUsuel.Nom}" property="target.{PID:PatientName(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR04NomUsuel.NameTypeCode}" property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR05Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR318AutresPrenoms}" property="target.{PID:PatientName(1).middleinitialorname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR06Qualite}" property="target.{PID:PatientName(1).prefix}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{OR:OR07NomDeNaissance.Nom}) &amp;&amp; (source.{OR:OR04NomUsuel.Nom} '= source.{OR:OR07NomDeNaissance.Nom})">
<true>
<assign value="source.{OR:OR07NomDeNaissance.Nom}" property="target.{PID:PatientName(2).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR07NomDeNaissance.NameTypeCode}" property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR05Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{OR:OR09DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{OR:OR10Sexe})" property="target.{PID:Sex}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR11NoRueAdresse}" property="target.{PID:PatientAddress(1).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR12CodePostalAdresse}" property="target.{PID:PatientAddress(1).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR201LocaliteAdresse}" property="target.{PID:PatientAddress(1).city}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR206ComplementAdresse}" property="target.{PID:PatientAddress(1).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR207PaysAdresse}" property="target.{PID:PatientAddress(1).country}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{OR2:OR202TelephoneDomicile})">
<true>
<assign value="source.{OR2:OR202TelephoneDomicile}" property="target.{PID:PhoneNumberHome($I(nbtel)).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{OR2:OR208TelephoneProfessionnel})">
<true>
<assign value="source.{OR2:OR208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;WPN&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{OR2:OR209TelephonePortable})">
<true>
<assign value="source.{OR2:OR209TelephonePortable}" property="target.{PID:PhoneNumberHome($I(nbtel)).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;CP&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{OR2:OR203Nationalite}" property="target.{PID:Nationality}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR212NumeroSSDernierEpisode}" property="target.{PID:SSNNumberPatient}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR303NumeroEpisode}" property="target.{PID:PatientAccountNumber.ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="..Lookup($G(^ISSAS.Config(&quot;LUT&quot;, &quot;CCOM_HL7_MaritalStatus&quot;)),source.{OR3:OR309SituationFamiliale})" property="target.{PID:MaritalStatus.identifier}" key="&quot;&quot;" action="set" />

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value="&quot;O&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR210IdentifiantUniqueDeMouv}" property="target.{PV1:AlternateVisitID}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR303NumeroEpisode}" property="target.{PV1:VisitNumber.ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value='source.{OR3:OR301CodeHopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.FacilityHD}' action='set' />
<assign value="source.{OR3:OR305CodeUniteConsultation}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR315MedecinResponsable.CodeClinicom}" property="target.{PV1:AttendingDoctor(1).IDnumberST}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR315MedecinResponsable.Nom}" property="target.{PV1:AttendingDoctor(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR315MedecinResponsable.Prenom}" property="target.{PV1:AttendingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR315MedecinResponsable.Qualite}" property="target.{PV1:AttendingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR315MedecinResponsable.Titre}" property="target.{PV1:AttendingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR307DateHeureEnregistrement}" property="target.{PV1:AdmitDateTime.timeofanevent}" key="&quot;&quot;" action="set" />

<!-- segment ZFU -->
<assign value="source.{OR3:OR306CodeUF}" property="target.{ZFU:MedicalFunctionalUnit}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR307DateHeureEnregistrement}" property="target.{ZFU:MedicalFunctionalUnitStartDa}" key="&quot;&quot;" action="set" />

</transform>
}

}
