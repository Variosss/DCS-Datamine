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
base.material       = orange_mat -- "GREEN_TRANSPARENT"
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

rudder_limit             = Copy(rudder_index)
rudder_limit.controllers = {{"rudder_limit",size*1000/rudder_lim},{"rotate",math.rad(-90)}}
--rudder_limit.tex_params	   = {329.5 / 512, 328.5 / 512, 5*tex_scale, 5*tex_scale}
rudder_limit.tex_coords	   = {{293 / 512, 329 / 512}, {330 / 512, 329 / 512}, {330 / 512, 400 / 512}, {293 / 512, 400 / 512}, }
--rudder_limit.tex_coords	   = {{227 / 512, 143 / 512}, {282 / 512, 143 / 512}, {282 / 512, 157 / 512}, {227 / 512, 143 / 512}, }
rudder_limit.parent_element = rudder_scale.name
AddElement(rudder_limit)

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


--------------------------------------------------------------------------
-- Autopilot Indication
local autopilot_len = 4*size
local autopilot_height = box_height*0.7
local au_tex_scale     		= 0.25/autopilot_len
local au_line_width    		= ((4.5/512)/au_tex_scale)/10
local au_ind_line_width 	= ((4.5/512)/au_tex_scale)/5
local au_ind_index_sz   	= (autopilot_len/8)*0.6
		

autopilot_base       		= CreateElement "ceMeshPoly"
autopilot_base.name		    = "autopilot_base"
autopilot_base.primitivetype  = "triangles"
autopilot_base.material       = orange_mat -- "GREEN_TRANSPARENT"
autopilot_base.vertices       = {{0, -autopilot_height},
								{0,  autopilot_height  }, 
								{ autopilot_len                            ,  autopilot_height  },
								{ autopilot_len                            , -autopilot_height }}        
autopilot_base.indices        = default_box_indices
autopilot_base.init_pos       = {0,(1 - autopilot_height)}
autopilot_base.controllers    = {{"show"},{"screenspace_position",2,(aspect-autopilot_len),0},
                                {"screenspace_position",1,0,0}}

autopilot_base.h_clip_relation  = h_clip_relations.REWRITE_LEVEL
autopilot_base.level		      = DEFAULT_LEVEL
AddElement(autopilot_base)

function Add_HP_Limit(i,right,top)
	
	local line_len = au_ind_line_width*3*right
	local line_width = au_ind_line_width/2
	local color = "ARCADE_2_YELLOW"
	if top == 0 then
		line_len = au_ind_line_width*3*right*1.5
		line_width = au_ind_line_width
		color = "ARCADE_3_WHITE"
	end
	
	
	au_HP_limit             = CreateElement "ceTexPoly"
	au_HP_limit.name         = "au_HP_limit"..i..right..top
	au_HP_limit.vertices     = {{0, -line_width},
									{0,  line_width},
									{ line_len,  line_width},
									{ line_len, -line_width}}
	au_HP_limit.indices      = default_box_indices
	au_HP_limit.material	  = color
	au_HP_limit.tex_params	  = {256/512,176.5/512,0.5*au_tex_scale}
	au_HP_limit.init_pos     = {(0.01+(autopilot_len/4)/2+i*autopilot_len/4)+au_ind_index_sz*right,top*(autopilot_len/4)*0.8/2}
	au_HP_limit.parent_element = autopilot_base.name
	AddElement(au_HP_limit)
end

function Add_R_Limit(right,top)
	
	local line_len = au_ind_line_width*3*top
	local line_width = au_ind_line_width/2
	local color = "ARCADE_2_YELLOW"
	
	if right == 0 then
		line_len = au_ind_line_width*3*top*1.5
		line_width = au_ind_line_width
		color = "ARCADE_3_WHITE"
	end
	
	
	au_R_limit             = CreateElement "ceTexPoly"
	au_R_limit.name         = "au_R_limit"..right..top
	au_R_limit.vertices     = {{0, -line_width},
									{0,  line_width},
									{ line_len,  line_width},
									{ line_len, -line_width}}
	au_R_limit.indices      = default_box_indices
	au_R_limit.material	  = color
	au_R_limit.tex_params	  = {256/512,176.5/512,0.5*au_tex_scale}
	au_R_limit.init_pos       = {0.01+(autopilot_len/4)/2+(autopilot_len/4)*0.8/2*right,top*au_ind_index_sz}
	au_R_limit.parent_element = autopilot_base.name
	au_R_limit.init_rot       = {90,0,0}
	AddElement(au_R_limit)
end

function Add_B_30_limit(right)

	local line_width = au_ind_line_width/2
	au_B_limit           = CreateElement "ceTexPoly"
	au_B_limit.name		= "au_B_30_limit"..right
	au_B_limit.vertices  = {{0  , -line_width},
								{0  ,  line_width},
								{ au_ind_line_width*5*right   ,  line_width},
								{ au_ind_line_width*5*right   , -line_width}}
	au_B_limit.indices		= default_box_indices
	au_B_limit.material		= "ARCADE_2_YELLOW"
	au_B_limit.tex_params	= {256/512,176.5/512,0.5*au_tex_scale}
	au_B_limit.init_pos     = {(0.01+(autopilot_len/4)/2+autopilot_len/4)+au_ind_index_sz*right,autopilot_height*0.3*0.5}
	au_B_limit.parent_element = autopilot_base.name
	au_B_limit.init_rot       = {30*right,0,0}
	AddElement(au_B_limit)
end

au_roll_scale           = CreateElement "ceTexPoly"
au_roll_scale.name		= "au_roll_scale"
au_roll_scale.vertices  = {{0   , -au_line_width},
                           {0   ,  au_line_width},
                           { autopilot_len   ,  au_line_width},
                           { autopilot_len   , -au_line_width}}
au_roll_scale.indices		= default_box_indices
au_roll_scale.material	    = "ARCADE_3_WHITE"
au_roll_scale.tex_params	= {256/512,176.5/512,0.5*au_tex_scale}
au_roll_scale.parent_element = autopilot_base.name
--AddElement(au_roll_scale)

--rudder
au_rudder_position              = CreateElement "ceTexPoly"
au_rudder_position.name         = "au_rudder_position"
au_rudder_position.vertices     = {{-au_ind_index_sz, -au_ind_line_width},
								{-au_ind_index_sz,  au_ind_line_width},
								{ au_ind_index_sz,  au_ind_line_width},
								{ au_ind_index_sz, -au_ind_line_width}}
au_rudder_position.indices      = default_box_indices
au_rudder_position.material	  	= "ARCADE_3_WHITE"
au_rudder_position.tex_params	= {256/512,176.5/512,0.5*au_tex_scale}
au_rudder_position.controllers  = {{"autopilot_value",(autopilot_len/4)*0.8/2,0}}
au_rudder_position.init_pos     = {0.01+(autopilot_len/4)/2,0.0}
au_rudder_position.parent_element = autopilot_base.name
AddElement(au_rudder_position)

Add_R_Limit(-1,1)
Add_R_Limit(0,1)
Add_R_Limit(1,1)

Add_R_Limit(-1,-1)
Add_R_Limit(0,-1)
Add_R_Limit(1,-1)

txt_goes_left            	 = CreateElement "ceStringPoly"
txt_goes_left.name       	 = "txt_goes_left"
txt_goes_left.material       = "font_ARCADE_YELLOW"
txt_goes_left.init_pos		 = {0.01,-autopilot_height+ds}
txt_goes_left.alignment      = "LeftBottom"
txt_goes_left.stringdefs     = {0.0035, 0.0035,0,0}
txt_goes_left.value          = 'Л'
txt_goes_left.parent_element = autopilot_base.name
txt_goes_left.controllers  = {{"autopilot_rudder_goes",0}}
AddElement(txt_goes_left)

txt_goes_right            	 = CreateElement "ceStringPoly"
txt_goes_right.name       	 = "txt_goes_right"
txt_goes_right.material       = "font_ARCADE_YELLOW"
txt_goes_right.init_pos		 = {0.01+autopilot_len/4,-autopilot_height+ds}
txt_goes_right.alignment      = "RightBottom"
txt_goes_right.stringdefs     = {0.0035, 0.0035,0,0}
txt_goes_right.value          = "П"
txt_goes_right.parent_element = autopilot_base.name
txt_goes_right.controllers  = {{"autopilot_rudder_goes",1}}
AddElement(txt_goes_right)

--- roll
au_roll_position              = CreateElement "ceTexPoly"
au_roll_position.name         = "au_roll_position"
au_roll_position.vertices     = {{-au_ind_index_sz, -au_ind_line_width},
								{-au_ind_index_sz,  au_ind_line_width},
								{ au_ind_index_sz,  au_ind_line_width},
								{ au_ind_index_sz, -au_ind_line_width}}
au_roll_position.indices      = default_box_indices
au_roll_position.material	  = "ARCADE_3_WHITE"
au_roll_position.tex_params	  = {256/512,176.5/512,0.5*au_tex_scale}
au_roll_position.controllers  = {{"autopilot_value",autopilot_height*0.8,1}}
au_roll_position.init_pos     = {0.01+(autopilot_len/4)/2+autopilot_len/4,0.0}
au_roll_position.parent_element = autopilot_base.name
AddElement(au_roll_position)

Add_B_30_limit(-1)
Add_B_30_limit(1)
Add_HP_Limit(1,-1,0)
Add_HP_Limit(1,1,0)


--- pitch
au_pitch_position             = CreateElement "ceTexPoly"
au_pitch_position.name         = "au_pitch_position"
au_pitch_position.vertices     = {{-au_ind_index_sz, -au_ind_line_width},
								{-au_ind_index_sz,  au_ind_line_width},
								{ au_ind_index_sz,  au_ind_line_width},
								{ au_ind_index_sz, -au_ind_line_width}}
au_pitch_position.indices      = default_box_indices
au_pitch_position.material	  = "ARCADE_3_WHITE"
au_pitch_position.tex_params	  = {256/512,176.5/512,0.5*au_tex_scale}
au_pitch_position.controllers  = {{"autopilot_value",(autopilot_len/4)*0.8/2,2}}
au_pitch_position.init_pos     = {0.01+(autopilot_len/4)/2+2*autopilot_len/4,0.0}
au_pitch_position.parent_element = autopilot_base.name
AddElement(au_pitch_position)

Add_HP_Limit(2,-1,-1)
Add_HP_Limit(2,-1,1)
Add_HP_Limit(2,-1,0)
Add_HP_Limit(2,1,0)
Add_HP_Limit(2,1,-1)
Add_HP_Limit(2,1,1)

--- height
au_height_position             = CreateElement "ceTexPoly"
au_height_position.name         = "au_height_position"
au_height_position.vertices     = {{-au_ind_index_sz, -au_ind_line_width},
								{-au_ind_index_sz,  au_ind_line_width},
								{ au_ind_index_sz,  au_ind_line_width},
								{ au_ind_index_sz, -au_ind_line_width}}
au_height_position.indices      = default_box_indices
au_height_position.material	  = "ARCADE_3_WHITE"
au_height_position.tex_params	  = {256/512,176.5/512,0.5*au_tex_scale}
au_height_position.controllers  = {{"autopilot_value",(autopilot_len/4)*0.8/2,3}}
au_height_position.init_pos     = {0.01+(autopilot_len/4)/2+3*autopilot_len/4,0.0}
au_height_position.parent_element = autopilot_base.name
AddElement(au_height_position)

Add_HP_Limit(3,-1,-1)
Add_HP_Limit(3,-1,1)
Add_HP_Limit(3,-1,0)
Add_HP_Limit(3,1,0)
Add_HP_Limit(3,1,-1)
Add_HP_Limit(3,1,1)

local chan_names = {"H","K","T","B"}

for i = 0,3 do	
	txt_chan_name            	 = CreateElement "ceStringPoly"
	txt_chan_name.name       	 = "txt_chan_name"..i
	txt_chan_name.material       = "font_ARCADE_WHITE"
	txt_chan_name.init_pos		 = {0.01+i*autopilot_len/4,autopilot_height}
	txt_chan_name.alignment      = "LeftTop"
	txt_chan_name.stringdefs     = {0.0035, 0.0035,0,0}
	txt_chan_name.value          = chan_names[i+1]
	txt_chan_name.parent_element = autopilot_base.name
	txt_chan_name.isdraw 		 = true
	AddElement(txt_chan_name)
end