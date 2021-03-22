/// RECORDMAP: Generated from RecordMap 'KITRY.Absences'
/// on 2021-03-08 at 14:36:29.824 [2021-03-08 13:36:29.824 UTC]
/// by user KSC
Class KITRY.Absences.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property CodeAbsenceQualifiée As %String;

Property LibelléAbsenceQualifiée As %String;

Property DateDébutAbsence As %String;

Property DateFinAbsenceCalculée As %String;

Property DateAT As %String;

Property NuméroAT As %String;

Property TypeArrêt As %String;

Property SuppressionArrêt As %String;

Relationship %ParentBatch As KITRY.Absences.BatchOut [ Cardinality = one, Inverse = Records ];

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
<Value>DateAT</Value>
</Value>
<Value name="8">
<Value>NuméroAT</Value>
</Value>
<Value name="9">
<Value>TypeArrêt</Value>
</Value>
<Value name="10">
<Value>SuppressionArrêt</Value>
</Value>
<Value name="11">
<Value>%ParentBatch</Value>
</Value>
<Value name="12">
<Value>CodeAbsenceQualifiée</Value>
</Value>
</Data>
<DataLocation>^KITRY.Absences.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^KITRY.Absences.RecordD</IdLocation>
<IndexLocation>^KITRY.Absences.RecordI</IndexLocation>
<StreamLocation>^KITRY.Absences.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
