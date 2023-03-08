local self_ID = "Yak-52 by Eagle Dynamics"

declare_plugin(
    self_ID,
    {
        installed = true, -- if false that will be place holder, or advertising
        dirName = current_mod_path,
        displayName = _("Yak-52"),

        version		 = "Early access",
        state		 = "sale",
        

        info = _("The Yakovlev Yak-52 is a tandem seat, radial engine, trainer aircraft that served as the primary aircraft trainer for the Soviet Union and many other nations. Introduced in 1976, the Yak-52 has been a popular choice among air forces given its rugged construction, ease of handling, tricycle landing gear, and simple maintenance. These same characteristic have made it a popular civilian aerobatics aircraft in its later years."),

        linkBuy =
        {
            ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/yak52/",
            --STEAM   = "http://store.steampowered.com/app/223750",
        },
        Skins = {
            {
                name = _("Yak-52"),
                dir = "Skins/1"
            },
        },
    })
----------------------------------------------------------------------------------------
plugin_done() -- finish declaration , clear temporal data
