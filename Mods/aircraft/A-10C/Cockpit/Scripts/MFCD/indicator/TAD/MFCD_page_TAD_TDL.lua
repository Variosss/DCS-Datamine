dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_TAD_tools.lua")

Add_SOI_border()

Label_OSB_01       = add_OSB_label(1,BRANCH_L .. "TAD")
addOSB_Box(1, {Label_OSB_01})

add_dummy_boxes({2, 3, 4})

Label_OSB_05       = add_OSB_label(5,BRANCH_L .. "SADL")
addOSB_Box(5, {Label_OSB_05})

add_dummy_boxes({6})

Label_OSB_07       = add_OSB_label(7, ROTARY)
Label_OSB_07.controllers = {{"tad_TDL_info_item_ownship_txt_lbl_avail"}}

Label_OSB_07_text  = default_label_text(8,true)
SetLowerLeftCornerOrigin(Label_OSB_07_text)
Label_OSB_07_text.init_pos	  = {soi_max_x, OSB_positions[7][2]}
Label_OSB_07_text.formats     = {"OWN", "OWN\n%d"}
Label_OSB_07_text.controllers = {{"tad_TDL_info_item_ownship_txt"}}
addOSB_Box(7, {Label_OSB_07,Label_OSB_07_text})

Label_OSB_08       = add_OSB_label(8, ROTARY)
Label_OSB_08.controllers = {{"tad_TDL_info_item_fl_leader_sel_rot_avail"}}

Label_OSB_08_text  = default_label_text(8,true)
SetLowerLeftCornerOrigin(Label_OSB_08_text)
Label_OSB_08_text.init_pos	  = {soi_max_x, OSB_positions[8][2]}
Label_OSB_08_text.formats     = {"FL\nOWN", "FL\nOTHR"}
Label_OSB_08_text.controllers = {{"tad_TDL_info_item_fl_leader_sel_type"}}
addOSB_Box(8, {Label_OSB_08, Label_OSB_08_text})

add_dummy_boxes({9, 10})

Label_OSB_16       = add_OSB_label(16, DATA_ENTRY)
Label_OSB_16.controllers = {{"tad_TDL_info_URN_lbl_avail"}}

Label_OSB_16_text  = default_label_text(16,true)
SetLowerLeftCornerOrigin(Label_OSB_16_text)
Label_OSB_16_text.init_pos = {soi_min_x, OSB_positions[16][2]}
Label_OSB_16_text.formats = {"URN\n%s"}
Label_OSB_16_text.controllers = {{"tad_TDL_info_URN", 0}}
addOSB_Box(16,{Label_OSB_16,Label_OSB_16_text})

Label_OSB_17       = add_OSB_label(17, DATA_ENTRY)
Label_OSB_17.controllers = {{"tad_TDL_info_voice_callsign_lbl_avail"}}

Label_OSB_17_text  = default_label_text(17,true)
SetLowerLeftCornerOrigin(Label_OSB_17_text)
Label_OSB_17_text.init_pos = {soi_min_x, OSB_positions[17][2]}
Label_OSB_17_text.formats = {"CALL", "CALL\n%s"}
Label_OSB_17_text.controllers = {{"tad_TDL_info_voice_callsign"}}
addOSB_Box(17,{Label_OSB_17,Label_OSB_17_text})

Label_OSB_18       = add_OSB_label(18,DATA_ENTRY)
Label_OSB_18_text  = default_label_text(18,true)
Label_OSB_18_text.parent_element = Label_OSB_18.name
Label_OSB_18_text.value = "TN"
addOSB_Box(18,{Label_OSB_18,Label_OSB_18_text})

add_osb_static_hint(1 , _("Return to TAD page"))
add_osb_static_hint(5 , _("Go to SADL page"))
add_osb_static_hint(7 , _("Set ownship number"))
add_osb_static_hint(8 , _("Set flight leader"))
add_osb_static_hint(16, _("Set Unit Reference Number"))
add_osb_static_hint(17, _("Set callsign"))
add_osb_static_hint(18, _("Enter track number"))
add_osb_static_hint(19, _("Navigate flight member and donor list"))
add_osb_static_hint(20, _("Navigate flight member and donor list"))


Scrollers = addScrollers(20, 19, 10)
addOSB_Box(20, {Scrollers[3]})
addOSB_Box(19, {Scrollers[4]})


LIST_txt				    = CreateElement "ceStringPoly"
LIST_txt.name			    = "LIST_txt"
LIST_txt.alignment	        = "LeftCenter"
LIST_txt.value		        = "LIST"
LIST_txt.material		    = font_MFCD
LIST_txt.UseBackground	    = true
LIST_txt.BackgroundMaterial = MFCD_SOLID_BLACK
LIST_txt.stringdefs	        = txt_labels_font
LIST_txt.init_pos		    = {OSB_positions[19][1]-5,(OSB_positions[19][2]+OSB_positions[20][2])/2,0}
LIST_txt.controllers	    = {{"declutter"}}
Add(LIST_txt)
SetLowerLeftCornerOrigin(LIST_txt)
use_mipfilter(LIST_txt)

local table_width = 180
TableGroupX = (max_pixels_count - table_width - 20)/2
TableGroupY = max_pixels_count - 95

local table_line_height = 24
local columns = {38}
TableBorder  = AddTable(4 , columns, table_line_height, table_width, TableGroupX, TableGroupY)
TableBorder2 = AddTable(12, columns, table_line_height, table_width, TableGroupX, TableGroupY - 5.5*table_line_height)

text_FLIGHT_MEMBERS						= CreateElement "ceStringPoly"
text_FLIGHT_MEMBERS.material			= font_MFCD
text_FLIGHT_MEMBERS.alignment			= "CenterTop"
text_FLIGHT_MEMBERS.init_pos			= {table_width / 2, table_line_height + 3}
text_FLIGHT_MEMBERS.value				= "FLIGHT MEMBERS"
text_FLIGHT_MEMBERS.stringdefs			= predefined_fonts[1]
text_FLIGHT_MEMBERS.parent_element 		= TableBorder.name
Add(text_FLIGHT_MEMBERS)
use_mipfilter(text_FLIGHT_MEMBERS)

text_DONORS						= CreateElement "ceStringPoly"
text_DONORS.material			= font_MFCD
text_DONORS.alignment			= "CenterTop"
text_DONORS.init_pos			= {table_width / 2, table_line_height + 3}
-- Do not wonder about the trailing space - it was made according to video
text_DONORS.value				= " DONORS"
text_DONORS.stringdefs			= predefined_fonts[1]
text_DONORS.parent_element 		= TableBorder2.name
Add(text_DONORS)
use_mipfilter(text_DONORS)

function add_rows_numbers(parent,count)
    local rows = {}
    for i=1,count do
        rows[i]						= CreateElement "ceStringPoly"
        rows[i].material			= font_MFCD
		rows[i].alignment			= "CenterCenter"
        rows[i].init_pos			= {columns[1] / 2 , -(i-1) * (table_line_height) - table_line_height / 2 - 1 }
        rows[i].value				= tostring(i)
        rows[i].stringdefs			= predefined_fonts[1]
        rows[i].parent_element 		= parent.name
        Add(rows[i])
        use_mipfilter(rows[i])
    end  
    return rows
end

function add_item(parent,i)
	InitPosX = -columns[1] / 2
	
    local   trk_number						= CreateElement "ceStringPoly"
            trk_number.material			    = font_MFCD
            trk_number.alignment			= "LeftCenter"
            trk_number.init_pos			    = {InitPosX + columns[1] + 5, 0}
            trk_number.formats              = {"%s"}
            trk_number.stringdefs			= predefined_fonts[1]
            trk_number.controllers          = {{"tad_TDL_info_item_track_number", 0, i}}
            trk_number.parent_element 		= parent.name
            Add(trk_number)
            use_mipfilter(trk_number)
            
    local   flight_leader					= CreateElement "ceStringPoly"
            flight_leader.material			= font_MFCD
            flight_leader.alignment			= "LeftCenter"
            flight_leader.init_pos			= {InitPosX + 122, 0}
            flight_leader.value             = "FL"
            flight_leader.stringdefs		= predefined_fonts[1]
            flight_leader.controllers       = {{"tad_TDL_info_item_flight_leader",i}}
            flight_leader.parent_element 	= parent.name
            Add(flight_leader)
            use_mipfilter(flight_leader)  
            
    local   ownship					    = CreateElement "ceStringPoly"
            ownship.material			= font_MFCD
            ownship.alignment			= "LeftCenter"
            ownship.init_pos			= {InitPosX + table_width + 5, 0}
            ownship.value               = "OWN"
            ownship.stringdefs		    = predefined_fonts[1]
            ownship.controllers         = {{"tad_TDL_info_item_ownship", i}}
            ownship.parent_element 	    = parent.name
            Add(ownship)
            use_mipfilter(ownship) 
end

function add_cursor(parent,frame_start,frame_end)
    local   SelectedArrow						= CreateElement "ceStringPoly"
            SelectedArrow.material				= font_MFCD
            SelectedArrow.alignment				= "RightCenter"
            SelectedArrow.init_pos				= {-15, -0.5 * table_line_height,0}
            SelectedArrow.value					= BRANCH_L
            SelectedArrow.controllers           = {{"tad_TDL_info_current", frame_start, frame_end, -table_line_height*GetScale()}}
            SelectedArrow.stringdefs			= predefined_fonts[3]
            SelectedArrow.parent_element 		= parent.name
            Add(SelectedArrow)
            use_mipfilter(SelectedArrow)
    return  SelectedArrow
end

rows_1 = add_rows_numbers(TableBorder, 4)
rows_2 = add_rows_numbers(TableBorder2, 12)

add_cursor(TableBorder, 0, 3)
add_cursor(TableBorder2, 4, 15)

for i = 1, #rows_1 do
    add_item(rows_1[i], i-1)
end

for i = 1, #rows_2 do
	add_item(rows_2[i], 4 + i-1)
end
