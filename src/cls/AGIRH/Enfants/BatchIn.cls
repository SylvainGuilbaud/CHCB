/// RECORDMAP: Modified during compilation of RecordMap 'AGIRH.Enfants'
/// on 2021-03-05 at 13:43:37.141 [2021-03-05 12:43:37.141 UTC]
/// by user KSC
Class AGIRH.Enfants.BatchIn Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "AGIRH_Enfants_BatchIn";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As AGIRH.Enfants.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "AGIRH_Enfants_BatchIn";

Storage Default
{
<Data name="BatchInDefaultData">
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
<DataLocation>^AGIRH.Enfants.BatchInD</DataLocation>
<DefaultData>BatchInDefaultData</DefaultData>
<IdLocation>^AGIRH.Enfants.BatchInD</IdLocation>
<IndexLocation>^AGIRH.Enfants.BatchInI</IndexLocation>
<StreamLocation>^AGIRH.Enfants.BatchInS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
