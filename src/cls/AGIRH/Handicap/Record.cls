/// RECORDMAP: Generated from RecordMap 'AGIRH.Handicap'
/// on 2021-03-05 at 07:15:34.626 [2021-03-05 06:15:34.626 UTC]
/// by user KSC
Class AGIRH.Handicap.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property NatureHandicap As %String;

Property TauxHandicap As %String;

Property CatégorieHandicap As %String;

Property LibelléCatégorieHandicap As %String;

Property DateEffetHandicap As %String;

Property DateFinHandicap As %String;

Relationship %ParentBatch As AGIRH.Handicap.BatchIn [ Cardinality = one, Inverse = Records ];

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
<Value>TauxHandicap</Value>
</Value>
<Value name="5">
<Value>CatégorieHandicap</Value>
</Value>
<Value name="6">
<Value>LibelléCatégorieHandicap</Value>
</Value>
<Value name="7">
<Value>DateEffetHandicap</Value>
</Value>
<Value name="8">
<Value>DateFinHandicap</Value>
</Value>
<Value name="9">
<Value>%ParentBatch</Value>
</Value>
<Value name="10">
<Value>NatureHandicap</Value>
</Value>
</Data>
<DataLocation>^AGIRH.Handicap.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^AGIRH.Handicap.RecordD</IdLocation>
<IndexLocation>^AGIRH.Handicap.RecordI</IndexLocation>
<StreamLocation>^AGIRH.Handicap.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
