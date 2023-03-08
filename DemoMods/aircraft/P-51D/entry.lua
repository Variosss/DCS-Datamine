local self_ID = "P-51D Mustang by Eagle Dynamics"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _("The Mustang was among the best and most well-known fighters used by the U.S. Army Air Forces during WWII. Possessing excellent range and maneuverability, the P-51 operated primarily as a long-range escort fighter and also as a ground attack fighter-bomber with bombs, rockets, and machine guns. The Mustang served in nearly every combat zone during WWII and proved to be what many consider the most successful fighter in history."),
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/dcs_p51d_mustang/",
        STEAM   = "http://store.steampowered.com/app/223750",
        GAMEFLY = "http://www.gamefly.com/Download-DCS-P-51D-Mustang/5006548",
        GAMEFLY_UK = "http://www.gamefly.co.uk/Download-DCS-P-51D-Mustang/5006549/",
    },

Skins	=
	{
		{
			name	= _("P-51D"),
			dir		= "Skins/1"
		},
	},

})
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
plugin_done()
