Class KSC.DTL.Alert Extends Ens.DataTransformDTL [ DependsOn = (Ens.StreamContainer, Ens.AlertRequest) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Ens.StreamContainer' targetClass='Ens.AlertRequest' create='new' language='objectscript' >
<assign value='source.OriginalFilename' property='target.AlertText' action='set' />
</transform>
}

}
