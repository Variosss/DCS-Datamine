local self_ID = "F-16C bl.50"
declare_plugin(self_ID,
{
dirName			= current_mod_path,
displayName		= _("F-16C bl.50"),
shortName		= "F-16C",
fileMenuName	= _("F-16C bl.50"),
update_id		= "F-16C",
version 		= "EA",
state			= "installed",
developerName	= _("Eagle Dynamics"),
info			= _("The F-16C Viper is a single-engine, supersonic, multi-role fighter that is flown by the United States and many other countries. Over 4,600 Vipers have been built, making it one of the most successful fighter aircraft in history. The Viper is equally capable at downing aircraft as it is attacking ground targets. It is equipped with a large suite of sensors that include radar, target pod, and a helmet mounted sight; and its’ weapons include an internal 20mm cannon, unguided bombs and rockets, laser- and GPS-guided bombs, air-to-surface missiles of all sorts, and both radar- and infrared-guided air-to-air missiles."),

binaries =
{
	'F16C',
},

Skins =
{
	{
		name	= "F-16C",
		dir		= "Skins/1"
	},
},
Missions =
{
	{
		name	= _("F-16C"),
		dir		= "Missions",
		CLSID	= "{F-16C missions}",
	},
},
LogBook =
{
	{
		name	= _("F-16C"),
		type	= "F-16C_50",
	},
},
Options =
{
	{
		name		= _("F-16C"),
		nameId		= "F-16C",
		dir			= "Options",
		CLSID		= "{F-16C options}"
	},
},
InputProfiles = 
{
	["F-16C_50"]		= current_mod_path .. '/Input/F-16C/',
},

})

-------------------------------------------------------------------------------
mount_vfs_texture_path  (current_mod_path ..  "/Cockpit/Textures/F-16C-CPT-TEXTURES")
mount_vfs_model_path    (current_mod_path ..  "/Cockpit/Shape")
mount_vfs_liveries_path (current_mod_path ..  "/Liveries")
mount_vfs_texture_path	(current_mod_path ..  "/Skins/1/ME")--for simulator loading window

local cfg_path = current_mod_path ..  "/FM/config.lua"
dofile(cfg_path)
F16C[1]				= self_ID
F16C[2]				= 'F16C'
F16C.config_path 	= cfg_path
F16C.user_options 	= 'F-16C_50'

dofile(current_mod_path.."/Views.lua")
make_view_settings('F-16C_50', ViewSettings, SnapViews)

make_flyable('F-16C_50', current_mod_path..'/Cockpit/Scripts/',F16C, current_mod_path..'/comm.lua')
plugin_done()-- finish declaration , clear temporal data
