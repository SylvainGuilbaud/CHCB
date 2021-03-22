/// 
Class KSC.Regles.RouteurDEPT Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="KSC.PROD.Formation">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="Departement contient A/a">
<constraint name="source" value="FromDEPT"></constraint>
<constraint name="msgClass" value="KSC.MessageDPT.Record"></constraint>
<when condition="ToUpper(Document.Nom) Contains &quot;AL&quot;">
<send transform="" target="ToDEPTOut"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
