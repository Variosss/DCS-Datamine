dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_tools.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Baked/CyranoLegacy_bake_config.lua")

local target_mark = addPlaceholder("target_mark", nil, {{"radarContactPosition", 1, AA_azimuth_zone_half, AA_range_vel_zone_half}})

addContactShapes(1, 23, 27, target_mark, 1)
