/// 
Class ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.TRtoADT Extends ISSAS.Common.DTL.CCOMtoHL7v231.TRtoADT
{

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:TR" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
<code>
<![CDATA[ Set tSC = ##super(source, .target, $G(aux))  If ($$$ISERR(tSC)) { Quit } ]]>
</code>

<!-- UF hébergée -->
<if condition='source.{TR:TR22IndicateurUFHebergee}="1"'>
<true>
<assign value='..Lookup("ISSAS.Sites.Bayonne.LUT.US_UF_hebergee",source.{TR:TR09CodeUS})' property="target.{ZFU:MedicalFunctionalUnit}" key="&quot;&quot;" action="set" />
</true>
</if>

<!-- annulation de mutation -->
<if condition='(source.{TR:TR01Mode} = "03") &amp;&amp; (source.{TR:TR24IndicateurUFPrecedenteHe}="1")'>
<true>
<assign value='..Lookup("ISSAS.Sites.Bayonne.LUT.US_UF_hebergee",source.{TR:TR23CodeUSPrecedente})' property="target.{ZFU:MedicalFunctionalUnit}" key="&quot;&quot;" action="set" />
</true>
</if>

</transform>
}

}
