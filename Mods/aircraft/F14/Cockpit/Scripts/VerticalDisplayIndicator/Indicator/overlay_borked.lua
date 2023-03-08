dofile(LockOn_Options.script_path.."Scripts/VerticalDisplayIndicator/Indicator/definitions.lua")
SetScale(FOV)
half_width   = GetScale() -- size in meters
half_height  = GetAspect() * half_width
aspect       = GetAspect()

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = VDI_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local grid_origin = create_origin()

local crtborked 	= create_textured_box(0,0,512,512,512,512)-- 
crtborked.name 	= create_guid_string()
crtborked.material = "VDI_CRT_TEX_BORKED"
crtborked.init_pos = {0, 0, 0}
crtborked.parent_element = grid_origin.name
crtborked.h_clip_relation = h_clip_relations.COMPARE
crtborked.level = INDICATOR_LEVEL
crtborked.use_mipfilter = true
crtborked.controllers = {{"borked_animation"}}
local state_coords = {}
for i=0,7 do
    state_coords[#state_coords+1]=get_tex_coord(i*512,0,512,512,4096,512)
end
crtborked.state_tex_coords = state_coords
Add(crtborked)
