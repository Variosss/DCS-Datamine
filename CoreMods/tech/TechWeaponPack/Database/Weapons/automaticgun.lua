--------------------------------
-- type values:
-- 3 - AA autocannons
-- 9 - machineguns up to 12.7 (.50) - high priority targets are infantry, nonarmored units
-- 10 - AA machineguns - high priority targets are aircrafts, helicopters, light armored units
-- 12 - AG autocannons

def_mg_LN = {
    type = 9, --machinegun
    distanceMin = 0,
    reactionTime = 0.5,
    reflection_limit = 0.22,
    connectorFire = true,
    sensor = {},
    PL = {},
}
set_recursive_metatable(def_mg_LN.sensor, GT_t.WSN_t[1]);

-- Launchers
--
-- german 7.92 machinegun for Tiger I
GT_t.LN_t.machinegun_MG34 = {name = _("MG34")}
set_recursive_metatable(GT_t.LN_t.machinegun_MG34, def_mg_LN);
GT_t.LN_t.machinegun_MG34.distanceMax = 1100
GT_t.LN_t.machinegun_MG34.max_trg_alt = 600
GT_t.LN_t.machinegun_MG34.PL[1] = {};
GT_t.LN_t.machinegun_MG34.PL[1].switch_on_delay = 15;
GT_t.LN_t.machinegun_MG34.PL[1].ammo_capacity = 200;
GT_t.LN_t.machinegun_MG34.PL[1].portionAmmoCapacity = 200;
GT_t.LN_t.machinegun_MG34.PL[1].shell_name = {"7_92x57_Smkl", "7_92x57sS", "7_92x57sS", "7_92x57sS"};
GT_t.LN_t.machinegun_MG34.PL[1].shell_display_name = "7.92x57"
GT_t.LN_t.machinegun_MG34.PL[1].shot_delay = 60/850;
GT_t.LN_t.machinegun_MG34.PL[1].reload_time = 15;
GT_t.LN_t.machinegun_MG34.BR = { {pos = {1.2, 0, 0} } }


-- .30 cal Browning M1919
GT_t.LN_t.Browning_M1919 = {name = _("Browning .30 cal")}
set_recursive_metatable(GT_t.LN_t.Browning_M1919, def_mg_LN);
GT_t.LN_t.Browning_M1919.distanceMax = 1100
GT_t.LN_t.Browning_M1919.max_trg_alt = 600
GT_t.LN_t.Browning_M1919.PL[1] = {};
GT_t.LN_t.Browning_M1919.PL[1].switch_on_delay = 15;
GT_t.LN_t.Browning_M1919.PL[1].ammo_capacity = 250;
GT_t.LN_t.Browning_M1919.PL[1].portionAmmoCapacity = 250;
GT_t.LN_t.Browning_M1919.PL[1].shell_name = {"Br303_tr", "Br303", "Br303", "Br303"};
GT_t.LN_t.Browning_M1919.PL[1].shell_display_name = _(".303 British")
GT_t.LN_t.Browning_M1919.PL[1].shot_delay = 60/500;
GT_t.LN_t.Browning_M1919.PL[1].reload_time = 15;
GT_t.LN_t.Browning_M1919.BR = { {pos = {1.2, 0, 0} } }

-- Bofors 40mm gun
GT_t.LN_t.Bofors_40mm = {name = _("Bofors 40mm gun")}
set_recursive_metatable(GT_t.LN_t.Bofors_40mm, def_mg_LN);
GT_t.LN_t.Bofors_40mm.type = 3;
set_recursive_metatable(GT_t.LN_t.Bofors_40mm.sensor, GT_t.WSN_t[3]);
GT_t.LN_t.Bofors_40mm.distanceMax = 4000
GT_t.LN_t.Bofors_40mm.max_trg_alt = 3000
GT_t.LN_t.Bofors_40mm.reflection_limit = 1.1
GT_t.LN_t.Bofors_40mm.reactionTime = 2.0
GT_t.LN_t.Bofors_40mm.PL[1] = {};
GT_t.LN_t.Bofors_40mm.PL[1].switch_on_delay = 1;
GT_t.LN_t.Bofors_40mm.PL[1].ammo_capacity = 200;
GT_t.LN_t.Bofors_40mm.PL[1].portionAmmoCapacity = 200;
GT_t.LN_t.Bofors_40mm.PL[1].shell_name = {"Bofors_40mm_HE"};
GT_t.LN_t.Bofors_40mm.PL[1].shell_display_name = _("Bofors_40mm_HE")
GT_t.LN_t.Bofors_40mm.PL[1].shot_delay = 60/120;
GT_t.LN_t.Bofors_40mm.PL[1].reload_time = 1200;
GT_t.LN_t.Bofors_40mm.BR = { {pos = {1.2, 0, 0}, recoilTime = 0.47 } }
-- Bofors 40mm gun WS
GT_t.WS_t.Bofors_40mm = {
	angles = {{math.rad(180), math.rad(-180), math.rad(-10), math.rad(89.9)}},
	omegaY = math.rad(60),
	omegaZ = math.rad(60),
	pidY = GT_t.AAA_PIDY,
	pidZ = GT_t.AAA_PIDZ
}
add_launcher(GT_t.WS_t.Bofors_40mm, GT_t.LN_t.Bofors_40mm);


GT_t.LN_t.AK_725 = {name = "AK_725", display_name = _("AK_725")}; -- used on BDK-775
set_recursive_metatable(GT_t.LN_t.AK_725, def_mg_LN);
GT_t.LN_t.AK_725.type = 3;
GT_t.LN_t.AK_725.distanceMin = 10
GT_t.LN_t.AK_725.distanceMax = 6000
GT_t.LN_t.AK_725.max_trg_alt = 2500
GT_t.LN_t.AK_725.reactionTime = 3
GT_t.LN_t.AK_725.reflection_limit = 0.05;
set_recursive_metatable(GT_t.LN_t.AK_725.sensor, GT_t.WSN_t[5]) 
GT_t.LN_t.AK_725.PL[1] = {}
GT_t.LN_t.AK_725.PL[1].ammo_capacity = 200
GT_t.LN_t.AK_725.PL[1].shell_name = {"53-UOR-281U", "53-UBR-281U"}	-- same on ZSU_57
GT_t.LN_t.AK_725.PL[1].shell_display_name = "57mm AP+HE";
GT_t.LN_t.AK_725.PL[1].shot_delay = 0.5; 
GT_t.LN_t.AK_725.PL[1].reload_time = 900; -- 15 minutes
GT_t.LN_t.AK_725.PL[1].switch_on_delay = 300
local pl_tmpl = GT_t.LN_t.AK_725.PL[1]
for i=2,5 do
	GT_t.LN_t.AK_725.PL[i] = {}
	set_recursive_metatable(GT_t.LN_t.AK_725.PL[i], pl_tmpl)
end
GT_t.LN_t.AK_725.BR = { {pos = {4.275, 0, 0} } }

GT_t.WS_t.BDK_775_AK725 = {name = "AK725", display_name = _("AK725")}; -- AK-725 mounted on BDK-775
GT_t.WS_t.BDK_775_AK725.angles_mech = {
                    {math.rad(180), math.rad(-180), math.rad(-12), math.rad(88),},
                    };
GT_t.WS_t.BDK_775_AK725.omegaY = math.rad(20)
GT_t.WS_t.BDK_775_AK725.omegaZ = math.rad(30)
GT_t.WS_t.BDK_775_AK725.pidY = {p=300, i = 0.05, d = 10.0, inn = 1000};
GT_t.WS_t.BDK_775_AK725.pidZ = {p=300, i = 0.05, d = 10.0, inn = 1000};
GT_t.WS_t.BDK_775_AK725.reference_angle_Z = 0
add_launcher(GT_t.WS_t.BDK_775_AK725, GT_t.LN_t.AK_725);