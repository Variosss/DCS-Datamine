-- Flak 18

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 2;

GT.visual.shape = "flak18";
GT.visual.shape_dstr = "flak18_p_1";
GT.animation_arguments.alarm_state = -1;

GT.IR_emission_coeff = 0.01

GT.AddPropVehicle = {
			{ id = "Shield" , control = 'checkbox', label = _('Shield'), boolean_inverted = false, defValue = false, arg=60} -- boolean_inverted = true by default: element present - argVal=0, absent - argVal=1
		}

--chassis

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 2.0;

--Burning after hit
GT.visual.fire_size = 0; --relative burning size
GT.visual.fire_time = 0; --burning time (seconds)
GT.visual.max_time_agony = 0;
GT.visual.agony_explosion_size = 0.1;

GT.visual.IR = { coeffs = {{0.0, 0.0}, GT_t.IR_COEFFS_ROLLERS_IFV, GT_t.IR_COEFFS_100mm, {0.0, 0.0}, {0.27, 0.27/550}}}

-- weapon systems
GT.WS = {};
GT.WS.maxTargetDetectionRange = 16000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.Flak18);
GT.WS[ws].center = "CENTER_POINT_01"
GT.WS[ws].LN[1].BR = { {connector_name = "POINT_GUN_01", 
						recoilArgument = 23, 
						recoliTime = 0.4, 
						muzzleBrakeType = 2, 
						reloadArgument = 70,} 
					}
GT.WS[ws].LN[1].depends_on_unit = {{{"KDO_Mod40", 2}}, {{"none"}}}

GT.Name = "flak18";
GT.DisplayName = _("AAA 8,8cm Flak 18");
GT.DisplayNameShort = _("Flak18");
GT.Rate = 4;

--GT.Sensors = { OPTIC = {"long-range air defence optics"}, };

GT.DetectionRange  = 0;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.airWeaponDist = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000015";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Gun,WSTYPE_PLACEHOLDER,
                "AA_flak",
                "Static AAA",
                };
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"AAA",
}
GT.Countries = AXIS