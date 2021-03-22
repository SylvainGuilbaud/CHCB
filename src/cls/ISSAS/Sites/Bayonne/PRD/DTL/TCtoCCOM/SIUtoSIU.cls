/// 
Class ISSAS.Sites.Bayonne.PRD.DTL.TCtoCCOM.SIUtoSIU Extends ISSAS.Common.DTL.TCtoCCOM.SIUtoSIU
{

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='ISSAS.Common.Message.ClinicomHL7' sourceDocType='TrakCare:SIU_S12' targetDocType='ClinicomReceiver:SIU' create='new' language='objectscript' >
<code>
<![CDATA[ Set tSC = ##super(source, .target, $G(aux))  If ($$$ISERR(tSC)) { Quit } ]]>
</code>

<!-- code agenda -->
<assign value='..Lookup("ISSAS.Sites.Bayonne.PRD.LUT.TrakCare_Agendas",source.{SCH:PlacerContactPerson(1).IDnumberST})' property='target.{SIU:SIU06CodeAgenda}' action='set' />

</transform>
}

}
