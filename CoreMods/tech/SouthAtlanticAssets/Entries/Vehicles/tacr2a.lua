-- RAF Rescue

GT = {};
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle)
set_recursive_metatable(GT.chassis, GT_t.CH_t.HMMWV);

GT.visual.shape = "tacr2a"
--GT.visual.shape_dstr = ""

--chassis
GT.swing_on_run = false

--Burning after hit
GT.visual.fire_size = 0.7 --relative burning size
GT.visual.fire_pos[1] = 0 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 0 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 900 --burning time (seconds)

--GT.driverViewPoint = {2.05, 2.25, -0.55};

GT.Name = "tacr2a"
GT.DisplayName = _("RAF Rescue")
GT.Rate = 5

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000005";
GT.attribute = {wsType_Ground,wsType_NoWeapon,wsType_Hummer,WSTYPE_PLACEHOLDER,
				"APC",
				};
GT.category = "Unarmed";
GT.tags =
{   "Unarmed",
    "Support & Logistics",
}
add_surface_unit(GT)