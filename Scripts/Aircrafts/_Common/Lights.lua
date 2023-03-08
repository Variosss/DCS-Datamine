WOLALIGHT_STROBES          = 1
WOLALIGHT_SPOTS            = 2
WOLALIGHT_LANDING_LIGHTS   = 2
WOLALIGHT_NAVLIGHTS        = 3
WOLALIGHT_FORMATION_LIGHTS = 4
WOLALIGHT_TIPS_LIGHTS      = 5
WOLALIGHT_TAXI_LIGHTS      = 6
WOLALIGHT_BEACONS          = 7
WOLALIGHT_CABIN_BOARDING   = 8
WOLALIGHT_CABIN_NIGHT      = 9
WOLALIGHT_REFUEL_LIGHTS    = 10
WOLALIGHT_PROJECTORS       = 11
WOLALIGHT_AUX_LIGHTS       = 12
WOLALIGHT_IR_FORMATION     = 13



SpotLigtPositions = { -- 1ÿ ôàðà âñåãäà ïîñàäî÷íàÿ
-- 1 spot
[ FA_18]		={{3.279, -0.599,  0.0}},
[ AV_8B]		={{4.418, -1.037,  0.405}},
[RQ_1A_Predator]={{2	   , -1.037, 0}},

-- 2 spots
[ MiG_25]		={{ 3.304, -0.768, -0.864} ,{3.304, -0.768, 0.864}},
[ MiG_25P]		={{ 3.304, -0.768, -0.864} ,{3.304, -0.768, 0.864}},
[ KC_10]		={{19.073, -1.475, 2.117	} ,{19.073,-1.475, -2.117	}},
[ KA_52]		={{ 2.063, -1.521, -0.65	} ,{1.272, -1.521, -0.311}},

-- 3 spots
[ Su_30]		={{5.501, -0.675, -0.002} ,{	5.439, -0.318, 0.121		} ,{ 5.4, -0.234, -0.154}},
[ F_2]			={{4.02,  -1.291,  0.0} ,{ 		0.409, -0.708, 0.864} ,{ 0.409, -0.708, -0.864}},
[ TORNADO_IDS]	={{4.02,  -1.291,  0.0} ,{ 		0.409, -0.708, 0.864} ,{ 0.409, -0.708, -0.864}},
[ KC_135]		={{18.092, -1.93, -1.015} ,{18.092,-1.93, 1.015	},{10,-2, 0	}},
};



nav_lights_default = {
	typename = "collection",
	lights = {
		{
			typename  = "omnilight",
			connector = "BANO_0",
			color     = {1.0, 1.0, 1.0, 0.333},
			position  = {-6.079, 2.896, 0.000},
			argument  = 192,
            movable   = false,
		},
		{
			typename  = "omnilight",
			connector = "BANO_1",
			color     = {0.99, 0.11, 0.3, 0.333},
			position  = {-1.516, -0.026, -7.249},
			argument  = 190,
            movable   = false,
		},
		{
			typename  = "omnilight",
			connector = "BANO_2",
			color     = {0.0, 0.894, 0.6, 0.333},
			position  = {-1.516, -0.026,  7.249},
			argument  = 191,
            movable   = false,
		},
	}
}
nav_lights_3arg = {
	typename = "collection",
	lights = {
		{
			typename = "argumentlight",
			argument = 192,
		},
		{
			typename = "argumentlight",
			argument = 190,
		},
		{
			typename = "argumentlight",
			argument = 191,
		},
	}
}
nav_lights_lockon = {
    typename = "argumentlight",
    argument = 49,
}

formation_lights_default = {
	typename = "collection",
	lights = {
		{typename  = "argumentlight" ,argument  = 200, movable = false, },--formation_lights_tail_1 = 200;
		{typename  = "argumentlight" ,argument  = 201, movable = false, },--formation_lights_tail_2 = 201;
		{typename  = "argumentlight" ,argument  = 202, movable = false, },--formation_lights_left   = 202;
		{typename  = "argumentlight" ,argument  = 203, movable = false, },--formation_lights_right  = 203;
		{typename  = "argumentlight" ,argument  = 88, movable = false, },-- old aircraft arg 
	}
}	

tips_lights_default = {
	typename = "collection",
	lights = {
		{typename  = "argumentlight" ,argument  = 47,}}--tips lights 
}

strobe_lights_default = {
	typename = "collection",
	lights   = {{typename  = "strobelight",connector =  "RED_BEACON"  ,argument  =  193,color = {0.8, 0.0, 0.0, 0.4}},
				{typename  = "strobelight",connector =  "RED_BEACON_2",argument  =  194,color = {0.8, 0.0, 0.0, 0.4}}}
}

uv_lights_default = {
    typename = "collection",
    lights = {{typename = "argumentlight", argument = 69,},},
}

lamp_prototypes = {
    LFS_P_27_200 = { -- landing lamp / combo, 200 Wt, 200 kcd, 145mm, LFS-PR27-200+130 / ËÔÑ-ÏÐ27-200+130
        color = {255, 201, 125, 0.012 * math.sqrt(200) + 0.024}, range = 0.012 * 200000, angle_max = math.rad(10.0), angle_min = math.rad(10.0 - 4.0), angle_change_rate = math.rad(10.0 * 0.25),
        power_up_t = 0.60,
    },
    LFS_P_27_450 = { -- landing lamp / combo, 450 Wt, 260 kcd, 145mm, LFS-PR27-450+250 / ËÔÑ-ÏÐ27-450+250
        color = {255, 201, 125, 0.012 * math.sqrt(450) + 0.024}, range = 0.012 * 260000, angle_max = math.rad(11.0), angle_min = math.rad(11.0 - 4.0), angle_change_rate = math.rad(11.0 * 0.25),
        power_up_t = 1.00,
    },
    LFS_P_27_600 = { -- landing lamp / combo, 600 Wt, 400 kcd, 205mm, LFS-PR27-600+180 / ËÔÑ-ÏÐ27-600+180
        color = {255, 201, 125, 0.012 * math.sqrt(600) + 0.024}, range = 0.012 * 400000, angle_max = math.rad(9.0), angle_min = math.rad(9.0 - 4.0), angle_change_rate = math.rad(9.0 * 0.25),
        power_up_t = 1.75,
    },
    LFS_P_27_1000 = { -- landing lamp / combo, 1000 Wt, 540 kcd, 205mm, LFS-PR27-1000+450 / ËÔÑ-ÏÐ27-1000+450
        color = {255, 201, 125, 0.012 * math.sqrt(1000) + 0.024}, range = 0.012 * 540000, angle_max = math.rad(12.0), angle_min = math.rad(12.0 - 4.0), angle_change_rate = math.rad(12.0 * 0.25),
        power_up_t = 3.22,
    },



    LFS_R_27_130 = { -- taxi lamp / combo, 130 Wt, 16 kcd, 145mm, LFS-PR27-200+130 / ËÔÑ-ÏÐ27-200+130
        color = {255, 201, 125, 0.012 * math.sqrt(130) + 0.024}, range = 0.012 * 16000, angle_max = math.rad(27.0), angle_min = math.rad(27.0 * 0.8), angle_change_rate = math.rad(-27.0 * 0.25),
        power_up_t = 0.75,
    },
    LFS_R_27_180 = { -- taxi lamp / combo, 180 Wt, 25 kcd, 205mm, LFS-PR27-600+180 / ËÔÑ-ÏÐ27-600+180
        color = {255, 201, 125, 0.012 * math.sqrt(180) + 0.024}, range = 0.012 * 25000, angle_max = math.rad(27.0), angle_min = math.rad(27.0 * 0.8), angle_change_rate = math.rad(-27.0 * 0.25),
        power_up_t = 0.90,
    },
    LFS_R_27_250 = { -- taxi lamp / combo, 250 Wt, 51 kcd, 145mm, LFS-PR27-450+250 / ËÔÑ-ÏÐ27-450+250
        color = {255, 201, 125, 0.012 * math.sqrt(250) + 0.024}, range = 0.012 * 51000, angle_max = math.rad(44.0), angle_min = math.rad(44.0 * 0.8), angle_change_rate = math.rad(-44.0 * 0.25),
        power_up_t = 1.55,
    },
    LFS_R_27_450 = { -- taxi lamp / combo, 450 Wt, 80 kcd, 205mm, LFS-PR27-1000+450 / ËÔÑ-ÏÐ27-1000+450
        color = {255, 201, 125, 0.012 * math.sqrt(450) + 0.024}, range = 0.012 * 80000, angle_max = math.rad(44.0), angle_min = math.rad(44.0 * 0.8), angle_change_rate = math.rad(-44.0 * 0.25),
        power_up_t = 2.42,
    },



    LFS_Z_27_250 = { -- refueling lamp, 250 Wt, 70 kcd, 145mm, LFS-Z27-250 / ËÔÑ-Ç27-250
        color = {255, 201, 125, 0.012 * math.sqrt(250) + 0.024}, range = 0.012 * 70000, angle_max = math.rad(44.0), angle_min = math.rad(44.0 * 0.8),
        power_up_t = 0.75,
    },
    FR_100 = { -- aux / taxi lamp, 70 Wt, 5 kcd, FR-100 / ÔÐ-100
        color = {255, 201, 125, 0.012 * math.sqrt(75) + 0.024}, range = 0.012 * 5500, angle_max = math.rad(28.0),
    },
    FPK_250 = { -- wing edge and nacelle illumination lamp, 250 Wt, 51 kcd, 128mm, FPK-250 / ÔÏÊ-100
        color = {255, 201, 125, 0.012 * math.sqrt(250) + 0.024}, range = 0.012 * 51000, angle_max = math.rad(44.0), angle_min = math.rad(12.0),
        power_up_t = 1.55,
    },
    FPP_7 = { -- search / landing lamp, 480 Wt, 300 kcd, 160mm, FPP-7M / ÔÏÏ-7Ì
        color = {255, 201, 125, 0.012 * math.sqrt(480) + 0.024}, range = 0.012 * 300000, angle_max = math.rad(12.0 + 1.0), angle_min = math.rad(12.0 - 1.0), angle_change_rate = math.rad(12.0 * 0.5),
        power_up_t = 1.12, cool_down_t = 1.12,
    },
    FPP_7_halo = { -- search / landing lamp, 480 Wt, 30 kcd, 160mm, FPP-7M / ÔÏÏ-7Ì
        color = {255, 201, 125, 0.012 * math.sqrt(480/4) + 0.024}, range = 0.012 * 30000, angle_max = math.rad(48.0), angle_min = math.rad(0.0), angle_change_rate = math.rad(48.0 * 0.25),
        power_up_t = 1.12, cool_down_t = 1.12,
    },



    SMI_2KM = { -- strobe lamp, red, SMI-2KM / ÑÌÈ-2ÊÌ
        color = {1.0, 0.0, 0.0, 0.012 * math.sqrt(1000)}, range = 48.0, angle_max = math.rad(180.0), angle_min = math.rad(180.0),
        controller = "Strobe", period = 1.33333,
    },
    MPS_1 = { -- strobe lamp, moon white, MPS-1 / ÌÏÑ-1
        color = {0.92, 0.92, 1.0, 0.012 * math.sqrt(300)}, range = 48.0, angle_max = math.rad(180.0), angle_min = math.rad(30.0),
        controller = "Strobe", period = 1.0,
    },
    MSL_3_2 = { -- beacon assy, 2x, red, MSL-3-2s / ÌÑË-3-2ñ
        --connector = "RED_BEACON",
        color = {1.0, 0.0, 0.0, 3.0 * 0.012 * math.sqrt(28)}, range = 40.0, angle_max = math.rad(45.0), angle_min = math.rad(35.0),
        cups = 2, angular_velocity = math.rad(360),
    },
    MSL_4 = { -- beacon assy, 1x, white, MSL-4 / ÌÑË-4
        --connector = "RED_BEACON",
        color = {1.0, 1.0, 1.0, 3.0 * 0.012 * math.sqrt(162)}, range = 64.0, angle_max = math.rad(75.0), angle_min = math.rad(0.0),
        cups = 1, angular_velocity = math.rad(390),
    },
    MSL_4K = { -- beacon assy, 1x, red, MSL-4K / ÌÑË-4Ê
        --connector = "RED_BEACON",
        color = {1.0, 0.1, 0.1, 3.0 * 0.012 * math.sqrt(40)}, range = 40.0, angle_max = math.rad(75.0), angle_min = math.rad(0.0),
        cups = 1, angular_velocity = math.rad(390),
    },



    HS_2A = { -- tail lamp, 44 Wt, HS-2A / ÕÑ-2À
        color = {1.0, 1.0, 1.0, 0.12}, range = 18.0, angle_max = math.rad(180.0),
    },
    ANO_3_Bl = { -- position lamp, 44 Wt, white, ANO 3-Bl / ÀÍÎ 3-Áë
        color = {1.0, 1.0, 1.0, 0.155}, range = 30.0, angle_max = math.rad(180.0),
    },
    ANO_3_Kr = { -- position lamp, 44 Wt, red, ANO 3-Kr / ÀÍÎ 3-Êð
        color = {1.0, 0.35, 0.15, 0.12}, range = 22.2, angle_max = math.rad(180.0),
    },
    ANO_3_Zl = { -- position lamp, 44 Wt, green, ANO 3-Zl / ÀÍÎ 3-Çë
        color = {0.0, 0.894, 0.6, 0.12}, range = 22.2, angle_max = math.rad(180.0),
    },
    ANO_3_Gl = { -- position lamp, 44 Wt, yellow, ANO 3-Zhl / ÀÍÎ 3-Æë
        color = {1.0, 1.0, 0.2, 0.12}, range = 22.2, angle_max = math.rad(180.0),
    },
    BANO_7M_green = { -- position lamp, 92 Wt, green, BANO-7M / ÂÀÍÎ-7Ì
        color = {0.0, 0.894, 0.6, 0.15}, range = 40.0, angle_max = math.rad(150.0), angle_min = math.rad(90.0),
    },
    BANO_7M_red = { -- position lamp, 92 Wt, red, BANO-7M / ÂÀÍÎ-7Ì
        color = {1.0, 0.35, 0.15, 0.15}, range = 40.0, angle_max = math.rad(150.0), angle_min = math.rad(90.0),
    },
    BANO_8M_green = { -- position lamp, 160 Wt, green, BANO-8M / ÂÀÍÎ-8Ì
        color = {0.0, 0.8, 0.6, 0.18}, range = 75.0, angle_max = math.rad(180.0),
    },
    BANO_8M_red = { -- position lamp, 160 Wt, red, BANO-8M / ÂÀÍÎ-8Ì
        color = {1.0, 0.3, 0.1, 0.18}, range = 75.0, angle_max = math.rad(180.0),
    },
}

function spot_lights_default ( A_Name )
	local spot_pos_data = SpotLigtPositions[A_Name]
	if spot_pos_data == nil then
	   return {}
	end
	local spot_args_default_planes 	   = {209,208,208}
	local spot_args_default_helicopters  = {46 ,45 ,45};	
	local spot_lights_default_connectors = {"MAIN_SPOT_PTR","RESERV_SPOT_PTR","FARA_3"}
	local ret_val = {}
	ret_val.typename = "collection"
	ret_val.lights   = {}
	for i,pos in ipairs(spot_pos_data) do
		ret_val.lights[i] = { 
			typename  = "spotlight",
			position  = pos,
			connector = spot_lights_default_connectors[i],
			argument  = spot_args_default_planes[i],
            color = {255, 255, 200, 0.333},
		}
		if A_Name > LastPlaneType then
		   ret_val.lights[i].argument = spot_args_default_helicopters[i]
		end
	end
	return ret_val
end

function spot_lights_lockon ( A_Name )
	local spot_pos_data = SpotLigtPositions[A_Name]
	if spot_pos_data == nil then
	    return nil
	end
	local spot_args_default_planes = {51, -1, -1}
	local spot_args_default_helicopters  = {46 ,45 ,45};
	local spot_lights_default_connectors = {"MAIN_SPOT_PTR", "RESERV_SPOT_PTR", "FARA_3"}
	local ret_val = {}
	ret_val.typename = "collection"
	ret_val.lights   = {}
	for i,pos in ipairs(spot_pos_data) do
		ret_val.lights[i] = { 
			typename  = "spotlight",
			position  = pos,
			connector = spot_lights_default_connectors[i],
			argument  = spot_args_default_planes[i],
		}
		if A_Name > LastPlaneType then
		    ret_val.lights[i].argument = spot_args_default_helicopters[i]
		end
	end
	return ret_val
end

function default_lights_plane ( A_Name )
	return {
		typename = "collection",
		lights = {
	        [WOLALIGHT_SPOTS] 			 = spot_lights_default(A_Name),
	        [WOLALIGHT_NAVLIGHTS] 		 = nav_lights_default,--must be collection
	        --[WOLALIGHT_FORMATION_LIGHTS] = formation_lights_default,--must be collection
	        [WOLALIGHT_TAXI_LIGHTS] 	 = spot_lights_default(A_Name),
		}
	}
end

function default_lights_helicopter ( A_Name )
	return {
		typename = "collection",
		lights = {
	        [WOLALIGHT_BEACONS]   		 = strobe_lights_default,--must be collection
	        [WOLALIGHT_SPOTS] 			 = spot_lights_default(A_Name),
	        [WOLALIGHT_NAVLIGHTS] 		 = nav_lights_default,--must be collection
	        [WOLALIGHT_FORMATION_LIGHTS] = formation_lights_default,--must be collection
	        [WOLALIGHT_TIPS_LIGHTS]		 = tips_lights_default,
		}
	}
end



lights_prototypes = {}



-- Planes ---------------------------------------------------------------------------------
-- A-20
lights_prototypes[A_50] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_3arg,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {17.654, -1.878, -0.864}, dir_correction = {elevation = math.rad(4.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_1000,
                        },
                        {
                            typename = "Omni", position = {17.654 + 0.5, -1.878, -0.864},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                        },
                        {
                            typename = "Spot", position = {17.654, -1.878, 0.864}, dir_correction = {elevation = math.rad(4.0)},
                            proto = lamp_prototypes.LFS_P_27_1000,
                        },
                        {
                            typename = "Omni", position = {17.654 + 0.5, -1.878, 0.864},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                        },
                        {
                            typename = "Spot", position = {-6.974, 1.066, -24.088}, dir_correction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "Spot", position = {-6.974, 1.066, 24.088}, dir_correction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {17.654, -1.878, -0.864}, dir_correction = {elevation = math.rad(4.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "Omni", position = {17.654 + 0.5, -1.878, -0.864},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                        },
                        {
                            typename = "Spot", position = {17.654, -1.878, 0.864}, dir_correction = {elevation = math.rad(4.0)},
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "Omni", position = {17.654 + 0.5, -1.878, 0.864},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                        },
                        {
                            typename = "Spot", position = {-6.974, 1.066, -24.088}, dir_correction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "Spot", position = {-6.974, 1.066, 24.088}, dir_correction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_STROBES] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "natostrobelight", position = {4.075, 3.215 + 0.200, 0.530}, argument = 83,
                            proto = lamp_prototypes.SMI_2KM,
                        },
                        {
                            typename = "natostrobelight", position = {-15.226, -0.670 - 0.200, -0.070},
                            proto = lamp_prototypes.SMI_2KM,
                        },
                    },
                },
            },
        },
    },
}

-- An-26B
lights_prototypes[AN_26B] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_3arg,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", connector = "MAIN_SPOT_PTR", dir_correction = {elevation = math.rad(8.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_600,
                        },
                        {
                            typename = "Spot", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_P_27_600,
                        },
                    },
                },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", connector = "MAIN_SPOT_PTR", dir_correction = {elevation = math.rad(8.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_180,
                        },
                        {
                            typename = "Spot", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_R_27_180,
                        },
                    },
                },
            }
        },
        [WOLALIGHT_CABIN_NIGHT] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Omni", connector = "pilots_vis",
                            color = {1.0, 0.0, 0.0, 0.2}, range = 8.0,
                        },
                    },
                },
            },
        },
    },
}

-- An-30M
lights_prototypes[AN_30M] = lights_prototypes[AN_26B]

-- AV-8B N/A
lights_prototypes[AV_8B] = default_lights_plane(AV_8B)

-- B-1B
lights_prototypes[B_1] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", position = {16.501, -2.354, 0.015}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_1000, angle_max = math.rad(12.0),
                            exposure = {{0, 0.8, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {16.501 + 1.5, -2.354, 0.015},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            exposure = {{0, 0.8, 1.0}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", position = {16.501, -2.354, 0.015}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_250, angle_max = math.rad(24.0),
                        },
                        {
                            typename = "Omni", position = {16.501 + 1.5, -2.354, 0.015},
                            proto = lamp_prototypes.LFS_R_27_250, range = 8.0,
                        },
                    },
                },
            },
        },
    },
}

-- B-52H
lights_prototypes[B_52] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {9.3, -2.832, 1.3}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_1000,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {9.3 + 0.5, -2.832, 1.3},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {9.032, -2.032, -1.993},
                            proto = lamp_prototypes.LFS_P_27_1000,
                            power_up_t = 1.2, exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {9.032 + 0.5, -2.032, -1.993},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            power_up_t = 1.2, exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {11.518, -2.032, 1.993},
                            proto = lamp_prototypes.LFS_P_27_1000,
                            power_up_t = 1.4, exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {11.518 + 0.5, -2.032, 1.993},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            power_up_t = 1.4, exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {-3.930, 0.327, -20.898},
                            proto = lamp_prototypes.LFS_P_27_1000,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {-3.930 + 0.5, 0.327, -20.898},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {-3.930, 0.327, 20.898},
                            proto = lamp_prototypes.LFS_P_27_1000,
                            power_up_t = 1.4, exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {-3.930 + 0.5, 0.327, 20.898},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            power_up_t = 1.4, exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {9.3, -2.832, 1.3}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "Omni", position = {9.3 + 0.5, -2.832, 1.3},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                        },
                        {
                            typename = "Spot", position = {9.032, -2.032, -1.993},
                            proto = lamp_prototypes.LFS_R_27_450,
                            power_up_t = 1.2,
                        },
                        {
                            typename = "Omni", position = {9.032 + 0.5, -2.032, -1.993},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                            power_up_t = 1.2,
                        },
                        {
                            typename = "Spot", position = {11.518, -2.032, 1.993},
                            proto = lamp_prototypes.LFS_R_27_250,
                            power_up_t = 1.6,
                        },
                        {
                            typename = "Omni", position = {11.518 + 0.5, -2.032, 1.993},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                            power_up_t = 1.6,
                        },
                        {
                            typename = "Spot", position = {-3.930, 0.327, -20.898},
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "Omni", position = {-3.930 + 0.5, 0.327, -20.898},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                        },
                        {
                            typename = "Spot", position = {-3.930, 0.327, 20.898},
                            proto = lamp_prototypes.LFS_R_27_450,
                            power_up_t = 0.4,
                        },
                        {
                            typename = "Omni", position = {-3.930 + 0.5, 0.327, 20.898},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                            power_up_t = 0.4,
                        },
                    },
                },
            },
        },
    },
}

-- C-17A
lights_prototypes[C_17] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {7.972, -0.221, 3.316}, direction = {azimuth = math.rad(10.0), elevation = math.rad(8.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_600, angle_max = math.rad(18.0 + 2.0), angle_min = math.rad(18.0 - 2.0), angle_change_rate = math.rad(-18.0 * 0.25),
                        },
                        {
                            typename = "Spot", position = {7.972, -0.221, -3.316}, direction = {azimuth = math.rad(-10.0), elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_P_27_600, angle_max = math.rad(18.0 + 2.0), angle_min = math.rad(18.0 - 2.0), angle_change_rate = math.rad(-18.0 * -0.25),
                        },
                        {
                            typename = "Omni", position = {7.972 + 0.25, -0.221, 3.316},
                            proto = lamp_prototypes.LFS_P_27_600, range = 4.0,
                        },
                        {
                            typename = "Omni", position = {7.972 + 0.25, -0.221, -3.316},
                            proto = lamp_prototypes.LFS_P_27_600, range = 4.0,
                        },
                    },
                },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {7.972, -0.221, 3.316}, direction = {azimuth = math.rad(10.0), elevation = math.rad(8.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_180, angle_max = math.rad(54.0 + 2.0), angle_min = math.rad(54.0 - 2.0), angle_change_rate = math.rad(-54.0 * 0.25),
                            power_up_t = 0.9,
                        },
                        {
                            typename = "Spot", position = {7.972, -0.221, -3.316}, direction = {azimuth = math.rad(-10.0), elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_R_27_180, angle_max = math.rad(54.0 + 2.0), angle_min = math.rad(54.0 - 2.0), angle_change_rate = math.rad(-54.0 * 0.25),
                            power_up_t = 0.9,
                        },
                        {
                            typename = "Omni", position = {7.972 + 0.25, -0.221, 3.316},
                            proto = lamp_prototypes.LFS_R_27_180, intensity_max = 4.0,
                            power_up_t = 1.4,
                        },
                        {
                            typename = "Omni", position = {7.972 + 0.25, -0.221, -3.316},
                            proto = lamp_prototypes.LFS_R_27_180, intensity_max = 4.0,
                            power_up_t = 1.4,
                        },
                    },
                },
            }
        },
    },
}

-- C-130
lights_prototypes[C_130] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_3arg,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", connector = "MAIN_SPOT_PTR", dir_correction = {elevation = math.rad(22.5)}, argument = 208,
                            proto = lamp_prototypes.LFS_P_27_450, angle_max = math.rad(45.0), angle_min = math.rad(45.0 * 0.8), angle_change_rate = math.rad(-45.0 * 0.25),
                            exposure = {{0, 0.4, 0.7}}, movable = true,
                        },
                        {
                            typename = "Spot", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-22.5)},
                            proto = lamp_prototypes.LFS_P_27_450, angle_max = math.rad(45.0), angle_min = math.rad(45.0 * 0.8), angle_change_rate = math.rad(-45.0 * 0.25),
                            exposure = {{0, 0.4, 0.7}}, movable = true,
                        },
                        {
                            typename = "Spot", connector = "RESERV1_SPOT_PTR",
                            proto = lamp_prototypes.LFS_P_27_450, angle_max = math.rad(45.0), angle_min = math.rad(45.0 * 0.8), angle_change_rate = math.rad(-45.0 * 0.25),
                            exposure = {{0, 0.4, 0.7}}, movable = true,
                        },
                        {
                            typename = "Spot", connector = "RESERV2_SPOT_PTR02",
                            proto = lamp_prototypes.LFS_P_27_450, angle_max = math.rad(45.0), angle_min = math.rad(45.0 * 0.8), angle_change_rate = math.rad(-45.0 * 0.25),
                            exposure = {{0, 0.4, 0.7}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", connector = "MAIN_SPOT_PTR", dir_correction = {elevation = math.rad(22.5)}, argument = 208,
                            proto = lamp_prototypes.LFS_R_27_250,
                            exposure = {{0, 0.4, 0.7}}, movable = true,
                        },
                        {
                            typename = "Spot", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-22.5)},
                            proto = lamp_prototypes.LFS_R_27_250,
                            exposure = {{0, 0.4, 0.7}}, movable = true,
                        },
                        {
                            typename = "Spot", connector = "RESERV1_SPOT_PTR",
                            proto = lamp_prototypes.LFS_R_27_250,
                            exposure = {{0, 0.4, 0.7}}, movable = true,
                        },
                        {
                            typename = "Spot", connector = "RESERV2_SPOT_PTR02",
                            proto = lamp_prototypes.LFS_R_27_250,
                            exposure = {{0, 0.4, 0.7}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_CABIN_BOARDING] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Omni", position = {4.000, 0.600, 0.000},
                            color = {1.0, 0.9, 0.8, 0.8}, range = 8.0,
                        },
                        {
                            typename = "Omni", position = {1.500, 0.600, 0.000},
                            color = {1.0, 0.9, 0.8, 0.8}, range = 8.0,
                        },
                        {
                            typename = "Omni", position = {-1.000, 0.600, 0.000},
                            color = {1.0, 0.9, 0.8, 0.8}, range = 8.0,
                        },
                        {
                            typename = "Omni", position = {-3.500, 0.600, 0.000},
                            color = {1.0, 0.9, 0.8, 0.8}, range = 8.0,
                        },
                        {
                            typename = "Omni", position = {-6.000, 0.600, 0.000},
                            color = {1.0, 0.9, 0.8, 0.8}, range = 8.0,
                        },
                        {
                            typename = "Omni", position = {7.097, -0.560, -1.591},
                            color = {1.0, 0.0, 0.0, 0.8}, range = 3.5,
                        },
                        {
                            typename = "Omni", position = {8.815, 1.572, 0.000},
                            color = {1.0, 0.9, 0.8, 0.4}, range = 8.0,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_CABIN_NIGHT] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Omni", position = {8.815, 1.872, 0.000},
                            color = {1.0, 0.0, 0.0, 0.4}, range = 8.0,
                        },
                    },
                },
            },
        },
    },
}

-- E-2D
lights_prototypes[E_2C] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", connector = "BANO_2", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                            proto = lamp_prototypes.ANO_3_Bl, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                        },
                        {
                            typename = "Spot", connector = "BANO_0", dir_correction = {azimuth = math.rad(-45.0), elevation = math.rad(45.0)}, argument = 190,
                            proto = lamp_prototypes.ANO_3_Kr, angle_max = math.rad(120.0), angle_min = math.rad(90.0),
                        },
                        {
                            typename = "Spot", connector = "BANO_1", dir_correction = {azimuth = math.rad(45.0), elevation = math.rad(45.0)}, argument = 191,
                            proto = lamp_prototypes.ANO_3_Zl, angle_max = math.rad(120.0), angle_min = math.rad(90.0),
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", connector = "MAIN_SPOT_PTR", dir_correction = {azimuth = math.rad(10.0), elevation = math.rad(10.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_200, angle_max = math.rad(30.0), angle_min = math.rad(30.0 * 0.8),
                        },
                        {
                            typename = "Spot", connector = "RESERV_SPOT_PTR", dir_correction = {azimuth = math.rad(-10.0), elevation = math.rad(10.0)},
                            proto = lamp_prototypes.LFS_P_27_200, angle_max = math.rad(30.0), angle_min = math.rad(30.0 * 0.8),
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", connector = "MAIN_SPOT_PTR", dir_correction = {azimuth = math.rad(10.0), elevation = math.rad(10.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_200, angle_max = math.rad(30.0), angle_min = math.rad(30.0 * 0.8),
                        },
                        {
                            typename = "Spot", connector = "RESERV_SPOT_PTR", dir_correction = {azimuth = math.rad(-10.0), elevation = math.rad(10.0)},
                            proto = lamp_prototypes.LFS_P_27_200, angle_max = math.rad(30.0), angle_min = math.rad(30.0 * 0.8),
                        },
                    },
                },
            },
        },
        [WOLALIGHT_CABIN_NIGHT] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Omni", position = {-3.000, 0.200, 0.400},
                            color = {0.0, 1.0, 0.0, 0.4}, range = 2.0,
                        },
                        {
                            typename = "Omni", position = {-2.000, 0.200, 0.400},
                            color = {0.0, 1.0, 0.0, 0.4}, range = 2.0,
                        },
                        {
                            typename = "Omni", position = {-1.000, 0.200, 0.400},
                            color = {0.0, 1.0, 0.0, 0.4}, range = 2.0,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_CABIN_BOARDING] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Omni", position = {2.200, -0.100, -0.600},
                            color = {1.0, 0.9, 0.9, 0.65}, range = 4.4,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_STROBES] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "natostrobelight", position = {4.797, -1.192 - 0.200, 0.020}, argument = 83,
                            proto = lamp_prototypes.MPS_1,
                        },
                        {
                            typename = "natostrobelight", position = {-8.173, 3.268 + 0.200, 3.434},
                            proto = lamp_prototypes.MPS_1,
                        },
                    },
                },
            },
        },
    },
}

-- E-3A
lights_prototypes[E_3] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_3arg,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", connector = "MAIN_SPOT_PTR", argument = 208,
                            proto = lamp_prototypes.LFS_P_27_200, angle_max = math.rad(30.0 + 3.0), angle_min = math.rad(30.0 - 3.0), angle_change_rate = math.rad(-30.0 * 0.25),
                        },
                        {
                            typename = "Spot", connector = "RESERV_SPOT_PTR",
                            proto = lamp_prototypes.LFS_P_27_200, angle_max = math.rad(30.0 + 3.0), angle_min = math.rad(30.0 - 3.0), angle_change_rate = math.rad(-30.0 * 0.25),
                        },
                        {
                            typename = "Spot", connector = "FARA_3",
                            proto = lamp_prototypes.LFS_P_27_450, angle_max = math.rad(30.0 + 3.0), angle_min = math.rad(30.0 - 3.0), angle_change_rate = math.rad(-30.0 * 0.25),
                            exposure = {{0, 0.8, 1.0}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", connector = "MAIN_SPOT_PTR", argument = 208,
                            proto = lamp_prototypes.LFS_R_27_130, angle_max = math.rad(60.0 + 6.0), angle_min = math.rad(60.0 - 6.0), angle_change_rate = math.rad(-60.0 * 0.25),
                        },
                        {
                            typename = "Spot", connector = "RESERV_SPOT_PTR",
                            proto = lamp_prototypes.LFS_R_27_130, angle_max = math.rad(60.0 + 6.0), angle_min = math.rad(60.0 - 6.0), angle_change_rate = math.rad(-60.0 * 0.25),
                        },
                        {
                            typename = "Spot", connector = "FARA_3",
                            proto = lamp_prototypes.LFS_R_27_180, angle_max = math.rad(60.0 + 6.0), angle_min = math.rad(60.0 - 6.0), angle_change_rate = math.rad(-60.0 * 0.25),
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_REFUEL_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "omnilight", position = {17.555, 1.527, 0.242},
                    color = {1.0, 1.0, 1.0, 0.8}, range = 1.0,
                },
            },
        },
    },
}

-- EA-6B
lights_prototypes[EA_6B] = default_lights_plane(EA_6B)

-- F-4E
lights_prototypes[F_4E] = default_lights_plane(F_4E)

-- F-14A
lights_prototypes[F_14] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {6.76, -0.838, 0.0}, direction = {elevation = math.rad(8.0)}, argument = 51,
                            color = {1.0, 1.0, 0.9, 0.3}, intensity_max = 4000.0, angle_max = math.rad(18.0 + 3.0), angle_min = math.rad(18.0 - 3.0),
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {7.35, -0.838, 0.0},
                            color = {1.0, 1.0, 0.9, 0.3}, intensity_max = 5.2,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                    },
                },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {6.76, -0.838, 0.0}, direction = {elevation = math.rad(12.0)}, argument = 51,
                            color = {1.0, 1.0, 0.9, 0.12}, intensity_max = 750.0, angle_max = math.rad(33.3), angle_min = math.rad(0.0),
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {7.35, -0.838, 0.0},
                            color = {1.0, 1.0, 0.9, 0.12}, intensity_max = 4.0,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                    },
                },
            }
        },
        --[WOLALIGHT_CABIN_NIGHT] = uv_lights_default, -- TODO doesn't produce light currently - Made Dragon
    },
}

-- F-15C
lights_prototypes[F_15] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "Collection",
            lights = {
                {
                    typename = "Argument", argument = 192,
                },
                {
                    typename = "Argument", argument = 190,
                    controller = "Strobe", mode = 1, power_up_t = 0.3, cool_down_t = 0.6, period = 1.0, flash_time = 0.7,
                },
                {
                    typename = "Argument", argument = 191,
                    controller = "Strobe", mode = 1, power_up_t = 0.3, cool_down_t = 0.6, period = 1.0, flash_time = 0.7,
                },
            }
        },
        [WOLALIGHT_SPOTS] = {
            typename = "Collection",
            lights = {
                {
                    typename = "Argument", argument = 209,
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "Collection",
            lights = {
                {
                    typename = "Argument", argument = 208,
                },
            },
        },
        [WOLALIGHT_STROBES] = {
            typename = "collection",
            lights = {
                {
                    typename = "Argument", argument = 199,
                    controller = "Strobe", period = 1.33333,
                },
            },
        },
        [WOLALIGHT_FORMATION_LIGHTS] = {
            typename = "argumentlight", argument = 88,
        },
    },
}

-- F-15E
lights_prototypes[F_15E] = lights_prototypes[F_15]

-- F-16A
lights_prototypes[F_16A] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "argumentlight", argument = 49,
                        },
                        {
                            typename = "Spot", position = {-1.948, 0.211, -4.559}, direction = {elevation = math.rad(90.0)},
                            proto = lamp_prototypes.ANO_3_Kr, angle_max = math.rad(90.0), angle_min = math.rad(0.0),
                        },
                        {
                            typename = "Spot", position = {-1.948, 0.211, 4.559}, direction = {elevation = math.rad(90.0)},
                            proto = lamp_prototypes.ANO_3_Zl, angle_max = math.rad(90.0), angle_min = math.rad(0.0),
                        },
                        {
                            typename = "Spot", position = {-3.631, 0.381, -0.621}, direction = {azimuth = math.rad(145.0), elevation = math.rad(-60.0)},
                            proto = lamp_prototypes.FR_100, angle_max = math.rad(40.0),
                        },
                        {
                            typename = "Spot", position = {-3.631, 0.381, 0.621}, direction = {azimuth = math.rad(-145.0), elevation = math.rad(-60.0)},
                            proto = lamp_prototypes.FR_100, angle_max = math.rad(40.0),
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {-0.724, -0.491, -0.516}, direction = {elevation = math.rad(6.0)},
                            proto = lamp_prototypes.LFS_P_27_600,
                            exposure = {{5, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {-0.724 + 0.25, -0.491, -0.516},
                            proto = lamp_prototypes.LFS_P_27_600, range = 6.0,
                            exposure = {{5, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {-0.724, -0.491, 0.516}, direction = {elevation = math.rad(6.0)},
                            proto = lamp_prototypes.LFS_P_27_600,
                            exposure = {{5, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {-0.724 + 0.25, -0.491, 0.516},
                            proto = lamp_prototypes.LFS_P_27_600, range = 6.0,
                            exposure = {{5, 0.99, 1.0}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {-0.724, -0.491, -0.516}, direction = {elevation = math.rad(6.0)},
                            proto = lamp_prototypes.LFS_R_27_180,
                            exposure = {{5, 0.99, 1.0}},
                        },
                        {
                            typename = "Omni", position = {-0.724 + 0.25, -0.491, -0.516},
                            proto = lamp_prototypes.LFS_R_27_180, range = 6.0,
                            exposure = {{5, 0.99, 1.0}},
                        },
                        {
                            typename = "Spot", position = {-0.724, -0.491, 0.516}, direction = {elevation = math.rad(6.0)},
                            proto = lamp_prototypes.LFS_R_27_180,
                            exposure = {{5, 0.99, 1.0}},
                        },
                        {
                            typename = "Omni", position = {-0.724 + 0.25, -0.491, 0.516},
                            proto = lamp_prototypes.LFS_R_27_180, range = 6.0,
                            exposure = {{5, 0.99, 1.0}},
                        },
                    },
                },
            },
        },
    },
}

-- F-16MLU
lights_prototypes[F_16] = lights_prototypes[F_16A]

-- F/A-18A
lights_prototypes[FA_18] = default_lights_plane(FA_18)

-- F/A-18C
lights_prototypes[FA_18C] = lights_prototypes[FA_18] -- TODO duplicated - Made Dragon

-- F-111
lights_prototypes[F_111] = default_lights_plane(F_111)

-- F-117A
lights_prototypes[F_117] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {5.351, -0.777, 0.000}, direction = {elevation = math.rad(8.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_600, angle_max = math.rad(18.0 + 2.0), angle_min = math.rad(18.0 - 2.0), angle_change_rate = math.rad(-18.0 * 0.25),
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {5.351 + 0.25, -0.777, 0.000},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {-0.517, -0.777, 2.314}, direction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_P_27_600, angle_max = math.rad(18.0 + 2.0), angle_min = math.rad(18.0 - 2.0), angle_change_rate = math.rad(-18.0 * 0.25),
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {-0.517 + 0.25, -0.777, 2.314},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {-0.517, -0.777, -2.314}, direction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_P_27_600, angle_max = math.rad(18.0 + 2.0), angle_min = math.rad(18.0 - 2.0), angle_change_rate = math.rad(-18.0 * 0.25),
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {-0.517 + 0.25, -0.777, -2.314},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                    },
                },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {5.351, -0.777, 0.000}, direction = {elevation = math.rad(8.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_180,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {5.351 + 0.25, -0.777, 0.000},
                            proto = lamp_prototypes.LFS_R_27_180, range = 8.0,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {-0.517, -0.777, 2.314}, direction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_R_27_180,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {-0.517 + 0.25, -0.777, 2.314},
                            proto = lamp_prototypes.LFS_R_27_180, range = 8.0,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {-0.517, -0.777, -2.314}, direction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_R_27_180,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {-0.517 + 0.25, -0.777, -2.314},
                            proto = lamp_prototypes.LFS_R_27_180, range = 8.0,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                    },
                },
            }
        },
    },
}

-- Il-76MD
lights_prototypes[IL_76] = lights_prototypes[A_50]

-- Il-78M
lights_prototypes[IL_78] = lights_prototypes[A_50]

-- KC-10
lights_prototypes[KC_10] = default_lights_plane(KC_10)

-- KC-135
lights_prototypes[KC_135] = lights_prototypes[E_3]

-- MiG-23MLD
lights_prototypes[MiG_23] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {2.542, -0.826, -0.812}, direction = {azimuth = math.rad(-10.0), elevation = math.rad(8.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_600,
                        },
                        {
                            typename = "Spot", position = {2.542, -0.826, 0.789}, direction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_P_27_600,
                        },
                        {
                            typename = "Omni", position = {2.542 + 0.5, -0.826, -0.812},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                        },
                        {
                            typename = "Omni", position = {2.542 + 0.5, -0.826, 0.789},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                        },
                    },
                },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {2.542, -0.826, -0.812}, direction = {azimuth = math.rad(-10.0), elevation = math.rad(12.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_180,
                        },
                        {
                            typename = "Spot", position = {2.542, -0.826, 0.789}, direction = {elevation = math.rad(12.0)},
                            proto = lamp_prototypes.LFS_R_27_180,
                        },
                        {
                            typename = "Omni", position = {2.542 + 0.25, -0.826, -0.812},
                            proto = lamp_prototypes.LFS_R_27_180, intensity_max = 8.0,
                        },
                        {
                            typename = "Omni", position = {2.542 + 0.25, -0.826, 0.789},
                            proto = lamp_prototypes.LFS_R_27_180, intensity_max = 8.0,
                        },
                    },
                },
            }
        },
    },
}

-- MiG-25RBT
lights_prototypes[MiG_25] = default_lights_plane(MiG_25)

-- MiG-25PD
lights_prototypes[MiG_25P] = default_lights_plane(MiG_25P)

-- MiG-27K
lights_prototypes[MiG_27] = lights_prototypes[MiG_23]

-- MiG-29A
lights_prototypes[MiG_29] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_3arg,
    }
}

-- MiG-29G
lights_prototypes[MiG_29G] = lights_prototypes[MiG_29]

-- MiG-29K
lights_prototypes[MIG_29K] = lights_prototypes[MiG_29]

-- MiG-29S
lights_prototypes[MiG_29C] = lights_prototypes[MiG_29]

-- MiG-31
lights_prototypes[MiG_31] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", position = {-9.670, 2.406, -1.700}, direction = {azimuth = math.rad(180.0)}, argument = 192,
                            proto = lamp_prototypes.HS_2A, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                        },
                        {
                            typename = "Spot", connector = "BANO_1", dir_correction = {elevation = math.rad(45.0)}, argument = 190,
                            proto = lamp_prototypes.BANO_7M_red, angle_max = math.rad(120.0),
                            controller = "Strobe", mode = 1, power_up_t = 0.5, cool_down_t = 0.5, period = 2.5, reduced_flash_time = 0.45, phase_shift = 0.0,
                        },
                        {
                            typename = "Spot", connector = "BANO_1", dir_correction = {azimuth = math.rad(90.0)},
                            proto = lamp_prototypes.BANO_7M_red, range = 9.0, angle_max = math.rad(70.0), angle_min = math.rad(50.0),
                            controller = "Strobe", mode = 1, power_up_t = 0.5, cool_down_t = 0.5, period = 2.5, reduced_flash_time = 0.45, phase_shift = 0.0,
                        },
                        {
                            typename = "Spot", connector = "BANO_2", dir_correction = {azimuth = math.rad(180.0), elevation = math.rad(45.0)}, argument = 191,
                            proto = lamp_prototypes.BANO_7M_green, angle_max = math.rad(120.0),
                            controller = "Strobe", mode = 1, power_up_t = 0.5, cool_down_t = 0.5, period = 2.5, reduced_flash_time = 0.45, phase_shift = 0.5,
                        },
                        {
                            typename = "Spot", connector = "BANO_2", dir_correction = {azimuth = math.rad(90.0)},
                            proto = lamp_prototypes.BANO_7M_green, range = 9.0, angle_max = math.rad(70.0), angle_min = math.rad(50.0),
                            controller = "Strobe", mode = 1, power_up_t = 0.5, cool_down_t = 0.5, period = 2.5, reduced_flash_time = 0.45, phase_shift = 0.5,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "Collection",
            lights = {
                {
                    typename = "Spot", connector = "MAIN_SPOT_PTR_01", dir_correction = {azimuth = math.rad(-2.0)}, argument = 208,
                    proto = lamp_prototypes.LFS_P_27_1000,
                    exposure = {{0, 0.79, 0.81}}, power_up_t = 0.75, movable = true,
                },
                {
                    typename = "Spot", connector = "MAIN_SPOT_PTR_01", dir_correction = {azimuth = math.rad(-6.0), elevation = math.rad(-12.0)},
                    proto = lamp_prototypes.LFS_P_27_1000,
                    exposure = {{0, 0.79, 0.81}}, power_up_t = 1.25, movable = true,
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "Spot", connector = "MAIN_SPOT_PTR_02", argument = 209,
            proto = lamp_prototypes.LFS_R_27_250,
            exposure = {{0, 0.79, 0.81}}, movable = true,
        },
        [WOLALIGHT_CABIN_NIGHT] = {
            typename = "Omni", position = {4.56, 1.011, 0.1},
            color = {1.0, 0.0, 0.0, 0.5}, intensity_max = 1.8,
        },
        [WOLALIGHT_CABIN_BOARDING] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Omni", position = {4.56, 1.011, -0.1},
                            color = {1.0, 0.9, 0.9, 0.65}, intensity_max = 1.8,
                        },
                        {
                            typename = "Omni", position = {6.08, 1.011, -0.1},
                            color = {1.0, 0.9, 0.9, 0.65}, intensity_max = 1.8,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_REFUEL_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Omni", position = {7.990, 0.792, -0.383},
                            proto = lamp_prototypes.LFS_Z_27_250, intensity_max = 2.0,
                        },
                        {
                            typename = "Spot", position = {7.990, 0.742, -0.383}, direction = {elevation = math.rad(-90.0)},
                            proto = lamp_prototypes.LFS_Z_27_250, intensity_max = 40.0, angle_max = math.rad(120.0),
                        },
                    },
                },
            },
        },
    },
}

-- Mirage 2000-5
lights_prototypes[Mirage] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {3.853, -1.112, -0.106}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_600, angle_max = math.rad(18.0 + 2.0), angle_min = math.rad(18.0 - 2.0), angle_change_rate = math.rad(-18.0 * 0.25),
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {3.853, -1.112, 0.106},
                            proto = lamp_prototypes.LFS_P_27_600, angle_max = math.rad(18.0 + 2.0), angle_min = math.rad(18.0 - 2.0), angle_change_rate = math.rad(-18.0 * 0.25),
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {3.853 + 0.5, -1.112, 0.000},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                    },
                },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {3.853, -1.112, -0.106}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_180, angle_max = math.rad(54.0 + 2.0), angle_min = math.rad(54.0 - 8.0), angle_change_rate = math.rad(-54.0 * 0.25),
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {3.853, -1.112, 0.106},
                            proto = lamp_prototypes.LFS_R_27_180, angle_max = math.rad(54.0 + 2.0), angle_min = math.rad(54.0 - 8.0), angle_change_rate = math.rad(-54.0 * 0.25),
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {3.853 + 0.5, -1.112, 0.000},
                            proto = lamp_prototypes.LFS_R_27_180, range = 8.0,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                    },
                },
            }
        },
    },
}

-- MQ-1A Reaper
lights_prototypes[RQ_1A_Predator] = default_lights_plane(RQ_1A_Predator) -- TODO implement fancy lights - Made Dragon

-- S-3B
lights_prototypes[S_3A] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {4.619, -0.725, -0.246}, direction = {elevation = math.rad(6.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_600,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {4.619 + 0.25, -0.725, -0.246},
                            proto = lamp_prototypes.LFS_P_27_600, range = 4.0,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                    },
                },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {4.619, -0.725, -0.246}, direction = {elevation = math.rad(6.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_180,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {4.619 + 0.25, -0.725, -0.246},
                            proto = lamp_prototypes.LFS_R_27_180, range = 4.0,
                            exposure = {{0, 0.99, 1.0}}, movable = true,
                        },
                    },
                },
            }
        },
    },
}

-- S-3B Tanker
lights_prototypes[S_3R] = lights_prototypes[S_3A]

-- Su-17M4
lights_prototypes[SU_17M4] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {5.460, -0.750, 0.400}, direction = {elevation = math.rad(8.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_600,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {5.460, -0.750, -0.400}, direction = {elevation = math.rad(8.0)},
                            proto = lamp_prototypes.LFS_P_27_600,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {5.460 + 0.5, -0.750, 0.400},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {5.460 + 0.5, -0.750, -0.400},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                    },
                },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {5.460, -0.750, 0.400}, direction = {elevation = math.rad(12.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_180,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {5.460, -0.750, -0.400}, direction = {elevation = math.rad(12.0)},
                            proto = lamp_prototypes.LFS_R_27_180,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {5.460 + 0.5, -0.750, 0.400},
                            proto = lamp_prototypes.LFS_R_27_180, intensity_max = 8.0,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {5.460 + 0.5, -0.750, -0.400},
                            proto = lamp_prototypes.LFS_R_27_180, intensity_max = 8.0,
                            exposure = {{0, 0.9, 1.0}}, movable = true,
                        },
                    },
                },
            }
        },
    },
}

-- Su-24M
lights_prototypes[Su_24] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_3arg,
    },
}

-- Su-24MR
lights_prototypes[Su_24MR] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_3arg,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Spot", connector = "RESERV_SPOT_PTR",
                    proto = lamp_prototypes.LFS_P_27_600,
                    exposure = {{51, 0.99, 1.0}}, movable = true,
                },
                {
                    typename = "Spot", connector = "RESERV_SPOT_PTR001",
                    proto = lamp_prototypes.LFS_P_27_600,
                    exposure = {{51, 0.99, 1.0}}, movable = true,
                },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Spot", position = {-2.000, 0.373, 2.129}, direction = {elevation = math.rad(20.0)},
                    proto = lamp_prototypes.LFS_R_27_180,
                    exposure = {{208, 0.5, 1.0}}, movable = true,
                },
                {
                    typename = "Spot", position = {-2.000, 0.373, -2.129}, direction = {elevation = math.rad(20.0)},
                    proto = lamp_prototypes.LFS_R_27_180,
                    exposure = {{208, 0.5, 1.0}}, movable = true,
                },
            }
        },
    },
}

-- Su-25
lights_prototypes[Su_25] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename  = "omnilight",
                    connector = "BANO_0",
                    color     = {1.0, 1.0, 1.0, 0.17},
                    range     = 4.1,
                    argument  = 192,
                },
                {
                    typename  = "Spot",
                    connector = "BANO_1",
                    color     = {1.0, 0.05, 0.15, 0.17},
                    range     = 12.0,
                    argument  = 190,
                    angle_max = math.rad(160.0), angle_min = math.rad(150.0),
                    controller = "Strobe", mode = 0, power_up_t = 0.3, period = 2.5, reduced_flash_time = 0.333, phase_shift = 0.0,
                },
                {
                    typename  = "Spot",
                    connector = "BANO_2",
                    color     = {0.0, 0.894, 0.6, 0.17},
                    range     = 12.0,
                    argument  = 191,
                    angle_max = math.rad(160.0), angle_min = math.rad(150.0),
                    controller = "Strobe", mode = 0, power_up_t = 0.3, period = 2.5, reduced_flash_time = 0.333, phase_shift = 0.5,
                },
            }
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {typename = "Spot", connector = "MAIN_SPOT_PTR",   argument = -1, color = {255, 201, 125, 0.3},  intensity_max = 4000.0, angle_max = math.rad(20.0), angle_min = math.rad(15.0), angle_change_rate = math.rad(80.0), movable = true, power_up_t = 0.9, cooldown_t = 0.45, },
                {typename = "Spot", connector = "RESERV_SPOT_PTR", argument = -1, color = {255, 201, 125, 0.3},  intensity_max = 4000.0, angle_max = math.rad(20.0), angle_min = math.rad(15.0), angle_change_rate = math.rad(80.0), movable = true, power_up_t = 0.9, cooldown_t = 0.45, },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {typename = "Spot", connector = "MAIN_SPOT_PTR",   argument = -1, color = {255, 201, 125, 0.12}, intensity_max = 750.0,  angle_max = math.rad(100.0),                            angle_change_rate = math.rad(-80.0), movable = true, power_up_t = 0.9, cooldown_t = 0.45, },
                {typename = "Spot", connector = "RESERV_SPOT_PTR", argument = -1, color = {255, 201, 125, 0.12}, intensity_max = 750.0,  angle_max = math.rad(100.0),                            angle_change_rate = math.rad(-80.0), movable = true, power_up_t = 0.9, cooldown_t = 0.45, },
            }
        },
    },
}

-- Su-25T
lights_prototypes[Su_25T] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "omnilight", connector = "BANO_0", position  = {-6.079, 2.896, 0.000}, argument  = 192,
                    color = {1.0, 1.0, 1.0, 0.17}, range = 4.6,
                },
                {
                    typename = "Spot", connector = "BANO_1", position = {-1.516, -0.026, -7.249}, direction = {azimuth = math.rad(-30.0), elevation = 0.0}, argument  = 190,
                    color = {1.0, 0.05, 0.15, 0.17}, range = 18.0, angle_max = math.rad(160.0), angle_min = math.rad(90.0),
                    controller = "Strobe", mode = 0, power_up_t = 0.3, period = 2.5, reduced_flash_time = 0.333, phase_shift = 0.0,
                },
                {
                    typename = "Spot", connector = "BANO_2", position = {-1.516, -0.026,  7.249}, direction = {azimuth = math.rad(30.0), elevation = 0.0}, argument  = 191,
                    color = {0.0, 0.894, 0.6, 0.17}, range = 18.0, angle_max = math.rad(160.0), angle_min = math.rad(90.0),
                    controller = "Strobe", mode = 0, power_up_t = 0.3, period = 2.5, reduced_flash_time = 0.333, phase_shift = 0.5,
                },
            }
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {typename = "Spot", position = {-0.975, -0.248, -6.932}, direction = {azimuth = -0.051, elevation = 0.226}, argument = -1, color = {255, 201, 125, 0.3},  intensity_max = 4000.0, angle_max = math.rad(20.0), angle_min = math.rad(15.0), angle_change_rate = math.rad(80.0),  movable = false, power_up_t = 0.9, cooldown_t = 0.45, },
                {typename = "Spot", position = {-0.975, -0.248,  6.932}, direction = {azimuth = -0.085, elevation = 0.226}, argument = -1, color = {255, 201, 125, 0.3},  intensity_max = 4000.0, angle_max = math.rad(20.0), angle_min = math.rad(15.0), angle_change_rate = math.rad(80.0),  movable = false, power_up_t = 0.9, cooldown_t = 0.45, },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {typename = "Spot", position = {-0.975, -0.248, -6.932}, direction = {azimuth = -0.051, elevation = 0.226}, argument = -1, color = {255, 201, 125, 0.12}, intensity_max = 750.0,  angle_max = math.rad(100.0),                            angle_change_rate = math.rad(-80.0), movable = false, power_up_t = 0.9, cooldown_t = 0.45, },
                {typename = "Spot", position = {-0.975, -0.248,  6.932}, direction = {azimuth = -0.085, elevation = 0.226}, argument = -1, color = {255, 201, 125, 0.12}, intensity_max = 750.0,  angle_max = math.rad(100.0),                            angle_change_rate = math.rad(-80.0), movable = false, power_up_t = 0.9, cooldown_t = 0.45, },
            }
        },
        [WOLALIGHT_CABIN_NIGHT] = uv_lights_default,
    },
}

-- Su-25TM
lights_prototypes[Su_39] = lights_prototypes[Su_25T]

-- Su-27
lights_prototypes[Su_27] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_3arg,
    }
}

-- Su-30
lights_prototypes[Su_30] = default_lights_plane(Su_30)

-- Su-33
lights_prototypes[Su_33] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_3arg,
        [WOLALIGHT_REFUEL_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "argumentlight", argument = 419,
                    power_up_t = 3.3, cool_down_t = 3.3,
                    exposure = {{22}}, movable = true,
                },
                {
                    typename = "argumentlight", argument = 427,
                    power_up_t = 4.1, cool_down_t = 3.9,
                    exposure = {{22}}, movable = true,
                },
            },
        },
    }
}

-- Tornado IDS
lights_prototypes[TORNADO_IDS] = default_lights_plane(TORNADO_IDS)

-- Tornado GR4
lights_prototypes[F_2] = lights_prototypes[TORNADO_IDS]

-- Tu-22M3
lights_prototypes[Tu_22M3] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_3arg,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {4.000, -0.875, -1.767},
                            proto = lamp_prototypes.LFS_P_27_1000,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {4.000 + 0.5, -0.875, -1.767},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {4.000, -0.875, 1.767},
                            proto = lamp_prototypes.LFS_P_27_1000,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {4.000 + 0.5, -0.875, 1.767},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {16.051, -1.214, -0.171},
                            proto = lamp_prototypes.LFS_P_27_1000, angle_max = math.rad(12.0 + 2.0), angle_min = math.rad(12.0 - 2.0), angle_change_rate = math.rad(-12.0 * 0.25),
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {16.051 + 0.5, -1.214, -0.171},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {16.051, -1.214, 0.171},
                            proto = lamp_prototypes.LFS_P_27_1000, angle_max = math.rad(12.0 + 2.0), angle_min = math.rad(12.0 - 2.0), angle_change_rate = math.rad(-12.0 * 0.25),
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {16.051 + 0.5, -1.214, 0.171},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {4.000, -0.875, -1.767},
                            proto = lamp_prototypes.LFS_R_27_450,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {4.000 + 0.5, -0.875, -1.767},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {4.000, -0.875, 1.767},
                            proto = lamp_prototypes.LFS_R_27_450,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {4.000 + 0.5, -0.875, 1.767},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {16.051, -1.214, -0.171},
                            proto = lamp_prototypes.LFS_R_27_450,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {16.051 + 0.5, -1.214, -0.171},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {16.051, -1.214, 0.171},
                            proto = lamp_prototypes.LFS_R_27_450,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {16.051 + 0.5, -1.214, 0.171},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                            exposure = {{208, 0.5, 1.0}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_STROBES] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "natostrobelight", position = {5.463, 1.542 + 0.200, 0.000}, argument = 194,
                            proto = lamp_prototypes.MPS_1,
                            period = 2.0,
                        },
                        {
                            typename = "natostrobelight", position = {4.126, -1.179 - 0.200, 0.004}, argument = 193,
                            proto = lamp_prototypes.MPS_1,
                            period = 1.81, phase_shift = 0.5,
                        },
                    },
                },
            },
        },
    },
}

-- Tu-95MS
lights_prototypes[Tu_95] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {14.412, -1.407, 1.007}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_600,
                        },
                        {
                            typename = "Spot", position = {14.412, -1.407, -1.007}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_600,
                        },
                        {
                            typename = "Omni", position = {14.412 + 0.5, -1.407, 1.007},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                        },
                        {
                            typename = "Omni", position = {14.412 + 0.5, -1.407, -1.007},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {14.412, -1.407, 1.007}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_180,
                        },
                        {
                            typename = "Spot", position = {14.412, -1.407, -1.007}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_180,
                        },
                        {
                            typename = "Omni", position = {14.412 + 0.5, -1.407, 1.007},
                            proto = lamp_prototypes.LFS_R_27_180, range = 8.0,
                        },
                        {
                            typename = "Omni", position = {14.412 + 0.5, -1.407, -1.007},
                            proto = lamp_prototypes.LFS_R_27_180, range = 8.0,
                        },
                    },
                },
            },
        },
    },
}

-- Tu-141
lights_prototypes[Tu_141] = default_lights_plane(Tu_141)

-- Tu-142
lights_prototypes[Tu_142] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {18.553, -1.420, 1.032}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_600,
                        },
                        {
                            typename = "Spot", position = {18.553, -1.420, -1.032}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_600,
                        },
                        {
                            typename = "Omni", position = {18.553 + 0.55, -1.420, 1.032},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                        },
                        {
                            typename = "Omni", position = {18.553 + 0.55, -1.420, -1.032},
                            proto = lamp_prototypes.LFS_P_27_600, range = 8.0,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                [1] = {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {18.553, -1.420, 1.032}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_180,
                        },
                        {
                            typename = "Spot", position = {18.553, -1.420, -1.032}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_180,
                        },
                        {
                            typename = "Omni", position = {18.553 + 0.55, -1.420, 1.032},
                            proto = lamp_prototypes.LFS_R_27_180, range = 8.0,
                        },
                        {
                            typename = "Omni", position = {18.553 + 0.55, -1.420, -1.032},
                            proto = lamp_prototypes.LFS_R_27_180, range = 8.0,
                        },
                    },
                },
            },
        },
    },
}

-- Tu-143
lights_prototypes[Tu_143] = default_lights_plane(Tu_143)

-- Tu-160
lights_prototypes[Tu_160] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {16.173, -0.975, 0.395}, direction = {azimuth = math.rad(10.0), elevation = math.rad(6.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_P_27_1000,
                            exposure = {{0, 0.89, 0.91}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {16.173, -0.975, -0.395}, direction = {azimuth = math.rad(-10.0), elevation = math.rad(6.0)},
                            proto = lamp_prototypes.LFS_P_27_1000,
                            exposure = {{0, 0.89, 0.91}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {16.173 + 1.0, -0.975, 0.000},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            exposure = {{0, 0.89, 0.91}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {23.620, -0.849, 0.330}, direction = {azimuth = math.rad(1.0), elevation = math.rad(2.0)},
                            proto = lamp_prototypes.LFS_P_27_1000,
                            exposure = {{0, 0.89, 0.91}}, movable = true,
                        },
                        {
                            typename = "Spot", position = {23.620, -0.849, -0.330}, direction = {azimuth = math.rad(-1.0), elevation = math.rad(2.0)},
                            proto = lamp_prototypes.LFS_P_27_1000,
                            exposure = {{0, 0.89, 0.91}}, movable = true,
                        },
                        {
                            typename = "Omni", position = {23.620 + 1.0, -0.849, 0.000},
                            proto = lamp_prototypes.LFS_P_27_1000, range = 8.0,
                            exposure = {{0, 0.89, 0.91}}, movable = true,
                        },
                    },
                },
            }
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", position = {16.173, -0.975, 0.395}, direction = {azimuth = math.rad(10.0), elevation = math.rad(6.0)}, argument = 51,
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "Spot", position = {16.173, -0.975, -0.395}, direction = {azimuth = math.rad(-10.0), elevation = math.rad(6.0)},
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "Omni", position = {16.173 + 1.0, -0.975, 0.000},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                        },
                        {
                            typename = "Spot", position = {23.620, -0.849, 0.330}, direction = {azimuth = math.rad(1.0), elevation = math.rad(2.0)},
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "Spot", position = {23.620, -0.849, -0.330}, direction = {azimuth = math.rad(-1.0), elevation = math.rad(2.0)},
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "Omni", position = {23.620 + 1.0, -0.849, 0.000},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                        },
                    },
                },
            }
        },
    },
}

-- Yak-40
lights_prototypes[Yak_40] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", connector = "BANO_0", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                            proto = lamp_prototypes.HS_2A, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                        },
                        {
                            typename = "Spot", connector = "BANO_1", dir_correction = {azimuth = math.rad(-45.0), elevation = math.rad(45.0)}, argument = 190,
                            proto = lamp_prototypes.BANO_7M_red,
                        },
                        {
                            typename = "Spot", connector = "BANO_2", dir_correction = {azimuth = math.rad(45.0), elevation = math.rad(45.0)}, argument = 191,
                            proto = lamp_prototypes.BANO_7M_green,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", connector = "MAIN_SPOT_PTR", dir_correction = {azimuth = math.rad(-2.0), elevation = math.rad(6.0)},
                            proto = lamp_prototypes.LFS_P_27_600,
                            movable = true,
                        },
                        {
                            typename = "Omni", connector = "MAIN_SPOT_PTR", pos_correction = {0.3, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_P_27_600, range = 6.0,
                            movable = true,
                        },
                        {
                            typename = "Spot", connector = "RESERV_SPOT_PTR", dir_correction = {azimuth = math.rad(2.0), elevation = math.rad(6.0)},
                            proto = lamp_prototypes.LFS_P_27_600,
                            movable = true,
                        },
                        {
                            typename = "Omni", connector = "RESERV_SPOT_PTR", pos_correction = {0.3, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_P_27_600, range = 6.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", connector = "MAIN_SPOT_PTR", dir_correction = {azimuth = math.rad(-2.0), elevation = math.rad(6.0)},
                            proto = lamp_prototypes.LFS_R_27_180,
                            movable = true,
                        },
                        {
                            typename = "Omni", connector = "MAIN_SPOT_PTR", pos_correction = {0.3, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_R_27_180, range = 6.0,
                            movable = true,
                        },
                        {
                            typename = "Spot", connector = "RESERV_SPOT_PTR", dir_correction = {azimuth = math.rad(2.0), elevation = math.rad(6.0)},
                            proto = lamp_prototypes.LFS_R_27_180,
                            movable = true,
                        },
                        {
                            typename = "Omni", connector = "RESERV_SPOT_PTR", pos_correction = {0.3, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_R_27_180, range = 6.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_CABIN_NIGHT] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Omni", position = {-1.000, 0.800, 0.000},
                            color = {1.0, 0.6, 0.0, 0.3}, range = 6.0,
                        },
                        {
                            typename = "Omni", position = {1.000, 0.800, 0.000},
                            color = {1.0, 0.6, 0.0, 0.3}, range = 6.0,
                        },
                        {
                            typename = "Omni", position = {3.000, 0.800, 0.000},
                            color = {1.0, 0.6, 0.0, 0.3}, range = 6.0,
                        },
                        {
                            typename = "Omni", position = {5.000, 0.800, 0.000},
                            color = {1.0, 0.6, 0.0, 0.3}, range = 6.0,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_CABIN_BOARDING] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Omni", position = {-1.000, 0.800, 0.000},
                            color = {1.0, 1.0, 1.0, 0.6}, range = 6.0,
                        },
                        {
                            typename = "Omni", position = {1.000, 0.800, 0.000},
                            color = {1.0, 1.0, 1.0, 0.6}, range = 6.0,
                        },
                        {
                            typename = "Omni", position = {3.000, 0.800, 0.000},
                            color = {1.0, 1.0, 1.0, 0.6}, range = 6.0,
                        },
                        {
                            typename = "Omni", position = {5.000, 0.800, 0.000},
                            color = {1.0, 1.0, 1.0, 0.6}, range = 6.0,
                        },
                        {
                            typename = "Omni", position = {7.200, 1.400, 0.000},
                            color = {1.0, 1.0, 1.0, 0.6}, range = 6.0,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_BEACONS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "strobelight", connector = "RED_BEACON", argument = 83,
                            proto = lamp_prototypes.MSL_3_2,
                            emitter_shift_x = -0.25,
                        },
                        {
                            typename = "strobelight", connector = "RESERV_RED_BEACON", argument = 83,
                            proto = lamp_prototypes.MSL_3_2, angular_velocity = math.rad(300),
                            emitter_shift_x = -0.25,
                        },
                    },
                },
            },
        },
    },
}

-- end of Planes --------------------------------------------------------------------------



-- Helicopters ----------------------------------------------------------------------------
-- AH-1W
lights_prototypes[AH_1W] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "BANO_1", dir_correction = {azimuth = math.rad(-90.0)}, argument = 190,
                            proto = lamp_prototypes.ANO_3_Kr,
                        },
                        {
                            typename = "spotlight", connector = "BANO_2", dir_correction = {azimuth = math.rad(90.0)}, argument = 191,
                            proto = lamp_prototypes.ANO_3_Zl,
                        },
                        {
                            typename = "spotlight", connector = "BANO_0 L", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                            proto = lamp_prototypes.HS_2A,
                        },
                        {
                            typename = "spotlight", connector = "BANO_0 R", dir_correction = {azimuth = math.rad(180.0)},
                            proto = lamp_prototypes.HS_2A,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 209,
                            proto = lamp_prototypes.LFS_R_27_250,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_R_27_250, range = 8.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_BEACONS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "RotatingBeacon", connector = "RED_BEACON", argument = 193,
                            proto = lamp_prototypes.MSL_3_2,
                            angular_velocity = math.rad(190), emitter_shift_x = -0.210,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_FORMATION_LIGHTS] = {
            typename = "argumentlight", argument = 200,
        },
    },
}

-- AH-64A
lights_prototypes[AH_64A] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "BANO_1", dir_correction = {azimuth = math.rad(-90.0)}, argument = 190,
                            proto = lamp_prototypes.ANO_3_Kr,
                        },
                        {
                            typename = "spotlight", connector = "BANO_2", dir_correction = {azimuth = math.rad(90.0)}, argument = 191,
                            proto = lamp_prototypes.ANO_3_Zl,
                        },
                        {
                            typename = "spotlight", connector = "BANO_0", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                            proto = lamp_prototypes.ANO_3_Bl,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", dir_correction = {azimuth = math.rad(60.0)}, argument = 209,
                            proto = lamp_prototypes.LFS_R_27_130,
							angle_max = math.rad(60.0),
                        },
						{
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", dir_correction = {azimuth = math.rad(62.0)}, argument = 209,
                            proto = lamp_prototypes.LFS_P_27_200,
							angle_max = math.rad(22.5),
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", dir_correction = {azimuth = math.rad(80.0)}, argument = 209,
                            proto = lamp_prototypes.LFS_R_27_130,
							angle_max = math.rad(60.0)
                        },
						{
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", dir_correction = {azimuth = math.rad(81.0)}, argument = 209,
                            proto = lamp_prototypes.LFS_P_27_200,
							angle_max = math.rad(22.5),
                        },
                    },
                },
            },
        },
        [WOLALIGHT_STROBES] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "natostrobelight", connector = "RED_BEACON L", dir_correction = {azimuth = math.rad(-90.0)}, argument = 193,
                            proto = lamp_prototypes.SMI_2KM,
                            period = 2.0, phase_shift = 0.0,
                        },
                        {
                            typename = "natostrobelight", connector = "RED_BEACON R", dir_correction = {azimuth = math.rad(90.0)}, argument = 194,
                            proto = lamp_prototypes.SMI_2KM,
                            period = 2.0, phase_shift = 0.5,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_AUX_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "natostrobelight", connector = "RED_BEACON L", dir_correction = {azimuth = math.rad(-90.0)}, argument = 193,
                            proto = lamp_prototypes.MPS_1,
                            period = 2.0, phase_shift = 0.0,
                        },
                        {
                            typename = "natostrobelight", connector = "RED_BEACON R", dir_correction = {azimuth = math.rad(90.0)}, argument = 194,
                            proto = lamp_prototypes.MPS_1,
                            period = 2.0, phase_shift = 0.5,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_FORMATION_LIGHTS] = {
            typename = "argumentlight", argument = 200,
        },
    },
}

-- AH-64D
lights_prototypes[AH_64D] = lights_prototypes[AH_64A]

-- CH-47D
lights_prototypes[CH_47D] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "BANO_1", dir_correction = {azimuth = math.rad(-90.0)}, argument = 190,
                            proto = lamp_prototypes.BANO_7M_red, angle_max = math.rad(180.0),
                        },
                        {
                            typename = "spotlight", connector = "BANO_2", dir_correction = {azimuth = math.rad(90.0)}, argument = 191,
                            proto = lamp_prototypes.BANO_7M_green, angle_max = math.rad(180.0),
                        },
                        {
                            typename = "spotlight", connector = "BANO_0", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                            proto = lamp_prototypes.ANO_3_Bl,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.LFS_R_27_450,
                            exposure = {{209, 0.8, 1.0}}, movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_R_27_450, range = 6.0,
                            exposure = {{208, 0.8, 1.0}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.LFS_R_27_450,
                            exposure = {{209, 0.8, 1.0}}, movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_R_27_450, range = 6.0,
                            exposure = {{208, 0.8, 1.0}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_STROBES] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", connector = "RED_BEACON B", dir_correction = {elevation = math.rad(90.0)}, argument = 194,
                            proto = lamp_prototypes.SMI_2KM,
                            phase_shift = 0.0,
                        },
                        {
                            typename = "Omni", connector = "RED_BEACON B", pos_correction = {0.000, -0.200, 0.000},
                            proto = lamp_prototypes.SMI_2KM, range = 8.0,
                            phase_shift = 0.0,
                        },
                        {
                            typename = "Spot", connector = "RED_BEACON T", dir_correction = {elevation = math.rad(-90.0)}, argument = 193,
                            proto = lamp_prototypes.SMI_2KM,
                            phase_shift = 0.5,
                        },
                        {
                            typename = "Omni", connector = "RED_BEACON T", pos_correction = {0.000, 0.200, 0.000},
                            proto = lamp_prototypes.SMI_2KM, range = 8.0,
                            phase_shift = 0.5,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_FORMATION_LIGHTS] = {
            typename = "argumentlight", argument = 200,
        },
        [WOLALIGHT_CABIN_NIGHT] = {
            typename = "Collection",
            lights = {
                [1] = {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Omni", position = {-4.000, 0.200, 0.000},
                            color = {1.0, 0.6, 0.1, 0.4}, range = 7.0,
                        },
                        {
                            typename = "Omni", position = {-2.000, 0.200, 0.000},
                            color = {1.0, 0.6, 0.1, 0.4}, range = 7.0,
                        },
                        {
                            typename = "Omni", position = {0.000, 0.200, 0.000},
                            color = {1.0, 0.6, 0.1, 0.4}, range = 7.0,
                        },
                        {
                            typename = "Omni", position = {2.000, 0.200, 0.000},
                            color = {1.0, 0.6, 0.1, 0.4}, range = 7.0,
                        },
                        {
                            typename = "Omni", position = {4.000, 0.200, 0.000},
                            color = {1.0, 0.6, 0.1, 0.4}, range = 7.0,
                        },
                    },
                },
            },
        },
    },
}

-- CH-53E
lights_prototypes[CH_53E] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
    },
}

-- Ka-27
lights_prototypes[KA_27] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "BANO_1", dir_correction = {elevation = math.rad(-70.0)}, argument = 190,
                            proto = lamp_prototypes.ANO_3_Kr, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                        },
                        {
                            typename = "spotlight", connector = "BANO_2", dir_correction = {elevation = math.rad(70.0)}, argument = 191,
                            proto = lamp_prototypes.ANO_3_Zl, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                        },
                        {
                            typename = "spotlight", connector = "BANO_0", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                            proto = lamp_prototypes.ANO_3_Bl,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR",
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(20.0)}, argument = 45,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(20.0)},
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR",
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_BEACONS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "strobelight", connector = "RED_BEACON", argument = 193,
                            proto = lamp_prototypes.MSL_3_2,
                        },
                        {
                            typename = "strobelight", connector = "RED_BEACON_2", argument = 194,
                            proto = lamp_prototypes.MSL_3_2, angular_velocity = math.rad(370),
                            emitter_shift_x = -0.2,
                        },
                    },
                },
            },
        },
    },
}

-- Ka-50
-- Moved to CoreMods
--[[
lights_prototypes[KA_50] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "BANO_1", dir_correction = {elevation = math.rad(-45.0)}, argument = 190,
                            proto = lamp_prototypes.BANO_7M_red,
                        },
                        {
                            typename = "spotlight", connector = "BANO_2", dir_correction = {elevation = math.rad(45.0)}, argument = 191,
                            proto = lamp_prototypes.BANO_7M_green,
                        },
                        {
                            typename = "spotlight", connector = "BANO_0", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                            proto = lamp_prototypes.HS_2A,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR",
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                    },
                },
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR", argument = 45,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR",
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "RESERV_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR",
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                    },
                },
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR", argument = 45,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR",
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "RESERV_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_BEACONS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "RotatingBeacon", connector = "RED_BEACON", argument = 193,
                            proto = lamp_prototypes.MSL_3_2, angular_velocity = math.rad(360.0/1.5),
                            emitter_shift_x = -0.25,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_FORMATION_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "argumentlight", argument = 200,
                },
                {
                    typename = "argumentlight", argument = 201,
                },
                {
                    typename = "argumentlight", argument = 202,
                },
                {
                    typename = "argumentlight", argument = 203,
                },
            },
        },
        [WOLALIGHT_TIPS_LIGHTS] = tips_lights_default,
    },
}
]]

-- Ka-52
lights_prototypes[KA_52] = default_lights_helicopter(KA_52)

-- Mi-8MTV2
lights_prototypes[MI_8MT] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "spotlight", connector = "BANO_0", dir_correction = {azimuth = math.rad(180.0)},
                    proto = lamp_prototypes.ANO_3_Bl,
                    power_up_t = 1e-6,
                },
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "argumentlight", argument = 191,
                            power_up_t = 1e-6,
                        },
                        {
                            typename = "spotlight", connector = "BANO_1", dir_correction = {azimuth = math.rad(-90.0), elevation = math.rad(-45.0)},
                            proto = lamp_prototypes.ANO_3_Kr,
                            exposure = {{1000, 0.0, 1.0, 1.0, 0.0}}, power_up_t = 1e-6,
                        },
                        {
                            typename = "spotlight", connector = "BANO_003", dir_correction = {azimuth = math.rad(-90.0), elevation = math.rad(-45.0)},
                            proto = lamp_prototypes.ANO_3_Kr,
                            exposure = {{80, 0.0, 1.0, 1.0, 0.0}}, power_up_t = 1e-6,
                        },
                        {
                            typename = "spotlight", connector = "BANO_2", dir_correction = {azimuth = math.rad(-90.0), elevation = math.rad(45.0)},
                            proto = lamp_prototypes.ANO_3_Zl,
                            exposure = {{1000, 0.0, 1.0, 1.0, 0.0}}, power_up_t = 1e-6,
                        },
                        {
                            typename = "spotlight", connector = "BANO_004", dir_correction = {azimuth = math.rad(-90.0), elevation = math.rad(45.0)},
                            proto = lamp_prototypes.ANO_3_Zl,
                            exposure = {{80, 0.0, 1.0, 1.0, 0.0}}, power_up_t = 1e-6,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "argumentlight", argument = 210,
                },
            },
        },
        [WOLALIGHT_BEACONS] = {
            typename = "collection",
            lights = {
                {
                    typename = "RotatingBeacon", connector = "RED_BEACON", argument = 193,
                    proto = lamp_prototypes.MSL_3_2,
                    emitter_shift_x = -0.250, emitter_shift_y = -0.040,
                },
            },
        },
        [WOLALIGHT_FORMATION_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "argumentlight", argument = 200,
                },
            },
        },
        [WOLALIGHT_TIPS_LIGHTS] = tips_lights_default,
        [WOLALIGHT_PROJECTORS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR", argument = 209,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                    },
                },
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR_2", argument = 208,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_CABIN_BOARDING] = {
            typename = "collection",
            lights = {
                -- Plafonds ---------------------------------------------------------------
                { -- 0 - Plafond, White, LH
                    typename = "omnilight", position = {4.120, 0.237, -0.622},
                    color = {1.00, 1.00, 1.00, 0.7}, range = 1.9,
                },
                { -- 1 - Plafond, White, RH
                    typename = "omnilight", position = {4.120, 0.237, 0.622},
                    color = {1.00, 1.00, 1.00, 0.7}, range = 1.9,
                },
                -- ------------------------------------------------------------------------
                -- Cargo Common Lights ----------------------------------------------------
                { -- 2
                    typename = "collection",
                    lights = {
                        {
                            typename = "omnilight", position = {2.300, -0.200, -0.280},
                            color = {1.00, 0.88, 1.00, 0.71}, intensity_max = 2.53,
                        },
                        {
                            typename = "omnilight", position = {1.150, -0.200, -0.280},
                            color = {1.00, 0.88, 1.00, 0.71}, intensity_max = 2.53,
                        },
                        {
                            typename = "omnilight", position = {0.000, -0.200, -0.280},
                            color = {1.00, 0.88, 1.00, 0.71}, intensity_max = 2.53,
                        },
                        {
                            typename = "omnilight", position = {-1.150, -0.200, -0.280},
                            color = {1.00, 0.88, 1.00, 0.71}, intensity_max = 2.53,
                        },
                        {
                            typename = "omnilight", position = {-2.300, -0.200, -0.280},
                            color = {1.00, 0.88, 1.00, 0.71}, intensity_max = 2.53,
                        },
                        {
                            typename = "spotlight", position = {2.649, -1.171, -1.205}, direction = {azimuth = math.rad(-80.0), elevation = math.rad(45.0)},
                            color = {1.00, 0.88, 1.00, 0.7}, intensity_max = 1.5 * 6.6, angle_max = math.rad(70.0), angle_min = 0.0,
                            exposure = {{38, 0.0, 1.0}}, movable = true,
                        },
                        {
                            typename = "spotlight", position = {-2.611, -0.400, 0.000}, direction = {azimuth = math.rad(180.0), elevation = math.rad(45.0)},
                            color = {1.00, 0.88, 1.00, 0.7}, intensity_max = 1.5 * 9.9, angle_max = math.rad(110.0), angle_min = 0.0,
                            exposure = {{86, 0.0, 0.5}}, movable = true,
                        },
                    },
                },
                -- ------------------------------------------------------------------------
            },
        },
        [WOLALIGHT_CABIN_NIGHT] = {
            typename = "collection",
            lights = {
                -- Plafonds ---------------------------------------------------------------
                { -- 0 - Plafond, Red, LH
                    typename = "omnilight", position = {4.220, 0.037, -0.722},
                    color = {1.0, 0.0, 0.0, 0.5}, range = 3.3,
                },
                { -- 1 - Plafond, Red, RH
                    typename = "omnilight", position = {4.220, 0.037, 0.722},
                    color = {1.0, 0.0, 0.0, 0.5}, range = 3.3,
                },
                -- ------------------------------------------------------------------------
                -- Cargo Duty Lights ------------------------------------------------------
                { -- 2
                    typename = "collection",
                    lights = {
                        {
                            typename = "omnilight", position = {2.300, -0.200, 0.280},
                            color = {0.1, 0.09, 1.00, 0.5}, intensity_max = 2.9,
                        },
                        {
                            typename = "omnilight", position = {1.150, -0.200, 0.280},
                            color = {0.1, 0.09, 1.00, 0.5}, intensity_max = 2.9,
                        },
                        {
                            typename = "omnilight", position = {0.000, -0.200, 0.280},
                            color = {0.1, 0.09, 1.00, 0.5}, intensity_max = 2.9,
                        },
                        {
                            typename = "omnilight", position = {-1.150, -0.200, 0.280},
                            color = {0.1, 0.09, 1.00, 0.5}, intensity_max = 2.9,
                        },
                        {
                            typename = "omnilight", position = {-2.300, -0.200, 0.280},
                            color = {0.1, 0.09, 1.00, 0.5}, intensity_max = 2.9,
                        },
                    },
                },
                -- ------------------------------------------------------------------------
            },
        },
    },
}

-- Mi-24V
lights_prototypes[MI_24W] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", connector = "BANO_1", dir_correction = {elevation = math.rad(-45.0)}, argument = 190,
                            proto = lamp_prototypes.BANO_7M_red,
                        },
                        {
                            typename = "Spot", connector = "BANO_2", dir_correction = {elevation = math.rad(55.0)}, argument = 191,
                            proto = lamp_prototypes.BANO_7M_green,
                        },
                        {
                            typename = "Spot", connector = "BANO_0", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                            proto = lamp_prototypes.HS_2A,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 45,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR",
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 45,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR",
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_BEACONS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "RotatingBeacon", connector = "RED_BEACON", argument = 193,
                            proto = lamp_prototypes.MSL_3_2,
                            emitter_shift_x = -0.2,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TIPS_LIGHTS] = tips_lights_default,
    },
}

-- Mi-26
lights_prototypes[MI_26] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "BANO_1", dir_correction = {azimuth = math.rad(90.0)}, argument = 190,
                            proto = lamp_prototypes.BANO_7M_red, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                        },
                        {
                            typename = "spotlight", connector = "BANO_2", dir_correction = {azimuth = math.rad(-90.0)}, argument = 191,
                            proto = lamp_prototypes.BANO_7M_green, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                        },
                        {
                            typename = "spotlight", connector = "BANO_0", argument = 192,
                            proto = lamp_prototypes.HS_2A,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.5, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                        },
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR",
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "omnilight", connector = "RESERV_SPOT_PTR", pos_correction = {0.5, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.5, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                        },
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR",
                            proto = lamp_prototypes.LFS_R_27_450,
                        },
                        {
                            typename = "omnilight", connector = "RESERV_SPOT_PTR", pos_correction = {0.5, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TIPS_LIGHTS] = tips_lights_default,
        [WOLALIGHT_BEACONS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "strobelight", connector = "RED_BEACON", argument = 83,
                            proto = lamp_prototypes.MSL_3_2,
                        },
                        {
                            typename = "strobelight", connector = "RESERV_RED_BEACON", argument = 83,
                            proto = lamp_prototypes.MSL_3_2, angular_velocity = math.rad(350),
                        },
                    },
                },
            },
        },
        --[WOLALIGHT_CABIN_NIGHT] = uv_lights_default, -- TODO doesn't produce light currently - Made Dragon
    },
}

--Mi-28N
lights_prototypes[MI_28N] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "BANO_1", dir_correction = {azimuth = math.rad(-90.0)}, argument = 190,
                            proto = lamp_prototypes.ANO_3_Kr, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                        },
                        {
                            typename = "spotlight", connector = "BANO_2", dir_correction = {azimuth = math.rad(90.0)}, argument = 191,
                            proto = lamp_prototypes.ANO_3_Zl, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                        },
                        {
                            typename = "spotlight", connector = "BANO_0", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                            proto = lamp_prototypes.HS_2A,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR",
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                    },
                },
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-90.0)}, argument = 45,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-90.0)},
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "RESERV_SPOT_PTR", pos_correction = {0.0, 0.25, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR",
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                    },
                },
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-90.0)}, argument = 45,
                            proto = lamp_prototypes.FPP_7,
                            movable = true,
                        },
                        {
                            typename = "spotlight", connector = "RESERV_SPOT_PTR", dir_correction = {elevation = math.rad(-90.0)},
                            proto = lamp_prototypes.FPP_7_halo,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "RESERV_SPOT_PTR", pos_correction = {0.0, 0.25, 0.0},
                            proto = lamp_prototypes.FPP_7, range = 8.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_BEACONS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "RotatingBeacon", connector = "RED_BEACON", argument = 193,
                            proto = lamp_prototypes.MSL_4,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TIPS_LIGHTS] = tips_lights_default,
        [WOLALIGHT_FORMATION_LIGHTS] = {
            typename = "argumentlight", argument = 200,
        },
    },
}

-- OH-58D
lights_prototypes[OH_58D] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "BANO_1", dir_correction = {elevation = math.rad(-90.0)}, argument = 190,
                            proto = lamp_prototypes.ANO_3_Kr, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                        },
                        {
                            typename = "spotlight", connector = "BANO_2", dir_correction = {elevation = math.rad(90.0)}, argument = 191,
                            proto = lamp_prototypes.ANO_3_Zl, angle_max = math.rad(180.0), angle_min = math.rad(170.0),
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.LFS_R_27_450,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 46,
                            proto = lamp_prototypes.LFS_R_27_450,
                            movable = true,
                        },
                        {
                            typename = "omnilight", connector = "MAIN_SPOT_PTR", pos_correction = {0.25, 0.0, 0.0},
                            proto = lamp_prototypes.LFS_R_27_450, range = 8.0,
                            movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TIPS_LIGHTS] = tips_lights_default,
        [WOLALIGHT_STROBES] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "Spot", connector = "RED_BEACON", dir_correction = {azimuth = math.rad(80.0)}, argument = 193,
                            proto = lamp_prototypes.SMI_2KM,
                            controller = "VariablePatternStrobe", mode = "2 Flash Long", period = 0.250,
                        },
                        {
                            typename = "Spot", connector = "RED_BEACON_2", dir_correction = {azimuth = math.rad(-90.0)}, argument = 194,
                            proto = lamp_prototypes.MPS_1,
                            controller = "VariablePatternStrobe", mode = "2 Flash Long", period = 0.250, phase_shift = 2.0,
                        },
                    },
                },
            },
        },
    },
}

-- Sea Lynx
lights_prototypes[Sea_Lynx] = default_lights_helicopter(Sea_Lynx)

-- SH-3H
lights_prototypes[SH_3H] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
    },
}

-- SH-60B
lights_prototypes[SH_60B] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = nav_lights_lockon,
    },
}

-- UH-1H
lights_prototypes[AB_212] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", connector = "BANO_1", dir_correction = {azimuth = math.rad(-45.0)}, argument = 190,
                            proto = lamp_prototypes.ANO_3_Gl, angle_max = math.rad(120.0), angle_min = math.rad(90.0),
                            controller = "Strobe", mode = 1, period = 1.0, flash_time = 0.5,
                        },
                        {
                            typename = "spotlight", connector = "RESERV_BANO_1", dir_correction = {azimuth = math.rad(-45.0)},
                            proto = lamp_prototypes.ANO_3_Gl, angle_max = math.rad(120.0), angle_min = math.rad(90.0),
                            controller = "Strobe", mode = 1, period = 1.0, flash_time = 0.5,
                        },
                        {
                            typename = "spotlight", connector = "BANO_2", dir_correction = {azimuth = math.rad(45.0)}, argument = 191,
                            proto = lamp_prototypes.ANO_3_Zl, angle_max = math.rad(120.0), angle_min = math.rad(90.0),
                            controller = "Strobe", mode = 1, period = 1.0, flash_time = 0.5,
                        },
                        {
                            typename = "spotlight", connector = "RESERV_BANO_2", dir_correction = {azimuth = math.rad(45.0)},
                            proto = lamp_prototypes.ANO_3_Zl, angle_max = math.rad(120.0), angle_min = math.rad(90.0),
                            controller = "Strobe", mode = 1, period = 1.0, flash_time = 0.5,
                        },
                        {
                            typename = "spotlight", connector = "BANO_0", dir_correction = {azimuth = math.rad(180.0)}, argument = 192,
                            proto = lamp_prototypes.ANO_3_Bl,
                            controller = "Strobe", mode = 1, period = 1.0, flash_time = 0.5,
                        },
                        {
                            typename = "spotlight", connector = "RESERV_BANO_0", dir_correction = {azimuth = math.rad(180.0)},
                            proto = lamp_prototypes.ANO_3_Bl,
                            controller = "Strobe", mode = 1, period = 1.0, flash_time = 0.5,
                        },
                        {
                            typename = "omnilight", connector = "RESERV_BANO_0", pos_correction = {-0.1, 0.0, 0.0},
                            proto = lamp_prototypes.ANO_3_Bl, range = 4.0,
                            controller = "Strobe", mode = 1, period = 1.0, flash_time = 0.5,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "argumentlight", argument = 208,
                },
            },
        },
        [WOLALIGHT_PROJECTORS] = {
            typename = "collection",
            lights = {
                {
                    typename = "argumentlight", argument = 209,
                },
            },
        },
        [WOLALIGHT_BEACONS] = {
            typename = "collection",
            lights = {
                {
                    typename = "Collection",
                    lights = {
                        {
                            typename = "RotatingBeacon", connector = "RED_BEACON", argument = 193,
                            proto = lamp_prototypes.MSL_3_2, angle_max = math.rad(45.0),
                            cups = 1, angular_velocity = math.rad(220.0), emitter_shift_x = -0.100, emitter_shift_y = -0.040,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_CABIN_NIGHT] = {
            typename = "collection",
            lights = {
                {
                    typename = "argumentlight", argument = 69,
                },
            },
        },
        [WOLALIGHT_CABIN_BOARDING] = {
            typename = "collection",
            lights = {
                {
                    typename = "argumentlight", argument = 446,
                },
            },
        },
    },
}

-- UH-60A
lights_prototypes[UH_60A] = {
    typename = "collection",
    lights = {
        [WOLALIGHT_NAVLIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", position = {-10.730, 1.720, 0.000}, direction = {azimuth = math.rad(180.0)}, argument = 49,
                            proto = lamp_prototypes.ANO_3_Bl,
                        },
                        {
                            typename = "Spot", connector = "BANO_1", dir_correction = {azimuth = math.rad(-45.0), elevation = math.rad(-45.0)}, argument = 190,
                            proto = lamp_prototypes.ANO_3_Kr, angle_max = math.rad(120.0),
                        },
                        {
                            typename = "Spot", connector = "BANO_1", dir_correction = {azimuth = math.rad(180.0)},
                            proto = lamp_prototypes.ANO_3_Kr, angle_max = math.rad(90.0),
                        },
                        {
                            typename = "Spot", connector = "BANO_2", dir_correction = {azimuth = math.rad(-45.0), elevation = math.rad(45.0)}, argument = 191,
                            proto = lamp_prototypes.ANO_3_Zl, angle_max = math.rad(120.0),
                        },
                        {
                            typename = "Spot", connector = "BANO_2", dir_correction = {azimuth = math.rad(180.0)},
                            proto = lamp_prototypes.ANO_3_Zl, angle_max = math.rad(90.0),
                        },
                    },
                },
            },
        },
        [WOLALIGHT_SPOTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", position = {3.210, -1.326, 0.545}, direction = {elevation = math.rad(20.0)}, argument = 45,
                            proto = lamp_prototypes.LFS_P_27_450,
                            exposure = {{208, 0.8, 1.0}}, movable = true,
                        },
                        {
                            typename = "omnilight", position = {3.210 + 0.200, -1.326, 0.545},
                            proto = lamp_prototypes.LFS_P_27_450, range = 6.0,
                            exposure = {{208, 0.8, 1.0}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_TAXI_LIGHTS] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "spotlight", position = {3.210, -1.326, 0.545}, direction = {elevation = math.rad(20.0)}, argument = 45,
                            proto = lamp_prototypes.LFS_R_27_450,
                            exposure = {{208, 0.8, 1.0}}, movable = true,
                        },
                        {
                            typename = "omnilight", position = {3.210 + 0.200, -1.326, 0.545},
                            proto = lamp_prototypes.LFS_R_27_450, range = 6.0,
                            exposure = {{208, 0.8, 1.0}}, movable = true,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_STROBES] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "Spot", position = {-5.465, -1.340, 0.000}, direction = {elevation = math.rad(90.0)}, argument = 193,
                            proto = lamp_prototypes.SMI_2KM,
                            phase_shift = 0.0,
                        },
                        {
                            typename = "Omni", position = {-10.130, 2.000, 0.000},
                            proto = lamp_prototypes.SMI_2KM,
                            phase_shift = 0.5,
                        },
                    },
                },
            },
        },
        [WOLALIGHT_CABIN_NIGHT] = {
            typename = "collection",
            lights = {
                {
                    typename = "collection",
                    lights = {
                        {
                            typename = "argumentlight", argument = 69,
                        },
                        {
                            typename = "omnilight", position = {2.180, 0.130, 0.000},
                            color = {0.0, 1.0, 0.3, 0.5}, range = 5.0,
                        },
                    },
                },
            },
        },
    },
}

-- end of Helicopters ---------------------------------------------------------------------
