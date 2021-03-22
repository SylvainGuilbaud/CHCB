/// RECORDMAP: Generated from RecordMap 'AGIRH.Formations'
/// on 2021-03-05 at 09:57:42.222 [2021-03-05 08:57:42.222 UTC]
/// by user KSC
Class AGIRH.Formations.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property NuméroFormation As %String;

Property IntituléFormation As %String(MAXLEN = 100);

Property DateDébut As %String;

Property DateFin As %String;

Property CommentaireFormation As %String(MAXLEN = 100);

Relationship %ParentBatch As AGIRH.Formations.BatchIn [ Cardinality = one, Inverse = Records ];

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
<Value>IntituléFormation</Value>
</Value>
<Value name="5">
<Value>DateDébut</Value>
</Value>
<Value name="6">
<Value>DateFin</Value>
</Value>
<Value name="7">
<Value>CommentaireFormation</Value>
</Value>
<Value name="8">
<Value>%ParentBatch</Value>
</Value>
<Value name="9">
<Value>NuméroFormation</Value>
</Value>
</Data>
<DataLocation>^AGIRH.Formations.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^AGIRH.Formations.RecordD</IdLocation>
<IndexLocation>^AGIRH.Formations.RecordI</IndexLocation>
<StreamLocation>^AGIRH.Formations.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
