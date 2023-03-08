dofile(LockOn_Options.script_path.."MFCD/indicator/STAT/MFCD_STAT_definitions.lua")

-- NEXT label

Label_OSB1_symbol						= CreateElement "ceStringPoly"
Label_OSB1_symbol.name					= "Label_OSB1_symbol"
Label_OSB1_symbol.alignment				= "CenterTop"
Label_OSB1_symbol.value					= BRANCH_L
Label_OSB1_symbol.material				= font_MFCD
Label_OSB1_symbol.stringdefs			= txt_labels_font
Label_OSB1_symbol.UseBackground			= false
Label_OSB1_symbol.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB1_symbol, 1, -27)
Add(Label_OSB1_symbol)
use_mipfilter(Label_OSB1_symbol)

Label_OSB1							= CreateElement "ceStringPoly"
Label_OSB1.name						= "LABEL_OSB1"
Label_OSB1.material					= font_MFCD
Label_OSB1.UseBackground			= false
Label_OSB1.BackgroundMaterial		= MFCD_SOLID_BLACK
Label_OSB1.alignment				= "CenterTop"
Label_OSB1.value					= "NEXT"
Label_OSB1.stringdefs				= txt_labels_font
shift_button_pos(Label_OSB1, 1, 0)
Add(Label_OSB1)
use_mipfilter(Label_OSB1)

addOSB_Box(1, {Label_OSB1_symbol, Label_OSB1})
add_osb_static_hint(1, _("Go to STAT Page 2"))


local TblIdxBegin = LRU_ALL
local TblIdxEnd = LRU_1760_9

Page1_StaticBackgndColor = {}
Page1_StaticBackgndColor[LRU_ALL] = MFCD_SOLID_WHITE

--for i = LRU_CICU, LRU_CICU_ALM do
--	Page1_StaticBackgndColor[i] = MFCD_SOLID_GREEN
--end

for k, v in pairs(Page1_StaticBackgndColor) do
	AddTblBackgndRow("Page1_StaticBackgnd_"..LRU_names2[k], Page1_StaticBackgndColor[k], k,
		TblRowHeight, TblHalfWidth * 2, TblCenterX - TblHalfWidth, Tbl1stLinePosY, nil)

end

Page1_DynamBackgndParam = {}
--for i = LRU_1760_3, LRU_1760_9 do
for i = LRU_CICU, LRU_1760_9 do 
	Page1_DynamBackgndParam[i] = 
		{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State", i, STATUS_NA + STATUS_OFF + STATUS_INIT + STATUS_TEST}} },
		 {Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", i, STATUS_NC + STATUS_FAIL}} },
		 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", i, STATUS_VALID}} },
		 {Color = MFCD_SOLID_YELLOW, Ctrlr = {{"STAT_LRU_State", i, STATUS_DEGR}} }}
end

for k, v in pairs(Page1_DynamBackgndParam) do
	for k2, v2 in pairs(v) do
		AddTblBackgndRow("Page1_DynamBackgnd_"..LRU_names2[k].."_"..k2, v2.Color, k,
			TblRowHeight, TblHalfWidth * 2, TblCenterX - TblHalfWidth, Tbl1stLinePosY, v2.Ctrlr)

	end
end

addSTAT_Table(TblIdxEnd - TblIdxBegin + 1)

for i = LRU_ALL, LRU_CICU_ALM do
	AddTblText("FirstColumnText_" .. LRU_names2[i], LRU_names[i], i, 1, nil)
end

Page1_FirstColDynamTextParam = {}
for i = LRU_1760_3, LRU_1760_9 do
	Page1_FirstColDynamTextParam[i] = 
	{	{Value = LRU_names[i], Ctrlr = {{"STAT_LRU_State", i, STATUS_NA + STATUS_NC}} },
		{Value = "JDAM"..LRU_stations[i].."   ", Ctrlr = {{"STAT_LRU_State", i,
			STATUS_VALID + STATUS_OFF + STATUS_INIT + STATUS_FAIL + STATUS_TEST + STATUS_DEGR, LRU_TYPE_JDAM}} },
		{Value = "WCMD"..LRU_stations[i].."   ", Ctrlr = {{"STAT_LRU_State", i,
			STATUS_VALID + STATUS_OFF + STATUS_INIT + STATUS_FAIL + STATUS_TEST + STATUS_DEGR, LRU_TYPE_WCMD}}}
	}
end


for k, v in pairs(Page1_FirstColDynamTextParam) do
	for k2, v2 in pairs(v) do
		AddTblText("Page1_FirstColDynamText_"..LRU_names2[k].."_"..k2, v2.Value, k, 1, v2.Ctrlr)
	end
end

AddTblText("SecondColumnText_" .. LRU_names2[LRU_ALL], LRU_status[LRU_ALL], LRU_ALL, 2,nil)

Page1_SecondColDynamTextParam = {}
--for i = LRU_1760_3, LRU_1760_9 do
for i = LRU_CICU, LRU_1760_9 do
	Page1_SecondColDynamTextParam[i] =
	{	{Value = "OFF", 	Ctrlr = {{"STAT_LRU_State", i, STATUS_OFF}}   },
		{Value = "NC", 		Ctrlr = {{"STAT_LRU_State", i, STATUS_NC}} 	  },
		{Value = "INIT", 	Ctrlr = {{"STAT_LRU_State", i, STATUS_INIT}}  },
		{Value = "TEST", 	Ctrlr = {{"STAT_LRU_State", i, STATUS_TEST}}  },
		{Value = "VALID", 	Ctrlr = {{"STAT_LRU_State", i, STATUS_VALID}} },
		{Value = "FAIL", 	Ctrlr = {{"STAT_LRU_State", i, STATUS_FAIL}}  },
		{Value = "DEGR", 	Ctrlr = {{"STAT_LRU_State", i, STATUS_DEGR}}  },
		{Value = "-", 		Ctrlr = {{"STAT_LRU_State", i, STATUS_NA}} 	  }
	}
end

for k, v in pairs(Page1_SecondColDynamTextParam) do
	for k2, v2 in pairs(v) do
		AddTblText("Page1_SecondColDynamText_"..LRU_names2[k].."_"..k2, v2.Value, k, 2, v2.Ctrlr)
	end
end

AddTblText("ThirdColumnText_"..LRU_names2[LRU_ALL], LRU_test[LRU_ALL], LRU_ALL, 3, nil)

for i = LRU_CICU_WP, LRU_CICU_ALM do
	AddTblText("ThirdColumnText_"..LRU_names2[i], LRU_test[i], i, 3, nil)
end

Page1_ThirdColDynamTextParam = {}

Page1_ThirdColDynamTextParam[LRU_CICU] =
	{	{Value = "UN", 	 Ctrlr = {{"STAT_LRU_TEST_State", LRU_CICU, TEST_UN	}} },
		{Value = "IP", 	 Ctrlr = {{"STAT_LRU_TEST_State", LRU_CICU, TEST_IP	}} },
		{Value = "PASS", Ctrlr = {{"STAT_LRU_TEST_State", LRU_CICU, TEST_PASS}} }
	}
		 
for i = LRU_1760_3, LRU_1760_9 do
	Page1_ThirdColDynamTextParam[i] =
	{	{Value = "UN", 	Ctrlr = {{"STAT_LRU_TEST_State", i, TEST_UN		}} },
		{Value = "IP", 	Ctrlr = {{"STAT_LRU_TEST_State", i, TEST_IP		}} },
		{Value = "PASS",Ctrlr = {{"STAT_LRU_TEST_State", i, TEST_PASS	}} },
		{Value = "FAIL",Ctrlr = {{"STAT_LRU_TEST_State", i, TEST_FAIL	}} },
		{Value = "-", 	Ctrlr = {{"STAT_LRU_TEST_State", i, TEST_NA		}} }
	}
end

for k, v in pairs(Page1_ThirdColDynamTextParam) do
	for k2, v2 in pairs(v) do
		AddTblText("Page1_ThirdColDynamText_"..LRU_names2[k].."_"..k2, v2.Value, k, 3, v2.Ctrlr)
	end
end

LRU_details1stPage = {}
for i = TblIdxBegin, TblIdxEnd do
	if (LRU_details[i]) then
		LRU_details1stPage[i]				= CreateElement "ceStringPoly"
		LRU_details1stPage[i].alignment		= "LeftTop"
		LRU_details1stPage[i].value			= LRU_details[i]
		LRU_details1stPage[i].material		= font_MFCD
		LRU_details1stPage[i].stringdefs	= predefined_fonts[1]
		SetFaultLogPlacerAsParent(LRU_details1stPage[i])
		LRU_details1stPage[i].init_pos		= {0, MFL_StringOffset * 2, 0}
		LRU_details1stPage[i].controllers	= {{"STAT_Current_LRU", i}}
		Add(LRU_details1stPage[i])
		use_mipfilter(LRU_details1stPage[i])	
	end
end

LRU_1760_detailsOFP_XXXX = {}
LRU_1760_detailsOFP_OFF  = {}
LRU_1760_detailsOFP_Num  = {}
for i = LRU_1760_3, LRU_1760_9 do
	LRU_1760_detailsOFP_XXXX[i]					= CreateElement "ceStringPoly"
	LRU_1760_detailsOFP_XXXX[i].alignment		= "LeftTop"
	LRU_1760_detailsOFP_XXXX[i].value			= "1760-"..LRU_stations[i].." OFP ID: XXXX"
	LRU_1760_detailsOFP_XXXX[i].material		= font_MFCD
	LRU_1760_detailsOFP_XXXX[i].stringdefs		= predefined_fonts[1]
	SetFaultLogPlacerAsParent(LRU_1760_detailsOFP_XXXX[i])
	LRU_1760_detailsOFP_XXXX[i].init_pos		= {0, MFL_StringOffset * 2, 0}
	LRU_1760_detailsOFP_XXXX[i].controllers		= {{"STAT_Current_LRU", i},
												   {"STAT_LRU_State", i, STATUS_NA + STATUS_NC}}
	Add(LRU_1760_detailsOFP_XXXX[i])
	use_mipfilter(LRU_1760_detailsOFP_XXXX[i])


	LRU_1760_detailsOFP_OFF[i]					= CreateElement "ceStringPoly"
	LRU_1760_detailsOFP_OFF[i].alignment		= "LeftTop"
	LRU_1760_detailsOFP_OFF[i].value			= "JDAM"..LRU_stations[i].." OFP ID: XXXX"
	LRU_1760_detailsOFP_OFF[i].material			= font_MFCD
	LRU_1760_detailsOFP_OFF[i].stringdefs		= predefined_fonts[1]
	SetFaultLogPlacerAsParent(LRU_1760_detailsOFP_OFF[i])
	LRU_1760_detailsOFP_OFF[i].init_pos			= {0, MFL_StringOffset * 2, 0}
	LRU_1760_detailsOFP_OFF[i].controllers		= {{"STAT_Current_LRU", i},
												   {"STAT_LRU_State", i, STATUS_OFF}}
	Add(LRU_1760_detailsOFP_OFF[i])
	use_mipfilter(LRU_1760_detailsOFP_OFF[i])


	LRU_1760_detailsOFP_Num[i]					= CreateElement "ceStringPoly"
	LRU_1760_detailsOFP_Num[i].alignment		= "LeftTop"
	LRU_1760_detailsOFP_Num[i].value			= "JDAM"..LRU_stations[i].." OFP ID: OH6342"
	LRU_1760_detailsOFP_Num[i].material			= font_MFCD
	LRU_1760_detailsOFP_Num[i].stringdefs		= predefined_fonts[1]
	SetFaultLogPlacerAsParent(LRU_1760_detailsOFP_Num[i])
	LRU_1760_detailsOFP_Num[i].init_pos			= {0, MFL_StringOffset * 2, 0}
	LRU_1760_detailsOFP_Num[i].controllers		= {{"STAT_Current_LRU", i},
												   {"STAT_LRU_State", i, STATUS_VALID + STATUS_INIT + STATUS_FAIL + STATUS_TEST + STATUS_DEGR}}
	Add(LRU_1760_detailsOFP_Num[i])
	use_mipfilter(LRU_1760_detailsOFP_Num[i])
end
