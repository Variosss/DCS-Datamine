local self_ID = "P-47D-30 by Eagle Dynamics"

declare_plugin(
    self_ID,
    {
        installed = true, -- if false that will be place holder, or advertising
        dirName = current_mod_path,
        displayName = _("P-47D-30"),

        version		 = __DCS_VERSION__,
        state		 = "sale",
        
        info = _("The P-47 Thunderbolt, nicknamed the Jug, served the United States Army Air Forces (USAAF) in World War II, and 15,636 were built between 1941 and 1945. France, the United Kingdom, Soviet Union, Mexico and Brazil also operated the P-47."),

        linkBuy =
        {
            ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/thunderbolt/",
            STEAM   = "http://store.steampowered.com/app/1120304",
        },
        Skins = {
            {
                name = _("P-47D-30"),
                dir = "Skins/1"
            },
        },
    })
----------------------------------------------------------------------------------------
plugin_done() -- finish declaration , clear temporal data
