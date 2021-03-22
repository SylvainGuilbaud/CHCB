/// RECORDMAP: Modified during compilation of RecordMap 'AGIRH.Personnes'
/// on 2021-03-05 at 07:15:52.831 [2021-03-05 06:15:52.831 UTC]
/// by user KSC
Class AGIRH.Personnes.BatchIn Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "AGIRH_Personnes_BatchIn";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As AGIRH.Personnes.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "AGIRH_Personnes_BatchIn";

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
<DataLocation>^AGIRH.Personnes.BatchInD</DataLocation>
<DefaultData>BatchInDefaultData</DefaultData>
<IdLocation>^AGIRH.Personnes.BatchInD</IdLocation>
<IndexLocation>^AGIRH.Personnes.BatchInI</IndexLocation>
<StreamLocation>^AGIRH.Personnes.BatchInS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
