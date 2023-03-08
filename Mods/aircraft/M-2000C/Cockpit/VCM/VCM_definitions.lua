dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."settingsloader.lua")

settings = settingsloader("settings.lua")

VCM_DEFAULT_LEVEL     = 6

SetScale(METERS)
SetCustomScale(GetScale()*0.001)



function set_common_properties(symbol, name, align, pos, parent, controllers)
	pos = pos or {0, 0}

	symbol.name				= name
	symbol.alignment		= align or "CenterCenter"
	symbol.parent_element	= parent
	symbol.controllers 		= controllers or {}
	symbol.init_pos			= {pos[1], pos[2], 0}

	symbol.material			= "vcm_green"
	symbol.thickness		= settings.vcm_thickness*0.2
	symbol.fuzziness		= settings.vcm_thickness*0.6
	symbol.use_mipfilter	= true
	symbol.h_clip_relation	= h_clip_relations.COMPARE
	symbol.level			= VCM_DEFAULT_LEVEL
	symbol.additive_alpha	= true
	symbol.collimated		= false
end

function create_text(name, text, size, align, pos, parent, controllers)

	local obj      = CreateElement "ceStringPoly"

	set_common_properties(obj, name, align, pos, parent, controllers)
	
	size = size or 5
	obj.stringdefs		= { size*0.001, size*0.00056 }
	obj.value			= text or ""
	
	Add(obj)
end


function create_symbol(name, symbol, scale, pos, parent, controllers)
	local obj	       = CreateElement "ceSMultiLine"
	
	set_common_properties(obj, name, "FromSet", pos, parent, controllers)
	obj.points_set  = { "vcm", symbol }
	obj.scale       = (scale or 1.0) * 25.4/96.0

	Add(obj)
	
	return obj
end
