/// RECORDMAP: Modified during compilation of RecordMap 'KITRY.Absences'
/// on 2021-03-08 at 14:36:29.848 [2021-03-08 13:36:29.848 UTC]
/// by user KSC
Class KITRY.Absences Extends EnsLib.RecordMap.RecordMap
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

Parameter OBJECTNAME = "KITRY.Absences.Record";

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
		Set pObject.CodeAbsenceQualifiée = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléAbsenceQualifiée = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.DateDébutAbsence = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.DateFinAbsenceCalculée = tCurrString
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
		Set pObject.NuméroAT = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.TypeArrêt = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.SuppressionArrêt = tCurrString
	}
	Quit tStatus
}

/// Internal helper method to output object to a stream
ClassMethod PutRecord(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pHasTopFields As %Boolean, ByRef pPadArray As %String) As %Status [ Internal, Private ]
{
	Set tStatus = $$$OK
	Do pStream.Write($select(pHasTopFields: ..Escape(pObject.Matricule, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeAbsenceQualifiée, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléAbsenceQualifiée, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateDébutAbsence, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateFinAbsenceCalculée, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateAT, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.NuméroAT, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.TypeArrêt, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.SuppressionArrêt, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(13,10), 0, .tStatus)
	If $$$ISERR(tStatus) Quit tStatus
	Quit tStatus
}

ClassMethod GetGeneratedClasses(Output pClasses As %String) As %Status
{
	Kill pClasses
	Set pClasses("KITRY.Absences.BatchOut")=""
	Set pClasses("KITRY.Absences.Record")=""
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
<Record xmlns="http://www.intersystems.com/Ensemble/RecordMap" name="KITRY.Absences" type="delimited" char_encoding="UTF-8" targetClassname="KITRY.Absences.Record" batchClass="KITRY.Absences.BatchOut" complexBatchManaged="0" padFromLeft="0" recordTerminator="\x0d\x0a" escaping="all" escapeSequence="&quot;" allowEarlyTerminator="0">
  <Separators>
    <Separator>;</Separator>
  </Separators>
  <Field name="Matricule" datatype="%String">
  </Field>
  <Field name="CodeAbsenceQualifiée" datatype="%String">
  </Field>
  <Field name="LibelléAbsenceQualifiée" datatype="%String">
  </Field>
  <Field name="DateDébutAbsence" datatype="%String">
  </Field>
  <Field name="DateFinAbsenceCalculée" datatype="%String">
  </Field>
  <Field name="DateAT" datatype="%String">
  </Field>
  <Field name="NuméroAT" datatype="%String">
  </Field>
  <Field name="TypeArrêt" datatype="%String">
  </Field>
  <Field name="SuppressionArrêt" datatype="%String">
  </Field>
</Record>
}

}
