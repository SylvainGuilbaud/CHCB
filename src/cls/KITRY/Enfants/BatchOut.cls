/// RECORDMAP: Modified during compilation of RecordMap 'KITRY.Enfants'
/// on 2021-03-05 at 13:43:22.685 [2021-03-05 12:43:22.685 UTC]
/// by user KSC
Class KITRY.Enfants.BatchOut Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "KITRY_Enfants_BatchOut";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As KITRY.Enfants.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "KITRY_Enfants_BatchOut";

Storage Default
{
<Data name="BatchOutDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>%Source</Value>
</Value>
<Value name="3">
<Value>BatchHeader</Value>
</Value>
<Value name="4">
<Value>BatchTrailer</Value>
</Value>
</Data>
<DataLocation>^KITRY.Enfants.BatchOutD</DataLocation>
<DefaultData>BatchOutDefaultData</DefaultData>
<IdLocation>^KITRY.Enfants.BatchOutD</IdLocation>
<IndexLocation>^KITRY.Enfants.BatchOutI</IndexLocation>
<StreamLocation>^KITRY.Enfants.BatchOutS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
