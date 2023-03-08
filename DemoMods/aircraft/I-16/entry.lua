local self_ID = "I-16 by OctopusG"
declare_plugin(self_ID,
{
dirName		  = current_mod_path,

version		  =   __DCS_VERSION__,
state		  =   "sale",
developerName =   "OctopusG",
info		 = _("The Polikarpov I-16 is a Soviet fighter aircraft of revolutionary design it is the world's first low-wing monoplane fighter with retractable landing gear. It is one of the longest-lived fighters of the period, serving until as late as 1950, in Spain. It has the complex nature. Get inspired!"),

Skins	 =
{
	{
		name	= "I-16",
		dir		= "Skins/1"			
	},
},
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/i-16/", 
        STEAM   = "https://store.steampowered.com/app/1084210",
    },
}) 

plugin_done()
