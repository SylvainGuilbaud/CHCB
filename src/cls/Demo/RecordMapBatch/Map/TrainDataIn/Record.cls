/// RECORDMAP: Generated from RecordMap 'Demo.RecordMapBatch.Map.TrainDataIn'
/// on 2021-02-01 at 19:12:04,432 [2021-02-01 18:12:04.432 UTC]
/// by user _SYSTEM
Class Demo.RecordMapBatch.Map.TrainDataIn.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Line As %String;

Property Trip As %Integer;

Property PlatformKey As %String;

Property InformationType As %String;

Property Time As %String;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Line</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>PlatformKey</Value>
</Value>
<Value name="5">
<Value>InformationType</Value>
</Value>
<Value name="6">
<Value>Time</Value>
</Value>
<Value name="7">
<Value>%ParentBatch</Value>
</Value>
<Value name="8">
<Value>Trip</Value>
</Value>
</Data>
<DataLocation>^Demo.RecordMapBatch3B98.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^Demo.RecordMapBatch3B98.RecordD</IdLocation>
<IndexLocation>^Demo.RecordMapBatch3B98.RecordI</IndexLocation>
<StreamLocation>^Demo.RecordMapBatch3B98.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

Parameter RECORDMAPGENERATED = 1;

Relationship %ParentBatch As Demo.RecordMapBatch.Map.TrainDataIn.BatchIn [ Cardinality = one, Inverse = Records ];

Index %ParentBatchIdx On %ParentBatch;

}
