/// 
Class KSC.FromVenus1 Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.HL7.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="KSC.FromVenus" context="EnsLib.HL7.MsgRouter.RoutingEngine" production="KSC.PROD.Formation">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="From Venus to TrakCare">
<constraint name="docCategory" value="2.5.1"></constraint>
<constraint name="docName" value="ADT_A01"></constraint>
<when condition="Document.{MSH:SendingApplication.NamespaceID}=&quot;VENUS&quot;">
<send transform="" target="ToTrakCare"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
