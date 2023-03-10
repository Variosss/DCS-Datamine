-- Bedford MWD

GT = {};
set_recursive_metatable(GT, GT_t.generic_wheel_vehicle)
set_recursive_metatable(GT.chassis, GT_t.CH_t.BEDFORD);
GT.chassis.life = 2;

GT.visual.shape = "Bedford_MWD"
GT.visual.shape_dstr = "Bedford_MWD_p_1"

GT.IR_emission_coeff = 0.07

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.pos = {0.3, 1.7, 0.4};

GT.AddPropVehicle = {
			{ id = "Tent" , control = 'comboList', wCtrl = 150, label = _('Tent'), defValue = 2, arg = 60,
				values = {
				{ id = 1, dispName = _("Full covered"), value = 0.0},
				{ id = 2, dispName = _("Only body"), value = 0.1},
				{ id = 3, dispName = _("Removed"), value = 0.2}
				}
			}
		}

--chassis
GT.swing_on_run = false


--Burning after hit
GT.visual.fire_size = 0.30 --relative burning size
GT.visual.fire_pos[1] = 1.5 -- center of burn at long axis shift(meters)
GT.visual.fire_pos[2] = 1 -- center of burn shift at vertical shift(meters)
GT.visual.fire_pos[3] = 0 -- center of burn at transverse axis shift(meters)
GT.visual.fire_time = 490 --burning time (seconds)
GT.visual.min_time_agony = 10;
GT.visual.max_time_agony = 130;
GT.visual.agony_explosion_size = 2;

GT.visual.IR = { coeffs = {GT_t.IR_COEFFS_ENGINE_APC, GT_t.IR_COEFFS_WHEELS_Car, {0, 0}, GT_t.IR_COEFFS_BODY, {0.15, 0.15/500}}}

GT.driverViewConnectorName = {"POINT_DRIVER", offset = {0.0, 0.0, 0.0}}
GT.driverCockpit = "DriverCockpit/DriverCockpit"

GT.Name = "Bedford_MWD"
GT.DisplayName = _("Truck Bedford MWD")
GT.DisplayNameShort = _("Bedford")
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
GT.Countries = ALIES
GT.InternalCargo = {
			nominalCapacity = 1000,
			maximalCapacity = 1000, --максимальный объем, который может вместить в усл. ед., складываются все transportable.size
		}