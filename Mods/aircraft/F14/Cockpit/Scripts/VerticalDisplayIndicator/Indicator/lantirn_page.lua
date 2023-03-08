dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

SetScale(FOV)
half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

LANTIRN_FX_MATERIAL_NAME = "LANTIRNMaterialVDI"
LANTIRN_MATERIAL_NAME = "LANTIRN_MAT_VDI"
LANTIRN_FONT_MATERIAL = "font_LANTIRN_VDI"

TV_LEVEL = VDI_DEFAULT_LEVEL

dofile(general_page_path.."lantirn_page.lua")

local grid_origin = create_origin()

local crtmask	= create_textured_box(0,0,512,512,512,512)--
crtmask.name 	= create_guid_string()
crtmask.vertices = { {-1.006, -1.006*aspect }, {-1.006, 1.006*aspect }, {1.006, 1.006*aspect }, {1.006, -1.006*aspect }}
crtmask.material = "VDI_CRT_TEX_MAT3"
crtmask.init_pos = {0, 0, 0}
crtmask.parent_element = grid_origin.name
crtmask.level = INDICATOR_LEVEL
crtmask.use_mipfilter = true
Add(crtmask)
