/// RECORDMAP: Modified during compilation of RecordMap 'AGIRH.Accidents'
/// on 2021-03-05 at 07:06:12.365 [2021-03-05 06:06:12.365 UTC]
/// by user KSC
Class AGIRH.Accidents.BatchIn Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "AGIRH_Accidents_BatchIn";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As AGIRH.Accidents.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "AGIRH_Accidents_BatchIn";

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
<DataLocation>^AGIRH.Accidents.BatchInD</DataLocation>
<DefaultData>BatchInDefaultData</DefaultData>
<IdLocation>^AGIRH.Accidents.BatchInD</IdLocation>
<IndexLocation>^AGIRH.Accidents.BatchInI</IndexLocation>
<StreamLocation>^AGIRH.Accidents.BatchInS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
