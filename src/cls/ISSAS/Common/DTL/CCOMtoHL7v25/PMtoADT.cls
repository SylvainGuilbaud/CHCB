Class ISSAS.Common.DTL.CCOMtoHL7v25.PMtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v25/PMtoADT.xml#7 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:PM" targetClass="EnsLib.HL7.Message" targetDocType="HL7v25IHE:ADT_AXX" create="new" language="objectscript" >
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
 /*If (source.GetValueAt("PM:PM02Mode") = "03") { Set tSC = 0  Quit }*/ ]]>
</code>
<!-- segment MSH -->
<assign value="$ZCVT(source.{MSH:MSH03SendingApplication},&quot;U&quot;)" property="target.{MSH:SendingApplication}" key="&quot;&quot;" action="set" />
<assign value="$ZCVT(source.{MSH:MSH04SendingFacility},&quot;U&quot;)" property="target.{MSH:SendingFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MSH:DateTimeOfMessage}" key="&quot;&quot;" action="set" />
<assign value="&quot;ADT&quot;" property="target.{MSH:MessageType.MessageCode}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","PM"_source.GetValueAt("PM:PM01Mode")),"MSH:MessageType.TriggerEvent","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","PM"_source.GetValueAt("PM:PM01Mode")),"MSH:MessageType.MessageStructure","set","")]]>
</code>
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value='"2.5"' property="target.{MSH:VersionID}" key="&quot;&quot;" action="set" />
<assign value="&quot;FRA&quot;" property="target.{MSH:CountryCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<assign value="&quot;FR&quot;" property="target.{MSH:PrincipalLanguageOfMessage}" key="&quot;&quot;" action="set" />

<!-- segment EVN -->
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","PM"_source.GetValueAt("PM:PM01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM17Utilisateur.Username}" property="target.{EVN:OperatorID.IDNumber}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM08CibleIPP}" property="target.{PID:PatientIdentifierList(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : on envoie toujours nom de naissance en L et nom usuel en D pour être conforme IHE PAM -->
<assign value="source.{PM:PM11CibleNomUsuel}" property="target.{PID:PatientName(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='"D"' property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM12CiblePrenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM16CibleNomDeNaissance}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='"L"' property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM12CiblePrenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : par précaution, dans le cas improbable où le nom de naissance serait vide, on envoie le nom usuel en L aussi -->
<if condition="$L(source.{PM:PM16CibleNomDeNaissance})">
<false>
<assign value="source.{PM:PM11CibleNomUsuel}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{PM:PM13CibleDateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{PM:PM14CibleSexe})" property="target.{PID:AdministrativeSex}" key="&quot;&quot;" action="set" />
<!-- Indicateur Décès Y/N -->
<if condition="##class(ISSAS.Common.Tools.ClassODBC).IsDeceased(source.{PM:PM04SourceIPP})=1">
<true>
<assign value="&quot;Y&quot;" property="target.{PID:PatientDeathIndicator}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;N&quot;" property="target.{PID:PatientDeathIndicator}" key="&quot;&quot;" action="set" />
</false>
</if>

<!-- segment MRG -->
<assign value="source.{PM:PM04SourceIPP}" property="target.{MRG:PriorPatientIdentifierList(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{MRG:PriorPatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{MRG:PriorPatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM04SourceIPP}" property="target.{MRG:PriorPatientID(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{MRG:PriorPatientID(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{MRG:PriorPatientID(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : on envoie toujours nom de naissance en L et nom usuel en D pour être conforme IHE PAM -->
<assign value="source.{PM:PM09SourceNomUsuel}" property="target.{MRG:PriorPatientName(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="&quot;D&quot;" property="target.{MRG:PriorPatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM10SourcePrenom}" property="target.{MRG:PriorPatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM15SourceNomDeNaissance}" property="target.{MRG:PriorPatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value="&quot;L&quot;" property="target.{MRG:PriorPatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM10SourcePrenom}" property="target.{MRG:PriorPatientName(2).givenname}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{PM:PM15SourceNomDeNaissance})">
<false>
<assign value="source.{PM:PM09SourceNomUsuel}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
</false>
</if>

<if condition="$L(source.{PM:PM05CibleEpisode})">
<true>
<assign value="source.{PM:PM05CibleEpisode}" property="target.{MRG:PriorPatientAccountNumber(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{MRG:PriorPatientAccountNumber(1).assigningauthority}" key="&quot;&quot;" action="set" />
</true>
</if>
</transform>
}

}
