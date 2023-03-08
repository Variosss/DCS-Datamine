local self_ID = "Mi-24P by Eagle Dynamics"
declare_plugin(self_ID,
{
installed 	 = false, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
displayName  = _("Mi-24P"),

fileMenuName = _("Mi-24P"),
update_id    = "MI-24P",
version		 = "EA",
state		 = "installed",
developerName = _("Eagle Dynamics"),
info		 = _("Mi-24P is the iconic, recognizable, and venerable helicopter which scores the highest number of combat involvements in various conflicts. Fast and reliable, it allows you to engage small-sized mobile and stationary ground targets with dumb and guided weapons, as well as destroy other enemy aircraft. Perform CAS missions, escort convoys, counteract enemy helicopters using a powerful double-barreled 30-mm cannon, air bombs, various guided and unguided missiles. Typically this helicopter is capable to destroy 4-6 armored targets per mission."),
binaries 	 =
{
'Mi24',
'CockpitMi24',
},

InputProfiles =
{
    ["Mi-24P_pilot"]      		= current_mod_path .. '/input/Mi_24P_pilot',
	["Mi-24P_operator"]      	= current_mod_path .. '/input/Mi_24P_op',
	["Mi-24P_AimingStation"]    = current_mod_path .. '/input/Mi_24P_AimingStation',
	["Mi-24P_AI_Menu"]      	= current_mod_path .. '/input/Mi_24P_AI_Menu',
	["Mi-24P_Gunner"] 			= current_mod_path .. '/input/Mi-24P_Gunner',  
	["Mi-24P_TrackIR_Gunner"] 	= current_mod_path .. '/input/Mi-24P_TrackIR_Gunner',  

},


Skins	=
	{
		{
			name	= _("Mi-24P"),
			dir		= "Skins/1"
		},
	},

Missions =
	{	
		{
			name		= _("Mi-24P"),
			dir			= "Missions",
		},
	},	

LogBook =
	{
		{
			name		= _("Mi-24P"),
			type		= "Mi-24P",
		},
	},	

Options =
	{
		{
			name		= _("Mi-24P"),
			nameId		= "Mi-24P",
			dir			= "Options",
		},
	},
	
preload_resources = {
	textures   = 
		{
		},
	models     = {},
	fonts      = {},
	explosions = {},
	},
})

mount_vfs_liveries_path(current_mod_path .. "/Liveries")
mount_vfs_texture_path(current_mod_path ..  "/Skins/1/ME")--for simulator loading window
dofile(current_mod_path.."/Views.lua")

make_view_settings('Mi-24P', ViewSettings, SnapViews)
----------------------------------------------------------------------------------------
make_flyable('Mi-24P',current_mod_path..'/Cockpit/Scripts/',{self_ID,'Mi24'}, current_mod_path..'/comm.lua')--make_flyable(obj_name,optional_cockpit path,optional_fm = {mod_of_fm_origin,dll_with_fm})
----------------------------------------------------------------------------------------
plugin_done()
