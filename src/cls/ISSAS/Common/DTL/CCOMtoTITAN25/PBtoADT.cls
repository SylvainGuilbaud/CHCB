Class ISSAS.Common.DTL.CCOMtoTITAN25.PBtoADT Extends Ens.DataTransformDTL [ DependsOn = EnsLib.HL7.Message ]
{

Parameter IGNOREMISSINGSOURCE = 0;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='Clinicom:PB' targetDocType='HL7v25IHE:ADT_AXX' create='new' language='objectscript' >
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
 Set nbtel=0
 Set nbadd=0 ]]></code>
<assign value='$ZCVT(source.{MSH:MSH03SendingApplication},"U")' property='target.{MSH:SendingApplication}' action='set' />
<assign value='$ZCVT(source.{MSH:MSH04SendingFacility},"U")' property='target.{MSH:SendingFacility}' action='set' />
<assign value='$E(strNow, 1, 12)' property='target.{MSH:DateTimeOfMessage}' action='set' />
<assign value='"ADT"' property='target.{MSH:MessageType.MessageCode}' action='set' />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","PB"_source.GetValueAt("PB:PB01Mode")),"MSH:MessageType.TriggerEvent","set","")]]></code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","PB"_source.GetValueAt("PB:PB01Mode")),"MSH:MessageType.MessageStructure","set","")]]></code>
<assign value='strGUID' property='target.{MSH:MessageControlID}' action='set' />
<assign value='"2.5"' property='target.{MSH:VersionID}' action='set' />
<assign value='"FRA"' property='target.{MSH:CountryCode}' action='set' />
<assign value='"8859/1"' property='target.{MSH:CharacterSet}' action='set' />
<assign value='"FR"' property='target.{MSH:PrincipalLanguageOfMessage}' action='set' />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","PB"_source.GetValueAt("PB:PB01Mode")),"EVN:EventTypeCode","set","")]]></code>
<assign value='$E(strNow, 1, 12)' property='target.{EVN:RecordedDateTime}' action='set' />
<assign value='$E(strNow, 1, 12)' property='target.{EVN:EventOccurred}' action='set' />
<assign value='source.{PB2:PB218Utilisateur.Username}' property='target.{EVN:OperatorID.IDNumber}' action='set' />
<assign value='"1"' property='target.{PID:SetIDPID}' action='set' />
<assign value='source.{PB:PB03IPP}' property='target.{PID:PatientIdentifierList(1).IDNumber}' action='set' />
<assign value='strAssigningAuthority' property='target.{PID:PatientIdentifierList(1).assigningauthority}' action='set' />
<assign value='"PI"' property='target.{PID:PatientIdentifierList(1).IdentifierTypeCode}' action='set' />
<if condition='$L(source.{PB2:PB220IdentifiantNational.Valeur})'  expanded='false' >
<true>
<assign value='source.{PB2:PB220IdentifiantNational.Valeur}' property='target.{PID:PatientIdentifierList(2).IDNumber}' action='set' />
<assign value='"1.2.250.1.213.1.4.2"' property='target.{PID:PatientIdentifierList(2).assigningauthority}' action='set' />
<assign value='"INS-C"' property='target.{PID:PatientIdentifierList(2).IdentifierTypeCode}' action='set' />
<assign value='"ASIP"' property='target.{PID:PatientIdentifierList(2).AssigningFacility}' action='set' />
<assign value='$E(source.{PB2:PB220IdentifiantNational.DateObtention},1,8)' property='target.{PID:PatientIdentifierList(2).EffectiveDate}' action='set' />
</true>
</if>
<assign value='source.{PB:PB04NomUsuel}' property='target.{PID:PatientName(1).FamilyName}' action='set' />
<assign value='"D"' property='target.{PID:PatientName(1).nametypecode}' action='set' />
<assign value='source.{PB:PB05Prenom}' property='target.{PID:PatientName(1).givenname}' action='set' />
<assign value='source.{PB2:PB213AutresPrenoms}' property='target.{PID:PatientName(1).SecondandFurtherGivenNamesor}' action='set' />
<assign value='source.{PB:PB06Qualite}' property='target.{PID:PatientName(1).prefix}' action='set' />
<assign value='source.{PB:PB07NomDeNaissance}' property='target.{PID:PatientName(2).FamilyName}' action='set' />
<assign value='"L"' property='target.{PID:PatientName(2).nametypecode}' action='set' />
<assign value='source.{PB:PB05Prenom}' property='target.{PID:PatientName(2).givenname}' action='set' />
<assign value='source.{PB:PB06Qualite}' property='target.{PID:PatientName(2).prefix}' action='set' />
<if condition='$L(source.{PB:PB07NomDeNaissance})'  expanded='false' >
<false>
<assign value='source.{PB:PB04NomUsuel}' property='target.{PID:PatientName(2).FamilyName}' action='set' />
</false>
</if>
<assign value='source.{PB:PB09DateDeNaissance}' property='target.{PID:DateTimeOfBirth}' action='set' />
<assign value='..Lookup("CCOM_HL7_Sexe",source.{PB:PB10Sexe})' property='target.{PID:AdministrativeSex}' action='set' />
<assign value='source.{PB:PB11NoRueAdresse}' property='target.{PID:PatientAddress($I(nbadd)).streetaddress}' action='set' />
<assign value='source.{PB:PB12CodePostalAdresse}' property='target.{PID:PatientAddress(nbadd).ziporpostalcode}' action='set' />
<assign value='source.{PB2:PB201LocaliteAdresse}' property='target.{PID:PatientAddress(nbadd).city}' action='set' />
<assign value='source.{PB2:PB206ComplementAdresse}' property='target.{PID:PatientAddress(nbadd).otherdesignation}' action='set' />
<assign value='source.{PB2:PB207PaysAdresse}' property='target.{PID:PatientAddress(nbadd).country}' action='set' />
<assign value='"H"' property='target.{PID:PatientAddress(nbadd).AddressType}' action='set' />
<if condition='$L(source.{PB2:PB202TelephoneDomicile})'  expanded='false' >
<true>
<assign value='source.{PB2:PB202TelephoneDomicile}' property='target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}' action='set' />
<assign value='"PRN"' property='target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}' action='set' />
<assign value='"PH"' property='target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}' action='set' />
<assign value='source.{PB2:PB202TelephoneDomicile}' property='target.{PID:PhoneNumberHome(nbtel).UnformattedTelephoneNumber}' action='set' />
</true>
</if>
<if condition='$L(source.{PB2:PB208TelephoneProfessionnel})'  expanded='false' >
<true>
<assign value='source.{PB2:PB208TelephoneProfessionnel}' property='target.{PID:PhoneNumberBusiness(1).TelephoneNumber}' action='set' />
<assign value='"WPN"' property='target.{PID:PhoneNumberBusiness(1).TelecommunicationUseCode}' action='set' />
<assign value='"PH"' property='target.{PID:PhoneNumberBusiness(1).TelecommunicationEquipmentTy}' action='set' />
<assign value='source.{PB2:PB208TelephoneProfessionnel}' property='target.{PID:PhoneNumberBusiness(1).UnformattedTelephoneNumber}' action='set' />
</true>
</if>
<if condition='$L(source.{PB2:PB217TelephonePortable})'  expanded='false' >
<true>
<assign value='source.{PB2:PB217TelephonePortable}' property='target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}' action='set' />
<assign value='"PRN"' property='target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}' action='set' />
<assign value='"CP"' property='target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}' action='set' />
<assign value='source.{PB2:PB217TelephonePortable}' property='target.{PID:PhoneNumberHome(nbtel).UnformattedTelephoneNumber}' action='set' />
</true>
</if>
<if condition='$L(source.{PB2:PB223Email})'  expanded='false' >
<true>
<assign value='source.{PB2:PB223Email}' property='target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}' action='set' />
<assign value='"NET"' property='target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}' action='set' />
<assign value='"Internet"' property='target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}' action='set' />
<assign value='source.{PB2:PB223Email}' property='target.{PID:PhoneNumberHome(nbtel).EmailAddress}' action='set' />
</true>
</if>
<assign value='..Lookup("PAYS_INSEE_3166-1-alpha-3",source.{PB2:PB203Nationalite})' property='target.{PID:Nationality}' action='set' />
<assign value='source.{PB2:PB203Nationalite}' property='target.{PID:Citizenship(1)}' action='set' />
<assign value='..Lookup("CCOM_HL7_MaritalStatus",source.{PB2:PB210SituationFamiliale})' property='target.{PID:MaritalStatus.identifier}' action='set' />
<assign value='source.{PB2:PB209DateDeDeces}' property='target.{PID:PatientDeathDateandTime}' action='set' />
<if condition='$L(source.{PB2:PB209DateDeDeces})'  expanded='false' >
<true>
<assign value='"Y"' property='target.{PID:PatientDeathIndicator}' action='set' />
</true>
<false>
<assign value='"N"' property='target.{PID:PatientDeathIndicator}' action='set' />
</false>
</if>
<if condition='source.{PB2:PB215InformationsIdentite.IndicateurIdentiteProvisoire}="1"'  expanded='false' >
<true>
<assign value='"PROV"' property='target.{PID:IdentityReliabilityCode(1)}' action='set' />
<assign value='"Y"' property='target.{PID:IdentityUnknownIndicator}' action='set' />
</true>
</if>
<if condition='source.{PB2:PB215InformationsIdentite.IndicateurIdentiteValidee}="1"'  expanded='false' >
<true>
<assign value='"VALI"' property='target.{PID:IdentityReliabilityCode(1)}' action='set' />
<assign value='"N"' property='target.{PID:IdentityUnknownIndicator}' action='set' />
</true>
</if>
<if condition='$L(source.{PB2:PB212DernierNumeroEpisode})'  expanded='false' >
<true>
<assign value='source.{PB2:PB212DernierNumeroEpisode}' property='target.{PID:PatientAccountNumber.IDNumber}' action='set' />
<assign value='strAssigningAuthority' property='target.{PID:PatientAccountNumber.assigningauthority}' action='set' />
</true>
</if>
<assign value='source.{PB2:PB221RangGemellaire}' property='target.{PID:BirthOrder}' action='set' />
<if condition='$L(source.{PB:PB08LocaliteDeNaissance}) || $L(source.{PB2:PB204PaysDeNaissance})'  expanded='false' >
<true>
<assign value='source.{PB2:PB205DepartementDeNaissance}' property='target.{PID:PatientAddress($I(nbadd)).ziporpostalcode}' action='set' />
<assign value='source.{PB:PB08LocaliteDeNaissance}' property='target.{PID:PatientAddress(nbadd).city}' action='set' />
<assign value='source.{PB2:PB204PaysDeNaissance}' property='target.{PID:PatientAddress(nbadd).country}' action='set' />
<assign value='"BDL"' property='target.{PID:PatientAddress(nbadd).AddressType}' action='set' />
</true>
</if>
<if condition='$L(source.{PB2:PB226AdresseProvisoire.Ville})'  expanded='false' >
<true>
<assign value='source.{PB2:PB226AdresseProvisoire.NumRue}' property='target.{PID:PatientAddress($I(nbadd)).streetaddress}' action='set' />
<assign value='source.{PB2:PB226AdresseProvisoire.CodePostal}' property='target.{PID:PatientAddress(nbadd).ziporpostalcode}' action='set' />
<assign value='source.{PB2:PB226AdresseProvisoire.Ville}' property='target.{PID:PatientAddress(nbadd).city}' action='set' />
<assign value='source.{PB2:PB226AdresseProvisoire.Pays}' property='target.{PID:PatientAddress(nbadd).country}' action='set' />
<assign value='"C"' property='target.{PID:PatientAddress(nbadd).AddressType}' action='set' />
</true>
</if>
<foreach property='source.{PB4()}' key='kPaP'  expanded='false' >
<code>
<![CDATA[ Set occTel=0 ]]></code>
<assign value='kPaP' property='target.{NK1(kPaP):SetIDNK1}' action='set' />
<assign value='source.{PB4(kPaP):PB402NomUsuel}' property='target.{NK1(kPaP):Name(1).familyname}' action='set' />
<assign value='"D"' property='target.{NK1(kPaP):Name(1).nametypecode}' action='set' />
<assign value='source.{PB4(kPaP):PB403Prenom}' property='target.{NK1(kPaP):Name(1).givenname}' action='set' />
<assign value='source.{PB4(kPaP):PB416Civilite}' property='target.{NK1(kPaP):Name(1).Prefix}' action='set' />
<assign value='..Lookup("CCOM_HL7_RelationShip",source.{PB4(kPaP):PB404LienDeParente.Code},"UNK")' property='target.{NK1(kPaP):Relationship}' action='set' />
<assign value='source.{PB4(kPaP):PB405NoRue}' property='target.{NK1(kPaP):Address(1).streetaddress}' action='set' />
<assign value='source.{PB4(kPaP):PB406ComplementAdresse}' property='target.{NK1(kPaP):Address(1).otherdesignation}' action='set' />
<assign value='source.{PB4(kPaP):PB407Pays}' property='target.{NK1(kPaP):Address(1).country}' action='set' />
<assign value='source.{PB4(kPaP):PB408CodePostal}' property='target.{NK1(kPaP):Address(1).ziporpostalcode}' action='set' />
<assign value='source.{PB4(kPaP):PB409Localite}' property='target.{NK1(kPaP):Address(1).city}' action='set' />
<if condition='$L(source.{PB4(kPaP):PB410TelephoneDomicile})'  expanded='false' >
<true>
<assign value='source.{PB4(kPaP):PB410TelephoneDomicile}' property='target.{NK1(kPaP):PhoneNumber($I(occTel)).Telephonenumber}' action='set' />
<assign value='"PRN"' property='target.{NK1(kPaP):PhoneNumber(occTel).TelecommunicationUseCode}' action='set' />
<assign value='"PH"' property='target.{NK1(kPaP):PhoneNumber(occTel).TelecommunicationEquipmentTy}' action='set' />
<assign value='source.{PB4(kPaP):PB410TelephoneDomicile}' property='target.{NK1(kPaP):PhoneNumber(occTel).UnformattedTelephonenumber}' action='set' />
</true>
</if>
<if condition='$L(source.{PB4(kPaP):PB411TelephoneProfessionnel})'  expanded='false' >
<true>
<assign value='source.{PB4(kPaP):PB411TelephoneProfessionnel}' property='target.{NK1(kPaP):BusinessPhoneNumber(1).Telephonenumber}' action='set' />
<assign value='"WPN"' property='target.{NK1(kPaP):BusinessPhoneNumber(1).TelecommunicationUseCode}' action='set' />
<assign value='"PH"' property='target.{NK1(kPaP):BusinessPhoneNumber(1).TelecommunicationEquipmentTy}' action='set' />
<assign value='source.{PB4(kPaP):PB411TelephoneProfessionnel}' property='target.{NK1(kPaP):BusinessPhoneNumber(1).UnformattedTelephonenumber}' action='set' />
</true>
</if>
<if condition='$L(source.{PB4(kPaP):PB413TelephoneMobile})'  expanded='false' >
<true>
<assign value='source.{PB4(kPaP):PB413TelephoneMobile}' property='target.{NK1(kPaP):PhoneNumber($I(occTel)).Telephonenumber}' action='set' />
<assign value='"PRN"' property='target.{NK1(kPaP):PhoneNumber(occTel).TelecommunicationUseCode}' action='set' />
<assign value='"CP"' property='target.{NK1(kPaP):PhoneNumber(occTel).TelecommunicationEquipmentTy}' action='set' />
<assign value='source.{PB4(kPaP):PB413TelephoneMobile}' property='target.{NK1(kPaP):PhoneNumber(occTel).UnformattedTelephonenumber}' action='set' />
</true>
</if>
<assign value='"C"' property='target.{NK1(kPaP):ContactRole}' action='set' />
<assign value='source.{PB4(kPaP):PB414IdentifiantUnique}' property='target.{NK1(kPaP):NextofKinAssociatedPartysIde(1).IDNumber}' action='set' />
<assign value='"CLINICOM"' property='target.{NK1(kPaP):NextofKinAssociatedPartysIde(1).AssigningAuthority}' action='set' />
<assign value='"PN"' property='target.{NK1(kPaP):NextofKinAssociatedPartysIde(1).IdentifierTypeCode}' action='set' />
<assign value='source.{PB4(kPaP):PB415DateDeSuppression}' property='target.{NK1(kPaP):EndDate}' action='set' />
</foreach>
<foreach property='source.{PB5()}' key='kPSY'  expanded='false' >
<assign value='kPSY' property='target.{ZFS(kPSY):SetIDZFS}' action='set' />
<assign value='..Lookup("CCOM_HL7_MovementAction",source.{PB5(kPSY):PB502Action})' property='target.{ZFS(kPSY):Action}' action='set' />
<assign value='source.{PB5(kPSY):PB503IdentifiantUnique}' property='target.{ZFS(kPSY):Identifiant.EntityIdentifier}' action='set' />
<assign value='strAssigningAuthority' property='target.{ZFS(kPSY):Identifiant.NamespaceID}' action='set' />
<assign value='source.{PB5(kPSY):PB504DateHeureDeDebut}' property='target.{ZFS(kPSY):DateHeureDebutModeLegal.Time}' action='set' />
<assign value='source.{PB5(kPSY):PB505DateHeureDeFin}' property='target.{ZFS(kPSY):DateHeureFinModeLegal.Time}' action='set' />
<assign value='source.{PB5(kPSY):PB506ModeLegalDeSoin.Code}' property='target.{ZFS(kPSY):ModeLegal.Identifier}' action='set' />
<assign value='source.{PB5(kPSY):PB507Commentaire}' property='target.{ZFS(kPSY):Commentaires}' action='set' />
<assign value='source.{PB5(kPSY):PB508CodeRIMPDuModeLegal.Code}' property='target.{ZFS(kPSY):CodeRIMPPModeLegal.Identifier}' action='set' />
</foreach>
<assign value='"1"' property='target.{PV1:SetIDPV1}' action='set' />
<assign value='"N"' property='target.{PV1:PatientClass}' action='set' />
<if condition='$L(source.{PB2:PB225Profession.CategorieSocioProf})' >
<true>
<assign value='source.{PB2:PB225Profession.CategorieSocioProf}' property='target.{ZFP:Categoriesociopro}' action='set' />
</true>
</if>
</transform>
}

}
