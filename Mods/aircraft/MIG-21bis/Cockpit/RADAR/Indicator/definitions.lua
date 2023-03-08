dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(FOV)

RADAR_DEFAULT_LEVEL = 4
RADAR_DEFAULT_NOCLIP_LEVEL  = RADAR_DEFAULT_LEVEL - 1

function AddElement(object)
    object.use_mipfilter    = true
	object.additive_alpha   = true
	object.h_clip_relation  = h_clip_relations.COMPARE
	object.level			= RADAR_DEFAULT_LEVEL
    Add(object)
end

--[[
SetScale  have generalized form input value : 
SetScale(MILLYRADIANS)
SetScale(FOV)
SetScale(METERS)

in case of FOV , GetScale()  will return half width of your indicator 

MILLYRADIANS :  0.001 * viewDistance , where viewDistance is default distance from pilot eye to indicator projection plane

]]--

