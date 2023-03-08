BACKGROUND_TYPE_AIR = 0 --look-up or look-down if self and target above the fog and overcast
BACKGROUND_TYPE_LAND = 1
BACKGROUND_TYPE_FOREST = 2
BACKGROUND_TYPE_ROAD = 3
BACKGROUND_TYPE_RUNWAY = 4
BACKGROUND_TYPE_WATER = 5

WEAPON_TYPE_MG = 0
WEAPON_TYPE_SMALL_CALIBER_CANNON = 1
WEAPON_TYPE_MEDIUM_CALIBER_CANNON = 2
WEAPON_TYPE_LARGE_CALIBER_CANNON = 3
WEAPON_TYPE_ROCKET = 4
WEAPON_TYPE_HEAVY_ROCKET = 5
WEAPON_TYPE_MISSILE = 6
WEAPON_TYPE_HEAVY_MISSILE = 7

visual_detection = {
    terrain_LOS_test = true,
    Earth_curvature_LOS_test = true,
    objects_LOS_test = true,
    trees_LOS_test = false,
    trees_LOS_test_T4 = true,
    
    sky_bodies_illumination_factor = true,
    other_light_sources_illumination_factor = true, --no effect if sun_illumination factor disabled
    darkness_threshold = 0.05, --no effect if sun_illumination factor disabled
	recognition_distance_ratio_threshold = 0.25, --target will be recognized if ratio between the distance and the maximal detection distance is less than this value
    overcast_test = true,
    fog_test = true,
    precipitations_test = false, --disabled by default, this makes A.I. units and player to have same detection capabilities
    
    max_detection_distance = 50000.0, --m, absolute limit
	average_det_time_max_dist_0 = 10.0, --s, average detection time of target ahead at the maximal distance
	average_det_time_max_dist_180 = 180.0, --s, average detection time of target behind at the maximal distance
	average_det_time_max_dist_180_for_ground_units = 60.0, --s, average detection time of target behind at the maximal distance (for ground units only)
    --visibility_km = exp((h1_km + h2_km) * k + b)
	atmosphere_transparency_factor = {
		max_visibility_at_ground_level = 10000.0, --detector and target both are on the surface
		max_visibility_at = {
			detector_altitude = 4000, --m
			target_altitude = 0.0, --m
			max_visibility = 42000 --m
		},
		fog_transparency_threshold = 0.03 -- with respect to player's ability to detect the target
    },
    --Detection distance by target type
    --Conditions: skill = excelent, LOS present, no fog, illumination = 1.0, background = air, non-moving target, no nearly located targets, no smokes, target is not shooting, no dust and inversion tail, no lights   
    in_reflected_light = {
        fixed_size_target_detection = {
            target_size = 6.0, --m
            detection_distance = 5500.0, --m
        },
        detection_distance_by_class = { --m
            ["Fighters"] = 7500.0,
            ["Multirole fighters"] = 7500.0,
            ["Interceptors"] = 7500.0,
            ["Battleplanes"] = 7000.0,
            ["Bombers"] = 9500.0,
            ["Strategic bombers"] = 10500.0,
            ["UAVs"]  = 900.0,
            ["Helicopters"] = 6500.0,
            ["Ground vehicles"] = {3300.0, 5500.0}, --for ground and airborne detectors
            ["Infantry"] = {800.0, 800.0}, --for ground and airborne detectors
            ["Aircraft Carriers"] = 24000.0,	-- https://jira.eagle.ru/browse/DCSCORE-5960 , Andrey request increase ships visibility
            ["Cruisers"]  = 18750.0,
            ["Destroyers"] = 15000.0,
            ["Frigates"] = 13500.0,
            ["Unarmed ships"]  = 15000.0,
            ["Airfields"] = 25000.0,
            ["Fortifications"] = 4000,
			["Point"] = 25000.0,
        }
    },
    as_light_source = {
        light_source_detection_distance = 10000.0 --for light power = 1.0f
    },
    as_shooter = {
        weapon_fire_detection_distance = { --m
            [WEAPON_TYPE_MG] = 5000.0,
            [WEAPON_TYPE_SMALL_CALIBER_CANNON] = 5500.0,
            [WEAPON_TYPE_MEDIUM_CALIBER_CANNON] = 10000.0,--6000.0,
            [WEAPON_TYPE_LARGE_CALIBER_CANNON] = 15000.0,--7000.0,
            [WEAPON_TYPE_ROCKET] = 5000.0,
            [WEAPON_TYPE_HEAVY_ROCKET] = 7500.0,
            [WEAPON_TYPE_MISSILE] = 5000.0,
            [WEAPON_TYPE_HEAVY_MISSILE] = 7500.0
        }
    },
    motion_factor = {
        angular_speed_to_angular_size_ratio_max = 10.0,
        detection_distance_factor_max = 1.5,
    },
    background_factor = true,
    background_factors = {  --reduces detection distance of airborne targets ONLY!
        [BACKGROUND_TYPE_AIR] = 1.0,
        [BACKGROUND_TYPE_LAND] = 0.6,
        [BACKGROUND_TYPE_FOREST] = 0.3,
        [BACKGROUND_TYPE_ROAD] = 0.8,
        [BACKGROUND_TYPE_RUNWAY] = 0.8,
        [BACKGROUND_TYPE_WATER] = 0.75
    },
    other_detected_target_location_factor = false,
    other_target_location_factor = false,   
    --note: motion_factor,  background_factor and skill_factor are multiplicative detection distance factors
}

detection_by_optic_sensor = {   --for optic sensors only
    scan_time_for_double_scan_to_view_angular_square_ratio = 0.1, --it is a average time of target detection if FOV angular square is a half of scan angular square
	recognition_distance_ratio_threshold = 0.5, --target will be recognized if ratio between the distance and the maximal detection distance is less than this value
    IR_view_trough_fog_and_overcast = false, --fog and overcast will not affect IR sensors capabilities
    light_detection_magnification_factor = false    
}

detection_by_radar = {
    air_search = {
        radial_velocity_limit = true,
        relative_radial_velocity_limit = true,
        background_factor = true,
        aspect_factor = true,
        tail_on_aspect_terrain_objects_mask_factor = true
    },
    surface_search = {
        vehicles_detecion_limitation = true,
        resolution_with_terrain_objects = true,
        masking_by_terrain_objects = true
    }
}