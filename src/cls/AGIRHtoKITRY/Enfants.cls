Class AGIRHtoKITRY.Enfants Extends Ens.DataTransformDTL [ DependsOn = (AGIRH.Enfants.BatchIn, KITRY.Enfants.BatchOut) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='AGIRH.Enfants.BatchIn' targetClass='KITRY.Enfants.BatchOut' create='new' language='objectscript' >
<foreach property='source.Records()' key='indice' >
<if condition='indice&gt;1' >
<true>
<assign value='$zstrip(source.Records.(indice).Matricule,"&gt;W")' property='target.Records.(indice).Matricule' action='set' />
<assign value='..ReplaceStr($zstrip(source.Records.(indice).NomPrénomEnfant,"&gt;W"),"  "," ")' property='target.Records.(indice).NomPrénomEnfant' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateNaissanceEnfant,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateNaissanceEnfant' action='set' />
<assign value='source.Records.(indice).SexeEnfant' property='target.Records.(indice).SexeEnfant' action='set' />
<if condition='source.Records.(indice).CodeSuspensionEnfant="1"' >
<true>
<assign value='"01/01/1900"' property='target.Records.(indice).DateDécèsEnfant' action='set' />
</true>
<false>
<assign value='""' property='target.Records.(indice).DateDécèsEnfant' action='set' />
</false>
</if>
<assign value='$zstrip(source.Records.(indice).CodeSFT,"&gt;W")' property='target.Records.(indice).CodeACharge' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléSFT,"&gt;W")' property='target.Records.(indice).LibelléACharge' action='set' />
</true>
</if>
</foreach>
</transform>
}

}
