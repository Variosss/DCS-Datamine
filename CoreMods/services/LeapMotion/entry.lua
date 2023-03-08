declare_plugin("LeapMotionSupport",{
developerName	  = "Eagle Dynamics",
state		 	  = "installed",
version		 	  = __DCS_VERSION__,
binaries 	 	  = {'edLeapMotion'},
Options 		  =
{
	{
		name		= _("LeapMotion"),
		nameId		= "LeapMotion",
		dir			= "Options",
		CLSID		= "{LeapMotion}",
		icon 		= current_mod_path.."/Options/LeapMotion_Banner.png",
		allow_in_simulation = true;
	},
},
})
plugin_done()