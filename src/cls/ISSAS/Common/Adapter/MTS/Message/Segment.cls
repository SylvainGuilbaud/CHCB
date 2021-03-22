Class ISSAS.Common.Adapter.MTS.Message.Segment Extends (%Persistent, %XML.Adaptor)
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/Adapter/MTS/Message/Segment.xml#3 $";

/// Min length of a segment
Parameter MINLENGTH = 16;

/// Header of segment with 16 characters : MessageType + SegmentCount + MessageId + IsLastSegment + DataSize
Property Header As ISSAS.Common.Adapter.MTS.Message.Header;

/// Data of segment with <DataSize> characters
Property Data As %String(MAXLEN = "");

/// Current timestamp
Property TimeStamp As %String(MAXLEN = "");

/// Message ID
Property MessageGUID As %String(MAXLEN = "");

/// Business Service/Operation name
Property BSBOName As %String(MAXLEN = "");

/// Inbound or Outbound side
Property IsInbound As %String(MAXLEN = "");

Index IdxMessageGUID On MessageGUID;

Index IdxTimeStamp On TimeStamp;

Method %OnNew(initvalue As %CacheString) As %Status [ Private, ProcedureBlock = 1, ServerOnly = 1 ]
{
	Set ..Header = ##class(ISSAS.Common.Adapter.MTS.Message.Header).%New()
	Set ..TimeStamp = $ZDATE($PIECE($HOROLOG,",",1),8)_$E($TR($ZTIME($PIECE($HOROLOG,",",2)),":",""),1,6)_"."_$PIECE($ZTS,".",2)
	Quit $$$OK
}

Method IsValid() As %Status
{
	Set sc = ..Header.IsValid()
	If ($$$ISERR(sc)) { Quit sc }

	If ($NUMBER($L(..Data)) '= $NUMBER(..Header.DataSize))
	{ Quit $$$ERROR($$$GeneralError, "MTS Segment : data size is not valid") }

	If ($L(..MessageGUID) <= 0)
	{ Quit $$$ERROR($$$GeneralError, "MTS Segment : message GUID is not valid") }

	Quit $$$OK
}

Method IsLast() As %Boolean
{
	Quit (..Header.IsLastSegment = "END")
}

Method IsACK() As %Boolean
{
	Quit (..Header.MessageType = "ACK")
}

Method ToString() As %String
{
	Quit ..Header.ToString()_..Data
}

Storage Default
{
<Data name="SegmentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Header</Value>
</Value>
<Value name="3">
<Value>Data</Value>
</Value>
<Value name="4">
<Value>TimeStamp</Value>
</Value>
<Value name="5">
<Value>MessageGUID</Value>
</Value>
<Value name="6">
<Value>BSBOName</Value>
</Value>
<Value name="7">
<Value>IsInbound</Value>
</Value>
</Data>
<DataLocation>^ISSAS.Common.Adapt9272.SegmentD</DataLocation>
<DefaultData>SegmentDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^ISSAS.Common.Adapt9272.SegmentD</IdLocation>
<IndexLocation>^ISSAS.Common.Adapt9272.SegmentI</IndexLocation>
<StreamLocation>^ISSAS.Common.Adapt9272.SegmentS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
