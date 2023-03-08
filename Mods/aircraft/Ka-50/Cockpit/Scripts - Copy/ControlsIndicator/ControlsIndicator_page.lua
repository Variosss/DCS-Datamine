dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetCustomScale(1.0)

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end

local aspect        = LockOn_Options.screen.aspect
local size          = 0.15
local tex_scale     = 0.25/size
local line_width    = (4.5/512)/tex_scale

local roll_stick_lim		        = 130
local pitch_stick_pos               = 115
local pitch_stick_neg               = 181.6
local rudder_lim	                = 81.5
local k                             = size / roll_stick_lim
local pitch_stick_movement_positive = pitch_stick_pos * k
local pitch_stick_movement_negative = pitch_stick_neg * k
--[[
    CURR_SCREENSPACE_NONE = 0,
    CURR_SCREENSPACE_HUD_ONLY_VIEW = 1,
    CURR_SCREENSPACE_ARCADE = 2,
--]]

local ds           = 0.05 * size
local collec_shift = 0.3*size
local rud_shift    = 0.1*size

local orange_mat   = MakeMaterial("",{255,100,0,50})

base       			= CreateElement "ceMeshPoly"
base.name		    = "base"
base.primitivetype  = "triangles"
base.material       = orange_mat -- "GREEN_TRANSPARENT"
base.vertices       = {{-(size + collec_shift + rud_shift  + 3.0*line_width + ds), -(size + ds)},
                       {-(size + collec_shift + rud_shift  + 3.0*line_width + ds),  pitch_stick_movement_negative  + ds}, 
                       { size  + ds                            ,  pitch_stick_movement_negative  + ds},
                       { size  + ds                            , -(size + ds)}}        
base.indices        = default_box_indices
base.init_pos       = {0,-(1 - 1.5*size)}
base.controllers    = {{"show"},{"screenspace_position",2,-(aspect - 2*size),0},
                                {"screenspace_position",1,0,0}}

base.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
base.level		      = DEFAULT_LEVEL
AddElement(base)


pitch_scale                = CreateElement "ceTexPoly"
pitch_scale.name		   = "pitch_scale"
pitch_scale.vertices       = {{-pitch_stick_movement_positive   , -line_width},
                              {-pitch_stick_movement_positive   ,  line_width},
                              { pitch_stick_movement_negative   ,  line_width},
                              { pitch_stick_movement_negative   , -line_width}}
pitch_scale.indices		   = default_box_indices
pitch_scale.material	   = "ARCADE_3_RED"
pitch_scale.init_rot       = {90,0,0}
pitch_scale.tex_params	   = {256/512,176.5/512,0.5*tex_scale,2*tex_scale}
pitch_scale.parent_element = base.name
AddElement(pitch_scale)

roll_scale                = CreateElement "ceTexPoly"
roll_scale.name		      = "roll_scale"
roll_scale.vertices       = {{-size   , -line_width},
                             {-size   ,  line_width},
                             { size   ,  line_width},
                             { size   , -line_width}}
roll_scale.indices		  = default_box_indices
roll_scale.material	      = "ARCADE_3_RED"
roll_scale.tex_params	  = {256/512,176.5/512,tex_scale,2*tex_scale}
roll_scale.parent_element = base.name
AddElement(roll_scale)

local stick_index_sz           = 0.1 * size

stick_position                  = CreateElement "ceTexPoly"
stick_position.name             = "stick_position"
stick_position.vertices         = {{-stick_index_sz, -stick_index_sz},
                                   {-stick_index_sz,  stick_index_sz},
                                   { stick_index_sz,  stick_index_sz},
                                   { stick_index_sz, -stick_index_sz}}
stick_position.indices          = default_box_indices
stick_position.material	       = "ARCADE_3_RED"
stick_position.tex_params	   = {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
stick_position.controllers    = {{"stick_pitch", size*1000/roll_stick_lim,
                                                 size*1000/roll_stick_lim},
                                 {"stick_roll", -size*1000/roll_stick_lim}}
stick_position.parent_element = base.name
AddElement(stick_position)

rudder_scale                = Copy(roll_scale)
rudder_scale.init_pos       = {0,-(pitch_stick_movement_positive + 0.1*size)}
AddElement(rudder_scale)

rudder_index             = Copy(roll_scale)
rudder_index.vertices    = {{-2.0*line_width , -line_width},
                            {-2.0*line_width ,  line_width},
                            { 2.0*line_width ,  line_width},
                            { 2.0*line_width , -line_width}}
rudder_index.controllers = {{"rudder",size*1000/rudder_lim},{"rotate",math.rad(90)}}
rudder_index.parent_element = rudder_scale.name
AddElement(rudder_index)

local collective_size = pitch_stick_movement_negative

collective_scale             = Copy(pitch_scale)
collective_scale.vertices    = {{0, -line_width},
                                {0,  line_width},
                                {collective_size  ,  line_width},
                                {collective_size, -line_width}}
collective_scale.init_pos    = {-(size + collec_shift),0}
AddElement(collective_scale)

collective_index             = Copy(roll_scale)
collective_index.vertices    = {{-2.0*line_width , -line_width},
                                {-2.0*line_width ,  line_width},
                                { 2.0*line_width ,  line_width},
                                { 2.0*line_width , -line_width}}
collective_index.controllers = {{"collective",collective_size}}
collective_index.init_rot    = {-90,0,0}
collective_index.parent_element  = collective_scale.name
AddElement(collective_index)


for i = 1,2 do
local rud_sz   = pitch_stick_movement_positive + 0.1*size

local rud = Copy(pitch_scale)
      rud.vertices       = {{ 0      , -line_width},
                            { 0      ,  line_width},
                            { rud_sz   ,  line_width},
                            { rud_sz   , -line_width}}
        
      rud.parent_element = collective_scale.name
      if i == 1 then
      rud.init_pos       =  {-rud_sz, rud_shift}
      else
      rud.init_pos       =  {-rud_sz,-rud_shift}
      end
      rud.init_rot       = {0,0,0}
      AddElement(rud)
      
local tick_50 = Copy(roll_scale)
      if i == 2 then tick_50.vertices    = {{0, -line_width},{0,  line_width},{3.0*line_width ,  line_width},{3.0*line_width , -line_width}}
      else           tick_50.vertices    = {{-3.0*line_width, -line_width},{-3.0*line_width,  line_width},{ 0 ,  line_width},{ 0 , -line_width}}   end
      tick_50.parent_element = rud.name
      tick_50.init_rot       = {90,0,0}
      tick_50.init_pos       = {(50/120)*rud_sz,0,0}
      AddElement(tick_50)

local tick_35 = Copy(tick_50)
      if i == 2 then tick_35.vertices    = {{0, -line_width},{0,  line_width},{1.5*line_width ,  line_width},{1.5*line_width , -line_width}}
      else           tick_35.vertices    = {{-1.5*line_width, -line_width},{-1.5*line_width,  line_width},{ 0 ,  line_width},{ 0 , -line_width}}   end
      tick_35.init_pos       = {(13/120)*rud_sz,0,0}
      AddElement(tick_35)
      
local tick             = Copy(tick_50)
      tick.init_rot    = {-90,0,0}
      tick.init_pos    = {0,0,0}
      tick.controllers = {{"throttle",i,rud_sz}}
      AddElement(tick)   
end


local brakes_pos = {-size,0.85*pitch_stick_movement_negative - ds}

txt_brakes                 = CreateElement "ceStringPoly"
txt_brakes.name            = "txt_brakes"
txt_brakes.material        = "font_ARCADE_RED"
txt_brakes.init_pos		   =  brakes_pos
txt_brakes.alignment       = "LeftBottom"
txt_brakes.stringdefs      = {0.0035, 0.0035,0,0}
txt_brakes.value           = "B"
txt_brakes.controllers     = {{"parking_brake"},{"blinking"}}
txt_brakes.parent_element  = base.name
AddElement(txt_brakes)





local sz_wheel_brake       = 0.5 * pitch_stick_movement_negative


wheel_brake_mask                = CreateElement "ceMeshPoly"
wheel_brake_mask.name		    = "wheel_brake_mask"
wheel_brake_mask.primitivetype  = "triangles"
wheel_brake_mask.vertices       = {{0                    ,0},
                                   {0                    ,sz_wheel_brake},
                                   {0.3 * sz_wheel_brake ,sz_wheel_brake},
                                   {0.3 * sz_wheel_brake ,0}}
wheel_brake_mask.indices		   = {0,1,2,0,2,3}
wheel_brake_mask.material	    = "GREEN_TRANSPARENT"
wheel_brake_mask.init_pos       = {brakes_pos[1],brakes_pos[2] - ds - sz_wheel_brake}
wheel_brake_mask.parent_element = base.name
wheel_brake_mask.controllers    = {{"brakes_value",sz_wheel_brake}}
wheel_brake_mask.h_clip_relation  = h_clip_relations.INCREASE_LEVEL
wheel_brake_mask.isvisible      = false
AddElement(wheel_brake_mask)


wheel_brake                = CreateElement "ceMeshPoly"
wheel_brake.name		   = "wheel_brake"
wheel_brake.primitivetype  = "triangles"
wheel_brake.vertices       = {{0 ,0},
                              {0 ,sz_wheel_brake},
                              {0.3 * sz_wheel_brake ,sz_wheel_brake}}
wheel_brake.indices		   = {0,1,2}
wheel_brake.material	   = "RED"
wheel_brake.init_pos       =  wheel_brake_mask.init_pos
wheel_brake.parent_element = base.name
wheel_brake.h_clip_relation = h_clip_relations.COMPARE
wheel_brake.level		    = DEFAULT_LEVEL
AddElement(wheel_brake)

	AUTOPMODE_NONE    = 0
	AUTOPMODE_ROUTE   = 1
	AUTOPMODE_DESCENT = 2
	AUTOPMODE_HOVER   = 3

txt_autopilot                 = CreateElement "ceStringPoly"
txt_autopilot.name            = "txt_autopilot"
txt_autopilot.material        = "font_ARCADE_RED"
txt_autopilot.init_pos		  = {size,brakes_pos[2]}
txt_autopilot.alignment       = "RightBottom"
txt_autopilot.stringdefs      = {0.0035, 0.0035,0,0}
txt_autopilot.value           = "A"
txt_autopilot.controllers     = {{"autopilot_engaged",AUTOPMODE_ROUTE}}
txt_autopilot.parent_element  = base.name
AddElement(txt_autopilot)

local delta  = 6*ds

txt_autopilot_hover                 = CreateElement "ceStringPoly"
txt_autopilot_hover.name            = "txt_autopilot_hover"
txt_autopilot_hover.material        = "font_ARCADE_RED"
txt_autopilot_hover.init_pos		= {size,brakes_pos[2] - delta}
txt_autopilot_hover.alignment       = "RightBottom"
txt_autopilot_hover.stringdefs      = {0.0035, 0.0035,0,0}
txt_autopilot_hover.value           = "H"
txt_autopilot_hover.controllers     = {{"autopilot_engaged",AUTOPMODE_HOVER}}
txt_autopilot_hover.parent_element  = base.name
AddElement(txt_autopilot_hover)