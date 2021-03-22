/// RECORDMAP: Modified during compilation of RecordMap 'AGIRH.Formations'
/// on 2021-03-05 at 09:57:42.229 [2021-03-05 08:57:42.229 UTC]
/// by user KSC
Class AGIRH.Formations.BatchIn Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "AGIRH_Formations_BatchIn";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As AGIRH.Formations.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "AGIRH_Formations_BatchIn";

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
<DataLocation>^AGIRH.Formations.BatchInD</DataLocation>
<DefaultData>BatchInDefaultData</DefaultData>
<IdLocation>^AGIRH.Formations.BatchInD</IdLocation>
<IndexLocation>^AGIRH.Formations.BatchInI</IndexLocation>
<StreamLocation>^AGIRH.Formations.BatchInS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
