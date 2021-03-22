Class ISSAS.Common.DTL.CCOMtoHL7v231.PMtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v231/PMtoADT.xml#3 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:PM" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
<code>
<![CDATA[ Set strAssigningAuthority = $G(^ISSAS.Config("DTL", "AssigningAuthority", "2.3.1"))
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
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt("ADT^"_..Lookup("CCOM_HL7_MessageType_v231","PM"_source.GetValueAt("PM:PM01Mode")),"MSH:MessageType","set","")]]>
</code>

<!-- segment EVN -->
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v231","PM"_source.GetValueAt("PM:PM01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="source.{PM:PM17Utilisateur.Username}" property="target.{EVN:OperatorID(1).IDNumberST}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM08CibleIPP}" property="target.{PID:PatientIdentifierList(1).ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM11CibleNomUsuel}" property="target.{PID:PatientName(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="&quot;L&quot;" property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM12CiblePrenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{PM:PM16CibleNomDeNaissance}) &amp;&amp; (source.{PM:PM11CibleNomUsuel} '= source.{PM:PM16CibleNomDeNaissance})">
<true>
<assign value="source.{PM:PM16CibleNomDeNaissance}" property="target.{PID:PatientName(2).familylastname}" key="&quot;&quot;" action="set" />
<assign value="&quot;M&quot;" property="target.{PID:PatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM12CiblePrenom}" property="target.{PID:PatientName(2).givenname}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{PM:PM13CibleDateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{PM:PM14CibleSexe})" property="target.{PID:Sex}" key="&quot;&quot;" action="set" />

<!-- segment MRG -->
<assign value="source.{PM:PM04SourceIPP}" property="target.{MRG:PriorPatientIdentifierList(1).ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{MRG:PriorPatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM04SourceIPP}" property="target.{MRG:PriorPatientID(1).ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{MRG:PriorPatientID(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM09SourceNomUsuel}" property="target.{MRG:PriorPatientName(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="&quot;L&quot;" property="target.{MRG:PriorPatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM10SourcePrenom}" property="target.{MRG:PriorPatientName(1).givenname}" key="&quot;&quot;" action="set" />
<if condition="$L(source.{PM:PM15SourceNomDeNaissance}) &amp;&amp; (source.{PM:PM09SourceNomUsuel} '= source.{PM:PM15SourceNomDeNaissance})">
<true>
<assign value="source.{PM:PM15SourceNomDeNaissance}" property="target.{MRG:PriorPatientName(2).familylastname}" key="&quot;&quot;" action="set" />
<assign value="&quot;M&quot;" property="target.{MRG:PriorPatientName(2).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{PM:PM10SourcePrenom}" property="target.{MRG:PriorPatientName(2).givenname}" key="&quot;&quot;" action="set" />
</true>
</if>
<if condition="$L(source.{PM:PM05CibleEpisode})">
<true>
<assign value="source.{PM:PM05CibleEpisode}" property="target.{MRG:PriorPatientAccountNumber(1).ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{MRG:PriorPatientAccountNumber(1).assigningauthority}" key="&quot;&quot;" action="set" />
</true>
</if>
</transform>
}

}
