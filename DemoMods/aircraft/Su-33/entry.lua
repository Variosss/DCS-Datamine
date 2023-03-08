--do return end

local self_ID = "Su-33 Flanker by Eagle Dynamics"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

displayName = _("Su-33"),
version		 = __DCS_VERSION__.." beta",
state		 = "sale",
info		 = _("The Su-33 is an all-weather fighter that has been the backbone of Russian aircraft carrier aviation since the late 1990s. Based on the powerful Su-27 'Flanker', the Su-33 is a navalized version suited for operations aboard the Admiral Kuznetsov aircraft carrier. Changes to the fighter include strengthened landing gear, folding wings, more powerful engines, and the very visible canards."),
rules = 
{	
	["Flaming Cliffs by Eagle Dynamics"] = { required = false , disabled = true }
},


linkBuy =
{
    ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/su-33_dcs_world/",
    STEAM   = "http://store.steampowered.com/app/223750",
},

Skins	=
	{
		{
			name	= _("Su-33"),
			dir		= "Skins/1"
		},
	},


})


----------------------------------------------------------------------------------------
plugin_done()
