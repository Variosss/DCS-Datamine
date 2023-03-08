declare_plugin("Su-25T by Eagle Dynamics",
{
displayName     = _("Su-25T Frogfoot"),
developerName   =   "Eagle Dynamics",

image     	 = "FC.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
fileMenuName = _("Su-25T"),

version		 = __DCS_VERSION__,
state		 = "installed",
info		 = _("The Su-25 Frogfoot is the primary close air support aircraft of Russia and many other countries. The Su-25T is an improved version of the Su-25, that includes more advanced weapons and sensors. Capable of employing anti-tank missiles, anti-SAM radar missiles, rockets and bombs, the Frogfoot is a balance of speed, firepower, survivability, and battlefield versatility."),

InputProfiles =
{
    ["su-25T"] = current_mod_path .. '/Input/su-25T',
},


Skins	=
	{
		{
			name	= _("Su-25T"),
			dir		= "Theme"
		},
	},
	
Missions =
	{
		{
			name		    = _("Su-25T"),
			dir			    = "Missions",
            training_ids    = {EN = 'SU-25T_video_EN', RU = 'SU-25T_video_RU'},
		},
	},		

LogBook =
	{
		{
			name		= _("Su-25T"),
			type		= "Su-25T",
		},
	},	
Options =
    {
        {
            name		= _("Su-25T"),
            nameId		= "Su-25T",
            dir			= "Options",
            CLSID		= "{Su-25T options}"
        },
    }, 	
})

mount_vfs_texture_path(current_mod_path ..  "/Theme/ME")--for simulator loading window
mount_vfs_texture_path  (current_mod_path ..  "/Cockpit/Textures/SU-25T-CPT-TEXTURES")
mount_vfs_model_path    (current_mod_path ..  "/Cockpit/Shape")
mount_vfs_liveries_path (current_mod_path ..  "/Liveries")

local support_cockpit = current_mod_path..'/Cockpit/Scripts/'

----------------------------------------------------------------------------------------
MAC_flyable('Su-25T', support_cockpit, nil, current_mod_path..'/comm.lua')
----------------------------------------------------------------------------------------
plugin_done()
