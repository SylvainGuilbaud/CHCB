Class ISSAS.Common.DTL.CCOMtoTC.APtoSRM Extends Ens.DataTransformDTL [ DependsOn = EnsLib.HL7.Message ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoTC/APtoSRM.xml#4 $";

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='Clinicom:AP1' targetDocType='2.4:SRM_S01' create='new' language='objectscript' >
<code>
<![CDATA[ Set strAssigningAuthority = $G(^ISSAS.Config("DTL", "AssigningAuthority", "2.4"))
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
<assign value='"CLINICOM"' property="target.{MSH:SendingApplication}" key="&quot;&quot;" action="set" />
<assign value='"ISC"' property="target.{MSH:SendingFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MSH:DateTimeOfMessage}" key="&quot;&quot;" action="set" />
<if condition="source.{AP2:AP201Mode}=&quot;01&quot;">
<true>
<assign value='"SRM^S01"' property='target.{MSH:MessageType}' action='set' />
</true>
<false>
<assign value='"SRM^S04"' property='target.{MSH:MessageType}' action='set' />
</false>
</if>
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value="&quot;FRA&quot;" property="target.{MSH:CountryCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<assign value="&quot;FR&quot;" property="target.{MSH:PrincipalLanguageOfMessage}" key="&quot;&quot;" action="set" />

<!-- segment ARQ -->
<assign value='"CLINICOM"' property='target.{ARQ:PlacerAppointmentID}' action='set' />
<assign value='source.{AP2:AP213IdentifiantUniqueRDV}' property='target.{ARQ:ScheduleID}' action='set' />
<assign value='source.{AP2:AP204DateRDV}_source.{AP2:AP205HeureRDV}' property='target.{ARQ:RequestedStartDateTimeRange(1).rangestartdatetime}' action='set' />

<!-- segment NTE -->
<if condition="$L(source.{AP2:AP208Commentaire})">
<true>
<assign value='"1"' property="target.{NTE(1):SetIDNTE}" key="&quot;&quot;" action="set" />
<assign value="source.{AP2:AP208Commentaire}" property="target.{NTE(1):Comment(1)}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- segment PID -->
<assign value="source.{AP1:AP101IPP}" property="target.{PIDgrp(1).PID:PatientIdentifierList(1).ID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PIDgrp(1).PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{AP1:AP102NomUsuel}" property="target.{PIDgrp(1).PID:PatientName(1).familyname}" key="&quot;&quot;" action="set" />
<assign value='"L"' property="target.{PIDgrp(1).PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{AP1:AP104Prenom}" property="target.{PIDgrp(1).PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{AP1:AP105DateDeNaissance}" property="target.{PIDgrp(1).PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{AP1:AP106Sexe})" property="target.{PIDgrp(1).PID:AdministrativeSex}" key="&quot;&quot;" action="set" />

<!-- segment RGS -->
<assign value='"1"' property="target.{RGSgrp(1).RGS:SetIDRGS}" key="&quot;&quot;" action="set" />
<assign value='"U"' property="target.{RGSgrp(1).RGS:SegmentActionCode}" key="&quot;&quot;" action="set" />

<!-- segment AIS -->
<assign value='source.{AP2:AP207CodePrestation}' property='target.{RGSgrp(1).AISgrp(1).AIS:UniversalServiceIdentifier}' action='set' />

<!-- segment AIL -->
<assign value='source.{AP2:AP209CodeUC}' property='target.{RGSgrp(1).AILgrp(1).AIL:LocationGroup}' action='set' />
<assign value='source.{AP2:AP211Coderessource}' property='target.{RGSgrp(1).AILgrp(1).AIL:LocationTypeAIL}' action='set' />
<assign value='source.{AP2:AP210CodeUF}' property='target.{RGSgrp(1).AILgrp(1).AIL:LocationGroup}' action='set' />
 
</transform>
}

}
