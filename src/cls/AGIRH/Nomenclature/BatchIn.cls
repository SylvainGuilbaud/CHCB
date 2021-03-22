/// RECORDMAP: Modified during compilation of RecordMap 'AGIRH.Nomenclature'
/// on 2021-03-10 at 19:24:15.042 [2021-03-10 18:24:15.042 UTC]
/// by user KSC
Class AGIRH.Nomenclature.BatchIn Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "AGIRH_Nomenclature_BatchIn";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As AGIRH.Nomenclature.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "AGIRH_Nomenclature_BatchIn";

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
<DataLocation>^AGIRH.Nomenclature.BatchInD</DataLocation>
<DefaultData>BatchInDefaultData</DefaultData>
<IdLocation>^AGIRH.Nomenclature.BatchInD</IdLocation>
<IndexLocation>^AGIRH.Nomenclature.BatchInI</IndexLocation>
<StreamLocation>^AGIRH.Nomenclature.BatchInS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
