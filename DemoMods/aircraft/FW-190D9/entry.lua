self_ID = "FW-190D9 Dora by Eagle Dynamics"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("Fw 190 D-9"),

version		 = __DCS_VERSION__,
state		 = "sale",
info		 = _("The Dora variant of the famous Fw 190 fighter was nicknamed the Long-Nose by German pilots as well as the Allies. The Focke-Wulf Fw 190 is not just one of Germany's greatest fighter planes; it is perhaps one of the most famous aircraft of the entire Second World War. Featuring many advances and innovations, it broke new ground in terms of pilot comfort, ease of use, and versatility."),


linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/dora/",
        STEAM   = "http://store.steampowered.com/app/223750",
    },

Skins	= 
	{
		{
			name	= _("Fw 190 D-9"),
			dir		= "Skins/1"
		},
	},

})

plugin_done()
