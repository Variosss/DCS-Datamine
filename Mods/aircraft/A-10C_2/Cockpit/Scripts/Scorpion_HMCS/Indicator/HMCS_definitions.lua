dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."Scorpion_HMCS/Indicator/HMCS_profile_IDs.lua")

-- degrees to milliradians
degToMil = math.rad(1) * 1000

SetScale(MILLYRADIANS)

collimated 			= true
use_mipfilter		= true

drawDbgGeometry 	= false
-- Does nothing when 'drawDbgGeometry' was set false
drawDbgMarkers  	= true
-- Debug color for symbology. Is useful when HMCS symbology overlaps HUD (happens when occlusion is disabled)
useDBGcolor  		= false

HMCS_DEFAULT_LEVEL 	= 15
disable_clipping   	= false
large_TFOV			= false

HMCS_horizontal_sz_mil 		= 26 * degToMil
HMCS_vertical_sz_mil   		= 20 * degToMil

largeTFOV_horizontal_sz_mil	= 310 * degToMil
largeTFOV_vertical_sz_mil	= 185 * degToMil
	
-- pixels per 1 milliradian
pixelsPerMil 		= 3.2183398
-- texture resolution
texture_resolution 	= 512
tex_scale   		= pixelsPerMil / texture_resolution

-- Base horizontal font size in milliradians.
-- Can be used to change scale of the whole set of fonts,
--    as well as of relative symbology positions
baseFontSizeMil_X = 8.67

-- The font size 'number' corresponds to it's relative size to the base horizonal one. Greater number means larger font.
-- Sizes are described in the order of dependence from each other.

-- Size 2 (base)
FontSizeX2		= baseFontSizeMil_X * GetScale()
FontSizeY2		= FontSizeX2

-- Size 1 (small)
--FontSizeX1	= FontSizeX2 / 3 * 2
FontSizeX1		= FontSizeX2 / 4 * 3
FontSizeY1		= FontSizeX1

-- Size 0 (tiny)
FontSizeX0		= FontSizeX1 / 4 * 3
FontSizeY0		= FontSizeX0

-- Size 3 (large)
FontSizeX3		= FontSizeX2 * 1.254
FontSizeY3		= FontSizeX3

predefined_font_0 = {FontSizeX0, FontSizeY0, 0, 0}
predefined_font_1 = {FontSizeX1, FontSizeY1, 0, 0}
predefined_font_2 = {FontSizeY2, FontSizeX2, 0, 0}
predefined_font_3 = {FontSizeY3, FontSizeX3, 0, 0.00105}

function determineClipRelation(relation, override_disable)
	local override = override_disable or false
	if disable_clipping == true and override == false then
		return h_clip_relations.NULL
	else
		return relation
	end
end

lineEndLen		= 1.5
lineWidth 		= 3

do
	solidLineParams = {
		-- variable line texture coordinates
		lineXbegin_px 	= 8,
		lineXend_px		= texture_resolution - 8,
		lineY_px  		= 502,
		
		-- mils
		lineEndLen		= lineEndLen
	}
end

-- variable line max length in mils
solidLineLenMax = (solidLineParams.lineXend_px - solidLineParams.lineXbegin_px) / pixelsPerMil
solidVarLenLineMax = 2 * solidLineLenMax

do
	dashedLineParams = {
		-- variable line texture coordinates
		lineXbegin_px 	= solidLineParams.lineXbegin_px,
		lineXend_px		= solidLineParams.lineXend_px,
		lineY_px		= 8.5,
		
		-- mils
		lineEndLen		= solidLineParams.lineEndLen
	}
	
	local dashStrokeMiddle_px = 11
	dashConnectGap_px = dashStrokeMiddle_px - dashedLineParams.lineXbegin_px
end

function makeBoxVerts(x_min, x_max, y_min, y_max)
	return {{x_min, y_min}, {x_min, y_max}, {x_max, y_max}, {x_max, y_min}}
end

function makeCircleVerts(num_points, radius)
	local step = math.rad(360.0 / num_points)

	local verts = {}
	for i = 1, num_points do
		verts[i] = { radius * math.cos(i * step), radius * math.sin(i * step)}
	end
	
	return verts
end

function getTexParams(x, y)
	return {x / texture_resolution, y / texture_resolution, tex_scale, tex_scale}
end

local function addPlaceholder__Raw(name, init_pos, controllers)
	local placeholder       		= CreateElement "ceSimple"
	placeholder.name        		= name
	init_pos 						= init_pos or {0, 0}
	placeholder.init_pos    		= {init_pos[1], init_pos[2], 0}
	placeholder.collimated  		= collimated or false
	
	if controllers ~= nil then
		placeholder.controllers		= controllers
	end
	
	Add(placeholder)
	return placeholder
end

-- All symbology elements are supposed to have this placeholder set as their parent_element
boresightPos = addPlaceholder__Raw("Boresight_Pos", {0, 0}, {{"boresight_pos"}})

function addPlaceholder(name, init_pos, controllers)
	local placeholder 				= addPlaceholder__Raw(name, init_pos, controllers)
	placeholder.parent_element 		= boresightPos.name
	return placeholder
end

function add_debug_marker(name, init_pos, span, label_txt)
	if drawDbgMarkers then
		
		local material = MakeMaterial("<REF_LINES>", {200, 50, 200, 255})
		local font 	   = MakeFont({used_DXUnicodeFontData = "font_dejavu_lgc_sans_22_white"}, {200, 50, 200, 255})

		-- cross at the marker position
		
		local cross           = CreateElement "ceMeshPoly"
		cross.name   		  = "dbg_ctr_".. (name or label_txt)
		cross.primitivetype   = "lines"
		cross.vertices        = {{-0.5 * span, 0.0}, {0.5 * span, 0.0}, {0, -0.5 * span}, {0, 0.5 * span}}
		cross.indices         = {0, 1, 2, 3}
		cross.material        = material
		cross.parent_element  = boresightPos.name
		cross.init_pos        = init_pos or {0, 0}
		cross.collimated      = collimated or false
		Add(cross)
		
		-- marker label text
		
		local label			  = CreateElement "ceStringPoly"
		label.name   		  = "dbg_lbl_".. (name or label_txt)
		label.alignment		  = "LeftCenter"
		label.value			  = label_txt or name or "<REF>"
		label.material		  = font
		label.stringdefs	  = {0.01, 0.003, 0, 0}
		label.use_mipfilter   = true
		label.init_pos        = {0.5 * span, 0}
		label.parent_element  = cross.name
		label.collimated	  = collimated or false
		Add(label)
		
		return cross
	end
end

function AddTexuredElement(name, vertices, tex_params, controllers, init_pos, init_rot, level)
	local element			= CreateElement "ceTexPoly"
	element.indices			= default_box_indices
	
	if useDBGcolor == true then
		element.material		= "INDICATION_HMCS_DBG"
	else
		element.material		= "INDICATION_HMCS"
	end
	
	element.name			= name
	element.vertices		= vertices
	element.tex_params 		= tex_params 
	
	if controllers ~= nil then
		element.controllers	= controllers
	end
	
	element.init_pos		= init_pos
	element.init_rot		= init_rot
	
	element.parent_element  = boresightPos.name
	
	element.h_clip_relation	= determineClipRelation(h_clip_relations.COMPARE)
	element.level			= level
	
	element.additive_alpha	= true
	element.collimated		= collimated or false
	
	element.use_mipfilter	= use_mipfilter
		
	Add(element)

	if drawDbgGeometry then
		local dbg_box 			= CreateElement "ceMeshPoly"
		dbg_box.name 			= name .. "_dbg_box"
		dbg_box.primitivetype 	= "triangles"
		dbg_box.vertices 		= vertices
		dbg_box.indices			= default_box_indices
		dbg_box.material		= "DBG_RED"
		dbg_box.isdraw			= true
		dbg_box.change_opacity	= false
		dbg_box.collimated		= collimated or false
		
		dbg_box.parent_element  = name
	
		Add(dbg_box)
		
		if drawDbgMarkers then
			local dbg_marker = add_debug_marker(name.."_dbg_marker_ctr", {0, 0}, 20, "")
			dbg_marker.parent_element  = dbg_box.name
		end
	end
	
	return element
end

function AddText(name, controllers, init_pos, level, size)
	local txt		= CreateElement "ceStringPoly"
	txt.name		= name
	
	if useDBGcolor == true then
		txt.material		= "font_HMCS_DBG"
	else
		txt.material		= "font_HMCS"
	end
	
	txt.init_pos	= init_pos
	txt.alignment	= "CenterCenter"
	
	if size ~= nil then
		if size == 0 then
			txt.stringdefs	= predefined_font_0
		elseif size == 1 then
			txt.stringdefs	= predefined_font_1
		elseif size == 2 then
			txt.stringdefs	= predefined_font_2
		else -- 3
			txt.stringdefs	= predefined_font_3
		end
	else
		txt.stringdefs	= predefined_font_1
	end
	
	txt.additive_alpha	= true
	txt.collimated		= collimated or false
	
	if controllers ~= nil then
		txt.controllers		= controllers
	end
	
	txt.parent_element = "Boresight_Pos"
	
	txt.h_clip_relation	= determineClipRelation(h_clip_relations.COMPARE)
	txt.level			= level
	txt.use_mipfilter	= use_mipfilter
		
	Add(txt)
	
	return txt
end


function AddText_Pos(name, controllers, init_pos, level, pos, size)
local txt = AddText(name, controllers, init_pos, level, size)
	txt.alignment	= pos
	return txt
end


function AddText_Pos_Val(name, controllers, init_pos, level, pos, value, size)
local txt = AddText_Pos(name, controllers, init_pos, level, pos, size)
	txt.value = value
	return txt
end

function AddText_Pos_Formats(name, controllers, init_pos, level, pos, formats, size)
local txt = AddText_Pos(name, controllers, init_pos, level, pos, size)
	txt.formats = formats
	return txt
end

function addMeshBox(Name, Hosts, pos, controllers)

	local GH = {}
	
	if Hosts ~= nil then
		i = 0
		for k, v in pairs(Hosts) do
			i = i+1
			GH[i] = v.name
		end
	end
	
	local MeshBox  				= CreateElement "ceBoundingMeshBox"
	MeshBox.name 				= Name
	
	for k, v in pairs(GH) do
		MeshBox.name = MeshBox.name .. "_" .. v
	end
	
	MeshBox.primitivetype		= "lines"
	MeshBox.material	   		= "INDICATION_COMMON_RED"
	
	if pos ~= nil then
		MeshBox.init_pos = pos
	end
		
	MeshBox.vertices			= {{-1, -1},
								   { 1, -1},
								   { 1, 1},
								   {-1, 1}}
	
	if controllers ~= nil then
		MeshBox.controllers	= controllers
	end
		
	MeshBox.geometry_hosts		= GH
	Add(MeshBox)
		
	return MeshBox
end

function openMaskArea(Name, vertices, controllers, level)

	local mask 				= CreateElement "ceMeshPoly"
	mask.name 				= Name
	mask.primitivetype 		= "triangles"
	mask.vertices 			= vertices
	mask.indices  			= default_box_indices
	mask.material 			= "DBG_RED" --"GREEN"
	mask.h_clip_relation 	= determineClipRelation(h_clip_relations.INCREASE_IF_LEVEL, true)
	mask.level			 	= level
	
	if controllers ~= nil then
		mask.controllers    = controllers
	end
	
	mask.parent_element		= boresightPos.name
	
	--mask.isdraw 			= true
	mask.isvisible  		= drawDbgGeometry
	Add(mask)

	return mask
end

function closeMaskArea(Name, vertices, controllers, level)

	local mask 				= CreateElement "ceMeshPoly"
	mask.name 				= Name
	mask.primitivetype 		= "triangles"
	mask.vertices 			= vertices
	mask.indices  			= default_box_indices
	mask.material 			= "DBG_RED" --"GREEN"
	mask.h_clip_relation 	= determineClipRelation(h_clip_relations.DECREASE_IF_LEVEL, true)
	mask.level			 	= level
	
	if controllers ~= nil then
		mask.controllers   	= controllers
	end
	
	mask.parent_element		= boresightPos.name
	
	mask.isvisible 			= drawDbgGeometry
	Add(mask)

	return mask
end

function addVarLenLine(Name, length, maxlength, controllers, init_pos, init_rot, level, dashed)
	
	local lineTexParams
	if dashed == true then
		lineTexParams = getTexParams(solidLineParams.lineXbegin_px, 8)
	else
		lineTexParams = getTexParams(solidLineParams.lineXbegin_px, solidLineParams.lineY_px)
	end
	
	local lineLen = 154

	local Line				= CreateElement("ceHWLine")
	Line.name				= Name
	Line.vertices			= makeBoxVerts(-lineEndLen, lineLen + lineEndLen, -lineWidth / 2, lineWidth / 2)
	Line.maskvertices		= makeBoxVerts(0, lineLen + lineEndLen, -lineWidth / 2, lineWidth / 2)
	Line.indices			= default_box_indices
	Line.maxlength			= maxlength
	Line.length				= length
	
	if useDBGcolor == true then
		Line.material		= "INDICATION_HMCS_DBG"
	else
		Line.material		= "INDICATION_HMCS"
	end
	
	Line.tex_params			= lineTexParams
	Line.init_pos			= init_pos
	Line.init_rot			= init_rot
	
	if controllers ~= nil then
		Line.controllers    	= controllers
	end
	
	Line.parent_element		= boresightPos.name
		
	Line.h_clip_relation	= determineClipRelation(h_clip_relations.COMPARE)
	Line.level				= level
	
	Line.additive_alpha		= true
	Line.collimated			= collimated or false
	Line.use_mipfilter		= use_mipfilter
	
	Add(Line)
	
	return Line
end

-- A line which is of enough length to stretch across the entire display
function addAllscrLine(Name, lineParams, originShiftX, connectGap_px, controllers, parent_name, init_pos, init_rot, level, material)
	
	local lineLen = (lineParams.lineXend_px - lineParams.lineXbegin_px - connectGap_px * 2) / pixelsPerMil
	local lineLenHalf = lineLen / 2
	local lineLenHalfWithTip = lineLen * 0.5 + connectGap_px / pixelsPerMil + lineParams.lineEndLen
	
	-- default origin is the middle of the line
	local shiftX = originShiftX or 0
	local clipLevel = level or HMCS_DEFAULT_LEVEL
	
	local line_origin 				= addPlaceholder(Name.."_origin", init_pos)
	line_origin.parent_element 		= parent_name
	line_origin.controllers 		= controllers
	line_origin.init_rot			= {init_rot} or {0}
	
	local lineTexParams = getTexParams(lineParams.lineXbegin_px + (lineParams.lineXend_px - lineParams.lineXbegin_px) / 2, lineParams.lineY_px)
	
	-- outer left segment
	local line_outer_left = AddTexuredElement(Name.."_outer_left",
				makeBoxVerts(-lineLenHalfWithTip, lineLenHalf, -lineWidth / 2, lineWidth / 2),
				lineTexParams,
				nil,
				{-(lineLen + lineLenHalf) + shiftX, 0},
				{},
				clipLevel)

	line_outer_left.parent_element = line_origin.name
	
	if material ~= nil then
		line_outer_left.material   = material
	end
	
	-- inner left segment
	local line_inner_left = AddTexuredElement(Name.."_inner_left",
				makeBoxVerts(-lineLenHalf, lineLenHalf, -lineWidth / 2, lineWidth / 2),
				lineTexParams,
				nil,
				{-lineLenHalf + shiftX, 0},
				{},
				clipLevel)

	line_inner_left.parent_element = line_origin.name
	
	if material ~= nil then
		line_inner_left.material   = material
	end
	
	--[[
	-- center segment
	local line_center = AddTexuredElement(Name.."_center",
				makeBoxVerts(-lineLenHalf, lineLenHalf, -lineWidth / 2, lineWidth / 2),
				lineTexParams,
				nil,
				{shiftX, 0},
				{},
				clipLevel)

	line_center.parent_element = line_origin.name
	
	if material ~= nil then
		line_center.material   = material
	end
	]]
	
	-- inner right segment
	local line_inner_right = AddTexuredElement(Name.."_inner_right",
				makeBoxVerts(-lineLenHalf, lineLenHalf, -lineWidth / 2, lineWidth / 2),
				lineTexParams,
				nil,
				{lineLenHalf + shiftX, 0},
				{},
				clipLevel)

	line_inner_right.parent_element = line_origin.name
	
	if material ~= nil then
		line_inner_right.material   = material
	end
	
	-- outer right segment
	local line_outer_right = AddTexuredElement(Name.."_outer_right",
				makeBoxVerts(-lineLenHalf, lineLenHalfWithTip, -lineWidth / 2, lineWidth / 2),
				lineTexParams,
				nil,
				{lineLen + lineLenHalf + shiftX, 0},
				{},
				clipLevel)

	line_outer_right.parent_element = line_origin.name
	
	if material ~= nil then
		line_outer_right.material   = material
	end
	
end

-- A line of the length that is half of one made by addAllscrLine() function
-- Note that it grows from one of it's ends. I.e. it is suitable for dashed lines of variable length.
function addHalfscrLine(Name, lineParams, originShiftX, connectGap_px, controllers, parent_name, init_pos, init_rot, level, material)
	
	-- lengths relation is the following:
	-- 		len(lineLenNoGap) > len(lineLen)
	-- 		len(lineLenHalfWithTip) > len(lineLenHalf)
	
	-- line piece max length with connection gap [mil]
	local lineLen = (lineParams.lineXend_px - lineParams.lineXbegin_px - connectGap_px * 2) / pixelsPerMil
	-- line piece half of max length with connection gap [mil]
	local lineLenHalf = lineLen * 0.5
	-- line piece half of max length with ending tip [mil]
	local lineLenHalfWithTip = lineLen * 0.5 + connectGap_px / pixelsPerMil + lineParams.lineEndLen
	
	-- default origin is the middle of the line
	local shiftX = originShiftX or 0
	local clipLevel = level or HMCS_DEFAULT_LEVEL
	
	local line_origin 				= addPlaceholder(Name.."_origin", init_pos)
	line_origin.parent_element 		= parent_name
	line_origin.controllers 		= controllers
	line_origin.init_rot			= {init_rot} or {0}
	
	local lineTexParams = getTexParams(lineParams.lineXbegin_px + (lineParams.lineXend_px - lineParams.lineXbegin_px) / 2, lineParams.lineY_px)
	
	-- left segment
	local line_outer_left = AddTexuredElement(Name.."_outer_left",
				makeBoxVerts(-lineLenHalfWithTip, lineLenHalf, -lineWidth / 2, lineWidth / 2),
				lineTexParams,
				nil,
				{-lineLenHalf + shiftX, 0},
				{},
				clipLevel)

	line_outer_left.parent_element = line_origin.name
	
	if material ~= nil then
		line_outer_left.material   = material
	end
	
	-- right segment
	local line_outer_right = AddTexuredElement(Name.."_outer_right",
				makeBoxVerts(-lineLenHalf, lineLenHalfWithTip, -lineWidth / 2, lineWidth / 2),
				lineTexParams,
				nil,
				{lineLenHalf + shiftX, 0},
				{},
				clipLevel)

	line_outer_right.parent_element = line_origin.name
	
	if material ~= nil then
		line_outer_right.material   = material
	end
	
end

-- A variable length line which is of enough length to stretch across the entire display
function addAllscrVarLenLine(Name, lineParams, controllers, line_controller_name, parent_name, init_pos, init_rot, level, material)

	local placeholder = addPlaceholder(Name.."_line_placeholder", init_pos, controllers)
	placeholder.init_rot = {init_rot} or {0}
	placeholder.parent_element = parent_name
	
	local lineLenBasic = (lineParams.lineXend_px - lineParams.lineXbegin_px) / pixelsPerMil
	local lineLenMax = lineLenBasic * 8
	local lineShiftX = lineLenBasic * 2
	
	local maskLen = lineLenMax * 0.5 + lineEndLen * 2
	local maskVerts = makeBoxVerts(0, maskLen, -lineWidth / 2, lineWidth / 2)
	
	local line_material
	if useDBGcolor == true then
		line_material = "INDICATION_HMCS_DBG_DARK"
	else
		line_material = material or "INDICATION_HMCS"
	end
	
	-- Line part 1
	do
		-- opening mask 1
		local omask_1 = openMaskArea(Name .. "_line_omask_1", maskVerts, {{line_controller_name, 2, lineLenMax}}, level)
		omask_1.parent_element = placeholder.name
		--omask_1.isvisible = true
			
		-- first half of the line
		addAllscrLine(Name .. "_line1", lineParams, lineShiftX, 0, {{line_controller_name, 0, lineLenMax}}, placeholder.name, nil, 0, level, line_material)
		
		-- closing mask 1
		local cmask_1 = closeMaskArea(Name .. "_line_cmask_1", maskVerts, {{line_controller_name, 2, lineLenMax}}, level + 1)
		cmask_1.parent_element = placeholder.name
		--cmask_1.isvisible = true
	end
	
	-- Line part 2
	do
		-- opening mask 2
		local omask_2 = openMaskArea(Name .. "_line_omask_2", maskVerts, {{line_controller_name, 3, lineLenMax}}, level)
		omask_2.parent_element = placeholder.name
		omask_2.init_rot = {180}
		--omask_2.isvisible = true
		
		-- second half of the line
		addAllscrLine(Name .. "_line2", lineParams, lineShiftX, 0, {{line_controller_name, 1, lineLenMax}}, placeholder.name, nil, 180, level, line_material)
		
		-- closing mask 2
		local cmask_2 = closeMaskArea(Name .. "_line_cmask_2", maskVerts, {{line_controller_name, 3, lineLenMax}}, level + 1)
		cmask_2.parent_element = placeholder.name
		cmask_2.init_rot = {180}
		--cmask_2.isvisible = true
	end
end

-- A variable length line which is suitable for dashed lines of variable length.
-- It is a modification addAllscrVarLenLine() functions.
function addAllscrDashVarLenLine(Name, lineParams, connectGap_px, controllers, line_controller_name, parent_name, init_pos, init_rot, level, material)
	
	local placeholder = addPlaceholder(Name.."_line_placeholder", init_pos, controllers)
	placeholder.init_rot = {init_rot} or {0}
	placeholder.parent_element = parent_name
	
	-- line piece max length with connection gaps [mil]
	local lineLen = (lineParams.lineXend_px - lineParams.lineXbegin_px - connectGap_px * 2) / pixelsPerMil
	
	local lineLenMax = lineLen * 4 + connectGap_px / pixelsPerMil * 2
	local maskLen = lineLenMax + lineParams.lineEndLen
	local maskVerts = makeBoxVerts(-maskLen, 0, -lineWidth / 2, lineWidth / 2)
		
	local line_material
	if useDBGcolor == true then
		line_material = "INDICATION_HMCS_DBG_DARK"
	else
		line_material = material or "INDICATION_HMCS"
	end
	
	-- opening mask
	local omask = openMaskArea(Name .. "_line_omask", maskVerts, {{line_controller_name, 1, lineLenMax}}, level)
	omask.init_rot = {180}
	omask.parent_element = placeholder.name
	--	omask.isvisible = true
	
	addAllscrLine(Name .. "_line", lineParams, lineLenMax * 0.5, connectGap_px, {{line_controller_name, 0, lineLenMax}}, placeholder.name, nil, nil, level, line_material)
	
	-- closing mask
	local cmask = closeMaskArea(Name .. "_line_cmask", maskVerts, {{line_controller_name, 1, lineLenMax}}, level + 1)
	cmask.init_rot = {180}
	cmask.parent_element = placeholder.name
	--cmask.isvisible = true

end

function CreateDummy()
	local el = CreateElement "ceSimple"
	el.collimated = collimated or false
	
	return el
end

navpt_sz = 13
navpt_half_sz = navpt_sz / 2

local navpt_verts = makeBoxVerts(-navpt_half_sz, navpt_half_sz, -navpt_half_sz, navpt_half_sz)

function addWaypointRectangle(name, controllers)
	local rect = AddTexuredElement(name,
				navpt_verts,
				getTexParams(35, 93),
				controllers,
				{},
				{},
				HMCS_DEFAULT_LEVEL)
				
	return rect
end

function addWaypointSymbol(name, isSteerpoint, ptControllers)
	
	local waypt_kind_idx
	if isSteerpoint == true then
		waypt_kind_idx = 1
	else
		waypt_kind_idx = 0
	end
		
	local controllers = ptControllers or {{"waypoint_kind", waypt_kind_idx}}
	
	local waypt = addWaypointRectangle(name, controllers)
	
	if isSteerpoint == true then
		if useDBGcolor == true then
			waypt.material	= "INDICATION_HMCS_DBG_DARK"
		else
			waypt.material	= "INDICATION_HMCS_YELLOW"
		end
	else
		waypt.parent_element = ""
	end
	
	--add_debug_marker("MARKER 1", stpt.init_pos, 20)
	--local dbg_stpt_side_sz = 8
	--add_debug_marker("SD", {-30 - dbg_stpt_side_sz, 40 + dbg_stpt_side_sz}, 10)

	local navptdot_sz = 4
	local navptdot_half_sz = navptdot_sz / 2

	local waypt_dot = AddTexuredElement(name .. "_Dot",
				makeBoxVerts(-navptdot_half_sz, navptdot_half_sz, -navptdot_half_sz, navptdot_half_sz),
				getTexParams(87, 93),
				nil,
				{},
				{},
				HMCS_DEFAULT_LEVEL)

	waypt_dot.parent_element = waypt.name
	
	if isSteerpoint == true then
		if useDBGcolor == true then
			waypt_dot.material	= "INDICATION_HMCS_DBG_DARK"
		else
			waypt_dot.material	= "INDICATION_HMCS_YELLOW"
		end
	end
	
	local name_controllers = {{"is_symbol_occluded", PRFL_SYMB_MSN_MARK_LABELS, PRFL_SYMB_MSN_MARKPOINTS}, {"waypoint_name"}}
		
	local waypt_name = AddText_Pos(name .. "_Name", 
				name_controllers,
				{0, -navpt_half_sz},
				HMCS_DEFAULT_LEVEL,
				"CenterTop",
				1)
				
	waypt_name.parent_element = waypt.name
	
	if useDBGcolor == true then
		waypt_name.material   = "font_HMCS_DBG_DARK"
	else
		waypt_name.material   = "font_HMCS_BLUE"
	end
	
	--waypt_name.value 		  = "STPT 1"
	
	return waypt
end
