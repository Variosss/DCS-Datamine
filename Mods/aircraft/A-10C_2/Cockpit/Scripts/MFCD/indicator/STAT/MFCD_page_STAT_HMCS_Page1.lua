dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")

-- PREV label

local Label_OSB1_symbol					= CreateElement "ceStringPoly"
Label_OSB1_symbol.name					= "HMCS_page1_label_OSB1_symbol"
Label_OSB1_symbol.alignment				= "CenterTop"
Label_OSB1_symbol.value					= BRANCH_L
Label_OSB1_symbol.material				= font_MFCD
Label_OSB1_symbol.stringdefs			= txt_labels_font
Label_OSB1_symbol.UseBackground			= false
Label_OSB1_symbol.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB1_symbol, 1, -27)
Add(Label_OSB1_symbol)
use_mipfilter(Label_OSB1_symbol)

local Label_OSB1						= CreateElement "ceStringPoly"
Label_OSB1.name							= "HMCS_page1_label_OSB1"
Label_OSB1.material						= font_MFCD
Label_OSB1.UseBackground				= false
Label_OSB1.BackgroundMaterial			= MFCD_SOLID_BLACK
Label_OSB1.alignment					= "CenterTop"
Label_OSB1.value						= "PREV"
Label_OSB1.stringdefs					= txt_labels_font
shift_button_pos(Label_OSB1, 1, 0)
Add(Label_OSB1)
use_mipfilter(Label_OSB1)

addOSB_Box(1, {Label_OSB1_symbol, Label_OSB1})
add_osb_static_hint(1, _("Return to STAT Page"))


-- NEXT label

local Label_OSB2_symbol					= CreateElement "ceStringPoly"
Label_OSB2_symbol.name					= "HMCS_page1_label_OSB2_symbol"
Label_OSB2_symbol.alignment				= "CenterTop"
Label_OSB2_symbol.value					= BRANCH_L
Label_OSB2_symbol.material				= font_MFCD
Label_OSB2_symbol.stringdefs			= txt_labels_font
Label_OSB2_symbol.UseBackground			= false
Label_OSB2_symbol.BackgroundMaterial	= MFCD_SOLID_BLACK
shift_button_pos(Label_OSB2_symbol, 2, -27)
Add(Label_OSB2_symbol)
use_mipfilter(Label_OSB2_symbol)

local Label_OSB2						= CreateElement "ceStringPoly"
Label_OSB2.name							= "HMCS_page1_label_OSB2"
Label_OSB2.material						= font_MFCD
Label_OSB2.UseBackground				= false
Label_OSB2.BackgroundMaterial			= MFCD_SOLID_BLACK
Label_OSB2.alignment					= "CenterTop"
Label_OSB2.value						= "NEXT"
Label_OSB2.stringdefs					= txt_labels_font
shift_button_pos(Label_OSB2, 2, 0)
Add(Label_OSB2)
use_mipfilter(Label_OSB2)

addOSB_Box(2, {Label_OSB2_symbol, Label_OSB2})
add_osb_static_hint(2, _("Go to HMCS Page 2"))


local function add_HMCS_ProfileLabel(name, index)
	local osbNum = 2 + index

	local label 						= CreateElement "ceStringPoly"
	label.name							= name
	label.material						= font_MFCD
	label.alignment						= "CenterTop"
	label.stringdefs					= txt_labels_font
	label.controllers					= {{"STAT_HMCS_profile_name", index, 0}}
	shift_button_pos(label, osbNum, 0)
	Add(label)
	use_mipfilter(label)

	local label_inversed				= Copy(label)
	label_inversed.name					= name .. "_inversed"
	label_inversed.material				= font_MFCD_BLACK
	label_inversed.UseBackground		= true
	label_inversed.BackgroundMaterial	= MFCD_SOLID_GREEN
	label_inversed.controllers			= {{"STAT_HMCS_profile_name", index, 1}}
	Add(label_inversed)
	use_mipfilter(label_inversed)
	
	addOSB_Box(osbNum, {label, label_inversed})
	add_osb_static_hint(osbNum, _("Select HMCS profile"))
end

-- OSB 3 - PRO1
add_HMCS_ProfileLabel("HMCS_page1_profile_1_name", 1)
-- OSB 4 - PRO2
add_HMCS_ProfileLabel("HMCS_page1_profile_2_name", 2)
-- OSB 5 - PRO3
add_HMCS_ProfileLabel("HMCS_page1_profile_3_name", 3)

-- OSB 6/7 Quick Through scroll
local Scrollers_6_7 = addScrollers(6, 7, -5)
add_osb_static_hint(6, _("Quick scroll up through symbols list"))
add_osb_static_hint(7, _("Quick scroll down through symbols list"))
addOSB_Box(6, {Scrollers_6_7[3]})
addOSB_Box(7, {Scrollers_6_7[4]})

-- QTR PAGE between OSBs 6 and 7
local QTR_PAGE_Text						= CreateElement "ceStringPoly"
QTR_PAGE_Text.name						= "HMCS_page1_QTR_PAGE_text"
QTR_PAGE_Text.material					= font_MFCD
QTR_PAGE_Text.alignment					= "CenterCenter"
QTR_PAGE_Text.init_pos					= {OSB_positions[6][1]-15, (OSB_positions[6][2]+OSB_positions[7][2])/2, 0}
QTR_PAGE_Text.stringdefs				= txt_labels_font
QTR_PAGE_Text.value						= "QTR\nPAGE"
SetLowerLeftCornerOrigin(QTR_PAGE_Text)
Add(QTR_PAGE_Text)
use_mipfilter(QTR_PAGE_Text) 

-- OSB 8 - TGP track mode
local Label_OSB8						= CreateElement "ceStringPoly"
Label_OSB8.name							= "HMCS_page1_label_OSB8"
Label_OSB8.alignment					= "RightCenter"
Label_OSB8.value						= ROTARY
Label_OSB8.material						= font_MFCD
Label_OSB8.stringdefs					= txt_labels_font
shift_button_pos(Label_OSB8,8,2*OSB_label_spacing,0)
Add(Label_OSB8)
use_mipfilter(Label_OSB8)

local Label_OSB8_text					= CreateElement "ceStringPoly"
Label_OSB8_text.name					= "HMCS_page1_label_OSB8_text"
Label_OSB8_text.alignment				= "RightCenter"
Label_OSB8_text.material				= font_MFCD
Label_OSB8_text.formats					= {"INR", "AREA", "POINT"}
Label_OSB8_text.stringdefs				= txt_labels_font
Label_OSB8_text.parent_element      	= Label_OSB8.name 
Label_OSB8_text.init_pos            	= {-2*OSB_label_spacing,0,0}
Label_OSB8_text.controllers				= {{"STAT_HMCS_TGP_track_mode_when_slaved"}}
Add(Label_OSB8_text)
use_mipfilter(Label_OSB8_text)

addOSB_Box(8, {Label_OSB8, Label_OSB8_text})
add_osb_static_hint(8, _("Select TGP track mode when slewed to HMCS LOS"))

local function addBrightnessControl(name, osb, mode, text, hint)
	local labelAction								= CreateElement "ceStringPoly"
	labelAction.name								= name.."_actionSymbol"
	labelAction.alignment							= "RightCenter"
	labelAction.value								= SYS_ACTION
	labelAction.material							= font_MFCD
	labelAction.stringdefs							= txt_labels_font
	shift_button_pos(labelAction, osb, 2*OSB_label_spacing, 0)
	Add(labelAction)
	use_mipfilter(labelAction)

	local label_text								= CreateElement "ceStringPoly"
	label_text.name									= name.."_label_text"
	label_text.alignment							= "RightCenter"
	label_text.material								= font_MFCD
	label_text.value								= text
	label_text.stringdefs							= txt_labels_font
	label_text.parent_element      					= labelAction.name 
	label_text.init_pos            					= {-2*OSB_label_spacing,0,0}
	label_text.controllers							= {{"STAT_HMCS_brightness_mode", mode, 0}}
	Add(label_text)	
	use_mipfilter(label_text)	
	
	local label_text_inversed						= Copy(label_text)
	label_text_inversed.name						= name.."_label_text_inversed"
	label_text_inversed.material					= font_MFCD_BLACK
	label_text_inversed.UseBackground				= true
	label_text_inversed.BackgroundMaterial			= MFCD_SOLID_GREEN
	label_text_inversed.controllers					= {{"STAT_HMCS_brightness_mode", mode, 1}}
	Add(label_text_inversed)	
	use_mipfilter(label_text_inversed)	
	
	local label_text_percents						= Copy(label_text)
	label_text_percents.name						= name.."_label_text_percents"
	label_text_percents.value						= ""
	label_text_percents.formats						= {"\n%d%%"}
	label_text_percents.parent_element      		= label_text.name 
	label_text_percents.init_pos            		= {0, 0, 0}
	label_text_percents.controllers					= {{"STAT_HMCS_brightness_value", mode}}
	Add(label_text_percents)
	use_mipfilter(label_text_percents)

	local label_text_percents_inversed				= Copy(label_text_percents)
	label_text_percents_inversed.name				= name.."_label_text_percents_inversed"
	label_text_percents_inversed.material			= font_MFCD_BLACK
	label_text_percents_inversed.UseBackground		= true
	label_text_percents_inversed.BackgroundMaterial	= MFCD_SOLID_GREEN
	label_text_percents_inversed.parent_element     = label_text_inversed.name 
	label_text_percents_inversed.controllers		= {{"STAT_HMCS_brightness_value", mode}}
	Add(label_text_percents_inversed)
	use_mipfilter(label_text_percents_inversed)

	addOSB_Box(osb, {labelAction, label_text, label_text_inversed, label_text_percents, label_text_percents_inversed})
	add_osb_static_hint(osb, hint)
end

-- OSB 9 - Day brightness mode
addBrightnessControl("HMCS_page1_brightness_DAY", 9, 0, " DAY\n    ", _("Select DAY brightness mode"))
-- OSB 10 - Night brightness mode
addBrightnessControl("HMCS_page1_brightness_NIGHT", 10, 1, "NIGHT\n     ", _("Select NIGHT brightness mode"))

addOSB_Box(16)

-- OSB 17 - Symbol range
local Label_OSB17_symb								= CreateElement "ceStringPoly"
Label_OSB17_symb.name								= "HMCS_page1_label_OSB17_symb"
Label_OSB17_symb.alignment							= "LeftCenter"
Label_OSB17_symb.value								= DATA_ENTRY
Label_OSB17_symb.material							= font_MFCD
Label_OSB17_symb.stringdefs							= txt_labels_font
Label_OSB17_symb.controllers						= {{"STAT_HMCS_range_entry_avail"}}
shift_button_pos(Label_OSB17_symb,17,-2*OSB_label_spacing,0)
Add(Label_OSB17_symb)
use_mipfilter(Label_OSB17_symb)

local Label_OSB17									= CreateElement "ceStringPoly"
Label_OSB17.name									= "HMCS_page1_label_OSB17"
Label_OSB17.alignment								= "LeftCenter"
Label_OSB17.value									= "RANGE"
Label_OSB17.material								= font_MFCD
Label_OSB17.stringdefs								= txt_labels_font
shift_button_pos(Label_OSB17,17,0,0)
Add(Label_OSB17)
use_mipfilter(Label_OSB17)

addOSB_Box(17, {Label_OSB17_symb, Label_OSB17})
add_osb_hint_controllers(17, _("Enter symbol range"), {{"STAT_HMCS_range_entry_avail"}})

-- OSB 18 - Symbol state
local Label_OSB18_symb								= CreateElement "ceStringPoly"
Label_OSB18_symb.name								= "HMCS_page1_label_OSB18_symb"
Label_OSB18_symb.alignment							= "LeftCenter"
Label_OSB18_symb.value								= ROTARY
Label_OSB18_symb.material							= font_MFCD
Label_OSB18_symb.stringdefs							= txt_labels_font
shift_button_pos(Label_OSB18_symb,18,-2*OSB_label_spacing,0)
Add(Label_OSB18_symb)
use_mipfilter(Label_OSB18_symb)

local Label_OSB18									= CreateElement "ceStringPoly"
Label_OSB18.name									= "HMCS_page1_label_OSB18"
Label_OSB18.alignment								= "LeftCenter"
Label_OSB18.formats									= {"OCLD", "OFF", "ON", "GHST", "NORM"}
Label_OSB18.material								= font_MFCD
Label_OSB18.stringdefs								= txt_labels_font
Label_OSB18.parent_element      					= Label_OSB18_symb.name
Label_OSB18.init_pos            					= {2*OSB_label_spacing,0,0}
Label_OSB18.controllers								= {{"STAT_HMCS_symbol_status"}}
Add(Label_OSB18)
use_mipfilter(Label_OSB18)

addOSB_Box(18, {Label_OSB18_symb, Label_OSB18})
add_osb_static_hint(18, "Select symbol state")

-- OSB 19/20 Symbol Navigation
Scrollers_20_19 = addScrollers(20, 19, 5, {{"STAT_HMCS_can_navigate_cursor", 1}}, {{"STAT_HMCS_can_navigate_cursor", -1}})
add_osb_hint_controllers(19, _("Symbol navigation down"), {{"STAT_HMCS_can_navigate_cursor", -1}})
add_osb_hint_controllers(20, _("Symbol navigation up"), {{"STAT_HMCS_can_navigate_cursor", 1}})

addOSB_Box(20, {Scrollers_20_19[3]})
addOSB_Box(19, {Scrollers_20_19[4]})

-- SYMBOL between OSBs 19 and 20
SymbolText							= CreateElement "ceStringPoly"
SymbolText.name						= "HMCS_page1_SYMBOL_text"
SymbolText.material					= font_MFCD
SymbolText.alignment				= "LeftCenter"
SymbolText.init_pos					= {OSB_positions[19][1]-15, (OSB_positions[19][2]+OSB_positions[20][2])/2, 0}
SymbolText.stringdefs				= txt_labels_font
SymbolText.value					= "SYMBOL"
SetLowerLeftCornerOrigin(SymbolText)
Add(SymbolText)
use_mipfilter(SymbolText) 

-- HMCS profiles table

local tableLinesCount 			= 20

local tableStringHeight 		= 22
local tableInitPosX 			= 110
local tableInitPosY 			= max_pixels_count - 520
local tableWidth 				= 330
local tableHeight 				= tableLinesCount * tableStringHeight
local tableVertLinePosX_1		= 350
local tableVertLinePosX_2		= 405

local TableBorder							= line_2_pixel({{0, tableInitPosY},
												{0, tableInitPosY + tableHeight}, 
												{tableWidth, tableInitPosY + tableHeight},
												{tableWidth, tableInitPosY},
												{0, tableInitPosY}}, MFCD_GREEN)
TableBorder.init_pos	    				= {tableInitPosX,0,0}
SetLowerLeftCornerOrigin(TableBorder)

TableHorLines={}
for i = 1, tableLinesCount - 1 do
	TableHorLines[i]						= line_2_pixel({{0, tableInitPosY + i * tableStringHeight},
												{tableWidth, tableInitPosY + i * tableStringHeight}}, MFCD_GREEN)
	TableHorLines[i].init_pos	    		= {tableInitPosX,0,0}
	SetLowerLeftCornerOrigin(TableHorLines[i])
end

TableVertLines={}

TableVertLines[1]							= line_2_pixel({{tableVertLinePosX_1, tableInitPosY},
												{tableVertLinePosX_1, tableInitPosY + tableHeight}}, MFCD_GREEN)
TableVertLines[1].init_pos	    			= {0,0,0}
SetLowerLeftCornerOrigin(TableVertLines[1])

TableVertLines[2]							= line_2_pixel({{tableVertLinePosX_2, tableInitPosY},
												{tableVertLinePosX_2, tableInitPosY + tableHeight}}, MFCD_GREEN)
TableVertLines[2].init_pos	    			= {0,0,0}
SetLowerLeftCornerOrigin(TableVertLines[2])

local symbolsNames = {}
local symbolsStates = {}
local symbolsRanges = {}

for i = 1, tableLinesCount do
	symbolsNames[i]								= CreateElement "ceStringPoly"
	symbolsNames[i].name						= "HMCS_profiles_tbl_symbol_name_"..i
	symbolsNames[i].material					= font_MFCD
	symbolsNames[i].alignment					= "LeftCenter"
	symbolsNames[i].init_pos					= {tableInitPosX + 8, tableInitPosY - tableStringHeight / 2 + tableStringHeight * i, 0}
	symbolsNames[i].controllers					= {{"STAT_HMCS_table_symbol_name", tableLinesCount - i}}
	symbolsNames[i].formats						= {"%s"}
	symbolsNames[i].stringdefs					= predefined_fonts[1]
	SetLowerLeftCornerOrigin(symbolsNames[i])
	Add(symbolsNames[i])
	use_mipfilter(symbolsNames[i])
	
	symbolsStates[i]							= CreateElement "ceStringPoly"
	symbolsStates[i].name						= "HMCS_profiles_tbl_symbol_state_"..i
	symbolsStates[i].material					= font_MFCD
	symbolsStates[i].alignment					= "CenterCenter"
	symbolsStates[i].init_pos					= {tableVertLinePosX_1 + (tableVertLinePosX_2 - tableVertLinePosX_1) / 2, tableInitPosY - tableStringHeight / 2 + tableStringHeight * i, 0}
	symbolsStates[i].controllers				= {{"STAT_HMCS_table_symbol_state", tableLinesCount - i}}
	symbolsStates[i].formats					= {"OCLD", "OFF", "ON", "GHST", "NORM"}
	symbolsStates[i].stringdefs					= predefined_fonts[1]
	SetLowerLeftCornerOrigin(symbolsStates[i])
	Add(symbolsStates[i])
	use_mipfilter(symbolsStates[i])
	
	symbolsRanges[i]							= CreateElement "ceStringPoly"
	symbolsRanges[i].name						= "HMCS_profiles_tbl_symbol_range_"..i
	symbolsRanges[i].material					= font_MFCD
	symbolsRanges[i].alignment					= "CenterCenter"
	symbolsRanges[i].init_pos					= {tableVertLinePosX_2 + (tableInitPosX + tableWidth - tableVertLinePosX_2) / 2, tableInitPosY - tableStringHeight / 2 + tableStringHeight * i, 0}
	symbolsRanges[i].controllers				= {{"STAT_HMCS_table_symbol_range", tableLinesCount - i}}
	symbolsRanges[i].formats					= {"%d", "-"}
	symbolsRanges[i].stringdefs					= predefined_fonts[1]
	SetLowerLeftCornerOrigin(symbolsRanges[i])
	Add(symbolsRanges[i])
	use_mipfilter(symbolsRanges[i])
end

local scrollHeight = tableHeight - tableStringHeight * 2
addTableScrollBar(171, tableInitPosY + (tableStringHeight * tableLinesCount / 2) - max_pixels_count / 2, scrollHeight,
	{{"STAT_HMCS_scroll_bar_pos", 0, scrollHeight}},
    {{"STAT_HMCS_scroll_up_visible"}},
    {{"STAT_HMCS_cursor_at_last_item"}},
    nil)

local tableArrow							= CreateElement "ceStringPoly"
tableArrow.name								= "HMCS_profiles_tbl_arrow"
tableArrow.material							= font_MFCD
tableArrow.alignment						= "RightCenter"
tableArrow.init_pos							= {tableInitPosX - 5, tableInitPosY - tableStringHeight / 2 + tableStringHeight * tableLinesCount, 0}
tableArrow.value							= BRANCH_L
tableArrow.stringdefs						= predefined_fonts[3]
tableArrow.controllers						= {{"STAT_HMCS_table_arrow_pos", tableStringHeight}}
SetLowerLeftCornerOrigin(tableArrow)
Add(tableArrow)
use_mipfilter(tableArrow)

local text_HMCS_SYMBOLOGY					= CreateElement "ceStringPoly"
text_HMCS_SYMBOLOGY.name					= "HMCS_page1_text_SYMBOLOGY"
text_HMCS_SYMBOLOGY.material				= font_MFCD
text_HMCS_SYMBOLOGY.alignment				= "CenterTop"
text_HMCS_SYMBOLOGY.init_pos				= {tableInitPosX + tableWidth / 2, tableInitPosY + 21 * tableStringHeight + 15, 0}
text_HMCS_SYMBOLOGY.value					= "HMCS SYMBOLOGY"
text_HMCS_SYMBOLOGY.stringdefs				= predefined_fonts[2]
SetLowerLeftCornerOrigin(text_HMCS_SYMBOLOGY)
Add(text_HMCS_SYMBOLOGY)
use_mipfilter(text_HMCS_SYMBOLOGY)
