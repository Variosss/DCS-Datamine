--SENSOR CATEGORY
local SENSOR_OPTICAL = 0
local SENSOR_RADAR = 1
local SENSOR_IRST = 2
local SENSOR_RWR = 3
--RADAR
local RADAR_AS = 0
local RADAR_SS = 1
local RADAR_MULTIROLE = 2
--
local ASPECT_HEAD_ON = 0
local ASPECT_TAIL_ON = 1
--
local HEMISPHERE_UPPER = 0
local HEMISPHERE_LOWER = 1
--IRST
local ENGINE_MODE_FORSAGE = 0
local ENGINE_MODE_MAXIMAL = 1
local ENGINE_MODE_MINIMAL = 2
--OPTIC
local OPTIC_SENSOR_TV = 0
local OPTIC_SENSOR_LLTV = 1
local OPTIC_SENSOR_IR = 2

PS37A = {
	Name = "PS-37A",
	category = SENSOR_RADAR,
	
	
	type = RADAR_MULTIROLE,
	scan_volume =
	{
		azimuth = {-60.0, 60.0},
		elevation = {-60.0, 60.0}
	},
	max_measuring_distance = 120000.0,
	scan_period = 5.0,

	air_search = {          
		centered_scan_volume =
		{
			azimuth_sector = 30.0,
			elevation_sector = 30.0
		},          
		detection_distance =
		{
			[HEMISPHERE_UPPER] =
			{
				[ASPECT_HEAD_ON] = 30000.0,
				[ASPECT_TAIL_ON] = 30000.0
			},
			[HEMISPHERE_LOWER] =
			{
				[ASPECT_HEAD_ON] = 30000.0,
				[ASPECT_TAIL_ON] = 30000.0
			}
		},
		lock_on_distance_coeff = 0.85,
		velocity_limits =
		{
			radial_velocity_min = 100.0 / 3.6,
			relative_radial_velocity_min = 100.0 / 3.6,
		},
	},
	surface_search = {
		vehicles_detection = true,
		RCS = 100,
		RBM_detection_distance = 120000.0,
		GMTI_detection_distance = 120000.0,
		HRM_detection_distance = 120000.0
	}
}

declare_sensor(PS37A)
