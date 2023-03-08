local self_ID  = "M-2000C by RAZBAM Sims"
declare_plugin(self_ID,
{
displayName     = _("M-2000C"),
developerName   =   "RAZBAM Sims",

installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
fileMenuName = _("M-2000C"),
update_id    = "RAZBAM_M-2000C", -- request from ED.
version		 = __DCS_VERSION__,
state		 = "installed",
registryPath = "Eagle Dynamics\\M2000C",
info		 = _("The M-2000C is a French multirole, single-engine fourth-generation jet fighter. It was designed in the late 1970s as a lightweight fighter based on previous delta winged aircraft for the French Air Force (Armee de l'Air). The M-2000 evolved into a multirole aircraft with several variants developed. Over 600 aircraft were built and it has been in service with nine nations."),
binaries 	 =
	{
		'M2KC_FM',
		'M2KC_CPT',
	},
InputProfiles =
	{
		["M-2000C"]     = current_mod_path .. '/Input/M-2000C',
	},
Skins	=
	{
		{
			name	= _("M-2000C"),
			dir		= "Skins/1"
		},
	},
Missions =
	{
		{
			name		= _("M-2000C"),
			dir			= "Missions",
			CLSID		= "{CLSID5456456346CLSID}",
		},
	},
LogBook =
	{
		{
			name		= _("M-2000C"),
			type		= "M-2000C",
		},
	},
Options =
    {
        {
            name		= _("M-2000C"),
            nameId		= "M-2000C",
            dir			= "Options",
            CLSID		= "{M-2000C options}"
        },
    }, 	
})
---------------------------------------------------------------------------------------
mount_vfs_model_path   (current_mod_path.."/Shapes")
mount_vfs_liveries_path(current_mod_path.."/Liveries")
mount_vfs_texture_path (current_mod_path.."/Skins/1/ME")--for simulator loading window
mount_vfs_texture_path (current_mod_path.."/Textures/M-2000C-CPT")
dofile(current_mod_path.."/Views.lua")

make_view_settings('M-2000C', ViewSettings, SnapViews)

---------------------------------------------------------------------------------------
-- AFM START
---------------------------------------------------------------------------------------
local cfg_path = current_mod_path ..  "/FM/config.lua"
dofile(cfg_path)
M2KFM[1] 				= self_ID
M2KFM[2] 				= 'M2KC_FM'
M2KFM.config_path 		= cfg_path
---------------------------------------------------------------------------------------
-- AFM END
---------------------------------------------------------------------------------------
make_flyable("M-2000C",current_mod_path..'/Cockpit/',M2KFM,current_mod_path..'/Comm/comm.lua')
---------------------------------------------------------------------------------------

plugin_done()-- finish declaration , clear temporal data
