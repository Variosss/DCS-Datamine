dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")


labels = {}
for i = 11, 14 do
	labels[i]						= CreateElement "ceStringPoly"
	labels[i].name					= "label_"..string.format("%d",i)
	labels[i].material				= font_MFCD
	labels[i].UseBackground			= true
	labels[i].BackgroundMaterial	= MFCD_SOLID_BLACK
	labels[i].alignment				= "CenterTop"
	labels[i].value					= ""
	labels[i].formats               = {"%s"}
	labels[i].stringdefs			= txt_labels_font
	SetLowerLeftCornerOrigin(labels[i])
	labels[i].init_pos              = {OSB_positions[i + 1][1],soi_min_y + 2}
	labels[i].controllers			= {{"DPP_OSB_label",0,i},
									   {"txt_color_current_mode" ,i}}
	Add(labels[i])
	use_mipfilter(labels[i])
	
	addOSB_Box(i + 1, {labels[i]})
end


label_declutter						= CreateElement "ceStringPoly"
label_declutter.name				= "declutter"
label_declutter.material			= font_MFCD
label_declutter.UseBackground		= true
label_declutter.BackgroundMaterial	= MFCD_SOLID_BLACK
label_declutter.alignment			= "CenterTop"
label_declutter.value				= "DCLT"
label_declutter.stringdefs			= txt_labels_font
SetLowerLeftCornerOrigin(label_declutter)
label_declutter.init_pos            = {OSB_positions[11][1],soi_min_y + 2}
label_declutter.controllers 		= {{"locked_OSB_status",10,-1},
									   {"message_acknowledge", 0},
								       {"txt_color_declutter"}}
Add(label_declutter)
use_mipfilter(label_declutter)
	
label_acknowledge               = Copy(label_declutter)
label_acknowledge.value         = "ACK"
label_acknowledge.controllers   =  {{"locked_OSB_status", 10, -1},
									{"message_acknowledge"}}
Add(label_acknowledge)

addOSB_Box(11, {label_declutter,label_acknowledge})


add_attitude_reference_symbol()

hints_osb        = {}
local fmt = _("Go to %s page")

for osb = 12,15  do
	local nm = "OSB_"..string.format("%02d",osb)
	hints_osb[osb] 				  = CreateElement  "ceHint"
	hints_osb[osb].hint_name      = hint_name[nm]
	hints_osb[osb].controllers	  = {{"dpp_magic_button_hint",0,osb - 1}}
	hints_osb[osb].formats        = {fmt}
	Add(hints_osb[osb])
end

add_osb_hint_controllers(11, _("Declutter (WCN Acknowledge)"), {{"locked_OSB_status",10,-1}})

--AddGrid("DBG_GREY",25)

dofile(LockOn_Options.script_path.."MFCD\\indicator\\MFCD_WCN.lua")

function AddGrid__()
	local verts       = {{0,0},
						 {max_pixels_count,0},
						 {max_pixels_count,max_pixels_count},
						 {0,max_pixels_count}}
	local indices     = {0,1,2,0,2,3}
	local grid			= CreateElement "ceTexPoly"
	grid.material	    = MakeMaterial(LockOn_Options.script_path.."../IndicationTextures/grid.tga",{0,0,0,120})
	grid.vertices       = verts
	grid.indices	    = indices
	grid.init_pos 		= {-max_pixels_count/2,-max_pixels_count/2}
	grid.tex_params     = {0,0,0.1,0.1}
	use_mipfilter(grid)
	Add(grid)
	return grid
end

function AddButtonPositionReference()

	local verts       = {{-10,0},
						 { 10,0},
						 { 0,-10},
						 { 0, 10}}
	local indices     = {0,1,2,3}
	for i = 1,20 do
		local obj	       = CreateElement "ceMeshPoly"
		obj.material	   = MakeMaterial(nil,{255,120,0,255})
		obj.primitivetype  = "lines"
		obj.vertices       = verts
		obj.indices	       = indices
		shift_button_pos(obj,i)
		Add(obj)
	end
end

function AddButtonPositionReference2()

	local verts       = {{-10,0},
						 { 10,0},
						 { 0,-10},
						 { 0, 10}}
	local indices     = {0,1,2,3}
	for i = 1,20 do
		local obj	       = CreateElement "ceMeshPoly"
		obj.material	   = MakeMaterial(nil,{120,255,0,255})
		obj.primitivetype  = "lines"
		obj.vertices       = verts
		obj.indices	       = indices
		shift_button_pos_2(obj,i)
		Add(obj)
	end
end

--AddButtonPositionReference()
--AddButtonPositionReference2()
--AddGrid__()


function AddBrightnessControl()
	local size_x   = 135
	local row_size = 56
	local size_y   = row_size * 3
	local shift_y  = size_y * 0.5 + 15
	
	local elm_back               = CreateElement "ceMeshPoly"
		  elm_back.primitivetype = "triangles"
		  elm_back.material	     = MFCD_SOLID_GREY
		  elm_back.vertices      = {{-0.5 * size_x , 0.5 * size_y},
									{ 0.5 * size_x , 0.5 * size_y},
									{ 0.5 * size_x ,-0.5 * size_y},
									{-0.5 * size_x ,-0.5 * size_y}}
		  elm_back.indices       = box_ind
		  SetLowerLeftCornerOrigin(elm_back)
		  elm_back.init_pos      = {max_pixels_count/2,max_pixels_count/2 + shift_y}	  
		  elm_back.controllers    = {{"BRT_CON_SYM_is_displayed", 3}} -- 3 seconds timeout
		  Add(elm_back)
		  use_mipfilter(elm_back)
		  
	local elm_header               		= CreateElement "ceStringPoly"
		  elm_header.material           = font_MFCD_BLACK
  		  elm_header.alignment          = "LeftCenter"
		  elm_header.stringdefs         = predefined_fonts[4]
		  elm_header.parent_element     = elm_back.name
		  elm_header.value 			    = " B\n C\n S"
		  use_mipfilter(elm_header)
		  Add(elm_header)
		  
	local elm_value               	   = CreateElement "ceStringPoly"
		  elm_value.material           = font_MFCD_BLACK
  		  elm_value.alignment          = "LeftCenter"
		  elm_value.stringdefs         = predefined_fonts[4]
		  elm_value.parent_element     = elm_back.name
		  elm_value.init_pos		   = {}
		  elm_value.formats 		   = {"%d\n","%d\n","%d"}
		  elm_value.controllers        = {{"brightness_video_value"    ,0},
									      {"contrast_video_value"      ,1},
										  {"brightness_symbology_value",2}}
	      elm_value.init_pos		   = {-54,0}
		  use_mipfilter(elm_value)
		  Add(elm_value)	  
end


AddBrightnessControl()
