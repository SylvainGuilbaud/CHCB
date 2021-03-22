Class ISSAS.Common.DTL.CCOMtoTITAN25.ADtoADT Extends Ens.DataTransformDTL [ DependsOn = EnsLib.HL7.Message ]
{

Parameter IGNOREMISSINGSOURCE = 0;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='Clinicom:AD' targetDocType='HL7v25IHE:ADT_AXX' create='new' language='objectscript' >
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
 Set nbtel=0 ]]></code>
<assign value='$ZCVT(source.{MSH:MSH03SendingApplication},"U")' property='target.{MSH:SendingApplication}' action='set' />
<assign value='$ZCVT(source.{MSH:MSH04SendingFacility},"U")' property='target.{MSH:SendingFacility}' action='set' />
<assign value='$E(strNow, 1, 12)' property='target.{MSH:DateTimeOfMessage}' action='set' />
<assign value='"ADT"' property='target.{MSH:MessageType.MessageCode}' action='set' />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","AD"_source.GetValueAt("AD:AD01Mode")),"MSH:MessageType.TriggerEvent","set","")]]></code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","AD"_source.GetValueAt("AD:AD01Mode")),"MSH:MessageType.MessageStructure","set","")]]></code>
<assign value='strGUID' property='target.{MSH:MessageControlID}' action='set' />
<assign value='"2.5"' property='target.{MSH:VersionID}' action='set' />
<assign value='"FRA"' property='target.{MSH:CountryCode}' action='set' />
<assign value='"8859/1"' property='target.{MSH:CharacterSet}' action='set' />
<assign value='"FR"' property='target.{MSH:PrincipalLanguageOfMessage}' action='set' />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","AD"_source.GetValueAt("AD:AD01Mode")),"EVN:EventTypeCode","set","")]]></code>
<assign value='$E(strNow, 1, 12)' property='target.{EVN:RecordedDateTime}' action='set' />
<assign value='source.{AD3:AD320DateHeureAdmission}' property='target.{EVN:EventOccurred}' action='set' />
<assign value='source.{AD3:AD331Utilisateur.Username}' property='target.{EVN:OperatorID.IDNumber}' action='set' />
<assign value='"1"' property='target.{PID:SetIDPID}' action='set' />
<assign value='strAssigningAuthority' property='target.{PID:PatientIdentifierList(1).assigningauthority}' action='set' />
<assign value='source.{AD:AD03IPP}' property='target.{PID:PatientIdentifierList(1).IDNumber}' action='set' />
<assign value='"PI"' property='target.{PID:PatientIdentifierList(1).IdentifierTypeCode}' action='set' />
<assign value='source.{AD:AD04NomUsuel.Nom}' property='target.{PID:PatientName(1).FamilyName}' action='set' />
<assign value='source.{AD:AD05Prenom}' property='target.{PID:PatientName(1).givenname}' action='set' />
<assign value='source.{AD2:AD211AutresPrenoms}' property='target.{PID:PatientName(1).SecondandFurtherGivenNamesor}' action='set' />
<assign value='"D"' property='target.{PID:PatientName(1).nametypecode}' action='set' />
<assign value='source.{AD:AD06Qualite}' property='target.{PID:PatientName(1).prefix}' action='set' />
<assign value='source.{AD:AD07NomDeNaissance.Nom}' property='target.{PID:PatientName(2).FamilyName}' action='set' />
<assign value='source.{AD:AD05Prenom}' property='target.{PID:PatientName(2).givenname}' action='set' />
<assign value='"L"' property='target.{PID:PatientName(2).nametypecode}' action='set' />
<assign value='source.{AD:AD06Qualite}' property='target.{PID:PatientName(2).prefix}' action='set' />
<if condition='$L(source.{AD:AD07NomDeNaissance.Nom})' >
<false>
<assign value='source.{AD:AD04NomUsuel.Nom}' property='target.{PID:PatientName(2).FamilyName}' action='set' />
</false>
</if>
<assign value='source.{AD:AD09DateDeNaissance}' property='target.{PID:DateTimeOfBirth}' action='set' />
<assign value='..Lookup("CCOM_HL7_Sexe",source.{AD:AD10Sexe})' property='target.{PID:AdministrativeSex}' action='set' />
<assign value='source.{AD:AD11NoRueAdresse}' property='target.{PID:PatientAddress(1).streetaddress}' action='set' />
<assign value='source.{AD:AD12CodePostalAdresse}' property='target.{PID:PatientAddress(1).ziporpostalcode}' action='set' />
<assign value='source.{AD2:AD201LocaliteAdresse}' property='target.{PID:PatientAddress(1).city}' action='set' />
<assign value='source.{AD2:AD206ComplementAdresse}' property='target.{PID:PatientAddress(1).otherdesignation}' action='set' />
<assign value='source.{AD2:AD207PaysAdresse}' property='target.{PID:PatientAddress(1).country}' action='set' />
<assign value='"H"' property='target.{PID:PatientAddress(1).AddressType}' action='set' />
<if condition='$L(source.{AD2:AD202TelephoneDomicile})' >
<true>
<assign value='source.{AD2:AD202TelephoneDomicile}' property='target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}' action='set' />
<assign value='"PRN"' property='target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}' action='set' />
<assign value='"PH"' property='target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}' action='set' />
<assign value='source.{AD2:AD202TelephoneDomicile}' property='target.{PID:PhoneNumberHome(nbtel).UnformattedTelephonenumber}' action='set' />
</true>
</if>
<if condition='$L(source.{AD2:AD208TelephoneProfessionnel})' >
<true>
<assign value='source.{AD2:AD208TelephoneProfessionnel}' property='target.{PID:PhoneNumberBusiness(1).TelephoneNumber}' action='set' />
<assign value='"WPN"' property='target.{PID:PhoneNumberBusiness(1).TelecommunicationUseCode}' action='set' />
<assign value='"PH"' property='target.{PID:PhoneNumberBusiness(1).TelecommunicationEquipmentTy}' action='set' />
<assign value='source.{AD2:AD208TelephoneProfessionnel}' property='target.{PID:PhoneNumberBusiness(1).UnformattedTelephonenumber}' action='set' />
</true>
</if>
<if condition='$L(source.{AD2:AD212TelephonePortable})' >
<true>
<assign value='source.{AD2:AD212TelephonePortable}' property='target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}' action='set' />
<assign value='"PRN"' property='target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}' action='set' />
<assign value='"CP"' property='target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}' action='set' />
<assign value='source.{AD2:AD212TelephonePortable}' property='target.{PID:PhoneNumberHome(nbtel).UnformattedTelephonenumber}' action='set' />
</true>
</if>
<assign value='..Lookup("PAYS_INSEE_3166-1-alpha-3",source.{AD2:AD203Nationalite})' property='target.{PID:Nationality}' action='set' />
<assign value='source.{AD2:AD203Nationalite}' property='target.{PID:Citizenship(1)}' action='set' />
<assign value='source.{AD2:AD215NumeroSSDernierEpisode}' property='target.{PID:SSNNumberPatient}' action='set' />
<assign value='source.{AD3:AD303NumeroEpisode}' property='target.{PID:PatientAccountNumber.IDNumber}' action='set' />
<assign value='strAssigningAuthority' property='target.{PID:PatientAccountNumber.assigningauthority}' action='set' />
<assign value='..Lookup("CCOM_HL7_MaritalStatus",source.{AD3:AD309SituationFamiliale})' property='target.{PID:MaritalStatus.identifier}' action='set' />
<assign value='"A"' property='target.{PV1:VisitIndicator}' action='set' />
<if condition='source.{AD2:AD214InformationsIdentite.IndicateurIdentiteProvisoire}="1"' >
<true>
<assign value='"PROV"' property='target.{PID:IdentityReliabilityCode(1)}' action='set' />
<assign value='"Y"' property='target.{PID:IdentityUnknownIndicator}' action='set' />
</true>
</if>
<if condition='source.{AD2:AD214InformationsIdentite.IndicateurIdentiteValidee}="1"' >
<true>
<assign value='"VALI"' property='target.{PID:IdentityReliabilityCode(1)}' action='set' />
<assign value='"N"' property='target.{PID:IdentityUnknownIndicator}' action='set' />
</true>
</if>
<if condition='$L(source.{AD5:AD505MedecinTraitant.CodeClinicom})' >
<true>
<assign value='"UP"' property='target.{ROL(1):ActionCode}' action='set' />
<assign value='"ODRP"' property='target.{ROL(1):RoleROL}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.CodeClinicom}' property='target.{ROL(1):RolePerson(1).IDNumber}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Nom}' property='target.{ROL(1):RolePerson(1).FamilyName}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Prenom}' property='target.{ROL(1):RolePerson(1).GivenName}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Qualite}' property='target.{ROL(1):RolePerson(1).Prefix}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Titre}' property='target.{ROL(1):RolePerson(1).Degree}' action='set' />
<assign value='"EI"' property='target.{ROL(1):RolePerson(1).IdentifierTypeCode}' action='set' />
<assign value='"O"' property='target.{ROL(1):OfficeHomeAddressBirthplace(1).AddressType}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedAdresse(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property='target.{ROL(1):OfficeHomeAddressBirthplace(1).StreetAddress}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedComplAd(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property='target.{ROL(1):OfficeHomeAddressBirthplace(1).OtherDesignation}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedCP(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property='target.{ROL(1):OfficeHomeAddressBirthplace(1).ZiporPostalCode}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedVille(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property='target.{ROL(1):OfficeHomeAddressBirthplace(1).City}' action='set' />
<assign value='..Lookup("PAYS_INSEE_3166-1-alpha-3",##class(ISSAS.Common.Tools.ClassODBC).MedPays(source.{AD5:AD505MedecinTraitant.CodeClinicom}))' property='target.{ROL(1):OfficeHomeAddressBirthplace(1).Country}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedVille(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property='target.{ROL(1):OfficeHomeAddressBirthplace(1).City}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedTel1(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property='target.{ROL(1):Phone(1).Telephonenumber}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedTel1(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property='target.{ROL(1):Phone(1).UnformattedTelephonenumber}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).MedEmail(source.{AD5:AD505MedecinTraitant.CodeClinicom})' property='target.{ROL(1):Phone(1).EmailAddress}' action='set' />
<if condition='$L(source.{AD5:AD505MedecinTraitant.NoRPPS})' >
<true>
<assign value='source.{AD5:AD505MedecinTraitant.NoRPPS}' property='target.{ROL(1):RolePerson(2).IDNumber}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Nom}' property='target.{ROL(1):RolePerson(2).FamilyName}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Prenom}' property='target.{ROL(1):RolePerson(2).GivenName}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Qualite}' property='target.{ROL(1):RolePerson(2).Prefix}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Titre}' property='target.{ROL(1):RolePerson(2).Degree}' action='set' />
<assign value='"RPPS"' property='target.{ROL(1):RolePerson(2).IdentifierTypeCode}' action='set' />
</true>
</if>
</true>
</if>
<assign value='"1"' property='target.{PV1:SetIDPV1}' action='set' />
<if condition='source.{AD3:AD322IndicateurEpisodeRecurr} = "1"' >
<true>
<assign value='"R"' property='target.{PV1:PatientClass}' action='set' />
</true>
<false>
<assign value='"I"' property='target.{PV1:PatientClass}' action='set' />
</false>
</if>
<assign value='source.{AD3:AD303NumeroEpisode}' property='target.{PV1:VisitNumber.IDNumber}' action='set' />
<assign value='strAssigningAuthority' property='target.{PV1:VisitNumber.assigningauthority}' action='set' />
<assign value='source.{AD3:AD305CodeUS}' property='target.{PV1:AssignedPatientLocation.pointofcare}' action='set' />
<assign value='source.{AD3:AD307Lit}' property='target.{PV1:AssignedPatientLocation.bed}' action='set' />
<assign value='source.{AD3:AD308Chambre}' property='target.{PV1:AssignedPatientLocation.room}' action='set' />
<assign value='source.{AD3:AD301Hopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.Facility}' action='set' />
<assign value='source.{AD3:AD313ModeEntree}' property='target.{PV1:AdmitSource}' action='set' />
<assign value='source.{AD3:AD319MedecinResponsable.CodeClinicom}' property='target.{PV1:AttendingDoctor(1).IDnumber}' action='set' />
<assign value='source.{AD3:AD319MedecinResponsable.Nom}' property='target.{PV1:AttendingDoctor(1).familyname}' action='set' />
<assign value='source.{AD3:AD319MedecinResponsable.Prenom}' property='target.{PV1:AttendingDoctor(1).givenname}' action='set' />
<assign value='source.{AD3:AD319MedecinResponsable.Qualite}' property='target.{PV1:AttendingDoctor(1).prefix}' action='set' />
<assign value='source.{AD3:AD319MedecinResponsable.Titre}' property='target.{PV1:AttendingDoctor(1).degree}' action='set' />
<assign value='"EI"' property='target.{PV1:AttendingDoctor(1).IdentifierTypeCode}' action='set' />
<if condition='$L(source.{AD2:AD209MedecinEnvoyeur.CodeClinicom})' >
<true>
<assign value='source.{AD2:AD209MedecinEnvoyeur.CodeClinicom}' property='target.{PV1:AdmittingDoctor(1).IDnumber}' action='set' />
<assign value='source.{AD2:AD209MedecinEnvoyeur.Nom}' property='target.{PV1:AdmittingDoctor(1).familyname}' action='set' />
<assign value='source.{AD2:AD209MedecinEnvoyeur.Prenom}' property='target.{PV1:AdmittingDoctor(1).givenname}' action='set' />
<assign value='source.{AD2:AD209MedecinEnvoyeur.Qualite}' property='target.{PV1:AdmittingDoctor(1).prefix}' action='set' />
<assign value='source.{AD2:AD209MedecinEnvoyeur.Titre}' property='target.{PV1:AdmittingDoctor(1).degree}' action='set' />
<assign value='"EI"' property='target.{PV1:AdmittingDoctor(1).IdentifierTypeCode}' action='set' />
</true>
</if>
<assign value='source.{AD3:AD320DateHeureAdmission}' property='target.{PV1:AdmitDateTime}' action='set' />
<if condition='$L(source.{AD5:AD505MedecinTraitant.CodeClinicom})' >
<true>
<assign value='source.{AD5:AD505MedecinTraitant.CodeClinicom}' property='target.{PV1:ReferringDoctor(1).IDnumber}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Nom}' property='target.{PV1:ReferringDoctor(1).familyname}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Prenom}' property='target.{PV1:ReferringDoctor(1).givenname}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Qualite}' property='target.{PV1:ReferringDoctor(1).prefix}' action='set' />
<assign value='source.{AD5:AD505MedecinTraitant.Titre}' property='target.{PV1:ReferringDoctor(1).degree}' action='set' />
<assign value='"EI"' property='target.{PV1:ReferringDoctor(1).IdentifierTypeCode}' action='set' />
</true>
</if>
<assign value='source.{AD3:AD335DateHospitalisationPrec}' property='target.{PV1:DischargedtoLocation.EffectiveDate}' action='set' />
<assign value='source.{AD3:AD316SupplementChambreSeule}' property='target.{PV1:CourtesyCode}' action='set' />
<if condition='$L(source.{AD3:AD332TypePlacementPsy})' >
<true>
<assign value='source.{AD3:AD332TypePlacementPsy}' property='target.{PV2:AdmitReason.Identifier}' action='set' />
</true>
</if>
<if condition='$L(source.{AD3:AD312ModeTransport.Code})' >
<true>
<assign value='source.{AD3:AD312ModeTransport.Code}' property='target.{PV2:ModeofArrivalCode}' action='set' />
</true>
</if>
<if condition='..In(source.{AD2:AD217ConfidentialiteMedicale},"1,2")' >
<true>
<assign value='"Y"' property='target.{PV2:VisitProtectionIndicator}' action='set' />
</true>
<false>
<assign value='"N"' property='target.{PV2:VisitProtectionIndicator}' action='set' />
</false>
</if>
<assign value='source.{AD2:AD213IdentifiantUniqueDeMouv}' property='target.{ZBE:MovementID}' action='set' />
<assign value='strAssigningAuthority' property='target.{ZBE:MovementID.NamespaceID}' action='set' />
<assign value='source.{AD3:AD320DateHeureAdmission}' property='target.{ZBE:StartMovementDateTime}' action='set' />
<if condition='source.{AD:AD01Mode} = "02"' >
<true>
<assign value='"UPDATE"' property='target.{ZBE:MovementAction}' action='set' />
<assign value='"A01"' property='target.{ZBE:Originaltriggereventcode}' action='set' />
</true>
<false>
<assign value='"INSERT"' property='target.{ZBE:MovementAction}' action='set' />
</false>
</if>
<if condition='source.{AD7:AD711IndicateurDernierMouvem} = "1"' >
<true>
<assign value='"N"' property='target.{ZBE:HistoricalMovementIndicator}' action='set' />
</true>
<false>
<assign value='"Y"' property='target.{ZBE:HistoricalMovementIndicator}' action='set' />
</false>
</if>
<assign value='source.{AD3:AD306CodeUF}' property='target.{ZBE:ResponsibleWard.OrganizationName}' action='set' />
<assign value='source.{AD3:AD306CodeUF}' property='target.{ZBE:ResponsibleWard.OrganizationIdentifier}' action='set' />
<assign value='"HMS"' property='target.{ZBE:NatureMouvement}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).ClinicomAdmissionModeEntree(source.{AD3:AD313ModeEntree})' property='target.{ZFM:ModeEntreePMSI}' action='set' />
<assign value='source.{AD3:AD314EtablissementOrigine.PropositionMTPMSI}' property='target.{ZFM:ModeprovenancePMSI}' action='set' />
<if condition='source.{AD:AD01Mode}="05"' >
<true>
<assign value='"5"' property='target.{ZFM:ModeprovenancePMSI}' action='set' />
</true>
</if>
<if condition='$L(source.{AD3:AD311CategorieSocioprofessio})' >
<true>
<assign value='source.{AD3:AD311CategorieSocioprofessio}' property='target.{ZFP:Activitesociopro}' action='set' />
</true>
</if>
<if condition='$L(source.{AD3:AD314EtablissementOrigine.CodeEtablissement})' >
<true>
<assign value='##class(ISSAS.Common.Tools.ClassODBC).ClinicomEtablissementExterieur(source.{AD3:AD314EtablissementOrigine.CodeEtablissement})' property='target.{ZFV:Etbprovenance.DischargeLocation}' action='set' />
</true>
</if>
<if condition='$L(source.{AD3:AD334DateHeureDecisionMedica})' >
<true>
<assign value='source.{AD3:AD334DateHeureDecisionMedica}' property='target.{EVN:EventOccurred}' action='set' />
<assign value='source.{AD3:AD334DateHeureDecisionMedica}' property='target.{ZBE:StartMovementDateTime}' action='set' />
</true>
</if>
</transform>
}

}
