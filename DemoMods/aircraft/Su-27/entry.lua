--do return end

local self_ID = "Su-27 Flanker by Eagle Dynamics"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

displayName = _("Su-27"),
version		 = __DCS_VERSION__.." beta",
state		 = "sale",
info		 = _("The Su-27, NATO codename Flanker, is one of the pillars of modern-day Russian combat aviation. Built to counter the American F-15 Eagle, the Flanker is a twin-engine, supersonic, highly manoeuvrable air superiority fighter."),
rules = 
{	
	["Flaming Cliffs by Eagle Dynamics"] = { required = false , disabled = true }
},

linkBuy =
{
    ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/su-27_dcs_world/",
    STEAM   = "http://store.steampowered.com/app/223750",
},
Skins	=
	{
		{
			name	= _("Su-27"),
			dir		= "Skins/1"
		},
	},

})

----------------------------------------------------------------------------------------
plugin_done()
