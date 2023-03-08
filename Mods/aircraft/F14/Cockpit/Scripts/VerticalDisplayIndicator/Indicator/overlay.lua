dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")
SetScale(FOV)
half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local grid_origin = create_origin()

local crtnoise 	= create_textured_box(0,0,512,512,512,512)-- 
crtnoise.name 	= create_guid_string()
crtnoise.material = "VDI_CRT_TEX_NOISE"
crtnoise.init_pos = {0, 0, 0}
crtnoise.parent_element = grid_origin.name
crtnoise.use_mipfilter = true
crtnoise.controllers = {{"crt_noise_animation"}}
local state_coords = {}
for i=0,7 do
    state_coords[#state_coords+1]=get_tex_coord(i*512,0,512,512,4096,512)
end
crtnoise.state_tex_coords = state_coords
Add(crtnoise)

local crtpixels 	= create_textured_box(0,0,512,512,512,512)-- 
crtpixels.name 	= create_guid_string()
crtpixels.material = "VDI_CRT_TEX_MAT"
crtpixels.init_pos = {0, 0, 0}
crtpixels.parent_element = grid_origin.name
crtpixels.use_mipfilter = true
crtpixels.controllers = {{"crt_pixels_brt"}}
Add(crtpixels)

local crtdarkvignette 	= create_textured_box(0,0,512,512,512,512)-- 
crtdarkvignette.name 	= create_guid_string()
crtdarkvignette.material = "VDI_CRT_TEX_MAT2"
crtdarkvignette.init_pos = {0, 0, 0}
crtdarkvignette.parent_element = grid_origin.name
crtdarkvignette.use_mipfilter = true
Add(crtdarkvignette)

local crtmask	= create_textured_box(0,0,512,512,512,512)-- 
crtmask.name 	= create_guid_string()
crtmask.vertices = { {-1.006, -1.006*aspect }, {-1.006, 1.006*aspect }, {1.006, 1.006*aspect }, {1.006, -1.006*aspect }}
crtmask.material = "VDI_CRT_TEX_MAT3"
crtmask.init_pos = {0, 0, 0}
crtmask.parent_element = grid_origin.name
crtmask.level = INDICATOR_LEVEL
crtmask.use_mipfilter = true
Add(crtmask)