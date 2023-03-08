dofile(LockOn_Options.script_path.."Scripts/VHF_Radio/Indicator/Main/tools.lua")

fontsize = 0.01

clip_box_in(0,0,135,160)

local grid_origin = create_origin()

--create_box(0,0,135, 155, BACKGROUND_MAT, artificial_horizon, h_clip_relations.DECREASE_IF_LEVEL ,VHF_DEFAULT_LEVEL + 1, true)

--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/nav_base_page.lua")
--dofile(LockOn_Options.script_path.."Scripts/HorizontalSituationDisplay/Indicator/nav_text_comm_page.lua")

local posx = 0 --10
local posy = 0 --20
local posz = 0 --10
local rotx = 0
local roty = 0 --5
local rotz = 0 --100

local fontb = -0.0000

-- FREQ string
local freq_string               = CreateElement "ceStringPoly"
    freq_string.name            = create_guid_string()
    freq_string.material        = VHF_DIGIT_RED --"font_NAV"
    freq_string.stringdefs      = {fontsize, fontsize, fontb, 0}
    freq_string.init_pos        = element_init_pos_shift(posx, posy, posz, 2048)
	freq_string.init_rot        = {rotx, roty, rotz}
    freq_string.alignment       = "CenterCenter"
	freq_string.parent_element  = grid_origin.name
    freq_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--freq_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	freq_string.level			= VHF_DEFAULT_LEVEL
	freq_string.use_mipfilter   = true
	freq_string.additive_alpha  = true
	freq_string.isdraw			= true
	freq_string.change_opacity	= false
	freq_string.isvisible		= true
	freq_string.collimated      = false
    --freq_string.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
    --freq_string.formats		    = {"%6.3f"}
    freq_string.controllers 	= {{"arc182freq_bright"},{"arc182freq_str",0}}
    --freq_string.value           = "028.0"
Add(freq_string)

-- FREQ DOT 
local freq_dot_string               = CreateElement "ceStringPoly"
    freq_dot_string.name            = create_guid_string()
    freq_dot_string.material        = VHF_DIGIT_RED --"font_NAV"
    freq_dot_string.stringdefs      = {fontsize, fontsize, fontb, 0}
    freq_dot_string.init_pos        = element_init_pos_shift(posx, posy, posz, 2048)
	freq_dot_string.init_rot        = {rotx, roty, rotz}
    freq_dot_string.alignment       = "CenterCenter"
	freq_dot_string.parent_element  = grid_origin.name
    freq_dot_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	freq_dot_string.level			= VHF_DEFAULT_LEVEL
	freq_dot_string.use_mipfilter   = true
	freq_dot_string.additive_alpha  = true
	freq_dot_string.isdraw			= true
	freq_dot_string.change_opacity	= false
	freq_dot_string.isvisible		= true
	freq_dot_string.collimated      = false
    freq_dot_string.controllers 	= {{"arc182freq_bright"},{"arc182dot_visible"}}
    freq_dot_string.value           = "."
Add(freq_dot_string)

-- FREQ BG string
local bg_string               = CreateElement "ceStringPoly"
    bg_string.name            = create_guid_string()
    bg_string.material        = VHF_SHADOW_RED --"font_NAV"
    bg_string.stringdefs      = {fontsize, fontsize, fontb, 0}
    bg_string.init_pos        = element_init_pos_shift(posx, posy, posz, 2048)
	bg_string.init_rot        = {rotx, roty, rotz}
    bg_string.alignment       = "CenterCenter"
	bg_string.parent_element  = grid_origin.name
    bg_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--freq_string.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
	bg_string.level	          = VHF_DEFAULT_LEVEL
	bg_string.use_mipfilter   = true
	bg_string.additive_alpha  = true
	bg_string.isdraw		  = true
	bg_string.change_opacity  = false
	bg_string.isvisible       = true
	bg_string.collimated      = false
    --bg_string.stringdefs      = {compassnrheight,compassnrwidth, 0, 0}
    bg_string.formats         = {"%6.0f"}
    bg_string.controllers     = {{"arc182bg_bright"}--[[,{"arc182bg_str",0}]]}
    bg_string.value           = "888888"
Add(bg_string)

-- BG DOT
local bg_dot_string               = CreateElement "ceStringPoly"
    bg_dot_string.name            = create_guid_string()
    bg_dot_string.material        = VHF_SHADOW_RED --"font_NAV"
    bg_dot_string.stringdefs      = {fontsize, fontsize, fontb, 0}
    bg_dot_string.init_pos        = element_init_pos_shift(posx, posy, posz, 2048)
	bg_dot_string.init_rot        = {rotx, roty, rotz}
    bg_dot_string.alignment       = "CenterCenter"
	bg_dot_string.parent_element  = grid_origin.name
    bg_dot_string.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	bg_dot_string.level			= VHF_DEFAULT_LEVEL
	bg_dot_string.use_mipfilter   = true
	bg_dot_string.additive_alpha  = true
	bg_dot_string.isdraw			= true
	bg_dot_string.change_opacity	= false
	bg_dot_string.isvisible		= true
	bg_dot_string.collimated      = false
    bg_dot_string.controllers 	= {{"arc182bg_bright"}}
    bg_dot_string.value           = "."
Add(bg_dot_string)

clip_box_out()

