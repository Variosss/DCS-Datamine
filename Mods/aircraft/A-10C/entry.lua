local self_ID  = "A-10C Warthog by Eagle Dynamics"
declare_plugin(self_ID,
{
image     	 = "A-10C.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,

displayName	 = _("A-10C Warthog"),
fileMenuName = _("A-10C"),
update_id    = "A-10C",
registryPath = "Eagle Dynamics\\Warthog",
version		 = __DCS_VERSION__,		 
state		 = "installed",
info		 = _("The A-10C is the premier attack jet for the U.S. Air Force and combines awesome firepower with advanced sensors and survivability. The 30mm cannon, Maverick missiles, GPS and laser guided bombs, and rockets are just a few of its many weapons. Almost every switch, dial and button in the A-10C cockpit is controllable and allows you to operate the aircraft just as a real A-10C pilot would."),
binaries 	 =
{
'A10',
"Cockpit_A10Common",
"Cockpit_A10C",
},

InputProfiles =
{
    ["A-10C"]      = current_mod_path .. '/Input/A-10C',
},


Skins	= 
	{
		{
			name	= _("A-10C"),
			dir		= "Skins/1"
		},
	},
	
Missions =
	{
		{
			name		= _("A-10C"),
			dir			= "Missions",	
		},
	},	

Options =
    {
        {
            name		= _("A-10C"),
            nameId		= "A-10C",
            dir			= "Options",
            CLSID		= "{A-10C options}"
        },
    },
LogBook =
	{
		{
			name		= _("A-10C"),
			type		= "A-10C",
		},
	},	
})

mount_vfs_liveries_path(current_mod_path .. "/Liveries")
mount_vfs_texture_path(current_mod_path ..  "/Skins/1/ME")--for simulator loading window

dofile(current_mod_path.."/Views.lua")
make_view_settings('A-10C'  , ViewSettings, SnapViews)

----------------------------------------------------------------------------------------
make_flyable('A-10C',current_mod_path..'/Cockpit/Scripts/',{self_ID,'A10'},current_mod_path..'/comm.lua')--make_flyable(obj_name,optional_cockpit path,optional_fm = {mod_of_fm_origin,dll_with_fm})
----------------------------------------------------------------------------------------
plugin_done()