dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_TAD_tools.lua")


Add_SOI_border()

Label_OSB_01   = add_OSB_label(1, BRANCH_L .. "TAD")
Label_OSB_02   = add_OSB_label(2, BRANCH_L .. "RET")

addOSB_Box(1,{Label_OSB_01})
addOSB_Box(2,{Label_OSB_02})

--------------------------------------------------------------------------------------------------------

Scrollers = addScrollers(20, 19, 10,
	{{"declutter"}, {"locked_OSB_status", 20 - 1,-1}},
	{{"declutter"}, {"locked_OSB_status", 19 - 1,-1}})
add_osb_static_hint(1, _("Return toTAD page"))
add_osb_static_hint(2, _("Return to TAD Profile Control page"))
add_osb_static_hint(18, _("Change symbol state"))
add_osb_static_hint(19, _("Navigate symbol down"))
add_osb_static_hint(20, _("Navigate symbol up"))

addOSB_Box(20, {Scrollers[3]})
addOSB_Box(19, {Scrollers[4]})

SYMBOL_txt				= CreateElement "ceStringPoly"
SYMBOL_txt.name			= "SYMBOL_txt"
SYMBOL_txt.alignment	= "LeftCenter"
SYMBOL_txt.value		= "SYMBOL"
SYMBOL_txt.material		= font_MFCD
SYMBOL_txt.UseBackground	  = false
--SYMBOL_txt.BackgroundMaterial = MFCD_SOLID_BLACK
SYMBOL_txt.stringdefs	= txt_labels_font
SYMBOL_txt.init_pos		= {OSB_positions[19][1]-5,(OSB_positions[19][2]+OSB_positions[20][2])/2,0}
SYMBOL_txt.controllers	= {{"declutter"}}
Add(SYMBOL_txt)
SetLowerLeftCornerOrigin(SYMBOL_txt)
use_mipfilter(SYMBOL_txt)

------------------------table-----------------------------------------------------------------------------
local table_line_height = 28
local table_size		= 7
local table_init_pos    = max_pixels_count - 91 - table_line_height * 2.5
local table_width		= 250

local vert_lines = {209}
TableBorder = AddTable(table_size, vert_lines, table_line_height, table_width, 158, table_init_pos)

Label_TDL_SYMBOLOGY							= CreateElement "ceStringPoly"
Label_TDL_SYMBOLOGY.name					= "Label_TIME"
Label_TDL_SYMBOLOGY.material				= font_MFCD
Label_TDL_SYMBOLOGY.alignment				= "CenterBottom"
Label_TDL_SYMBOLOGY.init_pos				= {table_width/2}
Label_TDL_SYMBOLOGY.value					= "TDL SYMBOLOGY"
Label_TDL_SYMBOLOGY.stringdefs				= predefined_fonts[1]
Label_TDL_SYMBOLOGY.parent_element 			= TableBorder.name
Add(Label_TDL_SYMBOLOGY)
use_mipfilter(Label_TDL_SYMBOLOGY)

local texts      =  {"BULLSEYE",
					 "RANGE RINGS",
					 "HOOK INFO",
					 "WAYPOINT LINES",
					 "WAYPOINT LABEL",
					 "WAYPOINTS",
					 "SPI DISPLAY"}

local contr = {}
					 
local table_text = {}
local table_value = {}

function on_off(parent, controller, on_label, off_label)
	local el = {}
	el[1]							= CreateElement "ceStringPoly"
	el[1].material					= font_MFCD
	el[1].alignment					= "LeftTop"
	el[1].init_pos					= {vert_lines[1],0}
	el[1].value						= on_label or "ON"
	el[1].stringdefs				= predefined_fonts[1]
	el[1].parent_element 			= parent.name
	el[1].controllers   			= {{controller,1}}
	Add(el[1])
	use_mipfilter(el[1])

	el[2]							= CreateElement "ceStringPoly"
	el[2].material					= font_MFCD
	el[2].alignment					= "LeftTop"
	el[2].init_pos					= {vert_lines[1],0}
	el[2].value						= off_label or "OFF"
	el[2].stringdefs				= predefined_fonts[1]
	el[2].parent_element 			= parent.name
	el[2].controllers   			= {{controller,0}}
	Add(el[2])
	use_mipfilter(el[2])
	return el
end


function enum(parent, controller, values)
local el = {}
for i = 1,#values do
	el[i]							= CreateElement "ceStringPoly"
	el[i].material					= font_MFCD
	el[i].alignment					= "LeftTop"
	el[i].init_pos					= {vert_lines[1],0}
	el[i].value						= values[i][1]
	el[i].stringdefs				= predefined_fonts[1]
	el[i].parent_element 			= parent.name
	el[i].controllers   			= {{controller,values[i][2]}}
	Add(el[i])
	use_mipfilter(el[i])
end
return el
end


for i = 1, table_size do
	table_text[i] 					= CreateElement "ceStringPoly"
	table_text[i].material			= font_MFCD
	table_text[i].alignment			= "LeftTop"
	table_text[i].init_pos			= {5, -table_line_height * (i - 1) - 3}
	table_text[i].value				= texts[i]
	table_text[i].stringdefs		= predefined_fonts[1]
	table_text[i].parent_element 	= TableBorder.name
	Add(table_text[i])
	use_mipfilter(table_text[i]) 
end


on_off(table_text[1], "tad_bullseye_enable_prof")
on_off(table_text[2], "tad_rings_enable_prof")
enum  (table_text[3], "tad_hook_info_enumeration_prof", {{"OFF", 0}, {"ON", 1}, {"ACT", 2}})
on_off(table_text[4], "tad_flight_plan_lines_enable_prof")
on_off(table_text[5], "tad_waypoint_labels_enable_prof")
on_off(table_text[6], "tad_ownship_waypoints_enable_prof")
enum  (table_text[7], "tad_spi_display_enable_prof", {{"OWN", 0}, {"ALL", 1}})

SelectedArrow						= CreateElement "ceStringPoly"
SelectedArrow.name					= "SELECTED_ARROW"
SelectedArrow.material				= font_MFCD
SelectedArrow.UseBackground			= false
--SelectedArrow.BackgroundMaterial	= MFCD_SOLID_BLACK
SelectedArrow.alignment				= "RightCenter"
SelectedArrow.init_pos				= {-15, -table_line_height * 0.5}
SelectedArrow.controllers 			= {{"tad_profile_settings_cursor", -table_line_height*GetScale()}}
SelectedArrow.value					= BRANCH_L
SelectedArrow.stringdefs			= predefined_fonts[3]
SelectedArrow.parent_element 		= TableBorder.name
Add(SelectedArrow)
use_mipfilter(SelectedArrow)
--[[
add_osb_static_hint(6,  _("Set frequency mapping"))
add_osb_static_hint(7,  _("Set guard channel"))
add_osb_static_hint(8,  _("Set Gateway key"))
add_osb_static_hint(9,  _("Set Air key"))
add_osb_static_hint(10, _("Set Ground key"))
add_osb_static_hint(17, _("Set logic channel number"))
add_osb_static_hint(18, _("Set symbol state"))

Label_OSB6   = add_OSB_label(6,  ROTARY)
Label_OSB7   = add_OSB_label(7,  DATA_ENTRY)
Label_OSB8   = add_OSB_label(8,  DATA_ENTRY)
Label_OSB9   = add_OSB_label(9,  DATA_ENTRY)
Label_OSB10  = add_OSB_label(10, DATA_ENTRY)
Label_OSB17  = add_OSB_label(17, DATA_ENTRY)
--]]
Label_OSB18  = add_OSB_label(18, ROTARY)
--[[

frequency 						= default_label_text(6)
frequency.parent_element 		= Label_OSB6.name
frequency.formats				= {"FREQ\n%d"}
frequency.controllers 		    = {{"tad_frequency_mapping_prof",0}}

guard_channel 					= default_label_text(7)
guard_channel.parent_element 	= Label_OSB7.name
guard_channel.formats			= {"CHNL\n%d%d"}
guard_channel.controllers 		= {{"tad_guard_channel_mapping_prof",0}}

gateway_key 					= default_label_text(8)
gateway_key.parent_element 		= Label_OSB8.name
gateway_key.formats				= {"GAT\n%s"}
gateway_key.controllers 		= {{"tad_gateway_key_prof",0}}

air_key 						= default_label_text(9)
air_key.parent_element 			= Label_OSB9.name
air_key.formats					= {"AIR\n%s"}
air_key.controllers 			= {{"tad_air_key_prof",0}}

ground_key						= default_label_text(10)
ground_key.parent_element 		= Label_OSB10.name
ground_key.formats				= {"GND\n%s"}
ground_key.controllers 			= {{"tad_ground_key_prof",0}}


logic_channel					= default_label_text(17)
logic_channel.parent_element 	= Label_OSB17.name
logic_channel.formats			= {"LCN1/2\n%s/", "%s"}
logic_channel.controllers 		= {{"tad_logic_channel_number_prof", 0, 1},
								   {"tad_logic_channel_number_prof", 1, 2}}
 --]]
local osb18_symbs = {}
for   i = 1,7 do
	osb18_symbs[i]			 	  = CreateElement "ceSimple"
	osb18_symbs[i].parent_element = Label_OSB18.name
	osb18_symbs[i].controllers    = {{"tad_profile_settings_entry",i - 1}}
	Add(osb18_symbs[i])
end

function osb_18_labels_bool(parent,controller)
	local 	el = {}
	for i = 1,2 do
		el[i]				 = default_label_text(18,true)
		if i == 1 then	
			el[i].value			 = "SYM\nON"
			el[i].controllers    = {{controller,1}}
		else
			el[i].value			 = "SYM\nOFF"
			el[i].controllers    = {{controller,0}}
		end
		el[i].parent_element = parent.name
	end
	return el
end

function osb_18_labels_enum(parent,controller,values)
	local 	el = {}
	for i = 1,#values do
		el[i]				= default_label_text(18,true)
		el[i].value			= values[i][1]
		el[i].stringdefs	= predefined_fonts[1]
		el[i].parent_element= parent.name
		el[i].controllers   = {{controller,values[i][2]}}
	end
	return el
end

local box_table = {}
      box_table[1] = osb_18_labels_bool(osb18_symbs[1], "tad_bullseye_enable_prof")
	  box_table[2] = osb_18_labels_bool(osb18_symbs[2], "tad_rings_enable_prof")
	  box_table[3] = osb_18_labels_enum(osb18_symbs[3], "tad_hook_info_enumeration_prof", {{"SYM\nOFF", 0}, {"SYM\nON", 1}, {"SYM\nACT", 2}})
	  box_table[4] = osb_18_labels_bool(osb18_symbs[4], "tad_flight_plan_lines_enable_prof")
	  box_table[5] = osb_18_labels_bool(osb18_symbs[5], "tad_waypoint_labels_enable_prof")
	  box_table[6] = osb_18_labels_bool(osb18_symbs[6], "tad_ownship_waypoints_enable_prof")
	  box_table[7] = osb_18_labels_enum(osb18_symbs[7], "tad_spi_display_enable_prof", {{"SYM\nOWN", 0}, {"SYM\nALL", 1}})

local tbl = {}
tbl[1] = Label_OSB18
local n = 2
for j=1,#box_table do
	for k =1,#box_table[j] do
		tbl[n] = box_table[j][k]
		n = n + 1
	end
end


--addOSB_Box(6, {Label_OSB6,frequency})
--addOSB_Box(7, {Label_OSB7,guard_channel})
--addOSB_Box(8, {Label_OSB8,gateway_key})
--addOSB_Box(9, {Label_OSB9,air_key})
--addOSB_Box(10, {Label_OSB10,ground_key})
--addOSB_Box(17, {Label_OSB17,logic_channel})
addOSB_Box(18, tbl)

add_tad_save_delete_profile_notification()
---------------------------

add_dummy_boxes({4, 5, 16})



