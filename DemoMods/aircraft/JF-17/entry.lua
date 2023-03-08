declare_plugin("JF-17 by Deka Ironwork Simulations",
{
installed       = true, -- if false that will be place holder , or advertising
dirName         = current_mod_path,

version         = __DCS_VERSION__,         
state           = "sale",
info            = _("JF-17"),

Skins = 
    {
        {
            name  = _("JF-17"),
            dir   = "Skins/1"
        },
    },

linkBuy =
    {
        ED = "https://www.digitalcombatsimulator.com/en/shop/modules/",
    },
})

plugin_done()