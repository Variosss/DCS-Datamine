local self_ID  = "AV-8B N/A by RAZBAM Sims"
declare_plugin(self_ID,
{
displayName     = _("AV-8B N/A"),
shortName	  	=   "AV8BNA",
developerName   =  _("RAZBAM Sims"),

installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
fileMenuName = _("AV-8B N/A"),
update_id    = "RAZBAM_AV8BNA",
version		 = _DCS_VERSION_,
state		 = "installed",
info		 = _("The AV-8B Harrier II Night Attack is a single-engine ground-attack aircraft that constitutes the second generation of the Harrier Jump Jet family. Capable of vertical or short takeoff and landing (V/STOL), the aircraft was designed in the late 1970s as an Anglo-American development of the British Hawker Siddeley Harrier, the first operational V/STOL aircraft. Named after a bird of prey, it is primarily employed on light attack or multi-role missions, ranging from close air support of ground troops to armed reconnaissance."),
binaries 	 =
	{
		'AV8B_CPT',
		'AV8B_FM',
	},
InputProfiles =
	{
		["AV8BNA"]     = current_mod_path .. '/Input/AV8BNA',
	},
Skins	=
	{
		{
			name	= _("AV8BNA"),
			dir		= "Skins/1"
		},
	},
Missions =
	{
		{
			name		= _("AV8BNA"),
			dir			= "Missions",
			CLSID		= "{CLSID5456475346CLSID}",
		},
	},
LogBook =
	{
		{
			name		= _("AV8BNA"),
			type		= "AV8BNA",
		},
	},
Options =
    {
        {
            name		= _("AV-8B N/A"),
            nameId		= "AV8BNA",
            dir			= "Options",
            CLSID		= "{AV-8B NA options}"
        },
    }, 	
})
---------------------------------------------------------------------------------------
mount_vfs_model_path   (current_mod_path.."/Shapes")
mount_vfs_liveries_path(current_mod_path.."/Liveries")
mount_vfs_texture_path (current_mod_path.."/Skins/1/ME")--for simulator loading window
mount_vfs_texture_path (current_mod_path.."/Textures/AV8BNA-CPT")
---------------------------------------------------------------------------------------
dofile(current_mod_path.."/Views.lua")
make_view_settings('AV8BNA', ViewSettings, SnapViews)

---------------------------------------------------------------------------------------
-- AFM START
---------------------------------------------------------------------------------------
local cfg_path = current_mod_path ..  "/FM/config.lua"
dofile(cfg_path)
AV8BFM[1] 				= self_ID
AV8BFM[2] 				= 'AV8B_FM'
AV8BFM.config_path 		= cfg_path
---------------------------------------------------------------------------------------
-- AFM END
---------------------------------------------------------------------------------------
make_flyable("AV8BNA",current_mod_path..'/Cockpit/',AV8BFM,current_mod_path..'/Comm/comm.lua') -- AFM ON
--make_flyable("AV8BNA",current_mod_path..'/Cockpit/',nil,current_mod_path..'/Comm/comm.lua') -- SFM ON
---------------------------------------------------------------------------------------
--turn_on_waypoint_panel('AV8BNA', true, true)

plugin_done()-- finish declaration , clear temporal data
