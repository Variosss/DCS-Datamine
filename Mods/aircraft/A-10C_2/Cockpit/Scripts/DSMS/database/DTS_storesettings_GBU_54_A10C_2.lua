
WeaponNamesByWpn[#WeaponNamesByWpn + 1] = {GBU54_B,"GBU-54"}

storesPermissions[1]["gbutypes"]["GBU54"]  = false
storesPermissions[2]["gbutypes"]["GBU54"]  = false
storesPermissions[3]["gbutypes"]["GBU54"]  = true
storesPermissions[4]["gbutypes"]["GBU54"]  = true
storesPermissions[5]["gbutypes"]["GBU54"]  = true
storesPermissions[6]["gbutypes"]["GBU54"]  = false
storesPermissions[7]["gbutypes"]["GBU54"]  = true
storesPermissions[8]["gbutypes"]["GBU54"]  = true
storesPermissions[9]["gbutypes"]["GBU54"]  = true
storesPermissions[10]["gbutypes"]["GBU54"] = false
storesPermissions[11]["gbutypes"]["GBU54"] = false

TYPE_STRINGS["GBU54"] = GBU54_B

common_types["GBU54"] = GBU54_B

local idx = #ProfileParametrsByWpn + 1
ProfileParametrsByWpn[idx] = {}
ProfileParametrsByWpn[idx]["type"] = GBU54_B
ProfileParametrsByWpn[idx]["strings"] = {}
ProfileParametrsByWpn[idx]["strings"][1]  = BMB_MNT_PARAMS
ProfileParametrsByWpn[idx]["strings"][2]  = NOSE_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][3]  = TAIL_FZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][4]  = MIN_ALT_PARAMS
ProfileParametrsByWpn[idx]["strings"][5]  = IAM_TARGET_PARAMS
ProfileParametrsByWpn[idx]["strings"][6]  = IMP_ANG_PARAMS
ProfileParametrsByWpn[idx]["strings"][7]  = IMP_AZ_PARAMS
--ProfileParametrsByWpn[idx]["strings"][8]  = PATT_AZ_PARAMS
ProfileParametrsByWpn[idx]["strings"][9]  = AUTO_LS_PARAMS
ProfileParametrsByWpn[idx]["strings"][10] = LS_TIME_PARAMS
ProfileParametrsByWpn[idx]["strings"][11] = LASER_CODE_PARAMS
ProfileParametrsByWpn[idx]["settings"] = {}
ProfileParametrsByWpn[idx]["settings"][1]  = DATA_MIN_ALT
--ProfileParametrsByWpn[idx]["settings"][2]  = DATA_PATT_AZ
ProfileParametrsByWpn[idx]["settings"][3]  = DATA_IMP_AZ
ProfileParametrsByWpn[idx]["settings"][4]  = DATA_IMP_ANG
ProfileParametrsByWpn[idx]["settings"][5]  = DATA_IAM_TARGET
ProfileParametrsByWpn[idx]["settings"][8]  = DATA_AUTO_LS
ProfileParametrsByWpn[idx]["settings"][10] = DATA_LS_TIME
ProfileParametrsByWpn[idx]["nose_fuzes"] = {}
ProfileParametrsByWpn[idx]["nose_fuzes"][1] = NOSE_FZ_NONE
ProfileParametrsByWpn[idx]["nose_fuzes"][2] = NOSE_FZ_DSU38
ProfileParametrsByWpn[idx]["nose_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["nose_set_by_fuze"][NOSE_FZ_DSU38] = {NOSE_SET_1_8}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_NONE] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU152}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_FMU139LD] = {TAIL_FZ_FMU139LD, TAIL_FZ_FMU152}
ProfileParametrsByWpn[idx]["tail_fuze_by_fuze"][NOSE_FZ_DSU38] = {TAIL_FZ_FMU139LD}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"] = {}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU139LD] = {TAIL_SET_4, TAIL_SET_6, TAIL_SET_7, TAIL_SET_10, TAIL_SET_14, TAIL_SET_20}
ProfileParametrsByWpn[idx]["tail_set_by_fuze"][TAIL_FZ_FMU152] = {TAIL_SET_2, TAIL_SET_26, TAIL_SET_3, TAIL_SET_4, TAIL_SET_5}
