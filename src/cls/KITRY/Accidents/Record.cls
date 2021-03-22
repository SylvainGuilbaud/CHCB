/// RECORDMAP: Generated from RecordMap 'KITRY.Accidents'
/// on 2021-03-08 at 15:48:57.872 [2021-03-08 14:48:57.872 UTC]
/// by user KSC
Class KITRY.Accidents.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property DateAT As %String;

Property HeureAT As %String;

Property CodeTypeAT As %String;

Property LibelléTypeAT As %String;

Property Circonstances As %String(MAXLEN = 200);

Property DateDéclaration As %String;

Property CodeNat1 As %String;

Property LibelléNat1 As %String;

Property CodeNat2 As %String;

Property LibelléNat2 As %String;

Property CodeNat3 As %String;

Property LibelléNat3 As %String;

Property CodeElemMat1 As %String;

Property LibElemMat1 As %String;

Property CodeElemMat2 As %String;

Property LibElemMat2 As %String;

Property CodeElemMat3 As %String;

Property LibElemMat3 As %String;

Property NumAccidentInterne As %String;

Property CodeSiège1 As %String;

Property LibelléSiège1 As %String;

Property CodeSiège2 As %String;

Property LibelléSiège2 As %String;

Property CodeSiège3 As %String;

Property LibelléSiège3 As %String;

Property CodeLésion1 As %String;

Property CodeLésion2 As %String;

Property CodeLésion3 As %String;

Relationship %ParentBatch As KITRY.Accidents.BatchOut [ Cardinality = one, Inverse = Records ];

Index %ParentBatchIdx On %ParentBatch;

Parameter RECORDMAPGENERATED = 1;

Storage Default
{
<Data name="RecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Matricule</Value>
</Value>
<Value name="3">
<Value>%Source</Value>
</Value>
<Value name="4">
<Value>HeureAT</Value>
</Value>
<Value name="5">
<Value>CodeTypeAT</Value>
</Value>
<Value name="6">
<Value>LibelléTypeAT</Value>
</Value>
<Value name="7">
<Value>Circonstances</Value>
</Value>
<Value name="8">
<Value>DateDéclaration</Value>
</Value>
<Value name="9">
<Value>CodeNat1</Value>
</Value>
<Value name="10">
<Value>LibelléNat1</Value>
</Value>
<Value name="11">
<Value>CodeNat2</Value>
</Value>
<Value name="12">
<Value>LibelléNat2</Value>
</Value>
<Value name="13">
<Value>CodeNat3</Value>
</Value>
<Value name="14">
<Value>LibelléNat3</Value>
</Value>
<Value name="15">
<Value>NumAccidentInterne</Value>
</Value>
<Value name="16">
<Value>CodeElemMat1</Value>
</Value>
<Value name="17">
<Value>LibElemMat1</Value>
</Value>
<Value name="18">
<Value>CodeElemMat2</Value>
</Value>
<Value name="19">
<Value>LibElemMat2</Value>
</Value>
<Value name="20">
<Value>CodeElemMat3</Value>
</Value>
<Value name="21">
<Value>LibElemMat3</Value>
</Value>
<Value name="22">
<Value>CodeSiège1</Value>
</Value>
<Value name="23">
<Value>LibelléSiège1</Value>
</Value>
<Value name="24">
<Value>CodeSiège2</Value>
</Value>
<Value name="25">
<Value>LibelléSiège2</Value>
</Value>
<Value name="26">
<Value>CodeSiège3</Value>
</Value>
<Value name="27">
<Value>LibelléSiège3</Value>
</Value>
<Value name="28">
<Value>CodeLésion1</Value>
</Value>
<Value name="29">
<Value>CodeLésion2</Value>
</Value>
<Value name="30">
<Value>CodeLésion3</Value>
</Value>
<Value name="31">
<Value>%ParentBatch</Value>
</Value>
<Value name="32">
<Value>DateAT</Value>
</Value>
</Data>
<DataLocation>^KITRY.Accidents.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^KITRY.Accidents.RecordD</IdLocation>
<IndexLocation>^KITRY.Accidents.RecordI</IndexLocation>
<StreamLocation>^KITRY.Accidents.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
