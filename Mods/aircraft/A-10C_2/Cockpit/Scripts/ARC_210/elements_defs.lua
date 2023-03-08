-- common definitions for elements

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

default_box_indices  = {0, 1, 2, 0, 2, 3}
default_rect_indices = {0, 1, 1, 2, 2, 3, 3, 0}

ScreenType = 
{
	SCREENSPACE_FALSE  = 0,
	SCREENSPACE_TRUE   = 1,
	SCREENSPACE_VOLUME = 2
}
	
-- functions
function SetDefaultClip(object)
	object.h_clip_relation = h_clip_relations.COMPARE
	object.level = DEFAULT_LEVEL + 1
end

function AddText_font(name, value, init_x, init_y, init_z, init_rot)
	local txt		= CreateElement "ceText"
	txt.name		= name
	txt.height		= 0.1
	txt.width		= 0.067
	txt.maxsize		= 30
	txt.alignment	= "LeftCenter"
	txt.value		= value
	txt.init_pos	= {init_x, init_y, init_z}
	txt.init_rot	= {init_rot, 0.0, 0.0}
	txt.material	= "GREEN"
	txt.font		= "ILS General"
	return txt
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
