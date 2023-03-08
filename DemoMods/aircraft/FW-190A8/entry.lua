self_ID = "Fw 190 A-8 by Eagle Dynamics"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("Fw 190 A-8"),

version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _("Designed for the German Luftwaffe by famed aircraft designer Kurt Tank in the late-1930s, the Fw -190 was the backbone of the Luftwaffe in both fighter and attack bomber roles. Powered by a large radial engine, the A version of the Focke-Wulf 190 was superior in many ways to the Bf 109s and Spitfires at the time of its introduction. In fact, this led to the development of the Mk.IX version of the Spitfire. The Spitfire LF Mk.IX and the Fw 190 A-8 make excellent counterparts for DCS World."),


linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/anton/",
        --STEAM   = "http://store.steampowered.com/app/223750",
    },

Skins	= 
	{
		{
			name	= _("Fw 190 A-8"),
			dir		= "Skins/1"
		},
	},

})

plugin_done()
