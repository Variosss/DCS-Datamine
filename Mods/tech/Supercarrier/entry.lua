local localized = _("Supercarrier")
local mission_category   = _("Supercarrier Required")

declare_plugin("Supercarrier",
{
dirName		  = current_mod_path,
displayName   = localized,
shortName	  = "Supercarrier",
update_id     = "SUPERCARRIER",
version		  = __DCS_VERSION__,
state		  = "installed",
developerName = "Eagle Dynamics",
info		  = localized,
load_immediately = true,

Skins	= 
	{
		{
			name	= localized,
			dir		= "Skins"
		},
	},
Options = 
	{
		{
			name		= localized,
			nameId		= "Supercarrier",
			dir			= "Options",			
			allow_in_simulation = true,
		},
	},	
attachMissionsToMods = 
	{
		["F/A-18C"] = 
		{
			name		= mission_category,
			MissionsDir =  "Missions",
		},
	},	
binaries 	 = 
{
	"edSupercarrier",
},
})
----------------------------------------------------------
mount_vfs_liveries_path (current_mod_path ..  "/Liveries")
mount_vfs_model_path    (current_mod_path ..  "/Shapes")
mount_vfs_texture_path	(current_mod_path ..  "/Textures/Nimitz_LSO")
------------------------------------
unlock_player_interaction("CVN_71")
unlock_player_interaction("CVN_72")
unlock_player_interaction("CVN_73")
unlock_player_interaction("CVN_75")
unlock_player_interaction("CV_1143_5")
unlock_player_interaction("USS_Arleigh_Burke_IIa")

------------------------------------
plugin_done()
