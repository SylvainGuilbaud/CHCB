Class ISSAS.Sites.Bayonne.PRD.DTL.QPLANNERtoCCOM.SIUtoSIU Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.HL7.Message, ISSAS.Common.Message.ClinicomHL7) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='ISSAS.Common.Message.ClinicomHL7' sourceDocType='2.3.1:SIU_S12' targetDocType='ClinicomReceiver:SIU' create='new' language='objectscript' >
<assign value='"QPLANNER"' property='target.{MSH:MSH03SendingApplication}' action='set' />
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
<assign value='"QPLANNER"' property='target.{SIU:SIU02IdentifiantModuleProduc}' action='set' />
<assign value='source.{SCH:FillerAppointmentID.entityidentifier}' property='target.{SIU:SIU03IdentifiantUniqueRDV}' action='set' />
<assign value='"P"' property='target.{SIU:SIU04TypeEntiteAttendue}' action='set' />
<assign value='source.{PIDgrp(1).PID:PatientIdentifierList(1).ID}' property='target.{SIU:SIU05IPP}' action='set' />
<assign value='source.{SCH:PlacerContactPerson(1)}' property='target.{SIU:SIU06CodeAgenda}' action='set' />
<assign value='$E(source.{SCH:AppointmentTimingQuantity(1).startdatetime},1,12)' property='target.{SIU:SIU07DateHeureDebutRDV}' action='set' />
<assign value='$E(source.{SCH:AppointmentTimingQuantity(1).enddatetime},1,12)' property='target.{SIU:SIU08DateHeureFinRDV}' action='set' />
<if condition='$L(source.{SCH:FillerStatusCode.text})'>
<true>
<assign value="..Lookup(&quot;ISSAS.Sites.Bayonne.PRD.LUT.Qplanner_StatutRDV&quot;,source.{SCH:FillerStatusCode.text})" property='target.{SIU:SIU09StatutRDV}' action='set' />
</true>
<false>
<assign value="..Lookup(&quot;ISSAS.Sites.Bayonne.PRD.LUT.Qplanner_StatutRDV&quot;,source.{SCH:FillerStatusCode})" property='target.{SIU:SIU09StatutRDV}' action='set' />
</false>
</if>
<assign value='"9999"' property='target.{SIU:SIU10PrestationAgenda}' action='set' />
<assign value='"0"' property='target.{SIU:SIU11TypeRessource}' action='set' />
<assign value='source.{RGSgrp(1).AIPgrp(1).AIP:PersonnelResourceID(1).IDnumberST}' property='target.{SIU:SIU12CodeRessource}' action='set' />
<assign value='source.{RGSgrp(1).AIPgrp(1).NTE(1):Comment(1)}' property='target.{SIU:SIU14Commentaire}' action='set' />
<assign value='source.{RGSgrp(1).AISgrp(1).AIS:UniversalServiceID.text}' property='target.{SIU:SIU14Commentaire}' action='set' />
</transform>
}

}
