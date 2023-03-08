local self_ID = "UH-1H Huey by Belsimtek"
declare_plugin(self_ID,
{
image     	 = "Uh-1H.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

displayName		= _("UH-1H Huey"),
shortName = 'UH-1H',
fileMenuName = _("UH-1H"), 
update_id        = "UH-1H",
registryPath	 = "Eagle Dynamics\\UH1H",
version		 = __DCS_VERSION__,
state		 = "installed",
info		 = _("The UH-1 Iroquois, better known as the Huey, is one of the most iconic helicopters in the world. Indispensable in the Vietnam War, the Huey continues to serve in both military and civilian roles around the globe today. DCS: UH-1H features an updated model of the helicopter armed with rockets, gatling guns, and door gunner machine guns. The simulation offers both extreme realism in its flight and systems modeling as well as a variety of options to reduce the learning curve for new players, including an Easy flight mode. DCS: UH-1H provides multiple player positions, including pilot, co-pilot, and door gunners."),
infoWaitScreen = "Bell, UH-1H Huey, emblems, logos, and body designs are trademarks of Textron Innovations Inc.\nand are used under license by Sky Jet International LLC. ",
binaries 	 =
{
'UH1H',
'CockpitUH1H',
},

InputProfiles =
{
    ["UH-1H"]      = current_mod_path .. '/input/UH-1H',
	["UH-1H_Gunner"] = current_mod_path .. '/input/UH-1H_Gunner',
	["UH-1H_TrackIR_Gunner"] = current_mod_path .. '/input/UH-1H_TrackIR_Gunner',  	
},


Skins	=
	{
		{
			name	= _("UH-1H"),
			dir		= "Skins/1"
		},
	},

Missions =
	{
		{
			name		= _("UH-1H"),
			dir			= "Missions",
            training_ids    = {EN = 'UH-1H_video_EN',},
		},
	},	

LogBook =
	{
		{
			name		= _("UH-1H"),
			type		= "UH-1H",
		},
	},	

Options =
	{
		{
			name		= _("UH-1H"),
			nameId		= "UH-1H",
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

mount_vfs_texture_path(current_mod_path .. "/Cockpit/Textures/UH-1H-CPT-TEXTURES")
mount_vfs_texture_path(current_mod_path ..  "/Skins/1/ME")--for simulator loading window 
mount_vfs_liveries_path(current_mod_path .. "/Liveries")

dofile(current_mod_path.."/Views.lua")

make_view_settings('UH-1H', ViewSettings, SnapViews)


----------------------------------------------------------------------------------------
make_flyable('UH-1H',current_mod_path..'/Cockpit/Scripts/',{self_ID,'UH1H'}, current_mod_path..'/comm.lua')--make_flyable(obj_name,optional_cockpit path,optional_fm = {mod_of_fm_origin,dll_with_fm})
set_manual_path('UH-1H', current_mod_path .. '/Doc/manual')
----------------------------------------------------------------------------------------
plugin_done()
