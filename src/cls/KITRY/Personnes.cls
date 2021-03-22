/// RECORDMAP: Modified during compilation of RecordMap 'KITRY.Personnes'
/// on 2021-03-11 at 16:16:51.832 [2021-03-11 15:16:51.832 UTC]
/// by user KSC
Class KITRY.Personnes Extends EnsLib.RecordMap.RecordMap
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

Parameter OBJECTNAME = "KITRY.Personnes.Record";

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
		Set pObject.NomUsage = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.NomFamille = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Prénom = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Prenom2 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.DateNaissance = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeSexe = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.NumINSEE = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.NumINSEEProv = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Civilité = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeEtatCivil = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléEtatCivil = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Nationalité = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LieuNaissance = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.PaysNaissance = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.NombreEnfants = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Adresse = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.ComplémentAdresse = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodePostal = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Commune = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.TéléphoneFixe = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.TéléphoneGSM = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.MailPerso = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.MailPro = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.TéléphonePro = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.DateEntréeEtab = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeMétier = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléMétier = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléEmploi = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeTempsTravail = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléTempsTravail = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.DateDébutContrat = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeTypeDeContrat = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeContrat = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelleContrat = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.DateSortie = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeMotifSortie = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléMotifSortie = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.MatriculeManager = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Grade = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléGrade = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeCGOS = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelleCGOS = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeCAF = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelleCAF = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeTypeContrat = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelleTypeContrat = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Code5 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Libelle5 = tCurrString
	}
	Quit tStatus
}

/// Internal helper method to output object to a stream
ClassMethod PutRecord(pStream As %IO.DeviceStream, pObject As %RegisteredObject, pHasTopFields As %Boolean, ByRef pPadArray As %String) As %Status [ Internal, Private ]
{
	Set tStatus = $$$OK
	Do pStream.Write($select(pHasTopFields: ..Escape(pObject.Matricule, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.NomUsage, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.NomFamille, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Prénom, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Prenom2, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateNaissance, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeSexe, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.NumINSEE, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.NumINSEEProv, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Civilité, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeEtatCivil, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléEtatCivil, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Nationalité, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LieuNaissance, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.PaysNaissance, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.NombreEnfants, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Adresse, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.ComplémentAdresse, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodePostal, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Commune, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.TéléphoneFixe, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.TéléphoneGSM, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.MailPerso, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.MailPro, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.TéléphonePro, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateEntréeEtab, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeMétier, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléMétier, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléEmploi, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeTempsTravail, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléTempsTravail, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateDébutContrat, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeTypeDeContrat, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeContrat, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelleContrat, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateSortie, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeMotifSortie, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléMotifSortie, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.MatriculeManager, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Grade, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléGrade, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeCGOS, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelleCGOS, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeCAF, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelleCAF, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeTypeContrat, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelleTypeContrat, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Code5, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Libelle5, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(13,10), 0, .tStatus)
	If $$$ISERR(tStatus) Quit tStatus
	Quit tStatus
}

ClassMethod GetGeneratedClasses(Output pClasses As %String) As %Status
{
	Kill pClasses
	Set pClasses("KITRY.Personnes.BatchOut")=""
	Set pClasses("KITRY.Personnes.Record")=""
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
<Record xmlns="http://www.intersystems.com/Ensemble/RecordMap" name="KITRY.Personnes" type="delimited" char_encoding="UTF-8" targetClassname="KITRY.Personnes.Record" batchClass="KITRY.Personnes.BatchOut" complexBatchManaged="0" padFromLeft="0" recordTerminator="\x0d\x0a" escaping="all" escapeSequence="&quot;" allowEarlyTerminator="0">
  <Separators>
    <Separator>;</Separator>
  </Separators>
  <Field name="Matricule" datatype="%String">
  </Field>
  <Field name="NomUsage" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="NomFamille" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Prénom" datatype="%String">
  </Field>
  <Field name="Prenom2" datatype="%String">
  </Field>
  <Field name="DateNaissance" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="CodeSexe" datatype="%String">
  </Field>
  <Field name="NumINSEE" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="NumINSEEProv" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Civilité" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="CodeEtatCivil" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="LibelléEtatCivil" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Nationalité" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="LieuNaissance" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="PaysNaissance" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="NombreEnfants" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Adresse" datatype="%String">
  </Field>
  <Field name="ComplémentAdresse" required="0" ignored="0" datatype="%String" params="MAXLEN=100" repeating="0">
  </Field>
  <Field name="CodePostal" datatype="%String">
  </Field>
  <Field name="Commune" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="TéléphoneFixe" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="TéléphoneGSM" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="MailPerso" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="MailPro" datatype="%String">
  </Field>
  <Field name="TéléphonePro" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="DateEntréeEtab" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="CodeMétier" datatype="%String">
  </Field>
  <Field name="LibelléMétier" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="LibelléEmploi" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="CodeTempsTravail" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="LibelléTempsTravail" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="DateDébutContrat" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="CodeTypeDeContrat" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="CodeContrat" datatype="%String">
  </Field>
  <Field name="LibelleContrat" datatype="%String">
  </Field>
  <Field name="DateSortie" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="CodeMotifSortie" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="LibelléMotifSortie" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="MatriculeManager" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Grade" datatype="%String">
  </Field>
  <Field name="LibelléGrade" datatype="%String">
  </Field>
  <Field name="CodeCGOS" datatype="%String">
  </Field>
  <Field name="LibelleCGOS" datatype="%String">
  </Field>
  <Field name="CodeCAF" datatype="%String">
  </Field>
  <Field name="LibelleCAF" datatype="%String">
  </Field>
  <Field name="CodeTypeContrat" datatype="%String">
  </Field>
  <Field name="LibelleTypeContrat" datatype="%String">
  </Field>
  <Field name="Code5" datatype="%String">
  </Field>
  <Field name="Libelle5" datatype="%String">
  </Field>
</Record>
}

}
