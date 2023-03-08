declare_plugin("F/A-18C",
{
installed		= true, -- if false that will be place holder , or advertising
dirName			= current_mod_path,

version			= __DCS_VERSION__,		 
state			= "sale",
info			= _("F/A-18C PFM + ASM"),

Skins = 
	{
		{
			name	= _("F/A-18C"),
			dir		= "Skins/1"
		},
	},

linkBuy =
    {
        ED      	= "https://www.digitalcombatsimulator.com/en/shop/modules/hornet/",
    },
})

plugin_done()