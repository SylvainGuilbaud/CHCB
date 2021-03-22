/// RECORDMAP: Modified during compilation of RecordMap 'KITRY.Arborescence'
/// on 2021-03-02 at 17:22:42.239 [2021-03-02 16:22:42.239 UTC]
/// by user KSC
Class KITRY.Arborescence.BatchOut Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "KITRY_Arborescence_BatchOut";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As KITRY.Arborescence.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "KITRY_Arborescence_BatchOut";

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
<DataLocation>^KITRY.Arborescence.BatchOutD</DataLocation>
<DefaultData>BatchOutDefaultData</DefaultData>
<IdLocation>^KITRY.Arborescence.BatchOutD</IdLocation>
<IndexLocation>^KITRY.Arborescence.BatchOutI</IndexLocation>
<StreamLocation>^KITRY.Arborescence.BatchOutS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
