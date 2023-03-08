dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")

SetScale(FOV)
local TST  = MakeMaterial(nil,MARK_COLOR)
local width  = 1;
local height = width * GetAspect()
local line_w = 0.005

local RT 		=  CreateElement "ceSimple"
RT.controllers    = {{"to_render_target",1}}
Add(RT)

local function  ADD_RT(elem)
	elem.parent_element = RT.name
	Add(elem)
end

function ring(radius)
    local segments = 36 
    local verts = {}
	local inds  = {}
    for i = 1,segments + 1 do
        local alfa = math.rad((i-1) * 360/segments)
 		verts[i] = {radius * math.sin(alfa),radius * math.cos(alfa)}
		inds[2*i - 1] = i - 1
		inds[2*i]     = i
		if i == segments + 1 then
		inds[2*i] = 0
		end
	end
	local ring	       		 = CreateElement "ceMeshPoly"
		ring.material 	     =  TST
		ring.primitivetype   = "lines"
		ring.vertices 	     = verts 
		ring.indices	  	 = inds
		ring.level		     = DEFAULT_LEVEL
		ring.h_clip_relation = h_clip_relations.REWRITE_LEVEL
		ring.blend_mode 	= blend_mode.IBM_REGULAR_RGB_ONLY
		ADD_RT(ring)
    return ring
end

--ring(1.0)




local objects	       = CreateElement "ceSimple"
objects.name     	   = "objects"
objects.controllers    = {{"draw_objects"}}
ADD_RT(objects)


flight_plan_line				= CreateElement "ceSimpleLineObject"
flight_plan_line.name			= "flight_lan_line"
flight_plan_line.material		= TST
flight_plan_line.width			= 0.005
flight_plan_line.controllers    = {{"flight_plan_line",GetScale()}}
flight_plan_line.h_clip_relation= h_clip_relations.COMPARE
flight_plan_line.level			= DEFAULT_LEVEL
flight_plan_line.blend_mode 	= blend_mode.IBM_REGULAR_RGB_ONLY
ADD_RT(flight_plan_line)

--[[
local test_font_size = 0.0075
local function add_origin(parent)
	local   orig				= CreateElement "ceMeshPoly"
			orig.material		= MakeMaterial(nil,{0,255,100,255})
			orig.primitivetype	= "lines"
			orig.vertices		= {{-0.1,0},{1,0},
								   {0,-0.1},{0,0.1}}
			orig.indices		= {0,1,2,3}
			orig.parent_element = parent.name
		Add(orig)
		
		
	local   box				= CreateElement "ceMeshPoly"
			box.material		= MakeMaterial(nil,{200,255,0,255})
			box.primitivetype	= "lines"
			box.vertices		= {{0,0},{0,test_font_size / GetScale()},
								   {test_font_size / GetScale(),test_font_size / GetScale()},{test_font_size / GetScale(),0}}
			box.indices		= {0,1,1,2,2,3}
			box.parent_element = parent.name
		Add(box)
end

local test_string_defs = {test_font_size,test_font_size,0.005,0.005}

TEXTTEST						= CreateElement "ceStringPoly"
TEXTTEST.alignment				= "LeftBottom"
TEXTTEST.value					= "AAAyyy123"
TEXTTEST.material				= MakeFont(FONT_PROTO,{255,0,0,255})
TEXTTEST.init_pos 				= {0,-0.35}
TEXTTEST.stringdefs				= test_string_defs
TEXTTEST.UseBackground			= true
TEXTTEST.BackgroundMaterial		= MakeMaterial(nil,{0,0,0,255})
ADD_RT(TEXTTEST)

add_origin(TEXTTEST)


TEXTTEST_OLD						= CreateElement "ceStringPoly"
TEXTTEST_OLD.alignment				= "LeftBottom"
TEXTTEST_OLD.value					= "AAAyyy123"
TEXTTEST_OLD.material				= MakeFont({used_DXUnicodeFontData = "font_dejavu_lgc_sans_22"},{0,255,0,255})
TEXTTEST_OLD.init_pos 				= {0,-0.25}
TEXTTEST_OLD.stringdefs				= test_string_defs
TEXTTEST_OLD.UseBackground			= true
TEXTTEST_OLD.BackgroundMaterial		= MakeMaterial(nil,{0,0,0,255})
ADD_RT(TEXTTEST_OLD)

add_origin(TEXTTEST_OLD)

TEXTTEST_CHINESE						= CreateElement "ceStringPoly"
TEXTTEST_CHINESE.alignment				= "LeftBottom"
TEXTTEST_CHINESE.value					= "这是一个测试"
TEXTTEST_CHINESE.material				= MakeFont(FONT_PROTO,{255,0,0,255})
TEXTTEST_CHINESE.init_pos 				= {-1,-0.35}
TEXTTEST_CHINESE.stringdefs				= test_string_defs
TEXTTEST_CHINESE.UseBackground			= true
TEXTTEST_CHINESE.BackgroundMaterial		= MakeMaterial(nil,{0,0,0,255})
ADD_RT(TEXTTEST_CHINESE)

add_origin(TEXTTEST_CHINESE)

--]]