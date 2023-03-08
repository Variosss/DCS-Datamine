local self_ID = "A-10A by Eagle Dynamics"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("A-10A"),

fileMenuName = _("A-10A"),
version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _("The A-10A Thunderbolt II, also known as the Warthog, is a 'flying gun'. The aircraft was used extensively during Operation Desert Storm, in support of NATO operations in response to the Kosovo crisis, in Operation Enduring Freedom in Afghanistan and in Operation Iraqi Freedom. The A-10A is a high-survivability and versatile aircraft, popular with pilots for the 'get home' effectiveness.The mission of the aircraft is ground attack against tanks, armored vehicles and installations, and close air support of ground forces. The Warthog is famous for its massive 30mm cannon, but it can also be armed with Maverick guided missiles and several types of bombs and rockets."),

rules = 
{	
	["Flaming Cliffs by Eagle Dynamics"] = { required = false , disabled = true }
},

linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/a-10a_dcs_world/",
        STEAM   = "http://store.steampowered.com/app/223750",
        GAMEFLY = "http://www.gamefly.com/Download-A-10A-DCS-Flaming-Cliffs/5006551",
        GAMEFLY_UK = "http://www.gamefly.co.uk/Download-A-10A-DCS-Flaming-Cliffs/5006552/",
    },

Skins	= 
	{
		{
			name	= "A-10A",
			dir		= "Skins/1"
		},
	},

})

----------------------------------------------------------------------------------------
plugin_done()
