/// 
Class ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.ADtoADT Extends ISSAS.Common.DTL.CCOMtoHL7v231.ADtoADT
{

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:AD" targetClass="EnsLib.HL7.Message" targetDocType="HL7v231IHE:ADT_AXX" create="new" language="objectscript" >
<code>
<![CDATA[ Set tSC = ##super(source, .target, $G(aux))  If ($$$ISERR(tSC)) { Quit } ]]>
</code>

<!-- UF hébergée -->
<if condition='source.{AD3:AD329IndicateurUFHebergee}="1"'>
<true>
<assign value='..Lookup("ISSAS.Sites.Bayonne.LUT.US_UF_hebergee",source.{AD3:AD305CodeUS})' property="target.{ZFU:MedicalFunctionalUnit}" key="&quot;&quot;" action="set" />
</true>
</if>

</transform>
}

}
