Class AGIRHtoKITRY.Accidents Extends Ens.DataTransformDTL [ DependsOn = (AGIRH.Accidents.BatchIn, KITRY.Accidents.BatchOut) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='AGIRH.Accidents.BatchIn' targetClass='KITRY.Accidents.BatchOut' create='new' language='objectscript' >
<foreach property='source.Records()' key='indice' >
<if condition='indice&gt;1' >
<true>
<assign value='$zstrip(source.Records.(indice).Matricule,"&gt;W")' property='target.Records.(indice).Matricule' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateEffetAT,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateAT' action='set' />
<if condition='source.Records.(indice).HeureAT="0"' >
<true>
<assign value='"00:00"' property='target.Records.(indice).HeureAT' action='set' />
</true>
<false>
<assign value='$number(source.Records.(indice).HeureAT)\60' property='target.Records.(indice).HeureAT' action='set' disabled='1' />
<assign value='$number(source.Records.(indice).HeureAT)\60' property='H' action='set' />
<assign value='$number(source.Records.(indice).HeureAT)#60' property='M' action='set' />
<assign value='$extract("0"_H,*-1)_$extract("0"_H,*)_":"_$extract("0"_M,*-1)_$extract("0"_M,*)' property='Tmp' action='set' />
<assign value='Tmp' property='target.Records.(indice).HeureAT' action='set' />
</false>
</if>
<assign value='source.Records.(indice).NatureAT' property='target.Records.(indice).CodeTypeAT' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléNatureAT,"&gt;W")' property='target.Records.(indice).LibelléTypeAT' action='set' />
<assign value='$zstrip(source.Records.(indice).CommentaireAT,"&gt;W")' property='target.Records.(indice).Circonstances' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateduCertificatMédical,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateDéclaration' action='set' />
<assign value='source.Records.(indice).ElémentMatérielAT' property='target.Records.(indice).CodeElemMat1' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléElémentMatérielAT,"&gt;W")' property='target.Records.(indice).LibElemMat1' action='set' />
<assign value='source.Records.(indice).SiègeAT' property='target.Records.(indice).CodeSiège1' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléSiègeAT,"&gt;W")' property='target.Records.(indice).LibelléSiège1' action='set' />
</true>
</if>
</foreach>
</transform>
}

}
