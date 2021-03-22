Include Constantes

Class ISSAS.Common.DTL.Doctolib.SIUtoSRM Extends Ens.DataTransformDTL [ DependsOn = EnsLib.HL7.Message ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/MAIN/cls/ISSAS/Common/DTL/Doctolib/SIUtoSRM.xml#8 $";

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='2.5.1:SIU_S12' targetDocType='2.4:SRM_S01' create='new' language='objectscript' >
<if condition='+##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "TraceTransformations", $$$FALSE)'>
<true>
<trace value='"Dans " _ $ClassName() _ ", MsgId=" _ source.%Id()'/>
</true>
</if>
<assign value='##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "RessourceSeparator", "-")' property='RessourceSeparator' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "FormatRessources", "UF_RESSOURCE")' property='FormatRessources' action='set' />

<if condition='FormatRessources = "UF_US_RESSOURCE"'>
<true>
<assign value='source.{RGSgrp(1).AILgrp(1).AIL:LocationResourceID(1).PointofCare}' property='PointofCare' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 1)' property='UF' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 2)' property='UC' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 3)' property='Ressource' action='set' />
<assign value='""' property='CodeAgenda01' action='set' />
</true>
</if>
<if condition='FormatRessources = "UF_RESSOURCE"'>
<true>
<assign value='source.{RGSgrp(1).AILgrp(1).AIL:LocationResourceID(1).PointofCare}' property='PointofCare' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 1)' property='UF' action='set' />
<assign value='""' property='UC' action='set' />
<assign value='$PIECE(PointofCare, RessourceSeparator, 2)' property='Ressource' action='set' />
<assign value='""' property='CodeAgenda01' action='set' />
</true>
</if>
<if condition='(FormatRessources = "UF_US_RESSOURCE_OTHERAGD") || (FormatRessources = "UF_US_RESSOURCE_OTHERAGD_SCH_AIG")'>
<true>
<assign value='source.{RGSgrp(1).AIGgrp(1).AIG:ResourceType.Text}' property='ResourceType' action='set' />
<assign value='$PIECE(ResourceType, RessourceSeparator, 1)' property='UF' action='set' />
<assign value='$PIECE(ResourceType, RessourceSeparator, 2)' property='UC' action='set' />
<assign value='$PIECE(ResourceType, RessourceSeparator, 3)' property='Ressource' action='set' />
<assign value='$PIECE(ResourceType, RessourceSeparator, 4)' property='CodeAgenda01' action='set' />
</true>
</if>

<assign value='source.{MSH}' property='target.{MSH}' action='set' />
<if condition='source.{MSH:MessageType.TriggerEvent}="S12"' >
<true>
<assign value='"SRM^S01"' property='target.{MSH:MessageType}' action='set' />
</true>
<false>
<assign value='"SRM^S04"' property='target.{MSH:MessageType}' action='set' />
</false>
</if>
<assign value='"8859/1"' property='target.{MSH:CharacterSet}' action='set' />
<assign value='source.{SCH:FillerAppointmentID.NamespaceID}' property='target.{ARQ:PlacerAppointmentID}' action='set' />
<assign value='"TRAKCARE"' property='target.{MSH:ReceivingApplication}' action='set' />
<assign value='"ISC"' property='target.{MSH:ReceivingFacility}' action='set' />
<assign value='source.{SCH:FillerAppointmentID.EntityIdentifier}' property='target.{ARQ:ScheduleID}' action='set' />
<assign value='source.{SCH:AppointmentTimingQuantity(1).Duration}' property='target.{ARQ:AppointmentDuration}' action='set' />
<assign value='source.{SCH:AppointmentTimingQuantity(1).StartDateTime}' property='target.{ARQ:RequestedStartDateTimeRange(1).rangestartdatetime}' action='set' />
<assign value='source.{NTE()}' property='target.{NTE()}' action='set' />
<assign value='source.{PIDgrp(1).PID}' property='target.{PIDgrp(1).PID}' action='set' />
<assign value='source.{PIDgrp(1).PV1}' property='target.{PIDgrp(1).PV1}' action='set' />
<assign value='source.{RGSgrp(1).RGS}' property='target.{RGSgrp(1).RGS}' action='set' />

<assign value='UF' property='target.{RGSgrp(1).AILgrp(1).AIL:LocationGroup}' action='set' />
<assign value='Ressource' property='target.{RGSgrp(1).AILgrp(1).AIL:LocationTypeAIL}' action='set' />
<assign value='source.{SCH:EventReason.Identifier}' property='target.{RGSgrp(1).AISgrp(1).AIS:UniversalServiceIdentifier}' action='set' />
<assign value='source.{RGSgrp(1).AILgrp(1).AIL:LocationResourceID(1).Room}' property='target.{RGSgrp(1).AILgrp(1).AIL:LocationResourceID(1).Room}' action='set' />

<code>
<![CDATA[
	// Formatte le PID (casse du nom, ...) à partir des paramètres de WSClinicomSyncOut (ISSAS.Common.BO.WS.ClinicomSyncOperation.CLS)
	SET tSC1 = ##class(ISSAS.Common.DTL.Doctolib.DoctolibUtils).FormatPID(.target)
	Set:($$$ISERR(tSC1)) tSCTrans = tSC1
]]>
</code>


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
