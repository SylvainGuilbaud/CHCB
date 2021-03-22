/// RECORDMAP: Generated from RecordMap 'KITRY.Handicap'
/// on 2021-03-04 at 13:30:23.566 [2021-03-04 12:30:23.566 UTC]
/// by user KSC
Class KITRY.Handicap.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property RQTH As %String;

Property CatégorieInvalidité As %String;

Property TauxInvalidité As %String;

Property CodeHandicap As %String;

Property LibelléHandicap As %String;

Property DateDébutRQTH As %String;

Property DateFinRQTH As %String;

Relationship %ParentBatch As KITRY.Handicap.BatchOut [ Cardinality = one, Inverse = Records ];

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
<Value>CatégorieInvalidité</Value>
</Value>
<Value name="5">
<Value>TauxInvalidité</Value>
</Value>
<Value name="6">
<Value>CodeHandicap</Value>
</Value>
<Value name="7">
<Value>LibelléHandicap</Value>
</Value>
<Value name="8">
<Value>DateDébutRQHT</Value>
</Value>
<Value name="9">
<Value>DateFinRQTH</Value>
</Value>
<Value name="10">
<Value>%ParentBatch</Value>
</Value>
<Value name="11">
<Value>RQTH</Value>
</Value>
<Value name="12">
<Value>DateDébutRQTH</Value>
</Value>
</Data>
<DataLocation>^KITRY.Handicap.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^KITRY.Handicap.RecordD</IdLocation>
<IndexLocation>^KITRY.Handicap.RecordI</IndexLocation>
<StreamLocation>^KITRY.Handicap.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
