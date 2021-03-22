/// 
Class ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.PBtoADT Extends ISSAS.Common.DTL.CCOMtoHL7v231.PBtoADT
{

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:PB" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
<code>
<![CDATA[ Set tSC = ##super(source, .target, $G(aux))  If ($$$ISERR(tSC)) { Quit } ]]>
</code>
<assign value='"A08"' property="target.{MSH:MessageType.triggerevent}" key="&quot;&quot;" action="set" />
<assign value='"A08"' property="target.{EVN:EventTypeCode}" key="&quot;&quot;" action="set" />
</transform>
}

}
