/// Clinicom Source
Class ISSAS.Sites.Bayonne.TRN.Prod.RouterCCOMSourceRoutingRule Extends Ens.Rule.Definition [ ProcedureBlock ]
{

Parameter RuleAssistClass = "EnsLib.MsgRouter.VDocRuleAssistCompatible";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.MsgRouter.VDocRoutingEngine" production="ISSAS.Sites.Bayonne.TRN.Prod.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.ADtoADT" target="HealthConnect.KSC,Health Connect CHCB"></send>
<rule name="ADT (Mouvements HPRIM Saint Palais)" disabled="false">
<constraint name="source" value="CLINICOM.HPR.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docName" value="ADT,SOR"></constraint>
<when condition="(Document.{P:P21CodeEtablissement}=&quot;01&quot;)">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMToAXBIOCEAN.ADTToADM" target="AxBiocean.ADT.FTP"></send>
</when>
</rule>
<rule name="ADT (tous mouvements HPRIM)" disabled="false">
<constraint name="source" value="CLINICOM.HPR.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="ADT,SOR"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="ADT,SOR"></constraint>
<when condition="1">
</when>
</rule>
<rule name="AD (admission hospit)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="Clinicom:AD"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.ADtoADT" target="LOGIPREN.ADT.TCP,Hemadialyse.ADT.FTP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="AD (admission hospit SYSEO)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="Clinicom:AD"></constraint>
<when condition="Document.{AD3:AD320DateHeureAdmission}&gt;=&quot;201701010000&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.ADtoADT" target="SYSEO.ADT.TCP"></send>
</when>
</rule>
<rule name="AD (admission hospit) NON HISTORIQUE" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="AD"></constraint>
<when condition="Document.{AD7:AD711IndicateurDernierMouvem}=&quot;1&quot;">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.ADtoADT" target="QCARE.ADT.TCP,COPILOTE.ADT.File,SMS.ADT.TCP,VIEWPOINT.ADT.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHEMOS.ADtoADT" target="IMAGE.ADT.File"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.ADtoADT" target="GLIMS.ADT.File"></send>
</when>
</rule>
<rule name="AD (admission hospit) pour CHIMIO" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="AD"></constraint>
<when condition="(Document.{AD7:AD711IndicateurDernierMouvem}=&quot;1&quot;)&amp;&amp;(Document.{AD3:AD306CodeUF} DoesNotContain &quot;S4&quot;)&amp;&amp;(Document.{AD3:AD306CodeUF} DoesNotContain &quot;S5&quot;)&amp;&amp;(Document.{AD3:AD306CodeUF} DoesNotContain &quot;S8&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoCHIMIO.ADtoADT" target="CHIMIO.ADT.File"></send>
</when>
</rule>
<rule name="AP (rendez-vous)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="AP1"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoTC.APtoSRM" target="TRAKCARE.SRM.TCP"></send>
<return></return>
</when>
</rule>
<rule name="AS (annulation séjour) sauf pread" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="AS01,AS03,AS04,AS05"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="Clinicom:AS"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.AStoADT" target="VIEWPOINT.ADT.TCP"></send>
</when>
</rule>
<rule name="AS (annulation séjour)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="Clinicom:AS"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.AStoADT" target="QCARE.ADT.TCP,COPILOTE.ADT.File"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.AStoADT" target="LOGIPREN.ADT.TCP,SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.AStoADT" target="GLIMS.ADT.File"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="DB (Document Bureautique)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DB"></constraint>
<when condition="1">
<send transform="" target="BP.MMA.CLINICOM"></send>
</when>
</rule>
<rule name="DL (Médecins du patient)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DL"></constraint>
<when condition="1">
<return></return>
</when>
</rule>
<rule name="DM (Médecins extérieurs)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DM"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="DMP" disabled="false">
<constraint name="source" value="CLINICOM.DMP.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DOC,DMP"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoDMP.DMPSeb" target="DMP.File"></send>
<return></return>
</when>
</rule>
<rule name="DO (Données Complémentaires)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DO"></constraint>
<when condition="1">
<return></return>
</when>
</rule>
<rule name="DR" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DR"></constraint>
<when condition="1">
<return></return>
</when>
</rule>
<rule name="DS (sortie hospit)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DS"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.DStoADT" target="QCARE.ADT.TCP,COPILOTE.ADT.File,SMS.ADT.TCP,VIEWPOINT.ADT.TCP"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.DStoADT" target="LOGIPREN.ADT.TCP,SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.DStoADT" target="GLIMS.ADT.File"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="DS (sortie hospit) pour INFOSERV" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="DS"></constraint>
<when condition="(Lookup(&quot;ISSAS.Sites.Bayonne.PRD.LUT.Infoserv_US&quot;,Document.{DS:DS14CodeUS})!=&quot;&quot;) &amp;&amp; (Document.{DS:DS18TypeDepartLongSejour}=&quot;&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoINFOSERV.DStoUP2" target="INFOSERV.TEL.TCP"></send>
</when>
</rule>

<rule name="HM (Médecins de l&apos;établissement)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="HM"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.HMtoMFN" target="GLIMS.MFN.File"></send>
</when>
</rule>
<rule name="IA (Indisponibilités Agenda)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="IA"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.AGENDAtoQPLANNER.IAtoSIU" target="QPLANNER.SIU.OUT.TCP"></send>
</when>
</rule>
<rule name="ND (sortie nouveau-né)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="ND"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.NDtoADT" target="QCARE.ADT.TCP,COPILOTE.ADT.File,VIEWPOINT.ADT.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.NDtoADT" target="GLIMS.ADT.File"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.NDtoADT" target="LOGIPREN.ADT.TCP,SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
</when>
</rule>
<rule name="NR (enregistrement nouveau-né)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="NR"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.NRtoADT" target="LOGIPREN.ADT.TCP,SYSEO.ADT.TCP,VENUS.ADT.TCP"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="NR (enregistrement nouveau-né) non historique" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="NR"></constraint>
<when condition="Document.{NR3:NR308IndicateurDernierMouvem}=&quot;1&quot;">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.NRtoADT" target="QCARE.ADT.TCP,COPILOTE.ADT.File,VIEWPOINT.ADT.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.NRtoADT" target="GLIMS.ADT.File"></send>
</when>
</rule>
<rule name="OD (cloture externe)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="OD"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.OD2toADT" target="QCARE.ADT.TCP"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.OD2toADT" target="LOGIPREN.ADT.TCP,SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.ODtoADT" target="GLIMS.ADT.File"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="OP (pré consultation)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="OP"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.OPtoADT" target="QCARE.ADT.TCP,COPILOTE.ADT.File,VIEWPOINT.ADT.TCP"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.OPtoADT" target="Hemadialyse.ADT.FTP"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.OPtoADT" target="GLIMS.ADT.File"></send>
</when>
</rule>
<rule name="OR (enregistrement externe) pour CHIMIO" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="OR"></constraint>
<when condition="Document.{OR3:OR315MedecinResponsable.CodeClinicom} In &quot;LAREDO,REMYSTE&quot;">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoCHIMIO.ORtoADT" target="CHIMIO.ADT.File"></send>
</when>
</rule>
<rule name="OR (enregistrement externe)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="OR"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.ORtoADT" target="QCARE.ADT.TCP,COPILOTE.ADT.File,SMS.ADT.TCP,VIEWPOINT.ADT.TCP"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.ORtoADT" target="LOGIPREN.ADT.TCP,Hemadialyse.ADT.FTP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.ORtoADT" target="GLIMS.ADT.File"></send>
</when>
</rule>
<rule name="OR (enregistrement externe SYSEO)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="OR"></constraint>
<when condition="Document.{OR3:OR307DateHeureEnregistrement}&gt;=&quot;201701010000&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.ORtoADT" target="SYSEO.ADT.TCP"></send>
</when>
</rule>
<rule name="ORM (prescriptions LABO)" disabled="false">
<constraint name="source" value="CLINICOM.HPR.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="ORM"></constraint>
<when condition="Document.{H:H09Destinataire.Code}=&quot;DORNER&quot;">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS.ORMtoOML" target="GLIMS.OML.File"></send>
</when>
</rule>
<rule name="PA (pré admission)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PA"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.PAtoADT" target="SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="PA (pré admission) NON HISTORIQUE" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PA"></constraint>
<when condition="Document.{PA7:PA711IndicateurDernierMouvem}=&quot;1&quot;">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.PAtoADT" target="QCARE.ADT.TCP,COPILOTE.ADT.File"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.PAtoADT" target="GLIMS.ADT.File"></send>
</when>
</rule>
<rule name="PB (Démographie base)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PB01,PB02"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PB"></constraint>
<when condition="1">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.PBtoADT" target="GLIMS.ADT.File"></send>
</when>
</rule>
<rule name="PB (Démographie) pour TRAK" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PB01,PB02"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PB"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="PB (Démographie base) MODIFICATION SEULEMENT" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PB02"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PB"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.PBtoADT" target="QCARE.ADT.TCP,COPILOTE.ADT.File,VIEWPOINT.ADT.TCP"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.PBtoADT" target="LOGIPREN.ADT.TCP,SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
</when>
</rule>
<rule name="PL (Cloture pre admission)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PL"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="PM (Fusion)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PM01,PM02"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PM"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.PMtoADT" target="LOGIPREN.ADT.TCP,SYSEO.ADT.TCP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.PMtoADT" target="GLIMS.ADT.File"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.PMtoADT" target="MONDOCTEUR.SIU.OUT.TCP"></send>
</when>
</rule>
<rule name="PM (Fusion) IDENTITES SEULEMENT" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docName" value="PM01"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="PM"></constraint>
<when condition="Document.{PM:PM01Mode}=&quot;01&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.PMtoADT" target="QCARE.ADT.TCP,VIEWPOINT.ADT.TCP"></send>
</when>
</rule>
<rule name="RI (retour permission)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="RI"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.RItoADT" target="SYSEO.ADT.TCP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="RI (retour permission) non HISTORIQUE" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="RI"></constraint>
<when condition="Document.{RI: RI20IndicateurDernierMouveme}=&quot;1&quot;">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.RItoADT" target="GLIMS.ADT.File"></send>
</when>
</rule>
<rule name="SD (départ permission)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="SD"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.SDtoADT" target="SYSEO.ADT.TCP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="SD (départ permission) non HISTORIQUE" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="SD"></constraint>
<when condition="Document.{SD:SD18IndicateurDernierMouveme}=&quot;1&quot;">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.SDtoADT" target="GLIMS.ADT.File"></send>
</when>
</rule>
<rule name="SU (sorties urgence)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="SU"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="TR (mutation et séance)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="TR"></constraint>
<when condition="Document.{TR:TR17TypeMutation}=&quot;1&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.EVtoADT" target="Hemadialyse.ADT.FTP"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
<when condition="Document.{TR:TR17TypeMutation}=&quot;2&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.SVtoADT" target="Hemadialyse.ADT.FTP"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.TRtoADT" target="LOGIPREN.ADT.TCP,SYSEO.ADT.TCP,Hemadialyse.ADT.FTP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="TR (mutations et venues) pour INFOSERV" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="TR"></constraint>
<when condition="(Document.{TR:TR26IndicateurDernierMouveme}=&quot;1&quot;) &amp;&amp; (Lookup(&quot;ISSAS.Sites.Bayonne.PRD.LUT.Infoserv_US&quot;,Document.{TR:TR09CodeUS})!=&quot;&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoINFOSERV.TRtoUP2" target="INFOSERV.TEL.TCP"></send>
</when>
</rule>
<rule name="TR (mutation) pour CHIMIO" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="TR"></constraint>
<when condition="(Document.{TR:TR17TypeMutation}=&quot;0&quot;)&amp;&amp; (Document.{TR:TR26IndicateurDernierMouveme}=&quot;1&quot;)&amp;&amp;(Document.{TR:TR13CodeUF} DoesNotContain &quot;S4&quot;)&amp;&amp;(Document.{TR:TR13CodeUF} DoesNotContain &quot;S5&quot;)&amp;&amp;(Document.{TR:TR13CodeUF} DoesNotContain &quot;S8&quot;)">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoCHIMIO.TRtoADT" target="CHIMIO.ADT.File"></send>
</when>
</rule>
<rule name="TR (mutation et séance) NON HISTORIQUE" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="TR"></constraint>
<when condition="(Document.{TR:TR17TypeMutation}=&quot;1&quot;) &amp;&amp; (Document.{TR:TR26IndicateurDernierMouveme}=&quot;1&quot;)">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.EVtoADT" target="GLIMS.ADT.File"></send>
</when>
<when condition="(Document.{TR:TR17TypeMutation}=&quot;2&quot;) &amp;&amp; (Document.{TR:TR26IndicateurDernierMouveme}=&quot;1&quot;)">
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.SVtoADT" target="GLIMS.ADT.File"></send>
</when>
<when condition="Document.{TR:TR26IndicateurDernierMouveme}=&quot;1&quot;">
<send transform="ISSAS.Sites.Bayonne.PRD.DTL.CCOMtoHL7v231.TRtoADT" target="QCARE.ADT.TCP,COPILOTE.ADT.File,VIEWPOINT.ADT.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.TRtoADT" target="GLIMS.ADT.File"></send>
</when>
</rule>
<rule name="UF (FDB des UF)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="UF"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.UFtoMFN" target="GLIMS.MFN.File"></send>
</when>
</rule>
<rule name="UR (urgence)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="UR"></constraint>
<when condition="1">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.URtoADT" target="LOGIPREN.ADT.TCP,Hemadialyse.ADT.FTP,VENUS.ADT.TCP,VENUS.ADT.File"></send>
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
<rule name="UR (urgence SYSEO)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="UR"></constraint>
<when condition="Document.{UR3:UR307DateHeureEnregistrement}&gt;=&quot;201701010000&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v25.URtoADT" target="SYSEO.ADT.TCP"></send>
</when>
</rule>
<rule name="UR (urgence) NON HISTORIQUE" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="UR"></constraint>
<when condition="Document.{UR3:UR316IndicateurDernierMouvem}=&quot;1&quot;">
<send transform="ISSAS.Common.DTL.CCOMtoHL7v231.URtoADT" target="QCARE.ADT.TCP,COPILOTE.ADT.File,VIEWPOINT.ADT.TCP"></send>
<send transform="ISSAS.Sites.Bayonne.DTL.CCOMtoGLIMS231.URtoADT" target="GLIMS.ADT.File"></send>
</when>
</rule>
<rule name="US (FDB des US)" disabled="false">
<constraint name="source" value="CLINICOM.STD.TCP"></constraint>
<constraint name="msgClass" value="ISSAS.Common.Message.ClinicomHL7"></constraint>
<constraint name="docCategory" value="Clinicom"></constraint>
<constraint name="docType" value="US"></constraint>
<when condition="1">
<send transform="" target="Routeur.CCOMtoTRAK"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
