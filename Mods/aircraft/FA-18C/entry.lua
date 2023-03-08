local self_ID = "F/A-18C"
declare_plugin(self_ID,
{
dirName			= current_mod_path,
displayName		= _("F/A-18C"),
shortName		= "F/A-18C",
fileMenuName	= _("F/A-18C"),
update_id		= "FA-18C",
version 		= "EA",
state			= "installed",
developerName	= _("Eagle Dynamics/Belsimtek"),
info			= _("The Hornet is a true multi-role fighter that can switch from attacking surface targets to engaging air targets with the press of a button. Equally at home on an aircraft carrier or airfield, the Hornet is equipped with a large suite of sensors that include radar, target pod, and a helmet mounted sight. In addition to its internal 20mm cannon, the Hornet can be armed with large assortment of unguided bombs and rockets, laser- and -GPS-guided bombs, air-to-surface missiles of all sorts, and both radar- and infrared-guided air-to-air missiles."),

binaries =
{
	'FA18C', --MUST be protected by ED_Crypt.
},

Skins =
{
	{
		name	= "F/A-18C",
		dir		= "Skins/1"
	},
},
Missions =
{
	{
		name	= _("F/A-18C"),
		dir		= "Missions",
		CLSID	= "{F/A-18C missions}",
	},
},
LogBook =
{
	{
		name	= _("F/A-18C"),
		type	= "FA-18C_hornet",
	},
},
Options =
{
	{
		name		= _("F/A-18C"),
		nameId		= "F/A-18C",
		dir			= "Options",
		CLSID		= "{F/A-18C options}",
		AircraftSettingsFile = 'AircraftSettings.lua'
	},
},
InputProfiles = 
{
	["FA-18C_hornet"]		= current_mod_path .. '/Input/FA-18C/',
},

})

-------------------------------------------------------------------------------
mount_vfs_texture_path  (current_mod_path ..  "/Cockpit/Textures/FA-18C-CPT-TEXTURES")
mount_vfs_model_path    (current_mod_path ..  "/Cockpit/Shape")
mount_vfs_liveries_path (current_mod_path ..  "/Liveries")
mount_vfs_texture_path	(current_mod_path ..  "/Skins/1/ME")--for simulator loading window

local cfg_path = current_mod_path ..  "/FM/config.lua"
dofile(cfg_path)
FA18C[1]				= self_ID
FA18C[2]				= 'FA18C'
FA18C.config_path 		= cfg_path
FA18C.user_options 		= 'FA-18C_hornet'

dofile(current_mod_path.."/Views.lua")
make_view_settings('FA-18C_hornet', ViewSettings, SnapViews)

make_flyable('FA-18C_hornet', current_mod_path..'/Cockpit/Scripts/',FA18C, current_mod_path..'/comm.lua')
plugin_done()-- finish declaration , clear temporal data
