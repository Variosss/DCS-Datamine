dofile(LockOn_Options.common_script_path..'Radio.lua')

local gettext = require("i_18n")
_ = gettext.translate

innerNoise			= getInnerNoise(2.5E-6, 6)
frequency_accuracy 	= 1000.0	--Hz
band_width			= 25E3		--Hz (6 dB selectivity)
power_in_FM 		= 25.0		--Wt
power_in_AM 		= 16.0		--Watts

agr = {
	input_signal_deviation		= 50.0, --Db
	output_signal_deviation		= 5.0,  --Db
	input_signal_linear_zone 	= 10.0,  --Db
	regulation_time				= 0.25, --sec
}

goniometer = {isLagElement = true, T1 = 0.3, bias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(1)}}}

GUI = {
	ranges = { 	{min = 100E6, max = 149E6, step = 25E3}, --Hz
				{min = 220E6, max = 400E6, step = 25E3} },
	displayName = _('R-800'),
	AM = true,
	FM = true
}

local r_800_default_path     		 = LockOn_Options.script_path.."R-800"
function Load_R_800_Status()
	local path = LockOn_Options.mission.file_path
	local campaign = LockOn_Options.mission.campaign
	local mission  = LockOn_Options.mission.title
	if campaign ~= "" then    path     = path.."\\"..campaign end
	if mission  ~= "" then    path     = path.."\\"..mission  end
	local fileName =  path .. "\\R_800.lua"
	local f = loadfile(fileName)
	if    f == nil then
	      fileName =   r_800_default_path.."\\R_800.lua"
	      f = loadfile(fileName)
	end
	if	  f 	then
	      f()
	end
end

R800_TRANSCEIVER_FAILURE = 0
R800_ANTENNA_FAILURE = 1
Damage = {{Failure = R800_TRANSCEIVER_FAILURE, Failure_name = "R800_TRANSCEIVER_FAILURE", Failure_editor_name = _("R-800 transceiver failure"), Element = 4, Integrity_Treshold = 0.3}, 
		  {Failure = R800_ANTENNA_FAILURE, Failure_name = "R800_ANTENNA_FAILURE", Failure_editor_name = _("R-800 antenna failure"), Element = 55}}
