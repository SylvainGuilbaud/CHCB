Class ISSAS.Common.DTL.CCOMtoHL7v25.URtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v25/URtoADT.xml#11 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:UR" targetClass="EnsLib.HL7.Message" targetDocType="HL7v25IHE:ADT_AXX" create="new" language="objectscript" >
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
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","UR"_source.GetValueAt("UR:UR01Mode")),"MSH:MessageType.TriggerEvent","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","UR"_source.GetValueAt("UR:UR01Mode")),"MSH:MessageType.MessageStructure","set","")]]>
</code>
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value='"2.5"' property="target.{MSH:VersionID}" key="&quot;&quot;" action="set" />
<assign value="&quot;FRA&quot;" property="target.{MSH:CountryCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<assign value="&quot;FR&quot;" property="target.{MSH:PrincipalLanguageOfMessage}" key="&quot;&quot;" action="set" />

<!-- segment EVN -->
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","UR"_source.GetValueAt("UR:UR01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR307DateHeureEnregistrement}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR320Utilisateur.Username}" property="target.{EVN:OperatorID.IDNumber}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR03IPP}" property="target.{PID:PatientIdentifierList(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : on envoie toujours nom de naissance en L et nom usuel en D pour être conforme IHE PAM -->
<assign value="source.{UR:UR04NomUsuel.Nom}" property="target.{PID:PatientName(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='"D"' property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR05Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR06Qualite}" property="target.{PID:PatientName(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR07NomDeNaissance.Nom}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='"L"' property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR05Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR06Qualite}" property="target.{PID:PatientName(2).prefix}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : par précaution, dans le cas improbable où le nom de naissance serait vide, on envoie le nom usuel en L aussi -->
<if condition="$L(source.{UR:UR07NomDeNaissance.Nom})">
<false>
<assign value="source.{UR:UR04NomUsuel.Nom}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{UR:UR09DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{UR:UR10Sexe})" property="target.{PID:AdministrativeSex}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR11NoRueAdresse}" property="target.{PID:PatientAddress(1).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{UR:UR12CodePostalAdresse}" property="target.{PID:PatientAddress(1).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{UR2:UR201LocaliteAdresse}" property="target.{PID:PatientAddress(1).city}" key="&quot;&quot;" action="set" />
<assign value="source.{UR2:UR206ComplementAdresse}" property="target.{PID:PatientAddress(1).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{UR2:UR207PaysAdresse}" property="target.{PID:PatientAddress(1).country}" key="&quot;&quot;" action="set" />
<assign value="&quot;H&quot;" property="target.{PID:PatientAddress(1).AddressType}" key="&quot;&quot;" action="set" />

<!-- telephone domicile seulement si valorisé -->
<if condition="$L(source.{UR2:UR202TelephoneDomicile})">
<true>
<assign value="source.{UR2:UR202TelephoneDomicile}" property="target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{UR2:UR208TelephoneProfessionnel})">
<true>
<assign value="source.{UR2:UR208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;WPN&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{UR2:UR209TelephonePortable})">
<true>
<assign value="source.{UR2:UR209TelephonePortable}" property="target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;CP&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{UR2:UR203Nationalite}" property="target.{PID:Nationality}" key="&quot;&quot;" action="set" />
<assign value="source.{UR2:UR203Nationalite}" property="target.{PID:Citizenship(1)}" key="&quot;&quot;" action="set" />
<assign value="source.{UR2:UR212NumeroSSDernierEpisode}" property="target.{PID:SSNNumberPatient}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR303NumeroEpisode}" property="target.{PID:PatientAccountNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="..Lookup($G(^ISSAS.Config(&quot;LUT&quot;, &quot;CCOM_HL7_MaritalStatus&quot;)),source.{UR3:UR309SituationFamiliale})" property="target.{PID:MaritalStatus.identifier}" key="&quot;&quot;" action="set" />
<!-- Identité validée ou provisoire -->
<if condition='source.{UR2:UR211InformationsIdentite.IndicateurIdentiteProvisoire}="1"'>
<true>
<assign value='"PROV"' property="target.{PID:IdentityReliabilityCode(1)}" key="&quot;&quot;" action="set" />
<assign value="&quot;Y&quot;" property="target.{PID:IdentityUnknownIndicator}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{UR2:UR211InformationsIdentite.IndicateurIdentiteValidee}="1"'>
<true>
<assign value='"VALI"' property="target.{PID:IdentityReliabilityCode(1)}" key="&quot;&quot;" action="set" />
<assign value="&quot;N&quot;" property="target.{PID:IdentityUnknownIndicator}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- segment ROL (médecin traitant) -->
<if condition="$L(source.{UR5:UR503MedecinTraitant.CodeClinicom})">
<true>
<assign value='"UP"' property="target.{ROL(1):ActionCode}" key="&quot;&quot;" action="set" />
<assign value='"ODRP"' property="target.{ROL(1):RoleROL}" key="&quot;&quot;" action="set" />
<assign value='source.{UR5:UR503MedecinTraitant.CodeClinicom}' property="target.{ROL(1):RolePerson(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value='source.{UR5:UR503MedecinTraitant.Nom}' property="target.{ROL(1):RolePerson(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='source.{UR5:UR503MedecinTraitant.Prenom}' property="target.{ROL(1):RolePerson(1).GivenName}" key="&quot;&quot;" action="set" />
<assign value='source.{UR5:UR503MedecinTraitant.Qualite}' property="target.{ROL(1):RolePerson(1).Prefix}" key="&quot;&quot;" action="set" />
<assign value='source.{UR5:UR503MedecinTraitant.Titre}' property="target.{ROL(1):RolePerson(1).Degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{ROL(1):RolePerson(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />

<!-- Adresse médecin traitant demandé par Firminy JIRA CCOMTCC-1076, nécessite mise à jour classe ODBC & PAYS_INSEE_3166-1-alpha-3.LUT -->
<assign value='"O"' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).AddressType}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedAdresse(source.{UR5:UR503MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).StreetAddress}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedComplAd(source.{UR5:UR503MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).OtherDesignation}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedCP(source.{UR5:UR503MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).ZiporPostalCode}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedVille(source.{UR5:UR503MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).City}" key="&quot;&quot;" action="set" />
<assign value='..Lookup("PAYS_INSEE_3166-1-alpha-3",##class(ISSAS.Common.Tools.ClassODBC).MedPays(source.{UR5:UR503MedecinTraitant.CodeClinicom}))' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).Country}" key="&quot;&quot;" action="set" />

<!-- N° RPPS -->
<if condition="$L(source.{UR5:UR503MedecinTraitant.NoRPPS})">
<true>
<assign value='source.{UR5:UR503MedecinTraitant.NoRPPS}' property="target.{ROL(1):RolePerson(2).IDNumber}" key="&quot;&quot;" action="set" />
<assign value='source.{UR5:UR503MedecinTraitant.Nom}' property="target.{ROL(1):RolePerson(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='source.{UR5:UR503MedecinTraitant.Prenom}' property="target.{ROL(1):RolePerson(2).GivenName}" key="&quot;&quot;" action="set" />
<assign value='source.{UR5:UR503MedecinTraitant.Qualite}' property="target.{ROL(1):RolePerson(2).Prefix}" key="&quot;&quot;" action="set" />
<assign value='source.{UR5:UR503MedecinTraitant.Titre}' property="target.{ROL(1):RolePerson(2).Degree}" key="&quot;&quot;" action="set" />
<assign value='"RPPS"' property="target.{ROL(1):RolePerson(2).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
</true>
</if>
</true>
</if>

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value="&quot;E&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR303NumeroEpisode}" property="target.{PV1:VisitNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR305CodeUS}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR315MedecinResponsable.CodeClinicom}" property="target.{PV1:AttendingDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR315MedecinResponsable.Nom}" property="target.{PV1:AttendingDoctor(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR315MedecinResponsable.Prenom}" property="target.{PV1:AttendingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR315MedecinResponsable.Qualite}" property="target.{PV1:AttendingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR315MedecinResponsable.Titre}" property="target.{PV1:AttendingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:AttendingDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value='source.{UR3:UR301CodeHopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.Facility}' action='set' />
<assign value="source.{UR3:UR307DateHeureEnregistrement}" property="target.{PV1:AdmitDateTime}" key="&quot;&quot;" action="set" />

<if condition="$L(source.{UR5:UR503MedecinTraitant.CodeClinicom})">
<true>
<assign value="source.{UR5:UR503MedecinTraitant.CodeClinicom}" property="target.{PV1:ReferringDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value="source.{UR5:UR503MedecinTraitant.Nom}" property="target.{PV1:ReferringDoctor(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR5:UR503MedecinTraitant.Prenom}" property="target.{PV1:ReferringDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{UR5:UR503MedecinTraitant.Qualite}" property="target.{PV1:ReferringDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{UR5:UR503MedecinTraitant.Titre}" property="target.{PV1:ReferringDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:ReferringDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{UR3:UR319ModeEntree}" property="target.{PV1:AdmitSource}" key="&quot;&quot;" action="set" />

<!-- segment PV2 -->
<assign value="source.{UR3:UR321CodeParcoursDeSoins}" property="target.{PV2:VisitUserCode}" key="&quot;&quot;" action="set" />
<if condition='$L(source.{UR3:UR323ModeTransport.Code})'>
<true>
<assign value="source.{UR3:UR323ModeTransport.Code}" property="target.{PV2:ModeofArrivalCode}" key="&quot;&quot;" action="set" />
</true>
</if>
<!-- Confidentialité médicale peut prendre les valeurs 0 (normal), 1 (confidentiel) ou 2 (hyperconfidentiel) -->
<if condition='..In(source.{UR2:UR214ConfidentialiteMedicale},"1,2")'>
<true>
<assign value='"Y"' property="target.{PV2:VisitProtectionIndicator}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value='"N"' property="target.{PV2:VisitProtectionIndicator}" key="&quot;&quot;" action="set" />
</false>
</if>

<!-- segment ZBE -->
<assign value="source.{UR2:UR210IdentifiantUniqueDeMouv}" property="target.{ZBE:MovementID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{ZBE:MovementID.NamespaceID}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR307DateHeureEnregistrement}" property="target.{ZBE:StartMovementDateTime}" key="&quot;&quot;" action="set" />
<if condition='source.{UR:UR01Mode} = "01"'>
<true>
<assign value="&quot;INSERT&quot;" property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{UR:UR01Mode} = "02"'>
<true>
<assign value="&quot;UPDATE&quot;" property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
<assign value="&quot;A04&quot;" property="target.{ZBE:Originaltriggereventcode}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{UR:UR01Mode}="03"'>
<true>
<assign value='"CANCEL"' property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
<assign value='"A06"' property="target.{ZBE:Originaltriggereventcode}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{UR:UR01Mode}="04"'>
<true>
<assign value='"CANCEL"' property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
<assign value='"A07"' property="target.{ZBE:Originaltriggereventcode}" key="&quot;&quot;" action="set" />
</true>
</if>

<if condition='source.{UR3:UR316IndicateurDernierMouvem} = "1"'>
<true>
<assign value="&quot;N&quot;" property="target.{ZBE:HistoricalMovementIndicator}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;Y&quot;" property="target.{ZBE:HistoricalMovementIndicator}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{UR3:UR306CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationName}" key="&quot;&quot;" action="set" />
<assign value="source.{UR3:UR306CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationIdentifier}" key="&quot;&quot;" action="set" />
<assign value='"HMS"' property="target.{ZBE:NatureMouvement}" key="&quot;&quot;" action="set" />

<!-- segment ZFM -->
<!-- requete vers CLINICOM : SELECT TXT_COD_ModeEntreeUM FROM ClinicomSQL.Admission_Mode_Entree WHERE ID='?' -->
<assign value="##class(ISSAS.Common.Tools.ClassODBC).ClinicomAdmissionModeEntree(source.{UR3:UR319ModeEntree})" property="target.{ZFM:ModeEntreePMSI}" key="&quot;&quot;" action="set" />

<!-- segment ZFP -->
<if condition="$L(source.{UR3:UR311CategorieSocioprofessio})">
<true>
<assign value="source.{UR3:UR311CategorieSocioprofessio}" property="target.{ZFP:Activitesociopro}" key="&quot;&quot;" action="set" />
</true>
</if>
</transform>
}

}
