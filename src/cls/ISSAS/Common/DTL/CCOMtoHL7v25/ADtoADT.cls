Class ISSAS.Common.DTL.CCOMtoHL7v25.ADtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v25/ADtoADT.xml#14 $";

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:AD" targetClass="EnsLib.HL7.Message" targetDocType="HL7v25IHE:ADT_AXX" create="new" language="objectscript" >
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
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","AD"_source.GetValueAt("AD:AD01Mode")),"MSH:MessageType.TriggerEvent","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","AD"_source.GetValueAt("AD:AD01Mode")),"MSH:MessageType.MessageStructure","set","")]]>
</code>
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value='"2.5"' property="target.{MSH:VersionID}" key="&quot;&quot;" action="set" />
<assign value="&quot;FRA&quot;" property="target.{MSH:CountryCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<assign value="&quot;FR&quot;" property="target.{MSH:PrincipalLanguageOfMessage}" key="&quot;&quot;" action="set" />

<!-- segment EVN -->
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","AD"_source.GetValueAt("AD:AD01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD320DateHeureAdmission}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD331Utilisateur.Username}" property="target.{EVN:OperatorID.IDNumber}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD03IPP}" property="target.{PID:PatientIdentifierList(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : on envoie toujours nom de naissance en L et nom usuel en D pour être conforme IHE PAM -->
<assign value="source.{AD:AD04NomUsuel.Nom}" property="target.{PID:PatientName(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD05Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD211AutresPrenoms}" property="target.{PID:PatientName(1).SecondandFurtherGivenNamesor}" key="&quot;&quot;" action="set" />
<assign value='"D"' property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD06Qualite}" property="target.{PID:PatientName(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD07NomDeNaissance.Nom}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD05Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
<assign value='"L"' property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD06Qualite}" property="target.{PID:PatientName(2).prefix}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : par précaution, dans le cas improbable où le nom de naissance serait vide, on envoie le nom usuel en L aussi -->
<if condition="$L(source.{AD:AD07NomDeNaissance.Nom})">
<false>
<assign value="source.{AD:AD04NomUsuel.Nom}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{AD:AD09DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{AD:AD10Sexe})" property="target.{PID:AdministrativeSex}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD11NoRueAdresse}" property="target.{PID:PatientAddress(1).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{AD:AD12CodePostalAdresse}" property="target.{PID:PatientAddress(1).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD201LocaliteAdresse}" property="target.{PID:PatientAddress(1).city}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD206ComplementAdresse}" property="target.{PID:PatientAddress(1).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD207PaysAdresse}" property="target.{PID:PatientAddress(1).country}" key="&quot;&quot;" action="set" />
<assign value="&quot;H&quot;" property="target.{PID:PatientAddress(1).AddressType}" key="&quot;&quot;" action="set" />

<!-- telephone domicile seulement si valorisé -->
<if condition="$L(source.{AD2:AD202TelephoneDomicile})">
<true>
<assign value="source.{AD2:AD202TelephoneDomicile}" property="target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD202TelephoneDomicile}" property="target.{PID:PhoneNumberHome(nbtel).UnformattedTelephonenumber}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{AD2:AD208TelephoneProfessionnel})">
<true>
<assign value="source.{AD2:AD208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;WPN&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).UnformattedTelephonenumber}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{AD2:AD212TelephonePortable})">
<true>
<assign value="source.{AD2:AD212TelephonePortable}" property="target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;CP&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD212TelephonePortable}" property="target.{PID:PhoneNumberHome(nbtel).UnformattedTelephonenumber}" key="&quot;&quot;" action="set" />
</true>
</if>

<assign value="source.{AD2:AD203Nationalite}" property="target.{PID:Nationality}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD203Nationalite}" property="target.{PID:Citizenship(1)}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD215NumeroSSDernierEpisode}" property="target.{PID:SSNNumberPatient}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD303NumeroEpisode}" property="target.{PID:PatientAccountNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="..Lookup($G(^ISSAS.Config(&quot;LUT&quot;, &quot;CCOM_HL7_MaritalStatus&quot;)),source.{AD3:AD309SituationFamiliale})" property="target.{PID:MaritalStatus.identifier}" key="&quot;&quot;" action="set" />
<assign value='"A"' property="target.{PV1:VisitIndicator}" key="&quot;&quot;" action="set" />

<!-- Identité validée ou provisoire -->
<if condition='source.{AD2:AD214InformationsIdentite.IndicateurIdentiteProvisoire}="1"'>
<true>
<assign value='"PROV"' property="target.{PID:IdentityReliabilityCode(1)}" key="&quot;&quot;" action="set" />
<assign value="&quot;Y&quot;" property="target.{PID:IdentityUnknownIndicator}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{AD2:AD214InformationsIdentite.IndicateurIdentiteValidee}="1"'>
<true>
<assign value='"VALI"' property="target.{PID:IdentityReliabilityCode(1)}" key="&quot;&quot;" action="set" />
<assign value="&quot;N&quot;" property="target.{PID:IdentityUnknownIndicator}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- segment ROL (médecin traitant) -->
<if condition="$L(source.{AD5:AD505MedecinTraitant.CodeClinicom})">
<true>
<assign value='"UP"' property="target.{ROL(1):ActionCode}" key="&quot;&quot;" action="set" />
<assign value='"ODRP"' property="target.{ROL(1):RoleROL}" key="&quot;&quot;" action="set" />
<assign value='source.{AD5:AD505MedecinTraitant.CodeClinicom}' property="target.{ROL(1):RolePerson(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value='source.{AD5:AD505MedecinTraitant.Nom}' property="target.{ROL(1):RolePerson(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='source.{AD5:AD505MedecinTraitant.Prenom}' property="target.{ROL(1):RolePerson(1).GivenName}" key="&quot;&quot;" action="set" />
<assign value='source.{AD5:AD505MedecinTraitant.Qualite}' property="target.{ROL(1):RolePerson(1).Prefix}" key="&quot;&quot;" action="set" />
<assign value='source.{AD5:AD505MedecinTraitant.Titre}' property="target.{ROL(1):RolePerson(1).Degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{ROL(1):RolePerson(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />

<!-- Adresse médecin traitant demandé par Firminy JIRA CCOMTCC-1076, nécessite mise à jour classe ODBC & PAYS_INSEE_3166-1-alpha-3.LUT -->
<assign value='"O"' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).AddressType}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedAdresse(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).StreetAddress}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedComplAd(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).OtherDesignation}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedCP(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).ZiporPostalCode}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedVille(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).City}" key="&quot;&quot;" action="set" />
<assign value='..Lookup("PAYS_INSEE_3166-1-alpha-3",##class(ISSAS.Common.Tools.ClassODBC).MedPays(source.{AD5:AD505MedecinTraitant.CodeClinicom}))' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).Country}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedVille(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property="target.{ROL(1):OfficeHomeAddressBirthplace(1).City}" key="&quot;&quot;" action="set" />
<!-- Téléphone et Email médecin traitant demandé par Pau JIRA CCOMTCC-1296, nécessite mise à jour classe ODBC -->
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedTel1(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property="target.{ROL(1):Phone(1).Telephonenumber}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedTel1(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property="target.{ROL(1):Phone(1).UnformattedTelephonenumber}" key="&quot;&quot;" action="set" />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedEmail(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property="target.{ROL(1):Phone(1).EmailAddress}" key="&quot;&quot;" action="set" />

<!-- N° RPPS -->
<if condition="$L(source.{AD5:AD505MedecinTraitant.NoRPPS})">
<true>
<assign value='source.{AD5:AD505MedecinTraitant.NoRPPS}' property="target.{ROL(1):RolePerson(2).IDNumber}" key="&quot;&quot;" action="set" />
<assign value='source.{AD5:AD505MedecinTraitant.Nom}' property="target.{ROL(1):RolePerson(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='source.{AD5:AD505MedecinTraitant.Prenom}' property="target.{ROL(1):RolePerson(2).GivenName}" key="&quot;&quot;" action="set" />
<assign value='source.{AD5:AD505MedecinTraitant.Qualite}' property="target.{ROL(1):RolePerson(2).Prefix}" key="&quot;&quot;" action="set" />
<assign value='source.{AD5:AD505MedecinTraitant.Titre}' property="target.{ROL(1):RolePerson(2).Degree}" key="&quot;&quot;" action="set" />
<assign value='"RPPS"' property="target.{ROL(1):RolePerson(2).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
</true>
</if>
</true>
</if>

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<if condition='source.{AD3:AD322IndicateurEpisodeRecurr} = "1"'>
<true>
<assign value="&quot;R&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;I&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{AD3:AD303NumeroEpisode}" property="target.{PV1:VisitNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD305CodeUS}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD307Lit}" property="target.{PV1:AssignedPatientLocation.bed}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD308Chambre}" property="target.{PV1:AssignedPatientLocation.room}" key="&quot;&quot;" action="set" />
<assign value='source.{AD3:AD301Hopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.Facility}' action='set' />
<assign value="source.{AD3:AD313ModeEntree}" property="target.{PV1:AdmitSource}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD319MedecinResponsable.CodeClinicom}" property="target.{PV1:AttendingDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD319MedecinResponsable.Nom}" property="target.{PV1:AttendingDoctor(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD319MedecinResponsable.Prenom}" property="target.{PV1:AttendingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD319MedecinResponsable.Qualite}" property="target.{PV1:AttendingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD319MedecinResponsable.Titre}" property="target.{PV1:AttendingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:AttendingDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{AD2:AD209MedecinEnvoyeur.CodeClinicom})">
<true>
<assign value="source.{AD2:AD209MedecinEnvoyeur.CodeClinicom}" property="target.{PV1:AdmittingDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD209MedecinEnvoyeur.Nom}" property="target.{PV1:AdmittingDoctor(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD209MedecinEnvoyeur.Prenom}" property="target.{PV1:AdmittingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD209MedecinEnvoyeur.Qualite}" property="target.{PV1:AdmittingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{AD2:AD209MedecinEnvoyeur.Titre}" property="target.{PV1:AdmittingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:AdmittingDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{AD3:AD320DateHeureAdmission}" property="target.{PV1:AdmitDateTime}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{AD5:AD505MedecinTraitant.CodeClinicom})">
<true>
<assign value="source.{AD5:AD505MedecinTraitant.CodeClinicom}" property="target.{PV1:ReferringDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value="source.{AD5:AD505MedecinTraitant.Nom}" property="target.{PV1:ReferringDoctor(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD5:AD505MedecinTraitant.Prenom}" property="target.{PV1:ReferringDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{AD5:AD505MedecinTraitant.Qualite}" property="target.{PV1:ReferringDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{AD5:AD505MedecinTraitant.Titre}" property="target.{PV1:ReferringDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:ReferringDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{AD3:AD335DateHospitalisationPrec}" property="target.{PV1:DischargedtoLocation.EffectiveDate}" key="&quot;&quot;" action="set" />

<!-- Attention : IHE PAM préconise Y / N , mais certains éditeurs attendent 0, 1 ou 2 --> 
<assign value="source.{AD3:AD316SupplementChambreSeule}" property="target.{PV1:CourtesyCode}" key="&quot;&quot;" action="set" />

<!-- segment PV2 -->
<if condition='$L(source.{AD3:AD332TypePlacementPsy})'>
<true>
<assign value="source.{AD3:AD332TypePlacementPsy}" property="target.{PV2:AdmitReason.Identifier}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='$L(source.{AD3:AD312ModeTransport.Code})'>
<true>
<assign value="source.{AD3:AD312ModeTransport.Code}" property="target.{PV2:ModeofArrivalCode}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- Confidentialité médicale peut prendre les valeurs 0 (normal), 1 (confidentiel) ou 2 (hyperconfidentiel) -->
<if condition='..In(source.{AD2:AD217ConfidentialiteMedicale},"1,2")'>
<true>
<assign value='"Y"' property="target.{PV2:VisitProtectionIndicator}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value='"N"' property="target.{PV2:VisitProtectionIndicator}" key="&quot;&quot;" action="set" />
</false>
</if>

<!-- segment ZBE -->
<assign value="source.{AD2:AD213IdentifiantUniqueDeMouv}" property="target.{ZBE:MovementID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{ZBE:MovementID.NamespaceID}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD320DateHeureAdmission}" property="target.{ZBE:StartMovementDateTime}" key="&quot;&quot;" action="set" />
<if condition='source.{AD:AD01Mode} = "02"'>
<true>
<assign value="&quot;UPDATE&quot;" property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
<assign value="&quot;A01&quot;" property="target.{ZBE:Originaltriggereventcode}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;INSERT&quot;" property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
</false>
</if>
<if condition='source.{AD7:AD711IndicateurDernierMouvem} = "1"'>
<true>
<assign value="&quot;N&quot;" property="target.{ZBE:HistoricalMovementIndicator}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;Y&quot;" property="target.{ZBE:HistoricalMovementIndicator}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{AD3:AD306CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationName}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD306CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationIdentifier}" key="&quot;&quot;" action="set" />
<assign value='"HMS"' property="target.{ZBE:NatureMouvement}" key="&quot;&quot;" action="set" />

<!-- segment ZFM -->
<!-- requete vers CLINICOM : SELECT TXT_COD_ModeEntreeUM FROM ClinicomSQL.Admission_Mode_Entree WHERE ID='?' -->
<assign value="##class(ISSAS.Common.Tools.ClassODBC).ClinicomAdmissionModeEntree(source.{AD3:AD313ModeEntree})" property="target.{ZFM:ModeEntreePMSI}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD314EtablissementOrigine.PropositionMTPMSI}" property="target.{ZFM:ModeprovenancePMSI}" key="&quot;&quot;" action="set" />
<if condition='source.{AD:AD01Mode}="05"'>
<true>
<assign value='"5"' property="target.{ZFM:ModeprovenancePMSI}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- segment ZFP -->
<if condition="$L(source.{AD3:AD311CategorieSocioprofessio})">
<true>
<assign value="source.{AD3:AD311CategorieSocioprofessio}" property="target.{ZFP:Activitesociopro}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- segment ZFV -->
<if condition="$L(source.{AD3:AD314EtablissementOrigine.CodeEtablissement})">
<true>
<!-- requete vers CLINICOM : SELECT TXT_DON_Finess FROM ClinicomSQL.FDB_NOY_EtablissementExterieur WHERE TXT_COD_EtablissementExterieur='?' -->
<assign value="##class(ISSAS.Common.Tools.ClassODBC).ClinicomEtablissementExterieur(source.{AD3:AD314EtablissementOrigine.CodeEtablissement})" property="target.{ZFV:Etbprovenance.DischargeLocation}" key="&quot;&quot;" action="set" />
</true>
</if>

<if condition="$L(source.{AD3:AD334DateHeureDecisionMedica})">
<true>
<assign value="source.{AD3:AD334DateHeureDecisionMedica}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{AD3:AD334DateHeureDecisionMedica}" property="target.{ZBE:StartMovementDateTime}" key="&quot;&quot;" action="set" />
</true>
</if>
</transform>
}

Parameter REPORTERRORS = 1;

}
