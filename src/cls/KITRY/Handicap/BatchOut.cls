/// RECORDMAP: Modified during compilation of RecordMap 'KITRY.Handicap'
/// on 2021-03-04 at 13:30:23.575 [2021-03-04 12:30:23.575 UTC]
/// by user KSC
Class KITRY.Handicap.BatchOut Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "KITRY_Handicap_BatchOut";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As KITRY.Handicap.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "KITRY_Handicap_BatchOut";

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
<DataLocation>^KITRY.Handicap.BatchOutD</DataLocation>
<DefaultData>BatchOutDefaultData</DefaultData>
<IdLocation>^KITRY.Handicap.BatchOutD</IdLocation>
<IndexLocation>^KITRY.Handicap.BatchOutI</IndexLocation>
<StreamLocation>^KITRY.Handicap.BatchOutS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
