/// RECORDMAP: Generated from RecordMap 'sg.record.person'
/// on 2021-03-02 at 17:40:52,572 [2021-03-02 16:40:52.572 UTC]
/// by user _SYSTEM
Class sg.record.person.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property name As %String;

Property dob As %String;

Property city As %String;

Parameter RECORDMAPGENERATED = 1;

Relationship %ParentBatch As sg.record.person.Batch [ Cardinality = one, Inverse = Records ];

Index %ParentBatchIdx On %ParentBatch;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>city</Value>
</Value>
<Value name="5">
<Value>%ParentBatch</Value>
</Value>
<Value name="6">
<Value>dob</Value>
</Value>
</Data>
<DataLocation>^sg.record.person.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^sg.record.person.RecordD</IdLocation>
<IndexLocation>^sg.record.person.RecordI</IndexLocation>
<StreamLocation>^sg.record.person.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
