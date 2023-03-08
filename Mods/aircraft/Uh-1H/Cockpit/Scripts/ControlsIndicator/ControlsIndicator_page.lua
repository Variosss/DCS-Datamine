dofile(LockOn_Options.common_script_path.."elements_defs.lua")
print('cargo')
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
local pitch_stick_pos               = 148.3--115
local pitch_stick_neg               = 148.3--181.6
local rudder_lim	                = 81.5
local k                             = size / roll_stick_lim
local pitch_stick_movement_positive = pitch_stick_pos * k
local pitch_stick_movement_negative = pitch_stick_neg * k
local box_height					= 0.2
--[[
    CURR_SCREENSPACE_NONE = 0,
    CURR_SCREENSPACE_HUD_ONLY_VIEW = 1,
    CURR_SCREENSPACE_ARCADE = 2,
--]]

local ds           = 0.05 * size
local collec_shift = 0.3*size
local rud_shift    = 0.1*size

local orange_mat   = MakeMaterial("",{0,0,0,150})

base       			= CreateElement "ceMeshPoly"
base.name		    = "base"
base.primitivetype  = "triangles"
base.material       = "RED_TRANSPARENT"
base.vertices       = {{-(size + collec_shift + rud_shift + 3.0*line_width + ds), -(box_height )},
                       {-(size + collec_shift + rud_shift + 3.0*line_width + ds),  box_height  }, 
                       { size  + ds                            ,  box_height  },
                       { size  + ds                            , -(box_height )}}        
base.indices        = default_box_indices
base.init_pos       = {0,(1 - 1.3*size)}
base.controllers    = {{"show"},{"screenspace_position",2,-(aspect - (size+collec_shift  + rud_shift +3.0*line_width + ds)),0},
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
stick_position.material	       = "ARCADE_3_WHITE"
stick_position.tex_params	   = {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
stick_position.controllers    = {{"AP"},{"stick_pitch", size*1000/roll_stick_lim,
                                                 size*1000/roll_stick_lim},
                                 {"stick_roll", -size*1000/roll_stick_lim}}
stick_position.parent_element = base.name
AddElement(stick_position)

stick_position_AP						= CreateElement "ceTexPoly"
stick_position_AP.name             = "stick_position_AP"
stick_position_AP.vertices         = {{-stick_index_sz, -stick_index_sz},
                                   {-stick_index_sz,  stick_index_sz},
                                   { stick_index_sz,  stick_index_sz},
                                   { stick_index_sz, -stick_index_sz}}
stick_position_AP.indices          = default_box_indices
stick_position_AP.material	       = "ARCADE_3_RED"
stick_position_AP.tex_params	   = {330/512,365.5 / 512,2*tex_scale,2*tex_scale/0.8}
stick_position_AP.controllers    = {{"stick_pitch_AP", size*1000/roll_stick_lim,
                                                 size*1000/roll_stick_lim},
                                 {"stick_roll_AP", -size*1000/roll_stick_lim}}
stick_position_AP.parent_element = base.name
AddElement(stick_position_AP)


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
rudder_index.tex_params	   = {256/512,176.5/512,0.5*tex_scale/3,2*tex_scale/3}
rudder_index.material	       ="ARCADE_3_RED"
AddElement(rudder_index)

rudder_scale_AP                = Copy(roll_scale)
rudder_scale_AP.init_pos       = {0,-(pitch_stick_movement_positive + 0.1*size)}
AddElement(rudder_scale_AP)

rudder_index_AP             = Copy(roll_scale)
rudder_index_AP.vertices    = {{-2.0*line_width , -line_width},
                            {-2.0*line_width ,  line_width},
                            { 2.0*line_width ,  line_width},
                            { 2.0*line_width , -line_width}}
rudder_index_AP.controllers = {{"AP"},{"rudder_AP",size*1000/rudder_lim},{"rotate",math.rad(90)}}
rudder_index_AP.parent_element = rudder_scale_AP.name
rudder_index_AP.tex_params	   = {256/512,176.5/512,0.5*tex_scale/3,2*tex_scale/3}
rudder_index_AP.material	       = "ARCADE_3_WHITE"
AddElement(rudder_index_AP)

local collective_size = pitch_stick_movement_negative

collective_scale             = Copy(pitch_scale)
collective_scale.vertices    = {{0, -line_width},
                                {0,  line_width},
                                {collective_size  ,  line_width},
                                {collective_size, -line_width}}
collective_scale.init_pos    = {-(size + collec_shift),0}
--collective_scale.material=MakeMaterial("",{255,0,255,255})
AddElement(collective_scale)

collective_index             = Copy(roll_scale)
collective_index.vertices    = {{-2.0*line_width , -line_width},
                                {-2.0*line_width ,  line_width},
                                { 2.0*line_width ,  line_width},
                                { 2.0*line_width , -line_width}}
collective_index.controllers = {{"AP"},{"collective",collective_size}}
collective_index.init_rot    = {-90,0,0}
collective_index.tex_params	   = {256/512,176.5/512,0.5*tex_scale/3,2*tex_scale/3}
collective_index.parent_element  = collective_scale.name
collective_index.material="ARCADE_3_WHITE"
AddElement(collective_index)


local collective_size_AP = pitch_stick_movement_negative

collective_scale_AP             = Copy(pitch_scale)
collective_scale_AP.vertices    = {{0, -line_width},
                                {0,  line_width},
                                {collective_size  ,  line_width},
                                {collective_size, -line_width}}
collective_scale_AP.init_pos    = {-(size + collec_shift),0}
AddElement(collective_scale_AP)

collective_index_AP             = Copy(roll_scale)
collective_index_AP.vertices    = {{-2.0*line_width , -line_width},
                                {-2.0*line_width ,  line_width},
                                { 2.0*line_width ,  line_width},
                                { 2.0*line_width , -line_width}}
collective_index_AP.controllers = {{"collective_AP",collective_size_AP}}
collective_index_AP.tex_params	   = {256/512,176.5/512,0.5*tex_scale/3,2*tex_scale/3}
collective_index_AP.init_rot    = {-90,0,0}
collective_index_AP.material="ARCADE_3_RED"
collective_index_AP.parent_element  = collective_scale_AP.name
AddElement(collective_index_AP)


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
      tick_50.init_pos       = {(20/120)*rud_sz,0,0}
	  --tick.material=MakeMaterial("",{255,255,255,255})
      AddElement(tick_50)

local tick_35 = Copy(tick_50)
      if i == 2 then tick_35.vertices    = {{0, -line_width},{0,  line_width},{1.5*line_width ,  line_width},{1.5*line_width , -line_width}}
      else           tick_35.vertices    = {{-1.5*line_width, -line_width},{-1.5*line_width,  line_width},{ 0 ,  line_width},{ 0 , -line_width}}   end
      tick_35.init_pos       = {(13/120)*rud_sz,0,0}
	  --tick.material=MakeMaterial("",{255,255,255,255})
      AddElement(tick_35)
      
local tick             = Copy(tick_50)
      tick.init_rot    = {-90,0,0}
      tick.init_pos    = {(20/120)*rud_sz,0,0}
      tick.controllers = {{"throttle", i, rud_sz * 100/120, rud_sz * 9/120}}
	  tick.material="ARCADE_3_RED"
	  tick.tex_params	   = {256/512,176.5/512,0.5*tex_scale/3,2*tex_scale/3}
      AddElement(tick)
	   
local tick_AP             = Copy(tick_50)
      tick_AP.init_rot    = {-90,0,0}
      tick_AP.init_pos    = {(20/120)*rud_sz,0,0}
      tick_AP.controllers = {{"AP"},{"throttle_AP", i, rud_sz * 100/120, rud_sz * 9/120}}
	  tick_AP.material="ARCADE_3_WHITE"
	  tick_AP.tex_params	   = {256/512,176.5/512,0.5*tex_scale/3,2*tex_scale/3}
      AddElement(tick_AP) 
	 
end