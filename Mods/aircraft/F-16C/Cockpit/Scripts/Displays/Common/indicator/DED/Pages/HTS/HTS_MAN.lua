addText("INS_SelectedSteerpoint",	"",		{20, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("INS_STPT_IncDecSymbol",	"a",	{23, 0})

local THREAT_NUMS = 
{
	NONE = 0;
	T1 = 1;
	T2 = 2;
	T3 = 3;
	T4 = 4;
	T5 = 5;
	T6 = 6;
	T7 = 7;
	T8 = 8;
}

addLocalPlaceholder("HTS_DED_ROOT", nil, {{"DED_HTS_isShow"}})

addText("HTS", "HTS MAN", {8,0}, nil, "HTS_DED_ROOT")

addText("T1", "1", {1,1}, nil, "HTS_DED_ROOT")
	addText("T1_code", "XXXX", {3,1},{"DED_HTS_DataEntry_Inv", THREAT_NUMS.T1},"HTS_DED_ROOT", {{"DED_HTS_ThreatCode", 0}})
	addAsteriscs("Asterisks_T1",{2, 1}, 4, "HTS_DED_ROOT",{{"DED_HTS_AsterisksPos", THREAT_NUMS.T1}})		
addText("T2", "2", {1,2}, nil, "HTS_DED_ROOT")
	addText("T2_code", "XXXX", {3,2},{"DED_HTS_DataEntry_Inv", THREAT_NUMS.T2},"HTS_DED_ROOT", {{"DED_HTS_ThreatCode", 1}})
	addAsteriscs("Asterisks_T2",{2, 2}, 4, "HTS_DED_ROOT",{{"DED_HTS_AsterisksPos", THREAT_NUMS.T2}})	
addText("T3", "3", {1,3}, nil, "HTS_DED_ROOT")
	addText("T3_code", "XXXX", {3,3},{"DED_HTS_DataEntry_Inv", THREAT_NUMS.T3},"HTS_DED_ROOT", {{"DED_HTS_ThreatCode", 2}})
	addAsteriscs("Asterisks_T3",{2, 3}, 4, "HTS_DED_ROOT",{{"DED_HTS_AsterisksPos", THREAT_NUMS.T3}})	
 addText("T4", "4", {1,4}, nil, "HTS_DED_ROOT")
	addText("T4_code", "XXXX", {3,4},{"DED_HTS_DataEntry_Inv", THREAT_NUMS.T4},"HTS_DED_ROOT", {{"DED_HTS_ThreatCode", 3}})
	addAsteriscs("Asterisks_T4",{2, 4}, 4, "HTS_DED_ROOT",{{"DED_HTS_AsterisksPos", THREAT_NUMS.T4}})	
 addText("T5", "5", {10,1}, nil, "HTS_DED_ROOT")
	addText("T5_code", "XXXX", {12,1},{"DED_HTS_DataEntry_Inv", THREAT_NUMS.T5},"HTS_DED_ROOT", {{"DED_HTS_ThreatCode", 4}})
	addAsteriscs("Asterisks_T5",{11, 1}, 4, "HTS_DED_ROOT",{{"DED_HTS_AsterisksPos", THREAT_NUMS.T5}})	
 addText("T6", "6", {10,2}, nil, "HTS_DED_ROOT")
	addText("T6_code", "XXXX", {12,2},{"DED_HTS_DataEntry_Inv", THREAT_NUMS.T6},"HTS_DED_ROOT", {{"DED_HTS_ThreatCode", 5}})
	addAsteriscs("Asterisks_T6",{11, 2}, 4, "HTS_DED_ROOT",{{"DED_HTS_AsterisksPos", THREAT_NUMS.T6}})	
 addText("T7", "7", {10,3}, nil, "HTS_DED_ROOT")
	addText("T7_code", "XXXX", {12,3},{"DED_HTS_DataEntry_Inv", THREAT_NUMS.T7},"HTS_DED_ROOT", {{"DED_HTS_ThreatCode", 6}})
	addAsteriscs("Asterisks_T7",{11, 3}, 4, "HTS_DED_ROOT",{{"DED_HTS_AsterisksPos", THREAT_NUMS.T7}})	
 addText("T8", "8", {10,4}, nil, "HTS_DED_ROOT")
	addText("T8_code", "XXXX", {12,4},{"DED_HTS_DataEntry_Inv", THREAT_NUMS.T8},"HTS_DED_ROOT", {{"DED_HTS_ThreatCode", 7}})
	addAsteriscs("Asterisks_T8",{11, 4}, 4, "HTS_DED_ROOT",{{"DED_HTS_AsterisksPos", THREAT_NUMS.T8}})	
