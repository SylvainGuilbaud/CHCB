/// RECORDMAP: Generated from RecordMap 'KITRY.Enfants'
/// on 2021-03-05 at 13:43:22.670 [2021-03-05 12:43:22.670 UTC]
/// by user KSC
Class KITRY.Enfants.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property NomPrénomEnfant As %String(MAXLEN = 100);

Property DateNaissanceEnfant As %String;

Property SexeEnfant As %String;

Property DateDécèsEnfant As %String;

Property CodeACharge As %String;

Property LibelléACharge As %String;

Relationship %ParentBatch As KITRY.Enfants.BatchOut [ Cardinality = one, Inverse = Records ];

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
<Value>DateNaissanceEnfant</Value>
</Value>
<Value name="5">
<Value>SexeEnfant</Value>
</Value>
<Value name="6">
<Value>DateDécèsEnfant</Value>
</Value>
<Value name="7">
<Value>CodeACharge</Value>
</Value>
<Value name="8">
<Value>LibelléACharge</Value>
</Value>
<Value name="9">
<Value>%ParentBatch</Value>
</Value>
<Value name="10">
<Value>NomPrénomEnfant</Value>
</Value>
</Data>
<DataLocation>^KITRY.Enfants.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^KITRY.Enfants.RecordD</IdLocation>
<IndexLocation>^KITRY.Enfants.RecordI</IndexLocation>
<StreamLocation>^KITRY.Enfants.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
