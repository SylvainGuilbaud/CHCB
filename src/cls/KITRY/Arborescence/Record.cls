/// RECORDMAP: Generated from RecordMap 'KITRY.Arborescence'
/// on 2021-03-02 at 17:22:42.226 [2021-03-02 16:22:42.226 UTC]
/// by user KSC
Class KITRY.Arborescence.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Etablissement As %String;

Property UF As %String;

Property LibelléUF As %String;

Property DateDébutUF As %String;

Property DateFinUF As %String;

Property EtablissementGéo As %String;

Property LibelléEtabGéo As %String;

Property Pôle As %String;

Property LibelléPôle As %String;

Relationship %ParentBatch As KITRY.Arborescence.BatchOut [ Cardinality = one, Inverse = Records ];

Index %ParentBatchIdx On %ParentBatch;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Etablissement</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>LibelléUF</Value>
</Value>
<Value name="5">
<Value>DateDébutUF</Value>
</Value>
<Value name="6">
<Value>DateFinUF</Value>
</Value>
<Value name="7">
<Value>EtablissementGéo</Value>
</Value>
<Value name="8">
<Value>LibelléEtabGéo</Value>
</Value>
<Value name="9">
<Value>Pôle</Value>
</Value>
<Value name="10">
<Value>LibelléPôle</Value>
</Value>
<Value name="11">
<Value>UF</Value>
</Value>
<Value name="12">
<Value>%ParentBatch</Value>
</Value>
</Data>
<DataLocation>^KITRY.Arborescence.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^KITRY.Arborescence.RecordD</IdLocation>
<IndexLocation>^KITRY.Arborescence.RecordI</IndexLocation>
<StreamLocation>^KITRY.Arborescence.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
