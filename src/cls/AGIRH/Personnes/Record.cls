/// RECORDMAP: Generated from RecordMap 'AGIRH.Personnes'
/// on 2021-03-05 at 07:15:52.780 [2021-03-05 06:15:52.780 UTC]
/// by user KSC
Class AGIRH.Personnes.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property NomUsage As %String;

Property NomFamille As %String;

Property Prénom As %String;

Property DateNaissance As %String;

Property CodeSexe As %String;

Property NumINSEE As %String;

Property CodeTitre As %String;

Property CodeSituationFamiliale As %String;

Property LibelSituationFamiliale As %String;

Property LibelléNationalitéactuelle As %String;

Property CommunedeNaissance As %String;

Property LibelléPaysdeNaissance As %String;

Property NombreEnfants As %String;

Property NumérodeVoie As %String;

Property ExtensiondeVoie As %String;

Property TypedeVoie As %String;

Property LibellédeVoie As %String;

Property ComplémentAdresse2 As %String(MAXLEN = 100);

Property CodePostal As %String;

Property LibelléCommune As %String;

Property Téléphone1 As %String;

Property Téléphone2 As %String;

Property Mail As %String;

Property Date1èreEntréedansHôpital As %String;

Property Métier As %String;

Property LibelléMétier As %String;

Property LibelléEmploi As %String;

Property TempsPartielNumérateur As %String;

Property LibelléMotifTpsPartiel As %String;

Property DateEffetContrat As %String;

Property Statut As %String;

Property LibelléStatut As %String;

Property DateDernierDépart As %String;

Property DernierModeSortie As %String;

Property LibelléDernierDépart As %String;

Property Grade As %String;

Property LibelléGrade As %String;

Relationship %ParentBatch As AGIRH.Personnes.BatchIn [ Cardinality = one, Inverse = Records ];

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
<Value>Nomdefamille</Value>
</Value>
<Value name="5">
<Value>Prénom</Value>
</Value>
<Value name="6">
<Value>Datedenaissance</Value>
</Value>
<Value name="7">
<Value>CodeSexe</Value>
</Value>
<Value name="8">
<Value>NINSEEComplet</Value>
</Value>
<Value name="9">
<Value>CodeTitre</Value>
</Value>
<Value name="10">
<Value>CodeSituationFamiliale</Value>
</Value>
<Value name="11">
<Value>LibelSituationFamiliale</Value>
</Value>
<Value name="12">
<Value>LibelléNationalitéactuelle</Value>
</Value>
<Value name="13">
<Value>CommunedeNaissance</Value>
</Value>
<Value name="14">
<Value>LibelléPaysdeNaissance</Value>
</Value>
<Value name="15">
<Value>Nbretotaldenfants</Value>
</Value>
<Value name="16">
<Value>NumérodeVoie</Value>
</Value>
<Value name="17">
<Value>ExtensiondeVoie</Value>
</Value>
<Value name="18">
<Value>TypedeVoie</Value>
</Value>
<Value name="19">
<Value>LibellédeVoie</Value>
</Value>
<Value name="20">
<Value>ComplémentadresseNouv</Value>
</Value>
<Value name="21">
<Value>CodePostal</Value>
</Value>
<Value name="22">
<Value>LibellédelaCommune</Value>
</Value>
<Value name="23">
<Value>NdeTéléphone1</Value>
</Value>
<Value name="24">
<Value>NdeTéléphone2</Value>
</Value>
<Value name="25">
<Value>Mail</Value>
</Value>
<Value name="26">
<Value>Date1èreEntréedansHôpital</Value>
</Value>
<Value name="27">
<Value>LibelléduMétier</Value>
</Value>
<Value name="28">
<Value>LibelléEmploi</Value>
</Value>
<Value name="29">
<Value>TempsPartielNumérateur</Value>
</Value>
<Value name="30">
<Value>LibelléMotifTpsPartiel</Value>
</Value>
<Value name="31">
<Value>DateEffetContrat</Value>
</Value>
<Value name="32">
<Value>Statut</Value>
</Value>
<Value name="33">
<Value>DateDernierDépart</Value>
</Value>
<Value name="34">
<Value>DernierModeSortie</Value>
</Value>
<Value name="35">
<Value>LibelléDernierDépart</Value>
</Value>
<Value name="36">
<Value>Grade</Value>
</Value>
<Value name="37">
<Value>LibelléduGrade</Value>
</Value>
<Value name="38">
<Value>Nomdusage</Value>
</Value>
<Value name="39">
<Value>NomUsage</Value>
</Value>
<Value name="40">
<Value>NomFamille</Value>
</Value>
<Value name="41">
<Value>DateNaissance</Value>
</Value>
<Value name="42">
<Value>NumINSEE</Value>
</Value>
<Value name="43">
<Value>NombreEnfants</Value>
</Value>
<Value name="44">
<Value>ComplémentAdresse2</Value>
</Value>
<Value name="45">
<Value>LibelléCommune</Value>
</Value>
<Value name="46">
<Value>Téléphone1</Value>
</Value>
<Value name="47">
<Value>Téléphone2</Value>
</Value>
<Value name="48">
<Value>LibelléMétier</Value>
</Value>
<Value name="49">
<Value>LibelléGrade</Value>
</Value>
<Value name="50">
<Value>Métier</Value>
</Value>
<Value name="51">
<Value>%ParentBatch</Value>
</Value>
<Value name="52">
<Value>LibelléStatut</Value>
</Value>
</Data>
<DataLocation>^AGIRH.Personnes.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^AGIRH.Personnes.RecordD</IdLocation>
<IndexLocation>^AGIRH.Personnes.RecordI</IndexLocation>
<StreamLocation>^AGIRH.Personnes.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
