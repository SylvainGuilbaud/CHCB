/// 
Class Router.KitryRoutingRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.RoutingEngine" production="KSC.PROD.Formation">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="Arborescence CHCB">
<constraint name="source" value="FTP.CHCB.Arborescence.FromAGIRH"></constraint>
<constraint name="msgClass" value="AGIRH.Arborescence.BatchIn"></constraint>
<when condition="1">
<send transform="AGIRHtoKITRY.Arborescence" target="FTP.CHCB.Arborescence.ToKITRY"></send>
<return></return>
</when>
</rule>
<rule name="Affectations CHCB" disabled="false">
<constraint name="source" value="FTP.CHCB.Affectation.FromAGIRH"></constraint>
<constraint name="msgClass" value="AGIRH.Affectations.BatchIn"></constraint>
<when condition="1">
<send transform="AGIRHtoKITRY.Affectations" target="FTP.CHCB.Affectations.ToKITRY"></send>
<return></return>
</when>
</rule>
<rule name="Personnes CHCB" disabled="false">
<constraint name="source" value="FTP.CHCB.Personnes.FromAGIRH"></constraint>
<constraint name="msgClass" value="AGIRH.Personnes.BatchIn"></constraint>
<when condition="1">
<send transform="AGIRHtoKITRY.Personnes" target="FTP.CHCB.Personnes.ToKITRY"></send>
<return></return>
</when>
</rule>
<rule name="Handicap CHCB" disabled="false">
<constraint name="source" value="FTP.CHCB.Handicap.FromAGIRH"></constraint>
<constraint name="msgClass" value="AGIRH.Handicap.BatchIn"></constraint>
<when condition="1">
<send transform="AGIRHtoKITRY.Handicap" target="FTP.CHCB.Handicap.ToKITRY"></send>
<return></return>
</when>
</rule>
<rule name="Accidents CHCB" disabled="false">
<constraint name="source" value="FTP.CHCB.Accidents.FromAGIRH"></constraint>
<constraint name="msgClass" value="AGIRH.Accidents.BatchIn"></constraint>
<when condition="1">
<send transform="AGIRHtoKITRY.Accidents" target="FTP.CHCB.Accidents.ToKITRY"></send>
<return></return>
</when>
</rule>
<rule name="Formations CHCB" disabled="false">
<constraint name="source" value="FTP.CHCB.Formations.FromAGIRH"></constraint>
<constraint name="msgClass" value="AGIRH.Formations.BatchIn"></constraint>
<when condition="1">
<send transform="AGIRHtoKITRY.Formations" target="FTP.CHCB.Formations.ToKITRY"></send>
<return></return>
</when>
</rule>
<rule name="Enfants CHcB" disabled="false">
<constraint name="source" value="FTP.CHCB.Enfants.FromAGIRH"></constraint>
<constraint name="msgClass" value="AGIRH.Enfants.BatchIn"></constraint>
<when condition="1">
<send transform="AGIRHtoKITRY.Enfants" target="FTP.CHCB.Enfants.ToKITRY"></send>
<return></return>
</when>
</rule>
<rule name="Absences CHCB" disabled="false">
<constraint name="source" value="FTP.CHCB.Absences.FromAGIRH"></constraint>
<constraint name="msgClass" value="AGIRH.Absences.BatchIn"></constraint>
<when condition="1">
<send transform="AGIRHtoKITRY.Absences" target="FTP.CHCB.Absences.ToKITRY"></send>
<return></return>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
