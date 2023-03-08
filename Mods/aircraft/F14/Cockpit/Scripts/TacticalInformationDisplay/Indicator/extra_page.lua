dofile(LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/Indicator/definitions.lua")

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = TID_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local TID_fontsize=0.056 * half_height


local grid_origin = create_origin()
--grid_origin.collimated 		 = true


for num = 1,40 do -- 20 items

    local line				= CreateElement "ceSimpleLineObject"

    line.name 	= "LineElement"..num
    line.material = "TID_COLOR"

    line.init_pos =  {0, 0, 0}
    line.h_clip_relation		= h_clip_relations.COMPARE -- this element will sit on level(.level + 1)
    line.level				= TID_DEFAULT_LEVEL
    line.parent_element = grid_origin.name
    line.isdraw            = true
    line.isvisible			= true
    line.additive_alpha = false
    line.use_mipfilter = true
    line.controllers = {{"ExtraLine", num}}
    line.width = 0.002


  Add(line)
end


local score_str           = CreateElement "ceStringPoly"
    score_str.name            = create_guid_string()
    score_str.material        = "font_TID"
    score_str.stringdefs    = {TID_fontsize, TID_fontsize, 0, 0}
    score_str.init_pos = {0.0,-0.54}
    score_str.alignment     = "CenterCenter"
    score_str.controllers 		= {{"ExtraScore"}}
    score_str.isdraw = true
    score_str.isvisible			= true
AddElement(score_str)
