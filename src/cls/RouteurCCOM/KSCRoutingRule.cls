/// 
Class RouteurCCOM.KSCRoutingRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.VDocRuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.VDocRoutingEngine" production="KSC.PROD.Formation">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="PB (Identite Std CWS)" disabled="false">
<constraint name="source" value="TCP.Ensemble.CwsTRN.StdIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docName" value="PB"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoTITAN25.PBtoADT" target="TitanQ.ADT.Files"></send>
<return></return>
</when>
</rule>
<rule name="AD (Admission Std CWS)" disabled="false">
<constraint name="source" value="TCP.Ensemble.CwsTRN.StdIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docName" value="AD"></constraint>
<when condition="Lookup(Document.{AD3:AD301Hopital.CodeEtablissement},&quot;CCOM_HL7_EHPAD&quot;)=&quot;&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoTITAN25.ADtoADT" target="TitanQ.ADT.Files"></send>
<return></return>
</when>
</rule>
<rule name="DS (Sortie Std CWS)" disabled="false">
<constraint name="source" value="TCP.Ensemble.CwsTRN.StdIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docName" value="DS"></constraint>
<when condition="Lookup(Document.{DS:DS02Hopital.CodeEtablissement},&quot;CCOM_HL7_EHPAD&quot;)=&quot;&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoTITAN25.DStoADT" target="TitanQ.ADT.Files"></send>
<return></return>
</when>
</rule>
<rule name="RI (Retour Std CWS)" disabled="false">
<constraint name="source" value="TCP.Ensemble.CwsTRN.StdIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docName" value="RI"></constraint>
<when condition="Document.{RI:RI02CodeHopital}=&quot;GARA&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoTITAN25.RItoADT" target="TitanQ.ADT.Files"></send>
<return></return>
</when>
</rule>
<rule name="SD (Départ Std CWS)" disabled="false">
<constraint name="source" value="TCP.Ensemble.CwsTRN.StdIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docName" value="SD"></constraint>
<when condition="Document.{SD:SD02CodeHopital}=&quot;GARA&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoTITAN25.SDtoADT" target="TitanQ.ADT.Files"></send>
<return></return>
</when>
</rule>
<rule name="TR (Mutation Std CWS)" disabled="false">
<constraint name="source" value="TCP.Ensemble.CwsTRN.StdIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docName" value="TR"></constraint>
<when condition="Lookup(Document.{TR:TR02CodeHopital.CodeEtablissement},&quot;CCOM_HL7_EHPAD&quot;)=&quot;&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoTITAN25.TRtoADT" target="TitanQ.ADT.Files"></send>
<return></return>
</when>
</rule>
<rule name="AD (Admission Hosp)" disabled="true">
<constraint name="source" value="EnsClinicomTRNIn"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docCategory" value="2.5"></constraint>
<constraint name="docName" value="ADT_A01,ADT_A06"></constraint>
<when condition="1">
<send transform="" target="Titan.Files.ADT"></send>
<return></return>
</when>
</rule>
<rule name="PA (Pré Admission)" disabled="true">
<constraint name="source" value="EnsClinicomTRNIn"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docCategory" value="2.5"></constraint>
<constraint name="docName" value="ADT_A05,ADT_A11"></constraint>
<when condition="1">
<send transform="" target="Titan.Files.ADT"></send>
<return></return>
</when>
</rule>
<rule name="PB (Données patient)" disabled="true">
<constraint name="source" value="EnsClinicomTRNIn"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docCategory" value="2.5"></constraint>
<constraint name="docName" value="ADT_A28,ADT_A29,ADT_A31"></constraint>
<when condition="1">
<send transform="" target="Titan.Files.ADT"></send>
<return></return>
</when>
</rule>
<rule name="PM (Fusion identité)" disabled="true">
<constraint name="source" value="EnsClinicomTRNIn"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docCategory" value="2.5"></constraint>
<constraint name="docName" value="ADT_A40,ADT_A44"></constraint>
<when condition="1">
<send transform="" target="Titan.Files.ADT"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
