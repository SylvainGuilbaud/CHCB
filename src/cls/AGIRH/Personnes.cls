/// RECORDMAP: Modified during compilation of RecordMap 'AGIRH.Personnes'
/// on 2021-03-05 at 07:15:52.846 [2021-03-05 06:15:52.846 UTC]
/// by user KSC
Class AGIRH.Personnes Extends EnsLib.RecordMap.RecordMap
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

Parameter OBJECTNAME = "AGIRH.Personnes.Record";

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
		Set pObject.CodeTitre = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CodeSituationFamiliale = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelSituationFamiliale = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléNationalitéactuelle = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.CommunedeNaissance = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléPaysdeNaissance = tCurrString
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
		Set pObject.NumérodeVoie = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.ExtensiondeVoie = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.TypedeVoie = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibellédeVoie = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.ComplémentAdresse2 = tCurrString
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
		Set pObject.LibelléCommune = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Téléphone1 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Téléphone2 = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Mail = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Date1èreEntréedansHôpital = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Métier = tCurrString
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
		Set pObject.TempsPartielNumérateur = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléMotifTpsPartiel = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.DateEffetContrat = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.Statut = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléStatut = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.DateDernierDépart = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.DernierModeSortie = tCurrString
	}
	If '$data(tRecordData(tCurrChunk, "block")) {
		Set tCurrString = $piece(tRecordData(tCurrChunk), $char(59), tTopPiece)
	}
	Do ..checkMerge(.tCurrChunk, .tRecordData, .tCurrString, $char(59), .tTopPiece)
	If pGetTopFields {
		Set pObject.LibelléDernierDépart = tCurrString
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
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateNaissance, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeSexe, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.NumINSEE, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeTitre, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodeSituationFamiliale, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelSituationFamiliale, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléNationalitéactuelle, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CommunedeNaissance, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléPaysdeNaissance, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.NombreEnfants, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.NumérodeVoie, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.ExtensiondeVoie, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.TypedeVoie, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibellédeVoie, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.ComplémentAdresse2, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.CodePostal, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléCommune, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Téléphone1, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Téléphone2, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Mail, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Date1èreEntréedansHôpital, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Métier, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléMétier, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléEmploi, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.TempsPartielNumérateur, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléMotifTpsPartiel, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateEffetContrat, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Statut, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléStatut, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DateDernierDépart, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.DernierModeSortie, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléDernierDépart, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.Grade, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(59) _ $select(pHasTopFields: ..Escape(pObject.LibelléGrade, $lb($char(59)),"all",$char(34)),1: $char(34)_$char(34)),0)
	Do pStream.Write($char(13,10), 0, .tStatus)
	If $$$ISERR(tStatus) Quit tStatus
	Quit tStatus
}

ClassMethod GetGeneratedClasses(Output pClasses As %String) As %Status
{
	Kill pClasses
	Set pClasses("AGIRH.Personnes.BatchIn")=""
	Set pClasses("AGIRH.Personnes.Record")=""
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
<Record xmlns="http://www.intersystems.com/Ensemble/RecordMap" name="AGIRH.Personnes" type="delimited" char_encoding="UTF-8" targetClassname="AGIRH.Personnes.Record" batchClass="AGIRH.Personnes.BatchIn" complexBatchManaged="0" padFromLeft="0" recordTerminator="\x0d\x0a" escaping="all" escapeSequence="&quot;" allowEarlyTerminator="0">
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
  <Field name="DateNaissance" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="CodeSexe" datatype="%String">
  </Field>
  <Field name="NumINSEE" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="CodeTitre" datatype="%String">
  </Field>
  <Field name="CodeSituationFamiliale" datatype="%String">
  </Field>
  <Field name="LibelSituationFamiliale" datatype="%String">
  </Field>
  <Field name="LibelléNationalitéactuelle" datatype="%String">
  </Field>
  <Field name="CommunedeNaissance" datatype="%String">
  </Field>
  <Field name="LibelléPaysdeNaissance" datatype="%String">
  </Field>
  <Field name="NombreEnfants" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="NumérodeVoie" datatype="%String">
  </Field>
  <Field name="ExtensiondeVoie" datatype="%String">
  </Field>
  <Field name="TypedeVoie" datatype="%String">
  </Field>
  <Field name="LibellédeVoie" datatype="%String">
  </Field>
  <Field name="ComplémentAdresse2" required="0" ignored="0" datatype="%String" params="MAXLEN=100" repeating="0">
  </Field>
  <Field name="CodePostal" datatype="%String">
  </Field>
  <Field name="LibelléCommune" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Téléphone1" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Téléphone2" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Mail" datatype="%String">
  </Field>
  <Field name="Date1èreEntréedansHôpital" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Métier" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="LibelléMétier" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="LibelléEmploi" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="TempsPartielNumérateur" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="LibelléMotifTpsPartiel" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="DateEffetContrat" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Statut" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="LibelléStatut" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="DateDernierDépart" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="DernierModeSortie" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="LibelléDernierDépart" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="Grade" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
  <Field name="LibelléGrade" required="0" ignored="0" datatype="%String" repeating="0">
  </Field>
</Record>
}

}
