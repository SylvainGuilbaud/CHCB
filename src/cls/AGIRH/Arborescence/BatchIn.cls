/// RECORDMAP: Modified during compilation of RecordMap 'AGIRH.Arborescence'
/// on 2021-03-05 at 07:15:16.635 [2021-03-05 06:15:16.635 UTC]
/// by user KSC
Class AGIRH.Arborescence.BatchIn Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "AGIRH_Arborescence_BatchIn";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As AGIRH.Arborescence.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "AGIRH_Arborescence_BatchIn";

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
<DataLocation>^AGIRH.Arborescence.BatchInD</DataLocation>
<DefaultData>BatchInDefaultData</DefaultData>
<IdLocation>^AGIRH.Arborescence.BatchInD</IdLocation>
<IndexLocation>^AGIRH.Arborescence.BatchInI</IndexLocation>
<StreamLocation>^AGIRH.Arborescence.BatchInS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
