dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")
SetScale(FOV)
half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local grid_origin = create_origin()

-- aircraft reticle and airspeed&altitude reference marks
local aircraft_reticle_reference 			= my_create_textured_box_2k(527,418,826,39,938,430,2048/826)
	aircraft_reticle_reference.name 	= create_guid_string()
	aircraft_reticle_reference.material = "VDI_WHITE_MAT"
	aircraft_reticle_reference.init_pos = {0, 0, 0}
	aircraft_reticle_reference.parent_element = grid_origin.name
AddElement(aircraft_reticle_reference, false)
