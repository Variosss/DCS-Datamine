declare_plugin("F-16C bl.50",
{
installed		= true, -- if false that will be place holder , or advertising
dirName			= current_mod_path,

version			= __DCS_VERSION__,		 
state			= "sale",
info			= _("The F-16C Viper is a single-engine, supersonic, multi-role fighter that is flown by the United States and many other countries. Over 4,600 Vipers have been built, making it one of the most successful fighter aircraft in history. The Viper is equally capable at downing aircraft as it is attacking ground targets. It is equipped with a large suite of sensors that include radar, target pod, and a helmet mounted sight; and its’ weapons include an internal 20mm cannon, unguided bombs and rockets, laser- and GPS-guided bombs, air-to-surface missiles of all sorts, and both radar- and infrared-guided air-to-air missiles."),

Skins = 
	{
		{
			name	= _("F-16C"),
			dir		= "Skins/1"
		},
	},

linkBuy =
    {
        ED      	= "https://www.digitalcombatsimulator.com/en/shop/modules/viper/",
    },
})

plugin_done()