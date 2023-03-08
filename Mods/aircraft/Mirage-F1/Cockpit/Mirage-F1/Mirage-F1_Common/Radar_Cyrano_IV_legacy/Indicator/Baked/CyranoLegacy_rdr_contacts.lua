dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/CyranoLegacy_tools.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/Radar_Cyrano_IV_legacy/Indicator/Baked/CyranoLegacy_bake_config.lua")

local radar_contact = addPlaceholder("radar_contact", nil, {{"radarContactPosition", 0, AA_azimuth_zone_half, AA_range_vel_zone_half}})

addContactShapes(0, 0, 27, radar_contact, a_r_num * 0.5 / (bake_scale * AA_azimuth_zone_az_scale) / a_o)
