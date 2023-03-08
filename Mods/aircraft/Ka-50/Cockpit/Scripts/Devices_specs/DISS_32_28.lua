-- DISS-32-28 Doppler Navigation System
local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.0625 -- seconds
device_pos = {-4.61, -0.34, 0.0}

time_to_power_up = 150.0 -- seconds
time_to_wave_search = 5.0 -- seconds

l0 = 0.0175 -- wave length (meters)
min_doppler_frequency = 3.0
max_doppler_frequency = 10000.0 --4000.0

beam_side_angle = math.rad(30.0); -- radians
beam_elev = math.rad(30.0); -- radians
		
min_beam_travel = 2.0 -- meters
max_beam_travel = 4170.0 -- meters

wave_angleK = 9.25 -- dimentionless

max_drift_angle = math.rad(30.0) -- radians
max_pitch_bank = math.rad(10.0) -- radians

DNS_FAILURE = 0
Damage = {{Failure = DNS_FAILURE, Failure_name = "DNS_FAILURE", Failure_editor_name = _("DNS failure"), Element = 55},
		  {Failure = DNS_FAILURE, Failure_name = "DNS_FAILURE", Failure_editor_name = _("DNS failure"), Element = 58}}
