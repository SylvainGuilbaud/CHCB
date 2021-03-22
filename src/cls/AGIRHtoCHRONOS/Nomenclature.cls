Class AGIRHtoCHRONOS.Nomenclature Extends Ens.DataTransformDTL [ DependsOn = (AGIRH.Nomenclature.BatchIn, CHRONOS.Nomenclature.BatchOut) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='AGIRH.Nomenclature.BatchIn' targetClass='CHRONOS.Nomenclature.BatchOut' create='new' language='objectscript' >
<foreach property='source.Records()' key='indice' >
<if condition='..In(source.Records.(indice).Type,"GRADES,PAFEMPL,PAFMETI,PSTSTAT,TUFETAB,TUFPOLE,TUFUFON")' >
<true>
<assign value='..Lookup("AGIRH_CHRONOS_Types",$zstrip(source.Records.(indice).Type,"&gt;W"))' property='target.Records.(indice).Type' action='set' />
<assign value='$zstrip(source.Records.(indice).Code,"&gt;W")' property='target.Records.(indice).Code' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléLong,"&gt;W")' property='target.Records.(indice).LibelléLong' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléCourt,"&gt;W")' property='target.Records.(indice).LibelléCourt' action='set' />
</true>
</if>
</foreach>
</transform>
}

}
