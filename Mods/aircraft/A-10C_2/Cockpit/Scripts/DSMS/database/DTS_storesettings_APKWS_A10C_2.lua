
WeaponNamesByWpn[#WeaponNamesByWpn + 1] = {M151_APKWS, "M-151L"}
WeaponNamesByWpn[#WeaponNamesByWpn + 1] = {M282_APKWS, "M-282L"}

TYPE_STRINGS["M151L"] = M151_APKWS
TYPE_STRINGS["M282L"] = M282_APKWS

rocket_types["M151L"] = M151_APKWS
rocket_types["M282L"] = M282_APKWS

local idx = #ProfileParametrsByWpn + 1
local idx_m151_apkws = idx
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = M151_APKWS
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = POD_SET_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = LAU_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][3] = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][4] = ADJ_RT_PARAMS
ProfileParametrsByWpn[idx]["strings"][5] = ADJ_UP_PARAMS
ProfileParametrsByWpn[idx]["strings"][6] = LASER_CODE_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT
ProfileParametrsByWpn[idx]["settings"][2] = DATA_ADJ_RT
ProfileParametrsByWpn[idx]["settings"][3] = DATA_ADJ_UP

idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = M282_APKWS
ProfileParametrsByWpn[idx]["strings"] = ProfileParametrsByWpn[idx_m151_apkws]["strings"]
ProfileParametrsByWpn[idx]["settings"] = ProfileParametrsByWpn[idx_m151_apkws]["settings"]
