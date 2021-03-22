/// RECORDMAP: Modified during compilation of RecordMap 'AGIRH.Absences'
/// on 2021-03-08 at 14:37:54.774 [2021-03-08 13:37:54.774 UTC]
/// by user KSC
Class AGIRH.Absences.BatchIn Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "AGIRH_Absences_BatchIn";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As AGIRH.Absences.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "AGIRH_Absences_BatchIn";

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
<DataLocation>^AGIRH.Absences.BatchInD</DataLocation>
<DefaultData>BatchInDefaultData</DefaultData>
<IdLocation>^AGIRH.Absences.BatchInD</IdLocation>
<IndexLocation>^AGIRH.Absences.BatchInI</IndexLocation>
<StreamLocation>^AGIRH.Absences.BatchInS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
