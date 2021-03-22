/// RECORDMAP: Modified during compilation of RecordMap 'AGIRH.Handicap'
/// on 2021-03-05 at 07:15:34.637 [2021-03-05 06:15:34.637 UTC]
/// by user KSC
Class AGIRH.Handicap.BatchIn Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "AGIRH_Handicap_BatchIn";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As AGIRH.Handicap.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "AGIRH_Handicap_BatchIn";

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
<DataLocation>^AGIRH.Handicap.BatchInD</DataLocation>
<DefaultData>BatchInDefaultData</DefaultData>
<IdLocation>^AGIRH.Handicap.BatchInD</IdLocation>
<IndexLocation>^AGIRH.Handicap.BatchInI</IndexLocation>
<StreamLocation>^AGIRH.Handicap.BatchInS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
