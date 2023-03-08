dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."settingsloader.lua")

settings = settingsloader("settings.lua")


GLASS_LEVEL  	  	  = 8   -- need to be mathed with declared in HUD_glass.lua
HUD_DEFAULT_LEVEL     = GLASS_LEVEL + 1

--all vertices in files who include this file will be scaled in milliradians
SetScale(MILLYRADIANS)

deg_to_mrad = 3.14159*1000/180

default_parent = nil

vth_debug_material	= "vth_debug_material"
debug_red_material = MakeMaterial(nil, {255,0,0,50})

-- VTH Font
font_size_default = {0.005,0.005}


-- Texture Functions
local texture_size_x = 1024
local texture_size_y = 1024



--all object passed to this function will be collimated and cliped by FOV and HUD Glass
function AddHUDElement(object)
	object.use_mipfilter      = true
	object.h_clip_relation    = h_clip_relations.COMPARE
	object.level			  = HUD_DEFAULT_LEVEL
	object.additive_alpha     = true
	object.collimated 		  = true
	Add(object)
end



--Material override functions, working as a stack
local override_materials = {}
function override_material(name)
	table.insert(override_materials, name)
end
function override_material_end()
	table.remove(override_materials)
end




--Clipping functions, working as a stack
local cliprects = {}
function push_cliprect(name, left, right, bottom, top, parent)
	clip					= CreateElement "ceMeshPoly"
	clip.name	    		= name	
	clip.vertices			= { {right, top}, { left, top}, { left,bottom}, {right,bottom}, }
	clip.indices			= {0,1,2 ; 0,2,3}
	clip.init_pos			= {0, 0, 0}
	clip.material			= debug_red_material
	clip.h_clip_relation	= h_clip_relations.INCREASE_IF_LEVEL
	clip.level	        	= HUD_DEFAULT_LEVEL + #cliprects
	clip.isvisible	    	= false
	clip.collimated	    	= true
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
		clip.indices			= {0,1,2 ; 0,2,3}
		clip.init_pos			= {0, 0, 0}
		clip.material			= debug_red_material
		clip.h_clip_relation 	= h_clip_relations.DECREASE_IF_LEVEL
		clip.level	         	= HUD_DEFAULT_LEVEL + #cliprects
		clip.isvisible	    	= false
		clip.collimated	    	= true
		clip.z_enabled			= false
		clip.parent_element 	= parent
		Add(clip)
		
		table.remove(cliprects)
	end
end


function setStrokeSymbolProperties(symbol)
	symbol.draw_as_wire 		= false
end

function setSymbolCommonProperties(symbol, name, align, pos, parent, controllers)
	symbol.name             = name
	symbol.isdraw           = true
	symbol.material         = override_materials[#override_materials] or "vth_green"
	symbol.use_mipfilter    = true
	symbol.h_clip_relation  = h_clip_relations.COMPARE
	symbol.level			= HUD_DEFAULT_LEVEL+#cliprects
	symbol.additive_alpha   = true
	symbol.collimated 		= true
	symbol.parent_element	= parent or default_parent
	symbol.alignment = align or "None"
	
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
	Add(obj)
	return obj
end



--0.001 : milliradian scale
--0.6 : collimation factor
--0.7 : font aspect ratio
local fontfactor_y = 0.001 * 0.6
local fontfactor_x = 0.001 * 0.6 * 0.75
function create_text(name, text_format, size, align, pos, parent, controllers)
	local obj      = CreateElement "ceStringPoly"
	material = material or "vth_green"
	setSymbolCommonProperties(obj, name, align, pos, parent, controllers)
		
	if type(text_format) == "table" then
		obj.formats    = text_format
	else
		obj.value = text_format
	end
	
	obj.stringdefs = { size*fontfactor_y, size*fontfactor_x }
	Add(obj)
	return obj
end


function create_fromsvg(name, symbol, pos, parent, controllers, scale)
	local obj       = CreateElement "ceSMultiLine"
	setSymbolCommonProperties(obj, name, "FromSet", pos, parent, controllers)
	setStrokeSymbolProperties(obj)
	obj.points_set  = { "vth", symbol }
	obj.scale       = scale or 1
	Add(obj)
	return obj
end

