Class ISSAS.Common.DTL.CCOMtoHL7v25.OPtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v25/OPtoADT.xml#9 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:OP" targetClass="EnsLib.HL7.Message" targetDocType="HL7v25IHE:ADT_AXX" create="new" language="objectscript" >
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
 Set strGUID = $EXTRACT(strGUID, 1, 16)
 Set nbtel=0 ]]>
</code>

<!-- segment MSH -->
<assign value="$ZCVT(source.{MSH:MSH03SendingApplication},&quot;U&quot;)" property="target.{MSH:SendingApplication}" key="&quot;&quot;" action="set" />
<assign value="$ZCVT(source.{MSH:MSH04SendingFacility},&quot;U&quot;)" property="target.{MSH:SendingFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MSH:DateTimeOfMessage}" key="&quot;&quot;" action="set" />
<assign value="&quot;ADT&quot;" property="target.{MSH:MessageType.MessageCode}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","OP"_source.GetValueAt("OP:OP01Mode")),"MSH:MessageType.TriggerEvent","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","OP"_source.GetValueAt("OP:OP01Mode")),"MSH:MessageType.MessageStructure","set","")]]>
</code>
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value='"2.5"' property="target.{MSH:VersionID}" key="&quot;&quot;" action="set" />
<assign value="&quot;FRA&quot;" property="target.{MSH:CountryCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<assign value="&quot;FR&quot;" property="target.{MSH:PrincipalLanguageOfMessage}" key="&quot;&quot;" action="set" />

<!-- segment EVN -->
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","OP"_source.GetValueAt("OP:OP01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP306DateHeureEnregistrement}" property="target.{EVN:DateTimePlannedEvent}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP306DateHeureEnregistrement}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP311Utilisateur.Username}" property="target.{EVN:OperatorID.IDNumber}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="source.{OP:OP03IPP}" property="target.{PID:PatientIdentifierList(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : on envoie toujours nom de naissance en L et nom usuel en D pour être conforme IHE PAM -->
<assign value="source.{OP:OP04NomUsuel}" property="target.{PID:PatientName(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value="&quot;D&quot;" property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{OP:OP05Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{OP:OP06Qualite}" property="target.{PID:PatientName(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{OP:OP07NomDeNaissance}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value="&quot;L&quot;" property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{OP:OP05Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{OP:OP06Qualite}" property="target.{PID:PatientName(2).prefix}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : par précaution, dans le cas improbable où le nom de naissance serait vide, on envoie le nom usuel en L aussi -->
<if condition="$L(source.{OP:OP07NomDeNaissance})">
<false>
<assign value="source.{OP:OP04NomUsuel}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{OP:OP09DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{OP:OP10Sexe})" property="target.{PID:AdministrativeSex}" key="&quot;&quot;" action="set" />
<assign value="source.{OP:OP11NoRueAdresse}" property="target.{PID:PatientAddress(1).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{OP:OP12CodePostalAdresse}" property="target.{PID:PatientAddress(1).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{OP2:OP201LocaliteAdresse}" property="target.{PID:PatientAddress(1).city}" key="&quot;&quot;" action="set" />
<assign value="source.{OP2:OP206ComplementAdresse}" property="target.{PID:PatientAddress(1).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{OP2:OP207PaysAdresse}" property="target.{PID:PatientAddress(1).country}" key="&quot;&quot;" action="set" />
<assign value="&quot;H&quot;" property="target.{PID:PatientAddress(1).AddressType}" key="&quot;&quot;" action="set" />

<!-- telephone domicile seulement si valorisé -->
<if condition="$L(source.{OP2:OP202TelephoneDomicile})">
<true>
<assign value="source.{OP2:OP202TelephoneDomicile}" property="target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<!-- telephone professionnel seulement si valorisé -->
<if condition="$L(source.{OP2:OP208TelephoneProfessionnel})">
<true>
<assign value="source.{OP2:OP208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;WPN&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{OP2:OP203Nationalite}" property="target.{PID:Citizenship(1)}" key="&quot;&quot;" action="set" />
<assign value="source.{OP2:OP211NumeroSSDernierEpisode}" property="target.{PID:SSNNumberPatient}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP303NumeroEpisode}" property="target.{PID:PatientAccountNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="..Lookup($G(^ISSAS.Config(&quot;LUT&quot;, &quot;CCOM_HL7_MaritalStatus&quot;)),source.{OP3:OP308SituationFamiliale})" property="target.{PID:MaritalStatus.identifier}" key="&quot;&quot;" action="set" />
<!-- Identité validée ou provisoire -->
<if condition='source.{OP2:OP210InformationsIdentite.IndicateurIdentiteProvisoire}="1"'>
<true>
<assign value='"PROV"' property="target.{PID:IdentityReliabilityCode(1)}" key="&quot;&quot;" action="set" />
<assign value="&quot;Y&quot;" property="target.{PID:IdentityUnknownIndicator}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{OP2:OP210InformationsIdentite.IndicateurIdentiteValidee}="1"'>
<true>
<assign value='"VALI"' property="target.{PID:IdentityReliabilityCode(1)}" key="&quot;&quot;" action="set" />
<assign value="&quot;N&quot;" property="target.{PID:IdentityUnknownIndicator}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value="&quot;O&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP303NumeroEpisode}" property="target.{PV1:VisitNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP303NumeroEpisode}" property="target.{PV1:PreadmitNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:PreadmitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP304CodeUniteConsultation}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP309CodeMedecinResponsable}" property="target.{PV1:AttendingDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:AttendingDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP306DateHeureEnregistrement}" property="target.{PV1:AdmitDateTime}" key="&quot;&quot;" action="set" />
<assign value='source.{OP3:OP301CodeHopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.Facility}' action='set' />

<!-- segment ZBE -->
<assign value="source.{OP2:OP209IdentifiantUniqueDeMouv}" property="target.{ZBE:MovementID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{ZBE:MovementID.NamespaceID}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP306DateHeureEnregistrement}" property="target.{ZBE:StartMovementDateTime}" key="&quot;&quot;" action="set" />
<if condition='source.{OP:OP01Mode} = "01"'>
<true>
<assign value="&quot;INSERT&quot;" property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;UPDATE&quot;" property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
<assign value="&quot;A05&quot;" property="target.{ZBE:Originaltriggereventcode}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="&quot;N&quot;" property="target.{ZBE:HistoricalMovementIndicator}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP305CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationName}" key="&quot;&quot;" action="set" />
<assign value="source.{OP3:OP305CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationIdentifier}" key="&quot;&quot;" action="set" />
<assign value='"HMS"' property="target.{ZBE:NatureMouvement}" key="&quot;&quot;" action="set" />
</transform>
}

}
