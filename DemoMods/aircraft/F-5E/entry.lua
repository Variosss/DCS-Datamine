local self_ID = "F-5E by Belsimtek"
declare_plugin(self_ID,
{
dirName			= current_mod_path,

version			= __DCS_VERSION__,		 
state			= "sale",
developerName	= _("Belsimtek"),
info			= _("F-5E Tiger II is a supersonic light fighter designed in the 1970s by Northrop Corporation. Air-to-air missiles and two 20-mm guns combined with excellent aircraft manoeuvrability reveal its air superiority potential while a wide range of armament makes F-5E a capable ground-attack platform. Considering its great military characteristics and relatively low cost, the aircraft became very popular in the global military market."),

Skins = 
	{
		{
			name	= _("F-5E"),
			dir		= "Theme/1"
		},
	},

linkBuy =
    {
        ED      	= "https://www.digitalcombatsimulator.com/en/shop/modules/tiger/",
    },
})

plugin_done()-- finish declaration , clear temporal data
