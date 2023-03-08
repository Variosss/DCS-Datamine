dofile(LockOn_Options.script_path.."Displays/Common/indicator/DED/Pages/DLNK/DLNK_Common.lua")

addText("INS_SelectedSteerpoint",	"",		{20, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("INS_STPT_IncDecSymbol",	"a",	{23, 0})

addText("LINK16 STN lbl",		"LINK16  STN",			{5, 0})

for i = 1,8,1 do

	local col = 0
	di = 0
	local asteriscs_stn_pos = ASTERISKS_POS.STN1 - 1 + 2*i-1
	local asteriscs_stn_tdoa_pos = ASTERISKS_POS.STN1_TDOA - 1 + 2*i-1
	
	if i > 4 then
		col = 10
		di = 4
	end
	
	addText("STN id lbl_"..i,			""..i,				{col, i - di})
	addText("STN TDOA value_"..i,		"",					{col + 2, i- di},nil,nil,{{"DED_DLNK_LINK16_STN_TDOA", i}})-- {"DED_DLNK_DataEntry_Inv", 0}, nil, {{"DED_DLNK_LINK16_STN", ASTERISKS_POS.STN1_TDOA}})
	addText("STN value_"..i,		"XX000",				{col + 4, i- di}, {"DED_DLNK_DataEntry_Inv", asteriscs_stn_pos}, nil, {{"DED_DLNK_LINK16_STN", i}})
	addAsteriscs("Asterisks on STN TDOA_"..i,				{col + 1, i- di}, 1, nil, {{"DED_DLNK_AsterisksPos", asteriscs_stn_tdoa_pos}})
	addAsteriscs("Asterisks on STN_"..i,					{col + 3, i- di}, 5, nil, {{"DED_DLNK_AsterisksPos", asteriscs_stn_pos}})
	
end

addText("OWN lbl",						"OWN",					{20, 1})
addText("NUM lbl",						"#",					{20, 2})
addText("Own num value",				"1",					{22, 2}, {"DED_DLNK_DataEntry_Inv", ASTERISKS_POS.OWN_ID}, nil, {{"DED_DLNK_LINK16_STN_OwnWingmanId"}})
addAsteriscs("Asterisks on Own",								{21, 2}, 1, nil, {{"DED_DLNK_AsterisksPos", ASTERISKS_POS.OWN_ID}})

addText("P3 lbl",						"P3>",					{21, 4})
