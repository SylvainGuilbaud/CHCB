/// Clinicom Source
Class ISSAS.Sites.Bayonne.PRD.Prod.RouterCCOMSourceRoutingRule Extends Ens.Rule.Definition [ ProcedureBlock ]
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.VDocRuleAssistCompatible";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.VDocRoutingEngine" production="ISSAS.Sites.Bayonne.PRD.Prod.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="ADT (tous mouvements HPRIM)" disabled="false">
<constraint name="source" value="TCPClinicomHPRIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="ADT,SOR"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="ADT,SOR"></constraint>
<when condition="1">
</when>
</rule>
<rule name="ADT (Mouvements HPRIM Saint Palais)" disabled="false">
<constraint name="source" value="TCPClinicomHPRIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docName" value="ADT,SOR"></constraint>
<when condition="(Document.{P:P21CodeEtablissement}=&quot;01&quot;)">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMToAXBIOCEAN.ADTToADM" target="AxBiocean.ADT.FTP"></send>
</when>
</rule>
<rule name="AD (admission hospit)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="Clinicom:AD"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.ADtoADT" target="Hemadialyse.ADT.FTP,LOGIPREN.ADT.TCP,VENUS.ADT.TCP,LOGIPRENv2.ADT.TCP"></send>
</when>
</rule>
<rule name="AD (admission hospit SYSEO)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="Clinicom:AD"></constraint>
<when condition="Document.{AD3:AD320DateHeureAdmission}&gt;=&quot;201701010000&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.ADtoADT" target="SYSEO.ADT.TCP"></send>
</when>
</rule>
<rule name="AD (admission hospit) NON HISTORIQUE" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="AD01,AD02,AD03,AD04,AD05"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="AD"></constraint>
<when condition="Document.{AD7:AD711IndicateurDernierMouvem}=&quot;1&quot;">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.ADtoADT" target="TCPDraegerOut,TCPQcareOut,FileCopiloteOut,TCPViewpointOut"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHEMOS.ADtoADT" target="FTPHemosOut,FTPImageOut"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.ADtoADT" target="Glims.ADT.TCP"></send>
</when>
</rule>
<rule name="AD (admission hospit) pour CHIMIO" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="AD01,AD02,AD03,AD04,AD05"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="AD"></constraint>
<when condition="(Document.{AD7:AD711IndicateurDernierMouvem}=&quot;1&quot;)&amp;&amp;(Document.{AD3:AD306CodeUF} DoesNotContain &quot;S4&quot;)&amp;&amp;(Document.{AD3:AD306CodeUF} DoesNotContain &quot;S5&quot;)&amp;&amp;(Document.{AD3:AD306CodeUF} DoesNotContain &quot;S8&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoCHIMIO.ADtoADT" target="FileChimioOut"></send>
</when>
</rule>
<rule name="AD (admission hospit) pour GRAAL" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="AD01,AD02,AD03,AD04,AD05"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="AD"></constraint>
<when condition="(Document.{AD7:AD711IndicateurDernierMouvem}=&quot;1&quot;)&amp;&amp;(Lookup(&quot;ISSAS.Sites.Bayonne.PRD.LUT.Graal_US&quot;,Document.{AD3:AD305CodeUS})=&quot;&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoGRAAL.ADtoADT" target="FTPGraalOut"></send>
<return></return>
</when>
</rule>
<rule name="AS (annulation séjour) sauf préad" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="AS01,AS03,AS04,AS05"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="Clinicom:AS"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.AStoADT" target="TCPDraegerOut,TCPViewpointOut"></send>
</when>
</rule>
<rule name="AS (annulation séjour)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="Clinicom:AS"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.AStoADT" target="TCPQcareOut,FileCopiloteOut"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.AStoADT" target="SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,LOGIPREN.ADT.TCP,VENUS.ADT.TCP,LOGIPRENv2.ADT.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.AStoADT" target="Glims.ADT.TCP"></send>
</when>
</rule>
<rule name="CM (Cession Medicament)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="CM01,CM02,CM03"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="Clinicom:CM"></constraint>
<when condition="Document.{CM2:CM202CodeDuMedicament}!=&quot;F28&quot;">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoPIMPIRIN.CMtoCESSION" target="FTPPimpirinOut"></send>
<return></return>
</when>
</rule>
<rule name="DB (Document Bureautique)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DB"></constraint>
<when condition="1">
<send transform="" target="BPClinicomMMA"></send>
<return></return>
</when>
</rule>
<rule name="DL (Médecins du patient)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DL"></constraint>
<when condition="1">
<return></return>
</when>
</rule>
<rule name="DM (Médecins extérieurs)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DM"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<return></return>
</when>
</rule>
<rule name="DMP" disabled="false">
<constraint name="source" value="TCPClinicomDMPIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DMP"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoDMP.DMPSeb" target="FileDMPOut"></send>
<return></return>
</when>
</rule>
<rule name="DO (Données Complémentaires)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DO"></constraint>
<when condition="1">
</when>
</rule>
<rule name="DR" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DR"></constraint>
<when condition="1">
<return></return>
</when>
</rule>
<rule name="DS (sortie hospit) pour HEMO et IMAGE" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="DS01,DS02"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DS"></constraint>
<when condition="Document.{DS:DS18TypeDepartLongSejour}=&quot;&quot;">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHEMOS.DStoADT" target="FTPHemosOut,FTPImageOut"></send>
</when>
</rule>
<rule name="DS (sortie hospit)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DS"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.DStoADT" target="TCPDraegerOut,TCPQcareOut,FileCopiloteOut,TCPViewpointOut"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.DStoADT" target="SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,LOGIPREN.ADT.TCP,VENUS.ADT.TCP,LOGIPRENv2.ADT.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.DStoADT" target="Glims.ADT.TCP"></send>
</when>
</rule>
<rule name="DS (sortie hospit) pour GRAAL" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="DS01,DS02,DS03"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DS"></constraint>
<when condition="(Lookup(&quot;ISSAS.Sites.Bayonne.PRD.LUT.Graal_US&quot;,Document.{DS:DS14CodeUS})=&quot;&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoGRAAL.DStoADT" target="FTPGraalOut"></send>
</when>
</rule>
<rule name="HM (Médecins de l&apos;établissement)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="HM"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.HMtoMFN" target="GLIMS.MFN.File"></send>
<return></return>
</when>
</rule>
<rule name="IA (Indisponibilités Agenda)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="IA"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.AGENDAtoQPLANNER.IAtoSIU" target="TCPQplannerOut"></send>
<return></return>
</when>
</rule>
<rule name="ND (sortie nouveau-né) sauf annulation" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="ND01,ND02"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="ND"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHEMOS.NDtoADT" target="FTPHemosOut,FTPImageOut"></send>
</when>
</rule>
<rule name="ND (sortie nouveau-né)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="ND"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.NDtoADT" target="TCPDraegerOut,TCPQcareOut,FileCopiloteOut,TCPViewpointOut"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.NDtoADT" target="SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,LOGIPREN.ADT.TCP,VENUS.ADT.TCP,LOGIPRENv2.ADT.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.NDtoADT" target="Glims.ADT.TCP"></send>
</when>
</rule>
<rule name="NR (enregistrement nouveau-né)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="NR"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.NRtoADT" target="SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,LOGIPREN.ADT.TCP,VENUS.ADT.TCP,LOGIPRENv2.ADT.TCP"></send>
</when>
</rule>
<rule name="NR (enregistrement nouveau-né) non historique" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="NR"></constraint>
<when condition="Document.{NR3:NR308IndicateurDernierMouvem}=&quot;1&quot;">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.NRtoADT" target="TCPDraegerOut,TCPQcareOut,FileCopiloteOut,TCPViewpointOut"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHEMOS.NRtoADT" target="FTPHemosOut,FTPImageOut"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.NRtoADT" target="Glims.ADT.TCP"></send>
</when>
</rule>
<rule name="OD (cloture externe)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="OD"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.OD2toADT" target="TCPQcareOut"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.OD2toADT" target="SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,LOGIPREN.ADT.TCP,VENUS.ADT.TCP,LOGIPRENv2.ADT.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.ODtoADT" target="Glims.ADT.TCP"></send>
<return></return>
</when>
</rule>
<rule name="OP (pré consultation)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="OP01,OP02"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="OP"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.OPtoADT" target="TCPDraegerOut,TCPQcareOut,FileCopiloteOut,TCPViewpointOut"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHEMOS.OPtoADT" target="FTPHemosOut,FTPImageOut"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.OPtoADT" target="LOGIPREN.ADT.TCP,Hemadialyse.ADT.FTP,LOGIPRENv2.ADT.TCP"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.OPtoADT" target="Glims.ADT.TCP"></send>
<return></return>
</when>
</rule>
<rule name="OR (enregistrement externe) pour CHIMIO" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="OR"></constraint>
<when condition="Document.{OR3:OR315MedecinResponsable.CodeClinicom} In &quot;LAREDO,REMYSTE&quot;">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoCHIMIO.ORtoADT" target="FileChimioOut"></send>
</when>
</rule>
<rule name="OR (enregistrement externe)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="OR"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.ORtoADT" target="TCPDraegerOut,TCPQcareOut,FileCopiloteOut,TCPViewpointOut"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHEMOS.ORtoADT" target="FTPHemosOut,FTPImageOut"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.ORtoADT" target="Hemadialyse.ADT.FTP,LOGIPREN.ADT.TCP,VENUS.ADT.TCP,LOGIPRENv2.ADT.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.ORtoADT" target="Glims.ADT.TCP"></send>
</when>
</rule>
<rule name="OR (enregistrement externe issu des Bornes pour TRAKCARE)" disabled="false">
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="OR01,OR02,OR03,OR04,OR05"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="OR"></constraint>
<when condition="Document.{OR3:OR320Utilisateur.Nom} = &quot;BORNE ADMISSIONS&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoTC.ORtoADT" target="TCPTrakCareOut"></send>
</when>
</rule>
<rule name="OR (enregistrement externe SYSEO)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="OR"></constraint>
<when condition="Document.{OR3:OR307DateHeureEnregistrement}&gt;=&quot;201701010000&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.ORtoADT" target="SYSEO.ADT.TCP"></send>
</when>
</rule>
<rule name="ORM (prescriptions LABO)" disabled="false">
<constraint name="source" value="TCPClinicomHPRIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="ORM"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="ORM"></constraint>
<when condition="Document.{H:H09Destinataire.Code}=&quot;DORNER&quot;">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS.ORMtoOML" target="Glims.OML.File"></send>
<return></return>
</when>
</rule>
<rule name="PA (pré admission)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PA"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.PAtoADT" target="SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,VENUS.ADT.TCP"></send>
</when>
</rule>
<rule name="PA (pré admission) NON HISTORIQUE" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PA01,PA02,PA03"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PA"></constraint>
<when condition="Document.{PA7:PA711IndicateurDernierMouvem}=&quot;1&quot;">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.PAtoADT" target="TCPDraegerOut,TCPQcareOut,FileCopiloteOut"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHEMOS.PAtoADT" target="FTPHemosOut,FTPImageOut"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.PAtoADT" target="Glims.ADT.TCP"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="PB (Démographie base)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PB01,PB02"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PB"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.PBtoADT" target="Glims.ADT.TCP"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="PB (Démographie) pour Doctolib" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PB01,PB02"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PB"></constraint>
<when condition="(Document.{PB:PMB1Mode}=&quot;01&quot;) &amp;&amp; (Document.{PB2:PB219IPPAutre(1)}=&quot;&quot;) || Not(ToUpper(Document.{PB2:PB219IPPAutre(1).Type})=&quot;DOCTOLIB&quot;)">
<send transform="ISSAS.Common.DTL.CCOMtoDOCTOLIB.PBtoADT" target="DOCTOLIB.ADT.HTTP"></send>
</when>
<when condition="Document.{PB:PB01Mode}=&quot;02&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoDOCTOLIB.PBtoADT" target="DOCTOLIB.ADT.HTTP"></send>
</when>
</rule>
<rule name="PB (Démographie base) MODIFICATION SEULEMENT" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PB02"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PB"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.PBtoADT" target="TCPQcareOut,FileCopiloteOut,TCPViewpointOut"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHEMOS.PBtoADT" target="FTPHemosOut,FTPImageOut"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.PBtoADT" target="SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,LOGIPREN.ADT.TCP,VENUS.ADT.TCP,LOGIPRENv2.ADT.TCP"></send>
</when>
</rule>
<rule name="PL (Cloture pre admission)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PL01,PL02,PL03"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PL"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.PLtoADT" target="Hemadialyse.ADT.FTP"></send>
<return></return>
</when>
</rule>
<rule name="PM (Fusion)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PM01,PM02"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PM"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.PMtoADT" target="SYSEO.ADT.TCP,LOGIPREN.ADT.TCP,VENUS.ADT.TCP,LOGIPRENv2.ADT.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.PMtoADT" target="Glims.ADT.TCP"></send>
</when>
</rule>
<rule name="PM (Fusion) IDENTITES SEULEMENT" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PM01"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PM"></constraint>
<when condition="Document.{PM:PM01Mode}=&quot;01&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.PMtoADT" target="TCPDraegerOut,TCPQcareOut,TCPViewpointOut"></send>
<send transform="ISSAS.Common.DTL.Doctolib.CCOMtoHL7v25PMtoADT" target="DOCTOLIB.ADT.HTTP"></send>
</when>
</rule>
<rule name="RI (retour permission)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="RI"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.RItoADT" target="SYSEO.ADT.TCP,VENUS.ADT.TCP"></send>
</when>
</rule>
<rule name="RI (retour permission) pour GRAAL" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="RI01,RI02,RI03"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="RI"></constraint>
<when condition="(Document.{RI: RI20IndicateurDernierMouveme}=&quot;1&quot;)&amp;&amp;(Lookup(&quot;ISSAS.Sites.Bayonne.PRD.LUT.Graal_US&quot;,Document.{RI:RI09CodeUS})=&quot;&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoGRAAL.RItoADT" target="FTPGraalOut"></send>
</when>
</rule>
<rule name="RI (retour permission) non HISTORIQUE" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="RI"></constraint>
<when condition="Document.{RI: RI20IndicateurDernierMouveme}=&quot;1&quot;">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.RItoADT" target="Glims.ADT.TCP"></send>
</when>
</rule>
<rule name="SD (départ permission)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="SD"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.SDtoADT" target="SYSEO.ADT.TCP,VENUS.ADT.TCP"></send>
</when>
</rule>
<rule name="SD (départ permission) pour GRAAL" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="SD"></constraint>
<when condition="(Document.{SD:SD18IndicateurDernierMouveme}=&quot;1&quot;)&amp;&amp;(Lookup(&quot;ISSAS.Sites.Bayonne.PRD.LUT.Graal_US&quot;,Document.{SD:SD12CodeUS})=&quot;&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoGRAAL.SDtoADT" target="FTPGraalOut"></send>
</when>
</rule>
<rule name="SD (départ permission) non HISTORIQUE" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="SD01,SD02,SD03"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="SD"></constraint>
<when condition="Document.{SD:SD18IndicateurDernierMouveme}=&quot;1&quot;">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.SDtoADT" target="Glims.ADT.TCP"></send>
</when>
</rule>
<rule name="SU (sorties urgence)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="SU01,SU02,SU03"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="SU"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<return></return>
</when>
</rule>
<rule name="TR (mutations et venues)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="TR"></constraint>
<when condition="Document.{TR:TR17TypeMutation}=&quot;1&quot;">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
<when condition="Document.{TR:TR17TypeMutation}=&quot;2&quot;">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.TRtoADT" target="SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,LOGIPREN.ADT.TCP,VENUS.ADT.TCP,LOGIPRENv2.ADT.TCP"></send>
</when>
</rule>
<rule name="TR (mutation) pour CHIMIO" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="TR"></constraint>
<when condition="(Document.{TR:TR17TypeMutation}=&quot;0&quot;)&amp;&amp; (Document.{TR:TR26IndicateurDernierMouveme}=&quot;1&quot;)&amp;&amp;(Document.{TR:TR13CodeUF} DoesNotContain &quot;S4&quot;)&amp;&amp;(Document.{TR:TR13CodeUF} DoesNotContain &quot;S5&quot;)&amp;&amp;(Document.{TR:TR13CodeUF} DoesNotContain &quot;S8&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoCHIMIO.TRtoADT" target="FileChimioOut"></send>
</when>
</rule>
<rule name="TR (mutation) pour GRAAL" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="TR"></constraint>
<when condition="(Document.{TR:TR17TypeMutation}=&quot;0&quot;)&amp;&amp;(Document.{TR:TR26IndicateurDernierMouveme}=&quot;1&quot;)&amp;&amp;(Lookup(&quot;ISSAS.Sites.Bayonne.PRD.LUT.Graal_US&quot;,Document.{TR:TR09CodeUS})=&quot;&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoGRAAL.TRtoADT" target="FTPGraalOut"></send>
</when>
</rule>
<rule name="TR (mutation) non historique" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="TR"></constraint>
<when condition="(Document.{TR:TR17TypeMutation}=&quot;1&quot;) &amp;&amp; (Document.{TR:TR26IndicateurDernierMouveme}=&quot;1&quot;)">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.EVtoADT" target="Glims.ADT.TCP"></send>
</when>
<when condition="(Document.{TR:TR17TypeMutation}=&quot;2&quot;) &amp;&amp; (Document.{TR:TR26IndicateurDernierMouveme}=&quot;1&quot;)">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.SVtoADT" target="Glims.ADT.TCP"></send>
</when>
<when condition="(Document.{TR:TR17TypeMutation}=&quot;0&quot;)&amp;&amp; (Document.{TR:TR26IndicateurDernierMouveme}=&quot;1&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.TRtoADT" target="TCPDraegerOut,TCPQcareOut,FileCopiloteOut,TCPViewpointOut"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHEMOS.TRtoADT" target="FTPHemosOut,FTPImageOut"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.TRtoADT" target="Glims.ADT.TCP"></send>
</when>
</rule>
<rule name="UR (urgence)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="UR"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.URtoADT" target="Hemadialyse.ADT.FTP,LOGIPREN.ADT.TCP,VENUS.ADT.TCP,LOGIPRENv2.ADT.TCP"></send>
</when>
</rule>
<rule name="UR (urgence SYSEO)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="UR"></constraint>
<when condition="Document.{UR3:UR307DateHeureEnregistrement}&gt;=&quot;201701010000&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.URtoADT" target="SYSEO.ADT.TCP"></send>
</when>
</rule>
<rule name="UR (urgence) NON HISTORIQUE" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="UR"></constraint>
<when condition="Document.{UR3:UR316IndicateurDernierMouvem}=&quot;1&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.URtoADT" target="TCPDraegerOut,TCPQcareOut,FileCopiloteOut,TCPViewpointOut"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHEMOS.URtoADT" target="FTPHemosOut,FTPImageOut"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.URtoADT" target="Glims.ADT.TCP"></send>
<return></return>
</when>
</rule>
<rule name="UF (FDB des UF)" disabled="false">
<constraint name="source" value="TCPClinicomSTDIn"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="UF"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.UFtoMFN" target="GLIMS.MFN.File"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
