Class ISSAS.Common.DTL.CCOMtoHL7v231.ADtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v231/ADtoADT.xml#8 $";

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:AD" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
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
<![CDATA[ Set tSC1=target.SetValueAt("ADT^"_..Lookup("CCOM_HL7_MessageType_v231","AD"_source.GetValueAt("AD:AD01Mode")),"MSH:MessageType","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v231","AD"_source.GetValueAt("AD:AD01Mode")),"EVN:EventTypeCode","set","")]]>
</code>

<!-- segment EVN -->
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD320DateHeureAdmission}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD331Utilisateur.Username}" property="target.{EVN:OperatorID(1).IDNumberST}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD03IPP}" property="target.{PID:PatientIdentifierList(1).ID}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD04NomUsuel.Nom}" property="target.{PID:PatientName(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD04NomUsuel.NameTypeCode}" property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD05Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD211AutresPrenoms}" property="target.{PID:PatientName(1).middleinitialorname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD06Qualite}" property="target.{PID:PatientName(1).prefix}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{AD:AD07NomDeNaissance.Nom}) &amp;&amp; (source.{AD:AD04NomUsuel.Nom} '= source.{AD:AD07NomDeNaissance.Nom})">
<true>
<assign value="source.{AD:AD07NomDeNaissance.Nom}" property="target.{PID:PatientName(2).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD07NomDeNaissance.NameTypeCode}" property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD05Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{AD:AD09DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{AD:AD10Sexe})" property="target.{PID:Sex}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD11NoRueAdresse}" property="target.{PID:PatientAddress(1).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD12CodePostalAdresse}" property="target.{PID:PatientAddress(1).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD201LocaliteAdresse}" property="target.{PID:PatientAddress(1).city}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD206ComplementAdresse}" property="target.{PID:PatientAddress(1).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD207PaysAdresse}" property="target.{PID:PatientAddress(1).country}" key="&quot;&quot;" action="set" />

<!-- téléphones seulement si valorisés -->
<if condition="$L(source.{AD2:AD202TelephoneDomicile})">
<true>
<assign value="source.{AD2:AD202TelephoneDomicile}" property="target.{PID:PhoneNumberHome($I(nbtel)).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{AD2:AD208TelephoneProfessionnel})">
<true>
<assign value="source.{AD2:AD208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;WPN&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{AD2:AD212TelephonePortable})">
<true>
<assign value="source.{AD2:AD212TelephonePortable}" property="target.{PID:PhoneNumberHome($I(nbtel)).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;CP&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>

<assign value="source.{AD2:AD203Nationalite}" property="target.{PID:Nationality}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD215NumeroSSDernierEpisode}" property="target.{PID:SSNNumberPatient}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD303NumeroEpisode}" property="target.{PID:PatientAccountNumber.ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="..Lookup($G(^ISSAS.Config(&quot;LUT&quot;, &quot;CCOM_HL7_MaritalStatus&quot;)),source.{AD3:AD309SituationFamiliale})" property="target.{PID:MaritalStatus.identifier}" key="&quot;&quot;" action="set" />

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<!-- Patient Class = R si épisode récurrent, I sinon -->
<if condition="source.{AD3:AD322IndicateurEpisodeRecurr} = 1">
<true>
<assign value="&quot;R&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;I&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
</false>
</if>

<assign value="source.{AD2:AD213IdentifiantUniqueDeMouv}" property="target.{PV1:AlternateVisitID}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD303NumeroEpisode}" property="target.{PV1:VisitNumber.ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value='source.{AD3:AD301Hopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.FacilityHD}' action='set' />
<assign value="source.{AD3:AD305CodeUS}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD307Lit}" property="target.{PV1:AssignedPatientLocation.bed}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD308Chambre}" property="target.{PV1:AssignedPatientLocation.room}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD313ModeEntree}" property="target.{PV1:AdmitSource}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD319MedecinResponsable.CodeClinicom}" property="target.{PV1:AttendingDoctor(1).IDnumberST}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD319MedecinResponsable.Nom}" property="target.{PV1:AttendingDoctor(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD319MedecinResponsable.Prenom}" property="target.{PV1:AttendingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD319MedecinResponsable.Qualite}" property="target.{PV1:AttendingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD319MedecinResponsable.Titre}" property="target.{PV1:AttendingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD320DateHeureAdmission}" property="target.{PV1:AdmitDateTime.timeofanevent}" key="&quot;&quot;" action="set" />

<!-- segment ZFU -->
<assign value="source.{AD3:AD306CodeUF}" property="target.{ZFU:MedicalFunctionalUnit}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD320DateHeureAdmission}" property="target.{ZFU:MedicalFunctionalUnitStartDa}" key="&quot;&quot;" action="set" />

<if condition="$L(source.{AD3:AD334DateHeureDecisionMedica})">
<true>
<assign value="source.{AD3:AD334DateHeureDecisionMedica}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD334DateHeureDecisionMedica}" property="target.{ZFU:MedicalFunctionalUnitStartDa}" key="&quot;&quot;" action="set" />
</true>
</if>
</transform>
}

Parameter REPORTERRORS = 1;

}
