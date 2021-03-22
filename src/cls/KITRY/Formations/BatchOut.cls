/// RECORDMAP: Modified during compilation of RecordMap 'KITRY.Formations'
/// on 2021-03-05 at 09:58:02.780 [2021-03-05 08:58:02.780 UTC]
/// by user KSC
Class KITRY.Formations.BatchOut Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "KITRY_Formations_BatchOut";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As KITRY.Formations.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "KITRY_Formations_BatchOut";

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
<DataLocation>^KITRY.Formations.BatchOutD</DataLocation>
<DefaultData>BatchOutDefaultData</DefaultData>
<IdLocation>^KITRY.Formations.BatchOutD</IdLocation>
<IndexLocation>^KITRY.Formations.BatchOutI</IndexLocation>
<StreamLocation>^KITRY.Formations.BatchOutS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
