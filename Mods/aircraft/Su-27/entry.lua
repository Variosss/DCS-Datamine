--do return end

local self_ID = "Su-27 Flanker by Eagle Dynamics"
declare_plugin(self_ID,
{
image     	 = "Su-27.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

fileMenuName = _("Su-27"),
displayName = _("Su-27"),
update_id        = "SU-27",
registryPath	 = "Eagle Dynamics\\SU27",
version		 = __DCS_VERSION__.." beta",
state		 = "installed",
info		 = _("The Su-27, NATO codename Flanker, is one of the pillars of modern-day Russian combat aviation. Built to counter the American F-15 Eagle, the Flanker is a twin-engine, supersonic, highly manoeuvrable air superiority fighter."),
rules = 
{	
	["Flaming Cliffs by Eagle Dynamics"] = { required = false , disabled = true }
},

binaries 	 =
{
'Su27',
'SU27CWS'
},

InputProfiles =
{
   ["su-27"] = current_mod_path .. '/Input/su-27',
   ["J-11A"] = current_mod_path .. '/Input/j-11a',
},


Skins	=
	{
		{
			name	= _("Su-27"),
			dir		= "Skins/1"
		},
	},

Missions =
	{
		{
			name		= _("Su-27"),
			dir			= "Missions",
		},
	},	
LogBook =
	{
		{
			name		= _("Su-27"),
			type		= "Su-27",
		},
		{
			name		= _("J-11A"),
			type		= "J-11A",
		},	
	},	
Options =
    {
        {
            name		= _("Su-27"),
            nameId		= "Su-27",
            dir			= "Options",
            CLSID		= "{Su-27 options}"
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
mount_vfs_texture_path  (current_mod_path ..  "/Cockpit/Textures/SU-27S-CPT-TEXTURES")
mount_vfs_model_path    (current_mod_path ..  "/Cockpit/Shape")
mount_vfs_liveries_path (current_mod_path ..  "/Liveries")


----------------------------------------------------------------------------------------
--make_flyable(obj_name,optional_cockpit path,optional_fm = {mod_of_fm_origin,dll_with_fm})
MAC_flyable('Su-27' , current_mod_path..'/Cockpit/KneeboardLeft/', {self_ID,'Su27',old = true}, current_mod_path..'/Comm/Su-27.lua')
MAC_flyable('J-11A'	, current_mod_path..'/Cockpit/KneeboardLeft/', {self_ID,'Su27',old = 3	 }, current_mod_path..'/Comm/Su-27.lua')
--set_manual_path('Su-27', current_mod_path .. '/Doc/manual')
----------------------------------------------------------------------------------------
plugin_done()
