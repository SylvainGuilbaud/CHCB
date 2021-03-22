/// 
Class ISSAS.Sites.Bayonne.TRN.Prod.RouterCCOMTargetRoutingRule Extends Ens.Rule.Definition [ ProcedureBlock ]
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.VDocRuleAssistCompatible";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.VDocRoutingEngine" production="ISSAS.Sites.Bayonne.TRN.Prod.Production">
<variable name="DoctoLibExcludeResources"></variable>
<ruleSet name="Messages HPRIM ou HL7" effectiveBegin="" effectiveEnd="">
<rule name="Résultats GLIMS pour TRAKCARE" disabled="false">
<constraint name="source" value="GLIMS.Res.File"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docCategory" value="2.5"></constraint>
<constraint name="docType" value="ORU_R01"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.DTL.GLIMStoTC.ORUtoORU" target="BP.MMA.TRAKCARE.GLIMS"></send>
<return></return>
</when>
</rule>
<rule name="Résultats OPESIM" disabled="false">
<constraint name="source" value="OPESIM.ORU.File"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.HPRIMv2HL7"></constraint>
<constraint name="docCategory" value="HPRIMV2"></constraint>
<constraint name="docType" value="ORU"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.OPESIMtoCCOM.ORUtoORU" target="CLINICOM.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.OPESIMtoTC.ORUtoORU" target="BP.MMA.TRAKCARE.OPESIM"></send>
<return></return>
</when>
</rule>
<rule name="Planification QPLANNER par FILE" disabled="false">
<constraint name="source" value="QPLANNER.SIU.IN.File"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="SIU_S12"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.QPLANNERtoCCOM.SIUtoSIU" target="CLINICOM.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.QPLANNERtoCCOM.SIUtoQPA" target="CLINICOM.TCP"></send>
<return></return>
</when>
</rule>
<rule name="Planification QPLANNER par TCP" disabled="false">
<constraint name="source" value="QPLANNER.SIU.IN.TCP"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="SIU_S12"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.QPLANNERtoCCOM.SIUtoSIU" target="CLINICOM.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.QPLANNERtoCCOM.SIUtoQPA" target="CLINICOM.TCP"></send>
<return></return>
</when>
</rule>
<rule name="Résultats COPILOTE" disabled="false">
<constraint name="source" value="COPILOTE.ORU.File"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.HPRIMv2HL7"></constraint>
<constraint name="docCategory" value="HPRIMV2"></constraint>
<constraint name="docType" value="ORU"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.COPILOTEtoCCOM.ORUtoORU" target="CLINICOM.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.COPILOTEtoTC.ORUtoORU" target="TRAKCARE.ORU.COPILOTE.TCP"></send>
<return></return>
</when>
</rule>
<rule name="Résultats VIEWPOINT" disabled="false">
<constraint name="source" value="VIEWPOINT.ORU.File"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.HPRIMv2HL7"></constraint>
<constraint name="docCategory" value="HPRIMV2"></constraint>
<constraint name="docType" value="ORU"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.VIEWPOINTtoCCOM.ORUtoORU" target="CLINICOM.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.VIEWPOINTtoTC.ORUtoORU" target="BP.MMA.TRAKCARE.VIEWPOINT"></send>
<return></return>
</when>
</rule>
<rule name="Prescriptions TrakCare pour Glims" disabled="false">
<constraint name="source" value="TRAKCARE.ORM.GLIMS.TCP"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.DTL.TCtoGLIMS.ORMtoOML" target="GLIMS.OML.File"></send>
<return></return>
</when>
</rule>
<rule name="Prescriptions TrakCare pour VENUS" disabled="false">
<constraint name="source" value="TRAKCARE.ORM.VENUS.TCP"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.DTL.TCtoVENUS.ORMtoORM" target="VENUS.ORM.TCP"></send>
<return></return>
</when>
</rule>
<rule name="Prescriptions TrakCare pour VENUS (St Palais)" disabled="false">
<constraint name="source" value="TRAKCARE.ORMsp.VENUS.TCP"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.DTL.TCtoVENUS.ORMtoORMsp" target="VENUS.ORM.TCP"></send>
<return></return>
</when>
</rule>
<rule name="Diagnostics TRAKCARE" disabled="false">
<constraint name="source" value="TRAKCARE.IN.TCP"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docCategory" value="2.4"></constraint>
<when condition="((Document.{EVN:EventTypeCode}=&quot;A08&quot;)||(Document.{EVN:EventTypeCode}=&quot;A03&quot;))&amp;&amp;(Length(Document.{DG1(1):SetIDDG1})!=0)">
<send transform="" target="BP.TCtoCCOM.SplitDiags"></send>
<return></return>
</when>
</rule>
<rule name="Diagnostics TRAKCARE" disabled="false">
<constraint name="source" value="BP.TCtoCCOM.SplitDiags"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docCategory" value="2.4"></constraint>
<when condition="((Document.{EVN:EventTypeCode}=&quot;A08&quot;)||(Document.{EVN:EventTypeCode}=&quot;A03&quot;))&amp;&amp;(Length(Document.{DG1(1):SetIDDG1})!=0)">
<send transform="ISSAS.Common.DTL.TCtoCCOM.ADTtoDIG" target="CLINICOM.TCP"></send>
<return></return>
</when>
</rule>
<rule name="Résultats HEMO SERVEUR" disabled="false">
<constraint name="source" value="HEMOS.HMV.File"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.HPRIMv2HL7"></constraint>
<constraint name="docCategory" value="HPRIMV2"></constraint>
<constraint name="docType" value="HMV"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.HEMOStoTC.HMVtoORU" target="TRAKCARE.ORU.HEMOS.TCP"></send>
<return></return>
</when>
</rule>
<rule name="Ordonnances IMAGE PHARMA" disabled="false">
<constraint name="source" value="IMAGE.ORDO.File"></constraint>
<constraint name="docType" value="ISSAS.Sites.Bayonne.PRD.VDoc.ImagePharmaCession:PH"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.IMAGEtoTC.PHtoORU" target="TRAKCARE.ORU.IMAGE.TCP"></send>
<return></return>
</when>
</rule>
<rule name="Résultats VENUS" disabled="false">
<constraint name="source" value="VENUS.ORU.File"></constraint>
<constraint name="docType" value="ISSAS.Sites.Bayonne.PRD.VDoc.SIR5:ORU_R01"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.VENUStoCCOM.ORUtoORU" target="CLINICOM.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.VENUStoTC.ORUtoORU" target="TRAKCARE.ORU.VENUS.TCP"></send>
<return></return>
</when>
</rule>
<rule name="MàJ prescriptions VENUS" disabled="false">
<constraint name="source" value="VENUS.ORM.File"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.DTL.VENUStoTC.ORMtoORM" target="TRAKCARE.ORM.VENUS.TCPOut"></send>
<return></return>
</when>
</rule>
<rule name="RDV TRAKCARE (Agenda) " disabled="false">
<constraint name="source" value="TRAKCARE.IN.TCP"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docCategory" value="2.4"></constraint>
<constraint name="docType" value="SIU_S12"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.TCtoCCOM.SIUtoSIU" target="CLINICOM.TCP"></send>
<return></return>
</when>
</rule>
<rule name="Résultats AxBiocean pour TRAK" disabled="false">
<constraint name="source" value="AxBiocean.ORU.FTP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.HPRIMv2HL7"></constraint>
<constraint name="docCategory" value="HPRIMV2"></constraint>
<constraint name="docType" value="ORU"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.DTL.AXBIOCEANtoTC.ORUtoORU" target="TRAKCARE.ORU.AXBIOCEAN.TCP"></send>
</when>
</rule>
<rule name="Résultats Hémadialyse pour TRAK" disabled="false">
<constraint name="source" value="Hemadialyse.ORU.FTP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.HPRIMv2HL7"></constraint>
<constraint name="docCategory" value="HPRIMV2"></constraint>
<constraint name="docType" value="ORU"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.DTL.HEMADIALtoTC.ORUtoORU" target="BP.MMA.TRAKCARE.HEMADIALYSE"></send>
</when>
</rule>
<rule name="Rendez-vous TRAK" disabled="false">
<constraint name="source" value="TRAKCARE.SIU.TCP"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="SIU_S12"></constraint>
<when condition="&quot;,S23,S24&quot; [ Document.{MSH:MessageType.triggerevent}">
<send transform="" target="MONDOCTEUR.SIU.OUT.TCP"></send>
</when>
<otherwise>
<send transform="ISSAS.Common.DTL.TCtoMONDOCTEUR.SIUtoSIU" target="MONDOCTEUR.SIU.OUT.TCP"></send>
<send transform="ISSAS.Common.DTL.TCtoCCOM.SIUtoSIU" target="CLINICOM.TCP"></send>
</otherwise>
</rule>
<rule name="Rendez-vous TRAK (SUI S23/S24)" disabled="false">
<constraint name="source" value="TRAKCARE.SIU.TCP"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="SIU_S24"></constraint>
<when condition="1">
<send transform="" target="DOCTOLIB.POST.HTTP"></send>
</when>
</rule>
<assign property="@DoctoLibExcludeResources" value="ISSASOBJClassMethodWithQuit3Args(&quot;ISSAS.Common.Tools.ClassTools&quot;,&quot;GetSettingFromItemName&quot;,&quot;BPLDoctolib&quot;,&quot;&quot;)"></assign>
<rule name="Rendez-vous TRAK pour DOCTOLIB" disabled="false">
<constraint name="source" value="TRAKCARE.SIU.TCP"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="SIU_S12"></constraint>
<when condition="(Document.{MSH:MessageType.MessageCode}=&quot;SIU&quot;) &amp;&amp; (Document.{MSH:MessageType.triggerevent}!=&quot;S26&quot;) &amp;&amp; (Lookup(@DoctoLibExcludeResources,Document.{RGSgrp(1).AIGgrp(1).AIG:ResourceType.Identifier})!=&quot;0&quot;)">
<send transform="ISSAS.Common.DTL.Doctolib.TCSIUtoDoctolibSIU" target="DOCTOLIB.POST.HTTP"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
