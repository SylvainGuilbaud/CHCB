/// !!! --- !!!
/// This class must be inherited for each site to manage 'SIU:SIU06CodeAgenda' field :
/// You need to create a specific lookup table for each site to put the correct value in 'SIU:SIU06CodeAgenda' field
/// !!! --- !!!
Class ISSAS.Common.DTL.TCtoCCOM.SIUtoSIU Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.HL7.Message, ISSAS.Common.Message.ClinicomHL7) ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/TCtoCCOM/SIUtoSIU.xml#5 $";

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='ISSAS.Common.Message.ClinicomHL7' sourceDocType='TrakCare:SIU_S12' targetDocType='ClinicomReceiver:SIU' create='new' language='objectscript' >
<!-- entête -->
<assign value='source.{MSH}' property='target.{MSH}' action='set' />
<assign value='"SIU"' property='target.{MSH:MSH09MessageType}' action='set' />

<!-- segment SIU : code action -->
<if condition='source.{MSH:MessageType.triggerevent}="S12"'>
<true>
<assign value='"01"' property='target.{SIU:SIU01CodeAction}' action='set' />
</true>
</if>
<if condition='source.{MSH:MessageType.triggerevent}="S13"'>
<true>
<assign value='"02"' property='target.{SIU:SIU01CodeAction}' action='set' />
</true>
</if>
<if condition='source.{MSH:MessageType.triggerevent}="S14"'>
<true>
<assign value='"02"' property='target.{SIU:SIU01CodeAction}' action='set' />
</true>
</if>
<if condition='source.{MSH:MessageType.triggerevent}="S15"'>
<true>
<assign value='"03"' property='target.{SIU:SIU01CodeAction}' action='set' />
</true>
</if>

<!-- segment SIU : other fields -->
<assign value='"TC"' property='target.{SIU:SIU02IdentifiantModuleProduc}' action='set' />
<assign value='$Replace(source.{SCH:FillerAppointmentID}, "\", ".")' property='target.{SIU:SIU03IdentifiantUniqueRDV}' action='set' />
<assign value='"P"' property='target.{SIU:SIU04TypeEntiteAttendue}' action='set' />
<assign value='source.{PIDgrp(1).PID:PatientIdentifierList(1).ID}' property='target.{SIU:SIU05IPP}' action='set' />
<assign value='$E(source.{SCH:AppointmentTimingQuantity(1).startdatetime},1,12)' property='target.{SIU:SIU07DateHeureDebutRDV}' action='set' />
<assign value='$E(source.{SCH:AppointmentTimingQuantity(1).enddatetime},1,12)' property='target.{SIU:SIU08DateHeureFinRDV}' action='set' />
<assign value='source.{RGSgrp(1).AISgrp(1).AIS:UniversalServiceIdentifier.identifierST}' property='target.{SIU:SIU10PrestationAgenda}' action='set' />
<assign value='"0"' property='target.{SIU:SIU11TypeRessource}' action='set' />
<assign value='source.{RGSgrp(1).AIGgrp(1).AIG:ResourceID.identifierST}' property='target.{SIU:SIU12CodeRessource}' action='set' />
<assign value='source.{SCH:EnteredByPerson(1).IDnumberST}' property='target.{SIU:SIU16CodeUtilisateur}' action='set' />

<!-- segment SIU : RDV status -->
<assign value='..Lookup("TC_CCOM_StatutRDV",source.{SCH:FillerStatusCode.identifierST})' property='target.{SIU:SIU09StatutRDV}' action='set' />

<!-- segment SIU : comment -->
<if condition='source.{MSH:MessageType.triggerevent}="S15"'>
<true>
<assign value='source.{SCH:EventReason.text}' property='target.{SIU:SIU14Commentaire}' action='set' />
</true>
</if>

<!-- segment SIU : code agenda -->
<!-- this class must be inherited for each site to manage 'SIU:SIU06CodeAgenda' field -->
<!-- you need to create a specific lookup table for each site to put the correct value in 'SIU:SIU06CodeAgenda' field -->
<assign value='"???"' property='target.{SIU:SIU06CodeAgenda}' action='set' />

</transform>
}

}
