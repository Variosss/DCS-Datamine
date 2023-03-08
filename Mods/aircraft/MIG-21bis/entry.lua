--/N/ Sep 2015, rev May 2020
--/M/ Dec 2015
--/M/ May 2017

local self_ID = "MiG-21Bis by Magnitude 3 LLC"

declare_plugin(self_ID,
{
--image     	 = "MiG-21.png",
installed 	 = true,
dirName	 	 = current_mod_path,
displayName = _("MiG-21bis"),
--shortName	 =   "MiG-21Bis",
fileMenuName = _("MiG-21bis"),
update_id        = "MIG-21BIS",
registryPath = "Leatherneck Simulations\\DCS:MiG-21 BiS",
DRM_controller = "bin/pcnsl.exe",
version		 =  __DCS_VERSION__,
state		 = "installed",
info		 = _("Initially designed in the late 1950s, the MiG-21 is today one of the most iconic tactical fighter/interceptor aircraft. It has participated in several local wars and conflicts and is still seeing widespread use in original or upgraded versions. Well known for its simplicity and durability, it was the aircraft of choice for many pilots and a highly respected opponent during the early jet era."),

binaries 	 =
{
'FlightModel',
'Avionics',
},

InputProfiles =
	{
		["MiG-21Bis"] 		= current_mod_path..'/Input/MiG-21/',
	},

Skins	= 
	{
		{
			name	= "MiG-21bis",
			dir		= "Skins/1"
		},
	},
Missions =
	{
		{
			name		= _("MiG-21bis"),
			dir			= "Missions",
		},
	},	
LogBook =
	{
		{
			name		= _("MiG-21bis"),
			type		= "MiG-21Bis",
		},
	},

Options =
	{
		{
			name		= _("MiG-21bis"),
			nameId		= "MiG-21Bis",
			dir			= "Options",
		},
	},

preload_resources = {
	textures = {},
	models = {},
	fonts = {},
	explosions = {},
	},

})



--mount_vfs_sound_path(current_mod_path.."/Sounds")
mount_vfs_texture_path(current_mod_path.."/Skins/1/ME")
mount_vfs_model_path(current_mod_path.."/Shapes")
mount_vfs_texture_path(current_mod_path.."/Textures")
mount_vfs_texture_path(current_mod_path.."/Textures/Avionics")
mount_vfs_liveries_path(current_mod_path.."/Liveries") --DON'T change this please. It is necessary for English Cockpit and Mirrors.

dofile(current_mod_path.."/Entry/01_Suspension.lua")
dofile(current_mod_path.."/Entry/03_Views.lua")



local FM = {
	self_ID, 
	'FlightModel',
	old = false,

	--center_of_mass = {0.02453, -0.0052, 0.004376},
	center_of_mass = {0.00, 0.00, 0.0044},
	moment_of_inertia = {6000, 50000, 58000},
	--config_path = current_mod_path..'/Entry/Ha',
	suspension = suspension,
}

make_view_settings('MiG-21Bis', ViewSettings, SnapViews)
make_flyable('MiG-21Bis',current_mod_path..'/Cockpit/',FM,current_mod_path..'/Entry/comm21.lua')
--set_manual_path('MiG-21Bis', current_mod_path .. '/Doc/manual')

plugin_done()
