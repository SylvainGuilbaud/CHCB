Class ISSAS.Common.DTL.CCOMtoHL7v25.PLtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v25/PLtoADT.xml#8 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:PL" targetClass="EnsLib.HL7.Message" targetDocType="HL7v25IHE:ADT_AXX" create="new" language="objectscript" >
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
 Set strGUID = $EXTRACT(strGUID, 1, 16) ]]>
</code>
<!-- segment MSH -->
<assign value="$ZCVT(source.{MSH:MSH03SendingApplication},&quot;U&quot;)" property="target.{MSH:SendingApplication}" key="&quot;&quot;" action="set" />
<assign value="$ZCVT(source.{MSH:MSH04SendingFacility},&quot;U&quot;)" property="target.{MSH:SendingFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MSH:DateTimeOfMessage}" key="&quot;&quot;" action="set" />
<assign value="&quot;ADT&quot;" property="target.{MSH:MessageType.MessageCode}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","PL"_source.GetValueAt("PL:PL01Mode")),"MSH:MessageType.TriggerEvent","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","PL"_source.GetValueAt("PL:PL01Mode")),"MSH:MessageType.MessageStructure","set","")]]>
</code>
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value='"2.5"' property="target.{MSH:VersionID}" key="&quot;&quot;" action="set" />
<assign value="&quot;FRA&quot;" property="target.{MSH:CountryCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<assign value="&quot;FR&quot;" property="target.{MSH:PrincipalLanguageOfMessage}" key="&quot;&quot;" action="set" />

<!-- segment EVN -->
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","PL"_source.GetValueAt("PL:PL01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="source.{PL:PL05IPP}" property="target.{PID:PatientIdentifierList(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : on envoie toujours nom de naissance en L et nom usuel en D pour être conforme IHE PAM -->
<assign value="source.{PL:PL09NomUsuel}" property="target.{PID:PatientName(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='"D"' property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PL:PL10Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{PL:PL11NomDeNaissance}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='"L"' property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PL:PL10Prenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
<!-- CCOMTCC-1369 : par précaution, dans le cas improbable où le nom de naissance serait vide, on envoie le nom usuel en L aussi -->
<if condition="$L(source.{PL:PL11NomDeNaissance})">
<false>
<assign value="source.{PL:PL11NomDeNaissance}" property="target.{PID:PatientName(2).FamilyName}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{PL:PL13DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{PL:PL12Sexe})" property="target.{PID:AdministrativeSex}" key="&quot;&quot;" action="set" />
<assign value="source.{PL:PL06NumeroEpisode}" property="target.{PID:PatientAccountNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value='"P"' property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
<assign value="source.{PL:PL06NumeroEpisode}" property="target.{PV1:VisitNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{PL:PL15CodeUS}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />

<!-- segment ZBE -->
<assign value="source.{PL:PL16IdentifiantUniqueDeMouve}" property="target.{ZBE:MovementID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{ZBE:MovementID.NamespaceID}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{ZBE:StartMovementDateTime}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MovementAction",source.GetValueAt("PL:PL01Mode")),"ZBE:MovementAction","set","")]]>
</code>
<if condition='source.{PL:PL01Mode} = "01"'>
<false>
<assign value="&quot;A03&quot;" property="target.{ZBE:Originaltriggereventcode}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{PL:PL14CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationName}" key="&quot;&quot;" action="set" />
<assign value="source.{PL:PL14CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationIdentifier}" key="&quot;&quot;" action="set" />
<assign value='"HMS"' property="target.{ZBE:NatureMouvement}" key="&quot;&quot;" action="set" />
</transform>
}

}
