local self_ID = "Ka-50 Black Shark by Eagle Dynamics"
declare_plugin(self_ID,
{
image     	 = "Ka-50.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

fileMenuName = _("Ka-50"),
update_id    = "KA-50",
displayName  = _("Ka-50 Black Shark"),
registryPath = "Eagle Dynamics\\Black Shark 2",
version		 = __DCS_VERSION__,
state		 = "installed",
info		 = _("The Ka-50 is a Russian attack helicopter of exceptional design and capability. Featuring its unique counter-rotating rotors, the Black Shark also employs a variety of guided missiles, rockets, and bombs. As the only operational single seat attack helicopter, the Black Shark has features such as an ejection seat and avionics that assist the single pilot workload. "),
binaries 	 =
{
'Ka50',
'CockpitKa50',
},

InputProfiles =
{
    ["Ka-50"]      = current_mod_path .. '/input/ka-50',
},


Skins	=
	{
		{
			name	= _("Ka-50"),
			dir		= "Skins/1"
		},
	},

Missions =
	{
		{
			name		    = _("Ka-50"),
			dir			    = "Missions",
            training_ids    = {EN = 'KA-50_video_EN', RU = 'KA-50_video_RU',},
		},
	},	

LogBook =
	{
		{
			name		= _("Ka-50"),
			type		= "Ka-50",
		},
	},	

Options =
	{
		{
			name		= _("Ka-50"),
			nameId		= "Ka-50",
			dir			= "Options",
		},
	},

preload_resources = {
	textures   = 
		{
			"KA-50-blade.bmp",
			"DAMAGE_Ka-50_n.bmp",
			"DAMAGE_Ka-50_n1.bmp",
			"DAMAGE_Ka-50_1.tga",
			"DAMAGE_KA-50_2.bmp",			
		},
	models     = {},
	fonts      = {},
	explosions = {},
	},
})

mount_vfs_liveries_path(current_mod_path .. "/Liveries")
mount_vfs_texture_path(current_mod_path ..  "/Skins/1/ME")--for simulator loading window

dofile(current_mod_path.."/Views.lua")
make_view_settings('Ka-50', ViewSettings, SnapViews)
----------------------------------------------------------------------------------------
make_flyable('Ka-50',current_mod_path..'/Cockpit/Scripts/',{self_ID,'Ka50'}, current_mod_path..'/comm.lua')--make_flyable(obj_name,optional_cockpit path,optional_fm = {mod_of_fm_origin,dll_with_fm})
----------------------------------------------------------------------------------------
plugin_done()
