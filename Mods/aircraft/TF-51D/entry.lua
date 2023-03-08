local self_ID = "TF-51D Mustang by Eagle Dynamics"
declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

displayName	 = _("TF-51D Mustang"),
fileMenuName = _("TF-51D"),
version		 = __DCS_VERSION__,
state		 = "installed",
info		 = _("The Mustang was among the best and most well-known fighters used by the U.S. Army Air Forces during WWII. Possessing excellent range and maneuverability, the P-51 operated primarily as a long-range escort fighter and also as a ground attack fighter-bomber with bombs, rockets, and machine guns. TF-51 is two-seat and unarmed version of P-51D."),
binaries 	 =
{
'TF51D',
},

InputProfiles =
{
    ["TF-51D"]      = current_mod_path .. '/Input/TF-51D',
},



Skins	=
	{
		{
			name	= _("TF-51D"),
			dir		= "Skins/1"
		},
	},

Missions =
	{
		{
			name		= _("TF-51D"),
			dir			= "Missions",	
		},
	},	

Options = 
	{
		{
			name		= _("TF-51D"),
			nameId		= "TF-51D",
			dir			= "Options",
		},
	},
LogBook =
	{
		{
			name		= _("TF-51D"),
			type		= "TF-51D",
		},
	},		
preload_resources = 
	{
		textures   = {},
		models     = {"sled"},
		fonts      = {},
		explosions = {},
	},
})

mount_vfs_liveries_path(current_mod_path .. "/Liveries")
mount_vfs_model_path   (current_mod_path .. "/Shapes")
mount_vfs_texture_path (current_mod_path .. "/Skins/1/ME")--for simulator loading window

----------------------------------------------------------------------------------------
make_flyable('TF-51D',current_mod_path..'/Cockpit/Scripts/',{self_ID,'TF51D'},current_mod_path..'/comm.lua')
set_manual_path('TF-51D', current_mod_path .. '/Doc/manual')
----------------------------------------------------------------------------------------

dofile(current_mod_path..'/TF-51D.lua')
plugin_done()
