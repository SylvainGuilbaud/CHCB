/// RECORDMAP: Modified during compilation of RecordMap 'CHRONOS.Nomenclature'
/// on 2021-03-10 at 19:25:26.253 [2021-03-10 18:25:26.253 UTC]
/// by user KSC
Class CHRONOS.Nomenclature.BatchOut Extends (%Library.Persistent, EnsLib.RecordMap.SimpleBatch)
{

Parameter XMLNAME = "CHRONOS_Nomenclature_BatchOut";

Parameter RECORDMAPGENERATED = 1;

Parameter BatchHeader;

Parameter HeaderTerm;

Parameter BatchTrailer;

Parameter TrailerTerm;

Parameter IgnoreLeadingData = 0;

Relationship Records As CHRONOS.Nomenclature.Record [ Cardinality = many, Inverse = %ParentBatch ];

Trigger OnDelete [ Event = DELETE ]
{
	Set %ok = ..deleteRecords({ID})
}

Parameter XMLTYPE = "CHRONOS_Nomenclature_BatchOut";

Storage Default
{
<Data name="BatchOutDefaultData">
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
<DataLocation>^CHRONOS.Nomenclature.BatchOutD</DataLocation>
<DefaultData>BatchOutDefaultData</DefaultData>
<IdLocation>^CHRONOS.Nomenclature.BatchOutD</IdLocation>
<IndexLocation>^CHRONOS.Nomenclature.BatchOutI</IndexLocation>
<StreamLocation>^CHRONOS.Nomenclature.BatchOutS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
