declare_plugin(
    "Yak-52 AI by Eagle Dynamics",
    {
        installed   = true, -- if false that will be place holder , or advertising
        dirName     = current_mod_path,
        version     = __DCS_VERSION__.." alpha", 
        state       = "installed",
        info        = _("Yak-52 AI"),
        encyclopedia_path = current_mod_path .. '/Encyclopedia'
    }
)
--------------------------------------------------------
dofile(current_mod_path .. '/Yak-52.lua')
--------------------------------------------------------
plugin_done()
