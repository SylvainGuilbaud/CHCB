/// RECORDMAP: Generated from RecordMap 'KITRY.Affectations'
/// on 2021-03-03 at 10:28:08.236 [2021-03-03 09:28:08.236 UTC]
/// by user KSC
Class KITRY.Affectations.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property Racine As %String;

Property UF As %String;

Property TypeUF As %String;

Property DateDébut As %String;

Property DateFin As %String;

Property Pourcentage As %String;

Relationship %ParentBatch As KITRY.Affectations.BatchOut [ Cardinality = one, Inverse = Records ];

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
<Value>UF</Value>
</Value>
<Value name="5">
<Value>TypeUF</Value>
</Value>
<Value name="6">
<Value>DateDébut</Value>
</Value>
<Value name="7">
<Value>DateFin</Value>
</Value>
<Value name="8">
<Value>Poucentage</Value>
</Value>
<Value name="9">
<Value>Racine</Value>
</Value>
<Value name="10">
<Value>Pourcentage</Value>
</Value>
<Value name="11">
<Value>%ParentBatch</Value>
</Value>
</Data>
<DataLocation>^KITRY.Affectations.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^KITRY.Affectations.RecordD</IdLocation>
<IndexLocation>^KITRY.Affectations.RecordI</IndexLocation>
<StreamLocation>^KITRY.Affectations.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
