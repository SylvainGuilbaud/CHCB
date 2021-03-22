Include Constantes

Class ISSAS.Common.DTL.Doctolib.SIU14toDLSIU14 Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/MAIN/cls/ISSAS/Common/DTL/Doctolib/SIU14toDLSIU14.xml#1 $";

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="2.5.1:SIU_S12" targetClass="EnsLib.HL7.Message" targetDocType="2.5.1:SIU_S12" create="new" language="objectscript" >
<if condition='+##class(ISSAS.Common.Tools.ClassTools).GetSettingFromItemName("BPLDoctolib", "TraceTransformations", $$$FALSE)'>
<true>
<trace value='"Dans " _ $ClassName() _ ", MsgId=" _ source.%Id()'/>
</true>
</if>
<assign value='$TRANSLATE(##class(%SYSTEM.Util).CreateGUID(), "{}-|", "")' property="strGUID" action="set" />
<assign value='source' property="target" action="set" />
<assign value="strGUID" property="target.{MSH:MessageControlID}" action="set" />

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
