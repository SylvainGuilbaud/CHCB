/// 
Class ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.PAtoADT Extends ISSAS.Common.DTL.CCOMtoHL7v231.PAtoADT
{

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:PA" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
<code>
<![CDATA[ Set tSC = ##super(source, .target, $G(aux))  If ($$$ISERR(tSC)) { Quit } ]]>
</code>

<assign value="source.{PA3:PA303NumeroEpisode}" property="target.{PV1:PreadmitNumber.ID}" key="&quot;&quot;" action="set" />

<assign value="source.{PA7:PA713IdentifiantsRDVPreEpiso.Identifiant}" property="target.{PV1:AlternateVisitID}" key="&quot;&quot;" action="set" />
</transform>
}

}
