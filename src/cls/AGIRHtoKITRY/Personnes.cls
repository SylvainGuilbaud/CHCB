Class AGIRHtoKITRY.Personnes Extends Ens.DataTransformDTL [ DependsOn = (AGIRH.Personnes.BatchIn, KITRY.Personnes.BatchOut) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='AGIRH.Personnes.BatchIn' targetClass='KITRY.Personnes.BatchOut' create='new' language='objectscript' >
<foreach property='source.Records()' key='indice' >
<if condition='indice&gt;1' >
<true>
<assign value='source.Records.(indice).Matricule' property='target.Records.(indice).Matricule' action='set' />
<assign value='$zstrip(source.Records.(indice).NomUsage,"&gt;W")' property='target.Records.(indice).NomUsage' action='set' />
<assign value='$zstrip(source.Records.(indice).NomFamille,"&gt;W")' property='target.Records.(indice).NomFamille' action='set' />
<assign value='$zstrip(source.Records.(indice).Prénom,"&gt;W")' property='target.Records.(indice).Prénom' action='set' />
<assign value='""' property='target.Records.(indice).Prenom2' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).DateNaissance,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateNaissance' action='set' />
<assign value='$zstrip(source.Records.(indice).CodeSexe,"&gt;W")' property='target.Records.(indice).CodeSexe' action='set' />
<assign value='source.Records.(indice).NumINSEE' property='target.Records.(indice).NumINSEE' action='set' />
<assign value='""' property='target.Records.(indice).NumINSEEProv' action='set' />
<assign value='$zstrip(source.Records.(indice).CodeSituationFamiliale,"&gt;W")' property='target.Records.(indice).CodeEtatCivil' action='set' />
<assign value='$zstrip(source.Records.(indice).CodeTitre,"&gt;W")' property='target.Records.(indice).Civilité' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelSituationFamiliale,"&gt;W")' property='target.Records.(indice).LibelléEtatCivil' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléNationalitéactuelle,"&gt;W")' property='target.Records.(indice).Nationalité' action='set' />
<assign value='$zstrip(source.Records.(indice).CommunedeNaissance,"&gt;W")' property='target.Records.(indice).LieuNaissance' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléPaysdeNaissance,"&gt;W")' property='target.Records.(indice).PaysNaissance' action='set' />
<assign value='source.Records.(indice).NombreEnfants' property='target.Records.(indice).NombreEnfants' action='set' />
<if condition='$zstrip(source.Records.(indice).ExtensiondeVoie,"&gt;W")=""' >
<true>
<assign value='$zstrip(source.Records.(indice).NumérodeVoie,"&gt;W")_" "_$zstrip(source.Records.(indice).TypedeVoie,"&gt;W")_" "_$zstrip(source.Records.(indice).LibellédeVoie,"&gt;W")' property='target.Records.(indice).Adresse' action='set' />
</true>
<false>
<assign value='$zstrip(source.Records.(indice).NumérodeVoie,"&gt;W")_" "_$zstrip(source.Records.(indice).ExtensiondeVoie,"&gt;W")_" "_$zstrip(source.Records.(indice).TypedeVoie,"&gt;W")_" "_$zstrip(source.Records.(indice).LibellédeVoie,"&gt;W")' property='target.Records.(indice).Adresse' action='set' />
</false>
</if>
<assign value='$zstrip(source.Records.(indice).ComplémentAdresse2,"&gt;W")' property='target.Records.(indice).ComplémentAdresse' action='set' />
<assign value='$zstrip(source.Records.(indice).CodePostal,"&gt;W")' property='target.Records.(indice).CodePostal' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléCommune,"&gt;W")' property='target.Records.(indice).Commune' action='set' />
<assign value='$zstrip(source.Records.(indice).Téléphone1,"&gt;W")' property='target.Records.(indice).TéléphoneFixe' action='set' />
<assign value='$zstrip(source.Records.(indice).Téléphone2,"&gt;W")' property='target.Records.(indice).TéléphoneGSM' action='set' />
<assign value='$zstrip(source.Records.(indice).Mail,"&gt;W")' property='target.Records.(indice).MailPerso' action='set' />
<assign value='source.Records.(indice).Matricule_"@ch-cotebasque.fr"' property='target.Records.(indice).MailPro' action='set' />
<assign value='""' property='target.Records.(indice).TéléphonePro' action='set' />
<assign value='..ConvertDateTime($E(source.Records.(indice).Date1èreEntréedansHôpital,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateEntréeEtab' action='set' />
<if condition='$zstrip(source.Records.(indice).LibelléMétier,"&gt;W")=""' >
<true>
<assign value='"00000"' property='target.Records.(indice).CodeMétier' action='set' />
</true>
<false>
<assign value='$zstrip(source.Records.(indice).Métier,"&gt;W")' property='target.Records.(indice).CodeMétier' action='set' />
</false>
</if>
<if condition='$zstrip(source.Records.(indice).LibelléMétier,"&gt;W")=""' >
<true>
<assign value='"Non rempli"' property='target.Records.(indice).LibelléMétier' action='set' />
</true>
<false>
<assign value='$zstrip(source.Records.(indice).LibelléMétier,"&gt;W")' property='target.Records.(indice).LibelléMétier' action='set' />
</false>
</if>
<assign value='$zstrip(source.Records.(indice).LibelléEmploi,"&gt;W")' property='target.Records.(indice).LibelléEmploi' action='set' />
<assign value='source.Records.(indice).TempsPartielNumérateur' property='target.Records.(indice).CodeTempsTravail' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléMotifTpsPartiel,"&gt;W")' property='target.Records.(indice).LibelléTempsTravail' action='set' />
<if condition='source.Records.(indice).TempsPartielNumérateur="100"' >
<true>
<assign value='"100"' property='target.Records.(indice).LibelléTempsTravail' action='set' />
</true>
</if>
<assign value='..Lookup("AGIRH_Statut_Contrat",$zstrip(source.Records.(indice).Statut,"&gt;W"))' property='target.Records.(indice).CodeTypeDeContrat' action='set' />
<if condition='..In(target.Records.(indice).CodeTypeDeContrat,"CDD,CDI")' >
<true>
<assign value='..ConvertDateTime($E(source.Records.(indice).DateEffetContrat,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateDébutContrat' action='set' />
</true>
</if>
<assign value='$zstrip(source.Records.(indice).Statut,"&gt;W")' property='target.Records.(indice).CodeContrat' action='set' />
<if condition='$zstrip(source.Records.(indice).Statut,"&gt;W")="3E"' >
<true>
<assign value='"Contrat Accomp. Emploi"' property='target.Records.(indice).LibelleContrat' action='set' />
</true>
<false>
<assign value='$zstrip(source.Records.(indice).LibelléStatut,"&gt;W")' property='target.Records.(indice).LibelleContrat' action='set' />
</false>
</if>
<if condition='$E(source.Records.(indice).DateDernierDépart,1,4)="3000"' >
<true>
<assign value='""' property='target.Records.(indice).DateSortie' action='set' />
</true>
<false>
<assign value='..ConvertDateTime($E(source.Records.(indice).DateDernierDépart,1,10),"%Y/%m/%d","%d/%m/%Y")' property='target.Records.(indice).DateSortie' action='set' />
</false>
</if>
<assign value='$zstrip(source.Records.(indice).DernierModeSortie,"&gt;W")' property='target.Records.(indice).CodeMotifSortie' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléDernierDépart,"&gt;W")' property='target.Records.(indice).LibelléMotifSortie' action='set' />
<assign value='""' property='target.Records.(indice).MatriculeManager' action='set' />
<assign value='$zstrip(source.Records.(indice).Grade,"&gt;W")' property='target.Records.(indice).Grade' action='set' />
<assign value='$zstrip(source.Records.(indice).LibelléGrade,"&gt;W")' property='target.Records.(indice).LibelléGrade' action='set' />
</true>
</if>
</foreach>
</transform>
}

}
