/// RECORDMAP: Modified during compilation of RecordMap 'KITRY.Accidents'
/// on 2021-03-08 at 15:48:57.904 [2021-03-08 14:48:57.904 UTC]
/// by user KSC
Class KITRY.Accidents.BatchOut Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "KITRY_Accidents_BatchOut";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As KITRY.Accidents.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "KITRY_Accidents_BatchOut";

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
<DataLocation>^KITRY.Accidents.BatchOutD</DataLocation>
<DefaultData>BatchOutDefaultData</DefaultData>
<IdLocation>^KITRY.Accidents.BatchOutD</IdLocation>
<IndexLocation>^KITRY.Accidents.BatchOutI</IndexLocation>
<StreamLocation>^KITRY.Accidents.BatchOutS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
