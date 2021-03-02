/// RECORDMAP: Modified during compilation of RecordMap 'sg.record.person'
/// on 2021-03-02 at 17:40:52,578 [2021-03-02 16:40:52.578 UTC]
/// by user _SYSTEM
Class sg.record.person.Batch Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "Batch";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader = "name;dob;city";

Parameter HeaderTerm = "\x0a";

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As sg.record.person.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "sg_record_person_Batch";

Storage Default
{
<Data name="BatchDefaultData">
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
<DataLocation>^sg.record.person.BatchD</DataLocation>
<DefaultData>BatchDefaultData</DefaultData>
<IdLocation>^sg.record.person.BatchD</IdLocation>
<IndexLocation>^sg.record.person.BatchI</IndexLocation>
<StreamLocation>^sg.record.person.BatchS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
