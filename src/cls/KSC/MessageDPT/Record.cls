/// RECORDMAP: Generated from RecordMap 'User.MessageDPT'
/// on 2019-11-20 at 15:20:17.100 [2019-11-20 14:20:17.100 UTC]
/// by user KSC
Class KSC.MessageDPT.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Code As %String;

Property Nom As %String;

Property Info As %String;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Code</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>Info</Value>
</Value>
<Value name="5">
<Value>Nom</Value>
</Value>
</Data>
<DataLocation>^KSC.MessageDPT.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^KSC.MessageDPT.RecordD</IdLocation>
<IndexLocation>^KSC.MessageDPT.RecordI</IndexLocation>
<StreamLocation>^KSC.MessageDPT.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
