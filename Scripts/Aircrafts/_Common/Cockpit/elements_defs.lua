-- common definitions for elements
dofile(LockOn_Options.common_script_path.."devices_defs.lua")

gettext = require("i_18n")
if not _ then
	function _(str) return gettext.translate(str) end
end

flag_hardware_clip = true
flag_show_clippers = false
flag_show_template = true
flag_show_regions  = false
flag_show_frame	   = false

DEFAULT_LEVEL = 1

BORDERS_COLOR = "BLUE"
REGIONS_COLOR = "GREEN"

FOV           = 1
MILLYRADIANS  = 2
METERS        = 3

h_clip_relations = 
{
	NULL				= 0,
	COMPARE				= 1,
	REWRITE_LEVEL		= 2,
	INCREASE_LEVEL		= 3,
	INCREASE_IF_LEVEL	= 4,
	DECREASE_LEVEL		= 5,
	DECREASE_IF_LEVEL	= 6
}

-- blend mode incorporate both isvisible field and additive alpha 
blend_mode = 
{
	IBM_NO_WRITECOLOR						= 0, -- element will be rendered only to stencil buffer
	IBM_REGULAR								= 1, -- regular work with write mask set to RGBA
	IBM_REGULAR_ADDITIVE_ALPHA				= 2, -- regular work with write mask set to RGBA , additive alpha for HUD 
	IBM_REGULAR_RGB_ONLY					= 3, -- regular work with write mask set to RGB (without alpha)
	IBM_REGULAR_RGB_ONLY_ADDITIVE_ALPHA		= 4, -- regular work with write mask set to RGB (without alpha) , additive alpha for HUD 
	IBM_ONLY_ALPHA							= 5, -- write mask set only for alpha
}

ScreenType = 
{
	SCREENSPACE_FALSE  = 0,
	SCREENSPACE_TRUE   = 1,
	SCREENSPACE_VOLUME = 2
}

default_box_indices  = {0, 1, 2, 0, 2, 3}
default_rect_indices = {0, 1, 1, 2, 2, 3, 3, 0}

-- Build indices for a convex poly.
-- Mesh should be described point-to-point either clockwise or counterclockwise
-- (both will work, as the poly is usually rendered as a two-sided).
function buildConvexPolyIndices(numOfVerts)
	local inds = {}
	
	if numOfVerts < 3 then
		return inds
	end
	
	for i = 1, numOfVerts - 2 do
		inds[#inds + 1] = 0
		inds[#inds + 1] = i
		inds[#inds + 1] = i + 1 
	end 
	
	return inds
end

-- functions
function SetDefaultClip(object)
	object.h_clip_relation = h_clip_relations.COMPARE
	object.level = DEFAULT_LEVEL + 1
end

function set_circle(obj, radius_outer, radius_inner, arc, sides)
	local verts    = {}
	local inds     = {}
	local solid    = radius_inner == nil or radius_inner == 0
	local arc      = arc or 360
	if    arc > 360 then arc = 360 end
	local count    = sides or 32 
	local delta    = math.rad(arc/count)

	local min_i    = 1
	local max_i    = count + 1
	verts[1] = {0,0}
	for i=min_i,max_i do
		if solid then
			verts[1 + i]      = { radius_outer * math.sin(delta *(i-1)),radius_outer * math.cos(delta *(i-1)) }
			inds[3*(i-1) + 1] = 0
			inds[3*(i-1) + 2] = i - 1 
			inds[3*(i-1) + 3] = i 
		else
			verts[2*(i - 1) + 1] = { radius_outer * math.sin(delta *(i-1)), radius_outer * math.cos(delta *(i-1)) }
			verts[2*(i - 1) + 2] = { radius_inner * math.sin(delta *(i-1)), radius_inner * math.cos(delta *(i-1)) }
			
			if i == max_i  then
			  if arc == 360 then  
				inds[6*(i-1) + 1] = 2*(i     - 1)
				inds[6*(i-1) + 2] = 2*(min_i - 1)
				inds[6*(i-1) + 3] = 2*(i     - 1) + 1 
				inds[6*(i-1) + 4] = 2*(i     - 1) + 1
				inds[6*(i-1) + 5] = 2*(min_i - 1)
				inds[6*(i-1) + 6] = 2*(min_i - 1) + 1 
			  end        
			else 
				inds[6*(i-1) + 1] = 2*(i - 1)
				inds[6*(i-1) + 2] = 2*(i) 
				inds[6*(i-1) + 3] = 2*(i - 1) + 1 
				inds[6*(i-1) + 4] = 2*(i - 1) + 1
				inds[6*(i-1) + 5] = 2*(i) 
				inds[6*(i-1) + 6] = 2*(i)     + 1  
			end
		end
	end
	obj.vertices         = verts              
	obj.indices          = inds
end



--[[
function create_region(element, name)
	local region			= CreateElement "ce_s_ClippableRegion"
	region.name				= name
	region.vertices			= element.vertices
	region.init_pos			= element.init_pos
	region.init_rot			= element.init_rot
	region.material			= REGIONS_COLOR
	region.elements			= {element.name}
	region.collimated	    = element.collimated
	region.parent_element	= element.parent_element
	return region
end

function create_HWSircle_region(element, name)
	local region			= CreateElement "ce_s_ClippableRegion"
	region.name				= name
	region.vertices			= element.vertices1
	region.init_pos			= element.init_pos
	region.init_rot			= element.init_rot
	region.material			= REGIONS_COLOR
	region.elements			= {element.name}
	region.collimated	    = element.collimated
	region.parent_element	= element.parent_element
	return region
end
--]]

function drawIndicatorRefGrid(lines_count, step, line_len, collimated, TFOV_radius)
	local placeholder       		= CreateElement "ceSimple"
	placeholder.name        		= "refGridPlaceholder"
	placeholder.collimated  		= collimated or false
	Add(placeholder)
	
	local material 	    = MakeMaterial("<HUD_REF_LINES>", 	   {255, 0,255, 100})
	local material_zero = MakeMaterial("<HUD_REF_LINES_ZERO>", {200, 255,0, 100})
	local font     = MakeFont({used_DXUnicodeFontData = "font_dejavu_lgc_sans_22_white"},{255, 0,255, 255})
	
	local makeLabel    = function(val)
	local   lab						= CreateElement "ceStringPoly"
			lab.alignment			= "LeftCenter"
			if val < 0 then
				lab.value				= string.format("%d",val)
			else
				lab.value				= string.format(" %d",val)
			end
			lab.material			= font
			lab.stringdefs			= {0.005,0.002,0,0}
			lab.use_mipfilter 		= true
			return lab
	end
	
	local line = function(pos_y,i)
		local elv           	= CreateElement "ceMeshPoly"
			elv.primitivetype   = "lines"
			elv.vertices        = {{-0.5 * line_len, 0.0}, {0.5 * line_len, 0.0}}
			elv.indices         = {0, 1}
			if i == 1 then
				elv.material        = material_zero
			else
				elv.material        = material
			end
			elv.init_pos        = {0, pos_y, 0}
			elv.parent_element  = placeholder.name
		Add(elv)
		
		local   label				= makeLabel(pos_y)
		label.init_pos        	= {0.5 * line_len,0}
		label.parent_element    = elv.name
		Add(label)	
		
		return elv
	end
	
	local line_v = function(pos_x,i)
		local elv           	= CreateElement "ceMeshPoly"
			elv.primitivetype   = "lines"
			elv.vertices        = {{0, -0.5 * line_len}, {0,0.5 * line_len}}
			elv.indices         = {0, 1}
			if i == 1 then
				elv.material        = material_zero
			else
				elv.material        = material
			end
			elv.init_pos        = {pos_x, 0, 0}
			elv.parent_element  = placeholder.name
		Add(elv)
		local   label				= makeLabel(pos_x)
			label.init_pos        	= {0,0.5 * line_len,0}
			label.init_rot			= {90}
			label.parent_element    = elv.name
		Add(label)	
		return elv
	end
	
	for i = 1, lines_count do
	
		line  ( step * (i-1),i)
		line_v( step * (i-1),i)
		
		if i ~= 1 then
			line  (-step * (i-1),i)
			line_v(-step * (i-1),i)
		end
	end

	if TFOV_radius ~= nil then
		local TFOV_circle         	= CreateElement "ceMeshPoly"
		TFOV_circle.name          	= "refgrid_total_fov"
		TFOV_circle.primitivetype 	= "triangles"
		set_circle(TFOV_circle, TFOV_radius + 1, TFOV_radius - 1)
		TFOV_circle.material      	= material
		TFOV_circle.parent_element  = placeholder.name
		Add(TFOV_circle)
	end
	
	return placeholder
end
