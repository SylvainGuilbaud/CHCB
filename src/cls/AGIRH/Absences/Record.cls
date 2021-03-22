/// RECORDMAP: Generated from RecordMap 'AGIRH.Absences'
/// on 2021-03-08 at 14:37:54.766 [2021-03-08 13:37:54.766 UTC]
/// by user KSC
Class AGIRH.Absences.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property CodeAbsenceQualifiée As %String;

Property LibelléAbsenceQualifiée As %String;

Property DateDébutAbsence As %String;

Property DateFinAbsenceCalculée As %String;

Relationship %ParentBatch As AGIRH.Absences.BatchIn [ Cardinality = one, Inverse = Records ];

Index %ParentBatchIdx On %ParentBatch;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Matricule</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>LibelléAbsenceQualifiée</Value>
</Value>
<Value name="5">
<Value>DateDébutAbsence</Value>
</Value>
<Value name="6">
<Value>DateFinAbsenceCalculée</Value>
</Value>
<Value name="7">
<Value>%ParentBatch</Value>
</Value>
<Value name="8">
<Value>CodeAbsenceQualifiée</Value>
</Value>
</Data>
<DataLocation>^AGIRH.Absences.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^AGIRH.Absences.RecordD</IdLocation>
<IndexLocation>^AGIRH.Absences.RecordI</IndexLocation>
<StreamLocation>^AGIRH.Absences.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
