/// RECORDMAP: Generated from RecordMap 'AGIRH.Arborescence'
/// on 2021-03-05 at 07:15:16.623 [2021-03-05 06:15:16.623 UTC]
/// by user KSC
Class AGIRH.Arborescence.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property UF As %String;

Property LibelléUF As %String;

Property DateDébutUF As %String;

Property DateFinUF As %String;

Property EtablissementGéo As %String;

Property LibelléEtabGéo As %String;

Property Pôle As %String;

Property LibelléPôle As %String;

Relationship %ParentBatch As AGIRH.Arborescence.BatchIn [ Cardinality = one, Inverse = Records ];

Index %ParentBatchIdx On %ParentBatch;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>UF</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>DateDébutUF</Value>
</Value>
<Value name="5">
<Value>DateFinUF</Value>
</Value>
<Value name="6">
<Value>EtablissementGéo</Value>
</Value>
<Value name="7">
<Value>LibelléEtabGéo</Value>
</Value>
<Value name="8">
<Value>Pôle</Value>
</Value>
<Value name="9">
<Value>LibelléPôle</Value>
</Value>
<Value name="10">
<Value>%ParentBatch</Value>
</Value>
<Value name="11">
<Value>LibelléUF</Value>
</Value>
</Data>
<DataLocation>^AGIRH.Arborescence.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^AGIRH.Arborescence.RecordD</IdLocation>
<IndexLocation>^AGIRH.Arborescence.RecordI</IndexLocation>
<StreamLocation>^AGIRH.Arborescence.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
