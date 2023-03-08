dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")

SetScale(MILLYRADIANS)

_five_degrees = math.rad(5) * 1000
_five_degrees_rad = math.rad(5)
_one_degree = math.rad(1) * 1000

_hud_scale = 100.0

DBG_GREEN = MakeMaterial(nil,{0,255,0,255}) 
DBG_RED = MakeMaterial(nil,{255,0,0,255}) 
DBG_TRANSPARENT = MakeMaterial(nil,{0,255,255,128}) 


function get_tex_coord (UL_X,UL_Y,W,H,SZX,SZY)
    local ux = UL_X / SZX
    local uy = UL_Y / SZY
    local w  = W / SZX
    local h  = H / SZY
    return {{ux ,uy},
        {ux + w ,uy},
        {ux + w ,uy + h},
        {ux 	 ,uy + h}}
end



--local __USE_SCREENSPACE = true
--local SHOW_DEBUG_CLIP_BOXES = true

function AddElement(object)
	object.use_mipfilter = true
	object.additive_alpha = true
	object.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--object.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	object.level			= HUD_DEFAULT_LEVEL
	--object.level			= HUD_DEFAULT_LEVEL + 1
	Add(object)
end

function AddBoxedHUDElement(object)
	object.use_mipfilter = true
	object.additive_alpha = true
	object.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--object.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	--object.level			= HUD_DEFAULT_LEVEL
	object.level			= HUD_DEFAULT_LEVEL + 1
	Add(object)
end

function AddHUDElement(object)
	AddElement(object) -- <R> some like to call AddHUDElement
end

--------------------------------------------------------------
--- screen space hud
--- screen space hud
--------------------------------------------------------------
if __USE_SCREENSPACE ~= nil then

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end

end
--------------------------------------------------------------
--------------------------------------------------------------

local scale = 550.0

if __USE_SCREENSPACE ~= nil then
	scale = 1.0
end

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


    local half_x = 0.5 * W * size_per_pixel_x
    local half_y = 0.5 * H * size_per_pixel_y
    local dcx = size_per_pixel_x * (CENTER_X - cx)
    local dcy = size_per_pixel_y * (CENTER_Y - cy)

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
function my_create_textured_box_2k(UL_X,UL_Y,DR_X,DR_Y, my_custom_scale, CENTER_X, CENTER_Y)
    if my_custom_scale then
        return create_textured_box(UL_X,UL_Y,UL_X+DR_X,UL_Y+DR_Y, 2048, 2048, scale * my_custom_scale, CENTER_X, CENTER_Y)
    else
        return create_textured_box(UL_X,UL_Y,UL_X+DR_X,UL_Y+DR_Y, 2048, 2048, scale, CENTER_X, CENTER_Y)
    end
end

function my_create_textured_box_2k_font(UL_X,UL_Y,DR_X,DR_Y, custom_scaling)
	return create_textured_box(UL_X,UL_Y,UL_X+DR_X,UL_Y+DR_Y, 2048, 2048, scale * custom_scaling)
end

function create_custom_number_element(number, posX, posY, posZ, parent_element, min_digits, signed, font_scaling, name, controllers)
    local number_holder	 			= CreateElement "ceSimple"
        number_holder.name 			= name or create_guid_string()
        number_holder.parent_element = parent_element.name
        if controllers ~= nil then
            number_holder.controllers = controllers
        end
    AddElement(number_holder)

	if font_scaling == nil then
		font_scaling = 1.0
	end

	local digit_start_X = 20
	local digit_start_Y = 25
	local digit_sizeX = 58
	local digit_sizeY = 80
	local digit_spacing = (500.0/9.0)-58

	local digit_spacing_screen = 12 * font_scaling

	local digits = {}

	local theSign = 0
	-- if number > 0 then
	--	theSign = 10 -- plus sign(+)
	-- end

	if number < 0 then
		theSign = 11 -- minus sign (-)
	end

	number = math.abs(number)

	if number ~= 0 then
		while number > 0 do
			digits[#digits+1] = number - math.floor(number/10) * 10
			number = math.floor(number/10)
		end
	else
		digits[1] = 0
	end

	if (min_digits ~= nil) and (min_digits > #digits) then
		local digits2 = {}
		for i = 1, min_digits do
			digits2[i] = 0
		end
		for i = 1, #digits do
			digits2[i] = digits[i]
		end

		digits = digits2
	end

	if signed ~= nil then
		if theSign > 0 or theSign < 0 then
			digits[#digits + 1] = theSign
		end
	end

	local anchor = (#digits - 1) * digit_spacing_screen / 2
	digitarray={}
	for i = 1, #digits do
		local digit = my_create_textured_box_2k_font(digit_start_X + (digit_sizeX + digit_spacing) * digits[#digits - i + 1] ,digit_start_Y,digit_sizeX,digit_sizeY, font_scaling)
			digit.name 	= tostring(digits[#digits - i + 1]).."_"..create_guid_string()
			digit.material = "HUD_MAT"
			digit.init_pos = {digit_spacing_screen * (i - 1) - anchor + posX, posY ,posZ}
			digit.parent_element = number_holder.name
		AddBoxedHUDElement(digit)
        digitarray[#digitarray+1]=digit
	end
    return number_holder, digitarray
end

function create_box(PosX, PosY, SizeX, SizeY, material, parent, clipRelation, clipLevel, transparent, name)
	local box = CreateElement "ceMeshPoly"
	box.name = name or "SymbologyBox"..create_guid_string()
	box.primitivetype = "triangles"

	box.vertices	= { {-SizeX,-SizeY},
								{-SizeX,SizeY},
								{ SizeX,SizeY},
								 {SizeX,-SizeY}}

	box.indices		 = default_box_indices
	box.init_pos		 = {PosX, PosY, 0}
	box.init_rot		 = {0, 0, 0}
	box.material		 = material

	if parent ~= nil then
		box.parent_element = parent.name
	end

	box.use_mipfilter = true
	box.additive_alpha = true
	box.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--box.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	box.level			= HUD_DEFAULT_LEVEL
	--box.level			= HUD_DEFAULT_LEVEL + 1
	--Add(box)

	box.collimated = true

	if clipRelation ~= nil then
		box.h_clip_relation = clipRelation
		box.level			 = clipLevel
		box.isdraw			 = true
		box.change_opacity	 = false
		box.isvisible		 = transparent
		--Add(box)
	else
		if clipLevel ~= nil then
			box.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
			box.clipLevel = clipLevel
		end
		--AddHUDElement(box)
	end
	Add(box)
    return box
end

function clip_box_in(PosX, PosY, SizeX, SizeY, name)
	return create_box(PosX, PosY, SizeX, SizeY, DBG_GREEN, nil, h_clip_relations.INCREASE_IF_LEVEL ,HUD_DEFAULT_LEVEL, false, name)
end

function clip_box_out(PosX, PosY, SizeX, SizeY)
	if SHOW_DEBUG_CLIP_BOXES ~= nil then
		create_box(PosX,PosY,SizeX,SizeY,DBG_TRANSPARENT, nil, h_clip_relations.DECREASE_IF_LEVEL ,HUD_DEFAULT_LEVEL + 1, true)
	end

	create_box(PosX, PosY, SizeX, SizeY, DBG_GREEN, nil, h_clip_relations.DECREASE_IF_LEVEL ,HUD_DEFAULT_LEVEL + 1, false)
end

function create_origin(parent)
	local grid_origin	 = CreateElement "ceSimple"
		grid_origin.name = create_guid_string()
		grid_origin.collimated = true
		grid_origin.init_pos = {0, 0, 0} -- <R> hack, for testing purposes only
		grid_origin.controllers = {{"hud_visible"}}
        if parent ~= nil then
            grid_origin.parent_element = parent.name
        end
	AddBoxedHUDElement(grid_origin)
	return grid_origin
end