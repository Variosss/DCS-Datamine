PFL_Subsystem_Formats =
{
	"",
	--
	"AA",
	"ACMI",
	"AMUX",
	"ASPJ",
	"BRK",
	"BLKR",
	"BMUX",
	"CADC",
	"CMDS",
	"CMUX",
	--"DLNK",	-- removed, use "LK16" or "MIDS"
	"DMUX",
	"DTE",
	"ENG",
	"EPOD",
	"FCC",
	"FCR",
	"FDR",
	"FLCS",
	"FMS",
	"GPS",
	"HARM",
	"HUD",
	"IFF",
	"INS",
	"ISA",
	"MFDS",
	"MSL",
	"NVP",
	"RALT",
	"RPT",
	"RWR",
	"SMS",
	"STBY",
	"SWIM",
	"TCN",
	"TF",
	"TGP",
	"UFC",
	"VHF",
	--
	"MMC",
	--
	"HMCS",
	"JSMX",
	"JMX",
	"JM3",
	"JM7",
	"LK16",
	"MIDS",
	"IPF",
	"MCL1",
	"MCL2",
};

PFL_Function_Formats =
{
	"",
	--
	"A/B",
	"A/I",
	"A/P",
	"AAGR",
	"ABT",
	"ADC",
	"ADED",
	"AE",
	"AGR",
	"AIR",
	"ALL",
	"ALMN",
	"ANT",
	"AOA",
	"ARC",
	"ATF",
	"ATTD",
	"AUTO",
	"AVTR",
	"BATT",
	"BCN",
	"BIT",
	"BUS",
	"CCM",
	"COM1",
	"COMM",
	"DED",
	"DFAL",
	"DFAR",
	"DFFL",
	"DFFR",
	"DISP",
	"DLNK",
	"DSPN",
	"DUAL",
	"ECM",
	"EM",
	"EMER",
	"EMS",
	"FCR",
	"FLIR",
	"FLUP",
	"FRQ1",
	"FRQ2",
	"FRQ3",
	"FRQ4",
	"GAIN",
	"HI",
	"HNDF",
	"HOT",
	"HYB",
	"IFF",
	"I M1",
	"I M2",
	"I M3",
	"I M4",
	"INTG",
	"INV",
	"LAFT",
	"LASR",
	"LCH",
	"LEF",
	"LF",
	"LFWD",
	"LHT",
	"LJ/R",
	"LO",
	"LSYLM",
	"LSYM",
	"LUBE",
	"LVID",
	"M 1",
	"M 2",
	"M 3",
	"M 4",
	"M C",
	"MACH",
	"MAN",
	"MAP",
	"NVP",
	"PFL",
	"PFLD",
	"PRES",
	"PWR",
	"RAFT",
	"RALT",
	"RCH",
	"RCVR",
	"RET",
	"RF",
	"RFWD",
	"RHT",
	"RJ/R",
	"RNG",
	"RSU",
	"RSYM",
	"RUD",
	"RVID",
	"RWR",
	"SCP",
	"SEMI",
	"SLAV",
	"SLNT",
	"SNGL",
	"STA1",
	"STA2",
	"STA3",
	"STA4",
	"STA5",
	"STA6",
	"STA7",
	"STA8",
	"STA9",
	"SW",
	"SYM",
	"TCN",
	"TFR",
	"THST",
	"TRK",
	"VEL",
	"VHF",
	"VID",
	"X M1",
	"X M2",
	"X M3",
	"X M4",
	"XMC",
	"XMTR",
	"XPDR",
	"ZERO",
	--
	"HUD",
	"MBAT",
	"DCDC",
	"DSPL",
	"DSCR",
	--
	"AOS",
	"QDC",
	"TEMP",
	"LOAD",
	"DLAY",
	"CPU",
	"GPS",
	"CNTL",
	"IMU",
	"TM",
	"FUZE",
	"FTS",
	"BIA",
	"ENG",
	"GUID",
	"10MN",
	"1MIN",
	"KEYS",
	"TIME",
	"MULT",
	"AA ST 1",
	"AA ST 2",
	"NUC",
	"EJ",
};

PFL_Severity_Formats =
{
	"",
	--
	"CNTL",
	"DEGR",
	"FAIL",
	"INTF",
	"LITE",
	"LOCK",
	"LOW",
	"OFF",
	"RST",
	"TEMP",
	"WARN",
	--
	"REQD",
	"NTR",
	"BLND",
	"NORM",
};


-- ---------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------

-- status line
addText("FLCS Label",	"FLCS",	{2, 0}, nil, nil, {{"PFLD_StatusFLCS"}})
addText("ENG Label",	"ENG",	{9, 0}, nil, nil, {{"PFLD_StatusENG"}})
addText("AV Label",		"AV",	{18, 0}, nil, nil, {{"PFLD_StatusAV"}})

local function AddFault(num)
	local line = 1 + num
	local placeholder_name = "Fault "..num.." Placeholder"
	addSimplePlaceholder(placeholder_name, nil, {{"PFLD_FaultShow", num}});
	addText("Fault "..num.." Warning Indicator Lhs",	">", {2, line}, true, placeholder_name, {{"PFLD_WarningIndicator", num}})
	addText("Fault "..num.." Warning Indicator Rhs",	"<", {19, line}, true, placeholder_name, {{"PFLD_WarningIndicator", num}})
	addText("Fault "..num.." Subsystem",				"XXXX", {3, line}, nil, placeholder_name, {{"PFLD_Subsystem", num}}, PFL_Subsystem_Formats)
	addText("Fault "..num.." Function",					"XXXX", {9, line}, nil, placeholder_name, {{"PFLD_Function", num}}, PFL_Function_Formats)
	addText("Fault "..num.." Severity",					"XXXX", {15, line}, nil, placeholder_name, {{"PFLD_Severity", num}}, PFL_Severity_Formats)
end

AddFault(1)
AddFault(2)
AddFault(3)

local MoreFaultsPlaceholder_name = "More Faults Placeholder"
addSimplePlaceholder(MoreFaultsPlaceholder_name, nil, {{"PFLD_MoreFaults_Show"}})
addText("More Fault Indicator Lhs",		"d",	{1, 4}, nil, MoreFaultsPlaceholder_name)
addText("More Fault Indicator Rhs",		"d",	{20, 4}, nil, MoreFaultsPlaceholder_name)

local PageIndexPlaceholder_name = "Page Index Placeholder"
addSimplePlaceholder(PageIndexPlaceholder_name, nil, {{"PFLD_PageIndex_Show"}})
addText("Page Label",					"P",	{20, 3}, nil, PageIndexPlaceholder_name)
addText("Page Index",					"XX",	{21, 3}, nil, PageIndexPlaceholder_name, {{"PFLD_MoreFaults_PageIndex"}})