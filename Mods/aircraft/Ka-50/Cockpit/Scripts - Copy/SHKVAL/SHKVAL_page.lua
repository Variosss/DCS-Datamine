dofile(LockOn_Options.script_path.."SHKVAL\\SHKVAL_usefull_definitions.lua")

local delta_H			=  0.43/(35/57.3)
local delta_V			= (1.25 - 0.012 - 0.194)/(85/57.3)

camera_lim_V            = CreateElement "ceTexPoly"
camera_lim_V.name       = "camera_lim_V"
camera_lim_V.vertices   = {{-0.03, -1.25}, {-0.03, 0.012}, {0.04, 0.012}, {0.04, -1.25}}
camera_lim_V.indices    = {0, 1, 2, 0, 2, 3}
camera_lim_V.init_pos	= {-0.9, 0.611, 0}
camera_lim_V.material   = "INDICATION_SHKVAL-V_KA50"
SetScreenSpace(camera_lim_V)
SetScreenSpaceTexParams(camera_lim_V,0.02049 * X_texmultiplier, 0.01052)
camera_lim_V.controllers = {{"limits_control",5.0/57.3},{"indication_inverted",0,0,0}}
Add(camera_lim_V)

camera_lim_index_V            = CreateElement "ceTexPoly"
camera_lim_index_V.name       = "camera_lim_index_V"
camera_lim_index_V.vertices   = {{-0.02, -0.045}, {-0.02, 0.045}, {0.065, 0.045}, {0.065, -0.045}}
camera_lim_index_V.indices    = {0, 1, 2, 0, 2, 3}
camera_lim_index_V.init_pos	  = {0.028,-0.194,0}
camera_lim_index_V.material   = "INDICATION_SHKVAL-V_KA50"
camera_lim_index_V.controllers = {{"view_angle",delta_V,0},{"indication_inverted",0,0,0}}
camera_lim_index_V.parent_element = "camera_lim_V"
SetScreenSpace(camera_lim_index_V)
SetScreenSpaceTexParams(camera_lim_index_V,0.0144 * X_texmultiplier, 0.64729)
Add(camera_lim_index_V)

camera_lim_H            = CreateElement "ceTexPoly"
camera_lim_H.name       = "camera_lim_H"
camera_lim_H.vertices   = {{-0.43, -0.037}, {-0.43, 0.035}, {0.43, 0.035}, {0.43, -0.037}}
camera_lim_H.indices    = {0, 1, 2, 0, 2, 3}
camera_lim_H.init_pos	= {0.0, 0.74,0}
camera_lim_H.material   = "INDICATION_SHKVAL-V_KA50"
SetScreenSpace(camera_lim_H)
SetScreenSpaceTexParams(camera_lim_H,0.21373 * X_texmultiplier, 0.97785)
camera_lim_H.controllers = {{"limits_control",5.0/57.3},{"indication_inverted",0,0,0}}
Add(camera_lim_H)

gun_lim_H            	 = CreateElement "ceMeshPoly"
gun_lim_H.primitivetype  = "triangles"
gun_lim_H.name       	 = "gun_lim_H"
gun_lim_H.vertices   	 = {{-2.5*delta_H/57.3, 0},
							{-2.5*delta_H/57.3, 0.035},
							{   9*delta_H/57.3, 0.035},
							{   9*delta_H/57.3, 0}}
gun_lim_H.indices  		 = {0, 1, 2, 0, 2, 3}
gun_lim_H.material       = "LIGHT_GREY"
gun_lim_H.parent_element = "camera_lim_H"
SetScreenSpace(gun_lim_H)
gun_lim_H.controllers = {{"cannon_uncaged"},{"indication_inverted",0,0,0}}
Add(gun_lim_H)

gun_lim_V            	 = CreateElement "ceMeshPoly"
gun_lim_V.primitivetype  = "triangles"
gun_lim_V.name       	 = "gun_lim_V"
gun_lim_V.vertices   	 = {{-0.035,3.5*delta_V/57.3},
							{-0.035,-37*delta_V/57.3},
							{ 0	   ,-37*delta_V/57.3},
							{ 0	   ,3.5*delta_V/57.3}}
gun_lim_V.indices  		 = {0, 1, 2, 0, 2, 3}
gun_lim_V.init_pos       = {0,-0.194,0}
gun_lim_V.material       = "LIGHT_GREY"
gun_lim_V.parent_element = "camera_lim_V"
SetScreenSpace(gun_lim_V)
gun_lim_V.controllers = {{"cannon_uncaged"},{"indication_inverted",0,0,0}}
Add(gun_lim_V)

camera_lim_index_H            = CreateElement "ceTexPoly"
camera_lim_index_H.name       = "camera_lim_index_H"
camera_lim_index_H.vertices   = {{-0.04, -0.055}, {-0.04, 0.02}, {0.04, 0.02}, {0.04, -0.055}}
camera_lim_index_H.indices    = {0, 1, 2, 0, 2, 3}
camera_lim_index_H.init_pos	  = {0.0, -0.028, 0}
camera_lim_index_H.material   = "INDICATION_SHKVAL-V_KA50"
camera_lim_index_H.controllers = {{"view_angle",0,delta_H},{"indication_inverted",0,0,0}} --0.0653/GetScale()}}
camera_lim_index_H.parent_element = "camera_lim_H"
SetScreenSpace(camera_lim_index_H)
SetScreenSpaceTexParams(camera_lim_index_H,0.10133 * X_texmultiplier, 0.63898)
Add(camera_lim_index_H)


local narrow_fov_ = 7/23
local texture_size_x = 256
local texture_size_y = 512

function texture_box(UL_X,UL_Y,DR_X,DR_Y)
	local ULX = UL_X / texture_size_x
	local ULY = UL_Y / texture_size_y
	local DRX = DR_X / texture_size_x
	local DRY = DR_Y / texture_size_y
	return  {{ULX, ULY},
			 {DRX, ULY},
			 {DRX, DRY},
			 {ULX, DRY}}
end

narrow_cam_border            		= CreateElement "ceTexPoly"
narrow_cam_border.name       		= "narrow_cam_border"
narrow_cam_border.material   		= "INDICATION_SHKVAL-V_KA50"
narrow_cam_border.controllers	  	= {{"zoom_control"},{"indication_inverted",0,0,0}}
narrow_cam_border.vertices   		=  {{-narrow_fov_, narrow_fov_},
										{ narrow_fov_, narrow_fov_},
										{ narrow_fov_,-narrow_fov_},
										{-narrow_fov_,-narrow_fov_}}	
narrow_cam_border.indices    		= {0, 1, 2, 0, 2, 3}
narrow_cam_border.tex_coords	    = texture_box(12,350,180,489)							
SetScreenSpace(narrow_cam_border)
Add(narrow_cam_border)

plane_symbol            = CreateElement "ceTexPoly"
plane_symbol.name       = "plane_symbol"
plane_symbol.vertices   =  {{-tex_scale*0.017578125, 2*tex_scale*0.1767578125},
							{ tex_scale*0.017578125, 2*tex_scale*0.1767578125},
							{ tex_scale*0.017578125,-2*tex_scale*0.1767578125},
							{-tex_scale*0.017578125,-2*tex_scale*0.1767578125}}
plane_symbol.indices    = {0, 1, 2, 0, 2, 3}
plane_symbol.init_pos	= {0,0,0}
plane_symbol.init_rot	= {90.0, 0.0, 0.0}
plane_symbol.material   = "INDICATION_SHKVAL-V_KA50"
plane_symbol.tex_params = {0.779296875,0.7490234375,tex_scale ,0.5*tex_scale} -- tex_scale, tex_scale * Y_scalemultiplier}
plane_symbol.controllers = {{"scales_reject"}, {"indication_inverted", 0, 0, 0}}
SetScreenSpace(plane_symbol)
SetScreenSpaceTexParams(plane_symbol,0.779296875,0.7490234375)
Add(plane_symbol)

pitch_bank_line            = CreateElement "ceTexPoly"
pitch_bank_line.name       = "pitch_bank_line"
pitch_bank_line.vertices   = {{-0.02, -0.76}, {-0.02, 0.76}, {0.02, 0.76}, {0.02, -0.76}}
pitch_bank_line.indices    = {0, 1, 2, 0, 2, 3}
pitch_bank_line.init_pos   = {0,0,0}
pitch_bank_line.init_rot   = {90.0, 0.0, 0.0}
pitch_bank_line.material   = "INDICATION_SHKVAL-V_KA50"
pitch_bank_line.tex_params = {0.42082 * X_texmultiplier, 0.5598, tex_scale, tex_scale * Y_scalemultiplier}
pitch_bank_line.controllers	  = {{"scales_reject"}, {"roll_control"}, {"pitch_control",-0.2}, {"indication_inverted", 0, 0, 0}}
SetScreenSpace(pitch_bank_line)
SetScreenSpaceTexParams(pitch_bank_line,0.42082 * X_texmultiplier, 0.5598)
Add(pitch_bank_line)

ralt_scale            = CreateElement "ceTexPoly"
ralt_scale.name       = "ralt_scale"
ralt_scale.vertices   = {{-0.07, -0.658},
                         {-0.07,  0.02}, 
						 { 0.064, 0.02},
						 { 0.064,-0.658}}
ralt_scale.indices    = {0, 1, 2, 0, 2, 3}
ralt_scale.init_pos   = {0.9,-0.105, 0}
ralt_scale.material   = "INDICATION_SHKVAL-V_KA50"
ralt_scale.controllers  = {{"radioalt_control",0,50.0},{"indication_inverted",0,0,0}}
SetScreenSpace(ralt_scale)
SetScreenSpaceTexParams(ralt_scale,39/256,150/512)
Add(ralt_scale)

ralt_scale_index              = CreateElement "ceTexPoly"
ralt_scale_index.name         = "ralt_scale_index"
ralt_scale_index.vertices     = {{-0.065, -0.045}, {-0.065, 0.045}, {0.02, 0.045}, {0.02, -0.045}}
ralt_scale_index.indices      = {0, 1, 2, 0, 2, 3}
ralt_scale_index.init_pos	  = {0,-0.645,0}
ralt_scale_index.material     = "INDICATION_SHKVAL-V_KA50"
ralt_scale_index.controllers  = {{"radioalt_control",0.658/50,50},{"indication_inverted",0,0,0}}
ralt_scale_index.parent_element = "ralt_scale"
SetScreenSpace(ralt_scale_index)
SetScreenSpaceTexParams(ralt_scale_index,0.07032 * X_texmultiplier, 0.64729)
Add(ralt_scale_index)

txt_IAS = CreateElement "ceStringPoly"
txt_IAS.name            = "txt_IAS"
txt_IAS.material        = "font_Ka-50_SHKVAL"
txt_IAS.init_pos		= {-0.83, 0.64, 0}
txt_IAS.alignment       = "LeftCenter"
txt_IAS.stringdefs      = {0.007, 0.007, 0.05 * 0.01, 0.05 * 0.01}
txt_IAS.formats         = {"%+04.f"}
txt_IAS.controllers     = {{"txt_IAS",0, -999.0, 999.0},{"indication_inverted",0,0,0}}
SetScreenSpace(txt_IAS)
Add(txt_IAS)

txt_TG_symbol					= CreateElement "ceStringPoly"
txt_TG_symbol.name				= "txt_TG_symbol"
txt_TG_symbol.material			= "font_Ka-50_SHKVAL"
txt_TG_symbol.init_pos			= {-0.295, 0.27, 0}
txt_TG_symbol.value				= "ТГ"
txt_TG_symbol.alignment			= "LeftCenter"
txt_TG_symbol.stringdefs		= {0.01, 0.01, -0.04 * 0.01, 0.05 * 0.01}
txt_TG_symbol.controllers       = {{"mode_control",2},{"indication_inverted",0,0,0}}
SetScreenSpace(txt_TG_symbol)
Add(txt_TG_symbol)

txt_TA_symbol					= CreateElement "ceStringPoly"
txt_TA_symbol.name				= "txt_TA_symbol"
txt_TA_symbol.material			= "font_Ka-50_SHKVAL"
txt_TA_symbol.init_pos			= {0.285, 0.27, 0}
txt_TA_symbol.value				= "ТA"
txt_TA_symbol.alignment			= "RightCenter"
txt_TA_symbol.stringdefs		= {0.01, 0.01, -0.04 * 0.01, 0.05 * 0.01}
txt_TA_symbol.controllers       = {{"mode_control",3},{"indication_inverted",0,0,0}}
SetScreenSpace(txt_TA_symbol)
Add(txt_TA_symbol)

txt_P_symbol					= CreateElement "ceStringPoly"
txt_P_symbol.name				= "txt_P_symbol"
txt_P_symbol.material			= "font_Ka-50_SHKVAL"
txt_P_symbol.init_pos			= {0.285, 0.27, 0}
txt_P_symbol.value				= "П"
txt_P_symbol.alignment			= "RightCenter"
txt_P_symbol.stringdefs			= {0.01, 0.01, -0.04 * 0.01, 0.05 * 0.01}
txt_P_symbol.controllers        = {{"mode_control",4},{"indication_inverted",0,0,0}}
SetScreenSpace(txt_P_symbol)
Add(txt_P_symbol)


SHKVAL_border				  = CreateElement "ceMeshPoly"
SHKVAL_border.name			  = "SHKVAL_border"
SHKVAL_border.primitivetype   = "triangles"
SHKVAL_border.vertices		  = {{-1, 1}, {1, 1}, {1, -1}, {-1, -1}}
SHKVAL_border.indices		  = {0, 1, 2, 0, 2, 3}
SHKVAL_border.material		  = "SHKVAL_RECT"
SHKVAL_border.h_clip_relation = h_clip_relations.REWRITE_LEVEL
SHKVAL_border.level			  = DEFAULT_LEVEL + 1
SHKVAL_border.isdraw		  = true
SHKVAL_border.isvisible       = false
SetScreenSpace(SHKVAL_border)
Add(SHKVAL_border);

txt_V_H						= CreateElement "ceStringPoly"
txt_V_H.name				= "txt_V_H"
txt_V_H.material			= "font_Ka-50_SHKVAL"
txt_V_H.init_pos			= {-0.717, -0.67, 0}
txt_V_H.alignment			= "LeftCenter"
txt_V_H.stringdefs			= {0.01, 0.01, -0.04 * 0.01, 0.05 * 0.01}
txt_V_H.controllers			= {{"CautionsBlink"}, {"txt_V_H"}, {"indication_inverted", 0, 0, 0}}
SetScreenSpace(txt_V_H)
Add(txt_V_H)

txt_range					= CreateElement "ceStringPoly"
txt_range.name				= "txt_range"
txt_range.material			= "font_Ka-50_SHKVAL"
txt_range.init_pos			= {0, -0.67, 0}
txt_range.alignment			= "CenterCenter"
txt_range.stringdefs		= {0.01, 0.01, -0.04 * 0.01, 0.05 * 0.01}
txt_range.formats           = {"%.1f"}
txt_range.controllers		= {{"target_range",0,0.001},{"indication_inverted", 0, 0, 0}}
SetScreenSpace(txt_range)
Add(txt_range)

txt_C					= CreateElement "ceStringPoly"
txt_C.name				= "txt_range_C"
txt_C.material			= "font_Ka-50_SHKVAL"
txt_C.init_pos			= {0, -0.47, 0}
txt_C.alignment			= "CenterCenter"
txt_C.stringdefs		= {0.01, 0.01, -0.04 * 0.01, 0.05 * 0.01}
txt_C.value          	= "С"
txt_C.controllers		= {{"launch_authorized"},{"indication_inverted", 0, 0, 0}}
SetScreenSpace(txt_C)
Add(txt_C)

--add_frame()


AddFrameBlock(-1,  5,false,2)
AddFrameBlock( 4,100,true ,1)

--add_dbg_aim_point()

local cross_start_x   = 124/256
local cross_start_y   = 230/512
local cross_size_x    = (124 - 57)/256
local cross_size_y    = (230 - 148)/512




break_cross            = CreateElement "ceTexPoly"
break_cross.name       = "break_cross"
break_cross.vertices   = {{-cross_size_x , -cross_size_y / Y_scalemultiplier },
						  {-cross_size_x ,  cross_size_y / Y_scalemultiplier },
						  { cross_size_x ,  cross_size_y / Y_scalemultiplier  },
						  { cross_size_x , -cross_size_y / Y_scalemultiplier  }}
break_cross.indices    = {0, 1, 2, 0, 2, 3}
break_cross.material   = "INDICATION_SHKVAL-V_KA50"
break_cross.controllers = {{"indication_inverted",0,0,0},{"it_cross"}}
SetScreenSpace(break_cross)
SetScreenSpaceTexParams(break_cross,cross_start_x,cross_start_y)
Add(break_cross)
