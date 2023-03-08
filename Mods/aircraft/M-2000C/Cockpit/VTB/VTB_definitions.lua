dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."settingsloader.lua")

settings = settingsloader("settings.lua")

VTB_BASE_LEVEL     = 64

SetScale(METERS)
SetCustomScale(GetScale()*0.001)

vtb_radar_video_material	= "vtb_radar_video_material"



--Material override functions, working as a stack
local override_materials = {}
function push_color(name)
	table.insert(override_materials, name)
end
function pop_color()
	table.remove(override_materials)
end

default_parent = nil


local cliprects = {}
function push_cliprect(name, left, right, bottom, top, parent)
	clip					= CreateElement "ceMeshPoly"
	clip.name	    		= name	
	clip.vertices			= { {right, top}, { left, top}, { left,bottom}, {right,bottom}, }
	clip.indices			= {0,1,2,0,2,3}
	clip.init_pos			= {0, 0, 0}
	clip.material			= "vtb_red"
	clip.h_clip_relation	= h_clip_relations.INCREASE_IF_LEVEL
	clip.level	        	= VTB_BASE_LEVEL + #cliprects
	clip.isvisible	    	= false
	clip.collimated	    	= false
	clip.z_enabled			= false
	clip.parent_element		= parent or default_parent
	Add(clip)
	
	table.insert(cliprects, {name=name, left=left, right=right, bottom=bottom, top=top, parent=clip.parent_element})
end

function pop_cliprect()
	if #cliprects>0 then
		local name = cliprects[#cliprects].name .. "@@cliprect_end"
		local left = cliprects[#cliprects].left
		local right = cliprects[#cliprects].right
		local top = cliprects[#cliprects].top
		local bottom = cliprects[#cliprects].bottom
		local parent = cliprects[#cliprects].parent
		
		clip					= CreateElement "ceMeshPoly"
		clip.name	    		= name
		clip.vertices			= { {right, top}, { left, top}, { left,bottom}, {right,bottom}, }
		clip.indices			= {0,1,2,0,2,3}
		clip.init_pos			= {0, 0, 0}
		clip.material			= "vtb_red"
		clip.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL
		clip.level	         	= VTB_BASE_LEVEL + #cliprects
		clip.isvisible	    	= false
		clip.collimated	    	= false
		clip.z_enabled			= false
		clip.parent_element 	= parent
		Add(clip)
		table.remove(cliprects)
	end
end









function setSymbolCommonProperties(symbol, name, align, pos, parent, controllers)
	symbol.name             = name
	symbol.isdraw           = true
	symbol.material         = override_materials[#override_materials] or "vtb_cav"
	symbol.use_mipfilter    = true
	symbol.h_clip_relation  = h_clip_relations.COMPARE
	symbol.level			= VTB_BASE_LEVEL + #cliprects
	symbol.additive_alpha   = true
	symbol.collimated 		= false
	symbol.z_enabled 		= false
	symbol.parent_element	= parent or default_parent
	symbol.alignment 		= align
	symbol.thickness		= settings.vtb_thickness*0.06
	symbol.fuzziness		= settings.vtb_thickness*0.30
	
	if controllers ~= nil then
		if type(controllers) == "table" then
			symbol.controllers = controllers
		end
	end
	
	pos = pos or {0, 0}
	symbol.init_pos       	  = {pos[1], pos[2], 0}
end



function create_dummy(name, pos, parent, controllers)
	local obj      = CreateElement "ceSimple"
	setSymbolCommonProperties(obj, name, nil, pos, parent, controllers, nil)
	obj.init_scale = {0.5, 0.5}
	obj.scale = {0.5, 0.5}
	obj.init_size = {0.5, 0.5}
	obj.size = {0.5, 0.5}
	Add(obj)
	return obj
end







function create_text(name, text_format, size, align, pos, parent, controllers)
	local obj      = CreateElement "ceStringPoly"
	material = material or "vtb_green"
	setSymbolCommonProperties(obj, name, align, pos, parent, controllers)
	obj.stringdefs = { size*0.001, size*0.001 , 0, size*0.0005}
	
	if type(text_format) == "table" then
		obj.formats    = text_format
	else
		obj.value = text_format
	end
	
	Add(obj)
	return obj
end



function create_fromsvg(name, symbol, pos, parent, controllers, scale)
	local obj       = CreateElement "ceSMultiLine"
	setSymbolCommonProperties(obj, name, "FromSet", pos, parent, controllers, "vtb_green")
	obj.points_set  = { "vtb", symbol }
	obj.scale       = (scale or 1.0)*25.4/96.0
	Add(obj)
	return obj
end


function create_contact(name, pos, parent, controllers)
	local obj      = CreateElement "ceStringPoly"
	setSymbolCommonProperties(obj, name, "CenterCenter", pos, parent, controllers)
	obj.stringdefs = { 0.005*1.166, 0.004*1.166 }
	obj.value = "0"
	Add(obj)
	return obj
end



function create_contact_mach(name, size, align, pos, parent, controllers)
	local obj      = CreateElement "ceStringPoly"
	setSymbolCommonProperties(obj, name, align, pos, parent, controllers)
	obj.stringdefs = { size*0.001, size*0.001, -size*0.001*0.4, 0 }
	obj.formats = {"%d:%d"}
	Add(obj)
	return obj
end


function create_video(name, left, right, bottom, top, parent, material, controllers)
	local d = 0.5/512
	local e = 511.5/512
	local vrt = {{left,bottom}, {left,top}, {right,top}, {right,bottom}}
	local txc = {{d,d}, {d,e}, {e,e}, {e,d}}
	local ind = {0,1,2,0,2,3}	

	local video = CreateElement "ceTexPoly"
	setSymbolCommonProperties(video, name, nil, {0,0}, parent, controllers)
	video.vertices			= vrt
	video.tex_coords		= txc
	video.indices			= ind
	video.material 			= material
	Add(video)
end


