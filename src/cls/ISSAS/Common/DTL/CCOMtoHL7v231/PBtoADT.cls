Class ISSAS.Common.DTL.CCOMtoHL7v231.PBtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v231/PBtoADT.xml#11 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:PB" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
<code>
<![CDATA[ 
 Set strAssigningAuthority = $G(^ISSAS.Config("DTL", "AssigningAuthority", "2.3.1"), "CLINICOM")
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
<![CDATA[ Set tSC1=target.SetValueAt("ADT^"_..Lookup("CCOM_HL7_MessageType_v231","PB"_source.GetValueAt("PB:PB01Mode")),"MSH:MessageType","set","")]]>
</code>

<!-- segment EVN -->
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v231","PB"_source.GetValueAt("PB:PB01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="source.{PB2:PB218Utilisateur.Username}" property="target.{EVN:OperatorID(1).IDNumberST}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB03IPP}" property="target.{PID:PatientIdentifierList(1).ID}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{PB2:PB220IdentifiantNational.Valeur})">
<true>
<assign value="source.{PB2:PB220IdentifiantNational.Valeur}" property="target.{PID:PatientIdentifierList(2).ID}" key="&quot;&quot;" action="set" />
<assign value="&quot;1.2.250.1.213.1.4.2&quot;" property="target.{PID:PatientIdentifierList(2).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="&quot;INS-C&quot;" property="target.{PID:PatientIdentifierList(2).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;ASIP&quot;" property="target.{PID:PatientIdentifierList(2).AssigningFacility}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{PB:PB04NomUsuel}" property="target.{PID:PatientName(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="&quot;L&quot;" property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB05Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB213AutresPrenoms}" property="target.{PID:PatientName(1).middleinitialorname}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB06Qualite}" property="target.{PID:PatientName(1).prefix}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{PB:PB07NomDeNaissance}) &amp;&amp; (source.{PB:PB04NomUsuel} '= source.{PB:PB07NomDeNaissance})">
<true>
<assign value="source.{PB:PB07NomDeNaissance}" property="target.{PID:PatientName(2).familylastname}" key="&quot;&quot;" action="set" />
<assign value="&quot;M&quot;" property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB05Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{PB:PB09DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{PB:PB10Sexe})" property="target.{PID:Sex}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB11NoRueAdresse}" property="target.{PID:PatientAddress(1).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{PB:PB12CodePostalAdresse}" property="target.{PID:PatientAddress(1).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB201LocaliteAdresse}" property="target.{PID:PatientAddress(1).city}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB206ComplementAdresse}" property="target.{PID:PatientAddress(1).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB207PaysAdresse}" property="target.{PID:PatientAddress(1).country}" key="&quot;&quot;" action="set" />

<if condition="$L(source.{PB2:PB202TelephoneDomicile})">
<true>
<assign value="source.{PB2:PB202TelephoneDomicile}" property="target.{PID:PhoneNumberHome($I(nbtel)).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{PB2:PB208TelephoneProfessionnel})">
<true>
<assign value="source.{PB2:PB208TelephoneProfessionnel}" property="target.{PID:PhoneNumberBusiness(1).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;WPN&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberBusiness(1).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{PB2:PB217TelephonePortable})">
<true>
<assign value="source.{PB2:PB217TelephonePortable}" property="target.{PID:PhoneNumberHome($I(nbtel)).phoneNumber1}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;CP&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{PB2:PB203Nationalite}" property="target.{PID:Citizenship(1)}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB203Nationalite}" property="target.{PID:Nationality}" key="&quot;&quot;" action="set" />
<assign value="source.{PB2:PB209DateDeDeces}" property="target.{PID:PatientDeathDateandTime(1)}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{PB2:PB209DateDeDeces})">
<true>
<assign value="&quot;Y&quot;" property="target.{PID:PatientDeathIndicator}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;N&quot;" property="target.{PID:PatientDeathIndicator}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="..Lookup($G(^ISSAS.Config(&quot;LUT&quot;, &quot;CCOM_HL7_MaritalStatus&quot;)),source.{PB2:PB210SituationFamiliale})" property="target.{PID:MaritalStatus.identifier}" key="&quot;&quot;" action="set" />

<!-- segment(s) NK1 -->
<foreach key="kPaP" property="source.{PB4()}">
<code>
<![CDATA[ Set occTel=0 ]]>
</code>
<assign value="kPaP" property="target.{NK1(kPaP):SetIDNK1}" key="&quot;&quot;" action="set" />
<assign value="source.{PB4(kPaP):PB402NomUsuel}" property="target.{NK1(kPaP):Name(1).familylastname}" key="&quot;&quot;" action="set" />
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
<assign value="source.{PB4(kPaP):PB410TelephoneDomicile}" property="target.{NK1(kPaP):PhoneNumber($I(occTel)).phonenumber1}" key="&quot;&quot;" action="set" />
<assign value='"PH"' property="target.{NK1(kPaP):PhoneNumber(occTel).telecommunicationequipmentty}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{PB4(kPaP):PB411TelephoneProfessionnel}" property="target.{NK1(kPaP):BusinessPhoneNumber(1).phonenumber1}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{PB4(kPaP):PB413TelephoneMobile})">
<true>
<assign value="source.{PB4(kPaP):PB413TelephoneMobile}" property="target.{NK1(kPaP):PhoneNumber($I(occTel)).phonenumber1}" key="&quot;&quot;" action="set" />
<assign value='"CP"' property="target.{NK1(kPaP):PhoneNumber(occTel).telecommunicationequipmentty}" key="&quot;&quot;" action="set" />
</true>
</if>
</foreach>

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value="&quot;N&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
</transform>
}

}
