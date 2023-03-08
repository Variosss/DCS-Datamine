dofile(LockOn_Options.common_script_path.."elements_defs.lua")

local texture_red = MakeMaterial("Bazar/Textures/AvionicsCommon/arcade.tga",{255, 0, 0, 255})

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

local roll_stick_movement           = 140
local k                             = size / roll_stick_movement
local pitch_stick_movement_positive = 140 * k
local pitch_stick_movement_negative = 140 * k
--[[
    CURR_SCREENSPACE_NONE = 0,
    CURR_SCREENSPACE_HUD_ONLY_VIEW = 1,
    CURR_SCREENSPACE_ARCADE = 2,
--]]

local ds           	 = 0.05 * size
local rud_shift    	 = 0.1*size
local rud_base_shift = 0.3*size
local orange_mat   	 = MakeMaterial("",{255,100,0,50})
local rudder_shift   = 0.1*size

base       			= CreateElement "ceMeshPoly"
base.name		    = "base"
base.primitivetype  = "triangles"
base.material       = orange_mat -- "GREEN_TRANSPARENT"
base.vertices       = {{-(size + rud_shift + rud_base_shift + 3.0*line_width + ds), -(size + 2 * ds + rudder_shift)},
                       {-(size + rud_shift + rud_base_shift + 3.0*line_width + ds),  pitch_stick_movement_negative  + ds}, 
                       { size  + ds                            ,	 pitch_stick_movement_negative  + ds},
                       { size  + ds                            , 	-(size + 2 * ds + rudder_shift)}}        
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
pitch_scale.material	   = texture_red
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
roll_scale.material	      = texture_red
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
stick_position.material	       = texture_red
stick_position.tex_params	   = {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
stick_position.controllers    = {{"stick_pitch", pitch_stick_movement_positive},
                                 {"stick_roll" ,-size}}
stick_position.parent_element = base.name
AddElement(stick_position)

--[[trimmer_stick_position                 = CreateElement "ceTexPoly"
trimmer_stick_position.name            = "trimmer_stick_position"
trimmer_stick_position.vertices        = {{-stick_index_sz, -stick_index_sz},
										  {-stick_index_sz,  stick_index_sz},
										  { stick_index_sz,  stick_index_sz},
										  { stick_index_sz, -stick_index_sz}}
trimmer_stick_position.indices         = default_box_indices
trimmer_stick_position.material	       = texture_red
trimmer_stick_position.tex_params	   = {330/512, 365.5 / 512, 2*tex_scale, 2*tex_scale/0.8}
trimmer_stick_position.controllers     = {{"trimmer_stick_pitch", pitch_stick_movement_positive},
										  {"trimmer_stick_roll" ,-size},
										  {"scale",0.5,0.5}}
trimmer_stick_position.parent_element  = base.name
AddElement(trimmer_stick_position)
]]


rudder_scale                = Copy(roll_scale)
rudder_scale.init_pos       = {0,-(pitch_stick_movement_positive + rudder_shift)}
AddElement(rudder_scale)

rudder_index             = Copy(roll_scale)
rudder_index.vertices    = {{-2.0*line_width , -line_width},
                            {-2.0*line_width ,  line_width},
                            { 2.0*line_width ,  line_width},
                            { 2.0*line_width , -line_width}}
rudder_index.controllers = {{"rudder",size},{"rotate",math.rad(90)}}
rudder_index.parent_element = rudder_scale.name
AddElement(rudder_index)

local rud_base			= CreateElement "ceSimple"
rud_base.name		    = "rud_base"
rud_base.init_pos 		= {-(size + rud_base_shift) ,0}
rud_base.init_rot       = {90}
rud_base.parent_element	= base.name
AddElement(rud_base)


local rud_sz   = pitch_stick_movement_positive + 0.1*size

local rud = Copy(pitch_scale)
rud.vertices       = {{ 0      , -line_width},
                            { 0      ,  line_width},
                            { rud_sz   ,  line_width},
                            { rud_sz   , -line_width}}
        
rud.parent_element =   rud_base.name
rud.init_pos       =   {-rud_sz, rud_shift}
rud.init_rot       = {0,0,0}
AddElement(rud)
      
--[[local tick_35 = Copy(roll_scale)
     
      tick_35.vertices    = {{-1.5*line_width, -line_width},{-1.5*line_width,  line_width},{ 0 ,  line_width},{ 0 , -line_width}}   
      tick_35.parent_element = rud.name
      tick_35.init_pos       = {(13/120)*rud_sz,0,0}
      tick_35.init_rot       = {90,0,0}
      AddElement(tick_35)]]

local tick = Copy(roll_scale)
    
tick.vertices    = {{-3.0*line_width, -line_width},{-3.0*line_width,  line_width},{ 0 ,  line_width},{ 0 , -line_width}}   
tick.parent_element = rud.name
tick.init_rot    = {-90,0,0}
tick.init_pos    = {0,0,0}
tick.controllers = {{"throttle",rud_sz}}
AddElement(tick)  
 
local brakes_pos 		   = {size,rudder_scale.init_pos[2]}

local sz_wheel_brake       = 1 * pitch_stick_movement_negative

for i = 1,2 do

	local signum = {-1,1}
	local 	wheel_brake_mask                = CreateElement "ceMeshPoly"
			wheel_brake_mask.name		    = "wheel_brake_mask_"..tostring(i)
			wheel_brake_mask.primitivetype  = "triangles"
			wheel_brake_mask.vertices       = {{0                    ,0},
											   {0                    ,sz_wheel_brake},
											   {-signum[i] * 0.3 * sz_wheel_brake ,sz_wheel_brake},
											   {-signum[i] * 0.3 * sz_wheel_brake ,0}}
			wheel_brake_mask.indices		= {0,1,2,0,2,3}
			wheel_brake_mask.material	    = "MASK_MATERIAL"
			wheel_brake_mask.init_pos       = {signum[i] * brakes_pos[1],brakes_pos[2]}
			wheel_brake_mask.parent_element = base.name
			wheel_brake_mask.controllers    = {{"brakes_value",i,sz_wheel_brake}}
			wheel_brake_mask.h_clip_relation  = h_clip_relations.INCREASE_LEVEL
			wheel_brake_mask.isvisible      = false
			AddElement(wheel_brake_mask)
			

			
			


	local	wheel_brake                = CreateElement "ceMeshPoly"
			wheel_brake.name		   = "wheel_brake_"..tostring(i)
			wheel_brake.primitivetype  = "triangles"
			wheel_brake.vertices       = {{0 ,0},
										  {0 ,sz_wheel_brake},
										  { -signum[i] * 0.3 * sz_wheel_brake,sz_wheel_brake}}
			wheel_brake.indices		   = {0,1,2}
			wheel_brake.material	   = "INDICATION_COMMON_RED"
			wheel_brake.init_pos       =  wheel_brake_mask.init_pos
			wheel_brake.parent_element  = base.name
			wheel_brake.h_clip_relation = h_clip_relations.COMPARE
			wheel_brake.level		    = DEFAULT_LEVEL
			AddElement(wheel_brake)
			
	local 	wheel_brake_actual                = CreateElement "ceMeshPoly"
			wheel_brake_actual.name		    = "wheel_brake_actual_"..tostring(i)
			wheel_brake_actual.primitivetype  = "triangles"
			wheel_brake_actual.vertices       = {{0                    ,-0.02 * sz_wheel_brake},
											     {0                    ,0.02 * sz_wheel_brake},
											     {-signum[i] * 0.3 * sz_wheel_brake ,0.02 * sz_wheel_brake},
											     {-signum[i] * 0.3 * sz_wheel_brake ,-0.02 * sz_wheel_brake}}
			wheel_brake_actual.indices	      = {0,1,2,0,2,3}
			wheel_brake_actual.material	      = "LBLUE"
			wheel_brake_actual.init_pos       = {signum[i] * brakes_pos[1],brakes_pos[2]}
			wheel_brake_actual.parent_element = base.name
			wheel_brake_actual.controllers    = {{"brakes_value_actual",i,sz_wheel_brake}}
			AddElement(wheel_brake_actual)

end