Class AGIRHtoKITRY.Absences Extends Ens.DataTransformDTL [ DependsOn = (AGIRH.Absences.BatchIn, KITRY.Absences.BatchOut) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='AGIRH.Absences.BatchIn' targetClass='KITRY.Absences.BatchOut' create='new' language='objectscript' >
<foreach property='source.Records()' key='indice' >
<if condition='indice&gt;1' >
<true>
<assign value='$zstrip(source.Records.(indice).Matricule,"&gt;W")' property='target.Records.(indice).Matricule' action='set' />
<assign value='$zstrip(source.Records.(indice).CodeAbsenceQualifiée,"&gt;W")' property='target.Records.(indice).CodeAbsenceQualifiée' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléAbsenceQualifiée,"&gt;W")' property='target.Records.(indice).LibelléAbsenceQualifiée' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateDébutAbsence,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateDébutAbsence' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateFinAbsenceCalculée,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateFinAbsenceCalculée' action='set' />
</true>
</if>
</foreach>
</transform>
}

}
