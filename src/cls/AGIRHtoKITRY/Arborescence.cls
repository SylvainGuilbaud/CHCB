Class AGIRHtoKITRY.Arborescence Extends Ens.DataTransformDTL [ DependsOn = (AGIRH.Arborescence.BatchIn, KITRY.Arborescence.BatchOut) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='AGIRH.Arborescence.BatchIn' targetClass='KITRY.Arborescence.BatchOut' create='new' language='objectscript' >
<foreach property='source.Records()' key='indice' >
<if condition='indice&gt;1' >
<true>
<assign value='"52"' property='target.Records.(indice).Etablissement' action='set' />
<assign value='$zstrip(source.Records.(indice).UF,"&gt;W")' property='target.Records.(indice).UF' action='set' />
<assign value='$zstrip(..ToUpper(source.Records.(indice).LibelléUF),"&gt;W")' property='target.Records.(indice).LibelléUF' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateDébutUF,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateDébutUF' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateFinUF,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateFinUF' action='set' />
<assign value='"52"_source.Records.(indice).EtablissementGéo' property='target.Records.(indice).EtablissementGéo' action='set' />
<assign value='$zstrip(..ToUpper(source.Records.(indice).LibelléEtabGéo),"&gt;W")' property='target.Records.(indice).LibelléEtabGéo' action='set' />
<assign value='$zstrip(source.Records.(indice).Pôle,"&gt;W")' property='target.Records.(indice).Pôle' action='set' />
<assign value='$zstrip(..ToUpper(source.Records.(indice).LibelléPôle),"&gt;W")' property='target.Records.(indice).LibelléPôle' action='set' />
</true>
</if>
</foreach>
</transform>
}

}
