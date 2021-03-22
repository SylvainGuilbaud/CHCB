/// 
Class KSC.FileToMail Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.VDocRuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.VDocRoutingEngine" production="KSC.PROD.Formation">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="">
<constraint name="source" value="FileToMail"></constraint>
<when condition="1">
<send transform="KSC.DTL.Alert" target="Mail.KSC"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
