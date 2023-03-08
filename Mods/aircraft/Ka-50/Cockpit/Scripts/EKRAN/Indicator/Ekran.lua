dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."EKRAN/Device/EKRAN_localizer.lua")

SetScale(FOV) -- set scale factor modifier (in this case FOV - half of horizontal size)

dzK = 0.006087

--[[
  SetScale(MILLYRADIANS)
	next elements will be scaled in millyrads
  SetScale(METERS)
        next elements will be scaled in meters
  SetScale(FOV)
        and again in FOV parts
--]]

--[[
template				 = CreateElement "ceTexPoly"
template.name			 = "template"
template.vertices		 = {{-1.03, -0.81}, {-1.03, 0.81}, {1.03, 0.81}, {1.03, -0.81}}
template.indices		 = default_box_indices
template.init_pos		 = {0.0, 0.0, 0}
template.material        = "INDICATION_SHKVAL-V_TEMPLATE"
template.tex_params		 = {0.5, 0.5, 0.48, 0.48}
template.isdraw			 = flag_show_template
Add(template)
--]]

--[[
dbg_template_box			   = CreateElement "ceMeshPoly"
dbg_template_box.name		   = "dbg_template_box"
dbg_template_box.primitivetype = "lines"
dbg_template_box.vertices	   = template.vertices
dbg_template_box.indices	   = default_rect_indices
dbg_template_box.init_pos	   = template.init_pos
dbg_template_box.material      = REGIONS_COLOR
dbg_template_box.isdraw		   = flag_show_template
Add(dbg_template_box)
--]]

frame			    = CreateElement "ceMeshPoly"
frame.name		    = "frame"
frame.primitivetype = "triangles"
frame.vertices		 = {{-1.0, -0.75},
						{-1.0, 0.75},
						{1.0, 0.75},
						{1.0, -0.75}}
frame.indices	    = default_box_indices
frame.init_pos		= {0, 0, 0}
frame.material      = "EKRAN_STNCL"
frame.h_clip_relation = h_clip_relations.REWRITE_LEVEL
frame.level			= DEFAULT_LEVEL + 2
frame.isdraw		= true
frame.isvisible		= false
Add(frame)

txt_memory                 = CreateElement "ceStringPoly"
txt_memory.name            = "txt_memory"
txt_memory.material        = "font_EKRAN"
txt_memory.init_pos		   = {0.68, 1.68, 0}
txt_memory.alignment       = "CenterCenter"
txt_memory.value		   = LOCALIZE("MEMORY")
txt_memory.stringdefs      = {0.0032, 0.0032, 0.0, 0.0}
txt_memory.controllers     = {{"txt_memory"}}
txt_memory.use_mipfilter = true
Add(txt_memory)

txt_queue                 = CreateElement "ceStringPoly"
txt_queue.name            = "txt_queue"
txt_queue.material        = "font_EKRAN"
txt_queue.init_pos		  = {-0.72, 1.68, 0}
txt_queue.alignment       = "CenterCenter"
txt_queue.value		      = LOCALIZE("QUEUE")
txt_queue.stringdefs      = {0.0032, 0.0032, 0.0, 0.0}
txt_queue.controllers     = {{"txt_queue"}}
txt_queue.use_mipfilter = true
Add(txt_queue)

txt_failure                 = CreateElement "ceStringPoly"
txt_failure.name            = "txt_failure"
txt_failure.material        = "font_EKRAN"
txt_failure.init_pos		= {0.0, 2.75, 0}
txt_failure.alignment       = "CenterCenter"
txt_failure.value		    = LOCALIZE("FAILURE")
txt_failure.stringdefs      = {0.0032, 0.0032, 0.0, 0.0}
txt_failure.controllers     = {{"txt_failure"}}
txt_failure.use_mipfilter = true
Add(txt_failure)

txt_1                 = CreateElement "ceStringPoly"
txt_1.name            = "txt_1"
txt_1.material        = "font_EKRAN"
txt_1.init_pos		  = {-0.925, 0.71, 0}
txt_1.alignment       = "LeftTop"
txt_1.value			  = ""
txt_1.stringdefs      = {0.0049, 0.0049, -0.01 * 0.01, 0.16 * 0.01}
txt_1.controllers     = {{"txt1", dzK}}
txt_1.h_clip_relation = h_clip_relations.COMPARE
txt_1.level			  = DEFAULT_LEVEL + 2
txt_1.use_mipfilter = true
Add(txt_1)

txt_2                 = CreateElement "ceStringPoly"
txt_2.name            = "txt_2"
txt_2.material        = "font_EKRAN"
txt_2.init_pos		  = {2.6, 0.71, 0}
txt_2.alignment       = "LeftTop"
txt_2.value			  = ""
txt_2.stringdefs      = {0.0049, 0.0049, -0.01 * 0.01, 0.16 * 0.01}
txt_2.controllers     = {{"txt2", dzK}}
txt_2.h_clip_relation = h_clip_relations.COMPARE
txt_2.level			  = DEFAULT_LEVEL + 2
txt_2.use_mipfilter   = true
Add(txt_2)
