dofile(LockOn_Options.script_path.."Displays/EHSI/indicator/EHSI_Page_defs.lua")

local MaskSize05 = 294 / 2
local function AddBackground(name, invisible, controllers)
	local element	        = CreateElement "ceMeshPoly"
	element.name 		    = name
	element.primitivetype   = "triangles"
	element.material 	    = "EHSI_BACKGROUND"
	element.vertices        = {{-MaskSize05, -MaskSize05}, {-MaskSize05, MaskSize05}, {MaskSize05, MaskSize05}, {MaskSize05, -MaskSize05}}
	element.indices	     	= {0, 1, 2, 0, 2, 3}
	element.blend_mode 	 	= blend_mode.IBM_REGULAR
	element.change_opacity  = false
	
	if invisible == true then
		element.h_clip_relation = h_clip_relations.REWRITE_LEVEL
		element.level			= DEFAULT_LEVEL
		setAsInvisibleMask(element) -- changes material
	end
	
	if controllers ~= nil then
		element.controllers = controllers
	end
	
	Add(element)
end

AddBackground("Background_Mask", true) -- clipping mask

