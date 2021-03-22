/// RECORDMAP: Generated from RecordMap 'AGIRH.Accidents'
/// on 2021-03-05 at 07:06:12.352 [2021-03-05 06:06:12.352 UTC]
/// by user KSC
Class AGIRH.Accidents.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property DateEffetAT As %String;

Property HeureAT As %String;

Property NatureAT As %String;

Property LibelléNatureAT As %String;

Property CommentaireAT As %String(MAXLEN = 200);

Property DateduCertificatMédical As %String;

Property ElémentMatérielAT As %String;

Property LibelléElémentMatérielAT As %String;

Property SiègeAT As %String;

Property LibelléSiègeAT As %String;

Relationship %ParentBatch As AGIRH.Accidents.BatchIn [ Cardinality = one, Inverse = Records ];

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
<Value>HeureAT</Value>
</Value>
<Value name="5">
<Value>NatureAT</Value>
</Value>
<Value name="6">
<Value>LibelléNatureAT</Value>
</Value>
<Value name="7">
<Value>CommentaireAT</Value>
</Value>
<Value name="8">
<Value>DateduCertificatMédical</Value>
</Value>
<Value name="9">
<Value>ElémentMatérielAT</Value>
</Value>
<Value name="10">
<Value>LibelléElémentMatérielAT</Value>
</Value>
<Value name="11">
<Value>SiègeAT</Value>
</Value>
<Value name="12">
<Value>LibelléSiègeAT</Value>
</Value>
<Value name="13">
<Value>%ParentBatch</Value>
</Value>
<Value name="14">
<Value>DateEffetdAT</Value>
</Value>
<Value name="15">
<Value>DateEffetAT</Value>
</Value>
</Data>
<DataLocation>^AGIRH.Accidents.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^AGIRH.Accidents.RecordD</IdLocation>
<IndexLocation>^AGIRH.Accidents.RecordI</IndexLocation>
<StreamLocation>^AGIRH.Accidents.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
