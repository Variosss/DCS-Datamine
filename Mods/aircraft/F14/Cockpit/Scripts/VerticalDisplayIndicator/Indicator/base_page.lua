dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")
SetScale(FOV)
half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")


local SHOW_MASKS = false

local verts = { {-1, aspect},
                { 1, aspect},
                { 1,-aspect},
                {-1,-aspect}, }
local smallerverts = { {-1*0.98, aspect*0.98},
                { 1*0.98, aspect*0.98},
                { 1*0.98,-aspect*0.98},
                {-1*0.98,-aspect*0.98}, }
glass = CreateElement "ceMeshPoly"
glass.name = "glass"
glass.primitivetype = "triangles"					
glass.vertices		= verts
glass.indices		= default_box_indices
glass.material		= "DBG_BLUE"
glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass.level			= VDI_NOCLIP_LEVEL
glass.isdraw			= true
glass.change_opacity	= false
glass.isvisible		= SHOW_MASKS
Add(glass)

total_field_of_view = CreateElement "ceMeshPoly"
total_field_of_view.name = "total_field_of_view"
total_field_of_view.primitivetype = "triangles"
total_field_of_view.vertices		= smallerverts
total_field_of_view.indices			= default_box_indices
total_field_of_view.material		= "DBG_RED"
total_field_of_view.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view.level			= VDI_DEFAULT_LEVEL - 1
total_field_of_view.isdraw			= true
total_field_of_view.change_opacity	= false
total_field_of_view.isvisible		= SHOW_MASKS
Add(total_field_of_view)

