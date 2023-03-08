dofile(LockOn_Options.script_path.."HMD/indicator/HMD_Page_defs.lua")
dofile(LockOn_Options.script_path.."HMD/indicator/HMD_IndicatorBorderTools.lua")

local displayBorderInds = prepareBorderVerts(displayBorderVerts, DegToDI(1))

local function AddBackground(name, invisible, controllers)
	local element	        = CreateElement "ceMeshPoly"
	element.name 		    = name
	element.primitivetype	= "triangles"
	element.material 	    = "MPD_BACKGROUND"
	element.vertices        = displayBorderVerts
	element.indices	     	= displayBorderInds
	element.blend_mode 	 	= blend_mode.IBM_REGULAR
	element.change_opacity  = false
	
	if invisible == true then
		element.h_clip_relation = h_clip_relations.REWRITE_LEVEL
		element.level			= DEFAULT_LEVEL
		setAsInvisibleMask(element) -- changes material
	end
	
	Add(element)
end

AddBackground("HMD_background", true)

------------------------------------------------------------

-- Debug reference grid
-- Uncomment desired step or add your own
--local step = MilToDI(10) -- 10 mils step
--local step = 20 -- 20 DI step
--local step = DegToDI() -- 1 degree step
--local step = glyphNominalHeight * 2 -- 200% stroke font height step
--dbg_add_MDG_RefGrid(step, MilToDI(HUD_TFOV_mils), collimated)
