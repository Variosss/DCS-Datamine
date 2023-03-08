
-- degrees to milliradians
degToMil = math.rad(1) * 1000

if collimated == nil then
	collimated 		= false
end

use_mipfilter		= true

if additive_alpha == nil then
	additive_alpha	= true
end

drawDbgGeometry 	= false
-- Does nothing when 'drawDbgGeometry' was set false
drawDbgMarkers  	= false
-- Debug color for symbology
--useDBGcolor  		= false

if INDICATOR_DEFAULT_LEVEL == nil then
	INDICATOR_DEFAULT_LEVEL = 3
end

if dbg_marker_span == nil then
	dbg_marker_span	= 20
end

disable_clipping   	= false
	
tex_scale   		= pixelsPerUnit / texture_resolution

function determineClipRelation(relation, override_disable)
	local override = override_disable or false
	if disable_clipping == true and override == false then
		return h_clip_relations.NULL
	else
		return relation
	end
end

function getTexParams(x, y)
	return {x / texture_resolution, y / texture_resolution, tex_scale, tex_scale}
end

-- All symbology elements are supposed to have this placeholder set as their parent_element
if boresightPos == nil then
	boresightPos = addPlaceholder__Raw("Boresight_Pos", {0, 0}, {{"boresight_pos"}}, collimated)
end

function addPlaceholder(name, init_pos, controllers)
	local placeholder 				= addPlaceholder__Raw(name, init_pos, controllers, collimated)
	placeholder.parent_element 		= boresightPos.name
	return placeholder
end

function add_debug_marker(name, init_pos, span_x, span_y, label_txt, label_shift)
	if drawDbgMarkers then
		
		local material = MakeMaterial("<REF_LINES>", {200, 50, 200, 255})
		local font 	   = MakeFont({used_DXUnicodeFontData = "font_dejavu_lgc_sans_22_white"}, {200, 50, 200, 255})

		-- cross at the marker position
		
		local cross           = CreateElement "ceMeshPoly"
		cross.name   		  = "dbg_ctr_".. (name or label_txt)
		cross.primitivetype   = "lines"
		cross.vertices        = {{-0.5 * span_x, 0.0}, {0.5 * span_x, 0.0}, {0, -0.5 * span_y}, {0, 0.5 * span_y}}
		cross.indices         = {0, 1, 2, 3}
		cross.material        = material
		cross.parent_element  = boresightPos.name
		cross.init_pos        = init_pos or {0, 0}
		cross.collimated      = collimated or false
		Add(cross)
		
		-- marker label text
		
		if label_txt ~= nil then
			local label			  = CreateElement "ceStringPoly"
			label.name   		  = "dbg_lbl_".. (name or label_txt)
			label.alignment		  = "LeftCenter"
			label.value			  = label_txt or name or "<REF>"
			label.material		  = font
			label.stringdefs	  = {0.01, 0.003, 0, 0}
			label.use_mipfilter   = true
			
			if label_shift ~= nil then
				label.init_pos        = label_shift
			else
				label.init_pos        = {0.5 * span_x, 0}
			end
			
			label.parent_element  = cross.name
			label.collimated	  = collimated or false
			Add(label)
		end
		
		return cross
	end
	
	return nil
end

function setTexturedElementProperties(element, name, vertices, tex_params, controllers, init_pos, init_rot, level)
	element.indices			= default_box_indices
	element.name			= name
	
	element.vertices		= vertices
	element.tex_params 		= tex_params
	
	if controllers ~= nil then
		element.controllers	= controllers
	end
	
	element.init_pos		= init_pos
	element.init_rot		= init_rot
	
	element.parent_element  = boresightPos.name
	
	element.h_clip_relation	= determineClipRelation(h_clip_relations.COMPARE)
	element.level			= level or INDICATOR_DEFAULT_LEVEL
	
	element.additive_alpha	= additive_alpha
	element.collimated		= collimated or false
	
	element.use_mipfilter	= use_mipfilter
end

function AddTexuredElement(name, vertices, tex_params, controllers, init_pos, init_rot, level)
	local element			= CreateElement "ceTexPoly"
	
	setTexturedElementProperties(element, name, vertices, tex_params, controllers, init_pos, init_rot, level)
	
	Add(element)

	if drawDbgGeometry then
		local dbg_box 			= CreateElement "ceMeshPoly"
		dbg_box.name 			= name .. "_dbg_box"
		dbg_box.primitivetype 	= "triangles"
		dbg_box.vertices 		= vertices
		dbg_box.indices			= default_box_indices
		dbg_box.material		= "DBG_RED"
		dbg_box.isdraw			= true
		dbg_box.change_opacity	= false
		dbg_box.collimated		= collimated or false
		
		dbg_box.parent_element  = name
	
		Add(dbg_box)
		
		if drawDbgMarkers then
			local dbg_marker = add_debug_marker(name.."_dbg_marker_ctr", {0, 0}, dbg_marker_span, dbg_marker_span)
			dbg_marker.parent_element  = dbg_box.name
		end
	end
	
	return element
end

function AddText(name, controllers, init_pos, level, size)
	local txt				= CreateElement "ceStringPoly"
	txt.name				= name
			
	txt.init_pos			= init_pos
	txt.alignment			= "CenterCenter"
			
	txt.stringdefs			= selectFont(size)
	
	txt.additive_alpha		= additive_alpha
	txt.collimated			= collimated or false
	
	if controllers ~= nil then
		txt.controllers		= controllers
	end
	
	txt.parent_element 		= boresightPos.name
	
	txt.h_clip_relation		= determineClipRelation(h_clip_relations.COMPARE)
	txt.level				= level or INDICATOR_DEFAULT_LEVEL
	txt.use_mipfilter		= use_mipfilter
		
	Add(txt)
	
	return txt
end


function AddText_Pos(name, controllers, init_pos, level, pos, size)
	local txt = AddText(name, controllers, init_pos, level, size)
	txt.alignment = pos
	return txt
end


function AddText_Pos_Val(name, controllers, init_pos, level, pos, value, size)
	local txt = AddText_Pos(name, controllers, init_pos, level, pos, size)
	txt.value = value
	return txt
end

function AddText_Pos_Formats(name, controllers, init_pos, level, pos, formats, size)
	local txt = AddText_Pos(name, controllers, init_pos, level, pos, size)
	txt.formats = formats
	return txt
end

function addMeshBox(Name, Hosts, pos, controllers)

	local GH = {}
	
	if Hosts ~= nil then
		i = 0
		for k, v in pairs(Hosts) do
			i = i+1
			GH[i] = v.name
		end
	end
	
	local MeshBox  				= CreateElement "ceBoundingMeshBox"
	MeshBox.name 				= Name
	
	for k, v in pairs(GH) do
		MeshBox.name = MeshBox.name .. "_" .. v
	end
	
	MeshBox.primitivetype		= "lines"
	MeshBox.material	   		= "INDICATION_COMMON_RED"
	
	if pos ~= nil then
		MeshBox.init_pos = pos
	end
		
	MeshBox.vertices			= {{-1, -1},
								   { 1, -1},
								   { 1, 1},
								   {-1, 1}}
	
	if controllers ~= nil then
		MeshBox.controllers	= controllers
	end
		
	MeshBox.geometry_hosts		= GH
	Add(MeshBox)
		
	return MeshBox
end

function openMaskArea(Name, vertices, controllers, level)

	local mask 				= CreateElement "ceMeshPoly"
	mask.name 				= Name
	mask.primitivetype 		= "triangles"
	mask.vertices 			= vertices
	mask.indices  			= default_box_indices
	mask.material 			= "DBG_RED" --"GREEN"
	mask.h_clip_relation 	= determineClipRelation(h_clip_relations.INCREASE_IF_LEVEL, true)
	mask.level			 	= level
	
	if controllers ~= nil then
		mask.controllers    = controllers
	end
	
	mask.parent_element		= boresightPos.name
	
	--mask.isdraw 			= true
	mask.isvisible  		= drawDbgGeometry
	Add(mask)

	return mask
end

function closeMaskArea(Name, vertices, controllers, level)

	local mask 				= CreateElement "ceMeshPoly"
	mask.name 				= Name
	mask.primitivetype 		= "triangles"
	mask.vertices 			= vertices
	mask.indices  			= default_box_indices
	mask.material 			= "DBG_RED" --"GREEN"
	mask.h_clip_relation 	= determineClipRelation(h_clip_relations.DECREASE_IF_LEVEL, true)
	mask.level			 	= level
	
	if controllers ~= nil then
		mask.controllers   	= controllers
	end
	
	mask.parent_element		= boresightPos.name
	
	mask.isvisible 			= drawDbgGeometry
	Add(mask)

	return mask
end

function CreateDummy()
	local el = CreateElement "ceSimple"
	el.collimated = collimated or false
	
	return el
end
