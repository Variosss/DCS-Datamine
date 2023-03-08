-- Setting up model container -------------------------------------------------------------
mount_vfs_model_path  (current_mod_path .. "/Weapons/Shapes")
mount_vfs_texture_path(current_mod_path  .."/Weapons/Textures/UK_bomb_WWII")
-- end of Setting up model container ------------------------------------------------------



-- Defining guns --------------------------------------------------------------------------
    local barrel_smoke_level = 1.0
    local barrel_smoke_opacity = 0.1



    -- TEST GUN ---------------------------------------------------------------------------
    -- [1] = TEST PROJECTILE
    declare_weapon({category = CAT_SHELLS, name = "PINK_PROJECTILE", user_name = _("PINK_PROJECTILE"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "HE",
        mass            = 539.117, -- Bullet mass
        round_mass      = 0.220, -- Assembled shell + link
        cartridge_mass  = 0.056, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.0090,
        payload         = 225.0090,
        payloadEffect   = "Fragmentation",
        payloadMaterial = "TNT",
        v0              = 1000.0,
        Dv0             = 0.0,
        Da0             = 0.0,
        Da1             = 0.0,
        life_time       = 3.5,
        caliber         = 20,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.6, 0.94, 0.65, 0.29, 1.88},
        k1              = 3.3e-08,
        tracer_off      = 3,
        smoke_tail_life_time = 0.7,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
        silent_self_destruction = false,
    })
    -- end of TEST GUN --------------------------------------------------------------------



    -- MG 15 ------------------------------------------------------------------------------
    -- [1] = Cartridge, 7.92x57, S.m.K. - Spitzgeschoss mit Kern
    declare_weapon({category = CAT_SHELLS, name = "Mauser7.92x57_S.m.K.", user_name = _("Mauser7.92x57_S.m.K."),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.0115, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 865.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [2] = Cartridge, 7.92x57, S.m.K.H. - Spitzgeschoss mit Kern, Hart
    declare_weapon({category = CAT_SHELLS, name = "Mauser7.92x57_S.m.K.H.", user_name = _("Mauser7.92x57_S.m.K.H."),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.0115, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 868.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.0,
        caliber         = 6.00,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [3] = Cartridge, 7.92x57, S.m.K. L'spur (gelb) - Spitzgeschoss mit Kern, Leuchtspur (gelb)
    declare_weapon({category = CAT_SHELLS, name = "Mauser7.92x57_S.m.K._L'spur(gelb)", user_name = _("Mauser7.92x57_S.m.K._L'spur(gelb)"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.01015, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 905.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 5.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = 5.0,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [4] = Cartridge, 7.92x57, S.m.K. L'spur (weiss) - Spitzgeschoss mit Kern, Leuchtspur (weiss)
    declare_weapon({category = CAT_SHELLS, name = "Mauser7.92x57_S.m.K._L'spur(weiss)", user_name = _("Mauser7.92x57_S.m.K._L'spur(weiss)"),
        model_name      = "tracer_bullet_white",
        projectile      = "AP",
        mass            = 0.01015, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 905.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 5.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = 5.0,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [5] = Cartridge, 7.92x57, S.m.K. Ub.m.Zerl. - Spitzgeschoss mit Kern Ubungsmunition mit Zerleger
    declare_weapon({category = CAT_SHELLS, name = "Mauser7.92x57_S.m.K._Ub.m.Zerl.", user_name = _("Mauser7.92x57_S.m.K._Ub.m.Zerl."),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.0115, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0,
        payload         = 0.0005,
        payloadEffect   = "Concussion",
        payloadMaterial = "Amatol",
        v0              = 865.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 1.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
        silent_self_destruction = false,
    })

    -- [6] = Cartridge, 7.92x57, P.m.K. - Phosphor mit Stahlkern
    declare_weapon({category = CAT_SHELLS, name = "Mauser7.92x57_P.m.K.", user_name = _("Mauser7.92x57_P.m.K."),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.01015, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0,
        payload         = 0.0005,
        payloadEffect   = "Thermal",
        payloadMaterial = "Phosphor",
        v0              = 905.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 4.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
        silent_self_destruction = true,
    })

    -- [7] = Cartridge, 7.92x57, B. - Beobachtung
    declare_weapon({category = CAT_SHELLS, name = "Mauser7.92x57_B.", user_name = _("Mauser7.92x57_B."),
        model_name      = "tracer_bullet_yellow",
        projectile      = "HE",
        mass            = 0.01085, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0,
        payload         = 0.0005,
        payloadEffect   = "Concussion",
        payloadMaterial = "Amatol",
        v0              = 855.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 4.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
        silent_self_destruction = true,
    })

    -- MG 15
    function MG_15 ( tbl )
        tbl.category = CAT_GUN_MOUNT
        tbl.name = "MG_15"
        tbl.display_name = _("MG 15")
        tbl.supply = {
            shells = {
                --[[ 1 ]]   "Mauser7.92x57_S.m.K.",
                --[[ 2 ]]   "Mauser7.92x57_S.m.K.H.",
                --[[ 3 ]]   "Mauser7.92x57_S.m.K._L'spur(gelb)",
                --[[ 4 ]]   "Mauser7.92x57_S.m.K._L'spur(weiss)",
                --[[ 5 ]]   "Mauser7.92x57_S.m.K._Ub.m.Zerl.",
                --[[ 6 ]]   "Mauser7.92x57_P.m.K.",
                --[[ 7 ]]   "Mauser7.92x57_B.",
            },
            mixes = {{1, 1, 1, 1, 1, 1, 1, 1, 1, 3}},
            count = 75,
        }
        if tbl.mixes then
            tbl.supply.mixes = tbl.mixes
            tbl.mixes = nil
        end
        if tbl.count then
            tbl.supply.count = tbl.count
            tbl.count = nil
        end
        tbl.gun = {
            max_burst_length = 75,
            rates = {1000}, -- unsynchronized mount
            recoil_coeff = 1.0,
            barrels_count = 1,
        }
        if tbl.rates then
            tbl.gun.rates = tbl.rates
            tbl.rates = nil
        end
        tbl.ejector_pos = tbl.ejector_pos or {0.0, 0.05, 0.0}
        tbl.ejector_dir = tbl.ejector_dir or {0, -1, 0}
        --tbl.effect_arg_number = tbl.effect_arg_number or 436
        tbl.supply_position = tbl.supply_position or {0, 0.3, -0.3}
        tbl.aft_gun_mount = false
        tbl.effective_fire_distance = 1000
        --tbl.drop_cartridge = 0 -- 204
        tbl.muzzle_pos = {0, 0, 0} -- all position from connector
        tbl.azimuth_initial = tbl.azimuth_initial or 0
        tbl.elevation_initial = tbl.elevation_initial or 0
        --if tbl.effects == nil then
        --    tbl.effects = {synchronizer, {name = "FireEffect", arg = tbl.effect_arg_number or 436}, {name = "HeatEffectExt", shot_heat = 4.103, barrel_k = 0.462 * 3.7, body_k = 0.462 * 14.3}, {name = "SmokeEffect"}}
        --end

        return declare_weapon(tbl)
    end
    -- end of MG 15 -----------------------------------------------------------------------



    -- MG 81 ------------------------------------------------------------------------------

    -- MG 81
    function MG_81 ( tbl )
        tbl.category = CAT_GUN_MOUNT
        tbl.name = "MG_81"
        tbl.display_name = _("MG 81")
        tbl.supply = {
            shells = {
                --[[ 1 ]]   "Mauser7.92x57_S.m.K.",
                --[[ 2 ]]   "Mauser7.92x57_S.m.K.H.",
                --[[ 3 ]]   "Mauser7.92x57_S.m.K._L'spur(gelb)",
                --[[ 4 ]]   "Mauser7.92x57_S.m.K._L'spur(weiss)",
                --[[ 5 ]]   "Mauser7.92x57_S.m.K._Ub.m.Zerl.",
                --[[ 6 ]]   "Mauser7.92x57_P.m.K.",
                --[[ 7 ]]   "Mauser7.92x57_B.",
            },
            mixes = {{1, 1, 1, 3, 6, 7, 1, 4}},
            count = 750,
        }
        if tbl.mixes then
            tbl.supply.mixes = tbl.mixes
            tbl.mixes = nil
        end
        if tbl.count then
            tbl.supply.count = tbl.count
            tbl.count = nil
        end
        tbl.gun = {
            max_burst_length = 65535,
            rates = {1500}, -- unsynchronized mount
            recoil_coeff = 1.0,
            barrels_count = 1,
        }
        if tbl.rates then
            tbl.gun.rates = tbl.rates
            tbl.rates = nil
        end
        tbl.ejector_pos = tbl.ejector_pos or {0.0, 0.05, 0.0}
        tbl.ejector_dir = tbl.ejector_dir or {0, -1, 0}
        --tbl.effect_arg_number = tbl.effect_arg_number or 436
        tbl.supply_position = tbl.supply_position or {0, 0.3, -0.3}
        tbl.aft_gun_mount = false
        tbl.effective_fire_distance = 1000
        --tbl.drop_cartridge = 0 -- 204
        tbl.muzzle_pos = {0, 0, 0} -- all position from connector
        tbl.azimuth_initial = tbl.azimuth_initial or 0
        tbl.elevation_initial = tbl.elevation_initial or 0
        --if tbl.effects == nil then
        --    tbl.effects = {synchronizer, {name = "FireEffect", arg = tbl.effect_arg_number or 436}, {name = "HeatEffectExt", shot_heat = 4.103, barrel_k = 0.462 * 3.7, body_k = 0.462 * 14.3}, {name = "SmokeEffect"}}
        --end

        return declare_weapon(tbl)
    end
    -- end of MG 81 -----------------------------------------------------------------------



    -- MG 131 -----------------------------------------------------------------------------
    -- [1] = MG_13x64_APT (x25)
    declare_weapon({category = CAT_SHELLS, name = "MG_13x64_APT", user_name = _("MG_13x64_APT"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.038, -- Bullet mass
        round_mass      = 0.076 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.031 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 710.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 7.0,
        caliber         = 13,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 1.03, 0.5, 0.38, 2},
        k1              = 5.0e-08,
        tracer_off      = 2,
        smoke_tail_life_time = 0.5,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [2] = MG_13x64_API (Ph) (x28)
    declare_weapon({category = CAT_SHELLS, name = "MG_13x64_API", user_name = _("MG_13x64_API"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.038, -- Bullet mass
        round_mass      = 0.076 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.031 + 0.009, -- Empty shell (+ link if links are stored as well)
        payload         = 0.001,
        payloadEffect   = "Thermal",
        payloadMaterial = "Phosphor",
        v0              = 710.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 7.0,
        caliber         = 13,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 1.03, 0.5, 0.38, 2},
        k1              = 5.0e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [3] = MG_13x64_HEI_T (x27)
    declare_weapon({category = CAT_SHELLS, name = "MG_13x64_HEI_T", user_name = _("MG_13x64_HEI_T"),
        model_name      = "tracer_bullet_white",
        projectile      = "HE",
        mass            = 0.034, -- Bullet mass
        round_mass      = 0.074 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.031 + 0.009, -- Empty shell (+ link if links are stored as well)
        payload         = 0.0013,
        payloadEffect   = "Concussion",
        payloadMaterial = "PETN",
        v0              = 750.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 7.0,
        caliber         = 13,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.912, 0.7, 0.25, 1.80},
        k1              = 4.3e-08,
        tracer_off      = 1.7,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [4] = MG_13x64_I (x19)
    declare_weapon({category = CAT_SHELLS, name = "MG_13x64_I", user_name = _("MG_13x64_I"),
        model_name      = "tracer_bullet_white",
        projectile      = "HE",
        mass            = 0.032, -- Bullet mass
        round_mass      = 0.067 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.031 + 0.009, -- Empty shell (+ link if links are stored as well)
        payload         = 0.0025,
        payloadEffect   = "Thermal",
        payloadMaterial = "Thermite",
        v0              = 770.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 7.0,
        caliber         = 13,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.912, 0.7, 0.25, 1.80},
        k1              = 5.1e-08,
        tracer_off      = 1.7,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [5] = MG_13x64_I_T (x20)
    declare_weapon({category = CAT_SHELLS, name = "MG_13x64_I_T", user_name = _("MG_13x64_I_T"),
        model_name      = "tracer_bullet_white",
        projectile      = "HE",
        mass            = 0.032, -- Bullet mass
        round_mass      = 0.067 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.031 + 0.009, -- Empty shell (+ link if links are stored as well)
        payload         = 0.0025,
        payloadEffect   = "Thermal",
        payloadMaterial = "Thermite",
        v0              = 770.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 7.0,
        caliber         = 13,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.912, 0.7, 0.25, 1.80},
        k1              = 5.1e-08,
        tracer_off      = 1.7,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [6] = MG_13x64_HE (x21)
    declare_weapon({category = CAT_SHELLS, name = "MG_13x64_HE", user_name = _("MG_13x64_HE"),
        model_name      = "tracer_bullet_white",
        projectile      = "HE",
        mass            = 0.034, -- Bullet mass
        round_mass      = 0.074 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.031 + 0.009, -- Empty shell (+ link if links are stored as well)
        payload         = 0.0018,
        payloadEffect   = "Concussion",
        payloadMaterial = "PETN",
        v0              = 750.0,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 7.0,
        caliber         = 13,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.912, 0.7, 0.25, 1.80},
        k1              = 4.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- MG 131
    function MG_131 ( tbl )
        tbl.category = CAT_GUN_MOUNT
        tbl.name = "MG_131"
        tbl.display_name = _("MG 131")
        tbl.supply = {
            shells = {
                --[[ 1 ]]   "MG_13x64_APT",
                --[[ 2 ]]   "MG_13x64_API",
                --[[ 3 ]]   "MG_13x64_HEI_T",
                --[[ 4 ]]   "MG_13x64_I",
                --[[ 5 ]]   "MG_13x64_I_T",
                --[[ 6 ]]   "MG_13x64_HE",
            },
            mixes = {{1, 6, 1, 2, 3}},
            count = 450,
        }
        if tbl.mixes then
            tbl.supply.mixes = tbl.mixes
            tbl.mixes = nil
        end
        if tbl.count then
            tbl.supply.count = tbl.count
            tbl.count = nil
        end
        tbl.gun = {
            max_burst_length = 65535,
            rates = {900}, -- unsynchronized mount
            recoil_coeff = 1.0,
            barrels_count = 1,
        }
        if tbl.rates then
            tbl.gun.rates = tbl.rates
            tbl.rates = nil
        end
        tbl.ejector_pos = tbl.ejector_pos or {0.0, 0.05, 0.0}
        tbl.ejector_dir = tbl.ejector_dir or {0, -1, 0}
        --tbl.effect_arg_number = tbl.effect_arg_number or 436
        tbl.supply_position = tbl.supply_position or {0, 0.3, -0.3}
        tbl.aft_gun_mount = false
        tbl.effective_fire_distance = 1000
        --tbl.drop_cartridge = 0 -- 204
        tbl.muzzle_pos = {0, 0, 0} -- all position from connector
        tbl.azimuth_initial = tbl.azimuth_initial or 0
        tbl.elevation_initial = tbl.elevation_initial or 0
        --if tbl.effects == nil then
        --    tbl.effects = {synchronizer, {name = "FireEffect", arg = tbl.effect_arg_number or 436}, {name = "HeatEffectExt", shot_heat = 4.103, barrel_k = 0.462 * 3.7, body_k = 0.462 * 14.3}, {name = "SmokeEffect"}}
        --end

        return declare_weapon(tbl)
    end
    -- end of MG 131 ----------------------------------------------------------------------



    -- MG 151/20 --------------------------------------------------------------------------
    -- [1] = 113-1945 Brsprgr. Patr. L'spur El. m. Zerl
    declare_weapon({category = CAT_SHELLS, name = "MG_20x82_HEI_T", user_name = _("MG_20x82_HEI_T"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "HE",
        mass            = 0.117, -- Bullet mass
        round_mass      = 0.220, -- Assembled shell + link
        cartridge_mass  = 0.056, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.0090,
        payload         = 0.0090,
        payloadEffect   = "Concussion",
        payloadMaterial = "TNT",
        v0              = 720.0,
        Dv0             = 0.0080,
        Da0             = 0.0006,
        Da1             = 0.0,
        life_time       = 3.5,
        caliber         = 20,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.6, 0.94, 0.65, 0.29, 1.88},
        k1              = 3.3e-08,
        tracer_off      = 3,
        smoke_tail_life_time = 0.7,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
        silent_self_destruction = true,
    })

    -- [2] = 113-1946 Pzgr. Patr. 151 El. o. Zerl
    declare_weapon({category = CAT_SHELLS, name = "MG_20x82_API", user_name = _("MG_20x82_API"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.117, -- Bullet mass
        round_mass      = 0.220, -- Assembled shell + link
        cartridge_mass  = 0.056, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0,
        payload         = 0.0010,
        payloadEffect   = "Thermal",
        payloadMaterial = "Thermite",
        v0              = 720.0,
        Dv0             = 0.0080,
        Da0             = 0.0006,
        Da1             = 0.0,
        life_time       = 7.0,
        caliber         = 20,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.3, 0.93, 0.55, 0.36, 1.8},
        k1              = 3.6e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
        silent_self_destruction = true,
    })

    -- [3] = 113-1979 M-Gsch. Patr. 151 El. m. Zerl
    declare_weapon({category = CAT_SHELLS, name = "MG_20x82_MGsch", user_name = _("MG_20x82_MGsch"),
        model_name      = "tracer_bullet_white",
        projectile      = "HE",
        mass            = 0.092, -- Bullet mass
        round_mass      = 0.190, -- Assembled shell + link
        cartridge_mass  = 0.056, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.0350,
        payload         = 0.0190,
        payloadEffect   = "Concussion",
        payloadMaterial = "PETN",
        v0              = 790.0,
        Dv0             = 0.0080,
        Da0             = 0.0006,
        Da1             = 0.0,
        life_time       = 3.0,
        caliber         = 20,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 1.22, 0.3, 0.36, 1.9},
        k1              = 5.2e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
        silent_self_destruction = true,
    })

    -- MG 151 / 20
    function MG_151_20 ( tbl )
        tbl.category = CAT_GUN_MOUNT 
        tbl.name = "MG_151_20"
        tbl.display_name = _("MG 151/20")
        tbl.supply = {
            shells = {
                --[[ 1 ]]   "MG_20x82_HEI_T",
                --[[ 2 ]]   "MG_20x82_API",
                --[[ 3 ]]   "MG_20x82_MGsch",
            },
            mixes = {{1, 2, 3, 1, 2, 3}},
            count = 250,
        }
        if tbl.mixes then
            tbl.supply.mixes = tbl.mixes
            tbl.mixes = nil
        end
        if tbl.count then
            tbl.supply.count = tbl.count
            tbl.count = nil
        end
        tbl.gun = {
            max_burst_length = 65535,
            rates = {700}, -- unsynchronized mount
            recoil_coeff = 1.0,
            barrels_count = 1,
        }
        if tbl.rates then
            tbl.gun.rates = tbl.rates
            tbl.rates = nil
        end
        tbl.ejector_pos = tbl.ejector_pos or {0.0, 0.05, 0.0}
        tbl.ejector_dir = tbl.ejector_dir or {0, -1, 0}
        tbl.supply_position = tbl.supply_position or {0, -0.3, -1.5}
        tbl.aft_gun_mount = false
        tbl.effective_fire_distance = 1000
        --tbl.drop_cartridge = 204
        tbl.muzzle_pos = {0, 0, 0} -- all position from connector
        tbl.azimuth_initial = tbl.azimuth_initial or 0
        tbl.elevation_initial = tbl.elevation_initial or 0
        --tbl.effects = {
        --    synchronizer,
        --    {name = "FireEffect", arg = tbl.effect_arg_number or 436},
        --    {name = "HeatEffectExt", shot_heat = 20.9, barrel_k = 0.462 * 16.6, body_k = 0.462 * 35.4},
        --    {name = "SmokeEffect"}
        --}

        return declare_weapon(tbl)
    end
    -- end of MG 151/20 -------------------------------------------------------------------



    -- MK 108 -----------------------------------------------------------------------------
    -- [1] = 3 cm M-Gesch. Patr. 108 m. Zerl Ausf. A
    declare_weapon({category = CAT_SHELLS, name = "MK_108_MGsch", user_name = _("MK_108_MGsch"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "HE",
        mass            = 0.330, -- Bullet mass
        round_mass      = 0.470 + 0.110, -- Assembled shell + link
        cartridge_mass  = 0.125 + 0.110, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.1275,
        payload         = 0.0850,
        payloadEffect   = "Concussion",
        payloadMaterial = "PETN",
        v0              = 500.0,
        Dv0             = 0.008,
        Da0             = 0.0004,
        Da1             = 0.0,
        life_time       = 4.0,
        caliber         = 30,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.5, 0.99, 0.36, 0.55, 1.8},
        k1              = 4.9e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [2] = 3 cm M-Gesch. Patr. L.Spur 108 m. Zerl
    declare_weapon({category = CAT_SHELLS, name = "MK_108_MGsch_T", user_name = _("MK_108_MGsch_T"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "HE",
        mass            = 0.330, -- Bullet mass
        round_mass      = 0.470 + 0.110, -- Assembled shell + link
        cartridge_mass  = 0.125 + 0.110, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.1275,
        payload         = 0.0850,
        payloadEffect   = "Concussion",
        payloadMaterial = "PETN",
        v0              = 500.0,
        Dv0             = 0.008,
        Da0             = 0.0004,
        Da1             = 0.0,
        life_time       = 4.0,
        caliber         = 30,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.5, 0.66, 0.25, 1.7},
        k1              = 2.2e-08,
        tracer_off      = 2.7,
        smoke_tail_life_time = 2.7,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [3] = 3 cm Brgr. Patr. 108 m. Zerl
    declare_weapon({category = CAT_SHELLS, name = "MK_108_HEI", user_name = _("MK_108_HEI"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "HE",
        mass            = 0.370, -- Bullet mass
        round_mass      = 0.470 + 0.110, -- Assembled shell + link
        cartridge_mass  = 0.125 + 0.110, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.0360,
        payload         = 0.0360,
        payloadEffect   = "Concussion",
        payloadMaterial = "TNT",
        v0              = 485.0,
        Dv0             = 0.008, -- медиан относительного разброса скорости - [v0-V0*Dv0, v0+v0*Dv0] содержит 50% скоростей
        Da0             = 0.0004,
        Da1             = 0.0,
        life_time       = 4.0,
        caliber         = 30,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.2, 0.72, 0.6, 0.62, 1.4},
        k1              = 4.8e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- MK 108
    function MK_108 ( tbl )
        tbl.category = CAT_GUN_MOUNT
        tbl.name = "MK_108"
        tbl.display_name = _("MK 108")
        tbl.supply = {
            shells = {
                --[[ 1 ]]   "MK_108_MGsch",
                --[[ 2 ]]   "MK_108_MGsch_T",
                --[[ 3 ]]   "MK_108_HEI",
            },
            mixes = {{2, 2}},
            count = 60,
        }
        if tbl.mixes then
            tbl.supply.mixes = tbl.mixes
            tbl.mixes        = nil
        end
        if tbl.count then
            tbl.supply.count = tbl.count
            tbl.count = nil
        end
        tbl.gun = {
            max_burst_length = 65535,
            rates = {660}, -- unsynchronized mount
            recoil_coeff = 1.0,
            barrels_count = 1,
        }
        if tbl.rates then
            tbl.gun.rates = tbl.rates
            tbl.rates = nil
        end
        tbl.ejector_pos = tbl.ejector_pos or {0.0, 0.05, 0.0}
        tbl.ejector_dir = {0, -1, 0}
        --tbl.effect_arg_number = tbl.effect_arg_number or 436
        tbl.supply_position = tbl.supply_position or {0, -0.3, -1.5}
        tbl.aft_gun_mount = false
        tbl.effective_fire_distance = 1000
        --tbl.drop_cartridge = 0 -- 204
        tbl.muzzle_pos = {0, 0, 0} -- all position from connector
        tbl.azimuth_initial = tbl.azimuth_initial or 0
        tbl.elevation_initial = tbl.elevation_initial or 0

        return declare_weapon(tbl)
    end
    -- end of MK 108 ----------------------------------------------------------------------



    -- Browning .303 Mk. II ---------------------------------------------------------------
    -- [1] = Cartridge, S.A., Ball, .303 inch, Magazine Rifle, Cordite, Mark I
    declare_weapon({category = CAT_SHELLS, name = "British303_Ball_Mk1c", user_name = _("British303_Ball_Mk1c"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "Ball",
        mass            = 0.0139317657, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 600.456,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [2] = Cartridge, S.A., Ball, .303 inch, Cordite, Mark VI
    declare_weapon({category = CAT_SHELLS, name = "British303_Ball_Mk6", user_name = _("British303_Ball_Mk6"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "Ball",
        mass            = 0.0139317657, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 600.456,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [3] = Cartridge, S.A., Ball, .303 inch, Cordite, Mark VII
    declare_weapon({category = CAT_SHELLS, name = "British303_Ball_Mk7", user_name = _("British303_Ball_Mk7"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "Ball",
        mass            = 0.0112750103, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 743.712,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.6,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [4] = Cartridge, S.A., Ball, .303 inch, Cordite, Mark VIII, Forbidden
    declare_weapon({category = CAT_SHELLS, name = "British303_Ball_Mk8", user_name = _("British303_Ball_Mk8"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "Ball",
        mass            = 0.0113398093, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 777.240,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.6,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [5] = Cartridge, S.A., Tracer, G, 500 yd, .303 inch, Cordite, Mark I
    declare_weapon({category = CAT_SHELLS, name = "British303_G_Mk1", user_name = _("British303_G_Mk1"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "Ball",
        mass            = 0.0112750103, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 743.712,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = 0.77,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [6] = Cartridge, S.A., Tracer, G, infantery long range, 1000 yd, .303 inch, Cordite, Mark II
    declare_weapon({category = CAT_SHELLS, name = "British303_G_Mk2", user_name = _("British303_G_Mk2"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "Ball",
        mass            = 0.0112750103, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 743.712,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = 1.91,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [7] = Cartridge, S.A., Tracer, G, naval, 800 yd, .303 inch, Cordite, Mark III
    declare_weapon({category = CAT_SHELLS, name = "British303_G_Mk3", user_name = _("British303_G_Mk3"),
        model_name      = "tracer_bullet_red",
        projectile      = "Ball",
        mass            = 0.0112750103, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 743.712,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = 1.40,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [8] = Cartridge, S.A., Tracer, G, aircraft, 550 yd, .303 inch, Cordite, Mark IIII
    declare_weapon({category = CAT_SHELLS, name = "British303_G_Mk4", user_name = _("British303_G_Mk4"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "Ball",
        mass            = 0.0112750103, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 743.712,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = 0.86,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [9] = Cartridge, S.A., Tracer, G, aircraft night dimmed, 550 yd, .303 inch, Cordite, Mark V
    declare_weapon({category = CAT_SHELLS, name = "British303_G_Mk5", user_name = _("British303_G_Mk5"),
        model_name      = "tracer_bullet_red",
        projectile      = "Ball",
        mass            = 0.0112750103, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 743.712,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = 0.86,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [10] = Cartridge, S.A., Tracer, G, aircraft, 550 yd, .303 inch, Nitrocellulose, Mark VIz
    declare_weapon({category = CAT_SHELLS, name = "British303_G_Mk6z", user_name = _("British303_G_Mk6z"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "Ball",
        mass            = 0.0112750103, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 743.712,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.0,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = 0.86,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [11] = Cartridge, S.A., Armour Piercing, W, .303 inch, Nitrocellulose, Mark Iz
    declare_weapon({category = CAT_SHELLS, name = "British303_W_Mk1z", user_name = _("British303_W_Mk1z"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.0112750103, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 743.712,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.6,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [12] = Cartridge, S.A., Incendiary, B, .303 inch, Nitrocellulose, Mark IIIIz
    declare_weapon({category = CAT_SHELLS, name = "British303_B_Mk4z", user_name = _("British303_B_Mk4z"),
        model_name      = "tracer_bullet_white",
        projectile      = "Ball",
        mass            = 0.0112750103, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.00025,
        payload         = 0.00025, -- of Ammonium Nitrate / Thermal
        payloadEffect   = "Thermal",
        payloadMaterial = "Thermite",
        v0              = 743.712,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.6,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = 3.6,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [13] = Cartridge, S.A., Incendiary, B, .303 inch, Nitrocellulose, Mark VIz, "De Wilde"
    declare_weapon({category = CAT_SHELLS, name = "British303_B_Mk6z", user_name = _("British303_B_Mk6z"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "HE",
        mass            = 0.0112750103, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.0005,
        payload         = 0.0005, -- of Ammonium Nitrate / High Explosive
        payloadEffect   = "Thermal",
        payloadMaterial = "Thermite",
        v0              = 743.712,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.6,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [14] = Cartridge, S.A., Observer, O, .303 inch, Cordite, Mark I
    declare_weapon({category = CAT_SHELLS, name = "British303_O_Mk1", user_name = _("British303_O_Mk1"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "HE",
        mass            = 0.0112750103, -- Bullet mass
        round_mass      = 0.024 + 0.009, -- Assembled shell + link
        cartridge_mass  = 0.006 + 0.009, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.0020,
        payload         = 0.0020, -- of Black Powder / High Explosive
        payloadEffect   = "Nil",
        payloadMaterial = "BlackPowder",
        v0              = 743.712,
        Dv0             = 0.0080,
        Da0             = 0.00045,
        Da1             = 0.0,
        life_time       = 3.6,
        caliber         = 7.62,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {1.0, 0.62, 0.65, 0.175, 1.80},
        k1              = 2.3e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- Browning .303 Mk. II
    function Browning303MkII ( tbl )
        tbl.category = CAT_GUN_MOUNT
        tbl.name = "Browning303MkII"
        tbl.display_name = _("Browning .303 Mk. II")
        tbl.supply = {
            shells = {
                --[[ 1 ]]   "British303_Ball_Mk1c",
                --[[ 2 ]]   "British303_Ball_Mk6",
                --[[ 3 ]]   "British303_Ball_Mk7",
                --[[ 4 ]]   "British303_Ball_Mk8",

                --[[ 5 ]]   "British303_G_Mk1",
                --[[ 6 ]]   "British303_G_Mk2",
                --[[ 7 ]]   "British303_G_Mk3",
                --[[ 8 ]]   "British303_G_Mk4",
                --[[ 9 ]]   "British303_G_Mk5",
                --[[ 10 ]]  "British303_G_Mk6z",

                --[[ 11 ]]  "British303_W_Mk1z",

                --[[ 12 ]]  "British303_B_Mk4z",
                --[[ 13 ]]  "British303_B_Mk6z",

                --[[ 14 ]]  "British303_O_Mk1",
            },
            mixes = {{2}},
            count = 200,
        }
        if tbl.mixes then
            tbl.supply.mixes = tbl.mixes
            tbl.mixes = nil
        end
        if tbl.count then
            tbl.supply.count = tbl.count
            tbl.count = nil
        end
        tbl.gun = {
            max_burst_length = 65535,
            rates = {1100}, -- unsynchronized mount
            recoil_coeff = 1.0,
            barrels_count = 1,
        }
        if tbl.rates then
            tbl.gun.rates = tbl.rates
            tbl.rates = nil
        end
        tbl.ejector_pos = tbl.ejector_pos or {0.0, 0.05, 0.0}
        tbl.ejector_dir = tbl.ejector_dir or {0, -1, 0}
        --tbl.effect_arg_number = tbl.effect_arg_number or 436
        tbl.supply_position = tbl.supply_position or {0, 0.3, -0.3}
        tbl.aft_gun_mount = false
        tbl.effective_fire_distance = 1000
        --tbl.drop_cartridge = 0 -- 204
        tbl.muzzle_pos = {0, 0, 0} -- all position from connector
        tbl.azimuth_initial = tbl.azimuth_initial or 0
        tbl.elevation_initial = tbl.elevation_initial or 0
        --if tbl.effects == nil then
        --    tbl.effects = {synchronizer, {name = "FireEffect", arg = tbl.effect_arg_number or 436}, {name = "HeatEffectExt", shot_heat = 4.103, barrel_k = 0.462 * 3.7, body_k = 0.462 * 14.3}, {name = "SmokeEffect"}}
        --end

        return declare_weapon(tbl)
    end
    -- end of Browning .303 Mk. II --------------------------------------------------------



    -- M2 Browning .50 Caliber Machine Gun ------------------------------------------------
    -- [1] = Cartridge, caliber .50, ball, M2
    declare_weapon({category = CAT_SHELLS, name = "50Browning_Ball_M2", user_name = _("50Browning_Ball_M2"),
        model_name      = "tracer_bullet_A-10",
        projectile      = "Ball",
        mass            = 0.046, -- Bullet mass
        round_mass      = 0.117 + 0.020, -- Assembled shell + link
        cartridge_mass  = 0.012 + 0.000, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 823.5,
        Dv0             = 0.0082,
        Da0             = 0.00085,
        Da1             = 0.0,
        life_time       = 7.0,
        caliber         = 12.7,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.5, 0.61, 0.80, 0.17, 2.0},
        k1              = 1.4e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [2] = Cartridge, caliber .50, armor piercing, M2
    declare_weapon({category = CAT_SHELLS, name = "50Browning_AP_M2", user_name = _("50Browning_AP_M2"),
        model_name      = "tracer_bullet_A-10",
        projectile      = "AP",
        mass            = 0.0458, -- Bullet mass
        round_mass      = 0.117 + 0.020, -- Assembled shell + link
        cartridge_mass  = 0.012 + 0.000, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 830.0,
        Dv0             = 0.0082,
        Da0             = 0.00085,
        Da1             = 0.0,
        life_time       = 7.0,
        caliber         = 12.7,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.5, 0.61, 0.80, 0.17, 2.0},
        k1              = 1.4e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [3] = Cartridge, caliber .50, armor-piercing incendiary, M8
    declare_weapon({category = CAT_SHELLS, name = "50Browning_API_M8", user_name = _("50Browning_API_M8"),
        model_name      = "tracer_bullet_A-10",
        projectile      = "AP",
        mass            = 0.0403, -- Bullet mass
        round_mass      = 0.114 + 0.020, -- Assembled shell + link
        cartridge_mass  = 0.012 + 0.000, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.0000,
        payload         = 0.001,
        payloadEffect   = "Thermal",
        payloadMaterial = "Thermite",
        v0              = 860.0,
        Dv0             = 0.0082,
        Da0             = 0.00085,
        Da1             = 0.0,
        life_time       = 7.0,
        caliber         = 12.7,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.5, 0.61, 0.80, 0.17, 2.0},
        k1              = 1.35e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [4] = Cartridge, caliber .50, armor-piercing incendiary tracer, M20
    declare_weapon({category = CAT_SHELLS, name = "50Browning_APIT_M20", user_name = _("50Browning_APIT_M20"),
        model_name      = "tracer_bullet_red",
        projectile      = "AP",
        mass            = 0.0410, -- Bullet mass
        round_mass      = 0.112 + 0.020, -- Assembled shell + link
        cartridge_mass  = 0.012 + 0.000, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.0000,
        payload         = 0.0017,
        payloadEffect   = "Thermal",
        payloadMaterial = "Thermite",
        v0              = 875.0,
        Dv0             = 0.0082,
        Da0             = 0.00085,
        Da1             = 0.0,
        life_time       = 7.0,
        caliber         = 12.7,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.5, 0.61, 0.80, 0.17, 2.0},
        k1              = 1.35e-08,
        tracer_off      = 4.0,
        smoke_tail_life_time = 0.5,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [5] = Cartridge, caliber .50, incendiary, M1
    declare_weapon({category = CAT_SHELLS, name = "50Browning_I_M1", user_name = _("50Browning_I_M1"),
        model_name      = "tracer_bullet_white",
        projectile      = "Ball",
        mass            = 0.0405, -- Bullet mass
        round_mass      = 0.115 + 0.02, -- Assembled shell + link
        cartridge_mass  = 0.012, -- Empty shell (+ link if links are stored as well)
        payload         = 0.0017,
        payloadEffect   = "Thermal",
        payloadMaterial = "Thermite",
        v0              = 860,
        Dv0             = 0.0082,
        Da0             = 0.00085,
        Da1             = 0,
        life_time       = 7,
        caliber         = 12.7,
        s               = 0,
        j               = 0,
        l               = 0,
        charTime        = 0,
        cx              = {0.5, 0.61, 0.8, 0.17, 2},
        k1              = 1.35e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [6] = Cartridge, caliber .50, Tracer, M1
    declare_weapon({category = CAT_SHELLS, name = "50Browning_T_M1", user_name = _("50Browning_T_M1"),
        model_name      = "tracer_bullet_red",
        projectile      = "Ball",
        mass            = 0.0437, -- Bullet mass
        round_mass      = 0.116 + 0.02, -- Assembled shell + link
        cartridge_mass  = 0.012, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 875,
        Dv0             = 0.0082,
        Da0             = 0.00085,
        Da1             = 0,
        life_time       = 7,
        caliber         = 12.7,
        s               = 0,
        j               = 0,
        l               = 0,
        charTime        = 0,
        cx              = {0.5, 0.61, 0.8, 0.17, 2},
        k1              = 1.35e-08,
        tracer_off      = 4,
        smoke_tail_life_time = 0.5,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- M2 Browning .50 Caliber Machine Gun
    function BrowningM2 ( tbl )
        tbl.category = CAT_GUN_MOUNT
        tbl.name = "BrowningM2"
        tbl.display_name = _("Browning .50 M2")
        tbl.supply = {
            shells = {
                --[[ 1 ]]   "50Browning_Ball_M2",
                --[[ 2 ]]   "50Browning_AP_M2",
                --[[ 3 ]]   "50Browning_API_M8",
                --[[ 4 ]]   "50Browning_APIT_M20",
                --[[ 5 ]]   "50Browning_I_M1",
                --[[ 6 ]]   "50Browning_T_M1",
            },
            mixes = {{1}},
            count = 100,
        }
        if tbl.mixes then
            tbl.supply.mixes = tbl.mixes
            tbl.mixes = nil
        end
        if tbl.count then
            tbl.supply.count = tbl.count
            tbl.count = nil
        end
        tbl.gun = {
            max_burst_length = 65535,
            rates = {800}, -- unsynchronized mount
            recoil_coeff = 0.91,
            barrels_count = 1,
        }
        if tbl.rates then
            tbl.gun.rates = tbl.rates
            tbl.rates = nil
        end
        --tbl.ejector_pos_connector
        tbl.ejector_pos = tbl.ejector_pos or {-0.5, -0.5, 0.0}
        tbl.ejector_dir = tbl.ejector_dir or {-2.0, -5.0, 0.0}
        tbl.supply_position = tbl.supply_position or {0.0, 0.0, 0.0}
        tbl.aft_gun_mount = false
        tbl.effective_fire_distance = 1200
        tbl.drop_cartridge = tbl.drop_cartridge or 204
        if tbl.muzzle_pos_connector ~= nil then
            tbl.muzzle_pos = {0, 0, 0}
        end
        tbl.azimuth_initial = tbl.azimuth_initial or 0
        tbl.elevation_initial = tbl.elevation_initial or 0
        if tbl.effects == nil then
            tbl.effects = {
                {name = "HeatEffectExt", shot_heat = 7.823, barrel_k = 0.462 * 6.0, body_k = 0.462 * 32.0},
                {name = "FireEffect", arg = tbl.effect_arg_number or 436, duration = 0.02, attenuation = 2.0, light_pos = {0.5, 0.0, 0.0}},
                {name = "SmokeEffect"},
            }
        end

        return declare_weapon(tbl)
    end
    -- end of M2 Browning .50 Caliber Machine Gun -----------------------------------------



    -- Hispano Mk. II ---------------------------------------------------------------------
    -- [1] = Cartridge, Hispano_Mk_II_Mk_Z_Ball Made according UK test report
    declare_weapon({category = CAT_SHELLS, name = "Hispano_Mk_II_Mk_Z_Ball", user_name = _("Hispano_Mk_II_Mk_Z_Ball"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "Ball",
        mass            = 0.124, -- Bullet mass
        round_mass      = 0.283, -- Assembled shell + link
        cartridge_mass  = 0.056, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 881.0,
        Dv0             = 0.0080,
        Da0             = 0.0006,
        Da1             = 0.0,
        life_time       = 6.0,
        caliber         = 20,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.4, 0.992, 0.8, 0.22, 1.85},
        k1              = 2.0e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [2] = Cartridge, Hispano_Mk_II_MKI_HE/I Made according UK test report
    declare_weapon({category = CAT_SHELLS, name = "Hispano_Mk_II_MKI_HE/I", user_name = _("Hispano_Mk_II_MKI_HE/I"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "HE",
        mass            = 0.129, -- Bullet mass
        round_mass      = 0.283, -- Assembled shell + link
        cartridge_mass  = 0.056, -- Empty shell (+ link if links are stored as well)
        --explosive       = 0.01,
        payload         = 0.010,
        payloadEffect   = "Thermal",
        payloadMaterial = "Tetryl",
        v0              = 881.0,
        Dv0             = 0.0080,
        Da0             = 0.0006,
        Da1             = 0.0,
        life_time       = 6.0,
        caliber         = 20,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.3, 1.11, 0.78, 0.22, 1.84},
        k1              = 2.18e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [3] = Cartridge, Hispano_Mk_II_MKIIZ_AP Made according UK test report
    declare_weapon({category = CAT_SHELLS, name = "Hispano_Mk_II_MKIIZ_AP", user_name = _("Hispano_Mk_II_MKIIZ_AP"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.14, -- Bullet mass
        round_mass      = 0.283, -- Assembled shell + link
        cartridge_mass  = 0.056, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 827.0,
        Dv0             = 0.0080,
        Da0             = 0.0006,
        Da1             = 0.0,
        life_time       = 6.0,
        caliber         = 20,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.4, 1.04, 0.78, 0.22, 1.87},
        k1              = 2.05e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [4] = Cartridge, Hispano_Mk_II_SAP/I Made according UK test report
    declare_weapon({category = CAT_SHELLS, name = "Hispano_Mk_II_SAP/I", user_name = _("Hispano_Mk_II_SAP/I"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.135, -- Bullet mass
        round_mass      = 0.283, -- Assembled shell + link
        cartridge_mass  = 0.056, -- Empty shell (+ link if links are stored as well)
        explosive       = 0.01,
		payloadEffect   = "Thermal",
        payloadMaterial = "Phosphor",		
        v0              = 827.0,
        Dv0             = 0.0080,
        Da0             = 0.0006,
        Da1             = 0.0,
        life_time       = 6.0,
        caliber         = 20,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.4, 1.06, 0.78, 0.22, 1.84},
        k1              = 2.00e-08,
        tracer_off      = -1,
        smoke_tail_life_time = 0,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [5] = Cartridge, Hispano_Mk_II_Tracer_G Made according UK test report
    declare_weapon({category = CAT_SHELLS, name = "Hispano_Mk_II_Tracer_G", user_name = _("Hispano_Mk_II_Tracer_G"),
        model_name      = "tracer_bullet_red",
        projectile      = "AP",
        mass            = 0.132, -- Bullet mass
        round_mass      = 0.283, -- Assembled shell + link
        cartridge_mass  = 0.056, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 854.0,
        Dv0             = 0.0080,
        Da0             = 0.0006,
        Da1             = 0.0,
        life_time       = 6.0,
        caliber         = 20,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.4, 0.96, 0.78, 0.22, 1.96},
        k1              = 1.8e-08,
        tracer_off      = 6.1,
        smoke_tail_life_time = 6.1,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- [6] = Cartridge, Hispano_Mk_II_AP/T Made according UK test report
    declare_weapon({category = CAT_SHELLS, name = "Hispano_Mk_II_AP/T", user_name = _("Hispano_Mk_II_AP/T"),
        model_name      = "tracer_bullet_yellow",
        projectile      = "AP",
        mass            = 0.14, -- Bullet mass
        round_mass      = 0.283, -- Assembled shell + link
        cartridge_mass  = 0.056, -- Empty shell (+ link if links are stored as well)
        explosive       = 0,
        v0              = 827.0,
        Dv0             = 0.0080,
        Da0             = 0.0006,
        Da1             = 0.0,
        life_time       = 6.0,
        caliber         = 20,
        s               = 0.0,
        j               = 0.0,
        l               = 0.0,
        charTime        = 0,
        cx              = {0.4, 0.89, 0.78, 0.22, 1.83},
        k1              = 1.70e-08,
        tracer_off      = 1.7,
        smoke_tail_life_time = 1.7,
        cartridge       = 0,
        scale_smoke     = barrel_smoke_level,
        smoke_opacity   = barrel_smoke_opacity,
    })

    -- Hispano Mk. II
    function HispanoMkII ( tbl )
        tbl.category = CAT_GUN_MOUNT 
        tbl.name = "HispanoMkII"
        tbl.display_name = _("Hispano Mk. II")
        tbl.supply = {
            shells = {
                --[[ 1 ]]   "Hispano_Mk_II_Mk_Z_Ball",
                --[[ 2 ]]   "Hispano_Mk_II_MKI_HE/I",
                --[[ 3 ]]   "Hispano_Mk_II_MKIIZ_AP",
                --[[ 4 ]]   "Hispano_Mk_II_SAP/I",
                --[[ 5 ]]   "Hispano_Mk_II_Tracer_G",
                --[[ 6 ]]   "Hispano_Mk_II_AP/T",
            },
            mixes = {{2, 4, 2, 6, 2}},
            count = 60,
        }
        if tbl.mixes then
            tbl.supply.mixes = tbl.mixes
            tbl.mixes = nil
        end
        if tbl.count then
            tbl.supply.count = tbl.count
            tbl.count = nil
        end
        tbl.gun = {
            max_burst_length = 65535,
            rates = {650}, -- unsynchronized mount
            recoil_coeff = 1.0,
            barrels_count = 1,
        }
        if tbl.rates then
            tbl.gun.rates = tbl.rates
            tbl.rates = nil
        end
        tbl.ejector_pos = tbl.ejector_pos or {0.0, 0.05, 0.0}
        tbl.ejector_dir = tbl.ejector_dir or {0, -1, 0}
        tbl.supply_position = tbl.supply_position or {0, -0.3, -1.5}
        tbl.aft_gun_mount = false
        tbl.effective_fire_distance = 1000
        --tbl.drop_cartridge = 204
        tbl.muzzle_pos = tbl.muzzle_pos or {0, 0, 0}
        tbl.azimuth_initial = tbl.azimuth_initial or 0
        tbl.elevation_initial = tbl.elevation_initial or 0
        --tbl.effects = {
        --    synchronizer,
        --    {name = "FireEffect", arg = tbl.effect_arg_number or 436},
        --    {name = "HeatEffectExt", shot_heat = 20.9, barrel_k = 0.462 * 16.6, body_k = 0.462 * 35.4},
        --    {name = "SmokeEffect"}
        --}

        return declare_weapon(tbl)
    end
    -- end of Hispano Mk. II --------------------------------------------------------------



-- end of Defining guns -------------------------------------------------------------------









-- Defining drop ordnance -----------------------------------------------------------------



    -- SC 50 ------------------------------------------------------------------------------
    SC_50 = {category = CAT_BOMBS, name = "SC_50", user_name = _("SC 50"),
        model           = "SC50",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 50.0,
        hMin            = 1000.0,
        hMax            = 12000.0,
        Cx              = 0.00014,			--according German WT tests of FW 190
        VyHold          = -100.0,
        Ag              = -1.23,
        fm              = {
            mass        = 50.0, -- Empty weight with warhead, W/O fuel, kg
            caliber     = 0.200, -- Calibre, meters 
            cx_coeff    = {1.000000, 0.390000, 0.60000, 0.1680000, 1.310000}, -- Cx
            L           = 3.365, -- Length, meters 
            I           = 443.4929, -- kgm2 - moment of inertia  I = 1/12 ML2
            Ma          = 0.42,  -- dependence moment coefficient of  by  AoA angular acceleration  T / I
            Mw          = 5.04, --  rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t
            wind_sigma  = 5, -- dispersion coefficient
            cx_factor   = 100,
        },
        fuze = predefined_fuze("Z25C"),
        warhead         = {
            mass        = 25.0; 
            expl_mass   = 25;
            other_factors = {1.0, 1.0, 1.0};
            obj_factors = {1, 1};
            concrete_factors = {1.0, 1.0, 1.0};
            cumulative_factor = 1;
            concrete_obj_factor = 1.0;
            cumulative_thickness = 1.0;
            piercing_mass = 1.0;
            caliber     = 200;
            default_fuze_delay = 0;
        },
        shape_table_data = {
            {
                name    = "SC_50";
                file    = "SC50";
                life    = 1;
                fire    = {0, 1};
                username = "SC 50";
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data  = {
            char_time   = 20.60, -- characteristic time for sights 
        },
    }
    declare_weapon(SC_50)
    declare_loadout({category = CAT_BOMBS, CLSID = "{SC_50}", displayName = _("SC 50 - 50kg GP Bomb LD"),
        attribute       = SC_50.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = SC_50.Cx,
        Picture         = "german_SC50.png",
        PictureBlendColor = "0xffffffff",
        Weight          = SC_50.mass,
        Elements        = {{ShapeName = SC_50.model}},
    })
    declare_loadout({category = CAT_BOMBS, CLSID = "ER_4_SC50", displayName = _("4 x SC 50 - 50kg GP Bomb LD"),
        attribute       = {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
        wsTypeOfWeapon  = SC_50.wsTypeOfWeapon,
        Count           = 4,
        Cx_pil          = 0.00111, 
        Picture         = "german_ER4_SC50.png",
        PictureBlendColor = "0xffffffff",
        Weight          = 220.0,
        Elements        = {
            [1] = {
                ShapeName = "ER4_Rack",
                IsAdapter = true
            }, 
            [2] = {
                Position = {0.45,  -0.17,  0.11},
                payload_CLSID = "{SC_50}",
            }, 
            [3] = {
                Position = {0.45,  -0.17,  -0.11},
                payload_CLSID = "{SC_50}",
            }, 
            [4] = {
                Position = {-0.68, -0.17,   0.11},
                payload_CLSID = "{SC_50}",
            }, 
            [5] = {
                Position = {-0.68, -0.17,  -0.11},
                payload_CLSID = "{SC_50}",
            },  
        }, -- end of Elements
        settings = PredefinedFuzeGUISettings("WWII_B_G_SCSmall")
    })
    -- end of SC 50 -----------------------------------------------------------------------



    -- SC 250 Type 1 L2 -------------------------------------------------------------------
    SC_250_T1_L2 = {category = CAT_BOMBS, name = "SC_250_T1_L2", user_name = _("SC 250 Type 1 L2"),
        model           = "SC-250L2",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 250.0,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00118,   --according German WT tests of FW 190
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.02,
        fm              = {
            mass        = 250, -- Empty weight with warhead, W/O fuel, kg
            caliber     = 0.368, -- Calibre, meters 
            cx_coeff    = {1.000000, 0.390000, 0.380000, 0.236000, 1.310000}, -- Cx
            L           = 1.640000, -- Length, meters 
            I           = 43.077867, -- kgm2 - moment of inertia - I = 1/12 ML2
            Ma          = 0.141338,  -- dependence moment coefficient of  by  AoA angular acceleration  T / I
            Mw          = 2.244756, --  rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t
            wind_sigma  = 30, -- dispersion coefficient  
            cx_factor   = 100,  
        },
        fuze = predefined_fuze("Z25C"),
        warhead         = {
            mass        = 135.0;
            expl_mass   = 135.0;
            other_factors = {1.0, 1.0, 1.0};
            obj_factors = {1, 1};
            concrete_factors = {1.0, 1.0, 1.0};
            cumulative_factor = 1;
            concrete_obj_factor = 1.0;
            cumulative_thickness = 1.0;
            piercing_mass = 1.0;
            caliber     = 368;
            default_fuze_delay = 0;
        },
        shape_table_data = {
            {
                name    = "SC_250L2";
                file    = "SC-250L2";
                life    = 1;
                fire    = {0, 1};
                username = "SC 250 Type 1 L2";
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data  = {
            char_time   = 20.60, -- characteristic time for sights 
        },
    }
    declare_weapon(SC_250_T1_L2)
    declare_loadout({category = CAT_BOMBS, CLSID = "{SC_250_T1_L2}", displayName = _("SC 250 Type 1 L2 - 250kg GP Bomb LD"),
        attribute       = SC_250_T1_L2.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = SC_250_T1_L2.Cx,
        Picture         = "german_SC250T1L2.png",
        PictureBlendColor = "0xffffffff",
        Weight          = SC_250_T1_L2.mass,
        Elements        = {{ShapeName = SC_250_T1_L2.model}},
        settings        = PredefinedFuzeGUISettings("WWII_B_G_SCSmall")
    })
    -- end of SC 250 Type 1 L2 ------------------------------------------------------------



    -- SC 250 Type 3 J --------------------------------------------------------------------
    SC_250_T3_J = {category = CAT_BOMBS, name = "SC_250_T3_J", user_name = _("SC 250 Type 3 J"),
        model           = "SC-250",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 250.0,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00118,   --according German WT tests of FW 190
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.02,
        fm              = {
            mass        = 250, -- Empty weight with warhead, W/O fuel, kg
            caliber     = 0.368, -- Calibre, meters 
            cx_coeff    = {1.000000, 0.390000, 0.380000, 0.236000, 1.310000}, -- Cx
            L           = 1.640000, -- Length, meters 
            I           = 43.077867, -- kgm2 - moment of inertia - I = 1/12 ML2
            Ma          = 0.141338,  -- dependence moment coefficient of  by  AoA angular acceleration  T / I
            Mw          = 2.244756, --  rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t
            wind_sigma  = 30, -- dispersion coefficient  
            cx_factor   = 100,  
        },
        fuze = predefined_fuze("Z25C"),
        warhead         = {
            mass        = 135.0; 
            expl_mass   = 135.0;
            other_factors = {1.0, 1.0, 1.0};
            obj_factors = {1, 1};
            concrete_factors = {1.0, 1.0, 1.0};
            cumulative_factor = 1;
            concrete_obj_factor = 1.0;
            cumulative_thickness = 1.0;
            piercing_mass = 1.0;
            caliber     = 368;
            default_fuze_delay = 0;
        },
        shape_table_data = {
            {
                name    = "SC_250";
                file    = "SC-250";
                life    = 1;
                fire    = {0, 1};
                username = "SC-250";
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data  = {
            char_time   = 20.60, -- characteristic time for sights 
        },
    }
    declare_weapon(SC_250_T3_J)
    declare_loadout({category = CAT_BOMBS, CLSID = "SC_501_SC250", displayName = _("SC 250 Type 3 J - 250kg GP Bomb LD"),
        attribute       = SC_250_T3_J.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = SC_250_T3_J.Cx,
        Picture         = "german_SC250T3J.png",
        PictureBlendColor = "0xffffffff",
        Weight          = SC_250_T3_J.mass,
        Elements        = {{ShapeName = SC_250_T3_J.model}},
        settings        = PredefinedFuzeGUISettings("WWII_B_G_SCSmall")
    })
    declare_loadout({category = CAT_BOMBS, CLSID = "{Schloss500XIIC1_SC_250_T3_J}", displayName = _("SC 250 Type 3 J - 250kg GP Bomb LD"),
        attribute       = {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
        wsTypeOfWeapon  = SC_250_T3_J.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = SC_250_T3_J.Cx,
        Picture         = "german_SC250T3J.png",
        PictureBlendColor = "0xffffffff",
        Weight          = SC_250_T3_J.mass + 20.0,
        Elements        = {
            [1] = {
                ShapeName   = "Schloss_500XIIC",
                IsAdapter   = true,
                connector_name = "PYLON_1", -- to
                attach_point_connector = "AttachPoint_1",  -- with
            },
            [2] = {
                connector_name = "AttachPoint",
                payload_CLSID = "SC_501_SC250",
            },
        }, -- end of Elements
        settings = PredefinedFuzeGUISettings("WWII_B_G_SCSmall")
    })
    -- end of SC 250 Type 3 J -------------------------------------------------------------



    -- SC 500 J ---------------------------------------------------------------------------
    SC_500_J = {category = CAT_BOMBS, name = "SC_500_J", user_name = _("SC 500 J"),
        model           = "SC-500",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 500.0,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00132,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.03,
        fm              = {
            mass        = 500.0,
            caliber     = 0.47,
            cx_coeff    = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
            L           = 2.01,
            I           = 246.037500,
            Ma          = 0.324570,
            Mw          = 3.139597,
            wind_sigma  = 100.0,
            cx_factor   = 300,
        },
        fuze = predefined_fuze("Z38"),
        warhead         = {
            mass        = 260.0;
            expl_mass   = 260;
            other_factors = {1.0, 1.0, 1.0};
            obj_factors = {1, 1};
            concrete_factors = {1.0, 1.0, 1.0};
            cumulative_factor = 1;
            concrete_obj_factor = 1.0;
            cumulative_thickness = 1.0;
            piercing_mass = 1.0;
            caliber     = 470;
            default_fuze_delay = 0.05;
        },
        shape_table_data = {
            {
                name    = "SC_500";
                file    = "SC-500";
                life    = 1;
                fire    = {0, 1};
                username = "SC-500";
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data = {
            char_time   = 20.35, -- characteristic time for sights 
        },
    }
    declare_weapon(SC_500_J)
    declare_loadout({category = CAT_BOMBS, CLSID = "SC_501_SC500", displayName = _("SC 500 J - 500kg GP Bomb LD"),
        attribute       = SC_500_J.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = SC_500_J.Cx,
        Picture         = "german_SC500J.png",
        PictureBlendColor = "0xffffffff",
        Weight          = SC_500_J.mass,
        Elements        = {{ShapeName = SC_500_J.model}},
        settings        = PredefinedFuzeGUISettings("WWII_B_G_SCMedium")
    })
    -- end of SC 500 J --------------------------------------------------------------------



    -- SC 500 L2 --------------------------------------------------------------------------
    SC_500_L2 = {category = CAT_BOMBS, name = "SC_500_L2", user_name = _("SC 500 L2"),
        model           = "SC-500L2",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 500.0,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00132,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.03,
        fm              = {
            mass        = 500.0,
            caliber     = 0.47,
            cx_coeff    = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
            L           = 2.01,
            I           = 246.037500,
            Ma          = 0.324570,
            Mw          = 3.139597,
            wind_sigma  = 100.0,
            cx_factor   = 300,
        },
        fuze = predefined_fuze("Z38"),
        warhead         = {
            mass        = 260.0; 
            expl_mass   = 260;
            other_factors = {1.0, 1.0, 1.0};
            obj_factors = {1, 1};
            concrete_factors = {1.0, 1.0, 1.0};
            cumulative_factor = 1;
            concrete_obj_factor = 1.0;
            cumulative_thickness = 1.0;
            piercing_mass = 1.0;
            caliber     = 470;
            default_fuze_delay = 0.05;
        },
        shape_table_data = {
            {
                name    = "SC_500L2";
                file    = "SC-500L2";
                life    = 1;
                fire    = {0, 1};
                username = "SC 500 L2";
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data = {
            char_time   = 20.35, -- characteristic time for sights 
        },
    }
    declare_weapon(SC_500_L2)
    declare_loadout({category = CAT_BOMBS, CLSID = "{SC_500_L2}", displayName = _("SC 500 L2 - 500kg GP Bomb LD"),
        attribute       = SC_500_L2.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = SC_500_L2.Cx,
        Picture         = "german_SC500L2.png",
        PictureBlendColor = "0xffffffff",
        Weight          = SC_500_L2.mass,
        Elements        = {{ShapeName = SC_500_L2.model}},
        settings        = PredefinedFuzeGUISettings("WWII_B_G_SCMedium")
    })
    -- end of SC 500 L2 -------------------------------------------------------------------



    -- SD 250 Stg -------------------------------------------------------------------------
    SD_250_Stg = {category = CAT_BOMBS, name = "SD_250_Stg", user_name = _("SD 250 Stg"),
        model           = "SD-250Stg",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 250.0,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00124,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.02,
        fm              = {
            mass        = 250, -- Empty weight with warhead, W/O fuel, kg
            caliber     = 0.368, -- Calibre, meters 
            cx_coeff    = {1.000000, 0.390000, 0.380000, 0.236000, 1.310000}, -- Cx
            L           = 1.640000, -- Length, meters 
            I           = 43.077867, -- kgm2 - moment of inertia - I = 1/12 ML2
            Ma          = 0.141338,  -- dependence moment coefficient of  by  AoA angular acceleration  T / I
            Mw          = 2.244756, --  rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t
            wind_sigma  = 30, -- dispersion coefficient  
            cx_factor   = 100,  
        },
        fuze = predefined_fuze("Z38"),
        warhead         = {
            mass        = 135.0;
            expl_mass   = 135.0;
            other_factors = {1.0, 1.0, 1.0};
            obj_factors = {1, 1};
            concrete_factors = {1.0, 1.0, 1.0};
            cumulative_factor = 1;
            concrete_obj_factor = 1.0;
            cumulative_thickness = 1.0;
            piercing_mass = 1.0;
            caliber     = 368;
            default_fuze_delay = 0.05;
        },
        shape_table_data = {
            {
                name    = "SD_250Stg";
                file    = "SD-250Stg";
                life    = 1;
                fire    = {0, 1};
                username = "SD 250 Stg";
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data  = {
            char_time   = 20.60, -- characteristic time for sights 
        },
    }
    declare_weapon(SD_250_Stg)
    declare_loadout({category = CAT_BOMBS, CLSID = "{SD_250_Stg}", displayName = _("SD 250 Stg - 250kg GP Bomb LD"),
        attribute       = SD_250_Stg.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = SD_250_Stg.Cx,
        Picture         = "german_SD250Stg.png",
        PictureBlendColor = "0xffffffff",
        Weight          = SD_250_Stg.mass,
        Elements        = {{ShapeName = SD_250_Stg.model}},
        settings        = PredefinedFuzeGUISettings("WWII_B_G_SDMedium")
    })
    -- end of SD 250 Stg ------------------------------------------------------------------



    -- SD 500 A ---------------------------------------------------------------------------
    SD_500_A = {category = CAT_BOMBS, name = "SD_500_A", user_name = _("SD 500 A"),
        model           = "SD-500A",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 500.0,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00132,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.03,
        fm              = {
            mass        = 500.0,
            caliber     = 0.47,
            cx_coeff    = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
            L           = 2.01,
            I           = 246.037500,
            Ma          = 0.324570,
            Mw          = 3.139597,
            wind_sigma  = 100.0,
            cx_factor   = 300,
        },
        fuze = predefined_fuze("Z38"),
        warhead         = {
            mass        = 260.0; 
            expl_mass   = 260;
            other_factors = {1.0, 1.0, 1.0};
            obj_factors = {1, 1};
            concrete_factors = {1.0, 1.0, 1.0};
            cumulative_factor = 1;
            concrete_obj_factor = 1.0;
            cumulative_thickness = 1.0;
            piercing_mass = 1.0;
            caliber     = 470;
            default_fuze_delay = 0.05;
        },
        shape_table_data = {
            {
                name    = "SD_500A";
                file    = "SD-500A";
                life    = 1;
                fire    = {0, 1};
                username = "SD 500 A";
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data = {
            char_time   = 20.35, -- characteristic time for sights 
        },
    }
    declare_weapon(SD_500_A)
    declare_loadout({category = CAT_BOMBS, CLSID = "{SD_500_A}", displayName = _("SD 500 A - 500kg GP Bomb LD"),
        attribute       = SD_500_A.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = SD_500_A.Cx,
        Picture         = "german_SD500A.png",
        PictureBlendColor = "0xffffffff",
        Weight          = SD_500_A.mass,
        Elements        = {{ShapeName = SD_500_A.model}},
        settings        = PredefinedFuzeGUISettings("WWII_B_G_SDMedium")
    })
    -- end of SD 500 A --------------------------------------------------------------------



    -- AB 250-2 with SD 2 submunition -----------------------------------------------------
    CLUSTER_AB_250_2_SD_2 = { category = CAT_CLUSTER_DESC, name = _("SD-2"),
        scheme = 
        {
            dispenser = 
            {
                mass                    = 280,
                caliber                 = 0.4,
                L                       = 1.73,
                I                       = 125,
                Ma                      = 0.164233,
                Mw                      = 1.588636,
                cx_coeff                = {1, 0.39, 0.6, 0.168, 1.31},
                wind_sigma              = 100,
                model_name              = "AB-250_dropping",
                set_start_args          = {},
                spawn_time              = {0.5},
                spawn_weight_loss       = {150},
                spawn_args_change       = {},
                op_spawns               = 1,
                use_effects             = 0,
                						--arg num	start val	end val		period		loop
                set_changing_args       = {58,		0,			0.15,		0.1,		0},
            },  
            empty_dispenser =
            {
                op_time                 = 300,
                mass                    = 25,
                caliber                 = 0.4,
                L                       = 2,
                I                       = 2,
                Ma                      = 0.3,
                Mw                      = 1,
                cx_coeff                = {1,1,1,1,2},
                model_name              = "AB-250_dropping",
                init_impulse            = {{0,0,0}},
                spawn_options           = {{0,0,1}},
                                		--arg num	start val	end val		period		loop
                set_changing_args       = {58,		0.15,			1,		0.3,		0},
            },
            bomblets =
            {
                wind_sigma                  = 30,
                impulse_sigma               = 5,
                moment_sigma                = 0.2,
                count                       = 144,
                effect_count                = 32,
                mass                        = 1.9,
                caliber                     = 0.08,
                cx_coeff                    = {1, 0.39, 0.38, 0.236, 1.31},
                L                           = 0.4,
                I                           = 0.061,
                Ma                          = 0.9,
                Mw                          = 0.9,
                model_name                  = "SD-2",
                connectors_model_name       = "AB-250_dropping",
                explosion_impulse_coeff     = 4,
                explosion_center            = {{0,0,0}},
                explosion_dont_use_x_axis   = 1,
                spawn_options               = {{0,0,144}},
                chute_diam                  = 0.26,
                chute_open_time             = 1.8,
                chute_rnd_coeff             = 0.45,
                set_changing_args           = {0,0,1,3,0}
            },
            warhead = simple_warhead(0.3,80),
        },
        cluster_scheme  = "opening_disp_bomblets_empty_disp",
        
        type_name       = _("cluster"),
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
    }
    declare_weapon(CLUSTER_AB_250_2_SD_2)
    AB_250_2_SD_2 = { category = CAT_BOMBS, name = "AB_250_2_SD_2", user_name = _("AB 250-2 SD-2"),
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
        type            = 5,
        mass            = 280.0,
        hMin            = 90.0,
        hMax            = 5000.0,
        Cx              = 0.000413,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.03,

        model           = "AB-250_dropping",
        scheme          = "bomb_cassette_v3",
        class_name      = "wAmmunition",
        fm =
        {
            mass            = 280,
            caliber         = 0.4,
            cx_coeff        = {1, 0.39, 0.6, 0.168, 1.31},
            L               = 1.73,
            I               = 125,
            Ma              = 0.164233,
            Mw              = 1.588636,
            wind_time       = 1000.000000,
            wind_sigma      = 100.000000,
        },  
        shape_table_data =
        {
            {
                name     = "AB_250_2_SD_2",
                file     = "AB-250_dropping",
                life     = 1,
                fire     = {0, 1},
                username = _("AB 250-2 SD-2"),
                index    = WSTYPE_PLACEHOLDER,
            },
        },
        launcher =
        {
            blocks  = {"cluster"},
            cluster = CLUSTER_AB_250_2_SD_2.descriptor,
        },
        container_fuze = predefined_fuze("Z69E"),
        targeting_data =
        {
            char_time = 20.4,
            bomblet_char_time = 22.5,
        }
    }
    declare_weapon(AB_250_2_SD_2)
    declare_loadout({category = CAT_BOMBS, CLSID = "{AB_250_2_SD_2}", displayName = _("AB 250-2 - 144 x SD-2, 250kg CBU with HE submunitions"),
        attribute       = AB_250_2_SD_2.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = AB_250_2_SD_2.Cx,
        Picture         = "german_AB250-2_SD2.png",
        PictureBlendColor = "0xffffffff",
        Weight          = AB_250_2_SD_2.mass,
        Elements        = {{ShapeName = "AB-250-2"}},
        settings        = PredefinedFuzeGUISettings("WWII_CC_G_AB250SD2")
    })
    -- end of AB 250-2 with SD 2 submunition ----------------------------------------------



    -- AB 250-2 with SD 10A submunition ---------------------------------------------------
    CLUSTER_AB_250_2_SD_10A = {category = CAT_CLUSTER_DESC, name = _("SD-10A"),
        scheme =
        {
            dispenser =
            {
                mass                    = 220,
                caliber                 = 0.4,
                L                       = 1.73,
                I                       = 120,
                Ma                      = 0.164233,
                Mw                      = 1.588636,
                cx_coeff                = {1, 0.39, 0.6, 0.168, 1.31},
                wind_sigma              = 100,
                model_name              = "AB-250_dropping",
                set_start_args          = {},
                spawn_time              = {0},
                spawn_weight_loss       = {170},
                spawn_args_change       = {},
                op_spawns               = 1,
                use_effects             = 0,
										--arg num	start val	end val		period		loop
                set_changing_args       = {58,		0,			0.15,		0.2,		0},
            },
            empty_dispenser =
            {
                op_time                 = 300,
                mass                    = 50,
                caliber                 = 3.46,
                L                       = 0.19,
                I                       = 2,
                Ma                      = 0.3,
                Mw                      = 1,
                cx_coeff                = {1,1,1,1,2},
                model_name              = "AB-250_dropping",
                spawn_options           = {{0,0,1}},
                						--arg num	start val	end val		period		loop
                set_changing_args       = {58,		0.15,		1,			1.0,		0},
            },
            bomblets =
            {
                wind_sigma                  = 50,
                impulse_sigma               = 5,
                moment_sigma                = 10,
                count                       = 17,
                effect_count                = 17,
                mass                        = 10,
                caliber                     = 0.086,
                cx_coeff                    = {1, 1, 0.8, 0.7, 1.31},
                L                           = 0.548,
                I                           = 1/12 * 10 * 0.548 ^ 2,
                Ma                          = 0.196612,
                Mw                          = 0.722107,
                model_name                  = "SD-10A",
                explosion_impulse_coeff     = 60,
                release_rnd_coeff           = 1.5,
                init_pos                    = {
                    {0.395, 0.13, 0}, {0.395, -0.13, 0}, {0.395, 0, 0.13}, {0.395, 0, -0.13}, {0.395, 0.1, 0.1}, {0.395, -0.1, 0.1}, {0.395, 0.1, -0.1}, {0.395, -0.1, -0.1},
                    {-0.17, 0.13, 0}, {-0.17, 0.11, 0.07}, {-0.17, 0.11, -0.07}, {-0.17, 0.06, 0.12}, {-0.17, 0.06, -0.12}, {-0.17, -0.02, 0.11}, {-0.17, -0.02, -0.11}, {-0.17, -0.09, 0.06}, {-0.17, -0.09, -0.06}
                },
                explosion_center            = {{0.105, 0, 0}},
                explosion_style             = 1,
                spawn_options               = {{0,0,17}},
            },
            warhead = predefined_warhead("SD_10A"),
        },
        cluster_scheme  = "opening_disp_bomblets_empty_disp",
        type_name       = _("cluster"),
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
    }
    declare_weapon(CLUSTER_AB_250_2_SD_10A)
    AB_250_2_SD_10A = {category = CAT_BOMBS, name = "AB_250_2_SD_10A", user_name = _("AB 250-2 SD-10A"),
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
        type            = 5,
        mass            = 220.0,
        hMin            = 90.0,
        hMax            = 5000.0,
        Cx              = 0.000413,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.03,

        model           = "AB-250_dropping",
        scheme          = "bomb_cassette_v3",
        class_name      = "wAmmunition",

        warhead = predefined_warhead("SD_10A"),

        fm =
        {
            mass            = 220,
            caliber         = 0.4,
            cx_coeff        = {1, 0.39, 0.6, 0.168, 1.31},
            L               = 1.73,
            I               = 120,
            Ma              = 0.164233,
            Mw              = 1.588636,
            wind_time       = 1000.000000,
            wind_sigma      = 100.000000,
        },

        shape_table_data =
        {
            {
                name     = "AB_250_2_SD_10A",
                file     = "AB-250_dropping",
                life     = 1,
                fire     = {0, 1},
                username = _("AB 250-2 SD-10A"),
                index    = WSTYPE_PLACEHOLDER,
            },
        },

        launcher =
        {
            blocks  = {"cluster"},
            cluster = CLUSTER_AB_250_2_SD_10A.descriptor,
        },

        container_fuze = predefined_fuze("Z69E"),

        targeting_data =
        {
            char_time = 20.56,
            bomblet_char_time = 21.2
        }
    }
    declare_weapon(AB_250_2_SD_10A)
    declare_loadout({category = CAT_BOMBS, CLSID = "{AB_250_2_SD_10A}", displayName = _("AB 250-2 - 17 x SD-10A, 250kg CBU with 10kg Frag/HE submunitions"),
        attribute       = AB_250_2_SD_10A.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = AB_250_2_SD_10A.Cx,
        Picture         = "german_AB250-2_SD10A.png",
        PictureBlendColor = "0xffffffff",
        Weight          = AB_250_2_SD_10A.mass,
        Elements        = {{ShapeName = "AB-250-2"}},
        settings        = PredefinedFuzeGUISettings("WWII_CC_G_AB250SC10")
    })
    -- end of AB 250-2 with SD 10A submunition --------------------------------------------



    -- AB 500-1 with SD 10A submunition ---------------------------------------------------
    CLUSTER_AB_500_1_SD_10A = {category = CAT_CLUSTER_DESC, name = _("SD-10A"),
        scheme =
        {
            dispenser =
            {
                mass                    = 470,
                caliber                 = 0.46,
                L                       = 2.03,
                I                       = 1/12 * 470 * 2.03 ^ 2,
                Ma                      = 0.164233,
                Mw                      = 1.588636,
                cx_coeff                = {1, 0.39, 0.6, 0.168, 1.31},
                wind_sigma              = 100,
                model_name              = "AB-500-1_dropping",
                set_start_args          = {},
                spawn_time              = {0},
                spawn_weight_loss       = {370},
                spawn_args_change       = {},
                op_spawns               = 1,
                use_effects             = 0,
										--arg num	start val	end val		period		loop
                set_changing_args       = {58,		0,			0.15,		0.2,		0},
            },
            empty_dispenser =
            {
                op_time                 = 300,
                mass                    = 100,
                caliber                 = 4.06,
                L                       = 0.23,
                I                       = 1/12 * 100 * 0.23 ^ 2,
                Ma                      = 0.3,
                Mw                      = 1,
                cx_coeff                = {1,1,1,1,2},
                model_name              = "AB-500-1_dropping",
                spawn_options           = {{0,0,1}},
                						--arg num	start val	end val		period		loop
                set_changing_args       = {58,		0.15,		1,			1.0,		0},
            },
            bomblets =
            {
                wind_sigma                  = 50,
                impulse_sigma               = 0,
                moment_sigma                = 0,
                count                       = 37,
                effect_count                = 37,
                mass                        = 10,
                caliber                     = 0.086,
                cx_coeff                    = {1, 1, 0.8, 0.7, 1.31},
                L                           = 0.548,
                I                           = 1/12 * 10 * 0.548 ^ 2,
                Ma                          = 0.196612,
                Mw                          = 0.722107,
                model_name                  = "SD-10A",
                connectors_model_name       = "AB-500-1_dropping",
                explosion_impulse_coeff     = 40,
                release_rnd_coeff           = 4.5,
                explosion_center            = {{0.2, 0, 0}},
                explosion_style             = 1,
                spawn_options               = {{0,0,37}},
            },
            warhead = predefined_warhead("SD_10A"),
        },
        cluster_scheme  = "opening_disp_bomblets_empty_disp",
        type_name       = _("cluster"),
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
    }
    declare_weapon(CLUSTER_AB_500_1_SD_10A)
    AB_500_1_SD_10A = {category = CAT_BOMBS, name = "AB_500_1_SD_10A", user_name = _("AB 500-1 SD-10A"),
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_Cluster, WSTYPE_PLACEHOLDER},
        type            = 5,
        mass            = 470.0,
        hMin            = 90.0,
        hMax            = 5000.0,
        Cx              = 0.000413,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.035,

        model           = "AB-500-1_dropping",
        scheme          = "bomb_cassette_v3",
        class_name      = "wAmmunition",
        warhead         = predefined_warhead("SD_10A"),

        fm =
        {
            mass            = 470,
            caliber         = 0.46,
            cx_coeff        = {1, 0.39, 0.6, 0.168, 1.31},
            L               = 2.03,
            I               = 150,
            Ma              = 0.164233,
            Mw              = 1.588636,
            wind_time       = 1000.000000,
            wind_sigma      = 100.000000,
        },

        shape_table_data =
        {
            {
                name     = "AB_500_1_SD_10A",
                file     = "AB-500-1_dropping",
                life     = 1,
                fire     = {0, 1},
                username = _("AB 500-1 SD-10A"),
                index    = WSTYPE_PLACEHOLDER,
            },
        },

        launcher =
        {
            blocks  = {"cluster"},
            cluster = CLUSTER_AB_500_1_SD_10A.descriptor,
        },

        container_fuze = predefined_fuze("Z69E"),

        targeting_data =
        {
            char_time = 20.41,
            bomblet_char_time = 21.2
        }
    }
    declare_weapon(AB_500_1_SD_10A)
    declare_loadout({category = CAT_BOMBS, CLSID = "{AB_500_1_SD_10A}", displayName = _("AB 500-1 - 34 x SD-10A, 500kg CBU with 10kg Frag/HE submunitions"),
        attribute       = AB_500_1_SD_10A.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = AB_500_1_SD_10A.Cx,
        Picture         = "german_AB500-1_SD10A.png",
        PictureBlendColor = "0xffffffff",
        Weight          = AB_500_1_SD_10A.mass,
        Elements        = {{ShapeName = "AB-500-1"}},
        settings        = PredefinedFuzeGUISettings("WWII_CC_G_AB500SC10")
    })
    -- end of AB 500-1 with SD 10A submunition --------------------------------------------

    -- LTF 5b -----------------------------------------------------------------------------
    LTF_5B = {category = CAT_TORPEDOES, name = "LTF_5B", user_name = _("LTF 5b"),
        scheme          = "unguided_stab_torpedo",
        class_name      = "wAmmunition",
        model           = "LT_F_5B",
        mass            = 765,
        
        wsTypeOfWeapon  = {wsType_Weapon,wsType_Torpedo,wsType_A_Torpedo,WSTYPE_PLACEHOLDER},

        -- torpedo data
        Head_Type   = 0,
        Diam        = 450.0,
        D_max       = 12000.0,
        D_min       = 500.0,
        V_min       = 10.0,
        V_max       = 250.0,
        H_max       = 75.0,
        H_min       = 5.0,
        Life_Time   = 1000.0,
        Nr_max      = 5.0,
        v_mid       = 20.0,

        
        shape_table_data =
        {
            {
                name        = "LTF_5B",
                file        = "LT_F_5B",
                life        = 1,
                fire        = { 0, 1},
                username    = _("LTF 5b"),
                index       = WSTYPE_PLACEHOLDER,
            },
        },

        fm = {
            mass            = 765.0,  
            caliber         = 0.450,  
            cx_coeff        = {1,0.39,0.38,0.236,1.31},
            L               = 5.36,
            I               = 1 / 12 * 765 * 5.36 * 5.36,
            Ma              = 0.16,
            Mw              = 0.28,
            wind_sigma      = 0.0,
            wind_time       = 0.0,
            Sw              = 1.6,
            dCydA           = {0.07, 0.036},
            A               = 0.5,
            maxAoa          = 0.3,
            finsTau         = 0.02,
            Ma_x            = 0.1,
            Mw_x            = 0.01,
            fins_val_div    = 10000,
            rho_w           = 1013,
            int_rho_y       = 0.8,
            Sww             = 0.15,
            splash_time     = 1.4,
            splash_dt       = 0.00002,
        },

        autopilot =
        {
            delay                   = 2.0,
            x_channel_delay         = 1.0,
            Kpv                     = 0.03,
            Kdv                     = 0.0,
            Kiv                     = 0.00002,
            Kph                     = 28.0,
            Kdh                     = 3.0,
            Kih                     = 0.0,
            steady_depth            = 5.0,
            x_fins_limit            = 0.1,
            fins_limit              = 0.1,
            hKp_err_croll           = 0.04,
            vel_proj_div            = 10.0,
            v_vel_limit             = 25.0,
            roll_diff_correction    = 1,
            
            hor_spir_on_time    = 0,
            hor_spir_period     = 0,
            hor_spir_power      = 0,
        },

        air_stab_autopilot =
        {
            x_channel_delay     = 0.6,
            delay               = 1.2,
            op_time             = 50,
            stab_dive_value     = math.rad(2),
            Kconv               = 300.0,
            Knv                 = 0.005,
            Kd                  = 0.4,
            Ki                  = 0.25,
            Kout                = 1.0,
            Kx                  = 0.1,
            Krx                 = 2.0,
            fins_limit          = math.rad(20),
            fins_limit_x        = math.rad(5),
            Areq_limit          = 10,
            max_side_N          = 10,
            max_signal_Fi       = math.rad(12),
            rotate_fins_output  = 0,
            null_roll           = math.rad(0),
        },

        engine = {
            thrust              = 7900,
        },
        
        warhead         = predefined_warhead("LTF_5B"),
        warhead_water   = predefined_warhead("LTF_5B"),
    }
    declare_weapon(LTF_5B)
    declare_loadout({category = CAT_TORPEDOES, CLSID = "{LTF_5B}", displayName = _("LTF 5b Aerial Torpedo"),
        attribute       = LTF_5B.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = 0.0018,
        Picture         = "fab100.png",
        Weight          = LTF_5B.mass,
        Elements        = {{ShapeName = "LT_F_5B"}},
    })
    -- end of LTF 5b ----------------------------------------------------------------------



	dcswwii_bomb_models =
	{
		["British_GP_250LB_Bomb_Mk1"]       = {file_name = "LB_250",                        icon = "british_250lb_GP_MkI.png",          display_name = _("250 lb GP Mk.I")},
		["British_GP_250LB_Bomb_Mk4"]       = {file_name = "250_lb_gp_mk_IV",               icon = "british_250lb_GP_MkIV.png",         display_name = _("250 lb GP Mk.IV")},
		["British_GP_250LB_Bomb_Mk5"]       = {file_name = "250_lb_gp_mk_V",                icon = "british_250lb_GP_MkV.png",          display_name = _("250 lb GP Mk.V")},
		["British_GP_500LB_Bomb_Mk1"]       = {file_name = "LB_500",                        icon = "british_500lb_GP_MkI.png",          display_name = _("500 lb GP Mk.I")},
		["British_GP_500LB_Bomb_Mk4"]       = {file_name = "500_lb_gp_mk_IV",               icon = "british_500lb_GP_MkIV.png",         display_name = _("500 lb GP Mk.IV")},
		["British_GP_500LB_Bomb_Mk4_Short"] = {file_name = "500_lb_gp_st_type",             icon = "british_500lb_GP_MkIV_Short.png",   display_name = _("500 lb GP Short tail")},
		["British_GP_500LB_Bomb_Mk5"]       = {file_name = "500_lb_gp_mk_V",                icon = "british_500lb_GP_MkV.png",          display_name = _("500 lb GP Mk.V")},
		["British_MC_250LB_Bomb_Mk1"]       = {file_name = "250_lb_mc_mkI",                 icon = "british_250lb_MC_MkI.png",          display_name = _("250 lb MC Mk.I")},
		["British_MC_250LB_Bomb_Mk2"]       = {file_name = "250_lb_mc_mkII",                icon = "british_250lb_MC_MkII.png",         display_name = _("250 lb MC Mk.II")},
		["British_MC_500LB_Bomb_Mk1_Short"] = {file_name = "500_lb_mc_short_tailed_type",   icon = "british_500lb_MC_MkI_Short.png",    display_name = _("500 lb MC Short tail")},
		["British_MC_500LB_Bomb_Mk2"]       = {file_name = "500_lb_mc_mkII",                icon = "british_500lb_MC_MkII.png",         display_name = _("500 lb MC Mk.II")},
		["British_SAP_250LB_Bomb_Mk5"]      = {file_name = "250_sab",                       icon = "british_250lb_SAP_MkV.png",         display_name = _("250 lb S.A.P.")},
		["British_SAP_500LB_Bomb_Mk5"]      = {file_name = "500_sab",                       icon = "british_500lb_SAP_MkV.png",         display_name = _("500 lb S.A.P.")},

		["BEER_BOMB"]						= {file_name = "beer_bomb",                     icon = "british_booze_bomb.png",            display_name = _('"Beer Bomb"')},
	}

	local sapExplRatio	= 0.2
	local gpExplRatio	= 0.3
	local mcExplRatio	= 0.5

	local function gp_warhead(power, caliber, fuze_delay)
		local res					= {};
		res.caliber					= caliber
		res.expl_mass				= power*gpExplRatio;
		res.mass					= res.expl_mass;
		res.other_factors			= {1, 1, 1};
		res.obj_factors				= {1, 1};
		res.concrete_factors		= {1, 1, 1};
		res.cumulative_factor		= 0;
		res.concrete_obj_factor		= 0.0;
		res.cumulative_thickness	= 0.0;
		res.piercing_mass			= res.mass/5.0;
		res.default_fuze_delay		= fuze_delay or 0;
		return res;
	end
	
	local function mc_warhead(power, caliber, fuze_delay)
		local res					= {};
		res.caliber					= caliber
		res.expl_mass				= power*mcExplRatio;
		res.mass					= res.expl_mass;
		res.other_factors			= {1, 1, 1};
		res.obj_factors				= {1, 1};
		res.concrete_factors		= {1, 1, 1};
		res.cumulative_factor		= 0;
		res.concrete_obj_factor		= 0.0;
		res.cumulative_thickness	= 0.0;
		res.piercing_mass			= res.mass/5.0;
		res.default_fuze_delay		= fuze_delay or 0;
		return res;
	end

	local function sap_warhead(power, caliber, fuze_delay)
		local res					= {};
		res.caliber					= caliber
		res.expl_mass				= power*sapExplRatio;
		res.mass					= res.expl_mass;
		res.other_factors			= {1, 1, 1};
		res.obj_factors				= {1, 1};
		res.concrete_factors		= {1, 1, 1};
		res.cumulative_factor		= 2.5;
		res.concrete_obj_factor		= 0.5;
		res.cumulative_thickness	= 0.2;
		res.piercing_mass			= res.mass/5.0;
		res.default_fuze_delay		= fuze_delay or 0;
		return res;
	end

    local dcswwii_carrier_models = {
        ["British_No1_EM_EF"] = {                   literal_name = "No1_EM_EF",                     mass = 7.71107, shape_name = "Carrier_N-1_EM_EF",   attach_point_name = "AttachPoint_Carrier_N_1_EM_EF",    connector_name = "AttachPoint"},
        ["British_Handley_Page_Type_B"] = {         literal_name = "Handley_Page_Type_B",           mass = 5.7,     shape_name = "Carrier_N-1_EM_EF",   attach_point_name = "AttachPoint_Carrier_N_1_EM_EF",    connector_name = "AttachPoint"},
        ["British_Handley_Page_Type_B_Cut_Bar"] = { literal_name = "Handley_Page_Type_B_Cut_Bar",   mass = 5.3,     shape_name = "Carrier_N-1_EM_EF",   attach_point_name = "AttachPoint_Carrier_N_1_EM_EF",    connector_name = "AttachPoint"},
    }

    local function declare_single_bomb_on_carrier ( bomb_data, carrier_data, carrier_draw_args, bomb_attach_point_name, bomb_settings )
        declare_loadout({category = CAT_BOMBS, CLSID = "{" .. bomb_data.name .. "_on_" .. carrier_data.literal_name .. "}", displayName = bomb_data.user_name,
            attribute       = {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
            wsTypeOfWeapon  = bomb_data.wsTypeOfWeapon,
            Count           = 1,
            Cx_pil          = bomb_data.Cx,
            Picture         = dcswwii_bomb_models[bomb_data.name].icon,
            PictureBlendColor = "0xffffffff",
            Weight          = bomb_data.mass + carrier_data.mass,
            Elements        = {
                [1] = {
                    ShapeName   = carrier_data.shape_name,
                    IsAdapter   = true,
                    --connector_name = "PYLON_1", -- to
                    attach_point_connector = carrier_data.attach_point_name, -- with
                    use_full_connector_position = true,
                    DrawArgs = carrier_draw_args,
                },
                [2] = {
                    connector_name = carrier_data.connector_name, -- to
                    attach_point_connector = bomb_attach_point_name, -- with
                    payload_CLSID = "{" .. bomb_data.name .. "}",
                    attach_point_oriented = true,
                },
            }, -- end of Elements
            settings = bomb_settings or {}
        })
    end



    -- British General Purpose Bomb, 250 lb., Mk. I ---------------------------------------
    British_GP_250LB_Bomb_Mk1 = {category = CAT_BOMBS, name = "British_GP_250LB_Bomb_Mk1", user_name = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk1"].display_name,
        model           = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk1"].file_name,
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 104.326,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00133,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.02,
		
        fm              = {
            mass        = 104.326,
            caliber     = 0.259,
            cx_coeff    = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
            L           = 0.660,
            I           = 246.037500,
            Ma          = 2.0,
            Mw          = 3.139597,
            wind_sigma  = 50.0,
			wind_time	= 1.0,
            cx_factor   = 300,
        },

        fuze = predefined_fuze("NP19"),

		warhead = gp_warhead(104,259),
		
        shape_table_data = {
            {
                name    = "British_GP_250LB_Bomb_Mk1";
                file    = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk1"].file_name;
                life    = 1;
                fire    = {0, 1};
                username = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk1"].display_name;
                index   = WSTYPE_PLACEHOLDER;
            },
        },
		
        targeting_data = {
            char_time   = 20.55, -- characteristic time for sights 
        },
    }
    declare_weapon(British_GP_250LB_Bomb_Mk1)
    declare_loadout({category = CAT_BOMBS, CLSID = "{British_GP_250LB_Bomb_Mk1}", displayName = British_GP_250LB_Bomb_Mk1.user_name,
        attribute       = British_GP_250LB_Bomb_Mk1.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = British_GP_250LB_Bomb_Mk1.Cx,
        Picture         = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk1"].icon,
        PictureBlendColor = "0xffffffff",
        Weight          = British_GP_250LB_Bomb_Mk1.mass,
        Elements        = {{ShapeName = British_GP_250LB_Bomb_Mk1.model}},
        settings        = PredefinedFuzeGUISettings("WWII_B_B_GPMkI")
    })
    -- end of British General Purpose Bomb, 250 lb., Mk. I --------------------------------



    -- British General Purpose Bomb, 250 lb., Mk. IV --------------------------------------
    British_GP_250LB_Bomb_Mk4 = {category = CAT_BOMBS, name = "British_GP_250LB_Bomb_Mk4", user_name = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk4"].display_name,
        model           = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk4"].file_name,
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 104.326,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00133,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.02,
		
        fm              = {
            mass        = 104.326,
            caliber     = 0.259,
            cx_coeff    = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
            L           = 0.660,
            I           = 246.037500,
            Ma          = 2.0,
            Mw          = 3.139597,
            wind_sigma  = 50.0,
			wind_time	= 1.0,
            cx_factor   = 300,
        },

        fuze = predefined_fuze("NP27"),

		warhead = gp_warhead(104,259),
		
        shape_table_data = {
            {
                name    = "British_GP_250LB_Bomb_Mk4";
                file    = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk4"].file_name;
                life    = 1;
                fire    = {0, 1};
                username = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk4"].display_name;
                index   = WSTYPE_PLACEHOLDER;
            },
        },
		
        targeting_data = {
            char_time   = 20.55, -- characteristic time for sights 
        },
    }
    declare_weapon(British_GP_250LB_Bomb_Mk4)
    declare_loadout({category = CAT_BOMBS, CLSID = "{British_GP_250LB_Bomb_Mk4}", displayName = British_GP_250LB_Bomb_Mk4.user_name,
        attribute       = British_GP_250LB_Bomb_Mk4.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = British_GP_250LB_Bomb_Mk4.Cx,
        Picture         = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk4"].icon,
        PictureBlendColor = "0xffffffff",
        Weight          = British_GP_250LB_Bomb_Mk4.mass,
        Elements        = {{ShapeName = British_GP_250LB_Bomb_Mk4.model}},
        settings        = PredefinedFuzeGUISettings("WWII_B_B_GPMkIV")
    })
    declare_single_bomb_on_carrier(British_GP_250LB_Bomb_Mk4, dcswwii_carrier_models.British_Handley_Page_Type_B_Cut_Bar, {{3, 0.1}}, "", PredefinedFuzeGUISettings("WWII_B_B_GPMkIV"))
    -- end of British General Purpose Bomb, 250 lb., Mk. IV -------------------------------



	-- British General Purpose Bomb, 250 lb., Mk. V ---------------------------------------
	British_GP_250LB_Bomb_Mk5 = {category = CAT_BOMBS, name = "British_GP_250LB_Bomb_Mk5", user_name = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk5"].display_name,
        model           = dcswwii_bomb_models["British_GP_250LB_Bomb_Mk5"].file_name,
		wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
		scheme          = "bomb_common_v2",
		type            = 0,
		mass            = 104.326,
		hMin            = 300.0,
		hMax            = 12000.0,
		Cx              = 0.00133,
		VyHold          = -100.0,
		Ag              = -1.23,
        Reflection      = 0.02,
		
		fm = {
			mass        = 104.326,
			caliber     = 0.259,
			cx_coeff    = {1.0, 0.39, 0.6, 0.168, 1.31},
			L           = 1.422,
			I           = 1/12 * 104.326 * 1.422 * 1.422,
			Ma          = 2.0,
			Mw          = 3.139597,
			wind_sigma  = 50.0,
			wind_time	= 1.0,
			cx_factor   = 300,
		},

		fuze = predefined_fuze("TP17"),
		
		warhead = gp_warhead(104,259,180),--30.73

		shape_table_data = {
			{
				name		= "British_GP_250LB_Bomb_Mk5";
				file		= dcswwii_bomb_models["British_GP_250LB_Bomb_Mk5"].file_name,
				life		= 1;
				fire		= {0, 1};
				username	= dcswwii_bomb_models["British_GP_250LB_Bomb_Mk5"].display_name,
				index		= WSTYPE_PLACEHOLDER;
            },
        },
		
		targeting_data = {
			char_time   = 20.55,
		},
	}
    declare_weapon(British_GP_250LB_Bomb_Mk5)
	declare_loadout({category = CAT_BOMBS, CLSID = "{British_GP_250LB_Bomb_Mk5}", displayName = British_GP_250LB_Bomb_Mk5.user_name,
		attribute			= British_GP_250LB_Bomb_Mk5.wsTypeOfWeapon,
		Count				= 1,
		Cx_pil				= British_GP_250LB_Bomb_Mk5.Cx,
		Picture				= dcswwii_bomb_models["British_GP_250LB_Bomb_Mk5"].icon,
		PictureBlendColor	= "0xffffffff",
		Weight				= British_GP_250LB_Bomb_Mk5.mass,
		Elements			= {{ShapeName = British_GP_250LB_Bomb_Mk5.model}},
		settings			= PredefinedFuzeGUISettings("WWII_B_B_GPMkV")
	})
    declare_single_bomb_on_carrier(British_GP_250LB_Bomb_Mk5, dcswwii_carrier_models.British_Handley_Page_Type_B_Cut_Bar, {{3, 0.1}}, "", PredefinedFuzeGUISettings("WWII_B_B_GPMkV"))
    -- end of British General Purpose Bomb, 250 lb., Mk. V --------------------------------



    -- British General Purpose Bomb, 500 lb., Mk. I ---------------------------------------
    British_GP_500LB_Bomb_Mk1 = {category = CAT_BOMBS, name = "British_GP_500LB_Bomb_Mk1", user_name = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk1"].display_name,
        model           = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk1"].file_name,
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 213.188,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00133,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.03,
		
        fm              = {
            mass        = 213.188,
            caliber     = 0.328,
            cx_coeff    = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
            L           = 1.778,
            I           = 246.037500,
            Ma          = 2.0,
            Mw          = 3.139597,
            wind_sigma  = 100.0,
			wind_time	= 1.0,
            cx_factor   = 300,
        },
		
        fuze = predefined_fuze("NP19"),

        --66.088
		warhead = gp_warhead(208,328),
       		
        shape_table_data = {
            {
                name    = "British_GP_500LB_Bomb_Mk1";
                file    = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk1"].file_name;
                life    = 1;
                fire    = {0, 1};
                username = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk1"].display_name;
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data = {
            char_time   = 20.55, -- characteristic time for sights 
        },
    }
    declare_weapon(British_GP_500LB_Bomb_Mk1)
    declare_loadout({category = CAT_BOMBS, CLSID = "{British_GP_500LB_Bomb_Mk1}", displayName = British_GP_500LB_Bomb_Mk1.user_name,
        attribute       = British_GP_500LB_Bomb_Mk1.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = British_GP_500LB_Bomb_Mk1.Cx,
        Picture         = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk1"].icon,
        PictureBlendColor = "0xffffffff",
        Weight          = British_GP_500LB_Bomb_Mk1.mass,
        Elements        = {{ShapeName = British_GP_500LB_Bomb_Mk1.model}},
        settings        = PredefinedFuzeGUISettings("WWII_B_B_GPMkI")
    })
    -- end of British General Purpose Bomb, 500 lb., Mk. I --------------------------------



    -- British General Purpose Bomb, 500 lb., Mk. IV --------------------------------------
    British_GP_500LB_Bomb_Mk4 = {category = CAT_BOMBS, name = "British_GP_500LB_Bomb_Mk4", user_name = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk4"].display_name,
        model           = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk4"].file_name,
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 213.188,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00133,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.03,
		
        fm              = {
            mass        = 213.188,
            caliber     = 0.328,
            cx_coeff    = {1.000000, 0.390000, 0.600000, 0.168000, 1.310000},
            L           = 1.778,
            I           = 246.037500,
            Ma          = 2.0,
            Mw          = 3.139597,
            wind_sigma  = 100.0,
			wind_time	= 1.0,
            cx_factor   = 300,
        },

        fuze = predefined_fuze("NP27"),

		--66.088
		warhead = gp_warhead(208,328),
       		
        shape_table_data = {
            {
                name    = "British_GP_500LB_Bomb_Mk4";
                file    = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk4"].file_name;
                life    = 1;
                fire    = {0, 1};
                username = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk4"].display_name;
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data = {
            char_time   = 20.55, -- characteristic time for sights 
        },
    }
    declare_weapon(British_GP_500LB_Bomb_Mk4)
    declare_loadout({category = CAT_BOMBS, CLSID = "{British_GP_500LB_Bomb_Mk4}", displayName = British_GP_500LB_Bomb_Mk4.user_name,
        attribute       = British_GP_500LB_Bomb_Mk4.wsTypeOfWeapon,
        Count           = 1,
        Cx_pil          = British_GP_500LB_Bomb_Mk4.Cx,
        Picture         = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk4"].icon,
        PictureBlendColor = "0xffffffff",
        Weight          = British_GP_500LB_Bomb_Mk4.mass,
        Elements        = {{ShapeName = British_GP_500LB_Bomb_Mk4.model}},
        settings        = PredefinedFuzeGUISettings("WWII_B_B_GPMkIV")
    })
    -- end of British General Purpose Bomb, 500 lb., Mk. IV -------------------------------



	-- British General Purpose Bomb, 500 lb., MK. IV, Short Tail Type ---------------------
	British_GP_500LB_Bomb_Mk4_Short = {category = CAT_BOMBS, name = "British_GP_500LB_Bomb_Mk4_Short", user_name = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk4_Short"].display_name,
        model           = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk4_Short"].file_name,
		wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
		scheme          = "bomb_common_v2",
		type            = 0,
		mass            = 207.7,
		hMin            = 300.0,
		hMax            = 12000.0,
		Cx              = 0.00133,
		VyHold          = -100.0,
		Ag              = -1.23,
        Reflection      = 0.03,
		
		fm = {
			mass        = 207.7,
			caliber     = 0.328,
			cx_coeff    = {1.0, 0.39, 0.6, 0.168, 1.31},
			L           = 1.412,
			I           = 1/12 * 207.7 * 1.412 * 1.412,
			Ma          = 2.0,
			Mw          = 3.139597,
			wind_sigma  = 100.0,
			wind_time	= 1.0,
			cx_factor   = 300,
		},

		fuze = predefined_fuze("NP27"),

		warhead = gp_warhead(208,328), --65.5
		
		shape_table_data = 
		{
			{
				index		= WSTYPE_PLACEHOLDER,
				name		= "British_GP_500LB_Bomb_Mk4_Short",
				username	= dcswwii_bomb_models["British_GP_500LB_Bomb_Mk4_Short"].display_name,
				file		= dcswwii_bomb_models["British_GP_500LB_Bomb_Mk4_Short"].file_name,
				life		= 1,
				fire		= {0, 1},				
            },
        },
		
		targeting_data = {
			char_time   = 20.48,
		},
	}
    declare_weapon(British_GP_500LB_Bomb_Mk4_Short)
	declare_loadout({category = CAT_BOMBS, CLSID = "{British_GP_500LB_Bomb_Mk4_Short}", displayName = British_GP_500LB_Bomb_Mk4_Short.user_name,
		attribute			= British_GP_500LB_Bomb_Mk4_Short.wsTypeOfWeapon,
		Count				= 1,
		Cx_pil				= British_GP_500LB_Bomb_Mk4_Short.Cx,
		Picture				= dcswwii_bomb_models["British_GP_500LB_Bomb_Mk4_Short"].icon,
		PictureBlendColor	= "0xffffffff",
		Weight				= British_GP_500LB_Bomb_Mk4_Short.mass,
		Elements			= {{ShapeName = British_GP_500LB_Bomb_Mk4_Short.model}},
		settings			= PredefinedFuzeGUISettings("WWII_B_B_GPMkIV")
	})
    declare_single_bomb_on_carrier(British_GP_500LB_Bomb_Mk4_Short, dcswwii_carrier_models.British_Handley_Page_Type_B_Cut_Bar, {{3, 0.45}}, "", PredefinedFuzeGUISettings("WWII_B_B_GPMkIV"))
	-- end of British General Purpose Bomb, 500 lb., Mk. IV, Short Tail Type --------------



	-- British General Purpose Bomb, 500 lb., Mk. V ---------------------------------------
	British_GP_500LB_Bomb_Mk5 = {category = CAT_BOMBS, name = "British_GP_500LB_Bomb_Mk5", user_name = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk5"].display_name,
        model           = dcswwii_bomb_models["British_GP_500LB_Bomb_Mk5"].file_name,
		wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
		scheme          = "bomb_common_v2",
		type            = 0,
		mass            = 213.188,
		hMin            = 300.0,
		hMax            = 12000.0,
		Cx              = 0.00133,
		VyHold          = -100.0,
		Ag              = -1.23,
        Reflection      = 0.03,
		
		fm = {
			mass        = 213.188,
			caliber     = 0.328,
			cx_coeff    = {1.0, 0.39, 0.6, 0.168, 1.31},
			L           = 1.793,
			I           = 1/12 * 213.188 * 1.793 * 1.793,
			Ma          = 2.0,
			Mw          = 3.139597,
			wind_sigma  = 100.0,
			wind_time	= 1.0,
			cx_factor   = 300,
		},

		fuze = predefined_fuze("TP17"),

		warhead = gp_warhead(208,328), --65.5
		
		shape_table_data = 
		{
			{
				index		= WSTYPE_PLACEHOLDER,
				name		= "British_GP_500LB_Bomb_Mk5",
				username	= dcswwii_bomb_models["British_GP_500LB_Bomb_Mk5"].display_name,
				file		= dcswwii_bomb_models["British_GP_500LB_Bomb_Mk5"].file_name,
				life		= 1,
				fire		= {0, 1},				
            },
        },
		
		targeting_data = {
			char_time   = 20.48,
		},
	}
    declare_weapon(British_GP_500LB_Bomb_Mk5)
	declare_loadout({category = CAT_BOMBS, CLSID = "{British_GP_500LB_Bomb_Mk5}", displayName = British_GP_500LB_Bomb_Mk5.user_name,
		attribute			= British_GP_500LB_Bomb_Mk5.wsTypeOfWeapon,
		Count				= 1,
		Cx_pil				= British_GP_500LB_Bomb_Mk5.Cx,
		Picture				= dcswwii_bomb_models["British_GP_500LB_Bomb_Mk5"].icon,
		PictureBlendColor	= "0xffffffff",
		Weight				= British_GP_500LB_Bomb_Mk5.mass,
		Elements			= {{ShapeName = British_GP_500LB_Bomb_Mk5.model}},
		settings			= PredefinedFuzeGUISettings("WWII_B_B_GPMkV")
	})
	-- end of British General Purpose Bomb, 500 lb., Mk. V --------------------------------



	-- British Medium Capacity Bomb, 250 lb., Mk. I ---------------------------------------
	British_MC_250LB_Bomb_Mk1 = {category = CAT_BOMBS, name = "British_MC_250LB_Bomb_Mk1", user_name = dcswwii_bomb_models["British_MC_250LB_Bomb_Mk1"].display_name,
        model           = dcswwii_bomb_models["British_MC_250LB_Bomb_Mk1"].file_name,
		wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
		scheme          = "bomb_common_v2",
		type            = 0,
		mass            = 102.0,
		hMin            = 300.0,
		hMax            = 12000.0,
		Cx              = 0.00133,
		VyHold          = -100.0,
		Ag              = -1.23,
        Reflection      = 0.02,
		
		fm = {
			mass        = 102.0,
			caliber     = 0.254,
			cx_coeff    = {1.0, 0.39, 0.6, 0.168, 1.31},
			L           = 1.384,
			I           = 1/12 * 102 * 1.348 * 1.384,
			Ma          = 2.0,
			Mw          = 3.139597,
			wind_sigma  = 50.0,
			wind_time	= 1.0,
			cx_factor   = 300,
		},

		fuze = predefined_fuze("NP27"),

		warhead = mc_warhead(102, 254), --51
		
		shape_table_data = {
			{
				name		= "British_MC_250LB_Bomb_Mk1",
				file		= dcswwii_bomb_models["British_MC_250LB_Bomb_Mk1"].file_name,
				life		= 1,
				fire		= {0, 1},
				username	= dcswwii_bomb_models["British_MC_250LB_Bomb_Mk1"].display_name,
				index		= WSTYPE_PLACEHOLDER,
            },
        },
		
		targeting_data = {
			char_time   = 20.55,
		},
	}
    declare_weapon(British_MC_250LB_Bomb_Mk1)
	declare_loadout({category = CAT_BOMBS, CLSID = "{British_MC_250LB_Bomb_Mk1}", displayName = British_MC_250LB_Bomb_Mk1.user_name,
		attribute			= British_MC_250LB_Bomb_Mk1.wsTypeOfWeapon,
		Count				= 1,
		Cx_pil				= British_MC_250LB_Bomb_Mk1.Cx,
		Picture				= dcswwii_bomb_models["British_MC_250LB_Bomb_Mk1"].icon,
		PictureBlendColor	= "0xffffffff",
		Weight				= British_MC_250LB_Bomb_Mk1.mass,
		Elements			= {{ShapeName = British_MC_250LB_Bomb_Mk1.model}},
        settings            = PredefinedFuzeGUISettings("WWII_B_B_GPMkIV")
	})
    declare_single_bomb_on_carrier(British_MC_250LB_Bomb_Mk1, dcswwii_carrier_models.British_Handley_Page_Type_B_Cut_Bar, {{3, 0.25}}, "", PredefinedFuzeGUISettings("WWII_B_B_GPMkIV"))
    -- end of British Medium Capacity Bomb, 250 lb., Mk. I --------------------------------



	-- British Medium Capacity Bomb, 250 lb., Mk. II --------------------------------------
	British_MC_250LB_Bomb_Mk2 = {category = CAT_BOMBS, name = "British_MC_250LB_Bomb_Mk2", user_name = dcswwii_bomb_models["British_MC_250LB_Bomb_Mk2"].display_name,
        model           = dcswwii_bomb_models["British_MC_250LB_Bomb_Mk2"].file_name,
		wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
		scheme          = "bomb_common_v2",
		type            = 0,
		mass            = 102.0,
		hMin            = 300.0,
		hMax            = 12000.0,
		Cx              = 0.00133,
		VyHold          = -100.0,
		Ag              = -1.23,
        Reflection      = 0.02,
		
		fm = {
			mass        = 102.0,
			caliber     = 0.254,
			cx_coeff    = {1.0, 0.39, 0.6, 0.168, 1.31},
			L           = 1.384,
			I           = 1/12 * 102 * 1.348 * 1.384,
			Ma          = 2.0,
			Mw          = 3.139597,
			wind_sigma  = 500.0,
			wind_time	= 1.0,
			cx_factor   = 300,
		},

		fuze = predefined_fuze("NP27"),

		warhead = mc_warhead(102, 254), --51
		
		shape_table_data = {
			{
				name		= "British_MC_250LB_Bomb_Mk2";
				file		= dcswwii_bomb_models["British_MC_250LB_Bomb_Mk2"].file_name,
				life		= 1;
				fire		= {0, 1};
				username	= dcswwii_bomb_models["British_MC_250LB_Bomb_Mk2"].display_name,
				index		= WSTYPE_PLACEHOLDER;
            },
        },
		
		targeting_data = {
			char_time   = 20.55,
		},
	}
    declare_weapon(British_MC_250LB_Bomb_Mk2)
	declare_loadout({category = CAT_BOMBS, CLSID = "{British_MC_250LB_Bomb_Mk2}", displayName = British_MC_250LB_Bomb_Mk2.user_name,
		attribute			= British_MC_250LB_Bomb_Mk2.wsTypeOfWeapon,
		Count				= 1,
		Cx_pil				= British_MC_250LB_Bomb_Mk2.Cx,
		Picture				= dcswwii_bomb_models["British_MC_250LB_Bomb_Mk2"].icon,
		PictureBlendColor	= "0xffffffff",
		Weight				= British_MC_250LB_Bomb_Mk2.mass,
		Elements			= {{ShapeName = British_MC_250LB_Bomb_Mk2.model}},
		settings			= PredefinedFuzeGUISettings("WWII_B_B_GPMkIV")
	})
    declare_single_bomb_on_carrier(British_MC_250LB_Bomb_Mk2, dcswwii_carrier_models.British_Handley_Page_Type_B_Cut_Bar, {{3, 0.25}}, "", PredefinedFuzeGUISettings("WWII_B_B_GPMkIV"))
    -- end of British Medium Capacity Bomb, 250 lb., Mk. II -------------------------------



	-- British Medium Capacity Bomb, 500 lb., Mk. I, Short Tail Type ----------------------
	British_MC_500LB_Bomb_Mk1_Short = {category = CAT_BOMBS, name = "British_MC_500LB_Bomb_Mk1_Short", user_name = dcswwii_bomb_models["British_MC_500LB_Bomb_Mk1_Short"].display_name,
        model           = dcswwii_bomb_models["British_MC_500LB_Bomb_Mk1_Short"].file_name,
		wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
		scheme          = "bomb_common_v2",
		type            = 0,
		mass            = 226.3,
		hMin            = 300.0,
		hMax            = 12000.0,
		Cx              = 0.00133,
		VyHold          = -100.0,
		Ag              = -1.23,
        Reflection      = 0.03,
		
		fm = {
			mass        = 226.3,
			caliber     = 0.328,
			cx_coeff    = {1.0, 0.39, 0.6, 0.168, 1.31},
			L           = 1.468,
			I           = 1/12 * 226.3 * 1.468 * 1.468,
			Ma          = 2.0,
			Mw          = 3.139597,
			wind_sigma  = 100.0,
			wind_time	= 1.0,
			cx_factor   = 300,
		},

		fuze = predefined_fuze("NP27"),

		warhead = mc_warhead(210,328), --100.7
		
		shape_table_data = 
		{
			{
				index		= WSTYPE_PLACEHOLDER,
				name		= "British_MC_500LB_Bomb_Mk1_Short",
				username	= dcswwii_bomb_models["British_MC_500LB_Bomb_Mk1_Short"].display_name,
				file		= dcswwii_bomb_models["British_MC_500LB_Bomb_Mk1_Short"].file_name,
				life		= 1,
				fire		= {0, 1},				
            },
        },
		
		targeting_data = {
			char_time   = 20.46,
		},
	}
    declare_weapon(British_MC_500LB_Bomb_Mk1_Short)
	declare_loadout({category = CAT_BOMBS, CLSID = "{British_MC_500LB_Bomb_Mk1_Short}", displayName = British_MC_500LB_Bomb_Mk1_Short.user_name,
		attribute			= British_MC_500LB_Bomb_Mk1_Short.wsTypeOfWeapon,
		Count				= 1,
		Cx_pil				= British_MC_500LB_Bomb_Mk1_Short.Cx,
		Picture				= dcswwii_bomb_models["British_MC_500LB_Bomb_Mk1_Short"].icon,
		PictureBlendColor	= "0xffffffff",
		Weight				= British_MC_500LB_Bomb_Mk1_Short.mass,
		Elements			= {{ShapeName = British_MC_500LB_Bomb_Mk1_Short.model}},
		settings			= PredefinedFuzeGUISettings("WWII_B_B_GPMkIV")
	})
    declare_single_bomb_on_carrier(British_MC_500LB_Bomb_Mk1_Short, dcswwii_carrier_models.British_Handley_Page_Type_B_Cut_Bar, {{3, 0.65}}, "", PredefinedFuzeGUISettings("WWII_B_B_GPMkIV"))
	-- end of British Medium Capacity Bomb, 500 lb., Mk. I, Short Tail Type ---------------



	-- British Medium Capacity Bomb, 500 lb., Mk. II --------------------------------------
	British_MC_500LB_Bomb_Mk2 = {category = CAT_BOMBS, name = "British_MC_500LB_Bomb_Mk2", user_name = dcswwii_bomb_models["British_MC_500LB_Bomb_Mk2"].display_name,
        model           = dcswwii_bomb_models["British_MC_500LB_Bomb_Mk2"].file_name,
		wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
		scheme          = "bomb_common_v2",
		type            = 0,
		mass            = 231.8,
		hMin            = 300.0,
		hMax            = 12000.0,
		Cx              = 0.00133,
		VyHold          = -100.0,
		Ag              = -1.23,
        Reflection      = 0.03,
		
		fm = {
			mass        = 231.8,
			caliber     = 0.328,
			cx_coeff    = {1.0, 0.39, 0.6, 0.168, 1.31},
			L           = 1.793,
			I           = 1/12 * 231.8 * 1.793 * 1.793,
			Ma          = 2.0,
			Mw          = 3.139597,
			wind_sigma  = 100.0,
			wind_time	= 1.0,
			cx_factor   = 300,
		},

		fuze = predefined_fuze("NP27"),

		warhead = mc_warhead(210,328), --100.7
		
		shape_table_data = 
		{
			{
				index		= WSTYPE_PLACEHOLDER,
				name		= "British_MC_500LB_Bomb_Mk2",
				username	= dcswwii_bomb_models["British_MC_500LB_Bomb_Mk2"].display_name,
				file		= dcswwii_bomb_models["British_MC_500LB_Bomb_Mk2"].file_name,
				life		= 1,
				fire		= {0, 1},				
            },
        },
		
		targeting_data = {
			char_time   = 20.46,
		},
	}
    declare_weapon(British_MC_500LB_Bomb_Mk2)
	declare_loadout({category = CAT_BOMBS, CLSID = "{British_MC_500LB_Bomb_Mk2}", displayName = British_MC_500LB_Bomb_Mk2.user_name,
		attribute			= British_MC_500LB_Bomb_Mk2.wsTypeOfWeapon,
		Count				= 1,
		Cx_pil				= British_MC_500LB_Bomb_Mk2.Cx,
		Picture				= dcswwii_bomb_models["British_MC_500LB_Bomb_Mk2"].icon,
		PictureBlendColor	= "0xffffffff",
		Weight				= British_MC_500LB_Bomb_Mk2.mass,
		Elements			= {{ShapeName = British_MC_500LB_Bomb_Mk2.model}},
		settings			= PredefinedFuzeGUISettings("WWII_B_B_GPMkIV")
	})
	-- end of British Medium Capacity Bomb, 500 lb., Mk. II -------------------------------



	-- British Semi-Armour Piercing Bomb, 250 lb., Mk. V ----------------------------------
	British_SAP_250LB_Bomb_Mk5 = {category = CAT_BOMBS, name = "British_SAP_250LB_Bomb_Mk5", user_name = dcswwii_bomb_models["British_SAP_250LB_Bomb_Mk5"].display_name,
        model           = dcswwii_bomb_models["British_SAP_250LB_Bomb_Mk5"].file_name,
		wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
		scheme          = "bomb_common_v2",
		type            = 0,
		mass            = 111.13,
		hMin            = 300.0,
		hMax            = 12000.0,
		Cx              = 0.00133,
		VyHold          = -100.0,
		Ag              = -1.23,
        Reflection      = 0.02,
		
		fm = {
			mass        = 111.13,
			caliber     = 0.234,
			cx_coeff    = {1.0, 0.39, 0.6, 0.168, 1.31},
			L           = 0.800,
			I           = 1/12 * 111.13 * 0.800 * 0.800,
			Ma          = 2.0,
			Mw          = 3.139597,
			wind_sigma  = 100.0,
			wind_time	= 1.0,
			cx_factor   = 300,
        },

		fuze = predefined_fuze("TP30"),
		
		warhead = sap_warhead(110, 234, 0.01), --18.37

		shape_table_data = {
			{
				name		= "British_SAP_250LB_Bomb_Mk5";
				file		= dcswwii_bomb_models["British_SAP_250LB_Bomb_Mk5"].file_name,
				life		= 1;
				fire		= {0, 1};
				username	= dcswwii_bomb_models["British_SAP_250LB_Bomb_Mk5"].display_name,
				index		= WSTYPE_PLACEHOLDER;
            },
        },
		
		targeting_data = {
			char_time   = 20.49,
		},
	}
    declare_weapon(British_SAP_250LB_Bomb_Mk5)
	declare_loadout({category = CAT_BOMBS, CLSID = "{British_SAP_250LB_Bomb_Mk5}", displayName = British_SAP_250LB_Bomb_Mk5.user_name,
		attribute			= British_SAP_250LB_Bomb_Mk5.wsTypeOfWeapon,
		Count				= 1,
		Cx_pil				= British_SAP_250LB_Bomb_Mk5.Cx,
		Picture				= dcswwii_bomb_models["British_SAP_250LB_Bomb_Mk5"].icon,
		PictureBlendColor	= "0xffffffff",
		Weight				= British_SAP_250LB_Bomb_Mk5.mass,
		Elements			= {{ShapeName = British_SAP_250LB_Bomb_Mk5.model}},
		settings			= PredefinedFuzeGUISettings("WWII_B_B_SAP")
	})
    declare_single_bomb_on_carrier(British_SAP_250LB_Bomb_Mk5, dcswwii_carrier_models.British_Handley_Page_Type_B_Cut_Bar, {{3, 0.0}}, "", PredefinedFuzeGUISettings("WWII_B_B_SAP"))
    -- end of British Semi-Armour Piercing Bomb, 250 lb., Mk. V ---------------------------



	-- British Semi-Armour Piercing Bomb, 500 lb., Mk. V ----------------------------------
	British_SAP_500LB_Bomb_Mk5 = {category = CAT_BOMBS, name = "British_SAP_500LB_Bomb_Mk5", user_name = dcswwii_bomb_models["British_SAP_500LB_Bomb_Mk5"].display_name,
        model           = dcswwii_bomb_models["British_SAP_500LB_Bomb_Mk5"].file_name,
		wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
		scheme          = "bomb_common_v2",
		type            = 0,
		mass            = 222.26,
		hMin            = 300.0,
		hMax            = 12000.0,
		Cx              = 0.00133,
		VyHold          = -100.0,
		Ag              = -1.23,
        Reflection      = 0.03,
		
		fm = {
			mass        = 222.26,
			caliber     = 0.292,
			cx_coeff    = {1.0, 0.39, 0.6, 0.168, 1.31},
			L           = 1.575,
			I           = 1/12 * 222.26 * 1.575 * 1.575,
			Ma          = 2.0,
			Mw          = 3.139597,
			wind_sigma  = 100.0,
			wind_time	= 1.0,
			cx_factor   = 300,
		},

		fuze = predefined_fuze("TP30"),
		
		warhead = sap_warhead(220,328,0.01), --40.37

		shape_table_data = 
		{
			{
				index		= WSTYPE_PLACEHOLDER,
				name		= "British_SAP_500LB_Bomb_Mk5",
				username	= dcswwii_bomb_models["British_SAP_500LB_Bomb_Mk5"].display_name,
				file		= dcswwii_bomb_models["British_SAP_500LB_Bomb_Mk5"].file_name,
				life		= 1,
				fire		= {0, 1},				
            },
        },
		
		targeting_data = {
			char_time   = 20.43,
		},
	}
    declare_weapon(British_SAP_500LB_Bomb_Mk5)
	declare_loadout({category = CAT_BOMBS, CLSID = "{British_SAP_500LB_Bomb_Mk5}", displayName = British_SAP_500LB_Bomb_Mk5.user_name,
		attribute			= British_SAP_500LB_Bomb_Mk5.wsTypeOfWeapon,
		Count				= 1,
		Cx_pil				= British_SAP_500LB_Bomb_Mk5.Cx,
		Picture				= dcswwii_bomb_models["British_SAP_500LB_Bomb_Mk5"].icon,
		PictureBlendColor	= "0xffffffff",
		Weight				= British_SAP_500LB_Bomb_Mk5.mass,
		Elements			= {{ShapeName = British_SAP_500LB_Bomb_Mk5.model}},
		settings			= PredefinedFuzeGUISettings("WWII_B_B_SAP")
	})
    -- end of British Semi-Armour Piercing Bomb, 500 lb., Mk. V ---------------------------



    -- US General Purpose High Explosive Bomb, 100 lb GP, AN-M30A1 ------------------------
    AN_M30A1 = {category = CAT_BOMBS, name = "AN_M30A1", user_name = _("AN-M30A1"),
        model           = "AN-M30A1",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 45.8,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00025,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.01,
		
        fm	= {
            mass        = 45.8,
            caliber     = 0.207,
            cx_coeff    = {1.0, 0.39, 0.38, 0.236, 1.31},
            L           = 0.976,
            I           = 1/12 * 45.8 * 0.976 * 0.976,
            Ma          = 0.141338,
            Mw          = 2.244756,
            wind_sigma  = 30,
        },

        fuze = predefined_fuze("ANM10xA2"),

        warhead         = simple_warhead(45, 207),
		
        shape_table_data = {
            {
                name    = "AN_M30A1";
                file    = "AN-M30A1";
                life    = 1;
                fire    = {0, 1};
                username = _("AN-M30A1"),
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data  = {
            char_time   = 20.83, -- characteristic time for sights 
        },
    }
    declare_weapon(AN_M30A1)
    declare_loadout({category = CAT_BOMBS, CLSID = "{AN_M30A1}", displayName = _("AN-M30A1 - 100lb GP Bomb LD"),
		attribute		= AN_M30A1.wsTypeOfWeapon,
		Count 			= 1,
		Cx_pil			= AN_M30A1.Cx,
        Picture = "us_AN-M30.png",
        PictureBlendColor = "0xffffffff",
		Weight			= AN_M30A1.mass,
		Elements  		= {{ShapeName = AN_M30A1.model}},
		settings		= PredefinedFuzeGUISettings("WWII_B_A_GPSmall")
	})
    -- end of US General Purpose High Explosive Bomb, 100 lb GP, AN-M30A1 -----------------



    -- US General Purpose High Explosive Bomb, 250 lb GP, AN-M57 --------------------------
    AN_M57 = {category = CAT_BOMBS, name = "AN_M57", user_name = _("AN-M57"),
        model           = "AN-M57",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 113.0,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00035,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.025,
		
        fm	= {
            mass        = 113.0,
            caliber     = 0.277,
            cx_coeff    = {1.0, 0.39, 0.38, 0.236, 1.31},
            L           = 1.214,
            I           = 1/12 * 113.0 * 1.214 * 1.214,
            Ma          = 0.141338,
            Mw          = 2.244756,
            wind_sigma  = 30,
        },

        fuze = predefined_fuze("ANM10xA2"),

        warhead         = simple_warhead(90, 277),
		
        shape_table_data = {
            {
                name    = "AN_M57";
                file    = "AN-M57";
                life    = 1;
                fire    = {0, 1};
                username = _("AN-M57"),
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data  = {
            char_time   = 20.68, -- characteristic time for sights 
        },
    }
    declare_weapon(AN_M57)
    declare_loadout({category = CAT_BOMBS, CLSID = "{AN_M57}", displayName = _("AN-M57 - 250lb GP Bomb LD"),
		attribute		= AN_M57.wsTypeOfWeapon,
		Count 			= 1,
		Cx_pil			= AN_M57.Cx,
        Picture = "us_AN-M57.png",
        PictureBlendColor = "0xffffffff",
		Weight			= AN_M57.mass,
		Elements  		= {{ShapeName = AN_M57.model}},
		settings		= PredefinedFuzeGUISettings("WWII_B_A_GPSmall")
	})
    -- end of US General Purpose High Explosive Bomb, 250 lb GP, AN-M57 -------------------



    -- US General Purpose High Explosive Bomb, 500 lb GP, AN-M64 --------------------------
    -- Ref. Scripts\Database\db_weapons_data.lua
    -- CLSID = "{AN-M64}",
    -- end of US General Purpose High Explosive Bomb, 500 lb GP, AN-M64 -------------------



    -- US General Purpose High Explosive Bomb, 1000 lb GP, AN-M65 -------------------------
    AN_M65 = {category = CAT_BOMBS, name = "AN_M65", user_name = _("AN-M65"),
        model           = "AN-M65",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 475.0,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.00056,
        VyHold          = -100.0,
        Ag              = -1.23,
        Reflection      = 0.035,
		
        fm	= {
            mass        = 475.0,
            caliber     = 0.477,
            cx_coeff    = {1.0, 0.39, 0.38, 0.236, 1.31},
            L           = 1.765,
            I           = 1/12 * 475.0 * 1.765 * 1.765,
            Ma          = 0.141338,
            Mw          = 2.244756,
            wind_sigma  = 30,
        },

        fuze = predefined_fuze("ANM10xA2"),

        warhead         = simple_warhead(360, 477, 0.01),

        shape_table_data = {
            {
                name    = "AN_M65";
                file    = "AN-M65";
                life    = 1;
                fire    = {0, 1};
                username = _("AN-M65"),
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data  = {
            char_time   = 20.57, -- characteristic time for sights 
        },
    }
    declare_weapon(AN_M65)
    declare_loadout({category = CAT_BOMBS, CLSID = "{AN_M65}", displayName = _("AN-M65 - 1000lb GP Bomb LD"),
		attribute		= AN_M65.wsTypeOfWeapon,
		Count 			= 1,
		Cx_pil			= AN_M65.Cx,
        Picture = "us_AN-M44.png",
        PictureBlendColor = "0xffffffff",
		Weight			= AN_M65.mass,
		Elements  		= {{ShapeName = AN_M65.model}},
        settings        = PredefinedFuzeGUISettings("WWII_B_A_GPLarge")
	})
    -- end of US General Purpose High Explosive Bomb, 1000 lb GP, AN-M65 ------------------



    -- US General Purpose High Explosive Bomb, 2000 lb GP, AN-M66 -------------------------
    AN_M66 = {category = CAT_BOMBS, name = "AN_M66", user_name = _("AN-M66"),
        model           = "AN-M66",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
        scheme          = "bomb_common_v2",
        type            = 0,
        mass            = 977.0,
        hMin            = 300.0,
        hMax            = 12000.0,
        Cx              = 0.0008,
        VyHold          = -100.0,
        Ag              = -1.23,
		
        fm	= {
            mass        = 977.0,
            caliber     = 0.585,
            cx_coeff    = {1.0, 0.39, 0.38, 0.236, 1.31},
            L           = 2.33,
            I           = 1/12 * 977.0 * 2.33 * 2.33,
            Ma          = 0.141338,
            Mw          = 2.244756,
            wind_sigma  = 30,
        },

        fuze = predefined_fuze("ANM10xA2"),

        warhead         = simple_warhead(750, 585, 0.01), --1,156 pounds of explosive +fragments

        shape_table_data = {
            {
                name    = "AN_M66";
                file    = "AN-M66";
                life    = 1;
                fire    = {0, 1};
                username = _("AN-M66"),
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        targeting_data  = {
            char_time   = 20.48, -- characteristic time for sights 
        },
    }
    declare_weapon(AN_M66)
    declare_loadout({category = CAT_BOMBS, CLSID = "{AN_M66}", displayName = _("AN-M66 - 2000lb GP Bomb LD"),
		attribute			= AN_M66.wsTypeOfWeapon,
		Count 				= 1,
		Cx_pil				= AN_M66.Cx,
        Picture				= "us_AN-M44.png",
        PictureBlendColor	= "0xffffffff",
		Weight				= AN_M66.mass,
		Elements  			= {{ShapeName = AN_M66.model}},
        settings            = PredefinedFuzeGUISettings("WWII_B_A_GPLarge")
	})
    -- end of US General Purpose High Explosive Bomb, 2000 lb GP, AN-M66 ------------------



-- end of Defining drop ordnance ----------------------------------------------------------









-- Defining unguided rocket shells --------------------------------------------------------



    -- R4M --------------------------------------------------------------------------------
    R4M = {category = CAT_ROCKETS, name = "R4M", user_name = _("R4M 3.2kg UnGd air-to-air rocket"),
        model           = "R4M",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER},
        scheme          = "nurs-standard",
        fm = 
        {
            mass        = 3.85,-- weight with kg
            caliber     = 0.055,  
            cx_coeff    = {1,0.91,0.67,0.3248,2.08},
            L           = 0.812,--length meters
            I           = 1.7240,-- kgm2 - moment of inertia  I = 1/12 ML2
            Ma          = 0.23322,-- dependence moment coefficient of  by  AoA angular acceleration  T / I
            Mw          = 2.177036,--rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t     
            wind_time   = 3.0,-- dispersion coefficient
            wind_sigma  = 20.0,
            shapeName   = "R4M",
            rail_open   = true,
        },
        engine = 
        {
            fuel_mass          = 0.815, -- mass of fuel in kg
            impulse            = 150, -- engine perfomance
            boost_time         = 0,
            work_time          = 0.8,-- time of engine work , fuel burn rate will be calculated using fuel mass and this time 
            boost_factor       = 1,
            nozzle_position    =  {{-0.35, 0, 0}}, -- effect placement
            tail_width         = 0.052,-- effect scale 
            boost_tail         = 1,
            work_tail          = 1,
            smoke_color        = {0.6, 0.6, 0.6},
            smoke_transparency = 0.3,
        },
        warhead = 
        {
            mass                    = 0.52,
            expl_mass               = 0.52,
            other_factors           = {1.0, 1.0, 1.0};
            concrete_factors        = {1.0, 1.0, 1.0};
            obj_factors             = { 1.0, 1.0 },
            cumulative_factor       = 1;
            concrete_obj_factor     = 1.0;
            cumulative_thickness    = 0.3;
            piercing_mass           = 0.52/5.0;
            caliber                 = 55;
        },
        shape_table_data = 
        {
            {
                name     = "R4M",
                file     = "R4M",
                life     = 1,
                fire     = {0, 1},
                username = "R4M",
                index    = WSTYPE_PLACEHOLDER,
            },
        },
        properties = 
        {
            dist_min = 600,   -- min range, meters
            dist_max = 1200,  -- max range, meters
        }
    }
    declare_weapon(R4M)
    -- end of R4M -------------------------------------------------------------------------



    -- Wfr. Gr. 21 ------------------------------------------------------------------------
    WGr21 = {category = CAT_ROCKETS, name = "WGr21", user_name = _("Werfer-Granate 21"),
        model           = "WGr21",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER},
        scheme          = "nurs_standard_v2",
        fm =
        {
            mass        = 111,-- weight with kg
            caliber     = 0.210,
            cx_coeff    = {1,0.8889618,0.67,0.3172910,2.08},
            L           = 1.26,--length meters
            I           = 96.5145,-- kgm2 - moment of inertia  I = 1/12 ML2
            Ma          = 0.1720553,-- dependence moment coefficient of  by  AoA angular acceleration  T / I
            Mw          = 6.106276,--rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t     
            wind_time   = 1.3,-- dispersion coefficient
            wind_sigma  = 10,
            shapeName   = "WGr21",
			derivation 	= 0.41,
        },
        engine =
        {
            fuel_mass          = 18.4, -- mass of fuel in kg
            impulse            = 170, -- engine perfomance
            boost_time         = 0,
            work_time          = 0.8,-- time of engine work , fuel burn rate will be calculated using fuel mass and this time 
            boost_factor       = 1,
            nozzle_position    = {{-0.65, 0, 0}}, -- effect placement
            tail_width         = 0.1,-- effect scale 
            boost_tail         = 1,
            work_tail          = 1,
            smoke_color        = {0.6, 0.6, 0.6},
            smoke_transparency = 0.3,
            custom_smoke_dissipation_factor = 0.5,
        },
        warhead =
        {
            mass                    = 40.8,
            expl_mass               = 40.8,
            other_factors           = {1.0, 1.0, 1.0};
            concrete_factors        = {1.0, 1.0, 1.0};
            obj_factors             = { 1.0, 1.0 },
            cumulative_factor       = 1;
            concrete_obj_factor     = 1.0;
            cumulative_thickness    = 0.0;
            piercing_mass           = 40.8/5.0;
            caliber                 = 210;
        },
        shape_table_data =
        {
            {
                name     = "WGr21",
                file     = "WGr21",
                life     = 1,
                fire     = {0, 1},
                username = "WGr21",
                index    = WSTYPE_PLACEHOLDER,
            },
        },
        properties =
        {
            dist_min = 600,   -- min range, meters
            dist_max = 1200,  -- max range, meters
        }
    }
    declare_weapon(WGr21)
    declare_loadout({category = CAT_ROCKETS, CLSID = "{WGr21}", displayName = _("Werfer-Granate 21 - 21 cm UnGd air-to-air rocket"),
	
		attribute		= {wsType_Weapon, wsType_NURS, wsType_Container, WSTYPE_PLACEHOLDER},
        wsTypeOfWeapon  = WGr21.wsTypeOfWeapon,
        Count           = 1,
        Weight          = WGr21.fm.mass + 10.0,
        Picture         = "german_WGr21.png",
        PictureBlendColor = "0xffffffff",
        Cx_pil          = 0.00102, -- ad libitum
		Elements        = {
            [1] = {
                ShapeName   	= "BR21-Gerat",
                IsAdapter   	= true,
            },
            [2] = {
                ShapeName = WGr21.model,
            },
        }, -- end of Elements
		pilon_jettison_option = 2, --ADAPTER_JETTISON_WHEN_NO_WEAPON_LEFT
        settings = PredefinedFuzeGUISettings("WWII_R_G_WGr21")
    })
    -- end of Wfr. Gr. 21 -----------------------------------------------------------------



    -- 4.5-Inch M8 ------------------------------------------------------------------------
    M8_45 = {category = CAT_ROCKETS, name = "M8rocket", user_name = _("4.5-Inch M8"),
        model           = "Rocket_M_8",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER},
        scheme          = "nurs-standard",
        fm = 
        {
            mass        = 17.24,					-- weight with kg
            caliber     = 0.114,  
            cx_coeff    = {1,0.91,0.67,0.3248,2.08},
            L           = 0.834,					--length meters
            I           = 1/12*17.24*0.834*0.834,	-- kgm2 - moment of inertia  I = 1/12 ML2
            Ma          = 0.23322,					-- dependence moment coefficient of  by  AoA angular acceleration  T / I
            Mw          = 2.177036,					--rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t     
            wind_time   = 3.0,						-- dispersion coefficient
            wind_sigma  = 20.0,
            shapeName   = "Rocket_M_8",
            rail_open   = true,
        },
		
        engine = 
        {
            fuel_mass          = 2.4, 				-- mass of fuel in kg
            impulse            = 150, 				-- engine perfomance
            boost_time         = 0,
            work_time          = 0.8,				-- time of engine work , fuel burn rate will be calculated using fuel mass and this time 
            boost_factor       = 1,
            nozzle_position    =  {{-0.35, 0, 0}},	-- effect placement
            tail_width         = 0.052,				-- effect scale 
            boost_tail         = 1,
            work_tail          = 1,
            smoke_color        = {0.6, 0.6, 0.6},
            smoke_transparency = 0.3,
        },
		
		warhead = 
        {
            mass                    = 1.95,			--1.95kg explosive mass
            expl_mass               = 1.95,
            other_factors           = {1.0, 1.0, 1.0};
            concrete_factors        = {1.0, 1.0, 1.0};
            obj_factors             = { 1.0, 1.0 },
            cumulative_factor       = 1;
            concrete_obj_factor     = 1.0;
            cumulative_thickness    = 0.0;
            piercing_mass           = 1.95/5.0;
            caliber                 = 114;
        },
		
        shape_table_data = 
        {
            {
                name     = "M8rocket",
                file     = "Rocket_M_8",
                life     = 1,
                fire     = {0, 1},
                username = _("4.5-Inch M8"),
                index    = WSTYPE_PLACEHOLDER,
            },
        },
		
        properties = 
        {
            dist_min = 500,   -- min range, meters
            dist_max = 2000,  -- max range, meters
        }
    }
    declare_weapon(M8_45)
    declare_loadout({category = CAT_ROCKETS, CLSID = "{3xM8_ROCKETS_IN_TUBES}", displayName = "3 x " .. _("4.5 inch M8 UnGd Rocket"),
        wsTypeOfWeapon  = M8_45.wsTypeOfWeapon,
        attribute       = {wsType_Weapon, wsType_NURS, wsType_Container, WSTYPE_PLACEHOLDER},
        Count           = 3,
        Picture         = "us_3x45inchM8.png",
        PictureBlendColor = "0xffffffff",
        Weight_Empty    = 20,
        Weight          = 20 + M8_45.fm.mass * 3,
        Cx_pil          = 0.00196533203125,
        Elements        = {
            [1] = {
                ShapeName = "Rocket_Launcher_4_5inch",
                IsAdapter = true,
            },
            [2] = {
                ShapeName = M8_45.model, connector_name = "tube_1",
            },
            [3] = {
                ShapeName = M8_45.model, connector_name = "tube_2",
            },
            [4] = {
                ShapeName = M8_45.model, connector_name = "tube_3",
            },
        },
		pilon_jettison_option = 3, --NO_JETTISON_AVAILABLE
    })
    -- end of 4.5-Inch M8 -----------------------------------------------------------------

    local RMNoI = {
        length              = 1.4,
        empty_mass          = 10.7,
        fuel_mass           = 5.2,
        impulse             = 190,
        boost_time          = 0,
        work_time           = 1.6,
        boost_factor        = 1,
        tail_width          = 0.0827,
        boost_tail          = 1,
        work_tail           = 1,
        nozzle_position     = {{-0.67, 0, 0}},
        smoke_color         = {0.6, 0.6, 0.6},
        smoke_transparency  = 0.3
    }

    -- British Shell, HE 60 lb. F. No. 1 Mk. I on Motor, A/C, 3-inch, No. 1 Mk. III -------
    British_HE_60LBFNo1_3INCHNo1 = {category = CAT_ROCKETS, name = "British_HE_60LBFNo1_3INCHNo1", user_name = _("RP-3 HE"),
        displayName     = _("RP-3 60lb F No1 Mk.I"),
        model           = "he_60lb_f_no1mkI",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER},
        scheme          = "nurs_standard_v2",
        fm =
        {
            mass        = RMNoI.empty_mass + 20.9, -- mass w/o fuel
            caliber     = 0.114,
            cx_coeff    = {1, 0.8889618, 0.67, 0.3172910, 2.08},
            L           = RMNoI.length + 0.56, --length meters
            I           = 1/12 * (RMNoI.empty_mass + 20.9) * (RMNoI.length + 0.56) ^ 2, -- kgm2 - moment of inertia  I = 1/12 ML2
            Ma          = 0.23322,					-- dependence moment coefficient of  by  AoA angular acceleration  T / I
            Mw          = 2.177036,					--rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t
            wind_time   = 3.0,						-- dispersion coefficient
            wind_sigma  = 50.0,
            shapeName   = "he_60lb_f_no1mkI",
            rail_open   = true,
            freq        = 0
        },
        engine = RMNoI,
        fuze = predefined_fuze("NFNo899MkI"),
        warhead =
        {
            mass                    = 20.9,
            expl_mass               = 1.77,
            other_factors           = {1.0, 1.0, 1.0};
            concrete_factors        = {1.0, 1.0, 1.0};
            obj_factors             = { 1.0, 1.0 },
            cumulative_factor       = 1;
            concrete_obj_factor     = 1.0;
            cumulative_thickness    = 0.0;
            piercing_mass           = 20.9 / 5.0;
            caliber                 = 0.114 * 10e3; -- in millimeters
        },
        shape_table_data =
        {
            {
                name     = "he_60lb_f_no1mki",
                file     = "he_60lb_f_no1mki",
                life     = 1,
                fire     = {0, 1},
                username = _("RP-3 HE"),
                index    = WSTYPE_PLACEHOLDER,
            },
        },
        properties =
        {
            dist_min = 500,   -- min range, meters
            dist_max = 1600,  -- max range, meters
        }
    }
    declare_weapon(British_HE_60LBFNo1_3INCHNo1)
    declare_loadout({category = CAT_ROCKETS, CLSID = "{British_HE_60LBFNo1_3INCHNo1}", displayName = British_HE_60LBFNo1_3INCHNo1.displayName,
        attribute       = {wsType_Weapon, wsType_NURS, wsType_Container, WSTYPE_PLACEHOLDER},
        wsTypeOfWeapon  = British_HE_60LBFNo1_3INCHNo1.wsTypeOfWeapon,
        Count           = 1,
        Weight          = British_HE_60LBFNo1_3INCHNo1.fm.mass,
        Picture         = "british_RS_60lb_F_No1.png",
        PictureBlendColor = "0xffffffff",
        Cx_pil          = 0.001, -- ad libitum
        Elements        = {{ShapeName = British_HE_60LBFNo1_3INCHNo1.model}},
        settings        = PredefinedFuzeGUISettings("WWII_R_B_RP3F")
    })
    -- end of British Shell, HE 60 lb. F. No. 1 Mk. I on Motor, A/C, 3-inch, No. 1 Mk. III



    -- British Shell, HE 60 lb. S.A.P. No. 2 Mk. I on Motor, A/C, 3-inch, No. 1 Mk. III ---
    British_HE_60LBSAPNo2_3INCHNo1 = {category = CAT_ROCKETS, name = "British_HE_60LBSAPNo2_3INCHNo1", user_name = _("RP-3 SAP"),
        displayName     = _("RP-3 60lb SAP No2 Mk.I"),
        model           = "he_60lb_sap_no2mkI",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER},
        scheme          = "nurs_standard_v2",
        fm =
        {
            mass        = RMNoI.empty_mass + 27.4, -- mass w/o fuel
            caliber     = 0.1524,
            cx_coeff    = {1, 0.8889618, 0.67, 0.3172910, 2.08},
            L           = RMNoI.length + 0.553, --length meters
            I           = 1/12 * (RMNoI.empty_mass + 27.4) * (RMNoI.length + 0.553) ^ 2, -- kgm2 - moment of inertia  I = 1/12 ML2
            Ma          = 0.23322,					-- dependence moment coefficient of  by  AoA angular acceleration  T / I
            Mw          = 2.177036,					--rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t
            wind_time   = 3.0,						-- dispersion coefficient
            wind_sigma  = 50.0,
            shapeName   = "he_60lb_sap_no2mkI",
            rail_open   = true,
            freq        = 0
        },
        engine = RMNoI,
        fuze = predefined_fuze("BFNo878MkI"),
        warhead =
        {
            mass                    = 27.4,
            expl_mass               = 6,
            other_factors           = {1.0, 1.0, 1.0};
            concrete_factors        = {1.0, 1.0, 1.0};
            obj_factors             = { 1.0, 1.0 },
            cumulative_factor       = 1;
            concrete_obj_factor     = 1.0;
            cumulative_thickness    = 0.1;
            piercing_mass           = 27.4 / 5.0;
            caliber                 = 0.1524 * 10e3; -- in millimeters
        },
        shape_table_data =
        {
            {
                name     = "he_60lb_sap_no2mkI",
                file     = "he_60lb_sap_no2mkI",
                life     = 1,
                fire     = {0, 1},
                username = _("RP-3 SAP"),
                index    = WSTYPE_PLACEHOLDER,
            },
        },
        properties =
        {
            dist_min = 500,   -- min range, meters
            dist_max = 1200,  -- max range, meters
        }
    }
    declare_weapon(British_HE_60LBSAPNo2_3INCHNo1)
    declare_loadout({category = CAT_ROCKETS, CLSID = "{British_HE_60LBSAPNo2_3INCHNo1}", displayName = British_HE_60LBSAPNo2_3INCHNo1.displayName,
        attribute       = {wsType_Weapon, wsType_NURS, wsType_Container, WSTYPE_PLACEHOLDER},
        wsTypeOfWeapon  = British_HE_60LBSAPNo2_3INCHNo1.wsTypeOfWeapon,
        Count           = 1,
        Weight          = British_HE_60LBSAPNo2_3INCHNo1.fm.mass,
        Picture         = "british_RS_60lb_SAP_No2.png",
        PictureBlendColor = "0xffffffff",
        Cx_pil          = 0.001, -- ad libitum
        Elements        = {{ShapeName = British_HE_60LBSAPNo2_3INCHNo1.model}},
        settings        = PredefinedFuzeGUISettings("WWII_R_B_RP3SAP")
    })
    -- end of British Shell, HE 60 lb. S.A.P. No. 2 Mk. I on Motor, A/C, 3-inch, No. 1 Mk. III



    -- British Shot, 25 lb. AP Mk. I on Motor, A/C, 3-inch, No. 1 Mk. I -------------------
    British_AP_25LBNo1_3INCHNo1 = {category = CAT_ROCKETS, name = "British_AP_25LBNo1_3INCHNo1", user_name = _("RP-3 AP"),
        displayName     = _("RP-3 25lb AP Mk.I"),
        model           = "shot_25lb_ap_mkI",
        wsTypeOfWeapon  = {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER},
        scheme          = "nurs_standard_v2",
        fm =
        {
            mass        = RMNoI.empty_mass + 11.3, -- mass w/o fuel
            caliber     = 0.087,  
            cx_coeff    = {1, 0.8889618, 0.67, 0.3172910, 2.08},
            L           = RMNoI.length + 0.314, --length meters
            I           = 1/12 * (RMNoI.empty_mass + 11.3) * (RMNoI.length + 0.314) ^ 2, -- kgm2 - moment of inertia  I = 1/12 ML2
            Ma          = 0.23322,					-- dependence moment coefficient of  by  AoA angular acceleration  T / I
            Mw          = 2.177036,					--rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t
            wind_time   = 3.0,						-- dispersion coefficient
            wind_sigma  = 50.0,
            shapeName   = "shot_25lb_ap_mkI",
            rail_open   = true,
            freq        = 0
        },
        engine = RMNoI,
        warhead =
        {
            mass                    = 11.3,
            expl_mass               = 0,
            other_factors           = { 1.0, 0.0, 1.0 };
            concrete_factors        = { 1.0, 0.0, 1.0 };
            obj_factors             = { 1.0, 0.0 },
            cumulative_factor       = 1;
            concrete_obj_factor     = 1.0;
            cumulative_thickness    = 0.1;
            piercing_mass           = 11.3;
            caliber                 = 0.087 * 10e3; -- in millimeters
        },
        shape_table_data =
        {
            {
                name     = "shot_25lb_ap_mkI",
                file     = "shot_25lb_ap_mkI",
                life     = 1,
                fire     = {0, 1},
                username = _("RP-3 AP"),
                index    = WSTYPE_PLACEHOLDER,
            },
        },
        properties =
        {
            dist_min = 300,   -- min range, meters
            dist_max = 800,  -- max range, meters
        }
    }
    declare_weapon(British_AP_25LBNo1_3INCHNo1)
    declare_loadout({category = CAT_ROCKETS, CLSID = "{British_AP_25LBNo1_3INCHNo1}", displayName = British_AP_25LBNo1_3INCHNo1.displayName,
        attribute       = {wsType_Weapon, wsType_NURS, wsType_Container, WSTYPE_PLACEHOLDER},
        wsTypeOfWeapon  = British_AP_25LBNo1_3INCHNo1.wsTypeOfWeapon,
        Count           = 1,
        Weight          = British_AP_25LBNo1_3INCHNo1.fm.mass,
        Picture         = "british_RS_25lb_AP.png",
        PictureBlendColor = "0xffffffff",
        Cx_pil          = 0.001, -- ad libitum
        Elements        = {{ShapeName = British_AP_25LBNo1_3INCHNo1.model}},
    })
    -- end of British Shot, 25 lb. AP Mk. I on Motor, A/C, 3-inch, No. 1 Mk. I ------------



-- end of Defining unguided rocket shells -------------------------------------------------









-- Defining fuel tanks --------------------------------------------------------------------



    -- German Generic 300 liter tank ------------------------------------------------------
    declare_loadout({category = CAT_FUEL_TANKS, CLSID = "BF109K_4_FUEL_TANK", displayName = _("300 liter Fuel Tank"),
        attribute = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        Picture = "german_tank_300l.png",
        PictureBlendColor = "0xffffffff",
        Weight_Empty = 50.0,
        Weight = 50.0 + 216.0,
        Cx_pil = 0.00066,   -- German WT test
        shape_table_data = {
            {
                file = "Drop_Tank_300_Liter";
                life = 1;
                fire = {0, 1};
                username = "BF109K_4_FUEL_TANK";
                index = WSTYPE_PLACEHOLDER;
            },
        },
        Elements = {
            {
                ShapeName = "Drop_Tank_300_Liter",
            },
        },
    })
    -- end of German Generic 300 liter tank -----------------------------------------------



    -- German E2 tank ---------------------------------------------------------------------
    declare_loadout({category = CAT_FUEL_TANKS, CLSID = "FW109_FUEL_TANK", displayName = _("300 liter Fuel Tank Type E2"),
        attribute       = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        Picture         = "german_tank_E2.png",
        PictureBlendColor = "0xffffffff",
        Weight_Empty    = 50.0,
        Weight          = 50.0 + 216.0,
        Cx_pil          = 0.00066,  -- German WT test 
        shape_table_data = {
            {
                file    = "FW-190_Fuel-Tank";
                life    = 1;
                fire    = { 0, 1};
                username= "FW109_FUEL_TANK";
                index   = WSTYPE_PLACEHOLDER;
            },
        },
        Elements    = {
            {
                ShapeName = "FW-190_Fuel-Tank",
            }, 
        }, 
    })
    -- end of German E2 tank --------------------------------------------------------------



    -- US 75-gallon tank ------------------------------------------------------------------
    -- Ref. Scripts\Database\db_weapons_data.lua
    -- CLSID = "{DT75GAL}",
    -- end of US 75-gallon tank -----------------------------------------------------------



    -- US 108-gallon paper tank -----------------------------------------------------------
    declare_loadout({category = CAT_FUEL_TANKS, CLSID = "{US_108GAL_PAPER_FUEL_TANK}", displayName = _("108 US gal. Paper Fuel Tank"),
        attribute       = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        Picture         = "us_Tank_108gal.png",
        PictureBlendColor = "0xffffffff",
        Weight_Empty    = 25.0,
        Weight          = 25.0 + 294.0,
        Cx_pil          = 0.00066,
        shape_table_data = {
            {
                file    = "droptank_108_gal",
                life    = 1,
                fire    = {0, 1},
                username= _("Fuel Tank 108 US gal."),
                index   = WSTYPE_PLACEHOLDER,
            },
        },
        Elements        = {
            {
                DrawArgs = {
                    [1] = {19, 0.0},
                    [2] = {57, 0.0},
                }, 
                ShapeName = "droptank_108_gal",
            }, 
        }, 
    })
    -- end of US 108-gallon paper tank ----------------------------------------------------



    -- US 110-gallon tank -----------------------------------------------------------------
    declare_loadout({category = CAT_FUEL_TANKS, CLSID = "{US_110GAL_FUEL_TANK}", displayName = _("110 US gal. Fuel Tank"),
        attribute       = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        Picture         = "us_Tank_110gal.png",
        PictureBlendColor = "0xffffffff",
        Weight_Empty    = 50.0,
        Weight          = 50.0 + 299.0,
        Cx_pil          = 0.00066,
        shape_table_data = {
            {
                file    = "droptank_110_gal",
                life    = 1,
                fire    = {0, 1},
                username= _("Fuel Tank 110 US gal."),
                index   = WSTYPE_PLACEHOLDER,
            },
        },
        Elements        = {
            {
                DrawArgs = {
                    [1] = {19, 0.0},
                    [2] = {57, 0.0},
                }, 
                Position = {0, 0, 0},
                ShapeName = "droptank_110_gal",
            }, 
        }, 
    })
    -- end of US 110-gallon tank ----------------------------------------------------------



    -- US 150-gallon tank -----------------------------------------------------------------
    declare_loadout({category = CAT_FUEL_TANKS, CLSID = "{US_150GAL_FUEL_TANK}", displayName = _("150 US gal. Fuel Tank"),
        attribute       = {wsType_Air, wsType_Free_Fall, wsType_FuelTank, WSTYPE_PLACEHOLDER},
        Picture         = "us_Tank_150gal.png",
        PictureBlendColor = "0xffffffff",
        Weight_Empty    = 50.0,
        Weight          = 50.0 + 408.8,
        Cx_pil          = 0.00066,
        shape_table_data = {
            {
                file    = "droptank_150_gal",
                life    = 1,
                fire    = {0, 1},
                username= _("Fuel Tank 150 US gal."),
                index   = WSTYPE_PLACEHOLDER,
            },
        },
        Elements        = {
            {
                ShapeName = "droptank_150_gal",
            }, 
        }, 
    })
    -- end of US 150-gallon tank ----------------------------------------------------------



-- end of Defining fuel tanks -------------------------------------------------------------









-- Defining specialized armament ----------------------------------------------------------



    -- Common Data ------------------------------------------------------------------------
    local smokes = {
        ["red"] 	= {r = 245  , g = 40 ,  b = 40  , a = 180 , disp = _("red_smk")  , picture = "smoke_red.png"},
        ["green"] 	= {r = 50   , g = 160,  b = 100 , a = 180 , disp = _("green")    , picture = "smoke_green.png"},
        ["blue"] 	= {r = 50   , g = 100,  b = 210 , a = 180 , disp = _("blue_smk") , picture = "smoke_blue.png"},
        ["yellow"] 	= {r = 255  , g = 230,  b = 50  , a = 180 , disp = _("yellow")   , picture = "smoke_yellow.png"},
        ["orange"] 	= {r = 255  , g = 150,  b = 35  , a = 180 , disp = _("orange")   , picture = "smoke_orange.png"},
        ["white"] 	= {r = 255  , g = 255,  b = 255 , a = 180 , disp = _("white")    , picture = "smoke_white.png"},
    }
    -- end of Common Data -----------------------------------------------------------------



    -- US M10 smoke tank ------------------------------------------------------------------
    function US_M10_SMOKE_TANK ( clsid_, smoke_, picture_ )
        declare_loadout({category = CAT_PODS, CLSID = clsid_, displayName = _("M10 Smoke Tank") .. " - " .. smoke_.disp,
            attribute       = {wsType_Weapon, wsType_GContainer, wsType_Smoke_Cont, WSTYPE_PLACEHOLDER},
            Picture         = picture_ or smoke_.picture,
            PictureBlendColor = "0xffffffff",
            Weight          = 266.7,
            Cx_pil          = 0.00066,
            Smoke           = {
                alpha = smoke_.a,
                r     = smoke_.r,
                g     = smoke_.g,
                b     = smoke_.b,
                dx    = -0.961,
                dy    = -0.206
            },
            shape_table_data = {
                {
                    name    = clsid_,
                    file    = "M10_Airplane_SmokeTank",
                    life    = 1,
                    fire    = {0, 1},
                    username= _("M10 Smoke Tank"),
                    index   = WSTYPE_PLACEHOLDER,
                },
            },
            Elements        = {
                {
                    ShapeName = clsid_,
                    Position = {0, 0, 0},
                },
            },
        })
    end
    US_M10_SMOKE_TANK("{US_M10_SMOKE_TANK_RED}",    smokes["red"],    "us_M10_Smoke_Tank_Red.png")
    US_M10_SMOKE_TANK("{US_M10_SMOKE_TANK_YELLOW}", smokes["yellow"], "us_M10_Smoke_Tank_Yellow.png")
    US_M10_SMOKE_TANK("{US_M10_SMOKE_TANK_ORANGE}", smokes["orange"], "us_M10_Smoke_Tank_Orange.png")
    US_M10_SMOKE_TANK("{US_M10_SMOKE_TANK_GREEN}",  smokes["green"],  "us_M10_Smoke_Tank_Green.png")
    US_M10_SMOKE_TANK("{US_M10_SMOKE_TANK_BLUE}",   smokes["blue"],   "us_M10_Smoke_Tank_Blue.png")
    US_M10_SMOKE_TANK("{US_M10_SMOKE_TANK_WHITE}",  smokes["white"],  "us_M10_Smoke_Tank_White.png")
    -- end of US M10 smoke tank -----------------------------------------------------------



    -- British "Beer Bomb" ----------------------------------------------------------------
	BEER_BOMB = {category = CAT_BOMBS, name = "BEER_BOMB", user_name = dcswwii_bomb_models["BEER_BOMB"].display_name,
        model           = dcswwii_bomb_models["BEER_BOMB"].file_name,
		wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_A, WSTYPE_PLACEHOLDER},
		scheme          = "bomb-common",
		type            = 0,
		mass            = 100.0,
		hMin            = 300.0,
		hMax            = 12000.0,
		Cx              = 0.00133,
		VyHold          = -100.0,
		Ag              = -1.23,
		
		fm = {
			mass        = 100.0,
			caliber     = 0.516,
			cx_coeff    = {1.0, 0.9, 0.6, 0.6, 1.2},
			L           = 0.675,
			I           = 1/12 * 100.0 * 0.675 * 0.675,
			Ma          = 0.05,
			Mw          = 0.001,
			wind_sigma  = 2000.0,
			cx_factor   = 300,
		},
		
		warhead	= {
			mass					= 1.0,
			expl_mass				= 1.0,
			other_factors			= {0.0, 0.0, 0.0},
			obj_factors				= {0, 0},
			concrete_factors		= {0.0, 0.0, 0.0},
			cumulative_factor		= 0,
			concrete_obj_factor		= 0.0,
			cumulative_thickness	= 0.0,
			piercing_mass			= 0.0,
			caliber					= 516,
        },
		
		shape_table_data = 
		{
			{
				index		= WSTYPE_PLACEHOLDER,
				name		= "BEER_BOMB",
				username	= dcswwii_bomb_models["BEER_BOMB"].display_name,
				file		= dcswwii_bomb_models["BEER_BOMB"].file_name,
				life		= 1,
				fire		= {0, 1},				
            },
        },
		
		targeting_data = {
			char_time   = 35.0,
		},
	}
    declare_weapon(BEER_BOMB)
	declare_loadout({category = CAT_BOMBS, CLSID = "{BEER_BOMB}", displayName = BEER_BOMB.user_name,
		attribute			= BEER_BOMB.wsTypeOfWeapon,
		Count				= 1,
		Cx_pil				= BEER_BOMB.Cx,
		Picture				= dcswwii_bomb_models["BEER_BOMB"].icon,
		PictureBlendColor	= "0xffffffff",
		Weight				= BEER_BOMB.mass,
		Elements			= {{ShapeName = BEER_BOMB.model}},
	})
    -- end of British "Beer Bomb" ---------------------------------------------------------



-- end of Defining specialized armament ---------------------------------------------------

-- Static Objects
--------------------------------------------------------------------------
local function add_static_object(f)
	if(f) then
		f.shape_table_data = 
		{
			{
				file  	    = f.ShapeName,
				life		= f.Life,
				username    = f.Name,
				desrt       = f.ShapeNameDestr,
			    classname 	= "lLandVehicle",
				positioning = f.positioning or "BYNORMAL",	--available: {"BYNORMAL", "ONLYHEIGTH", "BY_XZ", "ADD_HEIGTH"}
			},
			{
				file  = f.ShapeNameDestr,
				iscrashmodel = true,
				fire 		= {
								f.fireTime or 0,
								f.fireIntencity or 1,
							},
				expMass		= f.explMass or 0,
			},
		}
		f.mapclasskey = "P0091000076";
		f.attribute = {wsType_Static, wsType_Standing} -- if 'attribute' == nil then insertion will be aborted
		
		add_surface_unit(f)
		GT = nil;
	else
		error("Can't add fortification")
	end;
end

local function static_object( name, displayName, shape, shape_destr, life, rate, countries_, isPutToWater, positioning_, fireTime_, fireIntencity_, explMass_)
    local res = {};
    
    res.Name = name;
    res.DisplayName = displayName;
    res.ShapeName = shape;
	res.ShapeNameDestr = shape_destr;
	res.Life = life;
    res.Rate = rate;
    res.category = 'Fortification';
	res.Countries = countries_;
	res.isPutToWater = isPutToWater; -- allows object to be placed only on water
	res.positioning = positioning_;
	res.fireTime = fireTime_;
	res.fireIntencity = fireIntencity_;
	res.explMass = explMass_;
	
	add_static_object(res)
end

static_object("Beer Bomb", _('Barrel'), "barrelofbeer_support", "", 5, 5, nil, false, "BYNORMAL", 5.0, 1.0, 20.0);

