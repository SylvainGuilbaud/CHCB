/// RECORDMAP: Generated from RecordMap 'KITRY.Formations'
/// on 2021-03-05 at 09:58:02.770 [2021-03-05 08:58:02.770 UTC]
/// by user KSC
Class KITRY.Formations.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property CodeFormation As %String;

Property IntituléFormation As %String(MAXLEN = 100);

Property DateDébut As %String;

Property DateFin As %String;

Property CodeRésultat As %String;

Property LibelléRésultat As %String;

Property Commentaire As %String(MAXLEN = 100);

Relationship %ParentBatch As KITRY.Formations.BatchOut [ Cardinality = one, Inverse = Records ];

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
<Value>CodeRésultat</Value>
</Value>
<Value name="8">
<Value>LibelléRésultat</Value>
</Value>
<Value name="9">
<Value>Commentaire</Value>
</Value>
<Value name="10">
<Value>%ParentBatch</Value>
</Value>
<Value name="11">
<Value>CodeFormation</Value>
</Value>
</Data>
<DataLocation>^KITRY.Formations.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^KITRY.Formations.RecordD</IdLocation>
<IndexLocation>^KITRY.Formations.RecordI</IndexLocation>
<StreamLocation>^KITRY.Formations.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
