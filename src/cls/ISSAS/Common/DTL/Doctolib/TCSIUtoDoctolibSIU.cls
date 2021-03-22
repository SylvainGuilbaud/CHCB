Include Constantes

Class ISSAS.Common.DTL.Doctolib.TCSIUtoDoctolibSIU Extends Ens.DataTransformDTL [ DependsOn = EnsLib.HL7.Message ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/MAIN/cls/ISSAS/Common/DTL/Doctolib/TCSIUtoDoctolibSIU.xml#3 $";

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='2.4:SIU_S12' targetDocType='2.4:SIU_S12' create='new' language='objectscript' >
<if condition='+##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "TraceTransformations", $$$FALSE)'>
<true>
<trace value='"Dans " _ $ClassName() _ ", MsgId=" _ source.%Id()'/>
</true>
</if>

<!-- segment MSH -->
<assign value='source.{MSH}' property='target.{MSH}' action='set' />


<assign value='source.{SCH}' property='target.{SCH}' action='set' />
<assign value='..Lookup("DOCTOLIB_TRAK_DOCTOLIB_StatutRDV",source.{SCH:FillerStatusCode.text})' property='target.{SCH:FillerStatusCode}' action='set' />

<assign value='source.{NTE()}' property='target.{NTE()}' action='set' />
<assign value='""' property='strBuffer' action='set' />
<code>
<![CDATA[
	Set (strBuffer, strSep) = ""
	Set keyNTE=""
	For {
		Set tSC1=1, keyNTE=source.GetNextIndex("NTE(1):Comment()",keyNTE,.tSC1)
		Set:('tSC1)&&('..#IGNOREMISSINGSOURCE||(($$GetOneStatusText^%apiOBJ(tSC1)'["No segment found")&&($$GetOneStatusText^%apiOBJ(tSC1)'["is not an element, instead this node"))) tSCTrans=$select(+tSCTrans:tSC1,1:$$AppendStatus^%occSystem(tSCTrans,tSC1))
		Quit:(keyNTE = "")
		set strBuffer = strBuffer _ strSep _ source.GetValueAt("NTE(1):Comment(" _ keyNTE _ ")")
		set strSep = "\.br\"
	}
]]>
</code>
<if condition="strBuffer '= &quot;&quot; ">
<true>
<assign value='strBuffer' property='target.{NTE(1):Comment}' action='set' />
</true>
</if>
<assign value='source.{PIDgrp().PID}' property='target.{PIDgrp().PID}' action='set' />
<assign value='"CLINICOM"' property='target.{PIDgrp(1).PID:PatientIdentifierList(1).assigningauthority}' action='set' />
<assign value='"PI"' property='target.{PIDgrp(1).PID:PatientIdentifierList(1).identifiertypecodeID}' action='set' />
	<!-- CCOMTCC-518 -->
<assign value='$REPLACE(source.{PIDgrp(1).PID:AdministrativeSex},"I","U")' property='target.{PIDgrp(1).PID:AdministrativeSex}' action='set' />

<assign value='source.{PIDgrp().PV1}' property='target.{PIDgrp().PV1}' action='set' />

<assign value='source.{RGSgrp().RGS}' property='target.{RGSgrp().RGS}' action='set' />

<assign value='source.{RGSgrp().AISgrp()}' property='target.{RGSgrp().AISgrp()}' action='set' />

<assign value='source.{RGSgrp().AIGgrp()}' property='target.{RGSgrp().AIGgrp()}' action='set' />

<assign value='""' property="Ressource" />
<assign value='##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "RessourceSeparator", "-")' property="RessourceSeparator" />
<assign value='##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "FormatRessources", "UF_RESSOURCE")' property='FormatRessources' action='set' />

<if condition='FormatRessources = "UF_US_RESSOURCE"'>
<true>
<assign value='source.{PIDgrp(1).PV1:HospitalService}' property="UF" />
<assign value='source.{PIDgrp(1).PV1:AssignedPatientLocation.PointofCare}' property="UC" />
<assign value='source.{PIDgrp(1).PV1:AttendingDoctor(1).IDNumber}' property="Ressource" />
<assign value='UF _ RessourceSeparator _ UC _ RessourceSeparator _ Ressource' property="CodeAgenda" />
</true>
</if>
<if condition='FormatRessources = "UF_RESSOURCE"'>
<true>
<assign value='source.{PIDgrp(1).PV1:HospitalService}' property="UF" />
<assign value='source.{PIDgrp(1).PV1:AttendingDoctor(1).IDNumber}' property="Ressource" />
<assign value='UF _ RessourceSeparator _ Ressource' property="CodeAgenda" />
</true>
</if>
<if condition='FormatRessources = "UF_US_RESSOURCE_OTHERAGD"'>
<true>
<assign value='source.{PIDgrp(1).PV1:HospitalService}' property="UF" />
<assign value='source.{PIDgrp(1).PV1:AssignedPatientLocation.PointofCare}' property="UC" />
<assign value='source.{PIDgrp(1).PV1:AttendingDoctor(1).IDNumber}' property="Ressource" />
<assign value='"AFINIR"' property='CodeAgenda01' action='set' />
<assign value='UF _ RessourceSeparator _ UC _ RessourceSeparator _ Ressource _ RessourceSeparator _ CodeAgenda01' property="CodeAgenda" />
</true>
</if>
<if condition='FormatRessources = "UF_US_RESSOURCE_OTHERAGD_SCH_AIG"'>
<true>
<assign value='source.{SCH:EventReason.Identifier}' property="EventReason" />
<assign value='source.{PIDgrp(1).PV1:HospitalService}' property="UF" />
<assign value='source.{PIDgrp(1).PV1:AssignedPatientLocation.PointofCare}' property="UC" />
<assign value='source.{PIDgrp(1).PV1:AttendingDoctor(1).IDNumber}' property="Ressource" />
<assign value='""' property='CodeAgenda01' action='set' />
<assign value='UF _ RessourceSeparator _ UC _ RessourceSeparator _ EventReason' property="target.{SCH:EventReason.identifierST}" />
<if condition='CodeAgenda01 = ""'>
<true>
<assign value='Ressource' property="CodeAgenda" />
</true>
<false>
<assign value='Ressource _ RessourceSeparator _ CodeAgenda01' property="CodeAgenda" />
</false>
</if>
</true>
</if>

<assign value='CodeAgenda' property='target.{RGSgrp(1).AIGgrp(1).AIG:ResourceType.identifierST}' action='set' />

<assign value='source.{RGSgrp().AIPgrp()}' property='target.{RGSgrp().AIPgrp()}' action='set' />

<assign value='source.{RGSgrp().AILgrp()}' property='target.{RGSgrp().AILgrp()}' action='set' />
<if condition='$get(^ISSAS.Config("WS", "Client", "Clinicom", "Settings", "Doctolib", "AIL")) &apos;= ""' >
<annotation>Pour déboggage</annotation>
<true>
<assign value='^ISSAS.Config("WS", "Client", "Clinicom", "Settings", "Doctolib", "AIL")' property='target.{RGSgrp(1).AILgrp(1).AIL:LocationResourceID(1).pointofcare}' action='set' />
<trace value='"MODE DEBUG AIL !!!!"' />
</true>
</if>

<if condition='+##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "TraceTransformations", $$$FALSE)'>
<true>
<code>
<![CDATA[
	set strBuffer = "En sortie de " _ ..%ClassName() _ $char(13, 10)
	For I=1:1:target.SegCount
	{ set strBuffer = strBuffer _ target.GetValueAt(I) _ $char(13, 10) }
	$$$TRACE(strBuffer)
]]>
</code>
</true>
</if>
</transform>
}

}
