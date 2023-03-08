declare_plugin("CaptoGloveSupport",{
developerName	  = "Eagle Dynamics",
state		 	  = "installed",
version		 	  = __DCS_VERSION__,
binaries 	 	  = {'edCaptoGlove'},
Options 		  =
{
	{
		name		= _("Capto Glove"),
		nameId		= "CaptoGlove",
		dir			= "Options",
		CLSID		= "{Capto Glove}",
		icon 		= current_mod_path.."/Options/icon.png",
		allow_in_simulation = true;
	},
},
})
plugin_done()