dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_TAD_tools.lua")

Add_SOI_border()

Label_OSB_01       = add_OSB_label(1,BRANCH_L .. "TAD")

Label_OSB_06       = add_OSB_label(6,BRANCH_L)
Label_OSB_06_text  = default_label_text(6,true)
Label_OSB_06_text.parent_element = Label_OSB_06.name
Label_OSB_06_text.value = "VIEW"

addOSB_Box(6, {Label_OSB_06,Label_OSB_06_text})
addOSB_Box(1, {Label_OSB_01})

add_dummy_boxes({2, 3, 4, 5, 7, 8, 9, 10, 16, 17, 18})

Scrollers = addScrollers(20, 19, 10,
	{{"declutter"}, {"locked_OSB_status", 20 - 1,-1}},
	{{"declutter"}, {"locked_OSB_status", 19 - 1,-1}})
add_osb_static_hint(19, _("Cycle MA selection down"))
add_osb_static_hint(20, _("Cycle MA selection up"))

addOSB_Box(20, {Scrollers[3]})
addOSB_Box(19, {Scrollers[4]})

MA_txt				= CreateElement "ceStringPoly"
MA_txt.name			= "MA"
MA_txt.alignment	= "LeftCenter"
MA_txt.value		= "MA"
MA_txt.material		= font_MFCD
MA_txt.UseBackground	  = true
MA_txt.BackgroundMaterial = MFCD_SOLID_BLACK
MA_txt.stringdefs	= txt_labels_font
MA_txt.init_pos		= {OSB_positions[19][1]-5,(OSB_positions[19][2]+OSB_positions[20][2])/2,0}
MA_txt.controllers	= {{"declutter"}}
Add(MA_txt)
SetLowerLeftCornerOrigin(MA_txt)
use_mipfilter(MA_txt)

local table_line_height = 24
local table_size		= 12
local table_startx		= 150
local table_width		= 284
local table_starty      = max_pixels_count - 105 - table_line_height * 0.5

PageNameText							= CreateElement "ceStringPoly"
PageNameText.name						= "PageNameText"
PageNameText.material					= font_MFCD
PageNameText.alignment					= "CenterBottom"
PageNameText.init_pos					= {table_startx + table_width / 2, OSB_positions[20][2] + 8, 0}
SetLowerLeftCornerOrigin(PageNameText)
PageNameText.stringdefs					= txt_font_2_1
PageNameText.value						= "MISSION ASSIGNMENTS"
Add(PageNameText)
use_mipfilter(PageNameText) 

local vert_lines = {85, 210}
TableBorder = AddTable(table_size, vert_lines, table_line_height, table_width, table_startx, table_starty)

TblHdrPosY = table_line_height

Label_TIME							= CreateElement "ceStringPoly"
Label_TIME.name						= "Label_TIME"
Label_TIME.material					= font_MFCD
Label_TIME.alignment				= "LeftTop"
Label_TIME.init_pos					= {5, TblHdrPosY}
Label_TIME.value					= "TIME"
Label_TIME.stringdefs				= predefined_fonts[1]
Label_TIME.parent_element 			= TableBorder.name
Add(Label_TIME)
use_mipfilter(Label_TIME)

Label_TYPE							= CreateElement "ceStringPoly"
Label_TYPE.name						= "Label_TYPE"
Label_TYPE.material					= font_MFCD
Label_TYPE.alignment				= "LeftTop"
Label_TYPE.init_pos					= {vert_lines[1] + 5, TblHdrPosY}
Label_TYPE.value					= "TYPE"
Label_TYPE.stringdefs				= predefined_fonts[1]
Label_TYPE.parent_element 			= TableBorder.name
Add(Label_TYPE)
use_mipfilter(Label_TYPE)

Label_NM							= CreateElement "ceStringPoly"
Label_NM.name						= "Label_NM"
Label_NM.material					= font_MFCD
Label_NM.alignment					= "RightTop"
Label_NM.init_pos					= {table_width - 5, TblHdrPosY}
Label_NM.value						= "NM"
Label_NM.stringdefs					= predefined_fonts[1]
Label_NM.parent_element 			= TableBorder.name
Add(Label_NM)
use_mipfilter(Label_NM)


SelectedArrow						= CreateElement "ceStringPoly"
SelectedArrow.name					= "SELECTED_ARROW"
SelectedArrow.material				= font_MFCD
SelectedArrow.UseBackground			= false
--SelectedArrow.BackgroundMaterial	= MFCD_SOLID_BLACK
SelectedArrow.alignment				= "RightCenter"
SelectedArrow.init_pos				= {-15, -table_line_height * 0.5}
SelectedArrow.value					= BRANCH_L
SelectedArrow.stringdefs			= predefined_fonts[3]
SelectedArrow.parent_element 		= TableBorder.name
Add(SelectedArrow)
use_mipfilter(SelectedArrow)

scroll_bar_base 				= CreateElement "ceSimple"
scroll_bar_base.name			= "scroll_bar_base"
scroll_bar_base.parent_element  = TableBorder.name
scroll_bar_base.init_pos 		= {300, -table_line_height * table_size * 0.5}
Add(scroll_bar_base)

local scroll_init 		    	= table_size * (table_line_height - 1) / 2 - 0.2 * table_line_height
local scroll_size =	scroll_init - 23.5
local marker_pos  = scroll_init - 10;

scroll_bar						= CreateElement "ceHWLine"
scroll_bar.name					= "scroll_bar"
scroll_bar.vertices				= {{-1.9, -11.1},
								   {-1.9, 11.1}, 
								   {2*scroll_size, 11.1}, 
								   {2*scroll_size, -11.1}}
scroll_bar.maskvertices			= {{0.0, -11.1},
							       {0.0, 11.1},
								   {2*scroll_size, 11.1},
								   {2*scroll_size, -11.1}}
scroll_bar.indices				= box_ind
scroll_bar.init_pos				= {0,scroll_size,0}

scroll_bar.init_rot				= {-90, 0, 0}
scroll_bar.length				= 2*scroll_size -- * new_scale
scroll_bar.maxlength			= 2*scroll_size -- * new_scale
scroll_bar.material				= MFCD_BLUE
scroll_bar.tex_params			= {2 / 512, 399.734 / 512, texture_scale * 2, texture_scale * 2}
scroll_bar.parent_element		=  scroll_bar_base.name
--scroll_bar.controllers			= {{"DSMS_scroll_bar_pos", 0, 312}}
---------------------------------------
scroll_bar.isdraw				= false -- DBG. REMOVE THIS!
---------------------------------------
Add(scroll_bar)
use_mipfilter(scroll_bar)


scroll							=  line_2_pixel({{-8,-scroll_size},
												 {-8, scroll_size},
												 { 8, scroll_size},
												 { 8,-scroll_size},
												 {-8,-scroll_size}}, MFCD_WHITE)
scroll.parent_element		    =  scroll_bar_base.name



scroll_up_filled  				= CreateElement "ceTexPoly"
scroll_up_filled.vertices		= {{0 , 10},
								   {20, 10},
								   {20,-10},
								   {0 ,-10}}
scroll_up_filled.indices		= box_ind
scroll_up_filled.material		= MFCD_BLUE
scroll_up_filled.tex_params		= {4.5/512,479.5/512,1*texture_scale,1*texture_scale} 
scroll_up_filled.init_pos		= {0,marker_pos + 9,0}	
scroll_up_filled.init_rot		= {-90,   0, 0}
use_mipfilter(scroll_up_filled) 
scroll_up_filled.parent_element	=  scroll_bar_base.name
---------------------------------------
scroll_up_filled.isdraw			= false -- DBG. REMOVE THIS!
---------------------------------------
Add(scroll_up_filled)
					 

scroll_down_filled				= CreateElement "ceTexPoly"
scroll_down_filled.vertices		= {{0 , 10},
								   {20, 10},
								   {20,-10},
								   {0 ,-10}}
scroll_down_filled.indices		= box_ind
scroll_down_filled.material		= MFCD_BLUE
scroll_down_filled.tex_params	= {4.5/512,479.5/512,1*texture_scale,1*texture_scale} 
scroll_down_filled.init_pos		= {0,-(marker_pos + 9),0}
scroll_down_filled.init_rot		= { 90,   0, 0}
---------------------------------------
scroll_down_filled.isdraw		= false -- DBG. REMOVE THIS!
---------------------------------------

--[[
ToModelScrollBarBug = true
if ToModelScrollBarBug then
 scroll_down_filled.controllers = {{"DSMS_cursor_at_last_item", 0}}
else
 scroll_down_filled.controllers = {{"DSMS_last_item_visible", 0}}
end
--]]

--scroll_down_filled.controllers	= {{"DSMS_scroll_down_visible"}}
use_mipfilter(scroll_down_filled) 
scroll_down_filled.parent_element	=  scroll_bar_base.name
Add(scroll_down_filled)

scroll_up						=  line_2_pixel({{ 0, 10},
												 {-9,-10},
												 { 9,-10},
												 { 0, 10}}, MFCD_WHITE)
scroll_up.parent_element		=  scroll_bar_base.name												 
scroll_up.init_pos				=  {0,marker_pos,0}

scroll_down					    =  line_2_pixel({{ 0,-10},
								  			     {-9, 10},
											     { 9, 10},
											     { 0,-10}}, MFCD_WHITE)
scroll_down.parent_element		=  scroll_bar_base.name												 
scroll_down.init_pos			=  {0,-marker_pos,0}

add_tad_hook_info()
--add_sadl_data()