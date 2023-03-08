--Setting Up Model Container
--mount_vfs_texture_path  (current_mod_path.."/Textures/Navy/HarborTug/HarborTug.zip")

-- End Of Model Container

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_ship)

GT.visual = {}
GT.visual.shape = "HarborTug"
GT.visual.shape_dstr = ""

-- Ship Build
GT.life = 400
GT.mass = 1.427e+003 --3.65e+006
GT.max_velocity = 13.375   -- Velocity in m/s  (metric)
GT.race_velocity = 9
GT.economy_velocity = 5.144
GT.economy_distance = 10.0e+003
GT.race_distance = 2.9632e+003
GT.shipLength = 20
GT.Width = 7.7
GT.Height = 30
GT.Length = 20
GT.DeckLevel = 1.1
GT.X_nose = 10.5
GT.X_tail = -10.5
GT.Tail_Width = 8
GT.Gamma_max = 0.35
GT.Om = 0.05
GT.speedup = 0.365728
GT.R_min = 247
GT.distFindObstacles = 300

GT.riverCraft = true




GT.airWeaponDist = 0
GT.airFindDist = 0

GT.exhaust = {
							[1] = { size = 0.5 , pos = {-1.13, 7.06 , -1.14 } }, -- X Axis (forward and Back) - Height - Side to side}
							[2] = { size = 0.5 , pos = {-1.13, 7.06 , 1.14 } },

};

GT.Name = "HarborTug"  ----  Represents Upper folder for Livery
GT.DisplayName = ("Harbor Tug")
GT.Rate = 700


GT.DetectionRange  = GT.airFindDist;
GT.ThreatRange = GT.airWeaponDist;
GT.Singleton   ="no";
GT.mapclasskey = "P0091000039";
GT.attribute = {wsType_Navy,wsType_Ship,wsType_CivilShip,wsType_GenericCivShip,
				"Unarmed ships"
				};

GT.tags  =
{
	"Support",
}

add_surface_unit(GT)