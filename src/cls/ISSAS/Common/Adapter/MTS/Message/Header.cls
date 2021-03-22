Class ISSAS.Common.Adapter.MTS.Message.Header Extends (%SerialObject, %XML.Adaptor)
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/Adapter/MTS/Message/Header.xml#3 $";

/// Message type : DAT, ACK or NAK
Property MessageType As %String(MAXLEN = "");

/// Segment count with 3 characters : min value = 1, max value = 999
Property SegmentCount As %String(MAXLEN = "");

/// Message id with 3 characters : min value = 1, max value = 999
Property MessageId As %String(MAXLEN = "");

/// Last segment flag : END or NLS
Property IsLastSegment As %String(MAXLEN = "");

/// Data size with 4 characters : min value = 0, max value = 9999
Property DataSize As %String(MAXLEN = "");

Method IsValid() As %Status
{
	If ((..MessageType '= "DAT") && (..MessageType '= "ACK") && (..MessageType '= "NAK"))
	{ Quit $$$ERROR($$$GeneralError, "MTS Header : message type is not valid ("_..MessageType_")") }

	If ((..SegmentCount <= 0) || (..SegmentCount > 999))
	{ Quit $$$ERROR($$$GeneralError, "MTS Header : segment count is not valid ("_..SegmentCount_")") }

	If ((..MessageId <= 0) || (..MessageId > 999))
	{ Quit $$$ERROR($$$GeneralError, "MTS Header : message id is not valid ("_..MessageId_")") }

	If ((..IsLastSegment '= "END") && (..IsLastSegment '= "NLS"))
	{ Quit $$$ERROR($$$GeneralError, "MTS Header : last segment flag is not valid ("_..IsLastSegment_")") }

	If ((..DataSize < 0) || (..DataSize > 9999))
	{ Quit $$$ERROR($$$GeneralError, "MTS Header : data size is not valid ("_..DataSize_")") }

	Quit $$$OK
}

Method ToString() As %String
{
	Set str = $E(..MessageType, 1, 3)
	Set str = str_$E($TR($J(..SegmentCount, 3), " ", "0"), 1, 3)
	Set str = str_$E($TR($J(..MessageId, 3), " ", "0"), 1, 3)
	Set str = str_$E(..IsLastSegment, 1, 3)
	Set str = str_$E($TR($J(..DataSize, 4), " ", "0"), 1, 4)
	Quit str
}

Storage Default
{
<Data name="HeaderState">
<Value name="1">
<Value>MessageType</Value>
</Value>
<Value name="2">
<Value>SegmentCount</Value>
</Value>
<Value name="3">
<Value>MessageId</Value>
</Value>
<Value name="4">
<Value>IsLastSegment</Value>
</Value>
<Value name="5">
<Value>DataSize</Value>
</Value>
</Data>
<State>HeaderState</State>
<StreamLocation>^ISSAS.Common.Adapte9272.HeaderS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
