Class ISSAS.Common.Adapter.MTS.Message.ListOfSegment Extends (%Library.ListOfObjects, %RegisteredObject, %XML.Adaptor) [ Inheritance = right ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/Adapter/MTS/Message/ListOfSegment.xml#3 $";

Parameter ELEMENTTYPE = "ISSAS.Common.Adapter.MTS.Message.Segment";

Method GetLast() As ISSAS.Common.Adapter.MTS.Message.Segment
{
	If (..Count() <= 0) { Quit "" }
	Quit ..GetAt(..Count())
}

Storage Custom
{
<Type>%Library.CompleteCustomStorage</Type>
}

}
