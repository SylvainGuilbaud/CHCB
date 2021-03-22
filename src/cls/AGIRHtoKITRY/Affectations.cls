Class AGIRHtoKITRY.Affectations Extends Ens.DataTransformDTL [ DependsOn = (AGIRH.Affectations.BatchIn, KITRY.Affectations.BatchOut) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='AGIRH.Affectations.BatchIn' targetClass='KITRY.Affectations.BatchOut' create='new' language='objectscript' >
<foreach property='source.Records()' key='indice' >
<if condition='indice&gt;1' >
<true>
<assign value='$zstrip(source.Records.(indice).Matricule,"&gt;W")' property='target.Records.(indice).Matricule' action='set' />
<assign value='"0"' property='target.Records.(indice).Racine' action='set' />
<assign value='$zstrip(source.Records.(indice).UF,"&gt;W")' property='target.Records.(indice).UF' action='set' />
<assign value='""' property='target.Records.(indice).TypeUF' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateEffetAffectation,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateDébut' action='set' />
<if condition='$E(source.Records.(indice).DateFinAffectation,1,4)="3000"' >
<true>
<assign value='""' property='target.Records.(indice).DateFin' action='set' />
</true>
<false>
<assign value='..ConvertDateTime($E(source.Records.(indice).DateFinAffectation,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateFin' action='set' />
</false>
</if>
<if condition='source.Records.(indice).TypeAffectation="P"' >
<true>
<assign value='..Round($number(source.Records.(indice).TempsdeAffPrincnum,",")*100,1)' property='target.Records.(indice).Pourcentage' action='set' />
</true>
<false>
<assign value='..Round($number(source.Records.(indice).TempsdeAffSecnum,",")*100,1)' property='target.Records.(indice).Pourcentage' action='set' />
</false>
</if>
</true>
</if>
</foreach>
</transform>
}

}
