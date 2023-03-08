self_ID = "F-15C"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("F-15C"),

version		 = __DCS_VERSION__.." beta",
state		 = "sale",
info		 = _("The McDonnell Douglas / Boeing F-15C Eagle is a highly maneuverable fourth-generation twin-engine all-weather tactical fighter. It has been the air superiority fighter mainstay of U.S. and NATO forces since the 1970s and will remain as such well into the 21st century.Air superiority is achieved through high maneuverability at a wide range of airspeeds and altitudes, as well as advanced weapons and avionics."),
rules = 
{	
	["Flaming Cliffs by Eagle Dynamics"] = { required = false , disabled = true }
},

linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/f-15c_dcs_world/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },

Skins	= 
	{
		{
			name	= "F-15C",
			dir		= "Skins/1"
		},
	},

})

plugin_done()
