local self_ID  = "A-10C II Warthog by Eagle Dynamics"
declare_plugin(self_ID,
{
image     	 = "A-10C.bmp",
installed 	 = true,
dirName	  	 = current_mod_path,

displayName	 = _("A-10C II Tank Killer"),
shortName	 = "A-10C II",
fileMenuName = _("A-10C II"),
update_id    = "A-10C_2",
version		 = __DCS_VERSION__,		 
state		 = "installed",
info		 = _('DCS: A-10C II Tank Killer is a PC simulation of the U.S. premier Close Air Support attack aircraft. Tank Killer brings the most realistic PC simulation of the A-10C regarding flight dynamics, avionics, sensors, and weapon systems. You also have the option to play Tank Killer in "Game" mode for a casual game experience. Fly missions against and with a wide array of air, land, and sea forces. Create your own missions and campaigns with the included Mission and Campaign Editors and fly with and against friends online using the included online game browser.'),
binaries 	 =
{
'A10',
"Cockpit_A10Common",
"Cockpit_A10C",
"Cockpit_A10C_2",
},

InputProfiles =
{
    ["A-10C II"]      = current_mod_path .. '/Input/A-10C_2',
},

Skins	= 
	{
		{
			name	= _("A-10C II"),
			dir		= "Skins/1"
		},
	},
	
Missions =
	{
		{
			name		= _("A-10C II"),
			dir			= "Missions",	
		},
	},	

Options =
    {
        {
            name		= _("A-10C II"),
            nameId		= "A-10C_2",
            dir			= "Options",
            CLSID		= "{A-10C II options}"
        },
    },
LogBook =
	{
		{
			name		= _("A-10C II"),
			type		= "A-10C_2",
		},
	},	
})

mount_vfs_liveries_path(current_mod_path .. "/Liveries")
mount_vfs_texture_path(current_mod_path ..  "/Skins/1/ME")--for simulator loading window

dofile(current_mod_path.."/Views.lua")
make_view_settings('A-10C_2'  , ViewSettings, SnapViews)

----------------------------------------------------------------------------------------
make_flyable('A-10C_2',current_mod_path..'/Cockpit/Scripts/',{self_ID,'A10'},current_mod_path..'/comm.lua')--make_flyable(obj_name,optional_cockpit path,optional_fm = {mod_of_fm_origin,dll_with_fm})
----------------------------------------------------------------------------------------
plugin_done()