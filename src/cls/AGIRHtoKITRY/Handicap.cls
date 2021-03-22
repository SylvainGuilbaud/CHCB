Class AGIRHtoKITRY.Handicap Extends Ens.DataTransformDTL [ DependsOn = (AGIRH.Handicap.BatchIn, KITRY.Handicap.BatchOut) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='AGIRH.Handicap.BatchIn' targetClass='KITRY.Handicap.BatchOut' create='new' language='objectscript' >
<foreach property='source.Records()' key='indice' >
<if condition='indice&gt;1' >
<true>
<assign value='$zstrip(source.Records.(indice).Matricule,"&gt;W")' property='target.Records.(indice).Matricule' action='set' />
<if condition='..In($zstrip(source.Records.(indice).NatureHandicap,"&gt;W"),"C,01")' >
<true>
<assign value='"O"' property='target.Records.(indice).RQTH' action='set' />
</true>
<false>
<assign value='"N"' property='target.Records.(indice).RQTH' action='set' />
</false>
</if>
<assign value='source.Records.(indice).NatureHandicap' property='target.Records.(indice).CatégorieInvalidité' action='set' />
<assign value='source.Records.(indice).TauxHandicap' property='target.Records.(indice).TauxInvalidité' action='set' />
<assign value='source.Records.(indice).CatégorieHandicap' property='target.Records.(indice).CodeHandicap' action='set' />
<assign value='source.Records.(indice).LibelléCatégorieHandicap' property='target.Records.(indice).LibelléHandicap' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateEffetHandicap,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateDébutRQTH' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateFinHandicap,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateFinRQTH' action='set' />
</true>
</if>
</foreach>
</transform>
}

}
