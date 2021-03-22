Include Ensemble

Class ISSAS.Common.Adapter.Default.File.OutboundAdapter Extends EnsLib.File.OutboundAdapter [ ClassType = "", Inheritance = right, ProcedureBlock ]
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/REL/cls/ISSAS/Common/Adapter/Default/File/OutboundAdapter.xml#3 $";

/// Character encoding scheme used for translating output to files. For binary output, use 'Binary'.
/// Other choices include: <br/>
///  Native - the default character encoding of the installed locale of the Ensemble server <br/>
///  latin1 - the ISO Latin1 8-bit encoding <br/>
///  ISO-8859-1 - the ISO Latin1 8-bit encoding <br/>
///  UTF-8 - the Unicode 8-bit encoding <br/>
///  Unicode - the Unicode 16-bit encoding  (Little-Endian) <br/>
///  UnicodeBig - the Unicode 16-bit encoding (Big-Endian) <br/>
///  @&lt;ttable&gt; - &lt;ttable&gt; means a raw InterSystems character translation table name. A prefix of '@' means to use the named table.
Property Charset As %String [ InitialExpression = "ISO-8859-1" ];

/// Number of seconds to wait on each attempt to open the output file.
Property OpenTimeout As %Numeric(MINVAL = 0) [ InitialExpression = 10 ];

/// Key to get all settings to connect to a network resource (shared directory)
Property ConfigKeySharedFilePath As %String;

Parameter SETTINGS = "ConfigKeySharedFilePath";

Method OnInit() As %Status
{
	#Dim tSC As %Status = $$$OK

	// Don't need to check ^ISSAS.Config() global for shared resource => default 'OnInit()' method
	If ($L(..ConfigKeySharedFilePath) <= 0) { Quit ##super() }

	// Connect local device to network resource
	Set tSC = ..ConnectLocalDeviceToNetworkResource()
	If ($$$ISERR(tSC)) { Quit tSC }

	// Call base class process
	Quit ##super()
}

Method OnBeforeProcessExecute() As %Status
{
	#Dim tSC As %Status = $$$OK

	// Test directory access with shared network resource (need to reconnect after a server reboot for example)
	Set tSC = ..ConnectLocalDeviceToNetworkResource()
	If ($$$ISERR(tSC)) { Quit tSC }

	Quit tSC
}

Method ConnectLocalDeviceToNetworkResource() As %Status
{
	#Dim tSC As %Status = $$$OK

	// Don't need to check ^ISSAS.Config() global for shared resource
	If ($L(..ConfigKeySharedFilePath) <= 0) { Quit $$$OK }

	// Test directory access with shared network resource
	If (($L(..FilePath) > 0) && (##class(%Library.File).DirectoryExists(..FilePath) = 1)) { Quit $$$OK }

	// Connect local device to network resource
	$$$TRACE("Try to connect local device to network resource using '"_..ConfigKeySharedFilePath_"' key")
	Quit ##class(ISSAS.Common.Tools.ClassFile).ConnectLocalDeviceToNetworkResource(..ConfigKeySharedFilePath, 1)
}

}
