declare_plugin("Combined Arms by Eagle Dynamics",
{
image     	 = "CA.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

fileMenuName = _("CA"),
version		 = __DCS_VERSION__,		 
state		 = "sale",
info		 = _("In addition to flying the aircraft of DCS, Combined Arms allows the control of ground forces during the battle. Use the strategic map to move ground forces, set artillery fire missions, and control the ground battle. Jump into the role of a Joint Terminal Attack Controller (JTAC) and designate targets for close air support, or directly control an armored vehicle or air defense weapon and engage enemy forces."),
linkBuy =
    {
        ED     = "https://www.digitalcombatsimulator.com/en/shop/modules/dcs_combined_arms/",
        STEAM  = "http://store.steampowered.com/app/223750",
        GAMEFLY = "http://www.gamefly.com/Download-DCS-Combined-Arms/5006546",
        GAMEFLY_UK = "http://www.gamefly.co.uk/Download-DCS-Combined-Arms/5006547/",
    },

Skins	= 
	{
		{
			name	= _("CA"),
			dir		= "Skins/1"
		},
	},
})
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
