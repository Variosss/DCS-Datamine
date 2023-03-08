local self_ID = "Bf 109 K-4 by Eagle Dynamics"

declare_plugin(
    self_ID,
    {
        installed = true, -- if false that will be place holder , or advertising
        dirName = current_mod_path,

        displayName = _("Bf 109 K-4"),
        version = __DCS_VERSION__,
        state = "sale",
        info = _("Bf 109 is one of the most well-known fighters of WWII. Powerful and deadly, the last production model of the only single-engined German fighter to see service throughout World War II, the Bf 109 K-4 provides an exhilarating combat experience to its drivers, and a worthy challenge to all fans of DCS: P-51D Mustang. Get inspired on control of a powerful, propeller-driven, piston engine combat aircraft."),

        linkBuy =
        {
            ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/kurfurst/",
            STEAM   = "http://store.steampowered.com/app/223750",
        },
        Skins = {
            {
                name = _("Bf 109 K-4"),
                dir = "Skins/1"
            },
        },
    })
----------------------------------------------------------------------------------------
plugin_done() -- finish declaration , clear temporal data
