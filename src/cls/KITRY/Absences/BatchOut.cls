/// RECORDMAP: Modified during compilation of RecordMap 'KITRY.Absences'
/// on 2021-03-08 at 14:36:29.836 [2021-03-08 13:36:29.836 UTC]
/// by user KSC
Class KITRY.Absences.BatchOut Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "KITRY_Absences_BatchOut";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As KITRY.Absences.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "KITRY_Absences_BatchOut";

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
<DataLocation>^KITRY.Absences.BatchOutD</DataLocation>
<DefaultData>BatchOutDefaultData</DefaultData>
<IdLocation>^KITRY.Absences.BatchOutD</IdLocation>
<IndexLocation>^KITRY.Absences.BatchOutI</IndexLocation>
<StreamLocation>^KITRY.Absences.BatchOutS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
