local self_ID = "UH-1H Huey by Belsimtek"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _("While earlier Hueys were a success, the Army wanted a version that could carry more troops. Bell's solution was to stretch the HU-1B fuselage by 41 in (104 cm) and use the extra space to fit four seats next to the transmission, facing out. Seating capacity increased to 15, including crew. The enlarged cabin could also accommodate six stretchers and a medic, two more than the earlier models. In place of the earlier model's sliding side doors with a single window, larger doors were fitted which had two windows, plus a small hinged panel with an optional window, providing access to the cabin. The doors and hinged panels were quickly removable, allowing the Huey to be flown in a doors off configuration. In 1966, Bell installed the 1,400 shp (1,000 kW) Lycoming T53-L-13 engine to provide more power for the aircraft. Production models in this configuration were designated as the UH-1H."),

linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/dcs_uh1h_huey/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },

Skins	=
	{
		{
			name	= _("UH-1H"),
			dir		= "Skins/1"
		},
	},
})

----------------------------------------------------------------------------------------
plugin_done()
