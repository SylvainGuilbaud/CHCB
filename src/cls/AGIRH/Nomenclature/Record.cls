/// RECORDMAP: Generated from RecordMap 'AGIRH.Nomenclature'
/// on 2021-03-10 at 19:24:15.035 [2021-03-10 18:24:15.035 UTC]
/// by user KSC
Class AGIRH.Nomenclature.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Type As %String;

Property Code As %String;

Property LibelléLong As %String;

Property LibelléCourt As %String;

Relationship %ParentBatch As AGIRH.Nomenclature.BatchIn [ Cardinality = one, Inverse = Records ];

Index %ParentBatchIdx On %ParentBatch;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Type</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>LibelléLong</Value>
</Value>
<Value name="5">
<Value>LibelléCourt</Value>
</Value>
<Value name="6">
<Value>%ParentBatch</Value>
</Value>
<Value name="7">
<Value>Code</Value>
</Value>
</Data>
<DataLocation>^AGIRH.Nomenclature.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^AGIRH.Nomenclature.RecordD</IdLocation>
<IndexLocation>^AGIRH.Nomenclature.RecordI</IndexLocation>
<StreamLocation>^AGIRH.Nomenclature.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
