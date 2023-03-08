
WeaponNamesByWpn[#WeaponNamesByWpn + 1] = {AGM65E,"AGM-65E"}
WeaponNamesByWpn[#WeaponNamesByWpn + 1] = {TGM65E,"TGM-65E"}
WeaponNamesByWpn[#WeaponNamesByWpn + 1] = {AGM65L,"AGM-65L"}
WeaponNamesByWpn[#WeaponNamesByWpn + 1] = {TGM65L,"TGM-65L"}

maverick_types["AGM65E"] = AGM65E
maverick_types["TGM65E"] = TGM65E
maverick_types["AGM65L"] = AGM65L
maverick_types["TGM65L"] = TGM65L

local idx
idx = #ProfileParametrsByWpn + 1
local idx_agm65e = idx
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = AGM65E
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1] = LAUNCHER_PARAMS
ProfileParametrsByWpn[idx]["strings"][2] = MIN_ALT_PARAMS
--ProfileParametrsByWpn[idx]["strings"][3] = LASER_CODE_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1] = DATA_MIN_ALT

idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = TGM65E
ProfileParametrsByWpn[idx]["strings"]	= ProfileParametrsByWpn[idx_agm65e]["strings"]
ProfileParametrsByWpn[idx]["settings"]	= ProfileParametrsByWpn[idx_agm65e]["settings"]

idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = AGM65L
ProfileParametrsByWpn[idx]["strings"]	= ProfileParametrsByWpn[idx_agm65e]["strings"]
ProfileParametrsByWpn[idx]["settings"]	= ProfileParametrsByWpn[idx_agm65e]["settings"]

idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = TGM65L
ProfileParametrsByWpn[idx]["strings"]	= ProfileParametrsByWpn[idx_agm65e]["strings"]
ProfileParametrsByWpn[idx]["settings"]	= ProfileParametrsByWpn[idx_agm65e]["settings"]
