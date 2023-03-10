-- USS Argleigh Burke IIa

GT = {};
GT_t.ws = 0;

set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "Arleigh_Burke_IIa"
GT.visual.shape_dstr = ""

GT.encyclopediaAnimation = { 
	args = {
		[6] = 1, -- aft radar 1 rotation
		[10] = 1, -- aft radar 2 rotation
		[14] = 0.15, -- fwd cannon elevation
		[19] = 1, -- aft Phalanxs rotation
		[20] = 0.1, -- aft Phalanxs elevation
		[21] = 0.5, -- PS aux gun rotation
		[23] = -0.5, -- SB aux gun rotation
		[31] = 0.5, -- PS MG rotation
		[33] = -0.5, -- SB MG rotation
	}		
}

GT.IR_emission_coeff = 0.4

GT.life = 2100
GT.mass = 9.2e+006
GT.max_velocity = 15.55
GT.race_velocity = 15.55
GT.economy_velocity = 8.0
GT.economy_distance = 8.100e+006
GT.race_distance = 2.778e+006
GT.shipLength = 143.0
GT.Width = 22.0
GT.Height = 38.0
GT.Length = 155.5
GT.DeckLevel = 6.0
GT.X_nose = 74.0
GT.X_tail = -69.0
GT.Tail_Width = 15
GT.draft = 11
GT.Gamma_max = 1.0
GT.Om = 0.02
GT.speedup = 0.269786
GT.R_min = 275
GT.distFindObstacles = 462.5
GT.RCS = 80000 -- estimated RCS in square meters / оценочная ЭПР в кв.м.

GT.numParking = 1
GT.Helicopter_Num_ = 2
GT.Landing_Point = {-60.3, 3.7, 0.0}

GT.airWeaponDist = 100000
GT.airFindDist = 150000
GT.sensor = {
	max_range_finding_target = 100000,
	min_range_finding_target = 0,
	max_alt_finding_target = 30000,
	min_alt_finding_target = 0,
	pos = {27.0, 17.0, 0.0} -- search radar position
}

GT.animation_arguments = {
	nav_lights = 149, -- navigation lights 
	radar1_rotation = 1,
	radar2_rotation = 2,
	radar3_rotation = -1,
	flag_animation = -1,
	water_propeller = 65,
	flight_deck_fences = 150 -- опускание ограждения вертолетной плащадки
	-- 152 - deck illumination
}	
GT.radar1_period = 3;
GT.radar2_period = 3;

GT.DM = {
    { area_name = "Nose_Col_R", area_arg = 70, area_life = 55, 			area_fire = { connector = "FIRE_NOSE_R", size = 0.3}},
    { area_name = "Bort_Col_R", area_arg = 71, area_life = 55, 			area_fire = { connector = "FIRE_BORT_R", size = 0.3}},
    { area_name = "Korma_Col_R", area_arg = 72, area_life = 55, 		area_fire = { connector = "FIRE_KORMA_R", size = 0.3}},
	{ area_name = "Nose_Col_L", area_arg = 73, area_life = 55, 			area_fire = { connector = "FIRE_NOSE_L", size = 0.3}},
    { area_name = "Bort_Col_L", area_arg = 74, area_life = 55, 			area_fire = { connector = "FIRE_BORT_L", size = 0.3}},
    { area_name = "Korma_Col_L", area_arg = 75, area_life = 55, 		area_fire = { connector = "FIRE_KORMA_L", size = 0.3}},
	{ area_name = "Nose_Col_Top", area_arg = 76, area_life = 55,		area_fire = { connector = "FIRE_NOSE_TOP_02", size = 0.3}},
	{ area_name = "Cabin_Col_Front", area_arg = 77, area_life = 55, 	},
	{ area_name = "Cabin_Col_R", area_arg = 78, area_life = 55,			},
	{ area_name = "Cabin_Col_L", area_arg = 79, area_life = 55,			},
	{ area_name = "Middle_Col_R", area_arg = 80, area_life = 55,		},
	{ area_name = "Middle_Col_L", area_arg = 81, area_life = 55,		},
	{ area_name = "Tube_Col_Front", area_arg = 82, area_life = 55,		},
	{ area_name = "Paluba_Centr_Col_R", area_arg = 83, area_life = 55, 	area_fire = { connector = "FIRE_PALUBA_CENTR_R", size = 0.3}},
	{ area_name = "Paluba_Centr_Col_L", area_arg = 84, area_life = 55, 	area_fire = { connector = "FIRE_PALUBA_CENTR_L", size = 0.3}},
	{ area_name = "Tube_Back_Col_R", area_arg = 85, area_life = 55,		},
	{ area_name = "Tube_Back_Col_L", area_arg = 86, area_life = 55,		},
	{ area_name = "Bort_Col_Top", area_arg = 87, area_life = 55, 		area_fire = { connector = "FIRE_Bort_Top_01", size = 0.3}},
	{ area_name = "Korma_Col_Paluba", area_arg = 88, area_life = 55, 	area_fire = { connector = "FIRE_KORMA_Top", size = 0.3}},
	{ area_name = "Korma_Col_Back", area_arg = 89, area_life = 55,		},
}

-- weapon systems
GT.WS = {}
local ws;
GT.WS.maxTargetDetectionRange = 450000;
GT.WS.radar_type = 102
GT.WS.searchRadarMaxElevation = math.rad(60);
GT.WS.searchRadarFrequencies = {{50.0e6, 54.0e6}, {2.0e9, 2.2e9}}

-- Bushmaster Autogun
ws = GT_t.inc_ws();
GT.WS[ws] = {}
GT.WS[ws].center = 'CENTER_TOWER_MK_38_01'
GT.WS[ws].drawArgument1 = 21
GT.WS[ws].drawArgument2 = 22
GT.WS[ws].angles = {
                    {math.rad(170), math.rad(10), math.rad(-5), math.rad(40)},
                    };
GT.WS[ws].reference_angle_Y = math.rad(90);
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.automatic_gun_25mm);
__LN.BR[1].connector_name = 'POINT_MK_38_01'

ws = GT_t.inc_ws();
GT.WS[ws] = {}
GT.WS[ws].center = 'CENTER_TOWER_MK_38_02'
GT.WS[ws].drawArgument1 = 23
GT.WS[ws].drawArgument2 = 24
GT.WS[ws].angles = {
                    {math.rad(-10), math.rad(-170), math.rad(-5), math.rad(40)},
                    };
GT.WS[ws].reference_angle_Y = math.rad(-90);
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.automatic_gun_25mm);
__LN.BR[1].connector_name = 'POINT_MK_38_02'

-- CIWS Phalanxs
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.phalanx )
--GT.WS[ws].area = 'ZA_L'
GT.WS[ws].center = 'CENTER_TOWER_PHALANX_01'
GT.WS[ws].drawArgument1 = 17
GT.WS[ws].drawArgument2 = 18
GT.WS[ws].angles[1][1] = math.rad(120);
GT.WS[ws].angles[1][2] = math.rad(-120);
GT.WS[ws].LN[1].fireAnimationArgument = 119
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_PHALANX_01'


ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.phalanx )
--GT.WS[ws].area = 'ZA_R'
GT.WS[ws].center = 'CENTER_TOWER_PHALANX_02'
GT.WS[ws].drawArgument1 = 19
GT.WS[ws].drawArgument2 = 20
GT.WS[ws].angles[1][1] = math.rad(-20);
GT.WS[ws].angles[1][2] = math.rad(20);
GT.WS[ws].reference_angle_Y = math.rad(-180);
GT.WS[ws].LN[1].fireAnimationArgument = 120
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_PHALANX_02'

-- Artillery Guns
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_FMC5 )
--GT.WS[ws].area = 'TOWER_NOSE'
GT.WS[ws].center = 'CENTER_TOWER_MK_45_01'
GT.WS[ws].drawArgument1 = 13
GT.WS[ws].drawArgument2 = 14
GT.WS[ws].angles[1][1] = math.rad(160);
GT.WS[ws].angles[1][2] = math.rad(-160);
GT.WS[ws].reference_angle_Z = math.rad(5);
GT.WS[ws].LN[1].BR[1].connector_name = 'POINT_MK_45_01'
--GT.WS[ws].LN[1].BR[1].recoilArgument = 33;
--GT.WS[ws].LN[1].BR[1].recoilTime = 0.2;

-- 9 AIGES trackers
ws = GT_t.inc_ws();
local first_EGES_tracker_id = ws;
GT.WS[ws] = {
	omegaY = 2,
	omegaZ = 2,
	pidY = {p=100, i=0.05, d=12, inn = 50},
	pidZ = {p=100, i=0.05, d=12, inn = 50},
	--area = 'KABINA',
	pos = {27.0, 17.0, 0.0},
	angles = { {math.rad(180), math.rad(-180), math.rad(-90), math.rad(80)} },
	LN = {
		[1] = {
			type = 102,
			frequencyRange = {0.5e9, 0.58e9},
			distanceMin = 1000,
			distanceMax = 150000,
			reactionTime = 2.0,
			reflection_limit = 0.05,
			ECM_K = 0.5,
			min_trg_alt = 5,
			max_trg_alt = 30000,
			max_number_of_missiles_channels = 2,
			beamWidth = math.rad(90);
		}
	}
};
local AIGES_TRACKERS = {{{'self', ws}}}

for i=2,9 do
	ws = GT_t.inc_ws();
	GT.WS[ws] = {};
	set_recursive_metatable(GT.WS[ws], GT.WS[first_EGES_tracker_id]);
	table.insert(AIGES_TRACKERS, {{'self', ws}})
end;

-- Tomahawk Front
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_TOMAHAWK )
GT.WS[ws].area = 'Nose_Col_Top'
GT.WS[ws].center = 'POINT_MK_41_08'
GT.WS[ws].LN[1].PL[1].ammo_capacity = 16;
GT.WS[ws].LN[1].max_number_of_missiles_channels = 16; -- unlimited
GT.WS[ws].LN[1].BR = {
	{connector_name = 'POINT_MK_41_01', recoilArgument = 177, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_02', recoilArgument = 178, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_03', recoilArgument = 179, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_04', recoilArgument = 180, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_05', recoilArgument = 181, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_06', recoilArgument = 182, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_07', recoilArgument = 183, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_08', recoilArgument = 184, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},

	{connector_name = 'POINT_MK_41_09', recoilArgument = 185, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_10', recoilArgument = 186, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_11', recoilArgument = 187, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_12', recoilArgument = 188, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_13', recoilArgument = 189, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_14', recoilArgument = 190, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_15', recoilArgument = 191, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_16', recoilArgument = 192, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
}

-- SM2 Front
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_MK41_SM2 )
GT.WS[ws].area = 'Nose_Col_Top';
GT.WS[ws].center = 'POINT_MK_41_24';
GT.WS[ws].LN[1].depends_on_unit = AIGES_TRACKERS
GT.WS[ws].LN[1].PL[1].ammo_capacity = 16;
GT.WS[ws].LN[1].BR = {
	{connector_name = 'POINT_MK_41_17', recoilArgument = 193, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_18', recoilArgument = 194, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_19', recoilArgument = 195, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_20', recoilArgument = 196, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_21', recoilArgument = 197, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_22', recoilArgument = 198, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_23', recoilArgument = 199, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_24', recoilArgument = 200, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},

	{connector_name = 'POINT_MK_41_25', recoilArgument = 201, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_26', recoilArgument = 202, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_27', recoilArgument = 203, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_28', recoilArgument = 204, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_29', recoilArgument = 205, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_30', recoilArgument = 206, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_31', recoilArgument = 207, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_32', recoilArgument = 208, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
}

-- Tomahawk rear
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_TOMAHAWK )
GT.WS[ws].area = 'Bort_Col_Top'
GT.WS[ws].center = 'POINT_MK_41_40'
GT.WS[ws].LN[1].PL[1].ammo_capacity = 16;
GT.WS[ws].LN[1].max_number_of_missiles_channels = 16; -- unlimited
GT.WS[ws].LN[1].BR = {
	{connector_name = 'POINT_MK_41_33', recoilArgument = 209, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_34', recoilArgument = 210, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_35', recoilArgument = 211, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_36', recoilArgument = 212, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_37', recoilArgument = 213, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_38', recoilArgument = 214, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_39', recoilArgument = 215, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_40', recoilArgument = 216, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	                                                                                                    
	{connector_name = 'POINT_MK_41_41', recoilArgument = 217, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_42', recoilArgument = 218, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_43', recoilArgument = 219, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_44', recoilArgument = 220, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_45', recoilArgument = 221, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_46', recoilArgument = 222, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_47', recoilArgument = 223, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_48', recoilArgument = 224, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
}

-- SM2 Rear
ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.ship_MK41_SM2 )
GT.WS[ws].area = 'Bort_Col_Top';
GT.WS[ws].center = 'POINT_MK_41_56';
GT.WS[ws].LN[1].depends_on_unit = AIGES_TRACKERS
GT.WS[ws].LN[1].PL[1].ammo_capacity = 48;
GT.WS[ws].LN[1].BR = {
	{connector_name = 'POINT_MK_41_49',recoilArgument = 225, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_50',recoilArgument = 226, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_51',recoilArgument = 227, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_52',recoilArgument = 228, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_53',recoilArgument = 229, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_54',recoilArgument = 230, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_55',recoilArgument = 231, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_56',recoilArgument = 232, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	                                                                                                   
	{connector_name = 'POINT_MK_41_57',recoilArgument = 233, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_58',recoilArgument = 234, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_59',recoilArgument = 235, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_60',recoilArgument = 236, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_61',recoilArgument = 237, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_62',recoilArgument = 238, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_63',recoilArgument = 239, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_64',recoilArgument = 240, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	
	{connector_name = 'POINT_MK_41_65', recoilArgument = 241, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_66', recoilArgument = 242, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_67', recoilArgument = 243, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_68', recoilArgument = 244, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_69', recoilArgument = 245, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_70', recoilArgument = 246, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_71', recoilArgument = 247, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_72', recoilArgument = 248, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	                                                                                                    
	{connector_name = 'POINT_MK_41_73', recoilArgument = 249, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_74', recoilArgument = 250, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_75', recoilArgument = 251, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_76', recoilArgument = 252, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_77', recoilArgument = 253, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_78', recoilArgument = 254, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_79', recoilArgument = 255, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_80', recoilArgument = 256, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	
	{connector_name = 'POINT_MK_41_81', recoilArgument = 257, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_82', recoilArgument = 258, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_83', recoilArgument = 259, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_84', recoilArgument = 260, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_85', recoilArgument = 261, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_86', recoilArgument = 262, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_87', recoilArgument = 263, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_88', recoilArgument = 264, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	                                                                                                    
	{connector_name = 'POINT_MK_41_89', recoilArgument = 265, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_90', recoilArgument = 266, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_91', recoilArgument = 267, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_92', recoilArgument = 268, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_93', recoilArgument = 269, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_94', recoilArgument = 270, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_95', recoilArgument = 271, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
	{connector_name = 'POINT_MK_41_96', recoilArgument = 272, recoilT0 = -2, recoilT1 = -1, recoilT2 = 1.0, recoilTime = 2},
}

GT.Name = "USS_Arleigh_Burke_IIa"
GT.DisplayName = _("DDG Arleigh Burke IIa")
GT.DisplayNameShort = _("A.Burke")
GT.Rate = 3000

GT.Sensors = {  OPTIC = {"long-range naval optics", "long-range naval LLTV", "long-range naval FLIR",},
                RADAR = {
                    "Patriot str",
                    "ticonderoga search radar",
                }
            };

GT.DetectionRange  = GT.airFindDist;
GT.ThreatRange = GT.airWeaponDist;
GT.Singleton   ="no";
GT.mapclasskey = "P0091000067";
GT.attribute = {wsType_Navy,wsType_Ship,wsType_ArmedShip,TICONDEROGA,
                    "Cruisers",
                    "RADAR_BAND1_FOR_ARM",
                    "DetectionByAWACS",
				};
GT.Categories = {
					{name = "Armed Ship"},
					{name = "HelicopterCarrier"}
				};
GT.tags  =
{
	"Destroyer",
}
GT.Countries = {"USA"}