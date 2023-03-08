-- Bofors 40 mm

GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 1.5;

GT.visual.shape = "bofors40";
GT.visual.shape_dstr = "bofors40_p_1";
GT.animation_arguments.alarm_state = -1;

GT.IR_emission_coeff = 0.01

--chassis

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 1.736;

--Burning after hit
GT.visual.fire_size = 0; --relative burning size
GT.visual.fire_time = 0; --burning time (seconds)
GT.visual.max_time_agony = 0;
GT.visual.agony_explosion_size = 0.1;

GT.visual.IR = { coeffs = {{0.0, 0.0}, GT_t.IR_COEFFS_ROLLERS_IFV, GT_t.IR_COEFFS_50mm, {0.0, 0.0}, {0.27, 0.27/550}}}

-- weapon systems
GT.WS = {};
GT.WS.maxTargetDetectionRange = 10000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
set_recursive_metatable(GT.WS[ws], GT_t.WS_t.Bofors_40mm);
GT.WS[ws].pointer = 'POINT_GUN';
GT.WS[ws].cockpit = {"genericAAA", {-1.0, 0.4, 0.0}, open = true}
GT.WS[ws].center = 'CENTER_POINT_01'
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].reference_angle_Y = math.rad(180)
GT.WS[ws].reference_angle_Z = math.rad(10)
GT.WS[ws].LN[1].BR[1].connector_name = "POINT_GUN"
GT.WS[ws].LN[1].BR[1].recoilArgument = 23
GT.WS[ws].LN[1].sightMasterMode = 1;
GT.WS[ws].LN[1].sightIndicationMode = 1;

GT.Name = "bofors40"
GT.DisplayName = _("AAA 40mm Bofors");
GT.DisplayNameShort = _("Bofors");
GT.Rate = 3;

GT.DetectionRange  = 0;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000015";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Gun,ZU_23,
                "AA_flak",
                "Static AAA",
                };
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"AAA",
}
GT.Countries = ALIES