declare_sensor({
		Name = "Mys-M1_SR",
		category = SENSOR_RADAR,
		type = RADAR_SS,
		vehicles_detection = true,
		airborne_radar = false,
		scan_volume = 
		{
			azimuth = {-180, 180},
			elevation = {-10, 10}
		},
		max_measuring_distance = 200000,
		detection_distance = 
		{
			[HEMISPHERE_UPPER] =
			{
				[ASPECT_HEAD_ON] = 200000.0,
				[ASPECT_TAIL_ON] = 200000.0
			},
			[HEMISPHERE_LOWER] =
			{
				[ASPECT_HEAD_ON] = 200000.0,
				[ASPECT_TAIL_ON] = 200000.0
			}
		},
		lock_on_distance_coeff = 1.0,
		velocity_limits = 
		{
			radial_velocity_min = 0,
		},
		scan_period = 10.0,
		RCS = 5.0,
		RBM_detection_distance = 200000.0
	})

declare_sensor({
		Name = "RLS_19J6",
		category = SENSOR_RADAR,
		type = RADAR_AS,
		scan_volume =
		{
			azimuth = {-180.0, 180.0},
			elevation = {-15.0, 45.0}
		},
		max_measuring_distance = 150000.0,
		detection_distance =
		{
			[HEMISPHERE_UPPER] =
			{
				[ASPECT_HEAD_ON] = 150000.0,
				[ASPECT_TAIL_ON] = 150000.0
			},
			[HEMISPHERE_LOWER] =
			{
				[ASPECT_HEAD_ON] = 150000.0,
				[ASPECT_TAIL_ON] = 150000.0
			}
		},
		lock_on_distance_coeff = 0.85,
		velocity_limits =
		{
			radial_velocity_min = 20,
		},
		scan_period = 6.0,
	})

declare_sensor({
	Name = "RPC S-200 TR",
	category = SENSOR_RADAR,
	type = RADAR_AS,
	scan_volume =
	{
		azimuth = {-180.0, 180.0},
		elevation = {0.0, 80.0}
	},
	max_measuring_distance = 400000.0,
	detection_distance =
	{
		[HEMISPHERE_UPPER] =
		{
			[ASPECT_HEAD_ON] = 400000.0,
			[ASPECT_TAIL_ON] = 400000.0
		},
		[HEMISPHERE_LOWER] =
		{
			[ASPECT_HEAD_ON] = 400000.0,
			[ASPECT_TAIL_ON] = 400000.0
		}
	},
	lock_on_distance_coeff = 0.85,
	velocity_limits =
	{
		radial_velocity_min = 10,
	},
	scan_period = 1.0,
})

declare_sensor({
	Name = "NASAMS_Radar_MPQ64F1",
	category = SENSOR_RADAR,
	type = RADAR_AS,
	scan_volume =
	{
		azimuth = {-180.0, 180.0},
		elevation = {0.0, 80.0}
	},
	max_measuring_distance = 80000.0,
	detection_distance =
	{
		[HEMISPHERE_UPPER] =
		{
			[ASPECT_HEAD_ON] = 40000.0,
			[ASPECT_TAIL_ON] = 40000.0
		},
		[HEMISPHERE_LOWER] =
		{
			[ASPECT_HEAD_ON] = 40000.0,
			[ASPECT_TAIL_ON] = 40000.0
		}
	},
	lock_on_distance_coeff = 0.85,
	velocity_limits =
	{
		radial_velocity_min = 10,
	},
	scan_period = 2.0,
})

declare_sensor({
		Name = "FPS-117",
		category = SENSOR_RADAR,
		type = RADAR_AS,
		scan_volume =
		{
			azimuth = {-180.0, 180.0},
			elevation = {-15.0, 80.0}
		},
		max_measuring_distance = 463000.0,
		detection_distance =
		{
			[HEMISPHERE_UPPER] =
			{
				[ASPECT_HEAD_ON] = 463000.0,
				[ASPECT_TAIL_ON] = 463000.0
			},
			[HEMISPHERE_LOWER] =
			{
				[ASPECT_HEAD_ON] = 463000.0,
				[ASPECT_TAIL_ON] = 463000.0
			}
		},
		lock_on_distance_coeff = 0.85,
		scan_period = 1.0,
	})