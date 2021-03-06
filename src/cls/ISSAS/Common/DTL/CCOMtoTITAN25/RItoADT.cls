Class ISSAS.Common.DTL.CCOMtoTITAN25.RItoADT Extends Ens.DataTransformDTL [ DependsOn = EnsLib.HL7.Message ]
{

Parameter IGNOREMISSINGSOURCE = 0;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='Clinicom:RI' targetDocType='HL7v25IHE:ADT_AXX' create='new' language='objectscript' >
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
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","RI"_source.GetValueAt("RI:RI01Mode")),"MSH:MessageType.TriggerEvent","set","")]]></code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","RI"_source.GetValueAt("RI:RI01Mode")),"MSH:MessageType.MessageStructure","set","")]]></code>
<assign value='strGUID' property='target.{MSH:MessageControlID}' action='set' />
<assign value='"2.5"' property='target.{MSH:VersionID}' action='set' />
<assign value='"FRA"' property='target.{MSH:CountryCode}' action='set' />
<assign value='"8859/1"' property='target.{MSH:CharacterSet}' action='set' />
<assign value='"FR"' property='target.{MSH:PrincipalLanguageOfMessage}' action='set' />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","RI"_source.GetValueAt("RI:RI01Mode")),"EVN:EventTypeCode","set","")]]></code>
<assign value='$E(strNow, 1, 12)' property='target.{EVN:RecordedDateTime}' action='set' />
<assign value='source.{RI:RI08DateHeureRetour}' property='target.{EVN:EventOccurred}' action='set' />
<assign value='"1"' property='target.{PID:SetIDPID}' action='set' />
<assign value='source.{RI:RI05IPP}' property='target.{PID:PatientIdentifierList(1).IDNumber}' action='set' />
<assign value='strAssigningAuthority' property='target.{PID:PatientIdentifierList(1).assigningauthority}' action='set' />
<assign value='"PI"' property='target.{PID:PatientIdentifierList(1).IdentifierTypeCode}' action='set' />
<assign value='source.{RI:RI21NomUsuel.Nom}' property='target.{PID:PatientName(1).FamilyName}' action='set' />
<assign value='"D"' property='target.{PID:PatientName(1).nametypecode}' action='set' />
<assign value='source.{RI:RI22Prenom}' property='target.{PID:PatientName(1).givenname}' action='set' />
<assign value='source.{RI:RI23NomDeNaissance.Nom}' property='target.{PID:PatientName(2).FamilyName}' action='set' />
<assign value='"L"' property='target.{PID:PatientName(2).nametypecode}' action='set' />
<assign value='source.{RI:RI22Prenom}' property='target.{PID:PatientName(2).givenname}' action='set' />
<if condition='$L(source.{RI:RI23NomDeNaissance.Nom})' >
<false>
<assign value='source.{RI:RI21NomUsuel.Nom}' property='target.{PID:PatientName(2).FamilyName}' action='set' />
</false>
</if>
<assign value='source.{RI:RI25DateDeNaissance}' property='target.{PID:DateTimeOfBirth}' action='set' />
<assign value='..Lookup("CCOM_HL7_Sexe",source.{RI:RI24Sexe})' property='target.{PID:AdministrativeSex}' action='set' />
<assign value='source.{RI:RI06NumeroEpisode}' property='target.{PID:PatientAccountNumber.IDNumber}' action='set' />
<assign value='strAssigningAuthority' property='target.{PID:PatientAccountNumber.assigningauthority}' action='set' />
<assign value='"1"' property='target.{PV1:SetIDPV1}' action='set' />
<assign value='"I"' property='target.{PV1:PatientClass}' action='set' />
<assign value='source.{RI:RI06NumeroEpisode}' property='target.{PV1:VisitNumber.IDNumber}' action='set' />
<assign value='strAssigningAuthority' property='target.{PV1:VisitNumber.assigningauthority}' action='set' />
<assign value='source.{RI:RI09CodeUS}' property='target.{PV1:AssignedPatientLocation.pointofcare}' action='set' />
<assign value='source.{RI:RI13Chambre}' property='target.{PV1:AssignedPatientLocation.room}' action='set' />
<assign value='source.{RI:RI14Lit}' property='target.{PV1:AssignedPatientLocation.bed}' action='set' />
<assign value='source.{RI:RI11CodeMedecinResponsable}' property='target.{PV1:AttendingDoctor(1).IDnumber}' action='set' />
<assign value='"EI"' property='target.{PV1:AttendingDoctor(1).IdentifierTypeCode}' action='set' />
<assign value='source.{RI:RI12SupplementChambreSeule}' property='target.{PV1:CourtesyCode}' action='set' />
<assign value='source.{RI:RI26IdentifiantUniqueDeMouve}' property='target.{ZBE:MovementID}' action='set' />
<assign value='strAssigningAuthority' property='target.{ZBE:MovementID.NamespaceID}' action='set' />
<assign value='source.{RI:RI08DateHeureRetour}' property='target.{ZBE:StartMovementDateTime}' action='set' />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MovementAction",source.GetValueAt("RI:RI01Mode")),"ZBE:MovementAction","set","")]]></code>
<if condition='(source.{RI:RI01Mode} = "02")||(source.{RI:RI01Mode} = "03") ' >
<true>
<assign value='"A22"' property='target.{ZBE:Originaltriggereventcode}' action='set' />
</true>
</if>
<if condition='source.{RI:RI20IndicateurDernierMouveme} = "1"' >
<true>
<assign value='"N"' property='target.{ZBE:HistoricalMovementIndicator}' action='set' />
</true>
<false>
<assign value='"Y"' property='target.{ZBE:HistoricalMovementIndicator}' action='set' />
</false>
</if>
<assign value='source.{RI:RI10CodeUF}' property='target.{ZBE:ResponsibleWard.OrganizationName}' action='set' />
<assign value='source.{RI:RI10CodeUF}' property='target.{ZBE:ResponsibleWard.OrganizationIdentifier}' action='set' />
<assign value='"HMS"' property='target.{ZBE:NatureMouvement}' action='set' />
</transform>
}

}
