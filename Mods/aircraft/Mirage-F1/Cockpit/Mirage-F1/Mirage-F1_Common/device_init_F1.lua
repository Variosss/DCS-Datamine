dofile(LockOn_Options.script_path.."../../Common/device_init_common.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/materials_F1.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Radar_Cyrano_IV_legacy_render_cfg.lua")

creators[devices.INTERCOM] 				= {"F1cmn::F1CE_BE_EE::F1Intercom_CE_BE_EE"}
creators[devices.TRAP137B] 				= {"F1cmn::F1CE_BE_EE::F1_UHF_TRAP137B", 
	LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Comm/TRAP137B.lua"}

if dbgDisableAllIndicators == true then
	return
end

indicators[#indicators + 1] = {"F1cmn::F1CE_BE_EE::F1SightSystemIndicator",
	LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/SightSystem/Indicator/SightSystem_init.lua",
	devices.MAIN,
	{{"PNT-HUD-CENTER","PNT-HUD-DOWN","PNT-HUD-RIGHT"}}
	}

for i = 1, 2 do
	writeParameter("RDR_AG_RENDER_"..i.."_IDX", #indicators)
	indicators[#indicators + 1] = {"ABase::Radar_AG_render",
		LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_render_tgt_init.lua",
		nil,
		{{}, {}, i}
		}
end

local cyrano_device = devices.MAIN
local cyrano_geom_ptrs = {"PNT-RADAR-CENTER","PNT-RADAR-DOWN","PNT-RADAR-RIGHT"}
local cyrano_width_correction = -0.00122480467
local cyrano_bake_geom_corrections = {sh = -0.003, sw = -0.003 + cyrano_width_correction}

writeParameter("RDR_RENDER_SYMBOLS_IDX", #indicators)
indicators[#indicators + 1] = {"F1cmn::F1CE_BE_EE::F1RadarLegacyCmnInd",
	LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Baked/CyranoLegacy_init.lua",
	cyrano_device,
	{cyrano_geom_ptrs, cyrano_bake_geom_corrections}
	}

for i = 1, a_r_num do
	writeParameter("RDR_AA_RENDER_"..i.."_IDX", #indicators)
	indicators[#indicators + 1] = {"F1cmn::F1CE_BE_EE::F1RadarLegacyBakedSymbols",
		LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Baked/CyranoLegacyContacts_init.lua",
		cyrano_device,
		{cyrano_geom_ptrs, cyrano_bake_geom_corrections}
		}
end

indicators[#indicators + 1] = {"F1cmn::F1CE_BE_EE::F1RadarLegacyIndicator",
	LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Main/CyranoLegacy_init.lua",
	cyrano_device,
	--{cyrano_geom_ptrs, {sw = cyrano_width_correction}}
	{cyrano_geom_ptrs, cyrano_bake_geom_corrections}
	}

indicators[#indicators + 1] = {"ABase::aIndicator",
	LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/BakedGeneral/CyranoLegacy_bake_general_init.lua",
	cyrano_device,
	--{cyrano_geom_ptrs, {sw = cyrano_width_correction}}
	{cyrano_geom_ptrs, cyrano_bake_geom_corrections}
	}

