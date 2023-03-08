--do return end

local self_ID = "Su-33 Flanker by Eagle Dynamics"
declare_plugin(self_ID,
{
image     	 = "Su-33.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

fileMenuName = _("Su-33"),
displayName = _("Su-33"),
update_id        = "SU-33",
registryPath	 = "Eagle Dynamics\\SU33",
version		 = __DCS_VERSION__.." beta",
state		 = "installed",
info		 = _("The Su-33 is an all-weather fighter that has been the backbone of Russian aircraft carrier aviation since the late 1990s. Based on the powerful Su-27 'Flanker', the Su-33 is a navalized version suited for operations aboard the Admiral Kuznetsov aircraft carrier. Changes to the fighter include strengthened landing gear, folding wings, more powerful engines, and the very visible canards."),
rules = 
{	
	["Flaming Cliffs by Eagle Dynamics"] = { required = false , disabled = true }
},

binaries 	 =
{
'Su33',
'SU33CWS'
},

InputProfiles =
{
   ["su-33"]      = current_mod_path .. '/Input',
},


Skins	=
	{
		{
			name	= _("Su-33"),
			dir		= "Skins/1"
		},
	},

Missions =
	{
		{
			name		= _("Su-33"),
			dir			= "Missions",
		},
	},	
LogBook =
	{
		{
			name		= _("Su-33"),
			type		= "Su-33",
		},
	},	
Options =
    {
        {
            name		= _("Su-33"),
            nameId		= "Su-33",
            dir			= "Options",
            CLSID		= "{Su-33 options}"
        },
    }, 	
preload_resources = 
	{
		textures   = {},
		models     = {},
		fonts      = {},
		explosions = {},
	},
})

mount_vfs_texture_path(current_mod_path ..  "/Skins/1/ME")--for simulator loading window
mount_vfs_texture_path  (current_mod_path ..  "/Cockpit/Textures/SU-33-CPT-TEXTURES")
mount_vfs_model_path    (current_mod_path ..  "/Cockpit/Shape")
mount_vfs_liveries_path (current_mod_path ..  "/Liveries")


----------------------------------------------------------------------------------------
--make_flyable(obj_name,optional_cockpit path,optional_fm = {mod_of_fm_origin,dll_with_fm})
MAC_flyable('Su-33', current_mod_path..'/Cockpit/KneeboardLeft/', {self_ID,'Su33',old = true}, current_mod_path..'/Comm/Su-33.lua')

----------------------------------------------------------------------------------------
plugin_done()
