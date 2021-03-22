/// RECORDMAP: Modified during compilation of RecordMap 'KITRY.Accidents'
/// on 2021-03-08 at 15:48:57.915 [2021-03-08 14:48:57.915 UTC]
/// by user KSC
Class KITRY.Accidents Extends EnsLib.RecordMap.RecordMap
{

/// Method to retrieve a record from a stream or device. This method will be generated based on the
/// structure of the RecordMap. For testing purposes, a file name may be passed in the pStream argument.
ClassMethod GetObject(pStream As %IO.DeviceStream, Output pObject As %RegisteredObject, pTimeout As %Numeric = -1, ByRef pLookAhead As %String = "", pLabelFound As %Boolean = 0) As %Status
{
	Try {
		Set tStatus = $$$OK
		Set pObject = $$$NULLOREF
		If '$IsObject(pStream) {
			Set tFilename = pStream
			Set pStream = ##class(%IO.FileStream).%New()
			Do pStream.Open(tFilename,,pTimeout,"UTF-8", .tStatus)
			If $$$ISERR(tStatus) Quit
		}
		Set tObjectName = $parameter($this,"OBJECTNAME")
		Set tObject = $classmethod(tObjectName,"%New")
		If '$IsObject(tObject) {
			Set tStatus = $$$ERROR($$$CannotCreateObject,tObjectName)
			Quit
		}
		Set tObject.%Source = pStream.Name
		Set tGetTopFields = $parameter(tObject,"INCLUDETOPFIELDS")
		If pStream.AtEnd && (""=pLookAhead) {
			Set tStatus = $$$ERROR($$$EnsRecordMapErrStreamAtEnd, pStream.Name)
			Quit
		}
		Set pStream.CharEncoding = "UTF-8"

		#; Parse incoming stream
		Set tStatus = ..GetRecord(pStream, tObject, tGetTopFields, pTimeout, .pLookAhead, pLabelFound)
		If $$$ISERR(tStatus) Quit
	}
	Catch ex {
		Set tStatus = ex.AsStatus()
	}
	If $$$ISERR(tStatus) { Set pObject = $$$NULLOREF }
	Else { Set pObject = tObject }
	Quit tStatus
}

/// Method to write a record to a stream or device. This method will be generated based on the
/// structure of the RecordMap. For testing purposes, a file name may be passed in the pStream argument.
ClassMethod PutObject(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pFlush As %Boolean = 1, ByRef pPadArray As %String) As %Status
{
	Try {
		Set tStatus = $$$OK
		If '$IsObject(pStream) {
			Set tFilename = pStream
			Set pStream = ##class(%IO.FileStream).%New()
			Do pStream.Open(tFilename,"WAE",,"UTF-8", .tStatus)
			If $$$ISERR(tStatus) Quit
		}
		Set tHasTopFields = $parameter(pObject,"INCLUDETOPFIELDS")
		Set pStream.CharEncoding = "UTF-8"

		Set tStatus = ..PutRecord(pStream, pObject, tHasTopFields, .pPadArray)
		If $$$ISERR(tStatus) Quit
		If pFlush Do pStream.Flush(.tStatus)
		If $$$ISERR(tStatus) Quit
	}
	Catch ex {
		Set tStatus = ex.AsStatus()
	}
	Quit tStatus
}

Parameter OBJECTNAME = "KITRY.Accidents.Record";

/// Internal helper method to perform parse of incoming data
ClassMethod GetRecord(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pGetTopFields As %Boolean, pTimeout As %Numeric, ByRef pLookAhead As %String = "", pLabelFound As %Boolean = 0) As %Status [ Internal, Private ]
{
	Set tStatus = $$$OK
	If pLabelFound { Set tRecLabel = "" } 
	Else { Set tRecLabel = "" } 
	Set tStatus = ..chunkRecord(pStream, .tRecordData, .tCharCount, "", pTimeout, $char(13,10), tRecLabel, .pLookAhead, $char(34))
	If $$$ISERR(tStatus) Quit tStatus
	Set tMaxLocal = $$$MaxLocalLength
	Set tRecordData("charcount") = +$get(tCharCount)
	Set tCurrChunk = 1
	Set tTopPiece = 1
	Set tCurrSep = 1
	Set tStrings = 1
	Set tCurrString = ""
	Set tSeps = $listbuild($char(59))
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Else {
		Set tCurrString = tRecordData(tCurrChunk)
		Set tCurrPiece = 1
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Matricule = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.DateAT = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.HeureAT = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeTypeAT = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléTypeAT = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Circonstances = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.DateDéclaration = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeNat1 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléNat1 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeNat2 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléNat2 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeNat3 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléNat3 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeElemMat1 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibElemMat1 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeElemMat2 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibElemMat2 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeElemMat3 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibElemMat3 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.NumAccidentInterne = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeSiège1 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléSiège1 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeSiège2 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléSiège2 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeSiège3 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléSiège3 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeLésion1 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeLésion2 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeLésion3 = tCurrString
	}
	Quit tStatus
}

/// Internal helper method to output object to a stream
ClassMethod PutRecord(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pHasTopFields As %Boolean, ByRef pPadArray As %String) As %Status [ Internal, Private ]
{
	Set tStatus = $$$OK
	Do pStream.Write($select(pHasTopFields: ..Escape(pObject.Matricule, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateAT, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.HeureAT, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeTypeAT, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléTypeAT, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Circonstances, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateDéclaration, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeNat1, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléNat1, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeNat2, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléNat2, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeNat3, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléNat3, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeElemMat1, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibElemMat1, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeElemMat2, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibElemMat2, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeElemMat3, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibElemMat3, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.NumAccidentInterne, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeSiège1, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléSiège1, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeSiège2, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléSiège2, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeSiège3, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléSiège3, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeLésion1, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeLésion2, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeLésion3, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(13,10), 0, .tStatus)
	If $$$ISERR(tStatus) Quit tStatus
	Quit tStatus
}

ClassMethod GetGeneratedClasses(Output pClasses As %String) As %Status
{
	Kill pClasses
	Set pClasses("KITRY.Accidents.BatchOut")=""
	Set pClasses("KITRY.Accidents.Record")=""
	Set pClasses($classname())=""
	Quit $$$OK
}

ClassMethod getIdentifier() As %String [ CodeMode = expression ]
{
""
}

ClassMethod getType() As EnsLib.RecordMap.Model.DataType.RecordType [ CodeMode = expression ]
{
"delimited"
}

XData RecordMap [ XMLNamespace = "http://www.intersystems.com/Ensemble/RecordMap" ]
{
<Record xmlns="http://www.intersystems.com/Ensemble/RecordMap" name="KITRY.Accidents" type="delimited" char_encoding="UTF-8" targetClassname="KITRY.Accidents.Record" batchClass="KITRY.Accidents.BatchOut" complexBatchManaged="0" padFromLeft="0" recordTerminator="\x0d\x0a" escaping="all" escapeSequence="&quot;" allowEarlyTerminator="0">
  <Separators>
    <Separator>;</Separator>
  </Separators>
  <Field name="Matricule" datatype="%String">
  </Field>
  <Field name="DateAT" datatype="%String">
  </Field>
  <Field name="HeureAT" datatype="%String">
  </Field>
  <Field name="CodeTypeAT" datatype="%String">
  </Field>
  <Field name="LibelléTypeAT" datatype="%String">
  </Field>
  <Field name="Circonstances" required="0" ignored="0" datatype="%String" params="MAXLEN=200" repeating="0">
  </Field>
  <Field name="DateDéclaration" datatype="%String">
  </Field>
  <Field name="CodeNat1" datatype="%String">
  </Field>
  <Field name="LibelléNat1" datatype="%String">
  </Field>
  <Field name="CodeNat2" datatype="%String">
  </Field>
  <Field name="LibelléNat2" datatype="%String">
  </Field>
  <Field name="CodeNat3" datatype="%String">
  </Field>
  <Field name="LibelléNat3" datatype="%String">
  </Field>
  <Field name="CodeElemMat1" datatype="%String">
  </Field>
  <Field name="LibElemMat1" datatype="%String">
  </Field>
  <Field name="CodeElemMat2" datatype="%String">
  </Field>
  <Field name="LibElemMat2" datatype="%String">
  </Field>
  <Field name="CodeElemMat3" datatype="%String">
  </Field>
  <Field name="LibElemMat3" datatype="%String">
  </Field>
  <Field name="NumAccidentInterne" datatype="%String">
  </Field>
  <Field name="CodeSiège1" datatype="%String">
  </Field>
  <Field name="LibelléSiège1" datatype="%String">
  </Field>
  <Field name="CodeSiège2" datatype="%String">
  </Field>
  <Field name="LibelléSiège2" datatype="%String">
  </Field>
  <Field name="CodeSiège3" datatype="%String">
  </Field>
  <Field name="LibelléSiège3" datatype="%String">
  </Field>
  <Field name="CodeLésion1" datatype="%String">
  </Field>
  <Field name="CodeLésion2" datatype="%String">
  </Field>
  <Field name="CodeLésion3" datatype="%String">
  </Field>
</Record>
}

}
