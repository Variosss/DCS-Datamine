--/N/ 03. MAY 2018.

local self_ID = "Christen Eagle II by Magnitude 3 LLC"

declare_plugin(self_ID,
{
installed 	 = true,
dirName	 	 = current_mod_path,
displayName  = _("Christen Eagle II"),
version		 = __DCS_VERSION__,
state		 = "sale",
info		 	= _("\n The Christen Eagle II, which later became the Aviat Eagle II in the mid-1990s, is an aerobatic sporting biplane aircraft that has been produced in the United States since February 1977. It was designed in 1976 by a P-51 Mustang pilot and aerobatic competitor Frank Christensen. For pure flying excitement and adventure, you'll find an Eagle hard to beat, while being well within the capability of most competent tailwheel pilots. The fully inverted fuel and oil systems make all of this stuff child's play. \n Flight Review: The Enduring Eagle \n by Bob Grimstead \n\n I used to regard the Eagle as a substandard Pitts, but I was wrong. The 200-horsepower Eagle outperforms any 200-hp two-place Pitts, and its cleaner airframe is roomier, more comfortable, more affordable, better finished and has superior visibility in addition to being easier to control. As an aerobatic two-place biplane, the Eagle's ability is surpassed only by the six-cylinder Pitts S-2B with nearly 50% more power (but lower G limits)."),
linkBuy =
    {
        ED      = "https://www.digitalcombatsimulator.com/en/shop/modules/christen_eagle/",
		STEAM   = "https://store.steampowered.com/app/1024703/DCS_Christen_Eagle_II/",
    },
Skins	= 
	{
		{
			name	= "Christen Eagle II",
			dir		= "Skins"
		},
	},
})
plugin_done()
