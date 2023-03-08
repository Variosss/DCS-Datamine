local self_ID = "Spitfire LF Mk. IX by Eagle Dynamics"

declare_plugin(
    self_ID,
    {
        installed = true, -- if false that will be place holder, or advertising
        dirName = current_mod_path,
        displayName = _("Spitfire LF Mk. IX"),

        version		 = __DCS_VERSION__,
        state		 = "sale",
        
        info = _("The British Spitfire is one of the most iconic fighter aircraft of World War II. Most famous for its role in the Battle of Britain, the Spitfire served as Britain's primary fighter during the entirety of the war. The Spitfire combines graceful lines, eye-watering dogfight performance, and heavy firepower in its later variants. For DCS World, we are happy to bring you the most accurate and realistic simulation of the Spitfire LF Mk IX ever created."),

        linkBuy =
        {
            ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/spitfire/",
            STEAM   = "http://store.steampowered.com/app/223750",
        },
        Skins = {
            {
                name = _("Spitfire IX"),
                dir = "Skins/1"
            },
        },
    })
----------------------------------------------------------------------------------------
plugin_done() -- finish declaration , clear temporal data
