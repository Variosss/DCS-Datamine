dofile(LockOn_Options.script_path.."MFCD/indicator/MAV/MFCD_MAV_tools.lua")

back    			= CreateElement "ceMeshPoly"
back.name           = "back"
back.primitivetype  = "triangles"
back.vertices       =  {{0               ,0},
					    {0				 ,max_pixels_count},
						{max_pixels_count,max_pixels_count},
						{max_pixels_count,0}}
back.indices         = box_ind
back.level		     = DEFAULT_LEVEL
back.h_clip_relation = h_clip_relations.REWRITE_LEVEL
set_as_invisible_mask(back)
SetLowerLeftCornerOrigin(back)
Add(back)

Add_SOI_border()


maverick_active_station							= CreateElement "ceStringPoly"
maverick_active_station.name					= "maverick_active_station"
maverick_active_station.alignment				= "LeftCenter"
maverick_active_station.formats					= {"%d"}
maverick_active_station.material				= font_MFCD
maverick_active_station.stringdefs				= txt_labels_font
maverick_active_station.controllers				= {{"declutter"}, {"maverick_active_station"}}
maverick_active_station.UseBackground			= true
maverick_active_station.BackgroundMaterial		= MFCD_SOLID_BLACK
maverick_active_station.init_pos				= {10, 525, 0}
SetLowerLeftCornerOrigin(maverick_active_station)
Add(maverick_active_station)
use_mipfilter(maverick_active_station)


maverick_DSMS_current_profile						= CreateElement "ceStringPoly"
maverick_DSMS_current_profile.name					= "maverick_DSMS_current_profile"
maverick_DSMS_current_profile.alignment				= "LeftCenter"
maverick_DSMS_current_profile.formats				= {"%s"}
maverick_DSMS_current_profile.material				= font_MFCD
maverick_DSMS_current_profile.stringdefs			= txt_labels_font
maverick_DSMS_current_profile.controllers			= {{"declutter"}, {"maverick_DSMS_current_profile_name",0}}
maverick_DSMS_current_profile.UseBackground			= true
maverick_DSMS_current_profile.BackgroundMaterial	= MFCD_SOLID_BLACK
maverick_DSMS_current_profile.init_pos				= {10,545,0}
SetLowerLeftCornerOrigin(maverick_DSMS_current_profile)
Add(maverick_DSMS_current_profile)
use_mipfilter(maverick_DSMS_current_profile)

add_dummy_boxes({1, 2, 3, 4, 5})

labels_6 							= add_OSB_label(6, ROTARY)

labels_6_text						= default_label_text(6, true)
labels_6_text.value					= "EO\nOFF"
labels_6_text.parent_element        = labels_6.name 
labels_6_text.controllers           = {{"maverick_power_on",-1}}

labels_6_text_2						= Copy(labels_6_text)
labels_6_text_2.value				= "EO\nON"
labels_6_text_2.controllers         = {{"maverick_power_on"}}
Add(labels_6_text_2)

add_osb_static_hint(6 ,_("Maverick EO Power On/Off"))

labels_7 							= add_OSB_label(7, ROTARY)
--labels_7.controllers				= {--[[{"mav_adjustment_is_avail", 1},--]]{"declutter"},{"locked_OSB_status",7 -1,-1}}

labels_7_text 						= default_label_text(7, true)
labels_7_text.value					= "ADJ\nON"
labels_7_text.controllers 			= {{"maverick_adjustment"},{"declutter"}}
shift_button_pos(labels_7_text, 7, 0, 0)

labels_7_text_2 					= Copy(labels_7_text)
labels_7_text_2.value				= "ADJ\nOFF"
labels_7_text_2.controllers			= {{"maverick_adjustment", -1},{"declutter"}}
Add(labels_7_text_2)

add_osb_static_hint(7 , _("Maverick Adjustment On/Off"))

labels_8 							= add_OSB_label(8, DATA_ENTRY)

labels_8_text 						= default_label_text(8, true)
labels_8_text.formats				= {"SLEW\n%.1f"}
labels_8_text.parent_element		= labels_8.name
labels_8_text.controllers 			= {{"maverick_slew_magnifier",0}}

add_osb_static_hint(8, _("Adjust Maverick Slew Sensitivity"))

addOSB_Box(6, {labels_6,labels_6_text,labels_6_text_2})
addOSB_Box(7, {labels_7,labels_7_text,labels_7_text_2})
addOSB_Box(8, {labels_8,labels_8_text})

add_dummy_boxes({9, 10})

--[[
	MAVERICK_NO_MAVERICK,				
	MAVERICK_POWER_OFF,
	MAVERICK_POWERING_OFF,				
	MAVERICK_ALIGN,				
	MAVERICK_MASTER_ARM_SAFE,
	MAVERICK_WORK,
	MAVERICK_SEEKER_BORESIGHT,
	MAVERICK_FLAPS,					
	MAVERICK_GIMBAL_LIMITS,		
	MAVERICK_NO_TRACK_LAUNCH_INHIBITED
--]]


txt_sensor							= CreateElement "ceStringPoly"
txt_sensor.name						= "txt_sensor"
txt_sensor.material					= font_MFCD
txt_sensor.alignment				= "LeftCenter"
txt_sensor.value					= "S\nE\nN\nS\nO\nR"
txt_sensor.init_pos					= {OSB_positions[18][1] - 10,OSB_positions[18][2]}
SetLowerLeftCornerOrigin(txt_sensor)
txt_sensor.stringdefs				= predefined_fonts[2]
--txt_sensor.UseBackground			= true
--txt_sensor.BackgroundMaterial		= MFCD_SOLID_BLACK
txt_sensor.controllers              = {{"maverick_as_sensor"}}
Add(txt_sensor)
use_mipfilter(txt_sensor) 

add_dummy_boxes({16, 17, 18, 19, 20})

maverick_power_time					= CreateElement "ceStringPoly"
maverick_power_time.name			= "maverick_power_time"
maverick_power_time.material		= font_MFCD
maverick_power_time.UseBackground	= true
maverick_power_time.BackgroundMaterial		= MFCD_SOLID_BLACK
shift_button_pos(maverick_power_time, 10, -10, -87)
maverick_power_time.alignment		= "RightCenter"
maverick_power_time.stringdefs		= predefined_fonts[1]
maverick_power_time.formats 		= {" EO %02d:%02d:%02d"}
maverick_power_time.controllers     = {{"maverick_power_on"}, {"maverick_power_time",  0}}
use_mipfilter(maverick_power_time) 
Add(maverick_power_time)

frame 			     =  line_2_pixel_with_background({{-129,12},{0,12},{0,-12},{-129,-12},{-129,12}})
frame.parent_element =  maverick_power_time.name


add_maverick_dynamic_launch_zone()
Add_NOT_SOI_display()


txt_status = {}

for i = 0, 9 do
	if  i ~= 5 then
		txt_status[i]							= CreateElement "ceStringPoly"
		txt_status[i].name						= "txt_STATUS" ..i
		txt_status[i].material					= font_MFCD
		txt_status[i].alignment					= "CenterCenter"
		txt_status[i].init_pos					= {max_pixels_count/2,OSB_positions[19][2] + (OSB_positions[20][2] - OSB_positions[19][2])*0.5,0}
		SetLowerLeftCornerOrigin(txt_status[i])
		txt_status[i].stringdefs				= predefined_fonts[3]
		txt_status[i].UseBackground				= true
		txt_status[i].BackgroundMaterial		= MFCD_SOLID_BLACK
		txt_status[i].controllers				= {{"maverick_status",i}}
		Add(txt_status[i])
		use_mipfilter(txt_status[i]) 
	end
end
txt_status[6].controllers	= {{"maverick_status", 6}, {"maverick_seeker_boresight_accepted", 1}}

txt_status[0].value = "NO MAVERICK"
txt_status[1].value = "OFF"
txt_status[2].UseBackground	= false -- source - video
txt_status[2].value = "POWERING OFF"
txt_status[3].value = "ALIGN"
txt_status[4].value = "MASTER ARM SAFE"
txt_status[6].value = "SEEKER BORESIGHT"
txt_status[7].value = "FLAPS"
txt_status[8].value = "GIMBAL LIMITS"
txt_status[9].value = "NO TRACK LAUNCH IHBT"


txt_status[10] 					= Copy(txt_status[6])
txt_status[10].UseBackground	= false
txt_status[10].controllers		= {{"maverick_status", 6}, {"maverick_seeker_boresight_accepted", 0}}
Add(txt_status[10])


