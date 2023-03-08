-- NOTE: must set INDICATOR_LEVEL before including this file
assert(INDICATOR_LEVEL, "INDICATOR_LEVEL must be set!")

general_page_path = LockOn_Options.script_path.."Scripts/IndicatorDisplayScripts/"

scale = scale or 1.0
_screen_origin = _screen_origin or {0,0,0}
_screen_rotation = _screen_rotation or {0,0,0}

function AddElement(object, use_alpha, use_mipfilter)
    if use_mipfilter ~= nil then
        object.use_mipfilter = use_mipfilter
    else
        object.use_mipfilter = true
    end
    if use_alpha ~= nil then
        object.additive_alpha = use_alpha
    else
        object.additive_alpha = true
    end
    object.h_clip_relation = h_clip_relations.COMPARE
    object.level = INDICATOR_LEVEL
    Add(object)
end

--------------------------------------------------------------
--- screen space hud
--------------------------------------------------------------
if __USE_SCREENSPACE ~= nil then

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end
	scale = 1.0
end

--------------------------------------------------------------
--------------------------------------------------------------

-- CENTER_X and CENTER_Y are optional
function create_textured_box(UL_X,UL_Y,DR_X,DR_Y, texture_size_x, texture_size_y, my_custom_scale, CENTER_X, CENTER_Y)

    local my_scale = scale
    if my_custom_scale ~= nil then
        my_scale = my_custom_scale
    end

    local size_per_pixel_x = 1.0 / texture_size_x * my_scale
    local size_per_pixel_y = 1.0 / texture_size_y * my_scale
    local W = DR_X - UL_X
    local H = DR_Y - UL_Y
    local cx		     = (UL_X + 0.5 * W)
    local cy		     = (UL_Y + 0.5 * H)

    local CENTER_X 		 = CENTER_X or cx
    local CENTER_Y 		 = CENTER_Y or cy


    local half_x = W * size_per_pixel_x
    local half_y = H * size_per_pixel_y
    local dcx = 2 * size_per_pixel_x * (CENTER_X - cx)
    local dcy = 2 * size_per_pixel_y * (CENTER_Y - cy)

    local object = CreateElement "ceTexPoly"
    object.vertices =  {{-half_x - dcx, half_y + dcy},
                        { half_x - dcx, half_y + dcy},
                        { half_x - dcx,-half_y + dcy},
                        {-half_x - dcx,-half_y + dcy}}
    object.indices = {0,1,2,0,2,3}

    local ux = UL_X / texture_size_x
    local uy = UL_Y / texture_size_y
    local w = W / texture_size_x
    local h = H / texture_size_y
    object.tex_coords ={{ux     ,uy    },
                        {ux + w ,uy    },
                        {ux + w ,uy + h},
                        {ux     ,uy + h}}

	return object
end

-- texture box using 2048Bx2048B texture
-- CENTER_X and CENTER_Y are optional
function my_create_textured_box_2k(UL_X,UL_Y,DR_X,DR_Y, CENTER_X, CENTER_Y, scale)
	return create_textured_box(UL_X,UL_Y,UL_X+DR_X,UL_Y+DR_Y, 2048, 2048, scale, CENTER_X, CENTER_Y)
end

function my_create_textured_box_1k(UL_X,UL_Y,DR_X,DR_Y, CENTER_X, CENTER_Y, scale)
	return create_textured_box(UL_X,UL_Y,UL_X+DR_X,UL_Y+DR_Y, 1024, 1024, scale, CENTER_X, CENTER_Y)
end

function my_create_textured_box_2k_font(UL_X,UL_Y,DR_X,DR_Y, custom_scaling, CENTER_X, CENTER_Y)
	return create_textured_box(UL_X,UL_Y,UL_X+DR_X,UL_Y+DR_Y, 2048, 2048, scale * custom_scaling, CENTER_X, CENTER_Y)
end

-- line must be horizontal in texture, with half-circle cap on each end
-- object has initial rotation of 90deg so that it points upwards
-- left_X and left_Y refers to left-most pixel of line (vertical mid-point)
-- X_length is pixels from left-most to right-most pixel of line
-- Y_thickness is pixels from top to bottom of line
-- half-circle cap on left of line is assumed to have radius of half of line thickness (the line object origin (around which it rotates etc.) will be set to {left_X+thickness/2, left_Y})
function create_textured_line(left_X, left_Y, X_length, Y_thickness, texture_size_x, texture_size_y, my_custom_scale)
    local my_scale = scale
    if my_custom_scale ~= nil then
        my_scale = my_custom_scale
    end

    local size_per_pixel_x = 1.0 / texture_size_x * my_scale
    local size_per_pixel_y = 1.0 / texture_size_y * my_scale
    local W = X_length
    local H = Y_thickness
    local cx = (left_X + 0.5 * W)
    local cy = (left_Y + 0.5 * H)
    local origin_x = left_X + Y_thickness*0.5
    local origin_y = left_Y

    local half_x = W * size_per_pixel_x
    local half_y = H * size_per_pixel_y
    local dcx = 2 * size_per_pixel_x * (origin_x - cx)
    local dcy = 2 * size_per_pixel_y * (origin_y - cy)

    local object = CreateElement "ceHWLine"
    --[[
    object.vertices =  {{-half_x - dcx, half_y + dcy},
                        { half_x - dcx, half_y + dcy},
                        { half_x - dcx,-half_y + dcy},
                        {-half_x - dcx,-half_y + dcy}}
    object.maskvertices =  {{-half_x - dcx + size_per_pixel_x*Y_thickness*0.5, half_y + dcy},
                        { half_x - dcx - size_per_pixel_x*Y_thickness*0.5, half_y + dcy},
                        { half_x - dcx - size_per_pixel_x*Y_thickness*0.5,-half_y + dcy},
                        {-half_x - dcx + size_per_pixel_x*Y_thickness*0.5,-half_y + dcy}}
    --]]
    object.vertices =  {{-size_per_pixel_x*Y_thickness*0.5, half_y },
                        { 2*half_x, half_y},
                        { 2*half_x,-half_y},
                        {-size_per_pixel_x*Y_thickness*0.5,-half_y}}
    object.maskvertices =  {{0, half_y },
                        { 2*half_x, half_y},
                        { 2*half_x,-half_y},
                        { 0,-half_y}}
    object.indices = {0,1,2,0,2,3}
    object.maxlength = 1
    object.length = 0.2

    object.init_rot = {90,0,0}

    local ux = left_X / texture_size_x
    local uy = left_Y / texture_size_y
    local w = W / texture_size_x
    local h = H / texture_size_y
    object.tex_params = {ux, uy, 0.5, 0.5}
    --[[
    object.tex_coords ={{ux     ,uy    },
                        {ux + w ,uy    },
                        {ux + w ,uy + h},
                        {ux     ,uy + h}}
    --]]

    return object
end

function create_textured_line_2k(left_X, left_Y, X_length, Y_thickness, my_custom_scale)
    return create_textured_line(left_X, left_Y, X_length, Y_thickness, 2048, 2048, my_custom_scale)
end

function create_textured_circle(left_X, left_Y, X_length, Y_thickness, texture_size_x, texture_size_y, my_custom_scale)
    local my_scale = scale
    if my_custom_scale ~= nil then
        my_scale = my_custom_scale
    end

    local size_per_pixel_x = 1.0 / texture_size_x * my_scale
    local size_per_pixel_y = 1.0 / texture_size_y * my_scale
    local W = X_length
    local H = Y_thickness
    local cx = (left_X + 0.5 * W)
    local cy = (left_Y + 0.5 * H)
    local origin_x = left_X + Y_thickness*0.5
    local origin_y = left_Y

    local half_x = W * size_per_pixel_x
    local half_y = H * size_per_pixel_y
    local dcx = 2 * size_per_pixel_x * (origin_x - cx)
    local dcy = 2 * size_per_pixel_y * (origin_y - cy)

    local object = CreateElement "ceCircleHB"

    object.width = 0.003 --3mm


    local ux = left_X / texture_size_x
    local uy = left_Y / texture_size_y
    local w = W / texture_size_x
    local h = H / texture_size_y
    object.tex_params = {{ux, uy-(h/2)}, {ux+w, uy+(h/2)}, {my_scale,my_scale}}

    return object
end

function create_textured_circle_2k(left_X, left_Y, X_length, Y_thickness, my_custom_scale)
    return create_textured_circle(left_X, left_Y, X_length, Y_thickness, 2048, 2048, my_custom_scale)
end

function create_origin(name)
	local grid_origin	 = CreateElement "ceSimple"
		grid_origin.name = name or create_guid_string()
		grid_origin.collimated = false
		grid_origin.init_pos = _screen_origin -- PNT not centered, so i'll use this value
		grid_origin.init_rot = _screen_rotation
	AddElement(grid_origin)
	return grid_origin
end

function enable_box_rotation()
	_screen_rotation = {0,0,25}
end

function disable_box_rotation()
	_screen_rotation = {0,0,0}
end

function get_tex_coord (UL_X,UL_Y,W,H,SZX,SZY)
    local ux = UL_X / SZX
    local uy = UL_Y / SZY
    local w  = W / SZX
    local h  = H / SZY
    return {{ux     ,uy},
            {ux + w ,uy},
            {ux + w ,uy + h},
            {ux     ,uy + h}}
end

-- make 30cm x 30cm grid of 5cm blocks
function make_ruler_grid()
    local orig = CreateElement "ceSimple"
        orig.name = create_guid_string()
        orig.collimated = false
        orig.init_pos = _screen_origin
        orig.init_rot = _screen_rotation
        orig.h_clip_relation=h_clip_relations.NULL
    Add(grid_origin)
    local _scale = 1.0/GetScale() -- make everything meters
    for y=0,6 do
        local rule = CreateElement "ceSimpleLineObject"
            rule.name = create_guid_string()
            rule.parent_element=orig.name
            rule.material = MakeMaterial(nil,{220,220,220,255})
            rule.vertices =  {
                            {(-.15+0.05*y)*_scale, 0.15*_scale},
                            {(-.15+0.05*y)*_scale,-0.15*_scale},
                            }
            rule.width = 0.002 -- 2mm
            rule.isdraw = true
            rule.isvisible = true
            rule.additive_alpha = false
            rule.use_mipfilter = false
        Add(rule)
        local rule = CreateElement "ceSimpleLineObject"
            rule.name = create_guid_string()
            rule.parent_element=orig.name
            rule.material = MakeMaterial(nil,{220,220,220,255})
            rule.vertices =  {
                            { 0.15*_scale,(-.15+0.05*y)*_scale},
                            {-0.15*_scale,(-.15+0.05*y)*_scale},
                            }
            rule.width = 0.002 -- 2mm
            rule.isdraw = true
            rule.isvisible = true
            rule.additive_alpha = false
            rule.use_mipfilter = false
        Add(rule)
    end
end

local use_mipfilter = true
local collimated = false
local default_material = ""
local additive_alpha = false
local stroke_thickness  = 0.4
local stroke_fuzziness  = 0.5

function add_stroke_circle(name, radius, pos, parent, controllers, arc, segment, gap, dashed, material)
	local segmentsN = 64

	local circle     		= CreateElement "ceSCircle"
	circle.name               = name
	circle.isdraw             = true
	circle.material           = material or default_material
	circle.additive_alpha	  = additive_alpha or false
	circle.collimated		  = collimated or false
	circle.use_mipfilter      = use_mipfilter

	if parent ~= nil then
		circle.parent_element = parent
	end

	if controllers ~= nil then
		if type(controllers) == "table" then
			circle.controllers = controllers
		end
	end

	pos = pos or {0, 0}
	circle.init_pos       	  = {pos[1], pos[2], 0}

    circle.thickness    		= stroke_thickness
    circle.fuzziness    		= stroke_fuzziness
    circle.draw_as_wire 		= false
    --circle.use_specular_pass 	= false
	circle.radius    	 	= {radius, radius}
	circle.arc       		= arc or {0, math.pi * 2}
	circle.segment      	= segment or math.pi * 4 / segmentsN
	circle.gap      		= gap or math.pi * 4 / segmentsN
	circle.segment_detail   = 4
    -- TODO: set clip_relation and level

	if dashed ~= nil then
		circle.dashed    	= dashed
	else
		circle.dashed    	= false
	end

	Add(circle)
	return circle
end

-- Stroke line
-- rot (CCW in degrees from up)
-- pos (position of beginning of the line)
function add_stroke_line(name, length, pos, rot, parent, controllers, thickness, fuzziness, material)
	local line      = CreateElement "ceSMultiLine"
	line.name               = name
	line.isdraw             = true
	line.material           = material or default_material
	line.additive_alpha	  = additive_alpha or false
	line.collimated		  = collimated or false
	line.use_mipfilter      = use_mipfilter

	if parent ~= nil then
		line.parent_element = parent
	end

	if controllers ~= nil then
		if type(controllers) == "table" then
			line.controllers = controllers
		end
	end

	pos = pos or {0, 0}
	line.init_pos       	  = {pos[1], pos[2], 0}
    line.thickness    		= thickness or stroke_thickness
    line.fuzziness    		= fuzziness or stroke_fuzziness

	line.draw_as_wire 		= false
	--line.use_specular_pass 	= false

	if rot ~= nil then
		line.init_rot   = {rot}
	end

	local verts = {}
	local inds = {}

    verts = {{0, 0}, {0, length}}
    inds  = {0, 1}
	line.vertices   = verts
	line.indices    = inds

	AddElement(line)
	return line
end

function setClipLevel(obj, level)
	level = level or 0
	obj.h_clip_relation = h_clip_relations.COMPARE
	obj.level 		    = DEFAULT_LEVEL + level
end


-- NOTE
-- 'pos' is passed as a two-component table - x and y coordinates
function setSymbolCommonProperties(symbol, name, pos, parent, controllers, material)
	symbol.name               = name
	symbol.isdraw             = true
	symbol.material           = material or default_material
	symbol.additive_alpha	  = additive_alpha or false
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
	
	local verts, inds = buildStrokeLineVerts(1, dashed or false, stroke, gap)
	line.vertices   = verts
	line.indices    = inds
	
	Add(line)
	return line
end