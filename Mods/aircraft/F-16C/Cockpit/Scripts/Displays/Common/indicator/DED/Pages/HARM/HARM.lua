local THREAT_NUMS = 
{
	NONE = 0;
	T1 = 1;
	T2 = 2;
	T3 = 3;
	T4 = 4;
	T5 = 5;
}

addLocalPlaceholder("HARM_DED_ROOT", nil, {{"DED_HARM_isShow"}})

addText("HARM", "HARM", {1,0}, nil, "HARM_DED_ROOT")
addText("TblNum", "X", {6,0},nil,"HARM_DED_ROOT", {{"DED_HARM_ThreatTableNum"}})
addText("Angles", "a", {10,0}, nil, "HARM_DED_ROOT")

addText("T1", "T1", {14,0}, nil, "HARM_DED_ROOT")
	addText("T1_code", "XXX", {18,0},{"DED_HARM_DataEntry_Inv", THREAT_NUMS.T1},"HARM_DED_ROOT", {{"DED_HARM_ThreatCode", 0}})
	addAsteriscs("Asterisks_T1",							{17, 0}, 3, "HARM_DED_ROOT",{{"DED_HARM_AsterisksPos", THREAT_NUMS.T1}})		
addText("T2", "T2", {14,1}, nil, "HARM_DED_ROOT")
	addText("T2_code", "XXX", {18,1},{"DED_HARM_DataEntry_Inv", THREAT_NUMS.T2},"HARM_DED_ROOT", {{"DED_HARM_ThreatCode", 1}})
	addAsteriscs("Asterisks_T2",							{17, 1}, 3, "HARM_DED_ROOT",{{"DED_HARM_AsterisksPos", THREAT_NUMS.T2}})	
addText("T3", "T3", {14,2}, nil, "HARM_DED_ROOT")
	addText("T3_code", "XXX", {18,2},{"DED_HARM_DataEntry_Inv", THREAT_NUMS.T3},"HARM_DED_ROOT", {{"DED_HARM_ThreatCode", 2}})
	addAsteriscs("Asterisks_T3",							{17, 2}, 3, "HARM_DED_ROOT",{{"DED_HARM_AsterisksPos", THREAT_NUMS.T3}})	
addText("T4", "T4", {14,3}, nil, "HARM_DED_ROOT")
	addText("T4_code", "XXX", {18,3},{"DED_HARM_DataEntry_Inv", THREAT_NUMS.T4},"HARM_DED_ROOT", {{"DED_HARM_ThreatCode", 3}})
	addAsteriscs("Asterisks_T4",							{17, 3}, 3, "HARM_DED_ROOT",{{"DED_HARM_AsterisksPos", THREAT_NUMS.T4}})	
addText("T5", "T5", {14,4}, nil, "HARM_DED_ROOT")
	addText("T5_code", "XXX", {18,4},{"DED_HARM_DataEntry_Inv", THREAT_NUMS.T5},"HARM_DED_ROOT", {{"DED_HARM_ThreatCode", 4}})
	addAsteriscs("Asterisks_T5",							{17, 4}, 3, "HARM_DED_ROOT",{{"DED_HARM_AsterisksPos", THREAT_NUMS.T5}})	
	



