dofile(LockOn_Options.script_path.."MFCD/indicator/STAT/MFCD_page_STAT_common.lua")

-- PREV label

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
add_osb_static_hint(1, _("Go to STAT Page 2"))


function AddTextStat3(Name, Alignment, InitPos, FontDefs, DrawBackgnd, Controllers, Val)
	local Obj              = CreateElement "ceStringPoly"
	Obj.name               = Name
	Obj.material           = "font_MFCD"
	Obj.alignment          = Alignment
	Obj.init_pos           = InitPos
	SetLowerLeftCornerOrigin(Obj)
	Obj.stringdefs         = FontDefs
	Obj.UseBackground      = DrawBackgnd
	Obj.BackgroundMaterial = "INDICATION_COMMON_BLACK"
	Obj.value 				= Val
	
	if Controllers ~= nil then
		Obj.controllers    = Controllers
	end
	
	Add(Obj)
	use_mipfilter(Obj)

	return Obj
end


------------------------------------------------------


------------------------------------------------------
-- TABLE

local PAGE3_LRU_NUM_OFFSET = LRU_HMCS

local function getTblIdx(In)
	return In - PAGE3_LRU_NUM_OFFSET
end


local TblIdxBegin = getTblIdx(LRU_DVADR)
local TblIdxEnd   = getTblIdx(LRU_ARC210_2)

--AddTblBackgndRow("Page3_StaticBackgnd_"..LRU_names2[getTblIdx(LRU_DVADR)], "MFCD_GREEN", getTblIdx(LRU_DVADR),
	--TblRowHeight, TblHalfWidth * 2, TblCenterX - TblHalfWidth, Tbl1stLinePosY, nil)

Page3_DynamBackgndParam = {}
Page3_DynamBackgndParam[getTblIdx(LRU_DVADR)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_DVADR, STATUS_OFF}} },
	 {Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_DVADR, STATUS_NA}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_DVADR, STATUS_VALID}} }}
Page3_DynamBackgndParam[getTblIdx(LRU_ARC210_1)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_1, STATUS_OFF}} },
	 {Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_1, STATUS_NA}} },
	 {Color = MFCD_SOLID_GREEN, Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_1, STATUS_VALID}} }}
Page3_DynamBackgndParam[getTblIdx(LRU_ARC210_2)] = 
	{{Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_2, STATUS_OFF}} },
	 {Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_2, STATUS_NA}} },
	 {Color = MFCD_SOLID_WHITE, Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_2, STATUS_VALID}} }}

for k, v in pairs(Page3_DynamBackgndParam) do
	for k2, v2 in pairs(v) do
		AddTblBackgndRow("Page3_DynamBackgnd_"..LRU_names2[k].."_"..k2, v2.Color, k,
			TblRowHeight, TblHalfWidth * 2, TblCenterX - TblHalfWidth, Tbl1stLinePosY, v2.Ctrlr)
	end
end

addSTAT_Table(TblIdxEnd - TblIdxBegin + 1)

for i = TblIdxBegin, TblIdxEnd do
	AddTblText("FirstColumnText_" .. LRU_names2[i + PAGE3_LRU_NUM_OFFSET],
		LRU_names[i + PAGE3_LRU_NUM_OFFSET], i, 1, nil)
end

AddTblText("SecondColumnText_" .. LRU_names2[getTblIdx(LRU_DVADR) + PAGE3_LRU_NUM_OFFSET],
	LRU_status[getTblIdx(LRU_DVADR) + PAGE3_LRU_NUM_OFFSET], getTblIdx(LRU_DVADR), 2, nil)


Page3_SecondColDynamTextParam = {}
Page3_SecondColDynamTextParam[getTblIdx(LRU_ARC210_1)] =
	{{Value = "NC", Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_1, STATUS_OFF}} },
	 {Value = "-", Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_1, STATUS_NA}} },
	 {Value = "VALID", Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_1, STATUS_VALID}} }}
Page3_SecondColDynamTextParam[getTblIdx(LRU_ARC210_2)] =
	{{Value = "NC", Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_2, STATUS_OFF}} },
	 {Value = "-", Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_2, STATUS_NA}} },
	 {Value = "-", Ctrlr = {{"STAT_LRU_State_A10C_2", LRU_ARC210_2, STATUS_VALID}} }}
	

for k, v in pairs(Page3_SecondColDynamTextParam) do
	for k2, v2 in pairs(v) do
		AddTblText("Page3_SecondColDynamText_"..LRU_names2[k].."_"..k2, v2.Value, k, 2, v2.Ctrlr)
	end
end

AddTblText("SecondColumnText_DVADR_1", LRU_status[LRU_DVADR], getTblIdx(LRU_DVADR), 2, nil)

AddTblText("ThirdColumnText_" .. LRU_names2[LRU_DVADR], LRU_test[LRU_DVADR], getTblIdx(LRU_DVADR), 3, nil)
AddTblText("ThirdColumnText_" .. LRU_names2[LRU_ARC210_1], LRU_test[LRU_ARC210_1], getTblIdx(LRU_ARC210_1), 3, nil)
AddTblText("ThirdColumnText_" .. LRU_names2[LRU_ARC210_2], LRU_test[LRU_ARC210_2], getTblIdx(LRU_ARC210_2), 3, nil)



------------------------------------------------------
-- DVADR
LRU_details_DVADR = AddTextStat3("LRU_details_DVADR", "LeftTop",
	{0, MFL_StringOffset * 2}, predefined_fonts[1], false,
	{{"STAT_Current_LRU", LRU_DVADR}},
	"DVADR OFP ID:  2 5 0")
SetFaultLogPlacerAsParent(LRU_details_DVADR)


------------------------------------------------------
-- ARC-210
local ARC_Var_Tbl = {}

ARC_Var_Tbl["NA"]                      = {}
ARC_Var_Tbl["NA"]["name_suffix"]       = "_NA"
ARC_Var_Tbl["NA"]["value_var_part"]    = "ARC210-%d OFP ID: XXXX\n" ..
                                         "ARC210-%d BOOT:   XXXX"
ARC_Var_Tbl["NA"]["check_status"]      = STATUS_NA + STATUS_OFF

ARC_Var_Tbl["VALID"]                   = {}
ARC_Var_Tbl["VALID"]["name_suffix"]    = "_Valid"
ARC_Var_Tbl["VALID"]["value_var_part"] = "ARC210-%d OFP ID: 9841594002\n" ..
                                         "ARC210-%d BOOT:   9841586003"
ARC_Var_Tbl["VALID"]["check_status"]   = STATUS_VALID






idx = LRU_ARC210_1 - LRU_ARC210_1 + 1
ARC_LRU_details = AddTextStat3("ARC_LRU_details_" .. idx .. ARC_Var_Tbl["VALID"].name_suffix, "LeftTop",
			{0, MFL_StringOffset * 2}, predefined_fonts[1], false,
			{{"STAT_Current_LRU", LRU_ARC210_1}, {"STAT_LRU_State", LRU_ARC210_1, ARC_Var_Tbl["VALID"].check_status}},
			 string.format(ARC_Var_Tbl["VALID"].value_var_part, idx, idx))
		SetFaultLogPlacerAsParent(ARC_LRU_details)		


idx = LRU_ARC210_2 - LRU_ARC210_1 + 1
ARC_LRU_details = AddTextStat3("ARC_LRU_details_" .. idx .. ARC_Var_Tbl["NA"].name_suffix, "LeftTop",
			{0, MFL_StringOffset * 2}, predefined_fonts[1], false,
			{{"STAT_Current_LRU", LRU_ARC210_2}, {"STAT_LRU_State", LRU_ARC210_2, ARC_Var_Tbl["NA"].check_status}},
			 string.format(ARC_Var_Tbl["NA"].value_var_part, idx, idx))
		SetFaultLogPlacerAsParent(ARC_LRU_details)
		



