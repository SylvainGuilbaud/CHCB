Class ISSAS.Common.DTL.TCtoMONDOCTEUR.SIUtoSIU Extends Ens.DataTransformDTL [ DependsOn = EnsLib.HL7.Message ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='EnsLib.HL7.Message' sourceDocType='2.4:SIU_S12' targetDocType='2.3:SIU_S12' create='new' language='objectscript' >

<!-- segment MSH -->
<assign value='source.{MSH}' property='target.{MSH}' action='set' />
<assign value='"2.3"' property='target.{MSH:VersionID}' action='set' />
<assign value='"UTF-8"' property='target.{MSH:CharacterSet(1)}' action='set' />

<!-- segment SCH -->
<assign value='source.{SCH}' property='target.{SCH}' action='set' />
<assign value='source.{NTE()}' property='target.{NTE()}' action='set' />

<!-- segment PID -->
<assign value='source.{PIDgrp(1).PID}' property='target.{PIDgrp(1).PID}' action='set' />
<assign value='""' property='target.{PIDgrp(1).PID:PhoneNumberHome()}' action='set' />
<code>
<![CDATA[ Set oTEL=0 ]]>
</code>
<foreach key="kPH" property="source.{PIDgrp(1).PID:PhoneNumberHome()}">
<if condition='",CP,Internet" [ source.{PIDgrp(1).PID:PhoneNumberHome(kPH).telecommunicationequipmentty}'>
<true>
<assign value='source.{PIDgrp(1).PID:PhoneNumberHome(kPH)}' property='target.{PIDgrp(1).PID:PhoneNumberHome($I(oTEL))}' action='set' />
</true>
</if>
</foreach>

<!-- segment PV1 -->
<assign value='source.{PIDgrp().PV1}' property='target.{PIDgrp().PV1}' action='set' />

<!-- segment RGS -->
<assign value='source.{RGSgrp().RGS}' property='target.{RGSgrp().RGS}' action='set' />

<!-- segment AIS -->
<assign value='source.{RGSgrp().AISgrp()}' property='target.{RGSgrp().AISgrp()}' action='set' />

<!-- segment AIG -->
<assign value='source.{RGSgrp().AIGgrp()}' property='target.{RGSgrp().AIGgrp()}' action='set' />

<!-- segment AIL -->
<assign value='source.{RGSgrp().AILgrp()}' property='target.{RGSgrp().AILgrp()}' action='set' />

<!-- segment AIP -->
<assign value='source.{RGSgrp().AIPgrp()}' property='target.{RGSgrp().AIPgrp()}' action='set' />
</transform>
}

}
