Class ISSAS.Common.DTL.CCOMtoHL7v25.NRtoADT Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/DTL/CCOMtoHL7v25/NRtoADT.xml#8 $";

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass="EnsLib.HL7.Message" sourceDocType="Clinicom:NR" targetClass="EnsLib.HL7.Message" targetDocType="HL7v25IHE:ADT_AXX" create="new" language="objectscript" >
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
 Set strGUID = $EXTRACT(strGUID, 1, 16)
 Set nbtel=0 ]]>
</code>

<!-- segment MSH -->
<assign value="$ZCVT(source.{MSH:MSH03SendingApplication},&quot;U&quot;)" property="target.{MSH:SendingApplication}" key="&quot;&quot;" action="set" />
<assign value="$ZCVT(source.{MSH:MSH04SendingFacility},&quot;U&quot;)" property="target.{MSH:SendingFacility}" key="&quot;&quot;" action="set" />
<assign value="$E(strNow, 1, 12)" property="target.{MSH:DateTimeOfMessage}" key="&quot;&quot;" action="set" />
<assign value="&quot;ADT&quot;" property="target.{MSH:MessageType.MessageCode}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","NR"_source.GetValueAt("NR:NR01Mode")),"MSH:MessageType.TriggerEvent","set","")]]>
</code>
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageStruct_v25","NR"_source.GetValueAt("NR:NR01Mode")),"MSH:MessageType.MessageStructure","set","")]]>
</code>
<assign value="strGUID" property="target.{MSH:MessageControlID}" key="&quot;&quot;" action="set" />
<assign value='"2.5"' property="target.{MSH:VersionID}" key="&quot;&quot;" action="set" />
<assign value="&quot;FRA&quot;" property="target.{MSH:CountryCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;8859/1&quot;" property="target.{MSH:CharacterSet}" key="&quot;&quot;" action="set" />
<assign value="&quot;FR&quot;" property="target.{MSH:PrincipalLanguageOfMessage}" key="&quot;&quot;" action="set" />

<!-- segment EVN -->
<assign value="$E(strNow, 1, 12)" property="target.{EVN:RecordedDateTime}" key="&quot;&quot;" action="set" />
<code>
<![CDATA[ Set tSC1=target.SetValueAt(..Lookup("CCOM_HL7_MessageType_v25","NR"_source.GetValueAt("NR:NR01Mode")),"EVN:EventTypeCode","set","")]]>
</code>
<assign value="source.{NR4:NR411DateHeureAdmission}" property="target.{EVN:EventOccurred}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR306Utilisateur.Username}" property="target.{EVN:OperatorID.IDNumber}" key="&quot;&quot;" action="set" />

<!-- segment PID -->
<assign value="&quot;1&quot;" property="target.{PID:SetIDPID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientIdentifierList(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR03IPP}" property="target.{PID:PatientIdentifierList(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PI&quot;" property="target.{PID:PatientIdentifierList(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR04NomUsuel.Nom}" property="target.{PID:PatientName(1).FamilyName}" key="&quot;&quot;" action="set" />
<assign value='"L"' property="target.{PID:PatientName(1).nametypecode}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR05Prenom}" property="target.{PID:PatientName(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR07Qualite}" property="target.{PID:PatientName(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{NR4:NR417DateHeureNaissance}" property="target.{PID:DateTimeOfBirth}" key="&quot;&quot;" action="set" />
<assign value="..Lookup(&quot;CCOM_HL7_Sexe&quot;,source.{NR:NR11Sexe})" property="target.{PID:AdministrativeSex}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR12NoRueAdresse}" property="target.{PID:PatientAddress(1).streetaddress}" key="&quot;&quot;" action="set" />
<assign value="source.{NR:NR13CodePostalAdresse}" property="target.{PID:PatientAddress(1).ziporpostalcode}" key="&quot;&quot;" action="set" />
<assign value="source.{NR2:NR201LocaliteAdresse}" property="target.{PID:PatientAddress(1).city}" key="&quot;&quot;" action="set" />
<assign value="source.{NR2:NR206ComplementAdresse}" property="target.{PID:PatientAddress(1).otherdesignation}" key="&quot;&quot;" action="set" />
<assign value="source.{NR2:NR202PaysAdresse}" property="target.{PID:PatientAddress(1).country}" key="&quot;&quot;" action="set" />
<assign value="&quot;H&quot;" property="target.{PID:PatientAddress(1).AddressType}" key="&quot;&quot;" action="set" />

<!-- telephone domicile seulement si valorisé -->
<if condition="$L(source.{NR2:NR203Telephone})">
<true>
<assign value="source.{NR2:NR203Telephone}" property="target.{PID:PhoneNumberHome($I(nbtel)).TelephoneNumber}" key="&quot;&quot;" action="set" />
<assign value="&quot;PRN&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationUseCode}" key="&quot;&quot;" action="set" />
<assign value="&quot;PH&quot;" property="target.{PID:PhoneNumberHome(nbtel).TelecommunicationEquipmentTy}" key="&quot;&quot;" action="set" />
</true>
</if>
<assign value="source.{NR2:NR204Nationalite}" property="target.{PID:Nationality}" key="&quot;&quot;" action="set" />
<assign value="source.{NR2:NR204Nationalite}" property="target.{PID:Citizenship(1)}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR303NumeroEpisode}" property="target.{PID:PatientAccountNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:PatientAccountNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{NR4:NR415IPPMere}" property="target.{PID:MothersIdentifier(1).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:MothersIdentifier(1).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value='"PI"' property="target.{PID:MothersIdentifier(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="source.{NR4:NR416NumeroEpisodeMere}" property="target.{PID:MothersIdentifier(2).IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PID:MothersIdentifier(2).assigningauthority}" key="&quot;&quot;" action="set" />
<assign value='"AN"' property="target.{PID:MothersIdentifier(2).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value='source.{NR4:NR404RangGemellaire}' property="target.{PID:BirthOrder}" key="&quot;&quot;" action="set" />

<!-- segment PV1 -->
<assign value="&quot;1&quot;" property="target.{PV1:SetIDPV1}" key="&quot;&quot;" action="set" />
<assign value="&quot;I&quot;" property="target.{PV1:PatientClass}" key="&quot;&quot;" action="set" />
<assign value="&quot;N&quot;" property="target.{PV1:AdmissionType}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR303NumeroEpisode}" property="target.{PV1:VisitNumber.IDNumber}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{PV1:VisitNumber.assigningauthority}" key="&quot;&quot;" action="set" />
<assign value="source.{NR4:NR408CodeUS}" property="target.{PV1:AssignedPatientLocation.pointofcare}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR304Chambre}" property="target.{PV1:AssignedPatientLocation.room}" key="&quot;&quot;" action="set" />
<assign value='source.{NR3:NR301CodeHopital.CodeEtablissement}' property='target.{PV1:AssignedPatientLocation.Facility}' action='set' />
<assign value="source.{NR3:NR305MedecinResponsable.CodeClinicom}" property="target.{PV1:AttendingDoctor(1).IDnumber}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR305MedecinResponsable.Nom}" property="target.{PV1:AttendingDoctor(1).familyname}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR305MedecinResponsable.Prenom}" property="target.{PV1:AttendingDoctor(1).givenname}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR305MedecinResponsable.Qualite}" property="target.{PV1:AttendingDoctor(1).prefix}" key="&quot;&quot;" action="set" />
<assign value="source.{NR3:NR305MedecinResponsable.Titre}" property="target.{PV1:AttendingDoctor(1).degree}" key="&quot;&quot;" action="set" />
<assign value='"EI"' property="target.{PV1:AttendingDoctor(1).IdentifierTypeCode}" key="&quot;&quot;" action="set" />
<assign value="source.{NR4:NR411DateHeureAdmission}" property="target.{PV1:AdmitDateTime}" key="&quot;&quot;" action="set" />
<assign value='"8"' property="target.{PV1:AdmitSource}" key="&quot;&quot;" action="set" />

<!-- segment ZBE -->
<assign value="source.{NR3:NR307IdentifiantUniqueDeMouv}" property="target.{ZBE:MovementID}" key="&quot;&quot;" action="set" />
<assign value="strAssigningAuthority" property="target.{ZBE:MovementID.NamespaceID}" key="&quot;&quot;" action="set" />
<assign value="source.{NR4:NR411DateHeureAdmission}" property="target.{ZBE:StartMovementDateTime}" key="&quot;&quot;" action="set" />
<if condition='source.{NR:NR01Mode} = "02"'>
<true>
<assign value="&quot;UPDATE&quot;" property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
<assign value="&quot;A01&quot;" property="target.{ZBE:Originaltriggereventcode}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;INSERT&quot;" property="target.{ZBE:MovementAction}" key="&quot;&quot;" action="set" />
</false>
</if>
<if condition='source.{NR3:NR308IndicateurDernierMouvem} = "1"'>
<true>
<assign value="&quot;N&quot;" property="target.{ZBE:HistoricalMovementIndicator}" key="&quot;&quot;" action="set" />
</true>
<false>
<assign value="&quot;Y&quot;" property="target.{ZBE:HistoricalMovementIndicator}" key="&quot;&quot;" action="set" />
</false>
</if>
<assign value="source.{NR4:NR409CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationName}" key="&quot;&quot;" action="set" />
<assign value="source.{NR4:NR409CodeUF}" property="target.{ZBE:ResponsibleWard.OrganizationIdentifier}" key="&quot;&quot;" action="set" />
<assign value='"HMS"' property="target.{ZBE:NatureMouvement}" key="&quot;&quot;" action="set" />

<!-- segment ZFD -->
<assign value="source.{NR4:NR406AgeGestationnelEnSemain}" property="target.{ZFD:Nombredesemainesdegestation}" key="&quot;&quot;" action="set" />
<!-- segment OBX -->
<assign value="&quot;1&quot;" property="target.{OBX:SetIDOBX}" key="&quot;&quot;" action="set" />
<assign value="&quot;NM&quot;" property="target.{OBX:ValueType}" key="&quot;&quot;" action="set" />
<assign value="&quot;11752-3^PATIENT WEIGHT&quot;" property="target.{OBX:ObservationIdentifier}" key="&quot;&quot;" action="set" />
<assign value="source.{NR4:NR405PoidsEnGrammes}" property="target.{OBX:ObservationValue}" key="&quot;&quot;" action="set" />
<assign value="&quot;g&quot;" property="target.{OBX:Units}" key="&quot;&quot;" action="set" />
<assign value="&quot;F&quot;" property="target.{OBX:ObservationResultStatus}" key="&quot;&quot;" action="set" />
</transform>
}

}
