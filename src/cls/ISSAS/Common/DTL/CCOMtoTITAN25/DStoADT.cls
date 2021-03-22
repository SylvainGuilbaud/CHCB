Class ISSAS.Common.DTL.CCOMtoTITAN25.DStoADT Extends Ens.DataTransformDTL [ DependsOn = EnsLib.HL7.Message ]
{

Parameter IGNOREMISSINGSOURCE = 0;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='Clinicom:DS' targetDocType='HL7v25IHE:ADT_AXX' create='new' language='objectscript' >
<code>
<![CDATA[ Set strAssigningAuthority = $G(^ISSAS.Config("DTL", "AssigningAuthority", "2.5"))
 If (' $L(strAssigningAuthority)) { Set strAssigningAuthority = "CLINICOM" }
 Set target.Separators = "|^~\&"
 Set strNow = $ZDATE($PIECE($HOROLOG,",",1),8)_$E($TR($ZTIME($PIECE($HOROLOG,",",2)),":",""),1,6)_"."_$PIECE($ZTS,".",2)
 Set strGUID = ##class(%SYSTEM.Util).CreateGUID()
 Set strGUID = $REPLACE(strGUID, "{", "")
 Set strGUID = $REPLACE(strGUID, "}", "")
 Set strGUID = $REPLACE(strGUID, "-", "")
 Set strGUID = $REPLACE(strGUID, "|", "")
 Set strGUID = $EXTRACT(strGUID, 1, 16) ]]></code>
<assign value='$ZCVT(source.{MSH:MSH03SendingApplication},"U")' property='target.{MSH:SendingApplication}' action='set' />
<assign value='$ZCVT(source.{MSH:MSH04SendingFacility},"U")' property='target.{MSH:SendingFacility}' action='set' />
<assign value='$E(strNow, 1, 12)' property='target.{MSH:DateTimeOfMessage}' action='set' />
<assign value='"ADT"' property='target.{MSH:MessageType.MessageCode}' action='set' />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","DS"_source.GetValueAt("DS:DS01Mode")),"MSH:MessageType.TriggerEvent","set","")]]></code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","DS"_source.GetValueAt("DS:DS01Mode")),"MSH:MessageType.MessageStructure","set","")]]></code>
<assign value='strGUID' property='target.{MSH:MessageControlID}' action='set' />
<assign value='"2.5"' property='target.{MSH:VersionID}' action='set' />
<assign value='"FRA"' property='target.{MSH:CountryCode}' action='set' />
<assign value='"8859/1"' property='target.{MSH:CharacterSet}' action='set' />
<assign value='"FR"' property='target.{MSH:PrincipalLanguageOfMessage}' action='set' />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","DS"_source.GetValueAt("DS:DS01Mode")),"EVN:EventTypeCode","set","")]]></code>
<assign value='$E(strNow, 1, 12)' property='target.{EVN:RecordedDateTime}' action='set' />
<assign value='source.{DS:DS07DateHeureSortie}' property='target.{EVN:EventOccurred}' action='set' />
<assign value='source.{DS:DS28Utilisateur.Username}' property='target.{EVN:OperatorID.IDNumber}' action='set' />
<assign value='"1"' property='target.{PID:SetIDPID}' action='set' />
<assign value='source.{DS:DS05IPP}' property='target.{PID:PatientIdentifierList(1).IDNumber}' action='set' />
<assign value='strAssigningAuthority' property='target.{PID:PatientIdentifierList(1).assigningauthority}' action='set' />
<assign value='"PI"' property='target.{PID:PatientIdentifierList(1).IdentifierTypeCode}' action='set' />
<assign value='source.{DS:DS19NomUsuel.Nom}' property='target.{PID:PatientName(1).FamilyName}' action='set' />
<assign value='source.{DS:DS20Prenom}' property='target.{PID:PatientName(1).givenname}' action='set' />
<assign value='"D"' property='target.{PID:PatientName(1).nametypecode}' action='set' />
<assign value='source.{DS:DS22NomDeNaissance.Nom}' property='target.{PID:PatientName(2).FamilyName}' action='set' />
<assign value='source.{DS:DS20Prenom}' property='target.{PID:PatientName(2).givenname}' action='set' />
<assign value='"L"' property='target.{PID:PatientName(2).nametypecode}' action='set' />
<if condition='$L(source.{DS:DS22NomDeNaissance.Nom})' >
<false>
<assign value='source.{DS:DS19NomUsuel.Nom}' property='target.{PID:PatientName(2).FamilyName}' action='set' />
</false>
</if>
<assign value='source.{DS:DS24DateDeNaissance}' property='target.{PID:DateTimeOfBirth}' action='set' />
<assign value='..Lookup("CCOM_HL7_Sexe",source.{DS:DS23Sexe})' property='target.{PID:AdministrativeSex}' action='set' />
<assign value='source.{DS:DS06NumeroEpisode}' property='target.{PID:PatientAccountNumber.IDNumber}' action='set' />
<assign value='strAssigningAuthority' property='target.{PID:PatientAccountNumber.assigningauthority}' action='set' />
<if condition='##class(ISSAS.Common.Tools.ClassODBC).IsDeceased(source.{DS:DS05IPP})=1' >
<true>
<assign value='"Y"' property='target.{PID:PatientDeathIndicator}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).DeceaseDate(source.{DS:DS05IPP})' property='target.{PID:PatientDeathDateandTime.Time}' action='set' />
<assign value='"D"' property='target.{PID:PatientDeathDateandTime.DegreeofPrecision}' action='set' />
</true>
<false>
<assign value='"N"' property='target.{PID:PatientDeathIndicator}' action='set' />
</false>
</if>
<assign value='"1"' property='target.{PV1:SetIDPV1}' action='set' />
<if condition='source.{DS:DS26IndicateurEpisodeRecurre} = "1"' >
<true>
<assign value='"R"' property='target.{PV1:PatientClass}' action='set' />
</true>
<false>
<assign value='"I"' property='target.{PV1:PatientClass}' action='set' />
</false>
</if>
<assign value='source.{DS:DS06NumeroEpisode}' property='target.{PV1:VisitNumber.IDNumber}' action='set' />
<assign value='strAssigningAuthority' property='target.{PV1:VisitNumber.assigningauthority}' action='set' />
<assign value='source.{DS:DS14CodeUS}' property='target.{PV1:AssignedPatientLocation.pointofcare}' action='set' />
<assign value='source.{DS:DS21Chambre}' property='target.{PV1:AssignedPatientLocation.room}' action='set' />
<assign value='source.{DS:DS02Hopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.Facility}' action='set' />
<assign value='source.{DS:DS10ModeSortie}' property='target.{PV1:DischargeDisposition}' action='set' />
<assign value='source.{DS:DS25MedecinResponsable.CodeClinicom}' property='target.{PV1:AttendingDoctor(1).IDnumber}' action='set' />
<assign value='source.{DS:DS25MedecinResponsable.Nom}' property='target.{PV1:AttendingDoctor(1).familyname}' action='set' />
<assign value='source.{DS:DS25MedecinResponsable.Prenom}' property='target.{PV1:AttendingDoctor(1).givenname}' action='set' />
<assign value='source.{DS:DS25MedecinResponsable.Qualite}' property='target.{PV1:AttendingDoctor(1).prefix}' action='set' />
<assign value='source.{DS:DS25MedecinResponsable.Titre}' property='target.{PV1:AttendingDoctor(1).degree}' action='set' />
<assign value='"EI"' property='target.{PV1:AttendingDoctor(1).IdentifierTypeCode}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassDate).CvtFRToCCOM(##class(ISSAS.Common.Tools.ClassODBC).AdmDate(source.{DS:DS06NumeroEpisode}),2)' property='target.{PV1:AdmitDateTime}' action='set' />
<assign value='source.{DS:DS07DateHeureSortie}' property='target.{PV1:DischargeDateTime}' action='set' />
<assign value='"D"' property='target.{PV1:AccountStatus}' action='set' />
<assign value='source.{DS:DS27IdentifiantUniqueDeMouve}' property='target.{ZBE:MovementID}' action='set' />
<assign value='strAssigningAuthority' property='target.{ZBE:MovementID.NamespaceID}' action='set' />
<assign value='source.{DS:DS07DateHeureSortie}' property='target.{ZBE:StartMovementDateTime}' action='set' />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MovementAction",source.GetValueAt("DS:DS01Mode")),"ZBE:MovementAction","set","")]]></code>
<if condition='source.{DS:DS01Mode} = "01"' >
<false>
<assign value='"A03"' property='target.{ZBE:Originaltriggereventcode}' action='set' />
</false>
</if>
<assign value='"N"' property='target.{ZBE:HistoricalMovementIndicator}' action='set' />
<assign value='source.{DS:DS13CodeUF}' property='target.{ZBE:ResponsibleWard.OrganizationName}' action='set' />
<assign value='source.{DS:DS13CodeUF}' property='target.{ZBE:ResponsibleWard.OrganizationIdentifier}' action='set' />
<assign value='"HMS"' property='target.{ZBE:NatureMouvement}' action='set' />
<assign value='##class(ISSAS.Common.Tools.ClassODBC).ClinicomSortieMode(source.{DS:DS10ModeSortie})' property='target.{ZFM:ModeSortiePMSI}' action='set' />
<assign value='source.{DS:DS09EtablissementDestination.PropositionMTPMSI}' property='target.{ZFM:ModeDestinationPMSI}' action='set' />
<assign value='source.{DS:DS10ModeSortie}' property='target.{ZFV:Modesortiepersonnalise}' action='set' />
<if condition='$L(source.{DS:DS09EtablissementDestination.CodeEtablissement})' >
<true>
<assign value='##class(ISSAS.Common.Tools.ClassODBC).ClinicomEtablissementExterieur(source.{DS:DS09EtablissementDestination.CodeEtablissement})' property='target.{PV1:DischargedtoLocation.DischargeLocation}' action='set' />
</true>
</if>
</transform>
}

}
