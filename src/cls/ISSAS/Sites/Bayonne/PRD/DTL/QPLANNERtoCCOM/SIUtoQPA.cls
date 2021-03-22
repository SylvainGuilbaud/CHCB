Class ISSAS.Sites.Bayonne.PRD.DTL.QPLANNERtoCCOM.SIUtoQPA Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.HL7.Message, ISSAS.Common.Message.ClinicomHL7) ]
{

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='ISSAS.Common.Message.ClinicomHL7' sourceDocType='2.3.1:SIU_S12' targetDocType='ClinicomReceiver:QPA' create='new' language='objectscript' >
<assign value='source.{MSH:SendingApplication}' property='target.{MSH:MSH03SendingApplication}' action='set' />
<if condition='source.{MSH:MessageType.triggerevent}="S12"'>
<true>
<assign value='"01"' property='target.{QPA:QPA01CodeAction}' action='set' />
</true>
</if>
<if condition='source.{MSH:MessageType.triggerevent}="S13"'>
<true>
<assign value='"02"' property='target.{QPA:QPA01CodeAction}' action='set' />
</true>
</if>
<if condition='source.{MSH:MessageType.triggerevent}="S14"'>
<true>
<assign value='"02"' property='target.{QPA:QPA01CodeAction}' action='set' />
</true>
</if>
<if condition='source.{MSH:MessageType.triggerevent}="S15"'>
<true>
<assign value='"03"' property='target.{QPA:QPA01CodeAction}' action='set' />
</true>
</if>

<if condition='source.{PIDgrp(1).PV1:PatientClass}="I"'>
<true>
<assign value='"HCO"' property='target.{QPA:QPA02TypeEpisode}' action='set' />
</true>
</if>
<if condition='source.{PIDgrp(1).PV1:PatientClass}="O"'>
<true>
<assign value='"EXT"' property='target.{QPA:QPA02TypeEpisode}' action='set' />
</true>
</if>
<assign value='$E(source.{MSH:DateTimeOfMessage},1,12)' property='target.{QPA:QPA03DateHeureCreation}' action='set' />
<assign value='$E(source.{PIDgrp(1).PV1:AdmitDateTime},1,12)' property='target.{QPA:QPA04DateHeurePrevueAdmissio}' action='set' />
<assign value='source.{PIDgrp(1).PID:PatientIdentifierList(1).ID}' property='target.{QPA:QPA05IPP}' action='set' />
<assign value='source.{PIDgrp(1).PV1:VisitNumber.ID}' property='target.{QPA:QPA06NumeroEpisode}' action='set' />
<assign value='source.{PIDgrp(1).PV1:AssignedPatientLocation.pointofcare}' property='target.{QPA:QPA07CodeUSOuUC}' action='set' />
<assign value='source.{PIDgrp(1).PV1:AttendingDoctor(1).IDnumberST}' property='target.{QPA:QPA09CodeMedecin}' action='set' />
<assign value='"1"' property='target.{QPA:QPA10ModeEntree}' action='set' />
<assign value='"C3"' property='target.{QPA:QPA11CelluleDeGestion}' action='set' />
<code>
 Set com = $REPLACE(source.GetValueAt("NTE(1):Comment(1)"),"\.br\","- ") 
 Set com = ##class(EnsLib.HL7.Segment).UnescapeEx(com, source.Separators)
</code>
<!-- <assign value='$REPLACE(source.{NTE(1):Comment(1)},"\.br\","- ")' property='target.{QPA:QPA12Commentaire}' action='set' /> -->
<assign value='com' property='target.{QPA:QPA12Commentaire}' action='set' />
<assign value='source.{SCH:FillerAppointmentID.entityidentifier}' property='target.{QPA:QPA13NumeroItemAttente}' action='set' />
<assign value='$E(source.{SCH:AppointmentTimingQuantity(1).startdatetime},1,8)' property='target.{QPA:QPA14DateRDV}' action='set' />
</transform>
}

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

}
