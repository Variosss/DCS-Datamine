local self_ID = "Su-25A by Eagle Dynamics"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("Su-25"),

fileMenuName = _("Su-25"),
version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _("The Su-25 'Grach' (Rook), NATO callsigned 'Frogfoot', is a dedicated strike attack aircraft designed for the close air support and anti-tank roles. The Su-25 has seen combat in several conflicts during its more than 25 years in service. The Su-25 combines excellent pilot protection and high speed compared to most dedicated attack aircraft. It can be armed with a variety of weapon systems including guided missiles, bombs, rockets, and its internal 30mm cannon."),

rules = 
{	
	["Flaming Cliffs by Eagle Dynamics"] = { required = false , disabled = true }
},

linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/su-25_dcs_world/",
        STEAM   = "http://store.steampowered.com/app/223750",
        GAMEFLY = "http://www.gamefly.com/Download-Su-25-DCS-Flaming-Cliffs/5006553",
        GAMEFLY_UK = "http://www.gamefly.co.uk/Download-Su-25-DCS-Flaming-Cliffs/5006554/",
    },

Skins	= 
	{
		{
			name	= _("Su-25"),
			dir		= "Skins/1"
		},
	},
})

----------------------------------------------------------------------------------------
plugin_done()
