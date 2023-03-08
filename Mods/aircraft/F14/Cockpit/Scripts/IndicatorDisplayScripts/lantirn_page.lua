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
grid_origin.controllers	= {{"LANTIRNController"}}
--grid_origin.collimated 		 = true



local mask_shrink = forced_mask_shrink or 0.96

local aspect = 1.0
local left_text_pos = -120*mask_shrink/150.0 -- -0.7933333 * mask_shrink
local right_text_pos = 70*mask_shrink/150.0 -- 0.48 * mask_shrink
local bottom_text_pos = -103.0*mask_shrink/120.0 -- -0.8416667 * aspect * mask_shrink
local top_text_pos = 96*mask_shrink/120.0 -- 0.8 * aspect * mask_shrink
local centerleft_text_pos = 33.0*mask_shrink/120.0 -- 0.275 * aspect * mask_shrink

--local fontsizey = 1.06364 * 0.04264 * half_height * aspect * 0.7 / 0.6
--local fontsizex = 0.625 * 0.04264 * half_height * 0.7 / 0.6

local fontsizey = 0.9784483 * (9.0/8.0) * 1.06364 * 0.04264 * GetScale() * 1.4928515085884044604540456696065 * aspect * mask_shrink --* 0.986 
local fontsizex = 0.8395722 * (6.0/5.0) * 0.625 * 0.04264 * GetScale() * 1.4928515085884044604540456696065 * mask_shrink

--local fontsizey = 1.06364 * 0.03779 * half_height * aspect * 0.7 / 0.6
--local fontsizex = 0.625 * 0.03779 * half_height * 0.7 / 0.6

lantrin_stringdef   = {fontsizey, fontsizex, -fontsizex * (1.0/6.0), -fontsizey * (1.0/9.0)}


function create_square_clip_box(W,H, clipRelation, clipLevel)
	local box = CreateElement "ceMeshPoly"
	box.name = "SymbologyBox"
	box.primitivetype = "triangles"

    local size_per_pixel_x = 1.0 / 300
    local size_per_pixel_y = aspect / 240

    local half_x = mask_shrink * W * size_per_pixel_x
    local half_y = mask_shrink * H * size_per_pixel_y


    box.vertices =  {{-half_x, half_y},
                        { half_x, half_y},
                        { half_x,-half_y},
                        {-half_x,-half_y}}
    box.indices = {0,1,2,0,2,3}
	box.init_pos		 = {PosX, PosY, 0}
	box.init_rot		 = {0, 0, 0}
	box.material		 = "DBG_RED"

	box.parent_element = grid_origin.name

	box.use_mipfilter = true
	box.additive_alpha = true
	box.collimated = false
	box.h_clip_relation = clipRelation
	box.level			 = clipLevel
	box.isdraw			 = true
	box.change_opacity	 = false
	box.isvisible		 = transparent
	return box
end

function create_lantirn_element(UL_X,UL_Y,W,H, texture_size_x, texture_size_y, CENTER_X, CENTER_Y)
    local size_per_pixel_x = 1.0 / 300
    local size_per_pixel_y = aspect / 240
    --local W = DR_X - UL_X
    --local H = DR_Y - UL_Y
    local cx		     = (UL_X + 0.5 * W)
    local cy		     = (UL_Y + 0.5 * H)

    local CENTER_X 		 = CENTER_X or cx
    local CENTER_Y 		 = CENTER_Y or cy


    local half_x = mask_shrink * W * size_per_pixel_x
    local half_y = mask_shrink * H * size_per_pixel_y
    local dcx = mask_shrink * 2 * size_per_pixel_x * (CENTER_X - cx)
    local dcy = mask_shrink * 2 * size_per_pixel_y * (CENTER_Y - cy)

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
	object.name            		= create_guid_string()
    object.material        		= LANTIRN_MATERIAL_NAME
    object.parent_element 		= grid_origin.name
	return object
end

function AddLantirnElement(element) 
	element.screenspace		 = screenspaceType
	AddElement(element,false)
end

-- shader seems to want to have something to draw onto
local box = CreateElement "ceMeshPoly"
    box.name = "SymbologyBox"
    box.primitivetype = "triangles"
    box.vertices = { {-1 * mask_shrink ,-aspect * mask_shrink },
                      {-1 * mask_shrink ,aspect * mask_shrink },
                      { 1 * mask_shrink ,aspect * mask_shrink },
                      {1 * mask_shrink ,-aspect * mask_shrink }}
    box.indices = default_box_indices
    box.h_clip_relation = h_clip_relations.COMPARE
    box.level = TV_LEVEL
    box.parent_element = grid_origin.name
    box.material = MakeMaterial(nil,{200,20,20,0})
    box.screenspace		 = screenspaceType
Add(box)

-- local lantirn_render 			= create_textured_box(0,0,512,512,512,512)
	-- lantirn_render.primitivetype	= "triangles"
	-- lantirn_render.name 	= create_guid_string()
	-- lantirn_render.material = "LANTIRNMaterial"--MakeMaterial("mfd1",{255,255,255,255})--"TIDMaterial"--MakeMaterial("mfd1",{255,255,255,255})-- "TIDMaterial" ----RED_MAT
	-- lantirn_render.init_pos = {0, 0, 0}
	-- lantirn_render.parent_element = grid_origin.name
	-- lantirn_render.isdraw		 = true
	-- lantirn_render.isvisible		 = true
	-- lantirn_render.collimated = false
	-- --lantirn_render.controllers	= {{"lantirnController"}}
    -- lantirn_render.h_clip_relation = h_clip_relations.COMPARE
    -- lantirn_render.level = TID_DEFAULT_LEVEL-1
-- --	lantirn_render.tex_coords = {{0,0},{1,0},{1,1},{0,1}}

local lantirn_render 			= CreateElement "ceTexPoly"
	lantirn_render.primitivetype	= "triangles"
	lantirn_render.vertices = { {-1 * mask_shrink ,aspect * mask_shrink },
							{1 * mask_shrink ,aspect * mask_shrink },
							{ 1 * mask_shrink ,-aspect * mask_shrink },
							{-1 * mask_shrink ,-aspect * mask_shrink }}
	lantirn_render.indices = {0,1,2,0,2,3}
	lantirn_render.name 	= create_guid_string()
	lantirn_render.material = LANTIRN_FX_MATERIAL_NAME
	lantirn_render.init_pos = {0, 0, 0}
	lantirn_render.parent_element = grid_origin.name
	lantirn_render.isdraw		 = true
	lantirn_render.isvisible		 = true
	lantirn_render.collimated = false
    lantirn_render.h_clip_relation = h_clip_relations.COMPARE
    lantirn_render.level = TV_LEVEL
	lantirn_render.tex_coords = {{0.03125,0.03125},{0.96875,0.03125},{0.96875,0.96875},{0.03125,0.96875}}
	lantirn_render.controllers 	= {{"LANTIRN_camera_feed"}}
	lantirn_render.screenspace		 = screenspaceType
AddElement(lantirn_render)


--local fov_overlay = my_create_textured_box_2k(0,0,2048,2048,1024,1024,1.0)
local seizure 				= create_textured_box(0, 0, 300, 240, 512, 512)
    seizure.name 			= create_guid_string()
    seizure.material 		= LANTIRN_MATERIAL_NAME
    seizure.parent_element  = grid_origin.name
    seizure.isdraw 			= true
    seizure.isvisible 		= true
    seizure.controllers 	= {{"LANTIRN_seizure"}}
	seizure.vertices 		= { {-1 * mask_shrink ,aspect * mask_shrink },
							{1 * mask_shrink ,aspect * mask_shrink },
							{ 1 * mask_shrink ,-aspect * mask_shrink },
							{-1 * mask_shrink ,-aspect * mask_shrink }}
AddLantirnElement(seizure)

local cross_box_out = create_square_clip_box( 66, 52, h_clip_relations.INCREASE_IF_LEVEL, TV_LEVEL)
	cross_box_out.controllers 	= {{"LANTIRN_cross_box_out"}}
	cross_box_out.screenspace		 = screenspaceType
Add(cross_box_out)

local cross						= create_lantirn_element(300, 0, 66, 52, 512, 512)    
    cross.init_pos 				= {0,0}
	cross.controllers 	= {{"LANTIRN_cross"}}
    --cross.controllers = {{"LANTIRN_topleft",0},{"LANTIRN_topleft_bright",0}}
	cross.h_clip_relation = h_clip_relations.COMPARE
	cross.level			 = TV_LEVEL
    cross.isdraw = true
AddLantirnElement(cross)

local croos_box_in = create_square_clip_box( 66, 52, h_clip_relations.DECREASE_IF_LEVEL, TV_LEVEL+1)
	croos_box_in.controllers 	= {{"LANTIRN_cross_box_out"}}
	croos_box_in.screenspace		 = screenspaceType
Add(croos_box_in)

local target_frame_l			= create_lantirn_element(508, 0, 3, 120, 512, 512)    
    target_frame_l.init_pos 				= {0,0}
	target_frame_l.controllers 	= {{"LANTIRN_target_frame",1}}
    target_frame_l.isdraw = false
	target_frame_l.use_mipfilter = false
AddLantirnElement(target_frame_l)

local target_frame_r			= create_lantirn_element(508, 0, 3, 120, 512, 512)   
    target_frame_r.init_pos 				= {0,0}
	target_frame_r.controllers 	= {{"LANTIRN_target_frame",2}}
    target_frame_r.isdraw = false
	target_frame_r.use_mipfilter = false
AddLantirnElement(target_frame_r)

local target_frame_u			= create_lantirn_element(356, 71, 150, 3, 512, 512)    
    target_frame_u.init_pos 				= {0,0}
	target_frame_u.controllers 	= {{"LANTIRN_target_frame",3}}
    target_frame_u.isdraw = false
AddLantirnElement(target_frame_u)

local target_frame_d			= create_lantirn_element(356, 71, 150, 3, 512, 512)    
    target_frame_d.init_pos 				= {0,0}
	target_frame_d.controllers 	= {{"LANTIRN_target_frame",4}}
    target_frame_d.isdraw = false
AddLantirnElement(target_frame_d)

local target_frame_l2			= create_lantirn_element(508, 0, 3, 120, 512, 512)    
    target_frame_l2.init_pos 				= {0,0}
	target_frame_l2.controllers 	= {{"LANTIRN_target_frame",5}}
    target_frame_l2.isdraw = false
	target_frame_l2.use_mipfilter = false
AddLantirnElement(target_frame_l2)

local target_frame_r2			= create_lantirn_element(508, 0, 3, 120, 512, 512)   
    target_frame_r2.init_pos 				= {0,0}
	target_frame_r2.controllers 	= {{"LANTIRN_target_frame",6}}
    target_frame_r2.isdraw = false
	target_frame_r2.use_mipfilter = false
AddLantirnElement(target_frame_r2)

local target_frame_u2			= create_lantirn_element(356, 71, 150, 3, 512, 512)    
    target_frame_u2.init_pos 				= {0,0}
	target_frame_u2.controllers 	= {{"LANTIRN_target_frame",7}}
    target_frame_u2.isdraw = false
AddLantirnElement(target_frame_u2)

local target_frame_d2			= create_lantirn_element(356, 71, 150, 3, 512, 512)    
    target_frame_d2.init_pos 				= {0,0}
	target_frame_d2.controllers 	= {{"LANTIRN_target_frame",8}}
    target_frame_d2.isdraw = false
AddLantirnElement(target_frame_d2)

local fov_narrow				= create_lantirn_element(371, 0, 88, 70, 512, 512)    
    fov_narrow.init_pos 		= {0.0,0.0}
    fov_narrow.controllers 	= {{"LANTIRN_fov_narrow"}}
    fov_narrow.isdraw = true
AddLantirnElement(fov_narrow)

local fov_expand_1				= create_lantirn_element(371, 0, 12, 10, 512, 512)    
	fov_expand_1.init_pos 		= {-71.0*mask_shrink/150.0,56.0*mask_shrink/120.0}
	fov_expand_1.controllers 	= {{"LANTIRN_fov_expand",1}}
	fov_expand_1.isdraw = true
AddLantirnElement(fov_expand_1)

local fov_expand_2				= create_lantirn_element(447, 0, 12, 10, 512, 512)    
	fov_expand_2.init_pos 		= {71.0*mask_shrink/150.0,56.0*mask_shrink/120.0}
	fov_expand_2.controllers 	= {{"LANTIRN_fov_expand",2}}
	fov_expand_2.isdraw = true
AddLantirnElement(fov_expand_2)

local fov_expand_3				= create_lantirn_element(371, 60, 12, 10, 512, 512)    
	fov_expand_3.init_pos 		= {-71.0*mask_shrink/150.0,-56.0*mask_shrink/120.0}
	fov_expand_3.controllers 	= {{"LANTIRN_fov_expand",3}}
	fov_expand_3.isdraw = true
AddLantirnElement(fov_expand_3)

local fov_expand_4				= create_lantirn_element(447, 60, 12, 10, 512, 512)    
	fov_expand_4.init_pos 		= {71.0*mask_shrink/150.0,-56.0*mask_shrink/120.0}
	fov_expand_4.controllers 	= {{"LANTIRN_fov_expand",4}}
	fov_expand_4.isdraw = true
AddLantirnElement(fov_expand_4)

local eye_direction				= create_lantirn_element(363, 64, 6, 5, 512, 512)    
    eye_direction.init_pos 		= {0.0,0.0}
    eye_direction.controllers 	= {{"LANTIRN_eye_direction"}}
    eye_direction.isdraw = true
AddLantirnElement(eye_direction)

local hdg_tape					= create_lantirn_element(355, 75, 124, 12, 512, 512)    
    hdg_tape.init_pos 		= {0.0,80.0*mask_shrink/120.0}
    hdg_tape.controllers 	= {{"LANTIRN_hdg_tape"}}
    hdg_tape.isdraw = true
AddLantirnElement(hdg_tape)

local hdg_cue				= create_lantirn_element(480, 80, 4, 10, 512, 512)    
    hdg_cue.init_pos 		= {0.0,76.0*mask_shrink/120.0}
    hdg_cue.controllers 	= {{"LANTIRN_hdg_cue"}}
    hdg_cue.isdraw = true
AddLantirnElement(hdg_cue)

local release_tape					= create_lantirn_element(301, 64, 22, 98, 512, 512)    
    release_tape.init_pos 		= {96.0*mask_shrink/150.0,0}
    release_tape.controllers 	= {{"LANTIRN_release_tape"}}
    release_tape.isdraw = true
AddLantirnElement(release_tape)

local release_cue				= create_lantirn_element(306, 164, 12, 4, 512, 512)    
    release_cue.init_pos 		= {96.0*mask_shrink/150.0,0.0}
    release_cue.controllers 	= {{"LANTIRN_release_cue"}}
    release_cue.isdraw = true
AddLantirnElement(release_cue)

local lase				= create_lantirn_element(300, 52, 11, 11, 512, 512)    
    lase.init_pos 		= {-4.5*mask_shrink/150.0,-78.5*mask_shrink/120.0}
    lase.controllers 	= {{"LANTIRN_lase"}}
    lase.isdraw = false
AddLantirnElement(lase)

local laserMasked		= create_lantirn_element(311, 52, 11, 11, 512, 512)    
    laserMasked.init_pos 		= {6.5*mask_shrink/150.0,-78.5*mask_shrink/120.0}
    laserMasked.controllers 	= {{"LANTIRN_laserMasked"}}
    laserMasked.isdraw = false
AddLantirnElement(laserMasked)

local top_left_text           = CreateElement "ceStringPoly"
    top_left_text.name            = create_guid_string()
    top_left_text.material        = LANTIRN_FONT_MATERIAL
    top_left_text.parent_element = grid_origin.name
    top_left_text.stringdefs    = lantrin_stringdef
    top_left_text.init_pos = {left_text_pos,top_text_pos}
    top_left_text.alignment     = "LeftTop"
    top_left_text.controllers = {{"LANTIRN_topleft",0},{"LANTIRN_topleft_bright",0}}
    top_left_text.isdraw = true
AddLantirnElement(top_left_text)

local center_left_text           = CreateElement "ceStringPoly"
    center_left_text.name            = create_guid_string()
    center_left_text.material        = LANTIRN_FONT_MATERIAL
    center_left_text.parent_element = grid_origin.name
    center_left_text.stringdefs    = lantrin_stringdef
    center_left_text.init_pos = {left_text_pos,centerleft_text_pos}
    center_left_text.alignment     = "LeftTop"
    center_left_text.controllers = {{"LANTIRN_centerleft",0},{"LANTIRN_topleft_bright",0}}
    center_left_text.isdraw = true
AddLantirnElement(center_left_text)

local bottom_left_text           = CreateElement "ceStringPoly"
    bottom_left_text.name            = create_guid_string()
    bottom_left_text.material        = LANTIRN_FONT_MATERIAL
    bottom_left_text.parent_element = grid_origin.name
    bottom_left_text.stringdefs    = lantrin_stringdef
    bottom_left_text.init_pos = {left_text_pos,bottom_text_pos}
    bottom_left_text.alignment     = "LeftBottom"
    bottom_left_text.controllers = {{"LANTIRN_bottomleft",0},{"LANTIRN_topleft_bright",0}}
    bottom_left_text.isdraw = true
AddLantirnElement(bottom_left_text)

local bottom_right_text           = CreateElement "ceStringPoly"
    bottom_right_text.name            = create_guid_string()
    bottom_right_text.material        = LANTIRN_FONT_MATERIAL
    bottom_right_text.parent_element = grid_origin.name
    bottom_right_text.stringdefs    = lantrin_stringdef
    bottom_right_text.init_pos = {right_text_pos,bottom_text_pos}
    bottom_right_text.alignment     = "LeftBottom"
    bottom_right_text.controllers = {{"LANTIRN_bottomright",0},{"LANTIRN_topleft_bright",0}}
    bottom_right_text.isdraw = true
AddLantirnElement(bottom_right_text)

local center_top_text           = CreateElement "ceStringPoly"
      center_top_text.name            = create_guid_string()
      center_top_text.material        = LANTIRN_FONT_MATERIAL
      center_top_text.parent_element = grid_origin.name
      center_top_text.stringdefs    = lantrin_stringdef
      center_top_text.init_pos = {-9*mask_shrink/150.0, top_text_pos}
      center_top_text.alignment     = "LeftTop"
      center_top_text.controllers = {{"LANTIRN_centertop",0},{"LANTIRN_topleft_bright",0}}
      center_top_text.isdraw = true
AddLantirnElement(center_top_text)

local center_lase_text           = CreateElement "ceStringPoly"
      center_lase_text.name            = create_guid_string()
      center_lase_text.material        = LANTIRN_FONT_MATERIAL
      center_lase_text.parent_element = grid_origin.name
      center_lase_text.stringdefs    = lantrin_stringdef
      center_lase_text.init_pos = {0, -0.5}
      center_lase_text.alignment     = "CenterBottom"
      center_lase_text.controllers = {{"LANTIRN_lase",0},{"LANTIRN_topleft_bright",0}}
      center_lase_text.isdraw = true
AddLantirnElement(center_lase_text)

local bottom_left_middle_text           = CreateElement "ceStringPoly"
      bottom_left_middle_text.name            = create_guid_string()
      bottom_left_middle_text.material        = LANTIRN_FONT_MATERIAL
      bottom_left_middle_text.parent_element = grid_origin.name
      bottom_left_middle_text.stringdefs    = lantrin_stringdef
      bottom_left_middle_text.init_pos = {-48.0*mask_shrink/150.0,bottom_text_pos}
      bottom_left_middle_text.alignment     = "LeftBottom"
      bottom_left_middle_text.controllers = {{"LANTIRN_bottomleftmiddle",0},{"LANTIRN_topleft_bright",0}}
      bottom_left_middle_text.isdraw = true
AddLantirnElement(bottom_left_middle_text)

local bottom_right_middle_text           = CreateElement "ceStringPoly"
      bottom_right_middle_text.name            = create_guid_string()
      bottom_right_middle_text.material        = LANTIRN_FONT_MATERIAL
      bottom_right_middle_text.parent_element = grid_origin.name
      bottom_right_middle_text.stringdefs    = lantrin_stringdef
      bottom_right_middle_text.init_pos = {11.0*mask_shrink/150.0,bottom_text_pos}
      bottom_right_middle_text.alignment     = "LeftBottom"
      bottom_right_middle_text.controllers = {{"LANTIRN_bottomrightmiddle",0},{"LANTIRN_topleft_bright",0}}
      bottom_right_middle_text.isdraw = true
AddLantirnElement(bottom_right_middle_text)

local hdg_tape_text           = CreateElement "ceStringPoly"
      hdg_tape_text.name            = create_guid_string()
      hdg_tape_text.material        = LANTIRN_FONT_MATERIAL
      hdg_tape_text.parent_element = grid_origin.name
      hdg_tape_text.stringdefs    = lantrin_stringdef
      hdg_tape_text.init_pos = {-34.0*mask_shrink/150.0,64.0*mask_shrink/120.0}
      hdg_tape_text.alignment     = "LeftBottom"
      hdg_tape_text.controllers = {{"LANTIRN_hdg_tape_text",0},{"LANTIRN_topleft_bright",0}}
      hdg_tape_text.isdraw = true
	  hdg_tape_text.value = "R 283"
AddLantirnElement(hdg_tape_text)

local bomb_time_text           = CreateElement "ceStringPoly"
      bomb_time_text.name            = create_guid_string()
      bomb_time_text.material        = LANTIRN_FONT_MATERIAL
      bomb_time_text.parent_element = grid_origin.name
      bomb_time_text.stringdefs    = lantrin_stringdef
      bomb_time_text.init_pos = {70.0*mask_shrink/150.0,-55.0*mask_shrink/120.0}
      bomb_time_text.alignment     = "LeftBottom"
      bomb_time_text.controllers = {{"LANTIRN_bomb_time_text",0},{"LANTIRN_topleft_bright",0}}
      bomb_time_text.isdraw = true
	  bomb_time_text.value = "TREL +55"
AddLantirnElement(bomb_time_text)


--local fov_box = my_create_textured_box_2k(12,1548,178,174,nil,nil,2048/512)
--	fov_box.name = create_guid_string()
--	fov_box.material = "lantirn_WHITE_MAT"
--	fov_box.parent_element = grid_origin.name
--    fov_box.controllers = {{"lantirn_FOV_controller"}}
--    fov_box.isdraw = false
--AddLantirnElement(fov_box, false)
--
---- gimbal angle crosshair
--local gach = my_create_textured_box_2k(14,1738,174,174,nil,nil,2048/512)
--	gach.name = create_guid_string()
--	gach.material = "lantirn_WHITE_MAT"
--	gach.parent_element = grid_origin.name
--    gach.controllers = {{"lantirn_gach"}}
--    gach.isdraw = false
--    --gach.init_pos={0.5,0.5}
--AddLantirnElement(gach, false)
--
---- radar angle crosshair
--local rach = my_create_textured_box_2k(218,1547,174,174,nil,nil,2048/512)
--	rach.name = create_guid_string()
--	rach.material = "lantirn_WHITE_MAT"
--	rach.parent_element = grid_origin.name
--    rach.controllers = {{"lantirn_rach"}}
--    rach.isdraw = false
--    --rach.init_pos={-0.5,-0.5}
--AddLantirnElement(rach, false)
--
--for crnr = 1,4 do
--    local track_crnr = my_create_textured_box_2k(266,1759,10,10,nil,nil,2048/512)
--        track_crnr.name = create_guid_string()
--        track_crnr.material = "lantirn_WHITE_MAT"
--        track_crnr.parent_element = grid_origin.name
--        track_crnr.controllers = {{"lantirn_corner",crnr}}
--        track_crnr.isdraw = false
--    AddLantirnElement(track_crnr, false)
--end
--

local crtdarkvignette 	= create_textured_box(0,0,512,512,512,512)-- 
crtdarkvignette.name 	= create_guid_string()
crtdarkvignette.material = "VDI_CRT_TEX_MAT2_LANTIRN"
crtdarkvignette.init_pos = {0, 0, 0}
crtdarkvignette.parent_element = grid_origin.name
crtdarkvignette.h_clip_relation = h_clip_relations.COMPARE
crtdarkvignette.level = INDICATOR_LEVEL
crtdarkvignette.use_mipfilter = true
crtdarkvignette.screenspace		 = screenspaceType
Add(crtdarkvignette)
