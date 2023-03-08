--do return end

local self_ID = "MiG-29 Fulcrum by Eagle Dynamics"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

displayName = _("MiG-29"),
version		 = __DCS_VERSION__.." beta",
state		 = "sale",
info		 = _("The MiG-29 is a single seat, twin-engined, fourth generation supersonic fighter aircraft born during the closing phase of the Cold War. With primary roles being close range intercept and air superiority."),
rules = 
{	
	["Flaming Cliffs by Eagle Dynamics"] = { required = false , disabled = true }
},

linkBuy =
{
    ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/mig-29_dcs_world/",
    --STEAM   = "http://store.steampowered.com/app/223750",
},
Skins	=
	{
		{
			name	= _("MiG-29"),
			dir		= "Skins/1"
		},
	},

})

----------------------------------------------------------------------------------------
plugin_done()
