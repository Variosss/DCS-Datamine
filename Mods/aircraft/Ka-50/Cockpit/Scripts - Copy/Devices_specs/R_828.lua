dofile(LockOn_Options.common_script_path..'Radio.lua')

local gettext = require("i_18n")
_ = gettext.translate

innerNoise			= getInnerNoise(2.5E-6, 6)
frequency_accuracy 	= 1000.0		--Hz
band_width			= 20000.0		--Hz (6 dB selectivity)
power 				= 15.0			--Watts

agr = {
	input_signal_deviation		= 50.0, --Db
	output_signal_deviation		= 5.0,  --Db
	input_signal_linear_zone 	= 10.0,  --Db
	regulation_time				= 0.25, --sec
}

GUI = {
	displayName = _('R-828'),
	AM = false,
	FM = true
}

ElecConsumerParamsLight = {0.5, true}

max_search_time = 5.0

local r_828_default_path     		 = LockOn_Options.script_path.."R-828"
function Load_R_828_Status()
	local path = LockOn_Options.mission.file_path
	local campaign = LockOn_Options.mission.campaign
	local mission  = LockOn_Options.mission.title
	if campaign ~= "" then    path     = path.."\\"..campaign end
	if mission  ~= "" then    path     = path.."\\"..mission  end
	local fileName =  path .. "\\R_828.lua"
	local f = loadfile(fileName)
	if    f == nil then
	      fileName =   r_828_default_path.."\\R_828.lua"
	      f = loadfile(fileName)
	end

	if f then 
		f()
		assert(presets ~= nil)
		GUI.channels = presets
	end
end

R828_TRANSCEIVER_FAILURE = 0
R828_ANTENNA_FAILURE = 1
Damage = {	{Failure = R828_TRANSCEIVER_FAILURE, Failure_name = "R828_TRANSCEIVER_FAILURE", Failure_editor_name = _("R-828 transceiver failure"), Element = 4, Integrity_Treshold = 0.3}, 
			{Failure = R828_ANTENNA_FAILURE, Failure_name = "R828_ANTENNA_FAILURE", Failure_editor_name = _("R-828 antenna failure"), Element = 58}}
