Class AGIRHtoKITRY.Formations Extends Ens.DataTransformDTL [ DependsOn = (AGIRH.Formations.BatchIn, KITRY.Formations.BatchOut) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='AGIRH.Formations.BatchIn' targetClass='KITRY.Formations.BatchOut' create='new' language='objectscript' >
<foreach property='source.Records()' key='indice' >
<if condition='indice&gt;1' >
<true>
<assign value='$zstrip(source.Records.(indice).Matricule,"&gt;W")' property='target.Records.(indice).Matricule' action='set' />
<if condition='$zstrip(source.Records.(indice).NuméroFormation,"&gt;W")=""' >
<true>
<assign value='"000000"' property='target.Records.(indice).CodeFormation' action='set' />
</true>
<false>
<assign value='$zstrip(source.Records.(indice).NuméroFormation,"&gt;W")' property='target.Records.(indice).CodeFormation' action='set' />
</false>
</if>
<assign value='$zstrip(source.Records.(indice).IntituléFormation,"&gt;W")' property='target.Records.(indice).IntituléFormation' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateDébut,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateDébut' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateFin,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateFin' action='set' />
<assign value='$zstrip(source.Records.(indice).CommentaireFormation,"&gt;W")' property='target.Records.(indice).Commentaire' action='set' />
</true>
</if>
</foreach>
</transform>
}

}
