Class ISSAS.Common.DTL.CCOMtoHL7v231.NDtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v231/NDtoADT.xml#4 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:ND" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
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
<assign value="$ZCVT(source.{MSH:MSH03SendingApplication},&quot;U&quot;)" property="target.{MSH:SendingApplication}" key="&quot;&quot;" action="set" />
<assign value="$ZCVT(source.{MSH:MSH04SendingFacility},&quot;U&quot;)" property="target.{MSH:SendingFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MSH:DateTimeOfMessage}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt("ADT^"_..Lookup("CCOM_HL7_MessageType_v231","ND"_source.GetValueAt("ND:ND01Mode")),"MSH:MessageType","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v231","ND"_source.GetValueAt("ND:ND01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND05IPP}" property="target.{PID:PatientIdentifierList(1).ID}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND20NomUsuel.Nom}" property="target.{PID:PatientName(1).familylastname}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND20NomUsuel.NameTypeCode}" property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND21Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND24DateDeNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{ND:ND26Sexe})" property="target.{PID:Sex}" key="&quot;&quot;" action="set" />
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value="&quot;I&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND23IdentifiantUniqueDeMouve}" property="target.{PV1:AlternateVisitID}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND06NumeroEpisode}" property="target.{PID:PatientAccountNumber.ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND06NumeroEpisode}" property="target.{PV1:VisitNumber.ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND13IPPMere}" property="target.{PID:MothersIdentifier}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND17CodeUS}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND16CodeUF}" property="target.{ZFU:MedicalFunctionalUnit}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND22Chambre}" property="target.{PV1:AssignedPatientLocation.room}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND15ModeSortie}" property="target.{PV1:DischargeDisposition}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND07DateHeureSortie}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND07DateHeureSortie}" property="target.{ZFU:MedicalFunctionalUnitStartDa}" key="&quot;&quot;" action="set" />
<assign value="source.{ND:ND07DateHeureSortie}" property="target.{PV1:DischargeDateTime.timeofanevent}" key="&quot;&quot;" action="set" />

</transform>
}

}
