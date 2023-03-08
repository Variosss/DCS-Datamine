dofile(LockOn_Options.script_path.."HUD\\HUD_definitions.lua")

-----------------------------------------------------------------------
--
-- software clip
--
total_field_of_view = create_HUD_element("ceMeshPoly")
total_field_of_view.name = "total_field_of_view"
total_field_of_view.primitivetype = "triangles"

num_points = 32
radius = 1.55
step = math.rad(360.0/num_points)

verts = {}
for i = 1, num_points do
	verts[i] = {(radius * math.cos(i * step)), (radius * math.sin(i * step))}
end

total_field_of_view.vertices = verts

inds = {}
j = 0
for i = 0, 29 do
	j = j + 1
	inds[j] = 0
	j = j + 1
	inds[j] = i + 1
	j = j + 1
	inds[j] = i + 2
end

total_field_of_view.indices			= inds
total_field_of_view.init_pos		= bird_position
total_field_of_view.material		= "GREEN_2"
total_field_of_view.h_clip_relation = h_clip_relations.REWRITE_LEVEL
total_field_of_view.level			= HUD_FOV_LEVEL
total_field_of_view.isdraw			= true
total_field_of_view.change_opacity	= false
total_field_of_view.isvisible		= false
Add(total_field_of_view)



-----------------------------------------------------------------------

local init_pos_p_x =  0.585423350 /GetScale() 
local init_pos_p_y = -0.0499138832/GetScale() 

local hardware_glass_base  			  =  CreateElement "ceSimple"
      hardware_glass_base.name		  = "hardware_glass_base"
	  hardware_glass_base.init_pos	  = {0.0,init_pos_p_y,init_pos_p_x}
      hardware_glass_base.collimated  = false
	  hardware_glass_base.controllers = {{"set_origin_to_cockpit_shape"}}
	  Add(hardware_glass_base)
	  

function add_filter_hud_only()

local	filter			  = CreateElement "ceMeshPoly"
		filter.name		  = "filter"
		filter.primitivetype = "triangles"
		filter.vertices	  = {{-0.9, 0},
							 {-0.9, 2},
							 {0.9 , 2},
							 {0.9 , 0}}
		filter.indices	  = default_box_indices
		filter.init_pos	  = {0.0, -1.0, -0.2}
		filter.init_rot   = {0.0, 0.0, 90.0}
		filter.material   = "BROWN_GLASS"
		filter.collimated = false
		filter.controllers= {{"render_purpose",render_purpose.HUD_ONLY_VIEW},{"filter_rotate",-1}}
		filter.parent_element = hardware_glass_base.name
		Add(filter)
end

add_filter_hud_only()

local old_masks = false

function ellipse(a,b,phi_start,phi_end)
	local a_start = phi_start or 0
	local a_end   = phi_end   or 2 * math.pi
	
	if a_end < 0 then 
	   a_end = a_end + 2 * math.pi
	end
	
	local point = function (phi)
		local  cp = math.cos(phi)
		local  sp = math.sin(phi)
		
		local  bc = b * cp
		local  as = a * sp
		
		local  r = a * b / math.sqrt(bc * bc + as * as)

		return {r * sp,r * cp}
	end
	
	local vertices  = {{0,0},point(a_start)}
	local indices = {}
	
	local step = (a_end - a_start) / 128
	
	for i = 1, 128 do 
		
		local new_cpp_index = #vertices
		
		vertices[new_cpp_index + 1] = point(a_start + i * step)

		indices[#indices + 1] = 0
		indices[#indices + 1] = new_cpp_index - 1
		indices[#indices + 1] = new_cpp_index
	end
	
	local last_cpp_index = #vertices - 1
		
	indices[#indices + 1] = 0
	indices[#indices + 1] = last_cpp_index
	indices[#indices + 1] = 1
	
	
	local elem  	  = CreateElement("ceMeshPoly")
	elem.primitivetype = "triangles"
	elem.vertices	  = vertices
	elem.indices	  = indices
	elem.material     = MakeMaterial("",{200,0,200,100})
	Add(elem)
	return elem
end

local collim_sz_k_near = 1
local collim_sz_k_far = 1

local pos_near = {0.0, -0.66, -0.15}
local pos_far = {0.0, -0.09, 0.45}

local useStereo = false

if useStereo == false then
	local collimator_border_near    			= ellipse(1.2 * collim_sz_k_near, 0.9 * collim_sz_k_near, math.rad(48), -math.rad(48))
	collimator_border_near.init_pos	  			= pos_near
	collimator_border_near.init_rot   			= {0.0, 0.0, -42.0}
	collimator_border_near.parent_element   	= hardware_glass_base.name
	collimator_border_near.h_clip_relation 		= h_clip_relations.INCREASE_IF_LEVEL
	--collimator_border_near.h_clip_relation 	= h_clip_relations.NULL
	collimator_border_near.level	  			= HUD_FOV_LEVEL
	collimator_border_near.isvisible			= false

	local collimator_border_far    				= ellipse(1.3 * collim_sz_k_far, 0.9 * collim_sz_k_far, math.rad(75), -math.rad(75))
	collimator_border_far.init_pos	  			= pos_far
	collimator_border_far.init_rot   			= {180, 0.0, 42.0}
	collimator_border_far.parent_element    	= hardware_glass_base.name
	collimator_border_far.h_clip_relation 		= h_clip_relations.INCREASE_IF_LEVEL
	--collimator_border_far.h_clip_relation 	= h_clip_relations.NULL
	collimator_border_far.level	  				= HUD_FOV_LEVEL
	collimator_border_far.isvisible				= false
else
	-- to update
	
	local collimator_border_near_left    			= ellipse(1.2 * collim_sz_k_near, 0.9 * collim_sz_k_near, math.rad(48), -math.rad(48))
	collimator_border_near_left.init_pos	  		= {-0.15, pos_near[2], pos_near[3]}
	collimator_border_near_left.init_rot   			= {0.0, 0.0, -42.0}
	collimator_border_near_left.parent_element   	= hardware_glass_base.name
	collimator_border_near_left.h_clip_relation 	= h_clip_relations.INCREASE_IF_LEVEL
	--collimator_border_near_left.h_clip_relation 	= h_clip_relations.NULL
	collimator_border_near_left.level	  			= HUD_FOV_LEVEL
	collimator_border_near_left.isvisible			= false

	collimator_border_near_right					= Copy(collimator_border_near_left)
	collimator_border_near_right.init_pos	  		= {0.15, pos_near[2], pos_near[3]}
	Add(collimator_border_near_right)

	local pos_far = {0.0, -0.09, 0.45}

	local collimator_border_far_left    			= ellipse(1.2 * collim_sz_k_far, 0.9 * collim_sz_k_far, math.rad(75), -math.rad(75))
	collimator_border_far_left.init_pos	  			= {-0.15, pos_far[2], pos_far[3]}
	collimator_border_far_left.init_rot   			= {180, 0.0, 42.0}
	collimator_border_far_left.parent_element    	= hardware_glass_base.name
	collimator_border_far_left.h_clip_relation 		= h_clip_relations.INCREASE_IF_LEVEL
	--collimator_border_far_left.h_clip_relation 	= h_clip_relations.NULL
	collimator_border_far_left.level	  			= HUD_FOV_LEVEL
	collimator_border_far_left.isvisible			= false

	collimator_border_far_right						= Copy(collimator_border_far_left)
	collimator_border_far_right.init_pos	  		= {0.15, pos_far[2], pos_far[3]}
	Add(collimator_border_far_right)
end
