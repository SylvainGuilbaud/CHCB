/// RECORDMAP: Generated from RecordMap 'KITRY.Personnes'
/// on 2021-03-11 at 16:16:51.750 [2021-03-11 15:16:51.750 UTC]
/// by user KSC
Class KITRY.Personnes.Record Extends (%Persistent, %XML.Adaptor, Ens.Request, EnsLib.RecordMap.Base) [ Inheritance = right, ProcedureBlock ]
{

Parameter INCLUDETOPFIELDS = 1;

Property Matricule As %String;

Property NomUsage As %String;

Property NomFamille As %String;

Property Prénom As %String;

Property Prenom2 As %String;

Property DateNaissance As %String;

Property CodeSexe As %String;

Property NumINSEE As %String;

Property NumINSEEProv As %String;

Property Civilité As %String;

Property CodeEtatCivil As %String;

Property LibelléEtatCivil As %String;

Property Nationalité As %String;

Property LieuNaissance As %String;

Property PaysNaissance As %String;

Property NombreEnfants As %String;

Property Adresse As %String;

Property ComplémentAdresse As %String(MAXLEN = 100);

Property CodePostal As %String;

Property Commune As %String;

Property TéléphoneFixe As %String;

Property TéléphoneGSM As %String;

Property MailPerso As %String;

Property MailPro As %String;

Property TéléphonePro As %String;

Property DateEntréeEtab As %String;

Property CodeMétier As %String;

Property LibelléMétier As %String;

Property LibelléEmploi As %String;

Property CodeTempsTravail As %String;

Property LibelléTempsTravail As %String;

Property DateDébutContrat As %String;

Property CodeTypeDeContrat As %String;

Property CodeContrat As %String;

Property LibelleContrat As %String;

Property DateSortie As %String;

Property CodeMotifSortie As %String;

Property LibelléMotifSortie As %String;

Property MatriculeManager As %String;

Property Grade As %String;

Property LibelléGrade As %String;

Property CodeCGOS As %String;

Property LibelleCGOS As %String;

Property CodeCAF As %String;

Property LibelleCAF As %String;

Property CodeTypeContrat As %String;

Property LibelleTypeContrat As %String;

Property Code5 As %String;

Property Libelle5 As %String;

Relationship %ParentBatch As KITRY.Personnes.BatchOut [ Cardinality = one, Inverse = Records ];

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
<Value>Prenom2</Value>
</Value>
<Value name="7">
<Value>Datedenaissance</Value>
</Value>
<Value name="8">
<Value>CodeSexe</Value>
</Value>
<Value name="9">
<Value>NINSEEComplet</Value>
</Value>
<Value name="10">
<Value>NIR</Value>
</Value>
<Value name="11">
<Value>CodeTitre</Value>
</Value>
<Value name="12">
<Value>CodeSituationFamiliale</Value>
</Value>
<Value name="13">
<Value>LibelSituationFamiliale</Value>
</Value>
<Value name="14">
<Value>LibelléNationalitéactuelle</Value>
</Value>
<Value name="15">
<Value>CommunedeNaissance</Value>
</Value>
<Value name="16">
<Value>LibelléPaysdeNaissance</Value>
</Value>
<Value name="17">
<Value>NbretotaldenfantsJ</Value>
</Value>
<Value name="18">
<Value>Adresse</Value>
</Value>
<Value name="19">
<Value>ComplémentadresseNouv</Value>
</Value>
<Value name="20">
<Value>CodePostal</Value>
</Value>
<Value name="21">
<Value>LibellédelaCommune</Value>
</Value>
<Value name="22">
<Value>NdeTéléphone1</Value>
</Value>
<Value name="23">
<Value>NdeTéléphone2</Value>
</Value>
<Value name="24">
<Value>Mail</Value>
</Value>
<Value name="25">
<Value>MailPro</Value>
</Value>
<Value name="26">
<Value>TelPro</Value>
</Value>
<Value name="27">
<Value>Date1èreEntréedansHôpitalJ</Value>
</Value>
<Value name="28">
<Value>CodeMétier</Value>
</Value>
<Value name="29">
<Value>LibelléduMétierJ</Value>
</Value>
<Value name="30">
<Value>LibelléEmploiJ</Value>
</Value>
<Value name="31">
<Value>TempsPartielNumérateurJ</Value>
</Value>
<Value name="32">
<Value>LibelléMotifTpsPartielJ</Value>
</Value>
<Value name="33">
<Value>DateEffetContratJ</Value>
</Value>
<Value name="34">
<Value>TypeContrat</Value>
</Value>
<Value name="35">
<Value>CodeContrat</Value>
</Value>
<Value name="36">
<Value>LibelleContrat</Value>
</Value>
<Value name="37">
<Value>DateDernierDépart</Value>
</Value>
<Value name="38">
<Value>DernierModeSortie</Value>
</Value>
<Value name="39">
<Value>LibelléDernierDépart</Value>
</Value>
<Value name="40">
<Value>MatManager</Value>
</Value>
<Value name="41">
<Value>Grade</Value>
</Value>
<Value name="42">
<Value>LibelléGrade</Value>
</Value>
<Value name="43">
<Value>CodeCGOS</Value>
</Value>
<Value name="44">
<Value>LibelleCGOS</Value>
</Value>
<Value name="45">
<Value>CodeCAF</Value>
</Value>
<Value name="46">
<Value>LibelleCAF</Value>
</Value>
<Value name="47">
<Value>CodeTypeContrat</Value>
</Value>
<Value name="48">
<Value>LibelleTypeContrat</Value>
</Value>
<Value name="49">
<Value>Code5</Value>
</Value>
<Value name="50">
<Value>Libelle5</Value>
</Value>
<Value name="51">
<Value>Nomdusage</Value>
</Value>
<Value name="52">
<Value>NomUsage</Value>
</Value>
<Value name="53">
<Value>NomFamille</Value>
</Value>
<Value name="54">
<Value>DateNaissance</Value>
</Value>
<Value name="55">
<Value>NumINSEE</Value>
</Value>
<Value name="56">
<Value>NumINSEEProv</Value>
</Value>
<Value name="57">
<Value>Civilité</Value>
</Value>
<Value name="58">
<Value>CodeEtatCivil</Value>
</Value>
<Value name="59">
<Value>LibelléEtatCivil</Value>
</Value>
<Value name="60">
<Value>Nationalité</Value>
</Value>
<Value name="61">
<Value>LieuNaissance</Value>
</Value>
<Value name="62">
<Value>PaysNaissance</Value>
</Value>
<Value name="63">
<Value>NombreEnfants</Value>
</Value>
<Value name="64">
<Value>ComplémentAdresse</Value>
</Value>
<Value name="65">
<Value>Commune</Value>
</Value>
<Value name="66">
<Value>TéléphoneFixe</Value>
</Value>
<Value name="67">
<Value>TéléphoneGSM</Value>
</Value>
<Value name="68">
<Value>MailPerso</Value>
</Value>
<Value name="69">
<Value>TéléphonePro</Value>
</Value>
<Value name="70">
<Value>DateEntréeEtab</Value>
</Value>
<Value name="71">
<Value>LibelléMétier</Value>
</Value>
<Value name="72">
<Value>LibelléEmploi</Value>
</Value>
<Value name="73">
<Value>CodeTempsTravail</Value>
</Value>
<Value name="74">
<Value>LibelléTempsTravail</Value>
</Value>
<Value name="75">
<Value>DateDébutContrat</Value>
</Value>
<Value name="76">
<Value>CodeTypeDeContrat</Value>
</Value>
<Value name="77">
<Value>DateSortie</Value>
</Value>
<Value name="78">
<Value>CodeMotifSortie</Value>
</Value>
<Value name="79">
<Value>LibelléMotifSortie</Value>
</Value>
<Value name="80">
<Value>MatriculeManager</Value>
</Value>
<Value name="81">
<Value>%ParentBatch</Value>
</Value>
</Data>
<DataLocation>^KITRY.Personnes.RecordD</DataLocation>
<DefaultData>RecordDefaultData</DefaultData>
<ExtentSize>2000000</ExtentSize>
<IdLocation>^KITRY.Personnes.RecordD</IdLocation>
<IndexLocation>^KITRY.Personnes.RecordI</IndexLocation>
<StreamLocation>^KITRY.Personnes.RecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
