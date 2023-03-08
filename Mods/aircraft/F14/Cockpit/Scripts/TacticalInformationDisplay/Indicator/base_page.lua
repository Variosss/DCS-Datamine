dofile(LockOn_Options.script_path.."Scripts/TacticalInformationDisplay/Indicator/definitions.lua")

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = TID_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local SHOW_MASKS = false

local verts = { {-1, aspect},
                { 1, aspect},
                { 1,-aspect},
                {-1,-aspect}, }
base = CreateElement "ceMeshPoly"
base.name = "base"
base.primitivetype = "triangles"
--base.vertices		= verts
--base.indices		= default_box_indices
set_circle(base, 1, nil, nil, 64) -- from global element_defs.lua
base.init_pos		= {0, 0, 0}
base.init_rot		 = {0, 0, 0}
base.material		= DBG_TRANSPARENT
base.h_clip_relation = h_clip_relations.REWRITE_LEVEL
base.level			= TID_NOCLIP_LEVEL
base.isdraw			= true
base.change_opacity	= false
base.isvisible		= SHOW_MASKS
Add(base)


local verts = { {-1, aspect},
                { 1, aspect},
                { 1,-aspect},
                {-1,-aspect}, }

background = CreateElement "ceMeshPoly"
set_circle(background, 1, nil, nil, 64) -- from global element_defs.lua
background.material      = material
background.name = create_guid_string()
background.primitivetype = "triangles"
--background.vertices = verts
--background.indices = default_box_indices -- {0, 1, 2, 0, 2, 3}
background.material = DBG_GREEN
background.isdraw = true
background.change_opacity = false
background.isvisible = SHOW_MASKS
background.use_mipfilter = true
background.additive_alpha = false
background.collimated = false
background.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
background.level = TID_NOCLIP_LEVEL
Add(background)
