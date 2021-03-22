/// 
Class Router.GTTRoutingRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="KSC.PROD.Formation">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="Nomenclature du CHCB">
<constraint name="source" value="GTT.CHCB.Nomenclature.FromMIPIH"></constraint>
<constraint name="msgClass" value="AGIRH.Nomenclature.BatchIn"></constraint>
<when condition="1">
<send transform="AGIRHtoCHRONOS.Nomenclature" target="GTT.CHCB.Nomenclature.ToCHRONOS"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
