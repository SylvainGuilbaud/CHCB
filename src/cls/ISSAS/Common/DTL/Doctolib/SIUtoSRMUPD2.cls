Include Constantes

Class ISSAS.Common.DTL.Doctolib.SIUtoSRMUPD2 Extends ISSAS.Common.DTL.Doctolib.SIUtoSRM
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/MAIN/cls/ISSAS/Common/DTL/Doctolib/SIUtoSRMUPD2.xml#2 $";

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

<code>
<![CDATA[
	Set tSC = ##super(source, .target, $Get(aux))
	quit:($$$ISERR(tSC))
]]>
</code>

<!-- segment MSH -->
<assign value='"SRM^S01"' property='target.{MSH:MessageType}' action='set' />

</transform>
}

}
