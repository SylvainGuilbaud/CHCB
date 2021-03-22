/// RECORDMAP: Modified during compilation of RecordMap 'KITRY.Personnes'
/// on 2021-03-11 at 16:16:51.813 [2021-03-11 15:16:51.813 UTC]
/// by user KSC
Class KITRY.Personnes.BatchOut Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "KITRY_Personnes_BatchOut";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As KITRY.Personnes.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "KITRY_Personnes_BatchOut";

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
<DataLocation>^KITRY.Personnes.BatchOutD</DataLocation>
<DefaultData>BatchOutDefaultData</DefaultData>
<IdLocation>^KITRY.Personnes.BatchOutD</IdLocation>
<IndexLocation>^KITRY.Personnes.BatchOutI</IndexLocation>
<StreamLocation>^KITRY.Personnes.BatchOutS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
