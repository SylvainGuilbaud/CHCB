Class KSC.DTL.Doctolib Extends Ens.DataTransformDTL [ DependsOn = (ISSAS.Common.Message.ClinicomHL7, Ens.AlertRequest) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='ISSAS.Common.Message.ClinicomHL7' targetClass='Ens.AlertRequest' sourceDocType='2.5:SRM_S01' create='new' language='objectscript' >
<assign value='source.{PIDgrp(1).PID:PatientName().GivenName}_" "_source.{PIDgrp(1).PID:PatientName().FamilyName}_", dont l&apos;IPP est "_source.{PIDgrp(1).PID:PatientIdentifierList().IDNumber}_", doit venir en RdV le "_##class(ISSAS.Common.Tools.ClassDate).CvtCCOMToFRENCH(source.{ARQ:RequestedStartDateTimeRange()},1)' property='target.AlertText' action='set' />
</transform>
}

}
