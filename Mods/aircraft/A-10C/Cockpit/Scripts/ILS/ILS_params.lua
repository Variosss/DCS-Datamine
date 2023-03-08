dofile(LockOn_Options.common_script_path..'Radio.lua')

local gettext = require("i_18n")
_ = gettext.translate

-- —опоставление частот Localizer & Glideslope
-- The ILS operates between 108.1 and 111.95 MHz and has 40 possible channels selected from the ILS control panel
--[[
local freq_pairs = {
	[108.10] = 334.70,
	[108.15] = 334.55,
	[108.30] = 334.10,
	[108.35] = 333.95,
	[108.50] = 329.90,
	[108.55] = 329.75,
	[108.70] = 330.50,
	[108.75] = 330.35,
	[108.90] = 329.30,
	[108.95] = 329.15,
	[109.10] = 331.40,
	[109.15] = 331.25,
	[109.30] = 332.00,
	[109.35] = 331.85,
	[109.50] = 332.60,
	[109.55] = 332.45,
	[109.70] = 333.20,
	[109.75] = 333.05,
	[109.90] = 333.80,
	[109.95] = 333.65,
	[110.10] = 334.40,
	[110.15] = 334.25,
	[110.30] = 335.00,
	[110.35] = 334.85,
	[110.50] = 329.60,
	[110.55] = 329.45,
	[110.70] = 330.20,
	[110.75] = 330.05,
	[110.90] = 330.80,
	[110.95] = 330.65,
	[111.10] = 331.70,
	[111.15] = 331.55,
	[111.30] = 332.30,
	[111.35] = 332.15,
	[111.50] = 332.90,
	[111.55] = 332.75,
	[111.70] = 333.50,
	[111.75] = 333.35,
	[111.90] = 331.10,
	[111.95] = 330.95
}

function get_ILS_glideslope_frequency(localizerFrequency)
	local freq = localizerFrequency / 1000000
	local gs_freq = freq_pairs[freq] or 0;
	return gs_freq * 1000000;
end
--]]

-- a note for future implementation:
-- VOR min field strength - 90 uV/m (39dB(uV/m))

-- Per ANV-141 specification:
-- VOR/LOC Ц 3 uV emf for flag out of view; VOR/LOC Ц Aural 3 uV for 6dB ((S + N)/N)
innerNoise = getInnerNoise(3.0E-6, 6) -- ((S + N)/N)
-- Minimun localizer field strength is 32 dB(uV/m) (40 uV/m) per ICAO specification.
-- Minimum reception zone per ICAO is - 25 nm for narrow area, and 17 nm for wide area.
-- Currently localizer can be received around 75 nm in narrow area, and around 25 nm in wide area.
-- NOTE: V/m may be incorrect - should be V
localizerMinSignal = 1.0E-4 -- V/m
glideslopeMinSignal = 1.5E-3 -- V/m
markerMinSignal = 1.1E-3; -- V/m

ILS_FAILURE_TOTAL			= 0
ILS_FAILURE_ANT_LOCALIZER	= 1
ILS_FAILURE_ANT_GLIDESLOPE	= 2
ILS_FAILURE_ANT_MARKER		= 3
	
Damage = {	{Failure = ILS_FAILURE_TOTAL, Failure_name = "ILS_FAILURE_TOTAL", Failure_editor_name = _("ILS total failure"),  Element = 7, Integrity_Treshold = 0.25, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = ILS_FAILURE_ANT_LOCALIZER, Failure_name = "ILS_FAILURE_ANT_LOCALIZER", Failure_editor_name = _("ILS localizer antenna"),  Element = 36, Integrity_Treshold = 0.1, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = ILS_FAILURE_ANT_GLIDESLOPE, Failure_name = "ILS_FAILURE_ANT_GLIDESLOPE", Failure_editor_name = _("ILS glideslope antenna"),  Element = 36, Integrity_Treshold = 0.2, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300},
		{Failure = ILS_FAILURE_ANT_MARKER, Failure_name = "ILS_FAILURE_ANT_MARKER", Failure_editor_name = _("ILS marker antenna"),  Element = 7, Integrity_Treshold = 0.75, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}}
