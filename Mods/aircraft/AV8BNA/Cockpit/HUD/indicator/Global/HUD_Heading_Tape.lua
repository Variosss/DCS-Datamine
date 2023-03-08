-- Development vars
local DBG_RED = MakeMaterial(nil, {255,0,0,50})
local is_debug = false

-- Local vars
local hdg_y_pos		= 155.0 * MilToDI(HUD_SCALE)
local tick_y_pos	= 146.0 * MilToDI(HUD_SCALE)
local tape_y_pos	= 145.0 * MilToDI(HUD_SCALE)
local indx_y_pos	= 137.0 * MilToDI(HUD_SCALE)

local tape_hdg_factor = 2.5
local tape_hdg_displc = tape_hdg_factor / 10.0
local tick_hdg_factor = 1.25
local tick_hdg_displc = tick_hdg_factor / 5.0

local vert_horz = 71 * MilToDI(HUD_SCALE)
local vert_vert = 32 * MilToDI(HUD_SCALE)

-- Open Heading Tape Region
tape_begin          		= CreateElement "ceMeshPoly"
tape_begin.name	    		= "tape_begin"
tape_begin.vertices			= { {vert_horz, vert_vert}, { -vert_horz, vert_vert}, { -vert_horz,-vert_vert}, {vert_horz,-vert_vert}, }
tape_begin.indices			= {0,1,2 ; 0,2,3}
tape_begin.init_pos			= {0, hdg_y_pos, 0}
tape_begin.controllers		= {{"VSTOL_MasterMode"}}
tape_begin.material			= DBG_RED
tape_begin.h_clip_relation	= h_clip_relations.INCREASE_IF_LEVEL
tape_begin.level	        = HUD_DEFAULT_LEVEL
tape_begin.isvisible	    = is_debug
tape_begin.collimated	    = collimated
tape_begin.z_enabled        = false
Add(tape_begin)

-- Dynamic Elements
local i = 0
local j = 0

-- Numbers
for i = 0, 38 do

	if i == 0 then
		j = 35
	elseif i == 1 then
		j = 0
	elseif i == 37 then
		j = 0
	elseif i == 38 then
		j = 1
	elseif i > 1 then
		j = i - 1
	end

	tape_hdg					= CreateElement "ceStringSLine"
	tape_hdg.name				= "tape_hdg_" .. string.format("%02d", i)
	tape_hdg.material			= stroke_font
	tape_hdg.value				= string.format("%02d", j)
	tape_hdg.alignment			= "CenterCenter"
	tape_hdg.stringdefs			= stringdefs[STROKE_FNT_DFLT_100]
	tape_hdg.init_pos			= {0, hdg_y_pos, 0}
	tape_hdg.controllers		= {{"hud_reject_2"}, {"VSTOL_MasterMode"}, {"hud_hdg_tape", i, 1.0, tape_hdg_factor}, {"ac_hdg_main", tape_hdg_displc}} -- 
	tape_hdg.h_clip_relation	= h_clip_relations.COMPARE
	tape_hdg.level				= HUD_DEFAULT_LEVEL + 1
	tape_hdg.isvisible	    	= true
	tape_hdg.collimated	    	= collimated
	tape_hdg.use_mipfilter		= true
	tape_hdg.additive_alpha		= ALPHA_BLEND
	Add(tape_hdg)
	
	hdg_mark					= CreateElement "ceSMultiLine"
	hdg_mark.name				= "hdg_mrk_lg_" .. string.format("%02d", i)
	hdg_mark.material			= stroke_material
	hdg_mark.init_pos			= {0, tick_y_pos, 0}
	hdg_mark.points_set			= {"HUD_stroke_symbols", "hdg_mrk_lg"}
	hdg_mark.scale				= HUD_SCALE * 1.5
	hdg_mark.controllers		= {{"hud_reject_2"}, {"VSTOL_MasterMode"}, {"hud_hdg_tape", i, 1.0, tape_hdg_factor}, {"ac_hdg_main", tape_hdg_displc}} --  
	hdg_mark.alignment			= "FromSet"
	hdg_mark.thickness    		= stroke_thickness
	hdg_mark.fuzziness    		= stroke_fuzziness
	hdg_mark.isdraw				= true
	hdg_mark.draw_as_wire 		= dbg_drawStrokesAsWire
	hdg_mark.use_mipfilter		= true
	hdg_mark.h_clip_relation	= h_clip_relations.COMPARE
	hdg_mark.level				= HUD_DEFAULT_LEVEL + 1
	hdg_mark.additive_alpha		= ALPHA_BLEND
	hdg_mark.collimated			= collimated
	Add(hdg_mark)
end

for i = 0, 76 do
	hdg_mark					= CreateElement "ceSMultiLine"
	hdg_mark.name				= "hdg_mrk_sm_" .. string.format("%02d", i)
	hdg_mark.material			= stroke_material
	hdg_mark.init_pos			= {0, tape_y_pos, 0}
	hdg_mark.points_set			= {"HUD_stroke_symbols", "hdg_mrk_sm"}
	hdg_mark.scale				= HUD_SCALE * 1.5
	hdg_mark.controllers		= {{"hud_reject_2"}, {"VSTOL_MasterMode"}, {"hud_hdg_tape", i, 5.0, tick_hdg_factor}, {"ac_hdg_main", tick_hdg_displc}} -- 
	hdg_mark.alignment			= "FromSet"
	hdg_mark.thickness    		= stroke_thickness
	hdg_mark.fuzziness    		= stroke_fuzziness
	hdg_mark.isdraw				= true
	hdg_mark.draw_as_wire 		= dbg_drawStrokesAsWire
	hdg_mark.use_mipfilter		= true
	hdg_mark.h_clip_relation	= h_clip_relations.COMPARE
	hdg_mark.level				= HUD_DEFAULT_LEVEL + 1
	hdg_mark.additive_alpha		= ALPHA_BLEND
	hdg_mark.collimated			= collimated
	Add(hdg_mark)
end

hdg_mark					= CreateElement "ceSMultiLine"
hdg_mark.name				= "hdg_mrk_idx"
hdg_mark.material			= stroke_material
hdg_mark.init_pos			= {0, indx_y_pos, 0}
hdg_mark.controllers		= {{"VSTOL_MasterMode"}}
hdg_mark.points_set			= {"HUD_stroke_symbols", "HDG_Caret"}
hdg_mark.scale				= HUD_SCALE * 0.7
hdg_mark.alignment			= "FromSet"
hdg_mark.thickness    		= stroke_thickness
hdg_mark.fuzziness    		= stroke_fuzziness
hdg_mark.isdraw				= true
hdg_mark.draw_as_wire 		= dbg_drawStrokesAsWire
hdg_mark.use_mipfilter		= true
hdg_mark.h_clip_relation	= h_clip_relations.COMPARE
hdg_mark.level				= HUD_DEFAULT_LEVEL + 1
hdg_mark.additive_alpha		= ALPHA_BLEND
hdg_mark.collimated			= collimated
Add(hdg_mark)

hdg_mark					= CreateElement "ceSMultiLine"
hdg_mark.name				= "Steering_Cue"
hdg_mark.material			= stroke_material
hdg_mark.init_pos			= {0, indx_y_pos, 0}
hdg_mark.controllers		= {{"VSTOL_MasterMode"}, {"nav_dmg_lvl_0"}, {"nav_steering_error", 0.002083 * HUD_SCALE}}
hdg_mark.points_set			= {"HUD_stroke_symbols", "Steering_Cue"}
hdg_mark.scale				= HUD_SCALE * 0.7
hdg_mark.alignment			= "FromSet"
hdg_mark.thickness    		= stroke_thickness
hdg_mark.fuzziness    		= stroke_fuzziness
hdg_mark.isdraw				= true
hdg_mark.draw_as_wire 		= dbg_drawStrokesAsWire
hdg_mark.use_mipfilter		= true
hdg_mark.h_clip_relation	= h_clip_relations.COMPARE
hdg_mark.level				= HUD_DEFAULT_LEVEL + 1
hdg_mark.additive_alpha		= ALPHA_BLEND
hdg_mark.collimated			= collimated
Add(hdg_mark)

tape_hdg					= CreateElement "ceStringSLine"
tape_hdg.name				= "steerpoint_hdg"
tape_hdg.material			= stroke_font
tape_hdg.formats			= {"%03d"}
tape_hdg.alignment			= "CenterCenter"
tape_hdg.stringdefs			= stringdefs[STROKE_FNT_DFLT_100]
tape_hdg.init_pos			= {0, -9.0 * MilToDI(HUD_SCALE), 0}
tape_hdg.parent_element		= "Steering_Cue"
tape_hdg.controllers		= {{"nav_bearing"}}
tape_hdg.h_clip_relation	= h_clip_relations.COMPARE
tape_hdg.level				= HUD_DEFAULT_LEVEL + 1
tape_hdg.isvisible	    	= true
tape_hdg.collimated	    	= collimated
tape_hdg.use_mipfilter		= true
tape_hdg.additive_alpha		= ALPHA_BLEND
Add(tape_hdg)

tape_hdg					= CreateElement "ceStringSLine"
tape_hdg.name				= "Heading_Mode"
tape_hdg.material			= stroke_font
tape_hdg.value				= "T"
tape_hdg.alignment			= "CenterCenter"
tape_hdg.stringdefs			= stringdefs[STROKE_FNT_DFLT_100]
tape_hdg.init_pos			= {30.0 * MilToDI(HUD_SCALE), 162.0 * MilToDI(HUD_SCALE), 0}
tape_hdg.controllers		= {{"VSTOL_MasterMode"}, {"ac_hdg_mode"}}
tape_hdg.h_clip_relation	= h_clip_relations.COMPARE
tape_hdg.level				= HUD_DEFAULT_LEVEL + 1
tape_hdg.isvisible	    	= true
tape_hdg.collimated	    	= collimated
tape_hdg.use_mipfilter		= true
tape_hdg.additive_alpha		= ALPHA_BLEND
Add(tape_hdg)

-- Close Heading Tape Region
tape_end                 = CreateElement "ceMeshPoly"
tape_end.name	         = "tape_end"
tape_end.vertices	     = tape_begin.vertices
tape_end.indices	     = tape_begin.indices
tape_end.init_pos	     = tape_begin.init_pos
tape_end.controllers	= {{"VSTOL_MasterMode"}}
tape_end.material	     = tape_begin.material
tape_end.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
tape_end.level	         = HUD_DEFAULT_LEVEL + 1
tape_end.isvisible	     = is_debug
tape_end.collimated	     = collimated
tape_end.z_enabled       = false
Add(tape_end)

-- Reject 2 Digital Value
local	AC_Heading					= CreateElement "ceStringSLine"
		AC_Heading.name				= "Digital_Heading"
		AC_Heading.material			= stroke_font
		AC_Heading.init_pos			= {0, 24.0 * MilToDI(HUD_SCALE), 0}
		AC_Heading.formats			= {"%03d"}
		AC_Heading.stringdefs		= stringdefs[STROKE_FNT_DFLT_150]
		AC_Heading.alignment		= "CenterCenter"
		AC_Heading.parent_element	= HUD_center.name
		AC_Heading.controllers		= {{"hud_reject_21"}, {"VSTOL_MasterMode"}, {"hdg_dmg_lvl_0"}, {"ac_hdg_aux"}}
AddHUDElement(AC_Heading)
