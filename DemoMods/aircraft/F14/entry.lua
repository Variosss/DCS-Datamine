local self_ID = "F-14B by Heatblur Simulations"

declare_plugin(self_ID,
{
installed 	 = true,
dirName	 	 = current_mod_path,

displayName  = _("F-14"),
version		 = __DCS_VERSION__ .. "EA",
state		 = "sale",
info		 = _("The Legendary F-14 Tomcat is a variable-wing multi-role fleet defender with unmatched air to air capability. Incorporating a pilot and RIO 2-man crew, the Tomcat leverages its powerful AWG-9 radar to reach out and destroy enemy aircraft at unmatched distances, using weaponry such as the AIM-54A/C Phoenix, AIM-7 Sparrow and AIM-9 missiles. Through the LANTIRN upgrade programme, the F-14 became an effective strike aircraft, affectionally dubbed the 'Bombcat', the F-14 can employ a large assortment of unguided and guided weaponry while maintaining excellent range and air to air capability."),
linkBuy 	 =
{
	ED      = "https://www.digitalcombatsimulator.com/en/products/planes/tomcat/",
},
Skins	=
	{
		{
			name	= "F-14B",
			dir		= "Skins"
		},
	},
})

plugin_done()
