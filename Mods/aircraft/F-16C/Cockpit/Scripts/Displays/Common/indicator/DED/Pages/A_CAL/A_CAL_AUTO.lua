addText("INS_SelectedSteerpoint",	"",		{20, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("INS_STPT_IncDecSymbol",	"a",	{23, 0})

addText("AUTO_ACAL",		"AUTO ACAL",			{1, 0})
	addText("ACAL_AUTO_Sensors", "",				{12,0}, {"DED_ACAL_AUTO_SensorValid", 1}, nil, {{"DED_ACAL_AUTO_CurrentSensors"}})
	addAsteriscs("Asterisks_AUTO",					{11, 0}, 4, nil, nil)
	
addText("NAV_FILTER_label",				"NAV FILTER",{2, 1})
	addText("NAV_FILTER_mode", 			"AUTO", 	{14,1}, nil , nil, {{"DED_ACAL_AUTO_NavFilter"}}, {"", "AUTO", "INS"})
	
addText("GPS_ACCURACY_label",			"GPS ACCUR",{3, 2})
	addText("GPS_ACCURACY_value",		"",			{14, 2}, nil, nil, {{"DED_ACAL_AUTO_GPS_Accur"}}, {"", "HIGH", "MED", "LOW", "FAIL"})
	
addText("DTS_STATUS_label",				"DTS",		{9, 3})
	addText("DTS_STATUS_value",			"",			{14, 3}, nil, nil, {{"DED_ACAL_AUTO_DTS_Status"}}, {"", "ACQ", "TRK"})
	
addText("DTS_ACCURACY_HPU_label",		"H:",		{21, 3})
	addText("DTS_ACCURACY_HPU_value",	"",			{23, 3}, nil, nil, {{"DED_ACAL_AUTO_DTS_ACCURACY_HPU"}}, {"", "L", "M", "H"})
addText("DTS_ACCURACY_VPU_label",		"V:",		{21, 4})
	addText("DTS_ACCURACY_VPU_value",	"",			{23, 4}, nil, nil, {{"DED_ACAL_AUTO_DTS_ACCURACY_VPU"}}, {"", "L", "M", "H"})