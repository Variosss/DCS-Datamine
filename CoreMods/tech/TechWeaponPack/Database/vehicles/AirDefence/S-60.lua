-- AAA S-60
GT = {};
GT_t.ws = 0;
set_recursive_metatable(GT, GT_t.generic_stationary);
set_recursive_metatable(GT.chassis, GT_t.CH_t.STATIC);
GT.chassis.life = 1.5;

GT.visual.shape = "S-60_Type59_Artillery";
GT.visual.shape_dstr = "S-60_Type59_Artillery_p_1";
GT.animation_arguments.alarm_state = -1;

GT.sensor = {};
set_recursive_metatable(GT.sensor, GT_t.SN_visual);
GT.sensor.height = 1.736;

--Burning after hit
GT.visual.fire_size = 0; --relative burning size
GT.visual.fire_time = 0; --burning time (seconds)
GT.visual.max_time_agony = 0;
GT.visual.agony_explosion_size = 0.1;

GT.visual.IR = { coeffs = {{0.0, 0.0}, GT_t.IR_COEFFS_WHEELS_Car, GT_t.IR_COEFFS_50mm, {0.0, 0.0}, {0.27, 0.27/550}}}

-- weapon systems

GT.WS = {};
GT.WS.maxTargetDetectionRange = 10000;

local ws = GT_t.inc_ws();
GT.WS[ws] = {};
GT.WS[ws].center = 'CENTER_POINT'
GT.WS[ws].pointer = 'POINT_SIGHT'
GT.WS[ws].cockpit = {"genericAAA", {0.0, 0.0, 0.0}, open = true }
GT.WS[ws].omegaY = math.rad(20);
GT.WS[ws].omegaZ = math.rad(30);
GT.WS[ws].angles = {
					{math.rad(180), math.rad(-180), math.rad(-10), math.rad(88)},
					};
GT.WS[ws].drawArgument1 = 0
GT.WS[ws].drawArgument2 = 1
GT.WS[ws].pidY = GT_t.AAA_PIDY;
GT.WS[ws].pidZ = GT_t.AAA_PIDZ;

--GT.WS[1].LN[1]
__LN = add_launcher(GT.WS[ws], GT_t.LN_t.S_60_gun);
__LN.BR = {
			{connector_name = 'POINT_GUN',
			recoilArgument = 23,
			recoilTime = 0.3, --alternativeRecoil = true,
			}
		  }
__LN.depends_on_unit = {{{"SON_9", 4}}, {{"none"}}}


GT.Name = "S-60_Type59_Artillery";
GT.DisplayName = _("AAA S-60");
GT.DisplayNameShort = _("S-60");
GT.Rate = 3;

GT.Crew = 5;

GT.DetectionRange  = GT.sensor.max_range_finding_target;
GT.ThreatRange = GT.WS[1].LN[1].distanceMax;
GT.mapclasskey = "P0091000015";
GT.attribute = {wsType_Ground,wsType_SAM,wsType_Gun, WSTYPE_PLACEHOLDER,
                "AA_flak",
                "Static AAA",
                };
GT.category = "Air Defence";
GT.tags  =
{
    "Air Defence",
	"AAA",
}
GT.Countries = {"Russia", "USSR", "Syria"}