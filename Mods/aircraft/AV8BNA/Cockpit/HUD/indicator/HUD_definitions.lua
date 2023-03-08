dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."HUD/indicator/HUD_Glass_Levels.lua")
dofile(LockOn_Options.script_path.."Displays/Display_Units.lua")
dofile(LockOn_Options.script_path.."Displays/Display_StrokeDefs.lua")

-- Screen units
DItoScreenUnits = DItoMil()
ScreenUnitsToDI = 1 / DItoScreenUnits
dbg_drawStrokesAsWire = false

SetScale(MILLYRADIANS)							-- First we set the scake to millyradians
SetCustomScale(GetScale() * DItoScreenUnits)	-- All vertices in files who include this file will be scaled in Display Increments (DI)

mils_ratio	= MIL_PER_PIXEL_RATIO * MilToDI(HUD_SCALE)

GFOV_radius	=  10  * MilToDI(HUD_SCALE)	-- mils
NFOV_radius	=  125 * MilToDI(HUD_SCALE)	-- mils
TFOV_radius	=  145 * MilToDI(HUD_SCALE)	-- mils
RFOV_radius	=  135 * MilToDI(HUD_SCALE)	-- mils

HUD_Waterline = 7.1 * HUD_SCALE	--Degrees above the HUD center

-- Materials
stroke_font     	= "font_HUD_stroke"
stroke_font_outline	= "font_HUD_stroke_outline"
stroke_material 	= "HUD_GREEN_BRIGHT"
additive_alpha  	= true

-- Display Values
HUD_DEFAULT_LEVEL	= GLASS_LEVEL + 1

tape_is_collimated	= true
tape_hdg_scale		= -0.11775
tape_hdg_depress	= 0.0

hud_base_init_pos   = {0, 115.5, 0} -- {0, 109.5, 0}
tape_init_pos		= { 0, 120.5, 0}

-- Fonts
hud_ind_font		= "font_HUD_indicator"
hud_ind_font_bg		= "font_HUD_indicator_bg"

-- Font Sizes
hud_font_def_size	= {0.007,0.007}
hud_font_min_size	= {0.005,0.005}
hud_font_sml_size	= {0.006,0.006}
hud_font_lrg_size	= {0.009,0.009}
hud_font_Xlg_size	= {0.010,0.010}

hud_font_min_size_bg	= {0.0053,0.0053}

font_size_default	= {0.005,0.005}
hud_font_size_s		= {0.005,0.005}
hud_font_size_m		= {0.006,0.006}
hud_font_size_l		= {0.007,0.007}
hud_font_size_xl	= {0.009,0.009}

--Symbology
hud_hdg_material		= "hud_hdg_material"
hud_pitch_ladder		= "hud_pitch_ladder"
hud_symb_material		= "hud_ind_material"
hud_align_material		= "hud_align_material"
hud_line_indicators		= "hud_lines_material"
hud_dashed_line			= "hud_dashed_lines_material"

hud_lines_width			= 0.6  * MilToDI(HUD_SCALE)

if hud_repeater then
	if hud_repeater == "L" then
		hud_hdg_material		= "hrl_hdg_material"
		hud_pitch_ladder		= "hrl_pitch_ladder"
		hud_symb_material		= "hrl_ind_material"
		hud_align_material		= "hrl_align_material"
		hud_line_indicators		= "hrl_lines_material"
		hud_dashed_line			= "hrl_dashed_lines_material"
		-- Fonts
		hud_ind_font			= "hrl_indication_font"
		-- Stroke
		stroke_font     		= "font_HUD_stroke_rl"
		stroke_font_outline		= "font_HUD_stroke_ol_rl"
		stroke_material 		= "HUD_RL_GREEN_BRIGHT"
	else
		hud_hdg_material		= "hrr_hdg_material"
		hud_pitch_ladder		= "hrr_pitch_ladder"
		hud_symb_material		= "hrr_ind_material"
		hud_align_material		= "hrr_align_material"
		hud_line_indicators		= "hrr_lines_material"
		hud_dashed_line			= "hrr_dashed_lines_material"
		-- Fonts
		hud_ind_font			= "hrr_indication_font"
		-- Stroke
		stroke_font     		= "font_HUD_stroke_rr"
		stroke_font_outline		= "font_HUD_stroke_ol_rr"
		stroke_material 		= "HUD_RR_GREEN_BRIGHT"
	end
end

-- Stroke Fonts
-- WARNING! The only available fonts sizes for MDG stroke symbology are: 100% (20 DI), 120%, 150%, 200%
-- Do not define your own sizes!

-- AV-8B NA MDG DIs (display increments)
glyphNominalHeight100 = 20
glyphNominalWidth100  = 12
glyphAspect = glyphNominalWidth100 / glyphNominalHeight100

glyphNominalHeight120 = glyphNominalHeight100 * 1.2
glyphNominalHeight150 = glyphNominalHeight100 * 1.5
glyphNominalHeight200 = glyphNominalHeight100 * 2

glyphNominalWidth120 = roundDI(glyphNominalWidth100 * 1.2)
glyphNominalWidth150 = glyphNominalWidth100 * 1.5
glyphNominalWidth200 = glyphNominalWidth100 * 2

fontScaleY_100 = glyphNominalHeight100 * GetScale() * HUD_SCALE
fontScaleY_120 = glyphNominalHeight120 * GetScale() * HUD_SCALE
fontScaleY_150 = glyphNominalHeight150 * GetScale() * HUD_SCALE
fontScaleY_200 = glyphNominalHeight200 * GetScale() * HUD_SCALE

fontScaleX_100 = glyphNominalWidth100 * GetScale() * HUD_SCALE
fontScaleX_120 = glyphNominalWidth120 * GetScale() * HUD_SCALE
fontScaleX_150 = glyphNominalWidth150 * GetScale() * HUD_SCALE
fontScaleX_200 = glyphNominalWidth200 * GetScale() * HUD_SCALE

fontIntercharDflt100 		= 4 * HUD_SCALE
fontIntercharDflt120 		= 6 * HUD_SCALE
fontIntercharDflt150 		= 6 * HUD_SCALE
fontIntercharDflt200 		= 12 * HUD_SCALE
fontIntercharDflt120_wide 	= 9 * HUD_SCALE
fontIntercharDflt150_wide 	= 9 * HUD_SCALE

fontInterlineDflt100 		= 5 * HUD_SCALE
fontInterlineDflt120 		= 6 * HUD_SCALE
fontInterlineDflt150 		= 12 * HUD_SCALE
fontInterlineDflt200 		= 12 * HUD_SCALE

STROKE_FNT_DFLT_100 		= 1
STROKE_FNT_DFLT_120 		= 2
STROKE_FNT_DFLT_150 		= 3
STROKE_FNT_DFLT_200 		= 4
STROKE_FNT_DFLT_120_WIDE 	= 5
STROKE_FNT_DFLT_150_WIDE 	= 6

stringdefs	= {}
stringdefs[STROKE_FNT_DFLT_100] 		= {fontScaleY_100, fontScaleX_100, fontIntercharDflt100 * GetScale(), fontInterlineDflt100 * GetScale()}
stringdefs[STROKE_FNT_DFLT_120] 		= {fontScaleY_120, fontScaleX_120, fontIntercharDflt120 * GetScale(), fontInterlineDflt120 * GetScale()}
stringdefs[STROKE_FNT_DFLT_150] 		= {fontScaleY_150, fontScaleX_150, fontIntercharDflt150 * GetScale(), fontInterlineDflt150 * GetScale()}
stringdefs[STROKE_FNT_DFLT_200] 		= {fontScaleY_200, fontScaleX_200, fontIntercharDflt200 * GetScale(), fontInterlineDflt200 * GetScale()}
stringdefs[STROKE_FNT_DFLT_120_WIDE] 	= {fontScaleY_120, fontScaleX_120, fontIntercharDflt120_wide * GetScale(), fontInterlineDflt150 * GetScale()}
stringdefs[STROKE_FNT_DFLT_150_WIDE] 	= {fontScaleY_150, fontScaleX_150, fontIntercharDflt150_wide * GetScale(), fontInterlineDflt150 * GetScale()}

--
local symbol_texture_size_x = 1024
local symbol_texture_size_y = 1024

local texture_size_x = 1024
local texture_size_y = 1024

local hdg_text_size_x = 3721
local hdg_text_size_y = 80

box_indices =
{
	0,1,2;0,2,3
}

-- Heading Tape
function hdg_texture_box (UL_X,UL_Y,W,H)
	local ux = UL_X / hdg_text_size_x
	local uy = UL_Y / hdg_text_size_y
	local w  = W / hdg_text_size_x
	local h  = H / hdg_text_size_y
	return {
		{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}
	}
end

function create_hdg_textr_box(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)
	
	local mils_per_pixel = mils_ratio	--100/275
	local W 	   		 = DR_X - UL_X
	local H 	   		 = DR_Y - UL_Y
	local cx		     = (UL_X + 0.5 * W)
	local cy		     = (UL_Y + 0.5 * H)
	
	local CENTER_X 		 = CENTER_X or cx
	local CENTER_Y 		 = CENTER_Y or cy
	local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
	local dcy 		     = mils_per_pixel * (CENTER_Y - cy)
	
	local half_x 		 = 0.5 * W * mils_per_pixel
	local half_y 		 = 0.5 * H * mils_per_pixel
	
	local	object = CreateElement "ceTexPoly"
			object.material =  hud_hdg_material
			object.vertices =  {{-half_x - dcx, half_y + dcy},
								{ half_x - dcx, half_y + dcy},
								{ half_x - dcx,-half_y + dcy},
								{-half_x - dcx,-half_y + dcy}}
			object.tex_coords = hdg_texture_box(UL_X,UL_Y,W,H)
			object.indices	  = box_indices
	return object
end

-- Symbols
function symbol_texture_box (UL_X,UL_Y,W,H)
	local ux = UL_X / symbol_texture_size_x
	local uy = UL_Y / symbol_texture_size_y
	local w  = W / symbol_texture_size_x
	local h  = H / symbol_texture_size_y
	return {
		{ux	    ,uy},
		{ux + w ,uy},
		{ux + w ,uy + h},
		{ux	 	,uy + h}
	}
end

function create_hud_symbol(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)
	
	local mils_per_pixel = mils_ratio	--100/275
	local W 	   		 = DR_X - UL_X
	local H 	   		 = DR_Y - UL_Y
	local cx		     = (UL_X + 0.5 * W)
	local cy		     = (UL_Y + 0.5 * H)
	
	local CENTER_X 		 = CENTER_X or cx
	local CENTER_Y 		 = CENTER_Y or cy
	local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
	local dcy 		     = mils_per_pixel * (CENTER_Y - cy)
	
	local half_x 		 = 0.5 * W * mils_per_pixel
	local half_y 		 = 0.5 * H * mils_per_pixel
	
	local object = CreateElement "ceTexPoly"
	object.material =  hud_symb_material
	object.vertices =  {
		{-half_x - dcx, half_y + dcy},
		{ half_x - dcx, half_y + dcy},
		{ half_x - dcx,-half_y + dcy},
		{-half_x - dcx,-half_y + dcy}
	}
	object.tex_coords = symbol_texture_box(UL_X,UL_Y,W,H)
	object.indices	= box_indices
	
	return object
end

function create_hud_symbol_bg(UL_X,UL_Y,DR_X,DR_Y,CENTER_X,CENTER_Y)
	
	local mils_per_pixel = mils_ratio	--100/275
	local W 	   		 = DR_X - UL_X
	local H 	   		 = DR_Y - UL_Y
	local cx		     = (UL_X + 0.5 * W)
	local cy		     = (UL_Y + 0.5 * H)
	
	local CENTER_X 		 = CENTER_X or cx
	local CENTER_Y 		 = CENTER_Y or cy
	local dcx 		 	 = mils_per_pixel * (CENTER_X - cx)
	local dcy 		     = mils_per_pixel * (CENTER_Y - cy)
	
	local half_x 		 = 0.5 * W * mils_per_pixel
	local half_y 		 = 0.5 * H * mils_per_pixel
	
	local object = CreateElement "ceTexPoly"
	object.material =  hud_bg_symb_material
	object.vertices =  {
		{-half_x - dcx, half_y + dcy},
		{ half_x - dcx, half_y + dcy},
		{ half_x - dcx,-half_y + dcy},
		{-half_x - dcx,-half_y + dcy}
	}
	object.tex_coords = symbol_texture_box(UL_X,UL_Y,W,H)
	object.indices	= box_indices
	
	return object
end

--------------
function AddHUDElement(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = HUD_DEFAULT_LEVEL
	object.additive_alpha     = ALPHA_BLEND
	object.collimated 		  = collimated
	Add(object)
end

-- Stroke Functions

function AddHUDStrokeSymbol(object, _stroke, thick_factor)
	local t_factor = 1.0
	
	if thick_factor ~= nil then
		t_factor = thick_factor
	end
	
	object.alignment		= "FromSet"
	object.thickness    	= stroke_thickness * t_factor
	object.fuzziness    	= stroke_fuzziness * t_factor
	object.isdraw			= true
	object.draw_as_wire 	= dbg_drawStrokesAsWire
	object.use_mipfilter	= true
	object.h_clip_relation	= h_clip_relations.COMPARE
	object.level			= HUD_DEFAULT_LEVEL
	object.additive_alpha	= ALPHA_BLEND
	object.collimated		= collimated
	Add(object)
end



function addHUDText(name, value, formats, stringdef, align, pos, parent, controller, stroke)

	pos = pos or {0, 0}
	
	local _alignment = "CenterCenter"
	local has_stroke = false
	local pos_x = pos[1]
	local pos_y = pos[2]
	
	if align ~= nil then
		_alignment = align
	end
	
	local	HUD_Text					= CreateElement "ceStringSLine"
			HUD_Text.name				= name
			HUD_Text.material			= stroke_font
			HUD_Text.init_pos			= {pos[1] * MilToDI(HUD_SCALE), pos[2] * MilToDI(HUD_SCALE), 0}
			if value ~= nil then
				HUD_Text.value			= value
			end
			HUD_Text.formats			= formats
			HUD_Text.stringdefs			= stringdefs[stringdef]
			if align ~= nil then
				HUD_Text.alignment = align
			else
				HUD_Text.alignment = "CenterCenter"
			end
			if parent ~= nil then
				HUD_Text.parent_element = parent
			end
			if controllers ~= nil then
				if type(controllers) == "table" then
					HUD_Text.controllers = controllers
				end
			end
			HUD_Text.isdraw				= true
			HUD_Text.use_mipfilter      = true
			HUD_Text.h_clip_relation    = h_clip_relations.COMPARE
			HUD_Text.level				= HUD_DEFAULT_LEVEL
			HUD_Text.additive_alpha     = ALPHA_BLEND
			HUD_Text.collimated 		= collimated
	Add(HUD_Text)
	
end


function addPlaceholder(name, pos, parent, controllers)
	local placeholder       	= CreateElement "ceSimple"
	placeholder.name        	= name
	pos = pos or {0, 0}
	placeholder.init_pos    	= {pos[1], pos[2], 0}
	placeholder.collimated  	= collimated or false

	if parent ~= nil then
		placeholder.parent_element 	= parent
	end	
	
	if controllers ~= nil then
		placeholder.controllers		= controllers
	end
	
	Add(placeholder)
	return placeholder
end

function setAsInvisibleMask(obj)
	obj.isvisible = show_masks
	obj.material  = "MASK_MATERIAL_PURPLE"
	--obj.material  = "MASK_MATERIAL_PURPLE_2" -- a brighter variant
end

function setClipLevel(obj, level)
	level = level or 0
	obj.h_clip_relation = h_clip_relations.COMPARE
	--obj.h_clip_relation = h_clip_relations.NULL
	obj.level 		    = HUD_DEFAULT_LEVEL + level
end


-- NOTE
-- 'pos' is passed as a two-component table - x and y coordinates
function setSymbolCommonProperties(symbol, name, pos, parent, controllers, material)
	symbol.name               = name
	symbol.isdraw             = true
	symbol.material           = material or default_material
	symbol.additive_alpha	  = ALPHA_BLEND or false
	symbol.collimated		  = collimated or false
	symbol.use_mipfilter      = use_mipfilter
	
	if parent ~= nil then
		symbol.parent_element = parent
	end
	
	if controllers ~= nil then
		if type(controllers) == "table" then
			symbol.controllers = controllers
		end
	end
	
	pos = pos or {0, 0}
	symbol.init_pos       	  = {pos[1], pos[2], 0}
	
	setClipLevel(symbol)
end

local function setSymbolAlignment(symbol, align)
	if align ~= nil then
		symbol.alignment = align
	else
		symbol.alignment = "CenterCenter"
	end
end

local function setStrokeSymbolProperties(symbol)

	if override_materials == true then
		-- Is used for outlined font generated by DMC
		symbol.thickness    		= override_thickness
		symbol.fuzziness    		= override_fuzziness
	else
		symbol.thickness    		= stroke_thickness
		symbol.fuzziness    		= stroke_fuzziness
	end

	symbol.draw_as_wire 		= dbg_drawStrokesAsWire
	--symbol.use_specular_pass 	= false -- ommitted for now as is set for the entire indicator
end

local function buildStrokeLineVerts(length, dashed, stroke, gap)
	local verts = {}
	local inds = {}
	
	if dashed == true and stroke ~= nil and gap ~= nil then
		local segLength = stroke + gap
		local numOfWholePairs = math.floor(length / segLength)
		local reminder = length - numOfWholePairs * segLength
		
		local function addSeg(num)
			local shift1 = num * 2
			verts[shift1 + 1] = {0, num * segLength}
			verts[shift1 + 2] = {0, num * segLength + stroke}
			
			inds[shift1 + 1] = shift1
			inds[shift1 + 2] = shift1 + 1
		end
		
		for segNum = 0, numOfWholePairs - 1 do
			addSeg(segNum)
		end
		
		if reminder > 0 then
			if reminder >= stroke then
				addSeg(numOfWholePairs)
			else
				local shift1 = numOfWholePairs * 2
				verts[shift1 + 1] = {0, numOfWholePairs * segLength}
				verts[shift1 + 2] = {0, numOfWholePairs * segLength + reminder}
				
				inds[shift1 + 1] = shift1
				inds[shift1 + 2] = shift1 + 1
			end
		end
	else
		verts = {{0, 0}, {0, length}}
		inds  = {0, 1}
	end
	
	return verts, inds
end

-- Shared functions

-- Stroke text with glyphs described in a .svg file
function addStrokeText(name, value, stringdef, align, pos, parent, controllers, formats)
	local txt = CreateElement "ceStringSLine"
	setSymbolCommonProperties(txt, name, pos, parent, controllers, stroke_font)
	setSymbolAlignment(txt, align)
	
	-- custom size is noted in documents as in percents from the original one
	if type(stringdef) == "table" then
		txt.stringdefs = stringdef
	else
		txt.stringdefs = stringdefs[stringdef]
	end
	
	if value ~= nil then
		txt.value = value
	end
	
	txt.formats 		= formats
	
	Add(txt)
	
	return txt
end

-- Stroke symbol with points described in a .svg file
function addStrokeSymbol(name, set, align, pos, parent, controllers, scale, material)
	local symbol       = CreateElement "ceSMultiLine"
	setSymbolCommonProperties(symbol, name, pos, parent, controllers, material)
	setSymbolAlignment(symbol, align)
	setStrokeSymbolProperties(symbol)
	symbol.points_set  = set
	symbol.scale       = scale or 1
	Add(symbol)
	return symbol
end

-- Stroke line
-- rot (CCW in degrees from up)
-- pos (position of beginning of the line)
function addStrokeLine(name, length, pos, rot, parent, controllers, dashed, stroke, gap, material)
	local line      = CreateElement "ceSMultiLine"
	setSymbolCommonProperties(line, name, pos, parent, controllers, material)
	setStrokeSymbolProperties(line)
	
	if rot ~= nil then
		line.init_rot   = {rot}
	end
		
	local verts, inds = buildStrokeLineVerts(length, dashed, stroke, gap)
	line.vertices   = verts
	line.indices    = inds
	
	Add(line)
	return line
end

-- Stroke line of variable length
function addVarLenStrokeLine(name, length, pos, rot, parent, controllers, dashed, stroke, gap, material)
	local line      = CreateElement "ceSVarLenLine"
	setSymbolCommonProperties(line, name, pos, parent, controllers, material)
	setStrokeSymbolProperties(line)
	
	if rot ~= nil then
		line.init_rot   = {rot}
	end
	
	if length ~= nil then
		line.length     = length
	end
	
	local verts, inds = buildStrokeLineVerts(HUD_TFOV_DI * 4, dashed or false, stroke, gap)
	line.vertices   = verts
	line.indices    = inds
	
	Add(line)
	return line
end

-- Box made of stroke lines. Use case - HUD TD box (non-segmented)
function addStrokeBox(name, sideX, sideY, align, pos, parent, controllers, material)
	local box      = CreateElement "ceSMultiLine"
	setSymbolCommonProperties(box, name, pos, parent, controllers, material)
	setSymbolAlignment(box, align)
	setStrokeSymbolProperties(box)
	
	local halfSideX = sideX / 2
	local halfSideY = sideY / 2
	box.vertices    = {{-halfSideX, -halfSideY}, {-halfSideX, halfSideY}, {halfSideX, halfSideY}, {halfSideX, -halfSideY}}
	box.indices     = line_box_indices
	
	Add(box)
	return box
end

-- Segmented box made of stroke lines. Use case - HUD segmented TD box
function addStrokeBoxSegmented(name, sideX, sideY, segmentX, segmentY, align, pos, parent, controllers, material)
	local box      = CreateElement "ceSMultiLine"
	setSymbolCommonProperties(box, name, pos, parent, controllers, material)
	setSymbolAlignment(box, align)
	setStrokeSymbolProperties(box)
	
	local halfSideX = sideX / 2
	local halfSideY = sideY / 2
	local lineLenX  = halfSideX - segmentX / 2
	local lineLenY  = halfSideY - segmentY / 2
	box.vertices    = {{-halfSideX, -halfSideY}, {-halfSideX, -halfSideY + lineLenY}, {-halfSideX, halfSideY - lineLenY},
					   {-halfSideX, halfSideY}, {-halfSideX + lineLenX, halfSideY}, {halfSideX - lineLenX, halfSideY},
					   {halfSideX, halfSideY}, {halfSideX, halfSideY - lineLenY}, {halfSideX, -halfSideY + lineLenY},
					   {halfSideX, -halfSideY}, {halfSideX - lineLenX, -halfSideY}, {-halfSideX + lineLenX, -halfSideY}}
	box.indices     = {0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11, 0}
	
	Add(box)
	return box
end

-- Dashed box made of stroke lines. Align - CenterCenter
function addStrokeBoxDashed(name, sideX, sideY, stroke, gap, pos, parent, controllers, material)

	local root = addPlaceholder(name, pos, parent, controllers)

	addStrokeLine(name.."_left", sideY, {-sideX / 2, -sideY / 2}, 0, root.name, nil, true, stroke, gap, material)
	addStrokeLine(name.."_right", sideY, {sideX / 2, -sideY / 2}, 0, root.name, nil, true, stroke, gap, material)
	addStrokeLine(name.."_top", sideX, {-sideX / 2, sideY / 2}, -90, root.name, nil, true, stroke, gap, material)
	addStrokeLine(name.."_bottom", sideX, {-sideX / 2, -sideY / 2}, -90, root.name, nil, true, stroke, gap, material)
end

-- Equilateral triangle. Center point is at the top end.
-- The element is rotated about its center point by 'rot' angle, and then 'pos_shift' is applied.
function addStrokeEquilateralTriangle(name, height, angle, pos, rot, pos_shift, parent, controllers, material)
	local triangle      = CreateElement "ceSMultiLine"
	setSymbolCommonProperties(triangle, name, pos, parent, controllers, material)
	setStrokeSymbolProperties(triangle)
	
	local rot_lcl = rot or 0
	-- The angle is limited in the range of 1 to 179 degrees
	local base_angle = 180 - math.max(1, math.min(angle, 179)) / 2
	
	local angle1 = math.rad(-base_angle + rot_lcl)
	local angle2 = math.rad(base_angle + rot_lcl)
	
	local pt2_x = height * math.sin(angle1)
	local pt2_y = height * math.cos(angle1)
	local pt3_x = height * math.sin(angle2)
	local pt3_y = height * math.cos(angle2)

	local shift_x = 0
	local shift_y = 0
	
	if pos_shift ~= nil then
		shift_x = pos_shift[1]
		shift_y = pos_shift[2]
	end
	
	triangle.vertices    = {{shift_x, shift_y}, {pt2_x + shift_x, pt2_y + shift_y}, {pt3_x + shift_x, pt3_y + shift_y}}
	triangle.indices     = {0, 1, 1, 2, 2, 0}
	
	Add(triangle)
	return triangle
end

-- Stroke circle
function addStrokeCircle(name, radius, pos, parent, controllers, arc, segment, gap, dashed, material)
	local segmentsN = 64
	
	local circle     		= CreateElement "ceSCircle"
	setSymbolCommonProperties(circle, name, pos, parent, controllers, material)
	setStrokeSymbolProperties(circle)
	circle.radius    	 	= {radius, radius}
	circle.arc       		= arc or {0, math.pi * 2}
	circle.segment      	= segment or math.pi * 4 / segmentsN
	circle.gap      		= gap or math.pi * 4 / segmentsN
	circle.segment_detail   = 4
	
	if dashed ~= nil then
		circle.dashed    	= dashed
	else
		circle.dashed    	= false
	end
	
	Add(circle)
	return circle
end

-- Non-textured mesh, which is drawn by either triangles or by zero-width lines ('primitives' parameter)
function addMesh(name, vertices, indices, pos, primitives, parent, controllers, material)
	local mesh     			= CreateElement "ceMeshPoly"
	setSymbolCommonProperties(mesh, name, pos, parent, controllers, material)
	mesh.vertices			= vertices
	mesh.indices			= indices
	mesh.primitivetype		= primitives
	Add(mesh)
	return mesh
end

-- Triangulated line. The line is created as a mesh object.
-- Described by points like a stroke line.
--
-- NOTE: the parameters are the same as of the stroke line, instead that 'width' parameter added.
-- WARNING: the function is a test feature, 'width' parameter is not taken into account yet even if is set.
-- WARNING: commented until is complete
--[[
function addTriangulatedLine(name, length, width, pos, rot, parent, controllers, dashed, stroke, gap, material)
	-- TODO: to merge code common with addStrokeLine() (to add a dedicated function)
	local line      = CreateElement "ceTMultiLine"
	setSymbolCommonProperties(line, name, pos, parent, controllers, material)
	setStrokeSymbolProperties(line)
	
	if rot ~= nil then
		line.init_rot   = {rot}
	end
	
	local verts, inds = buildStrokeLineVerts(length, dashed, stroke, gap)
	-- WARNING: parameters below are not read now as parent class (ceParsedElement) does not support it
	line.vertices   = verts
	line.indices    = inds
	-- TODO: to add parameter read in cpp class
	--line.width	= width
	
	Add(line)
	return line
end
]]

-- A symbology clipping region. May be used to limit the area where an element is visible/hidden.
--  In aircraft manuals also called 'occultation area/mask'.
local function createMask(name, vertices, indices, pos, parent, controllers, material)
	local mask            = addMesh(name, vertices, indices, pos, "triangles", parent, controllers)
	setAsInvisibleMask(mask) -- changes material
	mask.additive_alpha	  = false
	mask.change_opacity   = false
	
	if material ~= nil then
		mask.material     = material
	end

	return mask
end

-- See above. Creates the region, and sets its occultation level.
-- Will increase the currently used level value, and will affect symbology 
--  according to 'h_clip_relation' field value of each element rendered after it.
function openMaskArea(level, name, vertices, indices, pos, parent, controllers, material)
	local mask            = createMask(name, vertices, indices, pos, parent, controllers, material)
	mask.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
	mask.level 		      = DEFAULT_LEVEL + level
	return mask
end

-- Same as above, but removes the previously created clipping region.
function closeMaskArea(level, name, vertices, indices, pos, parent, controllers, material)
	local mask            = createMask(name, vertices, indices, pos, parent, controllers, material)
	mask.h_clip_relation  = h_clip_relations.DECREASE_IF_LEVEL
	mask.level 		      = DEFAULT_LEVEL + level
	return mask
end

-- Debug reference grid. Fits for both HUD and MDI/AMPCD
function dbg_add_MDG_RefGrid(step, halfWidth, collimated, noTFOV)
	local lines_count = math.ceil(halfWidth / step)
	if noTFOV == true then
		drawIndicatorRefGrid(lines_count, step, 2 * halfWidth, collimated)
	else
		drawIndicatorRefGrid(lines_count, step, 2 * halfWidth, collimated, halfWidth)
	end
end

-- Debug indicator display center (optical center in the case of HUD)
function dbg_addIndicatorCenter()
	
	do return end -- comment if you want the debug cross to be displayed
	
	-- new way - cross
	local crossSz 		= 40
	local side 			= crossSz * 0.5
	local vertices 		= {{-side, 0}, {side, 0}, {0, side}, {0, -side}}
	local indices  		= {0, 1, 2, 3}
	addMesh("indicator_center", vertices, indices, {0, 0}, "lines", nil, nil, "DBG_RED")
	
	do return end
	
	-- old way - circle
	local dbgCenter         = CreateElement "ceMeshPoly"
	dbgCenter.name          = "indicator_center"
	dbgCenter.primitivetype = "triangles"
	set_circle(dbgCenter, 6, 3)
	dbgCenter.material      = "DBG_RED"
	dbgCenter.collimated    = collimated or false
	Add(dbgCenter)
end

function set_box(obj, left, right, up, down)
	local verts    = {
	{left,  down},
	{left,  up},
	{right, up},
	{right, down}}
	
	local inds = {0, 1, 2,
				  0, 2, 3}
	
	obj.vertices = verts              
	obj.indices  = inds
end

function set_box_w_h(obj, width, height)
	set_box(obj, -width/2, width/2, height/2, -height/2)
end

-- arc is decreased counterclockwise by controllers in the range of 360 - 0 degrees
function addStrokeVarArc(name, radius, rot, pos, parent, controllerMask, controllerMain, level)
	local maskSide = radius
	
	-- right half of the circle (arc)
	local openingMaskRight = openMaskArea(level, name.."_openingMaskRight", {}, {}, pos, parent, controllerMask)
	set_box(openingMaskRight, 0, maskSide + 5, maskSide + 5, -(maskSide + 5))
	
	rot = rot or 0
	
	openingMaskRight.init_rot = {rot - 180}
	--openingMaskRight.isvisible = true -- dbg
	
	addStrokeArc(name.."_right", radius, 180, rot, pos, parent, nil, 1)

	local closingMaskRight = closeMaskArea(level + 1, name.."_closingMaskRight",
		openingMaskRight.vertices, openingMaskRight.indices, openingMaskRight.init_pos, parent, controllerMask)
	closingMaskRight.init_rot = {rot - 180}
	--closingMaskRight.isvisible = true -- dbg
	
	-- left half of the circle (arc)
	local openingMaskLeft = openMaskArea(level, name.."_openingMaskLeft", {}, {}, pos, parent, controllerMask)
	set_box(openingMaskLeft, -(maskSide + 5), 0, maskSide + 5, -(maskSide + 5))
	openingMaskLeft.init_rot = {rot}
			
	addStrokeArc(name.."_left", radius, 180, rot + 180, pos, parent, controllerMain, 0)

	local closingMaskLeft = closeMaskArea(level + 1, name.."_closingMaskLeft",
		openingMaskLeft.vertices, openingMaskLeft.indices, openingMaskLeft.init_pos, parent, controllerMask)
	openingMaskLeft.init_rot = {rot}
end

function addStrokeArc(name, radius, arc, rot, pos, parent, controllers, level)
	local obj = CreateElement "ceSMultiLine"

	local MaxSegments = 64
	
	local arc = arc or 360
	if arc > 360 then
		arc = 360
	end
		
	local count = math.ceil(arc / 360 * MaxSegments)
	local delta = math.rad(arc/count)
	
	setSymbolCommonProperties(obj, name, pos, parent, controllers)
	
	if rot ~= nil then
		obj.init_rot   = {rot}
	end
	
	setStrokeSymbolProperties(obj)
	
	local verts    = {}
	local inds     = {}

	for i = 1, count + 1 do
		verts[i] = {radius * math.sin(delta * (i - 1)), radius * math.cos(delta * (i - 1))}
	end
	
	for i = 1, count do
		inds[2*(i-1) + 1] = i - 1
		inds[2*(i-1) + 2] = i
	end

	obj.vertices         = verts              
	obj.indices          = inds

	setClipLevel(obj, level or 0)
	
	Add(obj)
	return obj
end

function addStrokeArcIndicator(name, radius, rot, pos, parent, controller, level)
	local maskSide = radius

	-- Right half of the circle (arc)
	controller[1][#controller[1] + 1] = 0
	local openingMaskRight = openMaskArea(level, name.."_openingMaskRight", {}, {}, pos, parent, controller)
	set_box(openingMaskRight, -(maskSide + 5), 0, maskSide + 5, -(maskSide + 5)) ---(obj, left, right, up, down)

	addStrokeArc(name.."_Right", radius, 180, rot, pos, parent, nil, 0)
	

	local closingMaskRight = closeMaskArea(level + 1, name.."_closingMaskRight",
		openingMaskRight.vertices, openingMaskRight.indices, openingMaskRight.init_pos, parent, controller)
	openingMaskRight.init_rot = {rot}

	-- Left half of the circle (arc)
	controller[1][#controller[1]] = 1
	local openingMaskLeft = openMaskArea(level, name.."_openingMaskLeft", {}, {}, pos, parent, controller)
	set_box(openingMaskLeft, 0, maskSide + 5, maskSide + 5, -(maskSide + 5)) ---(obj, left, right, up, down)

	addStrokeArc(name.."_left", radius, 180, rot + 180, pos, parent, nil, 0)

	local closingMaskLeft = closeMaskArea(level + 1, name.."_closingMaskLeft",
		openingMaskLeft.vertices, openingMaskLeft.indices, openingMaskLeft.init_pos, parent, controller)
	openingMaskLeft.init_rot = {rot}
end

function addTexturedMesh(name, material, vertices, tex_params, pos, rot, parent, controllers)
	if material == nil then
		do return end
	end
	
	local texturedMexh		= CreateElement "ceTexPoly"
	setSymbolCommonProperties(texturedMexh, name, pos, parent, controllers, material)
	
	texturedMexh.indices		= default_box_indices
	texturedMexh.vertices		= vertices
	texturedMexh.tex_params 	= tex_params 
	
	if rot ~= nil then
		texturedMexh.init_rot   = {rot}
	end
	
	Add(texturedMexh)
	return texturedMexh
end

-- Shaped arrow contour. Is used for SPIN format left/right arrows, also for HUD GPWS/TAWS Recovery Cue
function addArrowContour(Name, arrLength, arrWidth, headLength, headWidth, pos, rot, parent, controllers, isBack, backDeep)
	if arrLength > headLength then
		if headWidth > arrWidth then
			local ArrName = "Arrow_"..Name

			local ArrPH = addPlaceholder(ArrName, pos, parent, controllers)
			addStrokeLine(ArrName.."_Body_Top", arrLength - headLength, {arrLength/2 , arrWidth/2}, 90, ArrName)
			addStrokeLine(ArrName.."_Body_Down", arrLength - headLength, {arrLength/2 , -arrWidth/2}, 90, ArrName)
			addStrokeLine(ArrName.."_Head_Back_Top", (headWidth - arrWidth) / 2, {-(arrLength/2 - headLength), arrWidth/2}, 0, ArrName)
			addStrokeLine(ArrName.."_Head_Back_Down", (headWidth - arrWidth) / 2, {-(arrLength/2 - headLength), -arrWidth/2}, 180, ArrName)
			local Hypotenuse = math.ceil(math.sqrt((headWidth / 2)^2 + headLength ^ 2))
			local Angle = math.ceil(math.deg(math.atan((headWidth / 2) / headLength)))

			addStrokeLine(ArrName.."_Head_Body_Top", Hypotenuse, {-arrLength/2, 0}, Angle - 90, ArrName)
			addStrokeLine(ArrName.."_Head_Body_Down", Hypotenuse, {-arrLength/2, 0}, -Angle - 90, ArrName)

			if isBack then
				local BackHypotenuse = math.ceil(math.sqrt((arrWidth / 2)^2 + backDeep ^ 2))
				local BackAngle = math.ceil(math.deg(math.atan((arrWidth / 2) / backDeep)))

				addStrokeLine(ArrName.."_Back_Body_Top", BackHypotenuse, {arrLength/2 - backDeep, 0}, BackAngle - 90, ArrName)
				addStrokeLine(ArrName.."_Back_Body_Down", BackHypotenuse, {arrLength/2 - backDeep, 0}, -BackAngle - 90, ArrName)
			else
				addStrokeLine(ArrName.."_Back", arrWidth, {arrLength/2 , -arrWidth/2}, 0, ArrName)
			end

			if rot ~= nil then
				ArrPH.init_rot = {rot}
			end
	
		end
	end
end

-- X over a display element - text, symbol, etc
function add_X_Over(name, width, height, pos, parent, controllers)
	local rootName = name.."_Root"
	local angle = math.floor(math.deg(math.atan(height / width)))
	local hypotenuse = math.floor(math.sqrt(height ^ 2 + width ^ 2))

	addPlaceholder(rootName, pos, parent, controllers)
	addStrokeLine(name.."_BottomLine", hypotenuse, {-width / 2, -height / 2}, -90 + angle, rootName)
	addStrokeLine(name.."_TopLine", hypotenuse, {-width / 2, height / 2}, -90 - angle, rootName)
end

-- The caret is pointed down by default
function addCaretByWidthHeight(name, width, height, pos, rot, parent, controllers)
	local elevCaretAngle   = math.atan((height/2)/width)
	local elevCaretLineLen = width / math.cos(elevCaretAngle)
	
	rot = rot or 0
	
	local caretPlaceholder = addPlaceholder(name.."_placeholder", pos, parent, controllers)
	addStrokeLine(name.."_line1", elevCaretLineLen, nil, rot + math.deg(elevCaretAngle), caretPlaceholder.name)
	addStrokeLine(name.."_line2", elevCaretLineLen, nil, rot - math.deg(elevCaretAngle), caretPlaceholder.name)
	
	return caretPlaceholder
end

-- The arrow is pointed up by default
function addArrow(name, length, pointerLen, pointerAngle, posShift, pos, rot, parent, controllers)
	rot = rot or 0
	
	local posAngle = math.rad(-rot)

	local arrowPlaceholder = addPlaceholder(name.."_placeholder", pos, parent, controllers)
	
	-- main line
	local arrowPos = {posShift * math.sin(posAngle), posShift * math.cos(posAngle)}
	addStrokeLine(name.."_mainLine", length, arrowPos, rot, arrowPlaceholder.name)
	
	-- pointer lines
	local pointerPosShift = posShift + length
	local pointerPos = {pointerPosShift * math.sin(posAngle), pointerPosShift * math.cos(posAngle)}
	
	local pointerAngleHalf = pointerAngle / 2
	addStrokeLine(name.."_pointerLine1", pointerLen, pointerPos, 180 + rot + pointerAngleHalf, arrowPlaceholder.name)
	addStrokeLine(name.."_pointerLine2", pointerLen, pointerPos, 180 + rot - pointerAngleHalf, arrowPlaceholder.name)
	
	return arrowPlaceholder
end

function addDot(name, radius, pos, parent, controllers)
	return addStrokeCircle(name, radius, pos, parent, controllers, nil, math.pi * 2 / 4)
end

-- TDC priority/sensor assignment indicator
function addMPD_TDC_diamond()
	local posX = 448
	local posY = 455
	local boxSide = 18
	
	local placeholder = addPlaceholder("TDC_diamond_placeholder", {posX, posY}, nil, {{"TDC_assignedDisplay"}})
	local box = addStrokeBox("TDC_diamond_box", boxSide, boxSide, "CenterCenter", nil, placeholder.name)
	-- make the diamond from the box 
	addStrokeCircle("TDC_diamond_box_DOT", 1, nil, box.name)
	box.init_rot = {45}
end
