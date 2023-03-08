local jsAvionics_disp  = _("jsAvionics")
declare_plugin("jsAvionics",
{
	dirName		  = current_mod_path,
	displayName   = ns430_disp,
	shortName	  = "jsAvionics",
	fileMenuName  = "jsAvionics",
	version		  = "1.0",
	state		  = "installed",
	developerName = "Eagle Dynamics",
	info		  = "jsAvionics",
	binaries 	  = 
	{
		'jsAvionics',
	},
	load_immediately = true,
})
plugin_done()
