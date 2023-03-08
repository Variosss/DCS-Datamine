dofile(LockOn_Options.script_path.."config.lua")

local gettext = require("i_18n")
_ = gettext.translate


device_timer_dt	= 0.02

page_names = {}

function set_page_name (mode,name)
	
	local L1 = mode[1] or 0

	if page_names[L1] == nil then
	   page_names[L1] =  {}
	end
	
	page_names[L1] = name
	
end

-- master modes
PILOT_SIGHT_OFF			= 0
PILOT_SIGHT_ON			= 1 

set_page_name({PILOT_SIGHT_OFF},"OFF")
set_page_name({PILOT_SIGHT_ON},"ON")

--failures
FLEX_S_NO_POWER_SUPPLY  	= 0
FLEX_S_MAIN_LAMP_DEFECTIVE  = 1
FLEX_S_BKP_LAMP_DEFECTIVE   = 2
FLEX_S_NO_GUN_SIGN  		= 3
--[[
Damage = {	
	{Failure = FLEX_S_MAIN_LAMP_DEFECTIVE, Failure_name = "FLEX_S_MAIN_LAMP_DEFECTIVE", Failure_editor_name = _("Flex. Sight. Main lamp defective"),  Element = 0, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
}--]]

ElecConsumerParamsSightBulb = {0.7, false}

ext_draw_args = {
	height =	{ 474, limits = {0, 1.0} }
}

need_to_be_closed = true -- close lua state after initialization 
