dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SIGHT_DEFAULT_LEVEL 	= 8
SIGHT_NO_CLIP 			= SIGHT_DEFAULT_LEVEL + 1

HALF_W        = 1
HALF_H        = HALF_W * GetAspect()

FOV_RADIUS 	  = 0.98 * HALF_H

SetScale(FOV)

local base 				= CreateElement "ceSimple"
base.controllers        = {{"tv_control"},{"vr_size_control"}}
Add(base)


local AREA_BOX_VERTS = {{-HALF_W,  HALF_H}, 
						{ HALF_W,  HALF_H},
						{ HALF_W, -HALF_H}, 
						{-HALF_W, -HALF_H}}
						
						
if LockOn_Options.screen.oculus_rift then

AREA_BOX_VERTS = 	   {{-8 * HALF_W,  8 * HALF_H}, 
						{ 8 * HALF_W,  8 * HALF_H},
						{ 8 * HALF_W, -8 * HALF_H}, 
						{-8 * HALF_W, -8 * HALF_H}}
end

baseFrame                                       = CreateElement "ceMeshPoly"
baseFrame.name                                  = "baseFrame"
baseFrame.primitivetype                         = "triangles"
baseFrame.material                              = "BRIGHTNESS_MASK_BLACK"
baseFrame.vertices                  			 = AREA_BOX_VERTS
baseFrame.indices			                     = default_box_indices
baseFrame.parent_element						 = base.name
baseFrame.h_clip_relation 						 = h_clip_relations.REWRITE_LEVEL
baseFrame.level			 					 	= SIGHT_NO_CLIP
baseFrame.use_mipfilter 						= true
baseFrame.isvisible 							= false
Add(baseFrame)


-------------------------------------------------------------------------------------------
FOV_BOX = {{-FOV_RADIUS,  FOV_RADIUS},
		   { FOV_RADIUS,  FOV_RADIUS}, 
		   { FOV_RADIUS, -FOV_RADIUS},
		   {-FOV_RADIUS, -FOV_RADIUS}}

num_points = 64
step = math.rad(360.0/num_points)

verts = {}
for i = 1, num_points do
	verts[i] = {FOV_RADIUS * math.cos(i * step), FOV_RADIUS * math.sin(i * step)}
end


inds = {}
j = 0
for i = 0, 61 do
	j = j + 1
	inds[j] = 0
	j = j + 1
	inds[j] = i + 1
	j = j + 1
	inds[j] = i + 2
end
----------------------------------------------------------------------------------------

local whole_texture 	= {0.5, 0.5, 1 / (2 * FOV_RADIUS), 1 / (2 * FOV_RADIUS)}

frame					= CreateElement "ceMeshPoly"
frame.name				= "SCENE"
frame.vertices			= verts
frame.indices			= inds
frame.tex_params		= whole_texture
frame.material         = "RED_TRANSPARENT"
frame.parent_element    = base.name
frame.h_clip_relation   = h_clip_relations.DECREASE_IF_LEVEL
frame.level				= SIGHT_NO_CLIP
frame.controllers       = {{"camera_on"}}
frame.isvisible 		= false
Add(frame)
-----------------------------------------------------------------------------------------


frame1                                       = CreateElement "ceMeshPoly"
frame1.name                                  = "fr1"
frame1.primitivetype                         = "triangles"
frame1.material                              = "BLACK_IND"
frame1.vertices                  			 = AREA_BOX_VERTS
frame1.indices			                     = default_box_indices
frame1.parent_element						 = base.name
frame1.controllers                           = {{"black_frame"}}
frame1.h_clip_relation 						 = h_clip_relations.INCREASE_IF_LEVEL
frame1.level			 					 = SIGHT_NO_CLIP
frame1.use_mipfilter 						 = true
Add(frame1)


local font_scale_factor = GetScale() * GetAspect();

local function  font_defs(fh,fw)
	
	return {fh * font_scale_factor, (fw or fh) * font_scale_factor,0,0}

end

local  tips_pos_1 		 = HALF_W - 0.05
local  tips_pos_2 		 = HALF_W - 0.05



txt_NABLTips                 = CreateElement "ceStringPoly"
txt_NABLTips.name            = "txt_NABLTips"
txt_NABLTips.material        = "font_general"
txt_NABLTips.alignment       = "CenterCenter"
txt_NABLTips.stringdefs      = font_defs(0.05)
txt_NABLTips.level			 = SIGHT_NO_CLIP + 1
txt_NABLTips.h_clip_relation = h_clip_relations.COMPARE
txt_NABLTips.value           = "OPEN SIGHT DOORS"
txt_NABLTips.parent_element  = frame1.name
Add(txt_NABLTips)

------------------------------------------------------------------------------

local function makeOverlay(name , material , controllers)

	local elem 				= CreateElement "ceTexPoly"
	elem.name				= name
	elem.material         	= material
	elem.vertices         	= FOV_BOX
	elem.indices		  	= default_box_indices
	elem.z_enabled 			= false
	elem.h_clip_relation	= h_clip_relations.COMPARE
	elem.level				= SIGHT_DEFAULT_LEVEL
	elem.tex_params 		= whole_texture
	elem.parent_element   	= frame.name
	elem.additive_alpha		= true
	elem.use_mipfilter		= true
	
	if controllers then 
		elem.controllers = controllers
	end
	
	Add(elem)
	return elem
end


BG_9k113_Orange 				= CreateElement "ceMeshPoly"
BG_9k113_Orange.name 			= "BG_9k113_Orange"
BG_9k113_Orange.primitivetype 	= "triangles"
BG_9k113_Orange.vertices 		= verts
BG_9k113_Orange.indices		    = inds
BG_9k113_Orange.material		= "ORANGE_2"
BG_9k113_Orange.h_clip_relation = h_clip_relations.COMPARE
BG_9k113_Orange.level			= SIGHT_DEFAULT_LEVEL
BG_9k113_Orange.z_enabled 		= false
BG_9k113_Orange.parent_element  = frame.name
BG_9k113_Orange.controllers     = {{"Orange_filter_9K113"}}
Add(BG_9k113_Orange)

BG_9k113_Green            		= CreateElement "ceMeshPoly"
BG_9k113_Green.name        		= "BG_9k113_Green"
BG_9k113_Green.material    		= "GREEN_2"
BG_9k113_Green.vertices    		= verts
BG_9k113_Green.indices			= inds
BG_9k113_Green.z_enabled 		= false
BG_9k113_Green.h_clip_relation	= h_clip_relations.COMPARE
BG_9k113_Green.level			= SIGHT_DEFAULT_LEVEL
BG_9k113_Green.parent_element  	= frame.name
BG_9k113_Green.controllers      = {{"Green_filter_9K113"}}
Add(BG_9k113_Green)


makeOverlay("Grid_9k113"			,"INDICATION_9K113_GRID_FIXED")

makeOverlay("Grid_10x_9k113_backlight"	,"INDICATION_9K113_GRID_10x_backlight"	,{{"Grid_9K113_rotation", 1}, {"backlight_9K113_on"}})
makeOverlay("Grid_10x_9k113"			,"INDICATION_9K113_GRID_10x"		  	,{{"Grid_9K113_rotation", 1}})
	
makeOverlay("Grid_3x_9k113_backlight","INDICATION_9K113_GRID_3x_backlight"		,{{"Grid_9K113_rotation", 0}, {"backlight_9K113_on"}})
makeOverlay("Grid_3x_9k113","INDICATION_9K113_GRID_3x"							,{{"Grid_9K113_rotation", 0}})

makeOverlay("Ready_9k113","INDICATION_9K113_READY",{{"Ready_9K113"}})

makeOverlay("BG_9k113","INDICATION_9K113_BG")
--[[
local ssize = 0.015

steering                    = CreateElement "ceStateTexPoly"
steering.vertices           = {{-ssize, -ssize}, { -ssize, ssize}, { ssize,ssize}, {ssize,-ssize}}
steering.indices            = default_box_indices
steering.material           = MakeMaterial("Bazar/Textures/AvionicsCommon/Cursors.tga",{255, 255, 0, 255})
steering.state_tex_coords   = 
{
	{{0/128.0, 49.0/128.0},{0.0/128.0, 0.0/128.0},{49.0/128.0, 0.0/128.0},{49.0/128.0, 49.0/128.0}},
	{{64.0/128.0, 56.0/128.0},{64.0/128.0, 0.0/128.0},{120.0/128.0, 0.0/128.0},{120.0/128.0, 56.0/128.0}},
	{{0.0/128.0, 120.0/128.0},{0.0/128.0, 64.0/128.0},{56.0/128.0, 64.0/128.0},{56.0/128.0, 120.0/128.0}},
	{{64.0/128.0, 120.0/128.0},{64.0/128.0, 64.0/128.0},{120.0/128.0, 64.0/128.0},{120.0/128.0, 120.0/128.0}},
}
steering.init_pos			= {0, -0.1 * FOV_RADIUS}
steering.additive_alpha     = false
steering.parent_element   	= frame.name
steering.level				= SIGHT_DEFAULT_LEVEL
steering.h_clip_relation	= h_clip_relations.COMPARE
steering.z_enabled 		 	= false
steering.controllers        = {{"draw_steering_helper", 0.66 * GetScale()}}
steering.use_mipfilter      = true
Add(steering)
]]
tex_scale = 1.0 / 1024.0
scale = 2000
local upY = 4 / scale
local leftX = 1.0 * 2  / scale
local rightX = 181.0 * 2 / scale

local	Line			= CreateElement("ceHWLine")
Line.name				= "SteeringLine"
Line.vertices			= {{-leftX, -upY}, {-leftX, upY},
						   {rightX, upY}, {rightX, -upY}}
Line.maskvertices		= {{0, -upY}, {0,upY},
						   {rightX, upY}, {rightX, -upY}}
Line.indices			= default_box_indices
Line.maxlength			= 0.4
Line.length				= 0.4
Line.material			= "INDICATION_ASP17_FLEX"
Line.tex_params			= {tex_scale * 16, tex_scale * 496.5, tex_scale * scale / 2, tex_scale * scale}
Line.init_pos			= {0.0, -0.1 * FOV_RADIUS, 0.0}
Line.init_rot			= {90.0, 0.0, 0.0}
Line.controllers    	= {{"draw_steering_helper_line", 0.0005 * GetScale(), 0.2}}
Line.parent_element		= frame.name
Line.isdraw				= true
Line.h_clip_relation	= h_clip_relations.COMPARE
Line.level				= SIGHT_DEFAULT_LEVEL
Line.additive_alpha		= true
Line.collimated			= true
Line.use_mipfilter		= true
Line.z_enabled 			= false
Add(Line)



txt_Tips                 = CreateElement "ceStringPoly"
txt_Tips.name            = "txt_Tips"
txt_Tips.material        = "font_general"
txt_Tips.init_pos		 = {tips_pos_1, -0.3}
txt_Tips.alignment       = "RightCenter"
txt_Tips.stringdefs      = font_defs(0.025)
txt_Tips.value           = "HIDE/SHOW TIPS  [LWIN+H] "
txt_Tips.parent_element  = base.name
Add(txt_Tips)


function AddHints(hintsBase, hintsScale)

	local function  line(ln,align)
		local elem 			 	   = CreateElement "ceStringPoly"
			  elem.material  	   = "font_general"
			  elem.init_pos		   =  {tips_pos_1, -0.3 + ln * 0.025 * hintsScale}
			  elem.stringdefs 	   = font_defs(0.025 * hintsScale)
			  elem.alignment       = align or "RightCenter"
			  elem.parent_element  = hintsBase.name
		return elem
	end

	txt_Zoom                 	= line(21)
	txt_Zoom.value           	= "ENLARGMENT FACTOR  [LCTRL+X]"
	Add(txt_Zoom)

	txt_Zoom_Val             	 = line(21,"LeftCenter")
	txt_Zoom_Val.formats         = {"X3", "X10"}
	txt_Zoom_Val.controllers     = {{"Zoom_Val"}}
	Add(txt_Zoom_Val)

	txt_Filter              	= line(6)
	txt_Filter.value        	= "LASER PROTECT  [RALT+G] "
	Add(txt_Filter)

	txt_Filter_Val             		= line(6,"LeftCenter")
	txt_Filter_Val.formats          = {"OFF", "ON"}
	txt_Filter_Val.controllers      = {{"Laser_Filter"}}
	Add(txt_Filter_Val)

	txt_Filter1              		= line(5)
	txt_Filter1.value       		= "FILTER ON/OFF           "
	Add(txt_Filter1)

	txt_OrangeFilter            	= line(7)
	txt_OrangeFilter.value      	= "ORANGE FILTER ON/OFF  [RALT+O] "
	Add(txt_OrangeFilter)

	txt_Filter1_Val             	= line(7,"LeftCenter")
	txt_Filter1_Val.formats         = {"OFF", "ON"}
	txt_Filter1_Val.controllers     = {{"Orange_Filter"}}
	Add(txt_Filter1_Val)
	
	
	txt_Backlight            	= line(8)
	txt_Backlight.value      	= "BACKLIGHT ON/OFF  [RCTRL+L]"
	Add(txt_Backlight)

	txt_Backlight_Val             	= line(8,"LeftCenter")
	txt_Backlight_Val.formats         = {"OFF", "ON"}
	txt_Backlight_Val.controllers     = {{"BackLight"}}
	Add(txt_Backlight_Val)


	txt_Mouse1            		= line(15)
	txt_Mouse1.value      		= "KEY CONTROL OF           "
	Add(txt_Mouse1)

	txt_Mouse2            		= line(14)
	txt_Mouse2.value      		= "VIEWING AXIS:           "
	Add(txt_Mouse2)

	txt_Mouse3            		= line(13)
	txt_Mouse3.value      		= "LEFT  [,]      "
	Add(txt_Mouse3)

	txt_Mouse4            		= line(12)
	txt_Mouse4.value      		= "RIGHT  [/]      "
	Add(txt_Mouse4)

	txt_Mouse5            		= line(11)
	txt_Mouse5.value      		= "UP  [;]      "
	Add(txt_Mouse5)

	txt_Mouse6            		= line(10)
	txt_Mouse6.value      		= "DOWN  [.]      "
	Add(txt_Mouse6)
	
	txt_ResetKnobs         		= line(9)
	txt_ResetKnobs.value   		= "KNOBS IN NEUTRAL".."  [RCTRL+I]"
	Add(txt_ResetKnobs)
	
	txt_ArrowHelper                 = line(4)
	txt_ArrowHelper.value           = "STEERING HELPER  [LALT+S] "
	Add(txt_ArrowHelper)

	txt_ArrowHelper_Val             	= line(4,"LeftCenter")
	txt_ArrowHelper_Val.formats         = {"OFF", "ON"}
	txt_ArrowHelper_Val.controllers     = {{"ArrowHelper_Val"}}
	Add(txt_ArrowHelper_Val)
	
	txt_LaunchKey     				= line(3)
	txt_LaunchKey.value      		= "LAUNCH MISSILE  [RCTRL+SPACE]"
	Add(txt_LaunchKey)
	
end

Hints					= CreateElement "ceSimple"
Hints.parent_element  	= base.name
Hints.controllers     	= {{"HintsOn", 1}}
Add(Hints)

AddHints(Hints, 1)

Hints_1					= CreateElement "ceSimple"
Hints_1.parent_element  = base.name
Hints_1.controllers     = {{"HintsOn", 2}}
Add(Hints_1)

AddHints(Hints_1, 1.5)
