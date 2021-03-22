/// RECORDMAP: Generated from RecordMap 'AGIRH.Affectations'
/// on 2021-03-05 at 07:15:01.835 [2021-03-05 06:15:01.835 UTC]
/// by user KSC
Class AGIRH.Affectations.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property UF As %String;

Property TypeAffectation As %String;

Property DateEffetAffectation As %String;

Property TempsdeAffPrincnum As %String;

Property DateFinAffectation As %String;

Property TempsdeAffSecnum As %String;

Relationship %ParentBatch As AGIRH.Affectations.BatchIn [ Cardinality = one, Inverse = Records ];

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
<Value>TypeAffectation</Value>
</Value>
<Value name="5">
<Value>DateEffetAffectation</Value>
</Value>
<Value name="6">
<Value>TempsdeAffPrincnum</Value>
</Value>
<Value name="7">
<Value>DateFinAffectation</Value>
</Value>
<Value name="8">
<Value>TempsdeAffSecnum</Value>
</Value>
<Value name="9">
<Value>UF</Value>
</Value>
<Value name="10">
<Value>%ParentBatch</Value>
</Value>
</Data>
<DataLocation>^AGIRH.Affectations.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^AGIRH.Affectations.RecordD</IdLocation>
<IndexLocation>^AGIRH.Affectations.RecordI</IndexLocation>
<StreamLocation>^AGIRH.Affectations.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
