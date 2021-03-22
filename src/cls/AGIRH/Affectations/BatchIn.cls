/// RECORDMAP: Modified during compilation of RecordMap 'AGIRH.Affectations'
/// on 2021-03-05 at 07:15:01.846 [2021-03-05 06:15:01.846 UTC]
/// by user KSC
Class AGIRH.Affectations.BatchIn Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "AGIRH_Affectations_BatchIn";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As AGIRH.Affectations.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "AGIRH_Affectations_BatchIn";

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
<DataLocation>^AGIRH.Affectations.BatchInD</DataLocation>
<DefaultData>BatchInDefaultData</DefaultData>
<IdLocation>^AGIRH.Affectations.BatchInD</IdLocation>
<IndexLocation>^AGIRH.Affectations.BatchInI</IndexLocation>
<StreamLocation>^AGIRH.Affectations.BatchInS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
