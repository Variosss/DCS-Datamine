local function genericGunpod(input)
    local result = {}

    result.CLSID 			 = input.CLSID
    result.displayName 		 = input.displayName
    result.category 		 = CAT_PODS
    result.attribute 		 = {wsType_Weapon, wsType_GContainer, wsType_Cannon_Cont, WSTYPE_PLACEHOLDER}
    result.kind_of_shipping  = 2
    result.Elements 		 = {{ShapeName = input.ShapeName}}

    result.gun_mounts = {
        gun_mount(
            input.GunMountName, {}, {
                muzzle_pos_connector = input.muzzle_pos_connector,
                -- ejector_pos_connector = "Ejector", -- doesn't seem to work atm
                ejector_pos = input.ejector_pos,
                ejector_dir = input.ejector_dir,
                supply_position = input.supply_position,
                effects = {
                    fire_effect(436),
                    -- heat_effect(7.823, 0.462 * 2.7, 0.462 * 14.3), -- causes pod to not load in
                    smoke_effect()
                }
            }
        )
    }

    result.shape_table_data = {{
        file = input.ShapeName,
        username = input.ShapeName,
        index = WSTYPE_PLACEHOLDER
    }}

    return result
end

local function DEFA553Gunpod(input)
    local result = {}

    input.GunMountName 	  = "DEFA553"
    input.ejector_pos 	  = {-2.25, -0.22, 0.095}
    input.supply_position = {2, -0.3, -0.4}

    result   	   = genericGunpod(input)
    result.Picture = "MB339-DEFA.png"
    result.Weight  = 190
    result.Cx_pil  = 0.0007/2

    return result
end

local function ANM3Gunpod(input)
    local result = {}

    input.GunMountName	  = "ANM3"
    input.ejector_pos 	  = {-0.879, -0.245, -0.053}
    input.ejector_dir 	  = {0, -1, -0.5}
    input.supply_position = {2, -0.3, -0.4}

    result   	   = genericGunpod(input)
    result.Picture = "MB339-AN-M3.png"
    result.Weight  = 75
    result.Cx_pil  = 0.0007/2.5

    return result
end

declare_loadout(
    DEFA553Gunpod({
        CLSID 		= "{MB339_DEFA553_L}",
        displayName = _("DEFA553 Gunpod Left"),
        ShapeName	= "MB339-DEFA553_L",
        muzzle_pos_connector = "Point_Gun_DEFA-L"
    })
)

declare_loadout(
    DEFA553Gunpod({
        CLSID 		= "{MB339_DEFA553_R}",
        displayName = _("DEFA553 Gunpod Right"),
        ShapeName 	= "MB339-DEFA553_R",
        muzzle_pos_connector = "Point_Gun_DEFA-R"
    })
)

declare_loadout(
    ANM3Gunpod({
        CLSID 		= "{MB339_ANM3_L}",
        displayName = _("AN/M3 Gunpod Left"),
        ShapeName = "MB339_cal50_L",
        muzzle_pos_connector = "Point_Gun_ANM3-L"
    })
)

declare_loadout(
    ANM3Gunpod({
        CLSID 		= "{MB339_ANM3_R}",
        displayName = _("AN/M3 Gunpod Right"),
        ShapeName = "MB339_cal50_R",
        muzzle_pos_connector = "Point_Gun_ANM3-R"
    })
)
