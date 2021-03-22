Class KSC.PROD.Formation Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="KSC.PROD.Formation" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="TransfertBORNESIn" Category="Bornes" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">C:\data\kristian\in</Setting>
    <Setting Target="Host" Name="TargetConfigNames">BornesQMATICOut</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.doc</Setting>
  </Item>
  <Item Name="BornesQMATICOut" Category="Bornes" ClassName="EnsLib.File.PassthroughOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Filename">%f</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\data\kristian\out\</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
  </Item>
  <Item Name="EnsClinicomTRNIn" Category="" ClassName="EnsLib.HL7.Service.TCPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Port">39001</Setting>
    <Setting Target="Host" Name="TargetConfigNames">RouteurCCOM.KSC,RouteurDoctolib.KSC</Setting>
    <Setting Target="Host" Name="MessageSchemaCategory">2.5</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Host" Name="Framing">MLLP</Setting>
  </Item>
  <Item Name="RouteurCCOM.KSC" Category="" ClassName="EnsLib.MsgRouter.VDocRoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">RouteurCCOM.KSCRoutingRule</Setting>
    <Setting Target="Host" Name="RuleLogging">r</Setting>
  </Item>
  <Item Name="Ens.Alert" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Alertes.EMAIL</Setting>
  </Item>
  <Item Name="Mail.Alert" Category="" ClassName="EnsLib.EMail.AlertOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="SMTPPort">25</Setting>
    <Setting Target="Adapter" Name="SMTPServer">172.17.0.210</Setting>
    <Setting Target="Adapter" Name="From">HealthConnectTRN@chcb.local</Setting>
    <Setting Target="Adapter" Name="Recipient">kschlecht@ch-cotebasque.fr;psabathie@ch-cotebasque.fr</Setting>
  </Item>
  <Item Name="FromVenus" Category="" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">2.5.1</Setting>
    <Setting Target="Host" Name="TargetConfigNames">VenusRouteur</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\data\kristian\in\</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.hl7</Setting>
  </Item>
  <Item Name="ToTrakCare" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">C:\data\kristian\out\</Setting>
    <Setting Target="Host" Name="Filename">%f_%Q%!+(_a)</Setting>
  </Item>
  <Item Name="VenusRouteur" Category="" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">KSC.FromVenus1</Setting>
  </Item>
  <Item Name="FromDEPT" Category="" ClassName="EnsLib.RecordMap.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">MessageDPT</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\data\kristian\csv\</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.csv</Setting>
    <Setting Target="Adapter" Name="WorkPath">C:\data\kristian\csv\workpath\</Setting>
    <Setting Target="Host" Name="TargetConfigNames">RouteurDEPT</Setting>
  </Item>
  <Item Name="RouteurDEPT" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">KSC.Regles.RouteurDEPT</Setting>
  </Item>
  <Item Name="ToDEPTOut" Category="" ClassName="EnsLib.RecordMap.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="RecordMap">MessageDPT</Setting>
    <Setting Target="Adapter" Name="FilePath">C:\data\kristian\csv\out\</Setting>
    <Setting Target="Host" Name="Filename">NEW-%f</Setting>
  </Item>
  <Item Name="Titan.Files.ADT" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Filename">Titan%q.hl7</Setting>
    <Setting Target="Adapter" Name="FilePath">\\srv-titanght\interfaces$\TRN\</Setting>
    <Setting Target="Host" Name="DefCharEncoding">Native</Setting>
  </Item>
  <Item Name="TITAN.EPS-Garazi.ADT" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Filename">EPSGarazi%q.hl7</Setting>
    <Setting Target="Adapter" Name="FilePath">\\srv-titanght\interfaces$\TRN\</Setting>
    <Setting Target="Host" Name="DefCharEncoding">Native</Setting>
  </Item>
  <Item Name="RouterCCOMSource" Category="RAD,LABO" ClassName="EnsLib.MsgRouter.VDocRoutingEngine" PoolSize="1" Enabled="false" Foreground="false" Comment="Clinicom -&gt; Trakcare et autres" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Validation"></Setting>
    <Setting Target="Host" Name="BusinessRuleName">ISSAS.Sites.Bayonne.PRD.Prod.RouterCCOMSourceRoutingRule</Setting>
  </Item>
  <Item Name="TCP.Ensemble.CwsTRN.StdIn" Category="" ClassName="ISSAS.Common.BS.MTS.TCPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Port">39002</Setting>
    <Setting Target="Host" Name="TargetConfigNames">RouteurCCOM.KSC</Setting>
    <Setting Target="Host" Name="MSHSendingApp">CLINICOM</Setting>
    <Setting Target="Host" Name="MSHSendingFacility">SHS</Setting>
    <Setting Target="Adapter" Name="QSize">0</Setting>
    <Setting Target="Host" Name="DaysToKeepMessages">120</Setting>
    <Setting Target="Host" Name="EnableSearchTableWarning">1</Setting>
    <Setting Target="Host" Name="SearchTableClass">ISSAS.Common.SearchTable.Clinicom</Setting>
  </Item>
  <Item Name="TCP.Ensemble.Doctolib.SIU" Category="" ClassName="ISSAS.Common.BS.MTS.TCPService" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Port">39003</Setting>
    <Setting Target="Host" Name="TargetConfigNames">RouteurCCOM.KSC</Setting>
    <Setting Target="Host" Name="MSHSendingApp">CLINICOM</Setting>
    <Setting Target="Host" Name="MSHSendingFacility">SHS</Setting>
    <Setting Target="Adapter" Name="QSize">0</Setting>
    <Setting Target="Host" Name="DaysToKeepMessages">120</Setting>
    <Setting Target="Host" Name="MSHDocType">ClinicomReceiver</Setting>
  </Item>
  <Item Name="Routeur.CCOM.Source" Category="" ClassName="EnsLib.MsgRouter.VDocRoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="Validation"></Setting>
    <Setting Target="Host" Name="BusinessRuleName">ISSAS.Sites.Bayonne.TRN.Prod.RouterCCOMSourceRoutingRule</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="VENUS.ADT.File" Category="" ClassName="ISSAS.Common.BO.HL7.FileOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">\\SRV-VENUSINT\Interfaces\\ADT</Setting>
    <Setting Target="Host" Name="FileNameFormat">ADT%cpt04%.HL7</Setting>
    <Setting Target="Host" Name="SendFileOk">0</Setting>
    <Setting Target="Host" Name="MSHReceivingApp">VENUS</Setting>
    <Setting Target="Host" Name="MSHReceivingFacility">NICESOFT</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Host" Name="MSHVersionId">2.5</Setting>
    <Setting Target="Host" Name="SearchTableClass">ISSAS.Common.SearchTable.HL7v25IHE</Setting>
    <Setting Target="Host" Name="DaysToKeepMessages">120</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="TitanQ.ADT.Files" Category="" ClassName="ISSAS.Common.BO.HL7.FileOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">\\srv-titanght\interfaces$\TRN\</Setting>
    <Setting Target="Host" Name="FileNameFormat">ADT%cpt05%.HL7</Setting>
    <Setting Target="Host" Name="SendFileOk">1</Setting>
    <Setting Target="Host" Name="MSHReceivingApp">TITAN</Setting>
    <Setting Target="Host" Name="MSHReceivingFacility">MALTA</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Host" Name="MSHVersionId">2.5</Setting>
    <Setting Target="Host" Name="SearchTableClass">ISSAS.Common.SearchTable.HL7v25IHE</Setting>
    <Setting Target="Host" Name="DaysToKeepMessages">120</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
    <Setting Target="Host" Name="EnableSearchTableWarning">1</Setting>
    <Setting Target="Host" Name="ReplyCodeActions">E=R</Setting>
    <Setting Target="Host" Name="SendSuperSession">1</Setting>
  </Item>
  <Item Name="CLINICOM.TCP" Category="" ClassName="ISSAS.Common.BO.MTS.TCPOperation" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Port">8083</Setting>
    <Setting Target="Adapter" Name="IPAddress">!</Setting>
    <Setting Target="Host" Name="DaysToKeepMessages">120</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="RouterDoctolibHL7" Category="RDV" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Validation"></Setting>
    <Setting Target="Host" Name="BusinessRuleName">ISSAS.Sites.Bayonne.TRN.Prod.RouterDoctolibHL7RoutingRule</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="Routeur.CCOM.Cible" Category="Health Connect CHCB" ClassName="EnsLib.MsgRouter.VDocRoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Validation"></Setting>
    <Setting Target="Host" Name="BusinessRuleName">ISSAS.Sites.Bayonne.TRN.Prod.RouterCCOMTargetRoutingRule</Setting>
    <Setting Target="Host" Name="InactivityTimeout">0</Setting>
  </Item>
  <Item Name="TCP.Ensemble.Doctolib.SIUIn" Category="" ClassName="ISSAS.Common.BS.MTS.TCPServiceKSC" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Port">39003</Setting>
    <Setting Target="Adapter" Name="QSize">0</Setting>
    <Setting Target="Host" Name="TargetConfigNames">RouteurCCOM.KSC</Setting>
  </Item>
  <Item Name="Mail.KSC" Category="" ClassName="EnsLib.EMail.AlertOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="From">HealthConnectTRN@ch-cotebasque.fr</Setting>
    <Setting Target="Adapter" Name="Recipient">kschlecht@ch-cotebasque.fr</Setting>
    <Setting Target="Adapter" Name="SMTPPort">25</Setting>
    <Setting Target="Adapter" Name="SMTPServer">172.17.0.210</Setting>
  </Item>
  <Item Name="RouteurDoctolib.KSC" Category="" ClassName="EnsLib.MsgRouter.VDocRoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">RouteurDoctolib.KSCRoutingRule</Setting>
  </Item>
  <Item Name="FileToMail" Category="" ClassName="EnsLib.File.PassthroughService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">C:\data\kristian\in</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Router.ToMail</Setting>
    <Setting Target="Host" Name="AlertOnError">1</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.txt</Setting>
  </Item>
  <Item Name="Router.ToMail" Category="" ClassName="EnsLib.MsgRouter.VDocRoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">KSC.FileToMail</Setting>
  </Item>
  <Item Name="FTP.CHCB.Arborescence.FromAGIRH" Category="" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="@Kitry">
    <Setting Target="Adapter" Name="Credentials">MIPIH</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.17.0.119</Setting>
    <Setting Target="Adapter" Name="FilePath">MIPIH/BO/KITRY</Setting>
    <Setting Target="Adapter" Name="FileSpec">CHCB_Arbo*.txt</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Router.Kitry</Setting>
    <Setting Target="Adapter" Name="ServerListStyle">MSDOS</Setting>
    <Setting Target="Adapter" Name="UseFileStream">0</Setting>
    <Setting Target="Host" Name="RecordMap">AGIRH.Arborescence</Setting>
    <Setting Target="Host" Name="BatchClass">AGIRH.Arborescence.BatchIn</Setting>
  </Item>
  <Item Name="Router.Kitry" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">Router.KitryRoutingRule</Setting>
  </Item>
  <Item Name="FTP.CHCB.Arborescence.ToKITRY" Category="" ClassName="EnsLib.RecordMap.Operation.BatchFTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">KITRY</Setting>
    <Setting Target="Adapter" Name="FTPPort">22</Setting>
    <Setting Target="Adapter" Name="FTPServer">80.94.184.35</Setting>
    <Setting Target="Host" Name="Filename">ARBORESCENCE_SL.CSV</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="StayConnected">60</Setting>
    <Setting Target="Host" Name="RecordMap">KITRY.Arborescence</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Host" Name="SendSuperSession">0</Setting>
    <Setting Target="Adapter" Name="SFTPAppendMode">Client</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">0600</Setting>
    <Setting Target="Adapter" Name="SSLConfig"></Setting>
    <Setting Target="Host" Name="DefaultBatchClass">KITRY.Arborescence.BatchOut</Setting>
  </Item>
  <Item Name="FTP.CHCB.Affectation.FromAGIRH" Category="" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="@Kitry">
    <Setting Target="Adapter" Name="Credentials">MIPIH</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.17.0.119</Setting>
    <Setting Target="Adapter" Name="FilePath">MIPIH/BO/KITRY</Setting>
    <Setting Target="Adapter" Name="FileSpec">CHCB_Affec*.txt</Setting>
    <Setting Target="Host" Name="RecordMap">AGIRH.Affectations</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Router.Kitry</Setting>
    <Setting Target="Adapter" Name="ServerListStyle">MSDOS</Setting>
    <Setting Target="Adapter" Name="UseFileStream">0</Setting>
    <Setting Target="Host" Name="BatchClass">AGIRH.Affectations.BatchIn</Setting>
  </Item>
  <Item Name="FTP.CHCB.Affectations.ToKITRY" Category="" ClassName="EnsLib.RecordMap.Operation.BatchFTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">KITRY</Setting>
    <Setting Target="Adapter" Name="FTPPort">22</Setting>
    <Setting Target="Adapter" Name="FTPServer">80.94.184.35</Setting>
    <Setting Target="Host" Name="Filename">AFFECTATIONS_SL.CSV</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="StayConnected">60</Setting>
    <Setting Target="Host" Name="RecordMap">KITRY.Affectations</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Host" Name="SendSuperSession">0</Setting>
    <Setting Target="Adapter" Name="SFTPAppendMode">Client</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">0600</Setting>
    <Setting Target="Host" Name="DefaultBatchClass">KITRY.Affectations.BatchOut</Setting>
  </Item>
  <Item Name="FTP.CHCB.Personnes.FromAGIRH" Category="" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="@Kitry">
    <Setting Target="Adapter" Name="Credentials">MIPIH</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.17.0.119</Setting>
    <Setting Target="Adapter" Name="FilePath">MIPIH/BO/KITRY</Setting>
    <Setting Target="Adapter" Name="FileSpec">CHCB_Perso*.txt</Setting>
    <Setting Target="Host" Name="RecordMap">AGIRH.Personnes</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Router.Kitry</Setting>
    <Setting Target="Adapter" Name="ServerListStyle">MSDOS</Setting>
    <Setting Target="Adapter" Name="UseFileStream">0</Setting>
    <Setting Target="Host" Name="BatchClass">AGIRH.Personnes.BatchIn</Setting>
  </Item>
  <Item Name="FTP.CHCB.Personnes.ToKITRY" Category="" ClassName="EnsLib.RecordMap.Operation.BatchFTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">KITRY</Setting>
    <Setting Target="Adapter" Name="FTPPort">22</Setting>
    <Setting Target="Adapter" Name="FTPServer">80.94.184.35</Setting>
    <Setting Target="Host" Name="Filename">PERSONNES_SL.CSV</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="StayConnected">60</Setting>
    <Setting Target="Host" Name="RecordMap">KITRY.Personnes</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Host" Name="SendSuperSession">0</Setting>
    <Setting Target="Adapter" Name="SFTPAppendMode">Client</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">0600</Setting>
    <Setting Target="Adapter" Name="SSLConfig"></Setting>
    <Setting Target="Host" Name="DefaultBatchClass">KITRY.Personnes.BatchOut</Setting>
  </Item>
  <Item Name="FTP.CHCB.Handicap.FromAGIRH" Category="" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="@Kitry">
    <Setting Target="Adapter" Name="Credentials">MIPIH</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.17.0.119</Setting>
    <Setting Target="Adapter" Name="FilePath">MIPIH/BO/KITRY</Setting>
    <Setting Target="Adapter" Name="FileSpec">CHCB_Handi*.txt</Setting>
    <Setting Target="Host" Name="RecordMap">AGIRH.Handicap</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Router.Kitry</Setting>
    <Setting Target="Adapter" Name="ServerListStyle">MSDOS</Setting>
    <Setting Target="Adapter" Name="UseFileStream">0</Setting>
    <Setting Target="Host" Name="BatchClass">AGIRH.Handicap.BatchIn</Setting>
  </Item>
  <Item Name="FTP.CHCB.Handicap.ToKITRY" Category="" ClassName="EnsLib.RecordMap.Operation.BatchFTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">KITRY</Setting>
    <Setting Target="Adapter" Name="FTPPort">22</Setting>
    <Setting Target="Adapter" Name="FTPServer">80.94.184.35</Setting>
    <Setting Target="Host" Name="Filename">HANDICAP_SL.CSV</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="StayConnected">60</Setting>
    <Setting Target="Host" Name="RecordMap">KITRY.Handicap</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Host" Name="SendSuperSession">0</Setting>
    <Setting Target="Adapter" Name="SFTPAppendMode">Client</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">0600</Setting>
    <Setting Target="Host" Name="DefaultBatchClass">KITRY.Handicap.BatchOut</Setting>
  </Item>
  <Item Name="FTP.CHCB.Accidents.FromAGIRH" Category="" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="@Kitry">
    <Setting Target="Adapter" Name="Credentials">MIPIH</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.17.0.119</Setting>
    <Setting Target="Adapter" Name="FilePath">MIPIH/BO/KITRY</Setting>
    <Setting Target="Adapter" Name="FileSpec">CHCB_Accid*.txt</Setting>
    <Setting Target="Host" Name="RecordMap">AGIRH.Accidents</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Router.Kitry</Setting>
    <Setting Target="Adapter" Name="ServerListStyle">MSDOS</Setting>
    <Setting Target="Adapter" Name="UseFileStream">0</Setting>
    <Setting Target="Host" Name="BatchClass">AGIRH.Accidents.BatchIn</Setting>
  </Item>
  <Item Name="FTP.CHCB.Accidents.ToKITRY" Category="" ClassName="EnsLib.RecordMap.Operation.BatchFTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">KITRY</Setting>
    <Setting Target="Adapter" Name="FTPPort">22</Setting>
    <Setting Target="Adapter" Name="FTPServer">80.94.184.35</Setting>
    <Setting Target="Host" Name="Filename">ACCIDENTS_SL.CSV</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="StayConnected">60</Setting>
    <Setting Target="Host" Name="RecordMap">KITRY.Accidents</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Host" Name="SendSuperSession">0</Setting>
    <Setting Target="Adapter" Name="SFTPAppendMode">Client</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">0600</Setting>
    <Setting Target="Host" Name="DefaultBatchClass">KITRY.Accidents.BatchOut</Setting>
  </Item>
  <Item Name="FTP.CHCB.Formations.FromAGIRH" Category="" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="@Kitry">
    <Setting Target="Adapter" Name="Credentials">MIPIH</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.17.0.119</Setting>
    <Setting Target="Adapter" Name="FilePath">MIPIH/BO/KITRY</Setting>
    <Setting Target="Adapter" Name="FileSpec">CHCB_Form*.txt</Setting>
    <Setting Target="Host" Name="RecordMap">AGIRH.Formations</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Router.Kitry</Setting>
    <Setting Target="Adapter" Name="ServerListStyle">MSDOS</Setting>
    <Setting Target="Adapter" Name="UseFileStream">0</Setting>
    <Setting Target="Host" Name="BatchClass">AGIRH.Formations.BatchIn</Setting>
  </Item>
  <Item Name="FTP.CHCB.Formations.ToKITRY" Category="" ClassName="EnsLib.RecordMap.Operation.BatchFTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">KITRY</Setting>
    <Setting Target="Adapter" Name="FTPPort">22</Setting>
    <Setting Target="Adapter" Name="FTPServer">80.94.184.35</Setting>
    <Setting Target="Host" Name="Filename">FORMATIONS_SL.CSV</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="StayConnected">60</Setting>
    <Setting Target="Host" Name="RecordMap">KITRY.Formations</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Host" Name="SendSuperSession">0</Setting>
    <Setting Target="Adapter" Name="SFTPAppendMode">Client</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">0600</Setting>
    <Setting Target="Host" Name="DefaultBatchClass">KITRY.Formations.BatchOut</Setting>
  </Item>
  <Item Name="FTP.CHCB.Enfants.FromAGIRH" Category="" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="@Kitry">
    <Setting Target="Adapter" Name="Credentials">MIPIH</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.17.0.119</Setting>
    <Setting Target="Adapter" Name="FilePath">MIPIH/BO/KITRY</Setting>
    <Setting Target="Adapter" Name="FileSpec">CHCB_Enf*.txt</Setting>
    <Setting Target="Host" Name="RecordMap">AGIRH.Enfants</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Router.Kitry</Setting>
    <Setting Target="Adapter" Name="ServerListStyle">MSDOS</Setting>
    <Setting Target="Adapter" Name="UseFileStream">0</Setting>
    <Setting Target="Host" Name="BatchClass">AGIRH.Enfants.BatchIn</Setting>
  </Item>
  <Item Name="FTP.CHCB.Enfants.ToKITRY" Category="" ClassName="EnsLib.RecordMap.Operation.BatchFTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">KITRY</Setting>
    <Setting Target="Adapter" Name="FTPPort">22</Setting>
    <Setting Target="Adapter" Name="FTPServer">80.94.184.35</Setting>
    <Setting Target="Host" Name="Filename">ENFANTS_SL.CSV</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="StayConnected">60</Setting>
    <Setting Target="Host" Name="RecordMap">KITRY.Enfants</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Host" Name="SendSuperSession">0</Setting>
    <Setting Target="Adapter" Name="SFTPAppendMode">Client</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">0600</Setting>
    <Setting Target="Host" Name="DefaultBatchClass">KITRY.Enfants.BatchOut</Setting>
  </Item>
  <Item Name="FTP.CHCB.Absences.FromAGIRH" Category="" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">MIPIH</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.17.0.119</Setting>
    <Setting Target="Adapter" Name="FilePath">MIPIH/BO/KITRY</Setting>
    <Setting Target="Adapter" Name="FileSpec">Abs*.txt</Setting>
    <Setting Target="Host" Name="RecordMap">AGIRH.Absences</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Router.Kitry</Setting>
    <Setting Target="Adapter" Name="ServerListStyle">MSDOS</Setting>
    <Setting Target="Adapter" Name="UseFileStream">0</Setting>
    <Setting Target="Host" Name="BatchClass">AGIRH.Absences.BatchIn</Setting>
  </Item>
  <Item Name="FTP.CHCB.Absences.ToKITRY" Category="" ClassName="EnsLib.RecordMap.Operation.BatchFTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">KITRY</Setting>
    <Setting Target="Adapter" Name="FTPPort">22</Setting>
    <Setting Target="Adapter" Name="FTPServer">80.94.184.35</Setting>
    <Setting Target="Host" Name="Filename">ABSENCES_SL.CSV</Setting>
    <Setting Target="Adapter" Name="Protocol">SFTP</Setting>
    <Setting Target="Adapter" Name="StayConnected">60</Setting>
    <Setting Target="Host" Name="RecordMap">KITRY.Absences</Setting>
    <Setting Target="Adapter" Name="Overwrite">0</Setting>
    <Setting Target="Host" Name="SendSuperSession">0</Setting>
    <Setting Target="Adapter" Name="SFTPAppendMode">Client</Setting>
    <Setting Target="Adapter" Name="Charset">Binary</Setting>
    <Setting Target="Adapter" Name="SFTPFileAccessMode">0600</Setting>
    <Setting Target="Host" Name="DefaultBatchClass">KITRY.Absences.BatchOut</Setting>
  </Item>
  <Item Name="GTT.CHCB.Nomenclature.FromMIPIH" Category="" ClassName="EnsLib.RecordMap.Service.BatchFTPService" PoolSize="1" Enabled="false" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">MIPIH</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.20.0.27</Setting>
    <Setting Target="Adapter" Name="FilePath">depot_CHRONOS/V2</Setting>
    <Setting Target="Adapter" Name="FileSpec">Nomen*.txt</Setting>
    <Setting Target="Host" Name="RecordMap">AGIRH.Nomenclature</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Router.GTT</Setting>
    <Setting Target="Adapter" Name="ServerListStyle">Unix</Setting>
    <Setting Target="Adapter" Name="UseFileStream">0</Setting>
    <Setting Target="Host" Name="BatchClass">AGIRH.Nomenclature.BatchIn</Setting>
    <Setting Target="Adapter" Name="StayConnected">0</Setting>
  </Item>
  <Item Name="GTT.CHCB.Nomenclature.ToCHRONOS" Category="" ClassName="EnsLib.RecordMap.Operation.BatchFTPOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Filename">TableRefKSC.csv</Setting>
    <Setting Target="Adapter" Name="FTPServer">172.17.0.120</Setting>
    <Setting Target="Adapter" Name="Credentials">MIPIH</Setting>
    <Setting Target="Host" Name="DefaultBatchClass">CHRONOS.Nomenclature.BatchOut</Setting>
    <Setting Target="Host" Name="RecordMap">CHRONOS.Nomenclature</Setting>
  </Item>
  <Item Name="Router.GTT" Category="" ClassName="EnsLib.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="BusinessRuleName">Router.GTTRoutingRule</Setting>
  </Item>
</Production>
}

}
