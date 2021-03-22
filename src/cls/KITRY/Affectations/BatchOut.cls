/// RECORDMAP: Modified during compilation of RecordMap 'KITRY.Affectations'
/// on 2021-03-03 at 10:28:08.247 [2021-03-03 09:28:08.247 UTC]
/// by user KSC
Class KITRY.Affectations.BatchOut Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "KITRY_Affectations_BatchOut";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As KITRY.Affectations.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "KITRY_Affectations_BatchOut";

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
<DataLocation>^KITRY.Affectations.BatchOutD</DataLocation>
<DefaultData>BatchOutDefaultData</DefaultData>
<IdLocation>^KITRY.Affectations.BatchOutD</IdLocation>
<IndexLocation>^KITRY.Affectations.BatchOutI</IndexLocation>
<StreamLocation>^KITRY.Affectations.BatchOutS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
