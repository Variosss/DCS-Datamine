dofile(LockOn_Options.script_path.."Scripts/DetailDataDisplay/Indicator/definitions.lua")

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = DDD_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local SHOW_MASKS = false

--local SizeX = half_width
--local SizeY = half_height
--[[local verts = {	{-SizeX,-SizeY},
                {-SizeX, SizeY},
                { SizeX, SizeY},
                { SizeX,-SizeY} }
--]]

-- make clip box covering connector-defined display
local verts = { {-1, 1},
                { 1, 1},
                { 1,-1},
                {-1,-1}, }

baselayer = CreateElement "ceMeshPoly"
baselayer.name = "baselayer"
baselayer.primitivetype = "triangles"
baselayer.vertices = verts
baselayer.indices = default_box_indices -- {0, 1, 2, 0, 2, 3}
baselayer.material = DBG_RED
baselayer.h_clip_relation = h_clip_relations.REWRITE_LEVEL
baselayer.level = DDD_NOCLIP_LEVEL
baselayer.isdraw = true
baselayer.change_opacity = false
baselayer.collimated = false
baselayer.isvisible = SHOW_MASKS
Add(baselayer)
