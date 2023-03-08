declare_plugin("World War II AI Units by Eagle Dynamics",
    {
        installed   = true, -- if false that will be place holder , or advertising
        dirName     = current_mod_path,
        version     = __DCS_VERSION__,
        state       = "installed",
        info        = _("World War 2 AI Pack"),
        Missions    = {
            {
                name    = _("FW 190 D-9"),
                dir     = "FW-190D-9/Missions",
            },
            {
                name    = _("Bf 109 K-4"),
                dir     = "Bf-109K-4/Missions",
            },
            {
                name    = _("Spitfire LF Mk. IX"),
                dir     = "SpitfireLFMkIX/Missions",
            },
            {
                name    = _("P-51D"),
                dir     = "P-51D/Missions",
            },
            {
                name    = _("P-47D-30"),
                dir     = "P-47D-30/Missions",
            },
            {
                name    = _("Mosquito FB Mk. VI"),
                dir     = "DH98MosquitoFBMkVI/Missions",
            },
            {
                name    = _("A-20G"),
                dir     = "A-20G/Missions",
            },
        },
        encyclopedia_path = current_mod_path .. '/Encyclopedia',
    })

---------------------------------------------------------------------------------------

dofile(current_mod_path .. '/Weapons/Weapons.lua')
dofile(current_mod_path .. '/Views.lua')

dofile(current_mod_path .. '/FW-190D-9/FW-190D-9.lua')
dofile(current_mod_path .. '/FW-190A-8/FW-190A-8.lua')
dofile(current_mod_path .. '/Bf-109K-4/Bf-109K-4.lua')
dofile(current_mod_path .. '/SpitfireLFMkIX/SpitfireLFMkIX.lua')
dofile(current_mod_path .. '/P-51D/P-51D.lua')
dofile(current_mod_path .. '/P-47D-30/P-47D-30.lua')
dofile(current_mod_path .. '/MosquitoFBMkVI/MosquitoFBMkVI.lua')
dofile(current_mod_path .. '/A-20G/A-20G.lua')

plugin_done() -- finish declaration , clear temporal data
