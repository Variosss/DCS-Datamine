dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(FOV) -- set scale factor modifier (in this case FOV - half of horizontal size)
tex_scale = 0.967
X_texmultiplier = 2.0
Y_scalemultiplier = 0.5

aspect  = 1.4676
function SetScreenSpace(object)
	object.screenspace = ScreenType.SCREENSPACE_VOLUME
end

function SetParentScreen(object)
	object.parent_element = "screen"
end


function SetScreenSpaceTexParams(object,xs,ys)
	object.tex_params = {xs,ys,tex_scale*GetScale(),(tex_scale*GetScale()) * Y_scalemultiplier}
end

function SetScreenSpaceTexParamsScale(object,xs,ys,scale)
	object.tex_params = {xs,ys,scale*tex_scale*GetScale(),scale*(tex_scale*GetScale()) * Y_scalemultiplier}
end

function add_dbg_aim_point()
local	box  					= CreateElement "ceSimpleLineObject"
		box.material	   		= "LIGHT_GREY"
		box.primitivetype       = "triangles"
		box.width				= 5/512
		box.vertices			= {{-0.05,-0.05},
								   { 0.05,-0.05},
								   { 0.05, 0.05},
								   {-0.05, 0.05},
								   {-0.05,-0.05}}
		box.controllers       = {{"dbg_aim_point",2,(4/3)*2}}
		SetScreenSpace(box)
		Add(box)
end

function AddFrameBlock(frame_start_number,frame_end_number,add_center_line,scale)

local   frame_start 				  = CreateElement "ceMeshPoly"
local  	name_start					  = frame_start.name
		frame_start.material		  = "SHKVAL_RECT"
		frame_start.isdraw		      = true
		frame_start.isvisible         = false
		frame_start.controllers       = {{"frame_type_control",frame_start_number,frame_end_number},
										 {"target_position_control",2,aspect*2}}
		SetScreenSpace(frame_start)
		Add(frame_start);
		
local left_right_move_scale = 1
local up_down_move_scale    = 1


local   line_vertices 	=				 {{-tex_scale *(4/512),0},
										  { tex_scale *(4/512),0},
										  { tex_scale *(4/512),4},
										  {-tex_scale *(4/512),4}}
local   line_indices    =                 {0, 1, 2, 0, 2, 3}
		
local   RIGHT_frame_border			       = CreateElement "ceMeshPoly"
		RIGHT_frame_border.primitivetype   = "triangles"
		RIGHT_frame_border.vertices		   = {{0, 1},
                                      		  {4, 1}, 
											  {4,-1},
											  {0,-1}}
		RIGHT_frame_border.indices		   = {0, 1, 2, 0, 2, 3}
		RIGHT_frame_border.init_pos		   = {0,0,0}
		RIGHT_frame_border.material		   = "SHKVAL_RECT"
		RIGHT_frame_border.h_clip_relation = h_clip_relations.INCREASE_LEVEL
		RIGHT_frame_border.isdraw		   = true
		RIGHT_frame_border.controllers     = {{"frame_control",0,left_right_move_scale}}
		RIGHT_frame_border.isvisible       = false  
		SetScreenSpace(RIGHT_frame_border)
		RIGHT_frame_border.parent_element  = name_start
		Add(RIGHT_frame_border);

		
local   basic_line                             = CreateElement "ceTexPoly"
		basic_line.vertices                    = line_vertices
		basic_line.indices                     = line_indices
		basic_line.material	                   = "INDICATION_SHKVAL-V_KA50"
		basic_line.init_pos             	   = {0,0,0}
		basic_line.controllers                 = {{"frame_control",-up_down_move_scale,-left_right_move_scale},{"rotate",-math.rad(90)}}
		SetScreenSpaceTexParamsScale(basic_line,251.5/256,0,scale)
		SetDefaultClip(basic_line)
		SetScreenSpace(basic_line)
		basic_line.parent_element  = name_start
		Add(basic_line)

local   basic_line1                            = CreateElement "ceTexPoly"
		basic_line1.vertices                   = basic_line.vertices
		basic_line1.indices                    = basic_line.indices
		basic_line1.material                   = "INDICATION_SHKVAL-V_KA50"
		basic_line1.init_pos                   = {0,0,0}
		basic_line1.controllers                = {{"frame_control",up_down_move_scale,-left_right_move_scale},{"rotate",-math.rad(90)}}
		SetScreenSpaceTexParamsScale(basic_line1,251.5/256,0,scale)
		SetDefaultClip(basic_line1)
		SetScreenSpace(basic_line1)
		basic_line1.parent_element  = name_start
		Add(basic_line1)


local   RIGHT_frame_border1			           = CreateElement "ceMeshPoly"
		RIGHT_frame_border1.primitivetype      = "triangles"
		RIGHT_frame_border1.vertices		   = RIGHT_frame_border.vertices
		RIGHT_frame_border1.indices		       = RIGHT_frame_border.indices
		RIGHT_frame_border1.material		   = "SHKVAL_RECT"
		RIGHT_frame_border1.h_clip_relation    = h_clip_relations.DECREASE_LEVEL
		RIGHT_frame_border1.isdraw		       = true
		RIGHT_frame_border1.controllers        ={{"frame_control",0,left_right_move_scale}}
		RIGHT_frame_border1.isvisible          = false
		SetScreenSpace(RIGHT_frame_border1)
		RIGHT_frame_border1.parent_element  = name_start
		Add(RIGHT_frame_border1);

local   DOWN_frame_border				   = CreateElement "ceMeshPoly"
		DOWN_frame_border.primitivetype    = "triangles"
		DOWN_frame_border.vertices		   = {{-1,-4},
											  { 1,-4},
 											  { 1, 0},
											  {-1, 0}}
		DOWN_frame_border.indices		   = {0, 1, 2, 0, 2, 3}
		DOWN_frame_border.init_pos		   = {0,0,0}
		DOWN_frame_border.material		   = "SHKVAL_RECT"
		DOWN_frame_border.h_clip_relation  = h_clip_relations.INCREASE_LEVEL
		DOWN_frame_border.isdraw		   = true
		DOWN_frame_border.controllers      = {{"frame_control",-up_down_move_scale,0}}
		DOWN_frame_border.isvisible        = false
		SetScreenSpace(DOWN_frame_border)
		DOWN_frame_border.parent_element   = name_start
		Add(DOWN_frame_border);

local   basic_line2                        = CreateElement "ceTexPoly"
		basic_line2.vertices               = basic_line.vertices
		basic_line2.indices                = basic_line.indices
		basic_line2.material	           = "INDICATION_SHKVAL-V_KA50"
		basic_line2.init_pos	           = {0,0,0}
		basic_line2.init_rot	           = {180,0,0}
		basic_line2.controllers            = {{"frame_control",-up_down_move_scale,-left_right_move_scale}}
		SetScreenSpaceTexParamsScale(basic_line2,251.5/256,0,scale)
		SetDefaultClip(basic_line2)
		SetScreenSpace(basic_line2)
		basic_line2.parent_element         = name_start
		Add(basic_line2)

local   basic_line3                        = CreateElement "ceTexPoly"
		basic_line3.vertices               = line_vertices 
		basic_line3.indices                = line_indices    
		basic_line3.material	           = "INDICATION_SHKVAL-V_KA50"
		basic_line3.init_rot	           = {180,0,0}
		basic_line3.controllers            = {{"frame_control",-up_down_move_scale, left_right_move_scale}}
		SetScreenSpaceTexParamsScale(basic_line3,251.5/256,0,scale)
		SetDefaultClip(basic_line3)
		SetScreenSpace(basic_line3)
		basic_line3.parent_element         = name_start
		Add(basic_line3)

		if add_center_line then
		
		local   center_frame_line   		  = CreateElement "ceTexPoly"
				center_frame_line.vertices    = line_vertices
				center_frame_line.indices     = line_indices
				center_frame_line.material	  = "INDICATION_SHKVAL-V_KA50"
				center_frame_line.init_rot	  = {180,0,0}
				SetScreenSpaceTexParamsScale(center_frame_line,251.5/256,0,scale)
				SetDefaultClip(center_frame_line)
				SetScreenSpace(center_frame_line)
				center_frame_line.parent_element  = name_start
				Add(center_frame_line)
		end

local   DOWN_frame_border1				   = CreateElement "ceMeshPoly"
		DOWN_frame_border1.primitivetype   = "triangles"
		DOWN_frame_border1.vertices		   = DOWN_frame_border.vertices
		DOWN_frame_border1.indices		   = DOWN_frame_border.indices
		DOWN_frame_border1.init_pos		   = {0,0,0}
		DOWN_frame_border1.material		   = "SHKVAL_RECT"
		DOWN_frame_border1.h_clip_relation = h_clip_relations.DECREASE_LEVEL
		DOWN_frame_border1.isdraw		   = true
		DOWN_frame_border1.controllers     = {{"frame_control",-up_down_move_scale,0}}
		DOWN_frame_border1.isvisible       = false
		SetScreenSpace(DOWN_frame_border1)
		DOWN_frame_border1.parent_element  = name_start
		Add(DOWN_frame_border1);
end
