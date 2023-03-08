-- Blitz 3.6-6700A truck

GT = {};
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle)
set_recursive_metatable(GT.chassis, GT_t.CH_t.BLITZ_36_6700A);

GT.visual.shape = "Blitz_36-6700A"
GT.visual.shape_dstr = "Blitz_36-6700A_p_1"

GT.IR_emission_coeff = 0.75

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.pos = {1.15, 1.73, -0.42};

GT.AddPropVehicle = {
			{ id = "TentedRoof" , control = 'checkbox', label = _('Tented Roof'), defValue = false, arg=60, boolean_inverted = true} -- boolean_inverted = true by default: element present - argVal=0, absent - argVal=1
		}

--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 0.30 --relative burning size
GT.visual.fire_pos[1] = 2.3 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1.2 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 550 --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 130;
GT.visual.agony_explosion_size = 2;

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Truck, {0, 0}, IR_COEFFS_BODY, {0.15, 0.15/500}}}

GT.driverViewConnectorName = {"POINT_DRIVER", offset = {0.0, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpit"

GT.Name = "Blitz_36-6700A"
GT.DisplayName = _("Truck Opel Blitz 3.6-6700A")
GT.DisplayNameShort = _("Blitz")
GT.Rate = 5

GT.DetectionRange  = 0;
GT.ThreatRange = 0;
GT.mapclasskey = "P0091000212";
GT.attribute = {wsType_Ground,wsType_Tank,wsType_NoWeapon,wsType_GenericVehicle,
				"Trucks",
				};
GT.category = "Unarmed";
GT.tags  =
{
    "Unarmed",
	"Support & Logistics",
}
GT.warehouse = true
GT.Countries = AXIS
GT.InternalCargo = {
			nominalCapacity = 1100,
			maximalCapacity = 1100, --максимальный объем, который может вместить в усл. ед., складываются все transportable.size
		}