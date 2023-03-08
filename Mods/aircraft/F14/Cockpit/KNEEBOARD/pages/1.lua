dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
dofile(LockOn_Options.script_path.."materials.lua")
dofile(LockOn_Options.script_path.."fonts.lua")
SetScale(FOV)

add_picture(LockOn_Options.script_path.."Resources/IndicationTextures/kneepad.dds")

local gettext = require("i_18n")
_ = gettext.translate

function AddElement(object)
 object.use_mipfilter = true
 Add(object)
end

-- fonts
font_size_x = 0.0075
font_size_y = font_size_x
font_keyhint_defs = {font_size_y * 0.6, font_size_x * 0.6, -0.0009, 0.0}

font_size_item_y = 0.0070
font_size_item_x = 0.5517 * font_size_item_y

font_item_defs = {font_size_item_y, font_size_item_x, -0.0007, 0.0}
font_title_defs = {font_size_y, font_size_x, 0.0, 0.0}

local start_line_y = 1.22
local line_size_y = 0.137

local function getLineY(line)
 return start_line_y - line_size_y * (line)
end

local keyhint_pos_x = 0.95

local item_pos_x = -0.32


local initload_pos_y = getLineY(0)

Name_GndCrewSet = CreateElement "ceStringPoly"
Name_GndCrewSet.name = "Name_GndCrewSet"
Name_GndCrewSet.material = "font_kneeboard"
Name_GndCrewSet.init_pos = {0, initload_pos_y, 0}
Name_GndCrewSet.value = _("GROUND SETTINGS")
Name_GndCrewSet.alignment = "CenterBottom"
Name_GndCrewSet.stringdefs = font_item_defs
AddElement(Name_GndCrewSet)

local LGBCode_pos_y = getLineY(1)
local LGBCode100_pos_y = getLineY(2)
local LGBCode10_pos_y = getLineY(3)
local LGBCode1_pos_y = getLineY(4)

Name_LGBCode = CreateElement "ceStringPoly"
Name_LGBCode.name = "Name_LGBCode"
Name_LGBCode.material = "font_kneeboard"
Name_LGBCode.init_pos = {item_pos_x, LGBCode_pos_y, 0}
Name_LGBCode.value = _("LASER CODE : ")
Name_LGBCode.alignment = "RightBottom"
Name_LGBCode.stringdefs = font_item_defs
Name_LGBCode.controllers = {{"LGB_CustomCode", -1}}
AddElement(Name_LGBCode)

LGB_CustomCode1000 = CreateElement "ceStringPoly"
LGB_CustomCode1000.name = "LGB_CustomCode1000"
LGB_CustomCode1000.material = "font_kneeboard"
LGB_CustomCode1000.init_pos = {item_pos_x, LGBCode_pos_y, 0}
LGB_CustomCode1000.value = "1"
LGB_CustomCode1000.alignment = "LeftBottom"
LGB_CustomCode1000.stringdefs = font_item_defs
LGB_CustomCode1000.controllers = {{"LGB_CustomCode", -1}}
AddElement(LGB_CustomCode1000)

LGB_CustomCode100 = CreateElement "ceStringPoly"
LGB_CustomCode100.name = "LGB_CustomCode100"
LGB_CustomCode100.material = "font_kneeboard"
LGB_CustomCode100.init_pos = {item_pos_x, LGBCode100_pos_y, 0}
LGB_CustomCode100.value = "6"
LGB_CustomCode100.alignment = "LeftBottom"
LGB_CustomCode100.stringdefs = font_item_defs
LGB_CustomCode100.controllers = {{"LGB_CustomCode", 0}}
AddElement(LGB_CustomCode100)

Key_LGBCode100 = CreateElement "ceStringPoly"
Key_LGBCode100.name = "Key_LGBCode100"
Key_LGBCode100.material = "font_general_blue"
Key_LGBCode100.init_pos = {keyhint_pos_x, LGBCode100_pos_y, 0}
Key_LGBCode100.value = _("RSHIFT-RALT-1")
Key_LGBCode100.alignment = "RightBottom"
Key_LGBCode100.stringdefs = font_keyhint_defs
Key_LGBCode100.controllers = {{"LGB_CustomCode", -1}}
AddElement(Key_LGBCode100)

LGB_CustomCode10 = CreateElement "ceStringPoly"
LGB_CustomCode10.name = "LGB_CustomCode10"
LGB_CustomCode10.material = "font_kneeboard"
LGB_CustomCode10.init_pos = {item_pos_x, LGBCode10_pos_y, 0}
LGB_CustomCode10.value = "8"
LGB_CustomCode10.alignment = "LeftBottom"
LGB_CustomCode10.stringdefs = font_item_defs
LGB_CustomCode10.controllers = {{"LGB_CustomCode", 1}}
AddElement(LGB_CustomCode10)

Key_LGBCode10 = CreateElement "ceStringPoly"
Key_LGBCode10.name = "Key_LGBCode10"
Key_LGBCode10.material = "font_general_blue"
Key_LGBCode10.init_pos = {keyhint_pos_x, LGBCode10_pos_y, 0}
Key_LGBCode10.value = _("RSHIFT-RALT-2")
Key_LGBCode10.alignment = "RightBottom"
Key_LGBCode10.stringdefs = font_keyhint_defs
Key_LGBCode10.controllers = {{"LGB_CustomCode", -1}}
AddElement(Key_LGBCode10)

LGB_CustomCode1 = CreateElement "ceStringPoly"
LGB_CustomCode1.name = "LGB_CustomCode1"
LGB_CustomCode1.material = "font_kneeboard"
LGB_CustomCode1.init_pos = {item_pos_x, LGBCode1_pos_y, 0}
LGB_CustomCode1.value = "8"
LGB_CustomCode1.alignment = "LeftBottom"
LGB_CustomCode1.stringdefs = font_item_defs
LGB_CustomCode1.controllers = {{"LGB_CustomCode", 2}}
AddElement(LGB_CustomCode1)

Key_LGBCode1 = CreateElement "ceStringPoly"
Key_LGBCode1.name = "Key_LGBCode1"
Key_LGBCode1.material = "font_general_blue"
Key_LGBCode1.init_pos = {keyhint_pos_x, LGBCode1_pos_y, 0}
Key_LGBCode1.value = _("RSHIFT-RALT-3")
Key_LGBCode1.alignment = "RightBottom"
Key_LGBCode1.stringdefs = font_keyhint_defs
Key_LGBCode1.controllers = {{"LGB_CustomCode", -1}}
AddElement(Key_LGBCode1)

local burstmode_pos_y = getLineY(6)

Name_M61Burst = CreateElement "ceStringPoly"
Name_M61Burst.name = "Name_M61Burst"
Name_M61Burst.material = "font_kneeboard"
Name_M61Burst.init_pos = {item_pos_x, burstmode_pos_y, 0}
Name_M61Burst.value = _("M-61 BURST : ")
Name_M61Burst.alignment = "RightBottom"
Name_M61Burst.stringdefs = font_item_defs
AddElement(Name_M61Burst)

M61BurstMode = CreateElement "ceStringPoly"
M61BurstMode.name = "M61BurstMode"
M61BurstMode.material = "font_kneeboard"
M61BurstMode.init_pos = {item_pos_x, burstmode_pos_y, 0}
M61BurstMode.value = "MANUAL" -- "BURST 50" "BURST 100" "BURST 200"
M61BurstMode.alignment = "LeftBottom"
M61BurstMode.stringdefs = font_item_defs
M61BurstMode.controllers = {{"M61_burstmode"}}
AddElement(M61BurstMode)

Key_M61Burst = CreateElement "ceStringPoly"
Key_M61Burst.name = "Key_M61Burst"
Key_M61Burst.material = "font_general_blue"
Key_M61Burst.init_pos = {keyhint_pos_x, burstmode_pos_y, 0}
Key_M61Burst.value = _("RSHIFT-RALT-4")
Key_M61Burst.alignment = "RightBottom"
Key_M61Burst.stringdefs = font_keyhint_defs
AddElement(Key_M61Burst)

local ky28enc_pos_y = getLineY(8)

submodel = get_aircraft_type()
if submodel ~= "F-14A-95-GR" then
    Name_KY28Enc = CreateElement "ceStringPoly"
    Name_KY28Enc.name = "Name_KY28Enc"
    Name_KY28Enc.material = "font_kneeboard"
    Name_KY28Enc.init_pos = {item_pos_x, ky28enc_pos_y, 0}
    Name_KY28Enc.value = _("KY-28 KEY : ")
    Name_KY28Enc.alignment = "RightBottom"
    Name_KY28Enc.stringdefs = font_item_defs
    AddElement(Name_KY28Enc)

    KY28Enc = CreateElement "ceStringPoly"
    KY28Enc.name = "KY28Enc"
    KY28Enc.material = "font_kneeboard"
    KY28Enc.init_pos = {item_pos_x, ky28enc_pos_y, 0}
    KY28Enc.value = "1"
    KY28Enc.alignment = "LeftBottom"
    KY28Enc.stringdefs = font_item_defs
    KY28Enc.controllers = {{"KY28_key"}}
    AddElement(KY28Enc)

    Key_KY28Enc = CreateElement "ceStringPoly"
    Key_KY28Enc.name = "Key_KY28Enc"
    Key_KY28Enc.material = "font_general_blue"
    Key_KY28Enc.init_pos = {keyhint_pos_x, ky28enc_pos_y, 0}
    Key_KY28Enc.value = _("RSHIFT-RALT- +/-")
    Key_KY28Enc.alignment = "RightBottom"
    Key_KY28Enc.stringdefs = font_keyhint_defs
    AddElement(Key_KY28Enc)
end


local latlong_pos_y = getLineY(10)

LatLong_Name = CreateElement "ceStringPoly"
LatLong_Name.name = "LatLong_Name"
LatLong_Name.material = "font_kneeboard"
LatLong_Name.init_pos = {item_pos_x, latlong_pos_y, 0}
LatLong_Name.value = _("LAT LONG : ")
LatLong_Name.alignment = "RightBottom"
LatLong_Name.stringdefs = font_item_defs
LatLong_Name.controllers = {{"on_ground"}}
AddElement(LatLong_Name)

CarrierInfo_LatLong = CreateElement "ceStringPoly"
CarrierInfo_LatLong.name = "CarrierInfo_LatLong"
CarrierInfo_LatLong.material = "font_kneeboard"
CarrierInfo_LatLong.init_pos = {item_pos_x, latlong_pos_y, 0}
CarrierInfo_LatLong.alignment = "LeftBottom"
CarrierInfo_LatLong.stringdefs = font_item_defs
CarrierInfo_LatLong.controllers = {{"latlong"}}
AddElement(CarrierInfo_LatLong)

local GroundAlt_pos_y = getLineY(11)

GroundAlt_Name = CreateElement "ceStringPoly"
GroundAlt_Name.name = "GroundAlt_Name"
GroundAlt_Name.material = "font_kneeboard"
GroundAlt_Name.init_pos = {item_pos_x, GroundAlt_pos_y, 0}
GroundAlt_Name.value = _("ELEV MSL : ")
GroundAlt_Name.alignment = "RightBottom"
GroundAlt_Name.stringdefs = font_item_defs
GroundAlt_Name.controllers = {{"on_ground"}}
AddElement(GroundAlt_Name)

GroundAlt = CreateElement "ceStringPoly"
GroundAlt.name = "GroundAlt"
GroundAlt.material = "font_kneeboard"
GroundAlt.init_pos = {item_pos_x, GroundAlt_pos_y, 0}
GroundAlt.alignment = "LeftBottom"
GroundAlt.stringdefs = font_item_defs
GroundAlt.controllers = {{"ground_alt"}}
AddElement(GroundAlt)

local GroundMagVar_pos_y = getLineY(12)

GroundMagVar_Name = CreateElement "ceStringPoly"
GroundMagVar_Name.name = "GroundMagVar_Name"
GroundMagVar_Name.material = "font_kneeboard"
GroundMagVar_Name.init_pos = {item_pos_x, GroundMagVar_pos_y, 0}
GroundMagVar_Name.value = _("MAG VAR : ")
GroundMagVar_Name.alignment = "RightBottom"
GroundMagVar_Name.stringdefs = font_item_defs
GroundMagVar_Name.controllers = {{"on_ground"}}
AddElement(GroundMagVar_Name)

GroundMagVar = CreateElement "ceStringPoly"
GroundMagVar.name = "GroundMagVar"
GroundMagVar.material = "font_kneeboard"
GroundMagVar.init_pos = {item_pos_x, GroundMagVar_pos_y, 0}
GroundMagVar.alignment = "LeftBottom"
GroundMagVar.stringdefs = font_item_defs
GroundMagVar.controllers = {{"ground_magvar"}}
AddElement(GroundMagVar)

local carrierinfo_pos_y = getLineY(13)

CarrierInfo_Name = CreateElement "ceStringPoly"
CarrierInfo_Name.name = "CarrierInfo_Name"
CarrierInfo_Name.material = "font_kneeboard"
CarrierInfo_Name.init_pos = {item_pos_x, carrierinfo_pos_y, 0}
CarrierInfo_Name.value = _("CARRIER : ")
CarrierInfo_Name.alignment = "RightBottom"
CarrierInfo_Name.stringdefs = font_item_defs
CarrierInfo_Name.controllers = {{"on_carrier"}}
AddElement(CarrierInfo_Name)

CarrierInfo_HdgSpd = CreateElement "ceStringPoly"
CarrierInfo_HdgSpd.name = "CarrierInfo_HdgSpd"
CarrierInfo_HdgSpd.material = "font_kneeboard"
CarrierInfo_HdgSpd.init_pos = {item_pos_x, carrierinfo_pos_y, 0}
CarrierInfo_HdgSpd.alignment = "LeftBottom"
CarrierInfo_HdgSpd.stringdefs = font_item_defs
CarrierInfo_HdgSpd.controllers = {{"carrier_hdgspd"}}
AddElement(CarrierInfo_HdgSpd)

local gndcrew_warn_pos_y = getLineY(18)

Name_GndCrewWarn = CreateElement "ceStringPoly"
Name_GndCrewWarn.name = "Name_GndCrewWarn"
Name_GndCrewWarn.material = "font_general_red"
Name_GndCrewWarn.init_pos = {0, gndcrew_warn_pos_y, 0}
Name_GndCrewWarn.value = _("[ONLY NEAR GROUND CREW]")
Name_GndCrewWarn.alignment = "CenterBottom"
Name_GndCrewWarn.stringdefs = font_title_defs
Name_GndCrewWarn.controllers = {{"gnd_crew_warn"}}
AddElement(Name_GndCrewWarn)
