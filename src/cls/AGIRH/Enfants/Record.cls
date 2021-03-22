/// RECORDMAP: Generated from RecordMap 'AGIRH.Enfants'
/// on 2021-03-05 at 13:43:37.133 [2021-03-05 12:43:37.133 UTC]
/// by user KSC
Class AGIRH.Enfants.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property NomPrénomEnfant As %String(MAXLEN = 100);

Property DateNaissanceEnfant As %String;

Property SexeEnfant As %String;

Property CodeSuspensionEnfant As %String;

Property CodeSFT As %String;

Property LibelléSFT As %String;

Relationship %ParentBatch As AGIRH.Enfants.BatchIn [ Cardinality = one, Inverse = Records ];

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
<Value>CodeSuspensionEnfant</Value>
</Value>
<Value name="7">
<Value>CodeSFT</Value>
</Value>
<Value name="8">
<Value>LibelléSFT</Value>
</Value>
<Value name="9">
<Value>%ParentBatch</Value>
</Value>
<Value name="10">
<Value>NomPrénomEnfant</Value>
</Value>
</Data>
<DataLocation>^AGIRH.Enfants.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^AGIRH.Enfants.RecordD</IdLocation>
<IndexLocation>^AGIRH.Enfants.RecordI</IndexLocation>
<StreamLocation>^AGIRH.Enfants.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
