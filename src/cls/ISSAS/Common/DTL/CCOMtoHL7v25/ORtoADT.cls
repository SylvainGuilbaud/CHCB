Class ISSAS.Common.DTL.CCOMtoHL7v25.ORtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v25/ORtoADT.xml#12 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:OR" targetClass="EnsLib.HL7.Message" targetDocType="HL7v25IHE:ADT_AXX" create="new" language="objectscript" >
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
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","OR"_source.GetValueAt("OR:OR01Mode")),"MSH:MessageType.TriggerEvent","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","OR"_source.GetValueAt("OR:OR01Mode")),"MSH:MessageType.MessageStructure","set","")]]>
</code>
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value='"2.5"' property="target.{MSH:VersionID}" key="&quot;&quot;" action="set" />
<assign value="&quot;FRA&quot;" property="target.{MSH:CountryCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<assign value="&quot;FR&quot;" property="target.{MSH:PrincipalLanguageOfMessage}" key="&quot;&quot;" action="set" />

<!-- segment EVN -->
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","OR"_source.GetValueAt("OR:OR01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR307DateHeureEnregistrement}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR320Utilisateur.Username}" property="target.{EVN:OperatorID.IDNumber}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR03IPP}" property="target.{PID:PatientIdentifierList(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : on envoie toujours nom de naissance en L et nom usuel en D pour être conforme IHE PAM -->
<assign value="source.{OR:OR04NomUsuel.Nom}" property="target.{PID:PatientName(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value="&quot;D&quot;" property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR05Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR318AutresPrenoms}" property="target.{PID:PatientName(1).secondandfurthergivennamesor}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR06Qualite}" property="target.{PID:PatientName(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR07NomDeNaissance.Nom}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value="&quot;L&quot;" property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR05Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR318AutresPrenoms}" property="target.{PID:PatientName(2).secondandfurthergivennamesor}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR06Qualite}" property="target.{PID:PatientName(2).prefix}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : par précaution, dans le cas improbable où le nom de naissance serait vide, on envoie le nom usuel en L aussi -->
<if condition="$L(source.{OR:OR07NomDeNaissance.Nom})">
<false>
<assign value="source.{OR:OR04NomUsuel.Nom}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{OR:OR09DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{OR:OR10Sexe})" property="target.{PID:AdministrativeSex}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR11NoRueAdresse}" property="target.{PID:PatientAddress(1).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{OR:OR12CodePostalAdresse}" property="target.{PID:PatientAddress(1).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR201LocaliteAdresse}" property="target.{PID:PatientAddress(1).city}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR206ComplementAdresse}" property="target.{PID:PatientAddress(1).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR207PaysAdresse}" property="target.{PID:PatientAddress(1).country}" key="&quot;&quot;" action="set" />
<assign value="&quot;H&quot;" property="target.{PID:PatientAddress(1).AddressType}" key="&quot;&quot;" action="set" />

<!-- telephone domicile seulement si valorisé -->
<if condition="$L(source.{OR2:OR202TelephoneDomicile})">
<true>
<assign value="source.{OR2:OR202TelephoneDomicile}" property="target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR202TelephoneDomicile}" property="target.{PID:PhoneNumberHome(nbtel).UnformattedTelephonenumber}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{OR2:OR208TelephoneProfessionnel})">
<true>
<assign value="source.{OR2:OR208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;WPN&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).UnformattedTelephonenumber}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{OR2:OR209TelephonePortable})">
<true>
<assign value="source.{OR2:OR209TelephonePortable}" property="target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;CP&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR209TelephonePortable}" property="target.{PID:PhoneNumberHome(nbtel).UnformattedTelephonenumber}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{OR2:OR203Nationalite}" property="target.{PID:Nationality}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR203Nationalite}" property="target.{PID:Citizenship(1)}" key="&quot;&quot;" action="set" />
<assign value="source.{OR2:OR212NumeroSSDernierEpisode}" property="target.{PID:SSNNumberPatient}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR303NumeroEpisode}" property="target.{PID:PatientAccountNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="..Lookup($G(^ISSAS.Config(&quot;LUT&quot;, &quot;CCOM_HL7_MaritalStatus&quot;)),source.{OR3:OR309SituationFamiliale})" property="target.{PID:MaritalStatus.identifier}" key="&quot;&quot;" action="set" />

<!-- Identité validée ou provisoire -->
<if condition='source.{OR2:OR211InformationsIdentite.IndicateurIdentiteProvisoire}="1"'>
<true>
<assign value='"PROV"' property="target.{PID:IdentityReliabilityCode(1)}" key="&quot;&quot;" action="set" />
<assign value="&quot;Y&quot;" property="target.{PID:IdentityUnknownIndicator}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{OR2:OR211InformationsIdentite.IndicateurIdentiteValidee}="1"'>
<true>
<assign value='"VALI"' property="target.{PID:IdentityReliabilityCode(1)}" key="&quot;&quot;" action="set" />
<assign value="&quot;N&quot;" property="target.{PID:IdentityUnknownIndicator}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- segment ROL (médecin traitant) -->
<if condition="$L(source.{OR5:OR503MedecinTraitant.CodeClinicom})">
<true>
<assign value='"UP"' property="target.{ROL(1):ActionCode}" key="&quot;&quot;" action="set" />
<assign value='"ODRP"' property="target.{ROL(1):RoleROL}" key="&quot;&quot;" action="set" />
<assign value='source.{OR5:OR503MedecinTraitant.CodeClinicom}' property="target.{ROL(1):RolePerson(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value='source.{OR5:OR503MedecinTraitant.Nom}' property="target.{ROL(1):RolePerson(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='source.{OR5:OR503MedecinTraitant.Prenom}' property="target.{ROL(1):RolePerson(1).GivenName}" key="&quot;&quot;" action="set" />
<assign value='source.{OR5:OR503MedecinTraitant.Qualite}' property="target.{ROL(1):RolePerson(1).Prefix}" key="&quot;&quot;" action="set" />
<assign value='source.{OR5:OR503MedecinTraitant.Titre}' property="target.{ROL(1):RolePerson(1).Degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{ROL(1):RolePerson(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />

<!-- Adresse médecin traitant demandé par Firminy JIRA CCOMTCC-1076, nécessite mise à jour classe ODBC & PAYS_INSEE_3166-1-alpha-3.LUT -->
<assign value='"O"' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).AddressType}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedAdresse(source.{OR5:OR503MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).StreetAddress}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedComplAd(source.{OR5:OR503MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).OtherDesignation}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedCP(source.{OR5:OR503MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).ZiporPostalCode}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedVille(source.{OR5:OR503MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).City}" key="&quot;&quot;" action="set" />
<assign value='..Lookup("PAYS_INSEE_3166-1-alpha-3",##class(ISSAS.Common.Tools.ClassODBC).MedPays(source.{OR5:OR503MedecinTraitant.CodeClinicom}))' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).Country}" key="&quot;&quot;" action="set" />

<!-- N° RPPS -->
<if condition="$L(source.{OR5:OR503MedecinTraitant.NoRPPS})">
<true>
<assign value='source.{OR5:OR503MedecinTraitant.NoRPPS}' property="target.{ROL(1):RolePerson(2).IDNumber}" key="&quot;&quot;" action="set" />
<assign value='source.{OR5:OR503MedecinTraitant.Nom}' property="target.{ROL(1):RolePerson(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='source.{OR5:OR503MedecinTraitant.Prenom}' property="target.{ROL(1):RolePerson(2).GivenName}" key="&quot;&quot;" action="set" />
<assign value='source.{OR5:OR503MedecinTraitant.Qualite}' property="target.{ROL(1):RolePerson(2).Prefix}" key="&quot;&quot;" action="set" />
<assign value='source.{OR5:OR503MedecinTraitant.Titre}' property="target.{ROL(1):RolePerson(2).Degree}" key="&quot;&quot;" action="set" />
<assign value='"RPPS"' property="target.{ROL(1):RolePerson(2).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
</true>
</if>
</true>
</if>

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<if condition='source.{OR3:OR319IndicateurEpisodeRecurr} = "1"'>
<true>
<assign value="&quot;R&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;O&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{OR3:OR303NumeroEpisode}" property="target.{PV1:VisitNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR305CodeUniteConsultation}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR301CodeHopital.CodeEtablissement}" property="target.{PV1:AssignedPatientLocation.facility}" key="&quot;&quot;" action="set" />

<assign value="source.{OR3:OR315MedecinResponsable.CodeClinicom}" property="target.{PV1:AttendingDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR315MedecinResponsable.Nom}" property="target.{PV1:AttendingDoctor(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR315MedecinResponsable.Prenom}" property="target.{PV1:AttendingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR315MedecinResponsable.Qualite}" property="target.{PV1:AttendingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR315MedecinResponsable.Titre}" property="target.{PV1:AttendingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:AttendingDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{OR3:OR316MedecinEnvoyeur.CodeClinicom})">
<true>
<assign value="source.{OR3:OR316MedecinEnvoyeur.CodeClinicom}" property="target.{PV1:AdmittingDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR316MedecinEnvoyeur.Nom}" property="target.{PV1:AdmittingDoctor(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR316MedecinEnvoyeur.Prenom}" property="target.{PV1:AdmittingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR316MedecinEnvoyeur.Qualite}" property="target.{PV1:AdmittingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR316MedecinEnvoyeur.Titre}" property="target.{PV1:AdmittingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:AdmittingDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{OR3:OR307DateHeureEnregistrement}" property="target.{PV1:AdmitDateTime}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{OR5:OR503MedecinTraitant.CodeClinicom})">
<true>
<assign value="source.{OR5:OR503MedecinTraitant.CodeClinicom}" property="target.{PV1:ReferringDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value="source.{OR5:OR503MedecinTraitant.Nom}" property="target.{PV1:ReferringDoctor(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR5:OR503MedecinTraitant.Prenom}" property="target.{PV1:ReferringDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{OR5:OR503MedecinTraitant.Qualite}" property="target.{PV1:ReferringDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{OR5:OR503MedecinTraitant.Titre}" property="target.{PV1:ReferringDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:ReferringDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- segment PV2 -->
<assign value="source.{OR3:OR321CodeParcoursDeSoins}" property="target.{PV2:VisitUserCode}" key="&quot;&quot;" action="set" />
<if condition='$L(source.{OR3:OR323ModeTransport.Code})'>
<true>
<assign value="source.{OR3:OR323ModeTransport.Code}" property="target.{PV2:ModeofArrivalCode}" key="&quot;&quot;" action="set" />
</true>
</if>
<!-- Confidentialité médicale peut prendre les valeurs 0 (normal), 1 (confidentiel) ou 2 (hyperconfidentiel) -->
<if condition='..In(source.{OR2:OR214ConfidentialiteMedicale},"1,2")'>
<true>
<assign value='"Y"' property="target.{PV2:VisitProtectionIndicator}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value='"N"' property="target.{PV2:VisitProtectionIndicator}" key="&quot;&quot;" action="set" />
</false>
</if>

<!-- segment ZBE -->
<assign value="source.{OR2:OR210IdentifiantUniqueDeMouv}" property="target.{ZBE:MovementID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{ZBE:MovementID.NamespaceID}" key="&quot;&quot;" action="set" />
<if condition='$L(source.{OR3:OR325DateHeureDecisionMedica})'>
<true>
<assign value="source.{OR3:OR325DateHeureDecisionMedica}" property="target.{ZBE:StartMovementDateTime}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR325DateHeureDecisionMedica}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="source.{OR3:OR307DateHeureEnregistrement}" property="target.{ZBE:StartMovementDateTime}" key="&quot;&quot;" action="set" />
</false>
</if>
<if condition='source.{OR:OR01Mode} = "02"'>
<true>
<assign value="&quot;UPDATE&quot;" property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
<assign value="&quot;A04&quot;" property="target.{ZBE:Originaltriggereventcode}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;INSERT&quot;" property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="&quot;N&quot;" property="target.{ZBE:HistoricalMovementIndicator}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR306CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationName}" key="&quot;&quot;" action="set" />
<assign value="source.{OR3:OR306CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationIdentifier}" key="&quot;&quot;" action="set" />
<assign value='"HMS"' property="target.{ZBE:NatureMouvement}" key="&quot;&quot;" action="set" />

<!-- segment ZFP -->
<if condition="$L(source.{OR3:OR311CategorieSocioprofessio})">
<true>
<assign value="source.{OR3:OR311CategorieSocioprofessio}" property="target.{ZFP:Activitesociopro}" key="&quot;&quot;" action="set" />
</true>
</if>
</transform>
}

}
