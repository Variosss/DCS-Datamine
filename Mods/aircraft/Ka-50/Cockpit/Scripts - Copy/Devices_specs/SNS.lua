--GPS modeling

psedoRangeErrorProcessTx = 25.0
SNRProcess = 20.0

--SNS receiver parameters
SAT_SYS_NONE = 0
SAT_SYS_GLONASS = 1
SAT_SYS_GPS = 2
SAT_SYS_BOTH = 3

system_mode_available = {}
system_mode_available[SAT_SYS_GPS] = true
system_mode_available[SAT_SYS_BOTH] = true
system_mode_available[SAT_SYS_GLONASS] = false

channel_quantity = 12
use_L2 = false
use_carrier = true
position_latency = 0.07
position_update_dt = 0.5 --PSR measuring rate
status_update_dt = 2.0 --satellites re-acquisition and DOPS calculation rate

antenna_pos = {-3.55, 0.92, 0.0}
min_elevation = -10.0
terrainLOS = true

Starting_Time = {}
Starting_Time["hot_start_time"] = 90
Starting_Time["warm_start_time"] = 120
Starting_Time["cold_start_time"] = 180

Satellite_re_aquisition_time = {}
Satellite_re_aquisition_time[10] = 3
Satellite_re_aquisition_time[60] = 5

--coords extrapolation
coords_extrapolation_enable = true
coords_extrapolation_dt = 0.05 --coords extrapolation rate

Kalman_filter_enable = true
