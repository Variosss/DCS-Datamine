dofile(LockOn_Options.script_path.."../../Common/ALR_300/Indicator/ALR_300_tools.lua")

--[[
local ALR_300_displArea_HUDonly_back				= makeDispArea(64)
ALR_300_displArea_HUDonly_back.name 			  	= "ALR_300_displArea_HUDonly_back"
ALR_300_displArea_HUDonly_back.material		  		= "ALR_300_BACKGROUND"
ALR_300_displArea_HUDonly_back.h_clip_relation 		= h_clip_relations.NULL
ALR_300_displArea_HUDonly_back.controllers 	 		= {{"render_purpose", render_purpose.HUD_ONLY_VIEW}}
Add(ALR_300_displArea_HUDonly_back)
--]]

local ALR_300_displArea_mask						= makeDispArea(32)
ALR_300_displArea_mask.name 			  			= "ALR_300_displArea_mask"
ALR_300_displArea_mask.material		  				= "MASK_MATERIAL"
ALR_300_displArea_mask.h_clip_relation 				= h_clip_relations.REWRITE_LEVEL
ALR_300_displArea_mask.level			  			= INDICATOR_DEFAULT_LEVEL
ALR_300_displArea_mask.isvisible		  			= false
Add(ALR_300_displArea_mask)

--drawIndicatorRefGrid(11, 0.1, 2, false)