Class ISSAS.Common.DTL.CCOMtoHL7v231.HMtoMFN Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v231/HMtoMFN.xml#4 $";

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='Clinicom:HM' targetDocType='2.3.1:MFN_M02' create='new' language='objectscript' >
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
 Set strGUID = $EXTRACT(strGUID, 1, 16) 
 Set nbTel=0 ]]>
 </code>

<!-- segment MSH -->
<assign value="$ZCVT(source.{MSH:MSH03SendingApplication},&quot;U&quot;)" property="target.{MSH:SendingApplication}" key="&quot;&quot;" action="set" />
<assign value="$ZCVT(source.{MSH:MSH04SendingFacility},&quot;U&quot;)" property="target.{MSH:SendingFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MSH:DateTimeOfMessage}" key="&quot;&quot;" action="set" />
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value='"MFN^M02"' property="target.{MSH:MessageType}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />

<!-- segment MFI -->
<assign value='"CLINICOM"' property='target.{MFI:MasterFileIdentifier}' action='set' />
<assign value='"UPD"' property='target.{MFI:FileLevelEventCode}' action='set' />
<assign value="$E(strNow, 1, 12)" property="target.{MFI:EnteredDateTime}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MFI:EffectiveDateTime}" key="&quot;&quot;" action="set" />
<assign value='"AL"' property='target.{MFI:ResponseLevelCode}' action='set' />

<!-- segment MFE -->
<if condition='source.{HM:HM01Mode}="01"'>
<true>
<assign value='"MAD"' property='target.{MFEgrp(1).MFE:RecordLevelEventCode}' action='set' />
</true>
</if>
<if condition='source.{HM:HM01Mode}="02"'>
<true>
<assign value='"MUP"' property='target.{MFEgrp(1).MFE:RecordLevelEventCode}' action='set' />
</true>
</if>
<if condition='source.{HM:HM01Mode}="03"'>
<true>
<assign value='"MDL"' property='target.{MFEgrp(1).MFE:RecordLevelEventCode}' action='set' />
</true>
</if>
<assign value="$E(strNow, 1, 12)" property="target.{MFEgrp(1).MFE:EffectiveDateTime}" key="&quot;&quot;" action="set" />
<assign value='source.{HM:HM02CodeClinicom}' property='target.{MFEgrp(1).MFE:PrimaryKeyValueMFE(1)}' action='set' />
<assign value='"CE"' property='target.{MFEgrp(1).MFE:PrimaryKeyValueType(1)}' action='set' />

<!-- segment STF -->
<assign value='source.{HM:HM02CodeClinicom}' property='target.{MFEgrp(1).STF:PrimaryKeyValueSTF.identifier}' action='set' />
<assign value='source.{HM:HM03NomUsuel}' property='target.{MFEgrp(1).STF:StaffName(1).familylastname}' action='set' />
<assign value='source.{HM:HM04Prenom}' property='target.{MFEgrp(1).STF:StaffName(1).givenname}' action='set' />
<assign value='source.{HM:HM05Qualite}' property='target.{MFEgrp(1).STF:StaffName(1).prefix}' action='set' />
<assign value='source.{HM2:HM201Titre}' property='target.{MFEgrp(1).STF:StaffName(1).degree}' action='set' />
<assign value='source.{HM2:HM203Telephone1}' property='target.{MFEgrp(1).STF:Phone($I(nbTel)).phonenumber1}' action='set' />
<assign value='source.{HM2:HM204Telephone2}' property='target.{MFEgrp(1).STF:Phone($I(nbTel)).phonenumber1}' action='set' />
<assign value='source.{HM2:HM205NoFax}' property='target.{MFEgrp(1).STF:Phone($I(nbTel)).phonenumber1}' action='set' />
<assign value='source.{HM:HM06NoRueAdresse}' property='target.{MFEgrp(1).STF:OfficeHomeAddress(1).streetaddress}' action='set' />
<assign value='source.{HM:HM07ComplementAdresse}' property='target.{MFEgrp(1).STF:OfficeHomeAddress(1).otherdesignation}' action='set' />
<assign value='source.{HM:HM08LocaliteAdresse}' property='target.{MFEgrp(1).STF:OfficeHomeAddress(1).city}' action='set' />
<assign value='source.{HM:HM09CodePostalAdresse}' property='target.{MFEgrp(1).STF:OfficeHomeAddress(1).ziporpostalcode}' action='set' />
<assign value='source.{HM2:HM202PaysAdresse}' property='target.{MFEgrp(1).STF:OfficeHomeAddress(1).country}' action='set' />
<assign value='source.{HM2:HM209AdresseEmail}' property='target.{MFEgrp(1).STF:EMailAddress(1)}' action='set' />
<assign value='"I"' property='target.{MFEgrp(1).STF:JobCodeClass}' action='set' />

<!-- segment PRA -->
<assign value='source.{HM:HM02CodeClinicom}' property='target.{MFEgrp(1).PRA:PrimaryKeyValuePRA}' action='set' />
<assign value='"MPMD"' property='target.{MFEgrp(1).PRA:PractitionerGroup(1)}' action='set' />
<assign value='source.{HM2:HM206Specialite}' property='target.{MFEgrp(1).PRA:Specialty(1)}' action='set' />
<assign value='source.{HM2:HM207NoInscriptionALOrdre}' property='target.{MFEgrp(1).PRA:PractitionerIDNumbers(1)}' action='set' />
</transform>
}

Parameter REPORTERRORS = 1;

}
