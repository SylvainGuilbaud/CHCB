/// 
Class ISSAS.Sites.Bayonne.TRN.Prod.RouterDoctolibHL7RoutingRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.HL7.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.VDocRoutingEngine" production="ISSAS.Sites.Bayonne.TRN.Prod.Production">
<variable name="AssigningAuthority"></variable>
<ruleSet name="Doctolib" effectiveBegin="" effectiveEnd="">
<rule name="Création identité (A28) pour agendas" disabled="false">
<constraint name="source" value="BPLDoctolib"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="ADT_A28"></constraint>
<when condition="Document.{EVN:EventTypeCode}=&quot;A28&quot;">
<send transform="ISSAS.Common.DTL.Doctolib.CCOMADTA28ToTCADTA28" target="TRAKCARE.SRM.DOCTOLIB.TCP"></send>
</when>
</rule>
<rule name="Modification identité (A08) pour agendas" disabled="false">
<constraint name="source" value="BPLDoctolib"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="ADT_A08"></constraint>
<when condition="Document.{MSH:MessageType}=&quot;SIU^A08&quot;">
<send transform="ISSAS.Common.DTL.Doctolib.A08toTCA31" target="TRAKCARE.SRM.DOCTOLIB.TCP"></send>
</when>
</rule>
<rule name="Fusion identité (A40) pour Doctolib" disabled="false">
<constraint name="source" value="BPLDoctolib"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="ADT_A40"></constraint>
<when condition="Document.{EVN:EventTypeCode}=&quot;A40&quot;">
<send transform="ISSAS.Common.DTL.Doctolib.ADTtoA40Direct" target="DOCTOLIB.ADT.HTTP"></send>
</when>
</rule>
<rule name="Création pré-admission / pré-consultation (A05) pour agendas" disabled="false">
<constraint name="source" value="BPLDoctolib"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="ADT_A05"></constraint>
<when condition="Document.{EVN:EventTypeCode}=&quot;A05&quot;">
<send transform="" target="&quot;&quot;"></send>
</when>
</rule>
<rule name="RDV (SIU_SXX) pour agendas" disabled="false">
<constraint name="source" value="BPLDoctolib"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="SIU_SXX"></constraint>
<when condition="(Document.{MSH:MessageType.MessageCode}=&quot;SIU&quot;) &amp;&amp; (Document.{MSH:MessageType.TriggerEvent} != &quot;S26&quot;) ">
<send transform="ISSAS.Common.DTL.Doctolib.TCSIUtoCCOMSIU" target="CLINICOM.TCP,HealthConnect.Clinicom.TCP"></send>
</when>
</rule>
<assign property="@AssigningAuthority" value="ISSASOBJClassMethodWithQuit1Arg(&quot;ISSAS.Common.DTL.Doctolib.DoctolibUtils&quot;,&quot;GetClinicomAssigningAuthority&quot;,&quot;2.5&quot;)"></assign>
<rule name="Rendez-vous DOCTOLIB pour TRAK" disabled="false">
<constraint name="source" value="BPLDoctolib"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="SIU_S12"></constraint>
<when condition="(Document.{PIDgrp(1).PID:PatientIdentifierList(1).AssigningAuthority}=@AssigningAuthority) &amp;&amp; (&quot;,S12,S15,&quot; [ (&quot;,&quot; _ Document.{MSH:MessageType.TriggerEvent} _ &quot;,&quot;))">
<send transform="ISSAS.Common.DTL.Doctolib.SIUtoSRM" target="TRAKCARE.SRM.DOCTOLIB.TCP"></send>
</when>
<when condition="(Document.{PIDgrp(1).PID:PatientIdentifierList(1).AssigningAuthority}=@AssigningAuthority) &amp;&amp; (&quot;,S13,S14,&quot; [ (&quot;,&quot; _ Document.{MSH:MessageType.TriggerEvent} _ &quot;,&quot;))">
<send transform="ISSAS.Common.DTL.Doctolib.SIUtoSRMUPD1" target="TRAKCARE.SRM.DOCTOLIB.TCP"></send>
<send transform="ISSAS.Common.DTL.Doctolib.SIUtoSRMUPD2" target="TRAKCARE.SRM.DOCTOLIB.TCP"></send>
</when>
<when condition="(Document.{PIDgrp(1).PID:PatientIdentifierList(1).AssigningAuthority}=@AssigningAuthority) &amp;&amp; (&quot;,S17,&quot; [ (&quot;,&quot;_Document.{MSH:MessageType.TriggerEvent}_&quot;,&quot;))">
<send transform="ISSAS.Common.DTL.Doctolib.SIUtoSRMUPD1" target="TRAKCARE.SRM.DOCTOLIB.TCP"></send>
</when>
</rule>
<rule name="Envoi du numéro d&apos;épisode créé par SIU_S14 pour Doctolib" disabled="false">
<constraint name="source" value="BPLDoctolib"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docType" value="SIU_SXX"></constraint>
<when condition="(Document.{MSH:MessageType} = &quot;SIU^S14&quot;) &amp;&amp; (Document.{MSH:SendingApplication.NamespaceID} != &quot;Doctolib&quot;)">
<send transform="ISSAS.Common.DTL.Doctolib.SIU14toDLSIU14" target="DOCTOLIB.ADT.HTTP"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
