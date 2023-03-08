declare_plugin(
    "Christen Eagle II AI by Magnitude 3 LLC",
    {
        installed         = true, -- if false that will be place holder , or advertising
        dirName           = current_mod_path,
        version           = __DCS_VERSION__, -- .." alpha", 
        state             = "installed",
        info              = _("Christen Eagle II AI"),
        encyclopedia_path = current_mod_path .. '/Encyclopedia',
	
		binaries =
			{
				'CE2_AI',
			},
    }
)




dofile(current_mod_path..'/Eagle_payload.lua')
dofile(current_mod_path..'/Eagle_II.lua')
--------------------------------------------------------
plugin_done()
