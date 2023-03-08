dofile(LockOn_Options.script_path.."MFCD/indicator/STAT/MFCD_STAT_definitions.lua")

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
Label_OSB1.value					= "PREV"
Label_OSB1.stringdefs				= txt_labels_font
shift_button_pos(Label_OSB1, 1, 0)
Add(Label_OSB1)
use_mipfilter(Label_OSB1)

addOSB_Box(1, {Label_OSB1_symbol, Label_OSB1})
add_osb_static_hint(1, _("Return to STAT Page 1"))

local PAGE2_LRU_NUM_OFFSET = LRU_1760_9

local function getTblIdx(In)
	return In - PAGE2_LRU_NUM_OFFSET
end

local TblIdxBegin = getTblIdx(LRU_TGP)
local TblIdxEnd = getTblIdx(LRU_EPLRS)

--[[for i = getTblIdx(LRU_LTMFCD), getTblIdx(LRU_HOTAS_AHCP) do
	AddTblBackgndRow("Page2_StaticBackgnd_"..LRU_names2[i], MFCD_SOLID_GREEN, i, nil)
end]]

Page2_DynamBackgndParam = {}
Page2_DynamBackgndParam[getTblIdx(LRU_TGP)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State", LRU_TGP, STATUS_OFF + STATUS_INIT}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", LRU_TGP, STATUS_VALID}} }}
Page2_DynamBackgndParam[getTblIdx(LRU_LTMFCD)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State", LRU_LTMFCD, STATUS_OFF + STATUS_INIT + STATUS_TEST}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", LRU_LTMFCD, STATUS_VALID}} },
	{Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", LRU_LTMFCD, STATUS_NC + STATUS_FAIL}} },}
Page2_DynamBackgndParam[getTblIdx(LRU_RTMFCD)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State", LRU_RTMFCD, STATUS_OFF + STATUS_INIT + STATUS_TEST}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", LRU_RTMFCD, STATUS_VALID}} },
	{Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", LRU_RTMFCD, STATUS_NC + STATUS_FAIL}} },}
Page2_DynamBackgndParam[getTblIdx(LRU_HOTAS)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS, STATUS_OFF + STATUS_INIT + STATUS_TEST}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS, STATUS_VALID}} },
	{Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS, STATUS_NC + STATUS_FAIL}} },}
Page2_DynamBackgndParam[getTblIdx(LRU_HOTAS_STICK)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_STICK, STATUS_OFF + STATUS_INIT + STATUS_TEST}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_STICK, STATUS_VALID}} },
	{Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_STICK, STATUS_NC + STATUS_FAIL}} },}
Page2_DynamBackgndParam[getTblIdx(LRU_HOTAS_THRTL)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_THRTL, STATUS_OFF + STATUS_INIT + STATUS_TEST}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_THRTL, STATUS_VALID}} },
	{Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_THRTL, STATUS_NC + STATUS_FAIL}} },}
Page2_DynamBackgndParam[getTblIdx(LRU_HOTAS_AHCP)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_AHCP, STATUS_OFF + STATUS_INIT + STATUS_TEST}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_AHCP, STATUS_VALID}} },
	{Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_AHCP, STATUS_NC + STATUS_FAIL}} },}	
Page2_DynamBackgndParam[getTblIdx(LRU_EGI)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State", LRU_EGI, STATUS_OFF + STATUS_INIT}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", LRU_EGI, STATUS_VALID}} },
	{Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", LRU_EGI, STATUS_NC + STATUS_FAIL}} },
	 {Color = MFCD_SOLID_YELLOW, Ctrlr = {{"STAT_LRU_State", LRU_EGI, STATUS_DEGR}} }}
Page2_DynamBackgndParam[getTblIdx(LRU_IFFCC)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State", LRU_IFFCC, STATUS_OFF + STATUS_INIT}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", LRU_IFFCC, STATUS_VALID}} },
	{Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", LRU_IFFCC, STATUS_FAIL}} }}
Page2_DynamBackgndParam[getTblIdx(LRU_CDU)] = 
	{{Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", LRU_CDU, STATUS_NC}} },
	 {Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State", LRU_CDU, STATUS_INIT}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", LRU_CDU, STATUS_VALID}} },
	{Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", LRU_CDU, STATUS_FAIL}} }}
Page2_DynamBackgndParam[getTblIdx(LRU_EPLRS)] = 
	{{Color = MFCD_SOLID_RED, Ctrlr = {{"STAT_LRU_State", LRU_EPLRS, STATUS_NC + STATUS_FAIL}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State", LRU_EPLRS, STATUS_VALID}} }}

for k, v in pairs(Page2_DynamBackgndParam) do
	for k2, v2 in pairs(v) do
		AddTblBackgndRow("Page2_DynamBackgnd_"..LRU_names2[k].."_"..k2, v2.Color, k,
		TblRowHeight, TblHalfWidth * 2, TblCenterX - TblHalfWidth, Tbl1stLinePosY, v2.Ctrlr)
	end
end

addSTAT_Table(TblIdxEnd - TblIdxBegin + 1)

for i = TblIdxBegin, TblIdxEnd do
	AddTblText("FirstColumnText_" .. LRU_names2[i + PAGE2_LRU_NUM_OFFSET],
				LRU_names[i + PAGE2_LRU_NUM_OFFSET], i, 1, nil)
end

--[[for i = getTblIdx(LRU_LTMFCD), getTblIdx(LRU_HOTAS_AHCP) do
	AddTblText("SecondColumnText_" .. LRU_names2[i + PAGE2_LRU_NUM_OFFSET],
				LRU_status[i + PAGE2_LRU_NUM_OFFSET], i, 2, nil)
end]]

Page2_SecondColDynamTextParam = {}
Page2_SecondColDynamTextParam[getTblIdx(LRU_TGP)] =
	{{Value = "OFF", Ctrlr = {{"STAT_LRU_State", LRU_TGP, STATUS_OFF}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State", LRU_TGP, STATUS_VALID}} },
	 {Value = "INIT", Ctrlr = {{"STAT_LRU_State", LRU_TGP, STATUS_INIT}} }}
Page2_SecondColDynamTextParam[getTblIdx(LRU_LTMFCD)] =
	{{Value = "OFF", Ctrlr = {{"STAT_LRU_State", LRU_LTMFCD, STATUS_OFF}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State", LRU_LTMFCD, STATUS_VALID}} },
	 {Value = "INIT", Ctrlr = {{"STAT_LRU_State", LRU_LTMFCD, STATUS_INIT}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_State", LRU_LTMFCD, STATUS_FAIL}} },
	 {Value = "TEST", Ctrlr = {{"STAT_LRU_State", LRU_LTMFCD, STATUS_TEST}} },
	 {Value = "NC", Ctrlr = {{"STAT_LRU_State", LRU_LTMFCD, STATUS_NC}} }}
Page2_SecondColDynamTextParam[getTblIdx(LRU_RTMFCD)] =
	{{Value = "OFF", Ctrlr = {{"STAT_LRU_State", LRU_RTMFCD, STATUS_OFF}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State", LRU_RTMFCD, STATUS_VALID}} },
	 {Value = "INIT", Ctrlr = {{"STAT_LRU_State", LRU_RTMFCD, STATUS_INIT}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_State", LRU_RTMFCD, STATUS_FAIL}} },
	 {Value = "TEST", Ctrlr = {{"STAT_LRU_State", LRU_RTMFCD, STATUS_TEST}} },
	 {Value = "NC", Ctrlr = {{"STAT_LRU_State", LRU_RTMFCD, STATUS_NC}} }}
	 
Page2_SecondColDynamTextParam[getTblIdx(LRU_HOTAS)] =
	{{Value = "OFF", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS, STATUS_OFF}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS, STATUS_VALID}} },
	 {Value = "INIT", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS, STATUS_INIT}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS, STATUS_FAIL}} },
	 {Value = "TEST", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS, STATUS_TEST}} },
	 {Value = "NC", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS, STATUS_NC}} }}	 
Page2_SecondColDynamTextParam[getTblIdx(LRU_HOTAS_STICK)] =
	{{Value = "OFF", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_STICK, STATUS_OFF}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_STICK, STATUS_VALID}} },
	 {Value = "INIT", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_STICK, STATUS_INIT}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_STICK, STATUS_FAIL}} },
	 {Value = "TEST", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_STICK, STATUS_TEST}} },
	 {Value = "NC", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_STICK, STATUS_NC}} }}	
Page2_SecondColDynamTextParam[getTblIdx(LRU_HOTAS_THRTL)] =
	{{Value = "OFF", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_THRTL, STATUS_OFF}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_THRTL, STATUS_VALID}} },
	 {Value = "INIT", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_THRTL, STATUS_INIT}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_THRTL, STATUS_FAIL}} },
	 {Value = "TEST", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_THRTL, STATUS_TEST}} },
	 {Value = "NC", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_THRTL, STATUS_NC}} }}	
Page2_SecondColDynamTextParam[getTblIdx(LRU_HOTAS_AHCP)] =
	{{Value = "OFF", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_AHCP, STATUS_OFF}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_AHCP, STATUS_VALID}} },
	 {Value = "INIT", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_AHCP, STATUS_INIT}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_AHCP, STATUS_FAIL}} },
	 {Value = "TEST", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_AHCP, STATUS_TEST}} },
	 {Value = "NC", Ctrlr = {{"STAT_LRU_State", LRU_HOTAS_AHCP, STATUS_NC}} }}	
	 
Page2_SecondColDynamTextParam[getTblIdx(LRU_EGI)] =
	{{Value = "OFF", Ctrlr = {{"STAT_LRU_State", LRU_EGI, STATUS_OFF}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State", LRU_EGI, STATUS_VALID}} },
	 {Value = "INIT", Ctrlr = {{"STAT_LRU_State", LRU_EGI, STATUS_INIT}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_State", LRU_EGI, STATUS_FAIL}} },
	 {Value = "DEGR", Ctrlr = {{"STAT_LRU_State", LRU_EGI, STATUS_DEGR}} }}
Page2_SecondColDynamTextParam[getTblIdx(LRU_IFFCC)] =
	{{Value = "OFF", Ctrlr = {{"STAT_LRU_State", LRU_IFFCC, STATUS_OFF}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State", LRU_IFFCC, STATUS_VALID}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_State", LRU_IFFCC, STATUS_FAIL}} }}
Page2_SecondColDynamTextParam[getTblIdx(LRU_CDU)] =
	{{Value = "NC", Ctrlr = {{"STAT_LRU_State", LRU_CDU, STATUS_NC}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State", LRU_CDU, STATUS_VALID}} },
	 {Value = "INIT", Ctrlr = {{"STAT_LRU_State", LRU_CDU, STATUS_INIT}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_State", LRU_CDU, STATUS_FAIL}} }}
Page2_SecondColDynamTextParam[getTblIdx(LRU_EPLRS)] =
	{{Value = "NC", Ctrlr = {{"STAT_LRU_State", LRU_EPLRS, STATUS_NC}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_State", LRU_EPLRS, STATUS_FAIL}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State", LRU_EPLRS, STATUS_VALID}} }}

for k, v in pairs(Page2_SecondColDynamTextParam) do
	for k2, v2 in pairs(v) do
		AddTblText("Page2_SecondColDynamText_"..LRU_names2[k].."_"..k2, v2.Value, k, 2, v2.Ctrlr)
	end
end


for i = TblIdxBegin, TblIdxEnd do
	AddTblText("ThirdColumnText_" .. LRU_names2[i + PAGE2_LRU_NUM_OFFSET], LRU_test[i + PAGE2_LRU_NUM_OFFSET], i, 3, nil)
end


Page2_ThirdColDynamTextParam = {}
Page2_ThirdColDynamTextParam[getTblIdx(LRU_LTMFCD)] =
	{{Value = "UN", Ctrlr = {{"STAT_LRU_TEST_State", LRU_LTMFCD, TEST_UN}} },
	 {Value = "IP", Ctrlr = {{"STAT_LRU_TEST_State", LRU_LTMFCD, TEST_IP}} },
	 {Value = "PASS", Ctrlr = {{"STAT_LRU_TEST_State", LRU_LTMFCD, TEST_PASS}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_TEST_State", LRU_LTMFCD, TEST_FAIL}} }}
Page2_ThirdColDynamTextParam[getTblIdx(LRU_RTMFCD)] =
	{{Value = "UN", Ctrlr = {{"STAT_LRU_TEST_State", LRU_RTMFCD, TEST_UN}} },
	 {Value = "IP", Ctrlr = {{"STAT_LRU_TEST_State", LRU_RTMFCD, TEST_IP}} },
	 {Value = "PASS", Ctrlr = {{"STAT_LRU_TEST_State", LRU_RTMFCD, TEST_PASS}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_TEST_State", LRU_RTMFCD, TEST_FAIL}} }}
Page2_ThirdColDynamTextParam[getTblIdx(LRU_HOTAS)] =
	{{Value = "UN", Ctrlr = {{"STAT_LRU_TEST_State", LRU_HOTAS, TEST_UN}} },
	 {Value = "IP", Ctrlr = {{"STAT_LRU_TEST_State", LRU_HOTAS, TEST_IP}} },
	 {Value = "PASS", Ctrlr = {{"STAT_LRU_TEST_State", LRU_HOTAS, TEST_PASS}} },
	 {Value = "FAIL", Ctrlr = {{"STAT_LRU_TEST_State", LRU_HOTAS, TEST_FAIL}} }}

for k, v in pairs(Page2_ThirdColDynamTextParam) do
	for k3, v3 in pairs(v) do
		AddTblText("Page2_ThirdColDynamText_"..LRU_names2[k].."_"..k3, v3.Value, k, 3, v3.Ctrlr)
	end
end

LRU_TGP_detailsOFP_NONE					= CreateElement "ceStringPoly"
LRU_TGP_detailsOFP_NONE.name			= "LRU_TGP_detailsOFP_NONE"
LRU_TGP_detailsOFP_NONE.alignment		= "LeftTop"
LRU_TGP_detailsOFP_NONE.value			= "TGP OFP ID:"
LRU_TGP_detailsOFP_NONE.material		= font_MFCD
LRU_TGP_detailsOFP_NONE.stringdefs		= predefined_fonts[1]
SetFaultLogPlacerAsParent(LRU_TGP_detailsOFP_NONE)
LRU_TGP_detailsOFP_NONE.init_pos		= {0, MFL_StringOffset * 2, 0}
LRU_TGP_detailsOFP_NONE.controllers		= {{"STAT_Current_LRU", LRU_TGP}, {"STAT_LRU_State", LRU_TGP, STATUS_INIT + STATUS_NC}}
Add(LRU_TGP_detailsOFP_NONE)
use_mipfilter(LRU_TGP_detailsOFP_NONE)

LRU_TGP_detailsOFP_XXXX					= Copy(LRU_TGP_detailsOFP_NONE)
LRU_TGP_detailsOFP_XXXX.name			= "LRU_TGP_detailsOFP_XXXX"
LRU_TGP_detailsOFP_XXXX.value			= "TGP OFP ID:  XXXX"
LRU_TGP_detailsOFP_XXXX.controllers		= {{"STAT_Current_LRU", LRU_TGP}, {"STAT_LRU_State", LRU_TGP, STATUS_OFF}}
Add(LRU_TGP_detailsOFP_XXXX)

LRU_TGP_detailsOFP_Num					= Copy(LRU_TGP_detailsOFP_XXXX)
LRU_TGP_detailsOFP_Num.name				= "LRU_TGP_detailsOFP_Num"
LRU_TGP_detailsOFP_Num.value			= "TGP OFP ID:  0603  V 2"
LRU_TGP_detailsOFP_Num.controllers		= {{"STAT_Current_LRU", LRU_TGP}, {"STAT_LRU_State", LRU_TGP, STATUS_VALID}}
Add(LRU_TGP_detailsOFP_Num)

LRU_EPLRS_details_None					= CreateElement "ceStringPoly"
LRU_EPLRS_details_None.name				= "LRU_EPLRS_details_None"
LRU_EPLRS_details_None.alignment		= "LeftTop"
LRU_EPLRS_details_None.value			= "EPLRS OFP ID:  XXXX"
LRU_EPLRS_details_None.material			= font_MFCD
LRU_EPLRS_details_None.stringdefs		= predefined_fonts[1]
SetFaultLogPlacerAsParent(LRU_EPLRS_details_None)
LRU_EPLRS_details_None.init_pos			= {0, MFL_StringOffset * 2, 0}
LRU_EPLRS_details_None.controllers		= {{"STAT_Current_LRU", LRU_EPLRS}, {"STAT_LRU_State", LRU_EPLRS, STATUS_NC}}
Add(LRU_EPLRS_details_None)
use_mipfilter(LRU_EPLRS_details_None)

LRU_EPLRS_details_Valid					= Copy(LRU_EPLRS_details_None)
LRU_EPLRS_details_Valid.name			= "LRU_EPLRS_details_Valid"
LRU_EPLRS_details_Valid.value			= "EPLRS OFP ID:  4095"
LRU_EPLRS_details_Valid.controllers		= {{"STAT_Current_LRU", LRU_EPLRS}, {"STAT_LRU_State", LRU_EPLRS, STATUS_VALID}}
Add(LRU_EPLRS_details_Valid)
