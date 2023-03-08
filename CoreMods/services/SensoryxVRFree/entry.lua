declare_plugin("SensoryxVRFreeSupport",{
developerName	  = "Eagle Dynamics",
state		 	  = "installed",
version		 	  = __DCS_VERSION__,
binaries 	 	  = {'edSensoryxVRFree'},
Options 		  =
{
	{
		name		= _("VRFree"),
		nameId		= "VRFree",
		dir			= "Options",
		CLSID		= "{VRFree}",
		icon 		= current_mod_path.."/Options/VRFree_Banner.png",
		allow_in_simulation = true;
	},
},
})
plugin_done()