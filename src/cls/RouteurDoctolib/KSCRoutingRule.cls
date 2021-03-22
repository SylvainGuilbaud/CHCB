/// 
Class RouteurDoctolib.KSCRoutingRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.VDocRuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.VDocRoutingEngine" production="KSC.PROD.Formation">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="RdV from DOCTOLIB" disabled="true">
<constraint name="source" value="EnsClinicomTRNIn"></constraint>
<constraint name="msgClass" value="EnsLib.HL7.Message"></constraint>
<constraint name="docCategory" value="2.5"></constraint>
<constraint name="docName" value="SRM_S01,SRM_S02,SRM_S03,SRM_S04,SRM_S05,SRM_S06,SRM_S07,SRM_S08,SRM_S09,SRM_S10,SRM_S11"></constraint>
<when condition="1">
<send transform="KSC.DTL.Doctolib" target="Mail.KSC"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
