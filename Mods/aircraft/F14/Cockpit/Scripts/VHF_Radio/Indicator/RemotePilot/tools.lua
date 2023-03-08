dofile(LockOn_Options.script_path.."Scripts/VHF_Radio/Indicator/RemotePilot/defs.lua")

--local __USE_SCREENSPACE = true
--local SHOW_DEBUG_CLIP_BOXES = true
local DISABLE_CLIP_BOXES = true
--local ENABLE_CONTROLLER_MERGE = true

function copyTable(target, src)
	assert(target ~= src)
	
	if not target then
		target = {}
	end
	
	for i, v in pairs(src) do
		if type(v) == 'table' then
			if not target[i] then
				target[i] = {}
			end
			
			copyTable(target[i], v)
		else
			target[i] = v
		end
	end

	return target
end

function mergeTables(table1, table2)
	local result = table1
	
    if type(table2) == 'table' then

		for k, v in pairs(table2) do
				if 'table' == type(v) then
					table.insert(result, copyTable(nil, v))
				else
					table.insert(result,v)
				end
		end
    else
        table.insert(result,{v}) 
	end
	
    return table2
	--return result
end

function AddMaskLevel(object, level)
    --object.collimated = false
	object.use_mipfilter = true
	object.additive_alpha = true
	--object.h_clip_relation = h_clip_relations.REWRITE_LEVEL -- COMPARE -- REWRITE_LEVEL
	--object.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
    if level == nil then
        level = VHF_DEFAULT_LEVEL
    end
	object.level			= level
	--object.level			= VHF_DEFAULT_LEVEL + 1
        
	Add(object)
end

function AddElementLevel(object, level)
    --object.collimated = false
	object.use_mipfilter = true
	object.additive_alpha = true
	object.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--object.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
    if level == nil then
        level = VHF_DEFAULT_LEVEL
    end
	object.level			= level
	--object.level			= VHF_DEFAULT_LEVEL + 1
        
	Add(object)
end

function AddElement(object)
    --object.collimated = false
	object.use_mipfilter = true
	object.additive_alpha = true
	object.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--object.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	object.level			= VHF_DEFAULT_LEVEL
	--object.level			= VHF_DEFAULT_LEVEL + 1
    
    
	Add(object)
end

function AddBoxedHUDElement(object)
	if DISABLE_CLIP_BOXES ~= nil then
		AddElement(object)
		return
	end
	object.use_mipfilter = true
	object.additive_alpha = true
	object.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--object.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	--object.level			= VHF_DEFAULT_LEVEL
	object.level			= VHF_DEFAULT_LEVEL + 1
    
    
	Add(object)
end

function AddHUDElement(object)
	AddElement(object) -- <R> some like to call AddHUDElement
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
function element_init_pos_shift(DX, DY, DZ, tex_size, my_custom_scale)

	local my_scale = scale
	if my_custom_scale ~= nil then
		my_scale = my_custom_scale
	end

    local texture_size = tex_size
	if tex_size == nil then
		texture_size = 2048
	end
    
	local size_per_pixel = 1.0 / texture_size * my_scale
    
    --local halfx = -obj.vertices[1][1]
    --local halfy = obj.vertices[1][2]
    
    local shiftx = 2 * DX * size_per_pixel
    local shifty = 2 * DY * size_per_pixel
    local shiftz = 2 * DZ * size_per_pixel
    
	local init_pos = {shiftx, shifty, shiftz}

    return init_pos
end




function tex_box_vert_shift(obj, DX, DY, tex_size, my_custom_scale)

	local my_scale = scale
	if my_custom_scale ~= nil then
		my_scale = my_custom_scale
	end

    local texture_size = tex_size
	if tex_size == nil then
		texture_size = 2048
	end
    
	local size_per_pixel = 1.0 / texture_size * my_scale
    
    local halfx = -obj.vertices[1][1]
    local halfy = obj.vertices[1][2]
    
    local shiftx = 2 * DX * size_per_pixel
    local shifty = 2 * DY * size_per_pixel
    
	local verts = {{-halfx+shiftx, halfy+shifty},
                               { halfx+shiftx, halfy+shifty},
                               { halfx+shiftx,-halfy+shifty},
                               {-halfx+shiftx,-halfy+shifty}}

    return verts
end

function create_textured_box(UL_X,UL_Y,DR_X,DR_Y, texture_size, my_custom_scale)

	local my_scale = scale
	if my_custom_scale ~= nil then
		my_scale = my_custom_scale
	end

	local size_per_pixel = 1.0 / texture_size * my_scale
	local W = DR_X - UL_X
	local H = DR_Y - UL_Y
	
	local texture_size_x = texture_size
	local texture_size_y = texture_size

    -- scaled up by 2
	local half_x = 2 * W * size_per_pixel
	local half_y = 2 * H * size_per_pixel
	local ux 	 = UL_X / texture_size_x
	local uy 	 = UL_Y / texture_size_y
	local w 	 = W / texture_size_x
	local h 	 = H / texture_size_y

	local object = CreateElement "ceTexPoly"
	object.vertices = {{-half_x, half_y},
						{ half_x, half_y},
						{ half_x,-half_y},
						{-half_x,-half_y}}
	object.indices	 = {0,1,2,0,2,3}
	object.tex_coords = {{ux ,uy},
						 {ux + w ,uy},
						 {ux + w ,uy + h},
						 {ux 	 ,uy + h}}	 
					 
	return object
end

function my_create_textured_box_2k(UL_X,UL_Y,DR_X,DR_Y)
	return create_textured_box(UL_X,UL_Y,UL_X+DR_X,UL_Y+DR_Y, 2048)
end

function my_create_textured_box_2k_font(UL_X,UL_Y,DR_X,DR_Y, custom_scaling)
	return create_textured_box(UL_X,UL_Y,UL_X+DR_X,UL_Y+DR_Y, 2048, scale * custom_scaling)
end

function create_custom_number_element(number, posX, posY, posZ, parent_element, min_digits, signed, font_scaling)

	if font_scaling == nil then
		font_scaling = 1.0
	end

	local digit_start_X = 80
	local digit_start_Y = 974
	local digit_sizeX = 19
	local digit_sizeY = 30
	local digit_spacing = 20
	
	local digit_spacing_screen = 8 * font_scaling

	local digits = {}
	
	local theSign = 0
	if number > 0 then 
		theSign = 10 -- plus sign(+)
	end
	
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
	
	for i = 1, #digits do
		local digit = my_create_textured_box_2k_font(digit_start_X + (digit_sizeX + digit_spacing) * digits[#digits - i + 1] ,digit_start_Y,digit_sizeX,digit_sizeY, font_scaling)
			digit.name 	= create_guid_string() 
			digit.material = MDIG_MAT_A
			digit.init_pos = {digit_spacing_screen * (i - 1) - anchor + posX, posY ,posZ}
			digit.parent_element = parent_element.name
		AddBoxedHUDElement(digit)
	end
end

function create_box(PosX, PosY, SizeX, SizeY, material, parent, clipRelation, clipLevel, transparent)
	local box = CreateElement "ceMeshPoly"
	box.name = "SymbologyBox"
	box.primitivetype = "triangles"

	box.vertices	= {{-SizeX, SizeY},
								 { SizeX, SizeY},
								 { SizeX,-SizeY},
								 {-SizeX,-SizeY}}

	box.indices		 = default_box_indices
	box.init_pos		 = {_screen_origin[1] + PosX, _screen_origin[2] + PosY, _screen_origin[3]}
	box.init_rot		 = _screen_rotation
	box.material		 = material
	
	if parent ~= nil then
		box.parent_element = parent.name
	end
	
	box.use_mipfilter = true
	box.additive_alpha = true
	box.h_clip_relation = h_clip_relations.COMPARE -- COMPARE -- REWRITE_LEVEL
	--box.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
	box.level			= VHF_DEFAULT_LEVEL
    
	--box.controllers = {{"hsd_visible"},  {"ecmd_bright"}}

	--box.level			= VHF_DEFAULT_LEVEL + 1
	--Add(box)
	
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
end

function clip_box_in(PosX, PosY, SizeX, SizeY)
	if DISABLE_CLIP_BOXES ~= nil then
		return
	end
	__clip_box = {}
	__clip_box[1] = PosX
	__clip_box[2] = PosY
	__clip_box[3] = SizeX
	__clip_box[4] = SizeY
	create_box(PosX, PosY, SizeX, SizeY, VHF_GREEN, nil, h_clip_relations.INCREASE_IF_LEVEL ,VHF_DEFAULT_LEVEL, false)
end

function clip_box_out(PosX, PosY, SizeX, SizeY)
	if DISABLE_CLIP_BOXES ~= nil then
		return
	end
	if __clip_box == nil then
		return
	end
	local PosX = __clip_box[1]
	local PosY = __clip_box[2]
	local SizeX = __clip_box[3]
	local SizeY = __clip_box[4]

	if SHOW_DEBUG_CLIP_BOXES ~= nil then
		create_box(PosX,PosY,SizeX,SizeY,VHF_TRANSPARENT, nil, h_clip_relations.DECREASE_IF_LEVEL ,VHF_DEFAULT_LEVEL + 1, true)
	end

	create_box(PosX, PosY, SizeX, SizeY, VHF_GREEN, parent, h_clip_relations.DECREASE_IF_LEVEL ,VHF_DEFAULT_LEVEL + 1, false)
end

function create_origin()
	local grid_origin	 = CreateElement "ceSimple"
		grid_origin.name = create_guid_string()
	    grid_origin.material = MDIG_MAT_A
		--grid_origin.collimated = false
		grid_origin.init_pos = _screen_origin -- PNT not centered, so i'll use this value
		grid_origin.init_rot = _screen_rotation
        grid_origin.controllers = {{"arc182freq_visible_remote_pilot"}}
	AddBoxedHUDElement(grid_origin)
	return grid_origin
end

function enable_box_rotation()
	_screen_rotation = {0,0,25}
end

function disable_box_rotation()
	_screen_rotation = {0,0,0}
end


function SetLineCircle(object, radius, numpts)

  local verts = {}
  local inds = {}
  
  step = math.rad(360.0/numpts)
  j=0
  for i = 1, numpts+1 do
    verts[i] = {radius * math.cos((i-1) * step), radius * math.sin((i-1) * step)}
    
    j = j + 1
    inds[j] = i-1
    j = j + 1
    inds[j] = i
  end
  inds[j] = 0
  --[[
  j = 0
  for i = 0, numpts do
    j = j + 1
    inds[j] = 0
    j = j + 1
    inds[j] = i + 1
    j = j + 1
    inds[j] = i + 2
  end
]]
  object.vertices = verts
  object.indices  = inds
  
end

function SetMeshCircle(object, radius, numpts)

  local verts = {}
  local inds = {}
  
  step = math.rad(360.0/numpts)
  for i = 1, numpts do
    verts[i] = {radius * math.cos(i * step), radius * math.sin(i * step)}
  end
  j = 0
  for i = 0, numpts-3 do
    j = j + 1
    inds[j] = 0
    j = j + 1
    inds[j] = i + 1
    j = j + 1
    inds[j] = i + 2
  end

  object.vertices = verts
  object.indices  = inds
  
end

function get_tex_coord (UL_X,UL_Y,W,H,SZX,SZY)
	local ux = UL_X / SZX
	local uy = UL_Y / SZY
	local w  = W / SZX
	local h  = H / SZY
    return {{ux ,uy},
				 {ux + w ,uy},
				 {ux + w ,uy + h},
				 {ux 	 ,uy + h}}
	--[[
    return {{ux + w ,uy},
			{ux + w ,uy + h},
			{ux	    ,uy+h},
			{ux	 	,uy}}
    ]]
end

function get_vertices (W,H,SZX,SZY)
	local w  = 0.5*W / SZX
	local h  = 0.5*H / SZY
    return {{-w, h},
				 {w, h},
				 {w, -h},
				 {-w, -h}}
	--[[
	vertices = {{-half_x, half_y},
						{ half_x, half_y},
						{ half_x,-half_y},
						{-half_x,-half_y}}
    ]]
end
