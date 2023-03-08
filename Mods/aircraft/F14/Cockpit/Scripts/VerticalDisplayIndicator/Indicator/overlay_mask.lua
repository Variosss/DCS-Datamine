dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")
SetScale(FOV)
half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local grid_origin = create_origin()

local roll_indices 		= my_create_textured_box_2k(302,1096,796,226,302,1096+226,2048/796) -- center texture at lower left corner
	roll_indices.name 	= create_guid_string()
	roll_indices.material = "VDI_ROLL_IDX_MAT"
	roll_indices.init_pos = {-1, -aspect, 0} -- bottom left corner of VDI
	roll_indices.parent_element = grid_origin.name
    roll_indices.level = INDICATOR_LEVEL
    roll_indices.use_mipfilter = true
Add(roll_indices)

local vdi_filter = CreateElement "ceMeshPoly"
    vdi_filter.name = create_guid_string()
    vdi_filter.primitivetype = "triangles"

    vdi_filter.vertices	= { {-1.1,-1.1},
                                {-1.1,1.1},
                                { 1.1,1.1},
                                 {1.1,-1.1}}

    vdi_filter.indices		 = default_box_indices
    vdi_filter.init_pos		 = {0, 0, 0}
    vdi_filter.material		 = "VDI_RED_FILTER"

    vdi_filter.use_mipfilter = true
    vdi_filter.additive_alpha = false
    vdi_filter.h_clip_relation = h_clip_relations.COMPARE
    vdi_filter.level = INDICATOR_LEVEL
    vdi_filter.isvisible = true
    vdi_filter.isdraw = false
    vdi_filter.controllers = {{"vdi_filter"}}
    vdi_filter.blend_mode = 6 -- MULT
Add(vdi_filter)

