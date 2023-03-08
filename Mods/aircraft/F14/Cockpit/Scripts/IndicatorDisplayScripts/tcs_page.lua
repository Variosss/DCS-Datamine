local screenspaceType = ScreenType.SCREENSPACE_FALSE 
if ( VIDEO_EXPORT ~= nil ) then
	screenspaceType = ScreenType.SCREENSPACE_TRUE
end

function AddElement(object)
	object.screenspace = screenspaceType
    object.use_mipfilter = true
    Add(object)
end

local grid_origin = create_origin()
grid_origin.controllers	= {{"TCSController"}}
--grid_origin.collimated 		 = true

local SHOW_MASKS = false

TV_LEVEL = TV_LEVEL + 1

function create_box(PosX, PosY, SizeX, SizeY, material, parent, clipRelation, clipLevel, showbox)
	local box = CreateElement "ceMeshPoly"
	box.name = create_guid_string()
	box.primitivetype = "triangles"

	box.vertices	= { {-SizeX,-SizeY},
								{-SizeX,SizeY},
								{ SizeX,SizeY},
								 {SizeX,-SizeY}}

	box.indices		 = default_box_indices
	box.init_pos		 = {PosX, PosY, 0}
	box.material		 = material

	if parent ~= nil then
		box.parent_element = parent.name
	end

	box.use_mipfilter = true
	box.additive_alpha = false
	box.h_clip_relation = h_clip_relations.COMPARE
	box.level			= TV_LEVEL
    if showbox ~= nil then
    		box.isvisible		 = showbox
    end

	if clipRelation ~= nil then
		box.h_clip_relation = clipRelation
		box.level			 = clipLevel
		box.isdraw			 = true
		box.change_opacity	 = false
	else
		if clipLevel ~= nil then
			box.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
			box.clipLevel = clipLevel
		end
	end
	return box
end

__clip_box = {}  --stack
local _local_clip_level = 0
-- must always having a closing clip_box_pop somewhere later
function clip_box_push(PosX, PosY, SizeX, SizeY, parent)
    local entry = {PosX, PosY, SizeX, SizeY, parent}
    table.insert(__clip_box, entry)
	local box = create_box(PosX, PosY, SizeX, SizeY, "DBG_GREEN", parent, h_clip_relations.INCREASE_IF_LEVEL, TV_LEVEL + _local_clip_level, false)
    _local_clip_level = _local_clip_level + 1
    return box
end

function clip_box_pop()
	if #__clip_box == 0 then
		return
	end
    local entry = table.remove(__clip_box)
	local PosX = entry[1]
	local PosY = entry[2]
	local SizeX = entry[3]
	local SizeY = entry[4]
    local parent = entry[5]

	local box = create_box(PosX, PosY, SizeX, SizeY, "DBG_GREEN", parent, h_clip_relations.DECREASE_IF_LEVEL, TV_LEVEL + _local_clip_level, false)
    _local_clip_level = _local_clip_level - 1
    return box
end

local verts = { {-1.0, 1.0},
                { 1.0, 1.0},
                { 1.0,-1.0},
                {-1.0,-1.0}, }

local clip = CreateElement "ceMeshPoly"
    clip.name = create_guid_string()
    clip.primitivetype = "triangles"
    clip.vertices = verts
    clip.indices = default_box_indices -- {0, 1, 2, 0, 2, 3}
    clip.material = "DBG_GREEN"
    clip.isdraw = true
    clip.change_opacity = false
    clip.isvisible = SHOW_MASKS
    clip.use_mipfilter = true
    clip.additive_alpha = false
    clip.collimated = false
    clip.parent_element = grid_origin.name
    clip.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
    clip.level = TV_LEVEL-1
    clip.screenspace = screenspaceType
Add(clip)

-- TCSMaterial seems to want to have something to draw onto
local box = CreateElement "ceMeshPoly"
    box.name = "SymbologyBox"
    box.primitivetype = "triangles"
    box.vertices = { {-1,-1},
                      {-1,1},
                      { 1,1},
                      {1,-1}}
    box.indices = default_box_indices
    box.parent_element = grid_origin.name
    box.h_clip_relation = h_clip_relations.COMPARE
    box.level = TV_LEVEL
    box.material = MakeMaterial(nil,{200,20,20,0})
    box.screenspace = screenspaceType
Add(box)

local tcs_render 			= create_textured_box(0,0,512,512,512,512)
	tcs_render.primitivetype	= "triangles"
	tcs_render.name 	= create_guid_string()
	tcs_render.material = TCS_FX_MATERIAL_NAME
	tcs_render.init_pos = {0, 0, 0}
	tcs_render.parent_element = grid_origin.name
	tcs_render.isdraw		 = true
	tcs_render.isvisible		 = true
	tcs_render.collimated = false
	--tcs_render.controllers	= {{"TCSController"}}
    tcs_render.h_clip_relation = h_clip_relations.COMPARE
    tcs_render.level = TV_LEVEL
--	tcs_render.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
    tcs_render.use_mipfilter = true
    tcs_render.additive_alpha = true
    tcs_render.screenspace = screenspaceType

Add(tcs_render)

for crnr = 1,4 do
    local track_crnr = my_create_textured_box_2k(266,1759,10,10,nil,nil,2048/512)
        track_crnr.name = create_guid_string()
        track_crnr.material = TCS_MATERIAL_NAME
        track_crnr.parent_element = grid_origin.name
        track_crnr.controllers = {{"TCS_corner",crnr}}
        track_crnr.isdraw = false
        track_crnr.h_clip_relation = h_clip_relations.COMPARE
        track_crnr.level = TV_LEVEL
        track_crnr.use_mipfilter = true
        track_crnr.additive_alpha = true
        track_crnr.screenspace = screenspaceType
    Add(track_crnr, false)
end

local clip_box = clip_box_push(0,0,1.0,1.0,grid_origin)
clip_box.controllers = {{"TCS_cornerclip"}}
clip_box.screenspace = screenspaceType
Add(clip_box)

local fov_box = my_create_textured_box_2k(12,1548,178,174,nil,nil,2048/512)
	fov_box.name = create_guid_string()
	fov_box.material = TCS_MATERIAL_NAME
	fov_box.parent_element = grid_origin.name
    fov_box.controllers = {{"TCS_FOV_controller"}}
    fov_box.isdraw = false
    fov_box.h_clip_relation = h_clip_relations.COMPARE
    fov_box.level = TV_LEVEL
    fov_box.use_mipfilter = true
    fov_box.additive_alpha = true
    fov_box.screenspace = screenspaceType
Add(fov_box, false)

-- gimbal angle crosshair
local gach = my_create_textured_box_2k(14,1738,174,174,nil,nil,2048/512)
	gach.name = create_guid_string()
	gach.material = TCS_MATERIAL_NAME
	gach.parent_element = grid_origin.name
    gach.controllers = {{"TCS_gach"}}
    gach.isdraw = false
    gach.h_clip_relation = h_clip_relations.COMPARE
    gach.level = TV_LEVEL
    gach.use_mipfilter = true
    gach.additive_alpha = true
    gach.screenspace = screenspaceType
    --gach.init_pos={0.5,0.5}
Add(gach, false)

-- radar angle crosshair
local rach = my_create_textured_box_2k(218,1547,174,174,nil,nil,2048/512)
	rach.name = create_guid_string()
	rach.material = TCS_MATERIAL_NAME
	rach.parent_element = grid_origin.name
    rach.controllers = {{"TCS_rach"}}
    rach.isdraw = false
    rach.h_clip_relation = h_clip_relations.COMPARE
    rach.level = TV_LEVEL
    rach.use_mipfilter = true
    rach.additive_alpha = true
    rach.screenspace = screenspaceType
    --rach.init_pos={-0.5,-0.5}
Add(rach, false)

local clip_box = clip_box_pop(0,0,1.0,1.0,grid_origin)
clip_box.controllers = {{"TCS_cornerclip"}}
clip_box.screenspace = screenspaceType
Add(clip_box)

-- Restores the mask to the original TV_LEVEL
local clipback = CreateElement "ceMeshPoly"
    clipback.name = create_guid_string()
    clipback.primitivetype = "triangles"
    clipback.vertices = verts
    clipback.indices = default_box_indices -- {0, 1, 2, 0, 2, 3}
    clipback.material = "DBG_GREEN"
    clipback.isdraw = true
    clipback.change_opacity = false
    clipback.isvisible = SHOW_MASKS
    clipback.use_mipfilter = true
    clipback.additive_alpha = false
    clipback.collimated = false
    clipback.parent_element = grid_origin.name
    clipback.h_clip_relation = h_clip_relations.DECREASE_IF_LEVEL
    clipback.level = TV_LEVEL
    clipback.screenspace = screenspaceType
Add(clipback)

TV_LEVEL = TV_LEVEL - 1
