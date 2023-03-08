dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Common_page_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/IndicatorBorderTools.lua")

-- Prepare display border vertices and indices
local borderVertsRescaled = {}
copyTable(borderVertsRescaled, displayBorderVerts)
local displayBorderInds = prepareBorderVerts(borderVertsRescaled, MeterToIn * ScreenUnitsToDI)

-- The total display mask area with shaped corners.
-- Is always applied as a mask, and it is made visible in HUD only view.
local function AddTotalDisplayArea(name, controllers)
	local element        		= CreateElement "ceMeshPoly"
	element.name 		 		= name
	element.primitivetype 		= "triangles"
	element.material 	 		= "MPD_BACKGROUND"
	element.vertices      		= borderVertsRescaled
	element.indices	     		= displayBorderInds
	--element.blend_mode 	 	= blend_mode.IBM_REGULAR
	element.change_opacity  	= false

	element.h_clip_relation 	= h_clip_relations.REWRITE_LEVEL
	element.level				= DEFAULT_LEVEL - 1
	
	if controllers ~= nil then
		element.controllers 	= controllers
	end

	Add(element)
	
	return element
end

-- An invisible rectangular mask area of 1024x1024 DIs. Is always rendered second, after the total display area (the one with shaped corners).
-- Is slightly tighter than the total display area, except it's corners.
local function AddSymbologyDisplayRect(name)
	local element	        	= CreateElement "ceMeshPoly"
	element.name 		    	= name
	element.primitivetype		= "triangles"
	element.vertices      		= {{-HalfUnitsPerSide, -HalfUnitsPerSide},
									{-HalfUnitsPerSide, HalfUnitsPerSide},
									{HalfUnitsPerSide, HalfUnitsPerSide},
									{HalfUnitsPerSide, -HalfUnitsPerSide}}
	element.indices	     		= default_box_indices
	--element.blend_mode 	 	= blend_mode.IBM_REGULAR
	element.change_opacity  	= false
	
	element.h_clip_relation 	= h_clip_relations.INCREASE_IF_LEVEL
	element.level				= DEFAULT_LEVEL - 1
	setAsInvisibleMask(element) -- changes material
	
	--[[
	if controllers ~= nil then
		element.controllers = controllers
	end
	]]
	
	Add(element)
end

-- The resulting symbology area is the intersection of Total Display Area and the Symbology Display Rectangle.

-- Total Display Area
if bakeIndicators == true then
	-- One invisible clipping mask
	local totalDisplayAreaInvis = AddTotalDisplayArea("TotalDisplayAreaInvis")
	setAsInvisibleMask(totalDisplayAreaInvis) -- changes material
else
	-- Two clipping masks - visible for HUD only view, and invisible for cockpit view.
	
	-- Invisible total display area for the normal cockpit view
	local totalDisplayAreaInvis = AddTotalDisplayArea("TotalDisplayAreaInvis", {{"render_purpose", render_purpose.GENERAL}})
	setAsInvisibleMask(totalDisplayAreaInvis) -- changes material

	-- Visible total display area for the HUD only view
	AddTotalDisplayArea("TotalDisplayAreaVis", {{"render_purpose", render_purpose.HUD_ONLY_VIEW}})
end

-- Symbology Display Rectangle
AddSymbologyDisplayRect("SymbologyDisplayRect")

------------------------------------------------------------
-- Debug reference grid

-- Uncomment desired step or add your own
local step = InToDI() -- 1 inch
--local step = 100 -- 30 Display Increments
--dbg_add_MDG_RefGrid(step, InToDI(2.5), collimated, true)
