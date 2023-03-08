dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/device_init_F1.lua")

createMainPanel("F1EE::F1MainPanel_EE", LockOn_Options.script_path.."mainpanel_init_EE.lua")
createDeviceMain("F1EE::F1Main_EE")

local RWR_type  = get_aircraft_property_or_nil("RWR_type") or "ALR_300"

if RWR_type == "ALR_300" then
	local ALR_300_geometry = {{"PNT-RWR-CENTER","PNT-RWR-BOTTOM","PNT-RWR-RIGHT"}}

	indicators[#indicators + 1] = {"F1EE::F1_RWR_ALR_300_Indicator_EE",
		LockOn_Options.script_path.."../../Common/ALR_300/Indicator/ALR_300_init.lua",
		devices.MAIN,
		ALR_300_geometry
		}

	indicators[#indicators + 1] = {"ABase::aIndicator",
		LockOn_Options.script_path.."../../Common/ALR_300/Indicator/Baked/ALR_300_bake_init.lua",
		devices.MAIN,
		ALR_300_geometry
		}
end
