Class ISSAS.Common.DTL.CCOMtoHL7v25.PBtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v25/PBtoADT.xml#16 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:PB" targetClass="EnsLib.HL7.Message" targetDocType="HL7v25IHE:ADT_AXX" create="new" language="objectscript" >
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
 Set nbadd=0 ]]>
</code>

<!-- segment MSH -->
<assign value="$ZCVT(source.{MSH:MSH03SendingApplication},&quot;U&quot;)" property="target.{MSH:SendingApplication}" key="&quot;&quot;" action="set" />
<assign value="$ZCVT(source.{MSH:MSH04SendingFacility},&quot;U&quot;)" property="target.{MSH:SendingFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MSH:DateTimeOfMessage}" key="&quot;&quot;" action="set" />
<assign value="&quot;ADT&quot;" property="target.{MSH:MessageType.MessageCode}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","PB"_source.GetValueAt("PB:PB01Mode")),"MSH:MessageType.TriggerEvent","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","PB"_source.GetValueAt("PB:PB01Mode")),"MSH:MessageType.MessageStructure","set","")]]>
</code>
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value='"2.5"' property="target.{MSH:VersionID}" key="&quot;&quot;" action="set" />
<assign value="&quot;FRA&quot;" property="target.{MSH:CountryCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<assign value="&quot;FR&quot;" property="target.{MSH:PrincipalLanguageOfMessage}" key="&quot;&quot;" action="set" />

<!-- segment EVN -->
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","PB"_source.GetValueAt("PB:PB01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB218Utilisateur.Username}" property="target.{EVN:OperatorID.IDNumber}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB03IPP}" property="target.{PID:PatientIdentifierList(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{PB2:PB220IdentifiantNational.Valeur})">
<true>
<assign value="source.{PB2:PB220IdentifiantNational.Valeur}" property="target.{PID:PatientIdentifierList(2).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;1.2.250.1.213.1.4.2&quot;" property="target.{PID:PatientIdentifierList(2).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="&quot;INS-C&quot;" property="target.{PID:PatientIdentifierList(2).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;ASIP&quot;" property="target.{PID:PatientIdentifierList(2).AssigningFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(source.{PB2:PB220IdentifiantNational.DateObtention},1,8)" property="target.{PID:PatientIdentifierList(2).EffectiveDate}" key="&quot;&quot;" action="set" />
</true>
</if>
<!-- CCOMTCC-1369 : on envoie toujours nom de naissance en L et nom usuel en D pour être conforme IHE PAM -->
<assign value="source.{PB:PB04NomUsuel}" property="target.{PID:PatientName(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='"D"' property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB05Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB213AutresPrenoms}" property="target.{PID:PatientName(1).SecondandFurtherGivenNamesor}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB06Qualite}" property="target.{PID:PatientName(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB07NomDeNaissance}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='"L"' property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB05Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB06Qualite}" property="target.{PID:PatientName(2).prefix}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : par précaution, dans le cas improbable où le nom de naissance serait vide, on envoie le nom usuel en L aussi -->
<if condition="$L(source.{PB:PB07NomDeNaissance})">
<false>
<assign value="source.{PB:PB04NomUsuel}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
</false>
</if>

<assign value="source.{PB:PB09DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{PB:PB10Sexe})" property="target.{PID:AdministrativeSex}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB11NoRueAdresse}" property="target.{PID:PatientAddress($I(nbadd)).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB12CodePostalAdresse}" property="target.{PID:PatientAddress(nbadd).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB201LocaliteAdresse}" property="target.{PID:PatientAddress(nbadd).city}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB206ComplementAdresse}" property="target.{PID:PatientAddress(nbadd).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB207PaysAdresse}" property="target.{PID:PatientAddress(nbadd).country}" key="&quot;&quot;" action="set" />
<assign value="&quot;H&quot;" property="target.{PID:PatientAddress(nbadd).AddressType}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{PB2:PB202TelephoneDomicile})">
<true>
<assign value="source.{PB2:PB202TelephoneDomicile}" property="target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB202TelephoneDomicile}" property="target.{PID:PhoneNumberHome(nbtel).UnformattedTelephoneNumber}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{PB2:PB208TelephoneProfessionnel})">
<true>
<assign value="source.{PB2:PB208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;WPN&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).UnformattedTelephoneNumber}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{PB2:PB217TelephonePortable})">
<true>
<assign value="source.{PB2:PB217TelephonePortable}" property="target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;CP&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB217TelephonePortable}" property="target.{PID:PhoneNumberHome(nbtel).UnformattedTelephoneNumber}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{PB2:PB223Email})">
<true>
<assign value="source.{PB2:PB223Email}" property="target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;NET&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;Internet&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB223Email}" property="target.{PID:PhoneNumberHome(nbtel).EmailAddress}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{PB2:PB203Nationalite}" property="target.{PID:Nationality}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB203Nationalite}" property="target.{PID:Citizenship(1)}" key="&quot;&quot;" action="set" />
<assign value="..Lookup($G(^ISSAS.Config(&quot;LUT&quot;,&quot;CCOM_HL7_MaritalStatus&quot;)),source.{PB2:PB210SituationFamiliale})" property="target.{PID:MaritalStatus.identifier}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB209DateDeDeces}" property="target.{PID:PatientDeathDateandTime}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{PB2:PB209DateDeDeces})">
<true>
<assign value="&quot;Y&quot;" property="target.{PID:PatientDeathIndicator}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;N&quot;" property="target.{PID:PatientDeathIndicator}" key="&quot;&quot;" action="set" />
</false>
</if>
<!-- Identité validée ou provisoire -->
<if condition='source.{PB2:PB215InformationsIdentite.IndicateurIdentiteProvisoire}="1"'>
<true>
<assign value='"PROV"' property="target.{PID:IdentityReliabilityCode(1)}" key="&quot;&quot;" action="set" />
<assign value="&quot;Y&quot;" property="target.{PID:IdentityUnknownIndicator}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='source.{PB2:PB215InformationsIdentite.IndicateurIdentiteValidee}="1"'>
<true>
<assign value='"VALI"' property="target.{PID:IdentityReliabilityCode(1)}" key="&quot;&quot;" action="set" />
<assign value="&quot;N&quot;" property="target.{PID:IdentityUnknownIndicator}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition='$L(source.{PB2:PB212DernierNumeroEpisode})'>
<true>
<assign value="source.{PB2:PB212DernierNumeroEpisode}" property="target.{PID:PatientAccountNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{PB2:PB221RangGemellaire}" property="target.{PID:BirthOrder}" key="&quot;&quot;" action="set" />
<!-- lieu de naissance -->
<if condition='$L(source.{PB:PB08LocaliteDeNaissance}) || $L(source.{PB2:PB204PaysDeNaissance})'>
<true>
<assign value="source.{PB2:PB205DepartementDeNaissance}" property="target.{PID:PatientAddress($I(nbadd)).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB08LocaliteDeNaissance}" property="target.{PID:PatientAddress(nbadd).city}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB204PaysDeNaissance}" property="target.{PID:PatientAddress(nbadd).country}" key="&quot;&quot;" action="set" />
<assign value="&quot;BDL&quot;" property="target.{PID:PatientAddress(nbadd).AddressType}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- adresse temporaire -->
<if condition='$L(source.{PB2:PB226AdresseProvisoire.Ville})'>
<true>
<assign value="source.{PB2:PB226AdresseProvisoire.NumRue}" property="target.{PID:PatientAddress($I(nbadd)).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB226AdresseProvisoire.CodePostal}" property="target.{PID:PatientAddress(nbadd).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB226AdresseProvisoire.Ville}" property="target.{PID:PatientAddress(nbadd).city}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB226AdresseProvisoire.Pays}" property="target.{PID:PatientAddress(nbadd).country}" key="&quot;&quot;" action="set" />
<assign value="&quot;C&quot;" property="target.{PID:PatientAddress(nbadd).AddressType}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- segment(s) NK1 -->
<foreach key="kPaP" property="source.{PB4()}">
<code>
<![CDATA[ Set occTel=0 ]]>
</code>
<assign value="kPaP" property="target.{NK1(kPaP):SetIDNK1}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB402NomUsuel}" property="target.{NK1(kPaP):Name(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="&quot;D&quot;" property="target.{NK1(kPaP):Name(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB403Prenom}" property="target.{NK1(kPaP):Name(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB416Civilite}" property="target.{NK1(kPaP):Name(1).Prefix}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_RelationShip&quot;,source.{PB4(kPaP):PB404LienDeParente.Code},&quot;UNK&quot;)" property="target.{NK1(kPaP):Relationship}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB405NoRue}" property="target.{NK1(kPaP):Address(1).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB406ComplementAdresse}" property="target.{NK1(kPaP):Address(1).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB407Pays}" property="target.{NK1(kPaP):Address(1).country}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB408CodePostal}" property="target.{NK1(kPaP):Address(1).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB409Localite}" property="target.{NK1(kPaP):Address(1).city}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{PB4(kPaP):PB410TelephoneDomicile})">
<true>
<assign value="source.{PB4(kPaP):PB410TelephoneDomicile}" property="target.{NK1(kPaP):PhoneNumber($I(occTel)).Telephonenumber}" key="&quot;&quot;" action="set" />
<assign value='"PRN"' property="target.{NK1(kPaP):PhoneNumber(occTel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value='"PH"' property="target.{NK1(kPaP):PhoneNumber(occTel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB410TelephoneDomicile}" property="target.{NK1(kPaP):PhoneNumber(occTel).UnformattedTelephonenumber}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{PB4(kPaP):PB411TelephoneProfessionnel})">
<true>
<assign value="source.{PB4(kPaP):PB411TelephoneProfessionnel}" property="target.{NK1(kPaP):BusinessPhoneNumber(1).Telephonenumber}" key="&quot;&quot;" action="set" />
<assign value='"WPN"' property="target.{NK1(kPaP):BusinessPhoneNumber(1).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value='"PH"' property="target.{NK1(kPaP):BusinessPhoneNumber(1).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB411TelephoneProfessionnel}" property="target.{NK1(kPaP):BusinessPhoneNumber(1).UnformattedTelephonenumber}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{PB4(kPaP):PB413TelephoneMobile})">
<true>
<assign value="source.{PB4(kPaP):PB413TelephoneMobile}" property="target.{NK1(kPaP):PhoneNumber($I(occTel)).Telephonenumber}" key="&quot;&quot;" action="set" />
<assign value='"PRN"' property="target.{NK1(kPaP):PhoneNumber(occTel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value='"CP"' property="target.{NK1(kPaP):PhoneNumber(occTel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB413TelephoneMobile}" property="target.{NK1(kPaP):PhoneNumber(occTel).UnformattedTelephonenumber}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value='"C"' property="target.{NK1(kPaP):ContactRole}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB414IdentifiantUnique}" property="target.{NK1(kPaP):NextofKinAssociatedPartysIde(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value='"CLINICOM"' property="target.{NK1(kPaP):NextofKinAssociatedPartysIde(1).AssigningAuthority}" key="&quot;&quot;" action="set" />
<assign value='"PN"' property="target.{NK1(kPaP):NextofKinAssociatedPartysIde(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB415DateDeSuppression}" property="target.{NK1(kPaP):EndDate}" key="&quot;&quot;" action="set" />
</foreach>

<!-- segment(s) ZFS (placements psy) -->
<foreach key="kPSY" property="source.{PB5()}">
<assign value="kPSY" property="target.{ZFS(kPSY):SetIDZFS}" key="&quot;&quot;" action="set" />
<assign value='..Lookup("CCOM_HL7_MovementAction",source.{PB5(kPSY):PB502Action})' property="target.{ZFS(kPSY):Action}" key="&quot;&quot;" action="set" />
<assign value="source.{PB5(kPSY):PB503IdentifiantUnique}" property="target.{ZFS(kPSY):Identifiant.EntityIdentifier}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{ZFS(kPSY):Identifiant.NamespaceID}" key="&quot;&quot;" action="set" />
<assign value="source.{PB5(kPSY):PB504DateHeureDeDebut}" property="target.{ZFS(kPSY):DateHeureDebutModeLegal.Time}" key="&quot;&quot;" action="set" />
<assign value="source.{PB5(kPSY):PB505DateHeureDeFin}" property="target.{ZFS(kPSY):DateHeureFinModeLegal.Time}" key="&quot;&quot;" action="set" />
<assign value="source.{PB5(kPSY):PB506ModeLegalDeSoin.Code}" property="target.{ZFS(kPSY):ModeLegal.Identifier}" key="&quot;&quot;" action="set" />
<assign value="source.{PB5(kPSY):PB507Commentaire}" property="target.{ZFS(kPSY):Commentaires}" key="&quot;&quot;" action="set" />
<assign value="source.{PB5(kPSY):PB508CodeRIMPDuModeLegal.Code}" property="target.{ZFS(kPSY):CodeRIMPPModeLegal.Identifier}" key="&quot;&quot;" action="set" />
</foreach>

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value="&quot;N&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />

<!-- segment ZFP -->
<if condition="$L(source.{PB2:PB225Profession.CategorieSocioProf})">
<true>
<assign value='source.{PB2:PB225Profession.CategorieSocioProf}' property='target.{ZFP:Categoriesociopro}' action='set' />
</true>
</if>

</transform>
}

}
