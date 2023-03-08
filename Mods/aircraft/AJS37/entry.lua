
local self_ID = "AJS37 Viggen by Heatblur Simulations"


declare_plugin(self_ID,
{
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
version		 = __DCS_VERSION__,		 
state		 = "installed",
info		 = _("The AJS37 Viggen is a Swedish double-delta supersonic attack aircraft from the late Cold War. It was the backbone of the Swedish Air Force during the Cold war, serving as the main attack and anti-ship platform. The AJS is the 90’s upgrade of this 70’s era aircraft, adding several advanced weapons and systems functionalities. The aircraft was designed around the pilot, with an excellent man-machine interface, supporting the pilot through the smart use of autopilot systems and HUD symbology in order to deliver the ordnance onto targets from treetop level with high speed attack runs."),


displayName = _("AJS37"),
shortName	 =   "AJS37",
fileMenuName = _("AJS37"),
update_id        = "AJS37",
registryPath = "HeatblurSimulations\\DCS: AJS-37",
DRM_controller = "bin/pcnsl.exe",
developerName	= _("Heatblur Simulations"), 
--


binaries	= { 'AJS37', 'AJS37-Avionics',}, 

Skins	= 
	{
		{
			name	= "AJS37", 
			dir		= "Theme"
		},
	},
Missions =
	{
		{
			name		= _("AJS37"),
			dir			= "Missions",
		},
	},	
LogBook =
	{
		{
			name		= _("AJS37"),
			type		= "AJS37",
		},
	},	
InputProfiles =
	{
		["AJS37"]     = current_mod_path .. '/Input',
	},
Options =
    {
        {
            name		= _("AJS37"),
            nameId		= "AJS37",
            dir			= "Options",
			CLSID		= "{AJS37 Options}"			
        },
    },
})


---------------------------------------------------------------------------------------

mount_vfs_sound_path(current_mod_path.."/Sounds")
mount_vfs_texture_path(current_mod_path.."/Theme")
mount_vfs_model_path(current_mod_path.."/Shapes")
mount_vfs_texture_path(current_mod_path.."/Textures")
mount_vfs_liveries_path(current_mod_path.."/Liveries") --DON'T change this please. It is necessary for English Cockpit and Mirrors.
mount_vfs_texture_path(current_mod_path ..  "/Theme/ME")--for simulator loading window
dofile(current_mod_path..'/Entry/Suspension.lua')
dofile(current_mod_path.."/Entry/Views.lua")

make_view_settings('AJS37', ViewSettings, SnapViews)


local FM = 
{
	[1] = self_ID,
	[2] = "AJS37",
	center_of_mass		=	{ 0.0 , 0.0 , 0.0},		-- center of mass position relative to object 3d model center for empty aircraft
	moment_of_inertia  	=  {14609,95834,96800}, -- <- Update 2016-03-05	old: {14609,95834,96800}, -- <- Update 2016-02-09 {14609,95834,144816},-- <- Update 2015-03-02, old: {14609,95834,96800}, -- <- Update 2015-01-03, old: {14609,48000,96800},--(??, yaw?, pitch?){141614, 9410720.1, 802403.6},--{128740.0, 855520.1, 756730.6}, -- F-15C : {38912  ,254758,223845,-705},--Ix,Iy,Iz,Ixy
	suspension   = suspension, -- gear posts initialization
}
make_flyable('AJS37',current_mod_path..'/Cockpit/scripts/',FM,current_mod_path..'/Comm/comm.lua')


plugin_done()
