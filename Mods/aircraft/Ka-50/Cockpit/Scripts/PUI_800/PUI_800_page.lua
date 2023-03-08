dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(FOV) -- set scale factor modifier (in this case FOV - half of horizontal size)

--[[
  SetScale(MILLYRADIANS)
	next elements will be scaled in millyrads
  SetScale(METERS)
        next elements will be scaled in meters
  SetScale(FOV)
        and again in FOV parts
--]]

vertical_size = 0.011
horizontal_size = 0.011
vertical_offset =  0.012
depth_offset  = 0.003/GetScale()
--[[
txt_weap_type			  = CreateElement "ceStringPoly"
txt_weap_type.name        = "txt_weap_type"
txt_weap_type.material    = "font_PUI_800"
txt_weap_type.init_pos	  = {-0.75, vertical_offset, 0.0}
txt_weap_type.alignment   = "LeftCenter"
txt_weap_type.formats     = {"НР", "ПС", "A6", "ПП"}
txt_weap_type.stringdefs  = {horizontal_size, vertical_size, 0.0, 0.0}
txt_weap_type.controllers = {{"current_weapon_type", 0, 1, 2, 3}}
Add(txt_weap_type)
--]]

local SYMBOL_WIDTH    = 0.0075
local SYMBOL_HEIGHT   = 0.013
local FONT_SYMBOL_W_K = 0.8203125
local FONT_SYMBOL_H_K = 1.015625
local SPACING		  = 0.0022

local function MakeStringPoly(name)
local txt			= CreateElement "ceStringPoly"
	if name then
		txt.name       		= name
	end
	txt.material   		= "font_PUI_800"
	txt.alignment  		= "LeftCenter"
	txt.stringdefs 		= {SYMBOL_HEIGHT / FONT_SYMBOL_H_K , SYMBOL_WIDTH / FONT_SYMBOL_W_K,SPACING, 0.0}
	txt.formats			= {"%02u"}
	--txt.parent_element  = base.name
	
	--txt.UseBackground		= true
	--txt.BackgroundMaterial  = MakeMaterial("",{100,0,0,255})
	Add(txt)
	return txt
end

local wepon_type_pos				= {-0.59, vertical_offset, depth_offset}

txt_weap_type_RT			 		= MakeStringPoly("txt_weap_type_RT")
txt_weap_type_RT.init_pos	 		= wepon_type_pos
txt_weap_type_RT.value		 		= "НР"
txt_weap_type_RT.controllers 		= {{"weapon_type", 1}}

txt_weap_type_AT			 		= MakeStringPoly("txt_weap_type_AT")
txt_weap_type_AT.init_pos			= wepon_type_pos
txt_weap_type_AT.value		 		= "ПС"
txt_weap_type_AT.controllers 		= {{"weapon_type", 2}}

txt_weap_type_Iron_Bomb			    = MakeStringPoly("txt_weap_type_Iron_Bomb")
txt_weap_type_Iron_Bomb.init_pos	= wepon_type_pos
txt_weap_type_Iron_Bomb.value		= "A6"
txt_weap_type_Iron_Bomb.controllers = {{"weapon_type", 3}}

txt_weap_type_Gun_Pod			 	= MakeStringPoly("txt_weap_type_Gun_Pod")
txt_weap_type_Gun_Pod.init_pos	 	= wepon_type_pos
txt_weap_type_Gun_Pod.value		 	= "ПП"
txt_weap_type_Gun_Pod.controllers	= {{"weapon_type", 4}}

txt_weap_count						= MakeStringPoly("txt_weap_count")
txt_weap_count.init_pos				= {0.092, vertical_offset, depth_offset}
txt_weap_count.controllers			= {{"weapon_count", 0, 99}}

txt_cannon_count					= MakeStringPoly("txt_cannon_count")
txt_cannon_count.init_pos			= {0.6, vertical_offset, depth_offset}
txt_cannon_count.controllers		= {{"cannon_count", 0, 99}}

local test = false
if test then
	txt_weap_type_RT.controllers 		= {}
	txt_weap_count.controllers			= {}
	txt_cannon_count.controllers		= {}
	
	txt_cannon_count.value 				= "32"
	txt_weap_count.value 				= "88"
end
