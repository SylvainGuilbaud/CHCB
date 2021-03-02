Class sg.record.transfo.person Extends Ens.DataTransformDTL [ DependsOn = sg.record.person.Batch ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='sg.record.person.Batch' targetClass='sg.record.person.Batch' create='new' language='objectscript' >
<foreach property='source.Records()' key='k1' >
<assign value='..ToUpper(source.Records.(k1).name)' property='target.Records.(k1).name' action='set' />
<assign value='..ConvertDateTime(source.Records.(k1).dob,"%d/%m/%Y","%Y-%m-%d")' property='target.Records.(k1).dob' action='set' />
<assign value='..ToUpper(source.Records.(k1).city)' property='target.Records.(k1).city' action='set' />
</foreach>
</transform>
}

}
