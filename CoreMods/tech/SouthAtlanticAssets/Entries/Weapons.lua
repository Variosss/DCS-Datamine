-- Mount Model Files
--mount_vfs_model_path (current_mod_path.."/Shapes/Weapons")

-- Mount Textures
mount_vfs_texture_path  (current_mod_path.."/Textures/Weapons")


--Declaring Wepaons
local mk46torp_name = 'MK46 Torpedo'
local mk46torp_mass = 231.0  -- Set Correctly
local mk46torp_warhead =
{
    mass                 = 44,    -- Set Correctly 
    caliber              = 324,   -- Set Correctly
    expl_mass            = 44,    -- Set Correctly
    piercing_mass        = 30,
    fantom               = 1.0,
    other_factors        = { 4.0, 4.0, 4.0 },
    concrete_factors     = { 8.0, 8.0, 20.0 },
    concrete_obj_factor  = 8.0,
    obj_factors          = { 8.0, 8.0 },
    cumulative_factor    = 4.0,
    cumulative_thickness = 0.5,
    time_self_destruct   = 1200,
}
mk46torp = {}

local mk46torp_guided = false

if mk46torp_guided then

    mk46torp = {
        category        = CAT_TORPEDOES,
        name            = "mk46torp_name",
        user_name       = (mk46torp_name),
        scheme          = "guided_torpedo",
        class_name      = "wAmmunition",
        model           = "mk46torp",
        mass            = mk46torp_mass,

        wsTypeOfWeapon  = {wsType_Weapon,wsType_Torpedo,wsType_A_Torpedo,WSTYPE_PLACEHOLDER},

        Head_Type    = 0,
        Diam         = 324.0,
        D_max        = 40000.0,
        D_min        = 200.0,
        V_min        = -1.0,
        V_max        = 320.0,
        H_max        = 3.0,
        H_min        = -100.0,
        Life_Time    = 1800.0,
        Nr_max       = 4.0,
        v_mid        = 40.0,

        shape_table_data =
        {
            {
                name        = "mk46torp",
                file        = 'mk46torp',
                life        = 1,
                fire        = {0, 1},
                username    = ("mk46torp"),
                index       = WSTYPE_PLACEHOLDER,
            },
        },

        fm = {
            mass            = mk46torp_mass,
            caliber         = 0.533,
            cx_coeff        = {1,0.39,0.38,0.236,1.31},
            L               = 7.186,
            I               = 1 / 12 * mk46torp_mass * 7.186 * 7.186,
            Ma              = 0.2,
            Mw              = 0.4,
            wind_sigma      = 0.0,
            wind_time       = 0.0,
            Sw              = 0.5,
            dCydA           = {0.07, 0.036},
            A               = 0.5,
            maxAoa          = 0.3,
            finsTau         = 0.02,
            Ma_x            = 0.1,
            Kw_x            = 0.0005,
            calcAirFins     = 0,
            fins_val_div    = 10000,
            rho_w           = 515,
            int_rho_y       = 1.8,
            Sww             = 0.5,
            splash_time     = 0.5,
            splash_dt       = 0.004,
        },

        autopilot =
        {
            delay                   = 2.0,
            Kpv                     = 0.03,
            Kdv                     = 0.0,
            Kiv                     = 0.00002,
            Kph                     = 20.5,     --28.0
            Kdh                     = 3.0,
            Kih                     = 0.0,

            steady_depth            = 15.0,
            hKp_err_croll           = 0.0,
            roll_diff_correction    = 1,
            fins_limit              = 0.25,
            x_fins_limit            = 0.0,
            vel_proj_div            = 10.0,
            v_vel_limit             = 25.0,

            air_ctrl                = 1,
            hor_ctrl                = 1,

            hor_spir_on_time        = 350,
            hor_spir_period         = 30,
            hor_spir_power          = 0.4,
        },

        engine =
        {
            thrust = 9900,
        },

        warhead        = mk46torp_warhead,
        warhead_water  = mk46torp_warhead,
    }

else

    mk46torp = {
        category        = CAT_TORPEDOES,
        name            = "mk46torp_name",
        user_name       = _(mk46torp_name),
        scheme          = "unguided_torpedo",
        class_name      = "wAmmunition",
        model           = "mk46torp",
        mass            = mk46torp_mass,

        wsTypeOfWeapon  = {wsType_Weapon,wsType_Torpedo,wsType_S_Torpedo,WSTYPE_PLACEHOLDER},

        Head_Type    = 0,
        Diam         = 533.0,
        D_max        = 20000.0,
        D_min        = 100.0,
        V_min        = -1.0,
        V_max        = 320.0,
        H_max        = 3.0,
        H_min        = -100.0,
        Life_Time    = 1800.0,
        Nr_max       = 4.0,
        v_mid        = 40.0,

        shape_table_data =
        {
            {
                name        = "mk46torp",
                file        = 'mk46torp',
                life        = 1,
                fire        = { 0, 1},
                username    = ("mk46torp"),
                index       = WSTYPE_PLACEHOLDER,
            },
        },

        fm = {
            mass            = mk46torp_mass,
            caliber         = 0.533,
            cx_coeff        = {1,0.39,0.38,0.236,1.31},
            L               = 7.186,
            I               = 1 / 12 * mk46torp_mass * 7.186 * 7.186,
            Ma              = 0.2,
            Mw              = 0.4,
            wind_sigma      = 0.0,
            wind_time       = 0.0,
            Sw              = 0.5,
            dCydA           = {0.07, 0.036},
            A               = 0.5,
            maxAoa          = 0.3,
            finsTau         = 0.02,
            Ma_x            = 0.1,
            Kw_x            = 0.0005,
            calcAirFins     = 0,
            fins_val_div    = 10000,
            rho_w           = 515,
            int_rho_y       = 1.8,
            Sww             = 0.5,
            splash_time     = 1.4,
            splash_dt       = 0.004,
        },

        autopilot =
        {
            delay                   = 2.0,
            Kpv                     = 0.03,
            Kdv                     = 0.0,
            Kiv                     = 0.00002,
            Kph                     = 20.5,
            Kdh                     = 3.0,
            Kih                     = 0.0,

            steady_depth            = 5.0,
            hKp_err_croll           = 0.0,
            roll_diff_correction    = 1,
            fins_limit              = 0.25,
            x_fins_limit            = 0.0,
            vel_proj_div            = 10.0,
            v_vel_limit             = 25.0,

            hor_spir_on_time        = 350,
            hor_spir_period         = 30,
            hor_spir_power          = 0.4,
        },

        engine =
        {
            thrust = 9900,
        },

        warhead        = mk46torp_warhead,
        warhead_water  = mk46torp_warhead,
    }

end

declare_weapon(mk46torp)

declare_loadout({
    category         = CAT_TORPEDOES,
    CLSID            = "DIS_mk46torp",
    attribute        = mk46torp.wsTypeOfWeapon,
    Count            = 1,
    Cx_pil           = 0.0018,
    Picture          = "agm84a.png",
    displayName      = mk46torp.user_name,
    Weight           = mk46torp.mass,
    Elements         = {{ShapeName = "mk46torp"}},
})