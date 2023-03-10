MFCD_NAME	= "Right MFCD"

dofile(LockOn_Options.script_path.."MFCD/device/MFCD.lua")

local gettext = require("i_18n")
_ = gettext.translate

RunwayStartInitMode = {master = 10,level_2 = 1,level_3 = 0,level_4 = 0}
AirStartInitMode	= {master = 6,level_2 = 0,level_3 = 0,level_4 = 0}

-- default layout
DPP_OSB_labels = 
{
	"",-- OSB_01
	"",-- OSB_02
	"",-- OSB_03
	"",-- OSB_04
	"",-- OSB_05
	"COMM",-- OSB_06
	"STAT",-- OSB_07
	"LOAD",-- OSB_08
	"MAV",-- OSB_09
	"CLR",-- OSB_10
	"DCLT",-- OSB_11
	-- magic (programmable) buttons
	"MSG", -- OSB_12
	"CDU", -- OSB_13
	"STAT", -- OSB_14
	"TGP", -- OSB_15
	--
	"CDU",-- OSB_16
	"MSG",-- OSB_17
	"DSMS",-- OSB_18
	"TGP",-- OSB_19
	"TAD",-- OSB_20
}


MFCD_FAILURE = 0
Damage = {	{Failure = MFCD_FAILURE, Failure_name = "RIGHT_MFCD_FAILURE", Failure_editor_name = _("Right MFCD"),  Element = 5, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}

-- programmed layout
local buttons = settings["osb_buttons"]
if buttons then
	DPP_OSB_labels[12] = buttons[11]["label"]
	DPP_OSB_labels[13] = buttons[12]["label"]
	DPP_OSB_labels[14] = buttons[13]["label"]
	DPP_OSB_labels[15] = buttons[14]["label"]
end

 