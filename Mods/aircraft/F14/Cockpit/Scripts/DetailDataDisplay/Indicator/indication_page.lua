dofile(LockOn_Options.script_path.."Scripts/DetailDataDisplay/Indicator/definitions.lua")

dofile(LockOn_Options.script_path.."Scripts/Common/levels.lua")
INDICATOR_LEVEL = DDD_DEFAULT_LEVEL
dofile(LockOn_Options.script_path.."Scripts/Common/common_defs.lua")

local grid_origin = create_origin()

local SHOW_MASKS=false

local verts = { {-1, 1},
                { 1, 1},
                { 1,-1},
                {-1,-1}, }

clipbase = CreateElement "ceMeshPoly"
clipbase.name = create_guid_string()
clipbase.primitivetype = "triangles"
clipbase.vertices = verts
clipbase.indices = default_box_indices -- {0, 1, 2, 0, 2, 3}
clipbase.material = "DBG_RED"
clipbase.isdraw = true
clipbase.change_opacity = false
clipbase.isvisible = SHOW_MASKS
clipbase.use_mipfilter = true
clipbase.additive_alpha = false
clipbase.collimated = false
clipbase.parent_element = grid_origin.name
clipbase.h_clipbase_relation = h_clip_relations.REWRITE_LEVEL
clipbase.level = INDICATOR_LEVEL-1
Add(clipbase)

clip = CreateElement "ceMeshPoly"
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
clip.level = INDICATOR_LEVEL-1
Add(clip)

background = CreateElement "ceMeshPoly"
background.name = create_guid_string()
background.primitivetype = "triangles"
background.vertices = verts
background.indices = default_box_indices -- {0, 1, 2, 0, 2, 3}
background.material = SCOPE_GREEN_TRANS
background.isdraw = true
background.change_opacity = false
background.isvisible = true
background.use_mipfilter = true
background.additive_alpha = false
background.collimated = false
background.parent_element = grid_origin.name
background.h_clip_relation = h_clip_relations.COMPARE
background.level = INDICATOR_LEVEL
Add(background)

local DDDshader = create_textured_box(0,0,512,512,512,512) -- my_create_textured_box_2k(0,0,2048,2048)
    DDDshader.primitivetype = "triangles"
    DDDshader.name = create_guid_string()
    DDDshader.material = "DDDMaterial"
    DDDshader.init_pos = {0, 0, 0}
    DDDshader.parent_element = background.name
    DDDshader.isdraw = true
    DDDshader.isvisible = true
    --DDDshader.collimated = false
    --DDDshader.controllers = {{"DDDController"}, }
    DDDshader.additive_alpha  = false
    DDDshader.collimated = false
AddElement(DDDshader)

local range_gate_top = CreateElement "ceSimpleLineObject"
    range_gate_top.name = create_guid_string()
    range_gate_top.material = MakeMaterial(nil,{0,0,0,255})
    range_gate_top.vertices =  {
                    {-1/20, aspect/40},
                    { 1/20, aspect/40},
                    }
    range_gate_top.width = 0.005
    range_gate_top.isdraw = false
    range_gate_top.isvisible = true
    range_gate_top.additive_alpha = false
    range_gate_top.use_mipfilter = true
    range_gate_top.collimated = false
    range_gate_top.controllers	= {{"ddd_cursor"}}
Add(range_gate_top)

local range_gate_bot = CreateElement "ceSimpleLineObject"
    range_gate_bot.name = create_guid_string()
    range_gate_bot.material = MakeMaterial(nil,{0,0,0,255})
    range_gate_bot.vertices =  {
                    { 1/20,-aspect/40},
                    {-1/20,-aspect/40},
                    }
    range_gate_bot.width = 0.005
    range_gate_bot.isdraw = false
    range_gate_bot.isvisible = true
    range_gate_bot.additive_alpha = false
    range_gate_bot.use_mipfilter = true
    range_gate_bot.collimated = false
    range_gate_bot.controllers	= {{"ddd_cursor"}}
Add(range_gate_bot)

local horizon = my_create_textured_box_2k(0,10,515,7,nil,nil,2048/512)
    horizon.name = create_guid_string()
    horizon.material = "DDD_OVERLAY2"
    horizon.init_pos = {0, 0, 0}
    horizon.parent_element = background.name
    horizon.isdraw = true
    horizon.isvisible = true
    horizon.collimated = false
	horizon.use_mipfilter = false
	horizon.additive_alpha = true
	--horizon.h_clip_relation = h_clip_relations.COMPARE
	--horizon.level = INDICATOR_LEVEL
    horizon.controllers	= {{"ddd_horizon"}}
Add(horizon)

local cursor_horiz = my_create_textured_box_2k(0,4,515,7,nil,nil,2048/512)
    cursor_horiz.name = create_guid_string()
    cursor_horiz.material = "DDD_OVERLAY2"
    cursor_horiz.init_pos = {0, 0, 0}
    cursor_horiz.parent_element = background.name
    cursor_horiz.isdraw = true
    cursor_horiz.isvisible = true
    cursor_horiz.collimated = false
	cursor_horiz.use_mipfilter = false
	cursor_horiz.additive_alpha = true
	--cursor_horiz.h_clip_relation = h_clip_relations.COMPARE
	--cursor_horiz.level = INDICATOR_LEVEL
    cursor_horiz.controllers	= {{"ddd_cursor_horiz"}}
Add(cursor_horiz)

local cursor_vert = my_create_textured_box_2k(0,4,515,7,nil,nil,2048/512)
    cursor_vert.name = create_guid_string()
    cursor_vert.material = "DDD_OVERLAY2"
    cursor_vert.init_pos = {0, 0, 0}
    cursor_vert.init_rot = {90, 0, 0}
    cursor_vert.parent_element = background.name
    cursor_vert.isdraw = true
    cursor_vert.isvisible = true
    cursor_vert.collimated = false
	cursor_vert.use_mipfilter = false
	cursor_vert.additive_alpha = true
	--cursor_vert.h_clip_relation = h_clip_relations.COMPARE
	--cursor_vert.level = INDICATOR_LEVEL
    cursor_vert.controllers	= {{"ddd_cursor_vert"}}
Add(cursor_vert)

-- TODO: breakaway (composite 45deg rotated of above lines)
-- TODO: ASE using ceHWLine

-- 0.25" line for rmin
local rmin = my_create_textured_box_2k(2,19,34,5,36,nil,2048/512)
    rmin.name = create_guid_string()
    rmin.material = "DDD_OVERLAY2"
    rmin.init_pos = {0, -0.654, 0}
    rmin.parent_element = background.name
    rmin.isdraw = false
    rmin.isvisible = true
    rmin.collimated = false
	rmin.use_mipfilter = false
	rmin.additive_alpha = true
    rmin.controllers	= {{"ddd_dlz", 0.01125, 1.334, 0}}  -- x per degree, y full scale
Add(rmin)

-- 0.25" line for rmax
local rmax = my_create_textured_box_2k(2,19,34,5,36,nil,2048/512)
    rmax.name = create_guid_string()
    rmax.material = "DDD_OVERLAY2"
    rmax.init_pos = {0, -0.654, 0}
    rmax.parent_element = background.name
    rmax.isdraw = false
    rmax.isvisible = true
    rmax.collimated = false
	rmax.use_mipfilter = false
	rmax.additive_alpha = true
    rmax.controllers	= {{"ddd_dlz", 0.01125, 1.334, 1}}  -- x per degree, y full scale
Add(rmax)

-- 0.25" line for pd-stt target range
local pdstt_range = my_create_textured_box_2k(2,19,34,5,2,nil,2048/512)
    pdstt_range.name = create_guid_string()
    pdstt_range.material = "DDD_OVERLAY2"
    pdstt_range.init_pos = {0, -0.654, 0}
    pdstt_range.parent_element = background.name
    pdstt_range.isdraw = false
    pdstt_range.isvisible = true
    pdstt_range.collimated = false
	pdstt_range.use_mipfilter = false
	pdstt_range.additive_alpha = true
    pdstt_range.controllers	= {{"ddd_pdstt_range", 0.01125, 1.334}}  -- x per degree, y full scale
Add(pdstt_range)

-- 0.25" line for closure rate
local closure_rate = my_create_textured_box_2k(2,19,34,5,nil,nil,2048/512)
    closure_rate.name = create_guid_string()
    closure_rate.material = "DDD_OVERLAY2"
    closure_rate.init_pos = {0.785, -0.427, 0}
    closure_rate.parent_element = background.name
    closure_rate.isdraw = false
    closure_rate.isvisible = true
    closure_rate.collimated = false
	closure_rate.use_mipfilter = false
	closure_rate.additive_alpha = true
    closure_rate.controllers	= {{"ddd_closure_rate", 0.222}} -- y scale 0.222 per tic
Add(closure_rate)

-- 1/8" by 1/4" PD acq gate
local pd_gate = my_create_textured_box_2k(2,28,18,37,nil,nil,2048/512)
    pd_gate.name = create_guid_string()
    pd_gate.material = "DDD_OVERLAY2"
    pd_gate.init_pos = {0, 0, 0}
    pd_gate.parent_element = background.name
    pd_gate.isdraw = false
    pd_gate.isvisible = true
    pd_gate.collimated = false
	pd_gate.use_mipfilter = false
	pd_gate.additive_alpha = true
    pd_gate.controllers	= {{"ddd_pd_acq_gate"}}
Add(pd_gate)

-- 3/16" by 1/8" P-STT gate
local pstt_gate = my_create_textured_box_2k(2,67,26,21,12,nil,2048/512)
    pstt_gate.name = create_guid_string()
    pstt_gate.material = "DDD_OVERLAY2"
    pstt_gate.init_pos = {0, -0.66, 0}
    pstt_gate.parent_element = background.name
    pstt_gate.isdraw = false
    pstt_gate.isvisible = true
    pstt_gate.collimated = false
	pstt_gate.use_mipfilter = false
	pstt_gate.additive_alpha = true
    pstt_gate.controllers = {{"ddd_pstt_gate", 0.01135, 1.345}}  -- x per degree, y full scale
Add(pstt_gate)

-- 3/16" by 1/8" PD-STT gate
local pdstt_gate = my_create_textured_box_2k(2,67,26,21,14,nil,2048/512)
    pdstt_gate.name = create_guid_string()
    pdstt_gate.material = "DDD_OVERLAY2"
    pdstt_gate.init_pos = {0, -0.66, 0}
    pdstt_gate.parent_element = background.name
    pdstt_gate.isdraw = false
    pdstt_gate.isvisible = true
    pdstt_gate.collimated = false
	pdstt_gate.use_mipfilter = false
	pdstt_gate.additive_alpha = true
    pdstt_gate.controllers = {{"ddd_pdstt_gate", 0.01135, 1.345}}  -- x per degree, y full scale
Add(pdstt_gate)

-- 0.43" by 1/8" P acq gate
local pulse_acq_gate = my_create_textured_box_2k(2,91,57,21,nil,nil,2048/512)
    pulse_acq_gate.name = create_guid_string()
    pulse_acq_gate.material = "DDD_OVERLAY2"
    pulse_acq_gate.init_pos = {0, 0, 0}
    pulse_acq_gate.parent_element = background.name
    pulse_acq_gate.isdraw = false
    pulse_acq_gate.isvisible = true
    pulse_acq_gate.collimated = false
	pulse_acq_gate.use_mipfilter = false
	pulse_acq_gate.additive_alpha = true
    pulse_acq_gate.controllers	= {{"ddd_p_acq_gate"}}
Add(pulse_acq_gate)

-- 0.025" by 0.035"
local steering_cue = my_create_textured_box_2k(6,128,28,32,nil,nil)
    steering_cue.name = create_guid_string()
    steering_cue.material = "DDD_OVERLAY2"
    steering_cue.init_pos = {0, 0, 0}
    steering_cue.parent_element = background.name
    steering_cue.isdraw = false
    steering_cue.isvisible = true
    steering_cue.collimated = false
	steering_cue.use_mipfilter = true
	steering_cue.additive_alpha = true
    steering_cue.controllers	= {{"ddd_steering_cue"}}
Add(steering_cue)

-- tick line for mrl_left_elev
local mrl_left_elev = my_create_textured_box_2k(2,28,18,5,2,nil,2048/512)
    mrl_left_elev.name = create_guid_string()
    mrl_left_elev.material = "DDD_OVERLAY2"
    mrl_left_elev.init_pos = {0, -0.654, 0}
    mrl_left_elev.parent_element = background.name
    mrl_left_elev.isdraw = false
    mrl_left_elev.isvisible = true
    mrl_left_elev.collimated = false
	mrl_left_elev.use_mipfilter = false
	mrl_left_elev.additive_alpha = true
    mrl_left_elev.controllers	= {{"ddd_mrl", 0.01125, 1.334, 0}}  -- x per degree, y full scale
Add(mrl_left_elev)

-- tick line for mrl_right_elev
local mrl_right_elev = my_create_textured_box_2k(2,28,18,5,19,nil,2048/512)
    mrl_right_elev.name = create_guid_string()
    mrl_right_elev.material = "DDD_OVERLAY2"
    mrl_right_elev.init_pos = {0, -0.654, 0}
    mrl_right_elev.parent_element = background.name
    mrl_right_elev.isdraw = false
    mrl_right_elev.isvisible = true
    mrl_right_elev.collimated = false
	mrl_right_elev.use_mipfilter = false
	mrl_right_elev.additive_alpha = true
    mrl_right_elev.controllers	= {{"ddd_mrl", 0.01125, 1.334, 1}}  -- x per degree, y full scale
Add(mrl_right_elev)

local ASE_circle = add_stroke_circle("ddd_ase", 0.2, nil, background.name, {{"ddd_ase"}}, nil, nil, nil, nil, "BLACK")

---[[
local DDDoverlay = my_create_textured_box_2k(0,0,2047,1688)
    DDDoverlay.name = create_guid_string()
    DDDoverlay.material = "DDD_OVERLAY"
    DDDoverlay.init_pos = {0, 0, 0}
    DDDoverlay.parent_element = background.name
    DDDoverlay.isdraw = true
    DDDoverlay.isvisible = true
    DDDoverlay.collimated = false
	DDDoverlay.use_mipfilter = false
	DDDoverlay.additive_alpha = false
	--DDDoverlay.h_clip_relation = h_clip_relations.COMPARE
	--DDDoverlay.level = INDICATOR_LEVEL
Add(DDDoverlay)
--]]

local ddd_filter = CreateElement "ceMeshPoly"
    ddd_filter.name = create_guid_string()
    ddd_filter.primitivetype = "triangles"

    ddd_filter.vertices	= { {-1.1,-1.1},
                                {-1.1,1.1},
                                { 1.1,1.1},
                                 {1.1,-1.1}}

    ddd_filter.indices		 = default_box_indices
    ddd_filter.init_pos		 = {0, 0, 0}
    ddd_filter.material		 = "DDD_GREEN_FILTER"

    ddd_filter.use_mipfilter = false
    ddd_filter.additive_alpha = false
    ddd_filter.collimated = false
    ddd_filter.isvisible = true
    ddd_filter.isdraw = false
    ddd_filter.parent_element = background.name
    ddd_filter.controllers = {{"ddd_filter"}}
    ddd_filter.blend_mode = 6 -- MULT
Add(ddd_filter)