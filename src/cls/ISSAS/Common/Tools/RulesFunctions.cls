Include Constantes

Class ISSAS.Common.Tools.RulesFunctions Extends Ens.Rule.FunctionSet
{

Parameter SrcVer = "$Id: //legacy/fr_products/CCOMTCC/MAIN/cls/ISSAS/Common/Tools/RulesFunctions.xml#4 $";

ClassMethod ISSASXcute(strINCommand As %String)
{
	/*
w ##class(ISSAS.Common.Tools.RulesFunctions).ISSASXcute("quit ##class(ISSAS.Common.DTL.Doctolib.DoctolibUtils).GetClinicomAssigningAuthority(""2.5"")")
	*/
	SET $ZTRAP = "ISSASXcuteError"
	XECUTE strINCommand
	QUIT $$$TRUE
ISSASXcuteError
	SET $ZTRAP = ""
	do BACK^%ETN
	QUIT $$$FALSE
}

/// Permet d'appeler une ClassMethod qui prends 1 argument et renvoie un résultat.
ClassMethod ISSASOBJClassMethodWithQuit1Arg(Classname As %String, Methodname As %String, Arg1) As %String
{
	/*
w ##class(ISSAS.Common.Tools.RulesFunctions).ISSASOBJClassMethodWithQuit1Arg("ISSAS.Common.DTL.Doctolib.DoctolibUtils", "GetClinicomAssigningAuthority", "2.5")
	*/
	SET $ZTRAP = "ISSASOBJClassMethodWithQuit1ArgError"
	quit $CLASSMETHOD(Classname, Methodname, Arg1)
ISSASOBJClassMethodWithQuit1ArgError
	SET $ZTRAP = ""
	do BACK^%ETN
	quit ""
}

/// Permet d'appeler une ClassMethod qui prends 2 arguments et renvoie un résultat.
ClassMethod ISSASOBJClassMethodWithQuit2Args(Classname As %String, Methodname As %String, Arg1, Arg2) As %String
{
	/*
w ##class(ISSAS.Common.Tools.RulesFunctions).ISSASOBJClassMethodWithQuit2Args("ISSAS.Common.DTL.Doctolib.DoctolibUtils", "GetPB227WebServiceApp", "Document.{PB2}", "TRAKCARE")
	*/
	SET $ZTRAP = "ISSASOBJClassMethodWithQuit1ArgError"
	quit $CLASSMETHOD(Classname, Methodname, Arg1, Arg2)
ISSASOBJClassMethodWithQuit1ArgError
	SET $ZTRAP = ""
	do BACK^%ETN
	quit ""
}

/// Permet d'appeler une ClassMethod qui prends 3 arguments et renvoie un résultat.
ClassMethod ISSASOBJClassMethodWithQuit3Args(Classname As %String, Methodname As %String, Arg1, Arg2, Arg3) As %String
{
	/*
w ##class(ISSAS.Common.Tools.RulesFunctions).ISSASOBJClassMethodWithQuit3Args("ISSAS.Common.Tools.ClassTools", "GetSettingFromItemName", "BPLDoctolib", "TraceTransformations", "")
	*/
	SET $ZTRAP = "ISSASOBJClassMethodWithQuit1ArgError"
	quit $CLASSMETHOD(Classname, Methodname, Arg1, Arg2, Arg3)
ISSASOBJClassMethodWithQuit1ArgError
	SET $ZTRAP = ""
	do BACK^%ETN
	quit ""
}

/// Permet d'appeler une ClassMethod qui prends 4 arguments et renvoie un résultat.
ClassMethod ISSASOBJClassMethodWithQuit4Args(Classname As %String, Methodname As %String, Arg1, Arg2, Arg3, Arg4) As %String
{
	/*
	*/
	SET $ZTRAP = "ISSASOBJClassMethodWithQuit4ArgError"
	quit $CLASSMETHOD(Classname, Methodname, Arg1, Arg2, Arg3, Arg4)
ISSASOBJClassMethodWithQuit4ArgError
	SET $ZTRAP = ""
	do BACK^%ETN
	quit ""
}

/// Calcul age in Year from Birth Date in YYYYMMDD
ClassMethod CalcAgeFromBirthDate(strINDateBirth As %String = "") As %String [ Final ]
{
	// write ##class(ISSAS.Common.Tools.RulesFunctions).CalcAgeFromBirthDate("19681019")
	SET $ZTRAP = "CalcAgeFromBirthDateError"
	if ($get(strINDateBirth)="") { quit "" }
	set (XBirth,XToday,AgeDay,AgeMth,AgeYear,CurrMth,CurrYear,AgeYr)=""
	set IBirth=$zdateh($get(strINDateBirth),8)
	set IToday=+$h
	if IBirth>2980000 set IBirth=""
	if IBirth<0 set IBirth=""
	if IToday<0 set IToday=""
	quit:'$get(IBirth) ""
	set XBirth=$zdate(IBirth,1)
	set XToday=$zdate(IToday,1)
	set AgeMth=XToday-XBirth
	set AgeDay=$piece(XToday,"/",2)-$piece(XBirth,"/",2)
	set CurrYear=$piece(XToday,"/",3) 
	if (CurrYear<100) { set CurrYear=CurrYear+1900 }
	set BirthYear=$piece(XBirth,"/",3) 
	if (BirthYear<100) { set BirthYear=BirthYear+1900 }
	set AgeYear=CurrYear-BirthYear
	if (AgeDay<0) {
		set AgeMth=AgeMth-1
		set AgeDay=AgeDay+$piece("31,31,28,31,30,31,30,31,31,30,31,30,31",",",+XToday)
		if (+XToday=2) {
			if (((CurrYear#4)=0)&&(((CurrYear#100)'=0)||((CurrYear#400)=0))) {
				set AgeDay=AgeDay+1
			}
		}
	}
	if (AgeMth<0) {
		set AgeMth=AgeMth+12
		set AgeYear=AgeYear-1
	}
	quit AgeYear
CalcAgeFromBirthDateError
	SET $ZTRAP = ""
	do BACK^%ETN
	quit ""
}

}
