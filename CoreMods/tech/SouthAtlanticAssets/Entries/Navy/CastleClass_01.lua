
--Setting Up Model Container
mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/Leeds_Castle/Leeds_Castle.zip")
-- End Of Model Container

GT = {};

GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "CastleClass_01"
GT.visual.shape_dstr = "CastleClass_01"

-- Ship Build
GT.life = 1200
GT.mass = 1.427e+003 --3.65e+006
GT.max_velocity = 13.375   -- Velocity in m/s  (metric)
GT.race_velocity = 9
GT.economy_velocity = 5.144
GT.economy_distance = 10.0e+003
GT.race_distance = 2.9632e+003
GT.shipLength = 74.1
GT.Width = 13.2
GT.Height = 30
GT.Length = 74
GT.DeckLevel = 4.7
GT.X_nose = 33.5
GT.X_tail = -40.5
GT.Tail_Width = 14
GT.Gamma_max = 0.35
GT.Om = 0.05
GT.speedup = 0.365728
GT.R_min = 247
GT.distFindObstacles = 200
GT.numParking = 1
GT.Plane_Num_ = 0
GT.Helicopter_Num_ = 2
GT.Landing_Point = {-29.0, 3.15,0.00}
GT.airWeaponDist = 3000
GT.airFindDist = 25000
GT.exhaust = {
							[1] = { size = 0.5 , pos = {-7.08, 14.38 , -0.11 } }, -- X Axis (forward and Back) - Height - Side to side}
							[2] = { size = 0.5 , pos = {-7.08 , 13.76 , -0.81 } },
}


-- weapon systems

--WS Entry (1) For Sounders.
GT.WS = {}
GT.WS.maxTargetDetectionRange = 25000;
GT.WS.radar_type = 109 --optical in wstypes
GT.WS.searchRadarMaxElevation = math.rad(70);

ws = GT_t.inc_ws();
GT.WS[ws] = {}
set_recursive_metatable(GT.WS[ws], GT_t.SS_t.OSA_tracker);
GT.WS[ws].pos = {-5,6,8};
GT.WS[ws].angles[1][1] = math.rad(125);
GT.WS[ws].angles[1][2] = math.rad(-125);

local ws;
-- Bushmaster Autogun Entry 2 For Sounders
ws = GT_t.inc_ws();
GT.WS[ws] = {}
GT.WS[ws].center = 'Center_Gun_LC_01'
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].angles= { -- X Rotation (degrees)     Y Rotation (degrees)
                    {math.rad(150), math.rad(-150), math.rad(-5), math.rad(70)},   -- Rotational Arc 
                    {math.rad(-150), math.rad(150), math.rad(60), math.rad(70)},   -- Rotational Arc Superstructure
                    };
                    
GT.WS[ws].reference_angle_Y = math.rad(0);
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.automatic_gun_25mm);
__LN.BR[1].connector_name = 'Gun_LC_01'


-- Port Machineguns 7.62 GPMG   Entry 3 For Sounders
ws = GT_t.inc_ws();
GT.WS[ws] = {}
GT.WS[ws].center = 'Machine_Gun_LC_01'
GT.WS[ws].drawArgument1 = 49
GT.WS[ws].drawArgument2 = 50
GT.WS[ws].angles = {{math.rad(165), math.rad(-5), math.rad(-5), math.rad(70)},};
GT.WS[ws].reference_angle_Y = math.rad(0);		-- Default Rest
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_M240C);
__LN.BR[1].connector_name = 'MGun_LC_01'


-- STBD Machineguns 7.62 GPMG   Entry 3 For Sounders
ws = GT_t.inc_ws();
GT.WS[ws] = {}
GT.WS[ws].center = 'Machine_Gun_LC_02'
GT.WS[ws].drawArgument1 = 51
GT.WS[ws].drawArgument2 = 52
GT.WS[ws].angles = 	{{math.rad(5), math.rad(-165), math.rad(-5), math.rad(70)},};
GT.WS[ws].reference_angle_Y = math.rad(0);		-- Default Rest			
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.machinegun_M240C);
__LN.BR[1].connector_name = 'MGun_LC_02'


GT.Name = "CastleClass_01"
GT.DisplayName = _("Castle Class")
GT.Rate = 1460

GT.Sensors = { OPTIC = {"long-range naval optics"},
            };

GT.DetectionRange  = GT.airFindDist;
GT.ThreatRange = GT.airWeaponDist;
GT.Singleton   ="no";
GT.mapclasskey = "P0091000070";
GT.attribute = {wsType_Navy,wsType_Ship,wsType_ArmedShip,REZKY,
                    "Corvettes",
					"Armed Ship",
					"Naval",
                    "RADAR_BAND2_FOR_ARM",
				};
GT.Categories = {{name = "Armed Ship"}, {name = "HelicopterCarrier"}};
GT.Countries		= {"UK"};
GT.tags  =
{
	"Corvette and Patrol",
}
			
add_surface_unit(GT)				