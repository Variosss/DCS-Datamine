local self_ID = "L-39C"
declare_plugin(self_ID,
{
dirName		  = current_mod_path,

version		  =   __DCS_VERSION__,
state		  =   "sale",
developerName =   "Eagle Dynamics",
info		  = _("L-39 is two seat Jet trainer aircraft intended for basic and advanced pilot training in visual and instrument flight rules weather conditions and also for combat use against air and ground targets. The aircraft has entered service in the 70s and it is still in the operational use in over 30 countries worldwide. Try yourself in a role of a flight instructor or if you are just a beginner make your first flight with a skilled player in DCS L-39."),

Skins	 =
{
	{
		name	= "L-39",
		dir		= "Theme"			
	},
},
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/albatros/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },
}) 

plugin_done()
