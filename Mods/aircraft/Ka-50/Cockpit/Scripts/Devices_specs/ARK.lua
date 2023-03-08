local fileName =  get_terrain_related_data("beacons") or get_terrain_related_data("beaconsFile")
if 	  fileName then 
	local f = loadfile(fileName)
	if    f     then
		  f()
	end
end


local gettext = require("i_18n")
_ = gettext.translate

dofile(LockOn_Options.common_script_path.."Transliterate.lua")

terrainAirdromes = get_terrain_related_data("Airdromes") or {};

theatre          = get_terrain_related_data("name")

function localizedAirdromeName(adr_data)
	local nm = adr_data.names.en 
	if nm ~= nil then
		return gettext.dtranslate("dcs",nm)
	end
	return nil
end

function localizeBeaconName(str)
	if str ~= nil then
		return gettext.dtranslate("dcs", str)
	end
	return nil
end

dofile(LockOn_Options.common_script_path..'Radio.lua')

device_timer_dt = 0.2

innerNoise			= getInnerNoise(7E-6, 6)
frequency_accuracy 	= 100.0			--Hz
band_width			= 800.0			--Hz

--automatic gain regulator
agr = {
	input_signal_deviation		= 37.0, --Db
	output_signal_deviation		= 3.0,  --Db
	input_signal_linear_zone 	= 5.0,  --Db
	regulation_time				= 0.20, --sec
}

goniometer = {isLagElement = true, T1 = 0.3, bias = {{valmin = math.rad(0), valmax = math.rad(360), bias = math.rad(1)}}}

--ADF paramenters
accuracy = 2.0
frequency_step = 100
band_width_tlg = 100.0
band_width_tlf = 3000.0
starting_time = 90.0
test_bearing_deviation = 45.0
frequency_changing_time = 2.0
min_elev_angle = -90.0
max_elev_angle = 10.0

mountainEffect = true
shorelineEffect = false --not implemented
nightEffect = true

--ADF constants
ADF_ADF = 0
ADF_ANTENNA = 1

ADF_RECEIVER_TLF = 0
ADF_RECEIVER_TLG = 1

ADF_HOMER_SELECTION_FAR_HOMER = 0
ADF_HOMER_SELECTION_AUTO = 1
ADF_HOMER_SELECTION_NEAR_HOMER	= 2

ADF_HOMER_FAR = 1
ADF_HOMER_NEAR = 2

--ADF channel data make functions

function NDB(homer)
	--NDB (non-airdrome beacons)
	if not homer then 
	   return nil 
	end
	return {
		name      = homer.display_name or homer.beaconId,
		callsign  = homer.callsign,
		frequency = homer.frequency or getTACANFrequency(homer.channel,'X')
	}
end

--ADF saved state

function Load_ADF_State()
	local  f1 = load_mission_file("Scripts/Aircrafts/ka-50/Cockpit/ARK/ARK.lua")
	if not f1 then 
	   f1 = copy_to_mission_and_get_buffer(LockOn_Options.script_path.."ARK/ARK.lua")
	end
	if  f1 then
		setfenv(f1,getfenv(NDB))
	    f1()
	end
end

RECEIVER_FAILURE = 0
DIRECTIONAL_ANTENNA_FAILURE = 1
NON_DIRECTIONAL_ANTENNA_FAILURE = 2
Damage = {	{Failure = RECEIVER_FAILURE, Failure_name = "ARK_RECEIVER_FAILURE", Failure_editor_name = _("NDB receiver failure"), Element = 4, Integrity_Treshold = 0.3}, 
			{Failure = NON_DIRECTIONAL_ANTENNA_FAILURE, Failure_name = "ARK_NONDIR_ANTENNA_FAILURE", Failure_editor_name = _("ARK nondir antenna failure"), Element = 5, Integrity_Treshold = 0.3}, 
			{Failure = DIRECTIONAL_ANTENNA_FAILURE, Failure_name = "ARK_DIR_ANTENNA_FAILURE", Failure_editor_name = _("ARK dir antenna failure"), Element = 56}, 
			{Failure = DIRECTIONAL_ANTENNA_FAILURE, Failure_name = "ARK_DIR_ANTENNA_FAILURE", Failure_editor_name = _("ARK dir antenna failure"), Element = 57}}
Load_ADF_State()
