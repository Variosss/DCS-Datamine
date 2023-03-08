

local self_ID = "F-14B by Heatblur Simulations"

declare_plugin(self_ID,
{

installed 	 = true,
dirName	 	 = current_mod_path,
displayName  = _("F-14"),
shortName    = "F-14",
fileMenuName = _("F-14"),
update_id    = "HEATBLUR_F-14",
version		 = tostring(__DCS_VERSION__) .. "EA",
state		 = "installed",
info		 = _("The Legendary F-14 Tomcat is a variable-wing multi-role fleet defender with unmatched air to air capability. Incorporating a pilot and RIO 2-man crew, the Tomcat leverages its powerful AWG-9 radar to reach out and destroy enemy aircraft at unmatched distances, using weaponry such as the AIM-54A/C Phoenix, AIM-7 Sparrow and AIM-9 missiles. Through the LANTIRN upgrade programme, the F-14 became an effective strike aircraft, affectionally dubbed the 'Bombcat', the F-14 can employ a large assortment of unguided and guided weaponry while maintaining excellent range and air to air capability."),

binaries 	 =
{
'F14-HeatblurCommon',
'F14-FlightModel',
'F14-Avionics'
},

InputProfiles =
	{
--		["F-14B"] 		= current_mod_path .. '/Input/F-14B/',
		["F-14"] = current_mod_path .. '/Input/F-14B-Pilot',
		["F-14_RIO"]   = current_mod_path .. '/Input/F-14B-RIO',
	},

Skins	=
	{
		{
			name	= "F-14B",
			dir		= "Skins"
		},
	},
Missions =
	{
		{
			name		= _("F-14B"),
			dir			= "Missions",
		},
	},
LogBook =
	{
		{
			name		= _("F-14B"),
			type		= "F-14B",
		},
		--{
		--	name		= _("F-14A IRIAF"),
		--	type		= "F-14A-95-GR",
		--},
		{
			name		= _("F-14A"),
			type		= "F-14A-135-GR",
		},
	},

Options =
	{
		{
			name		= _("F-14"),
			nameId		= "F-14",
			dir			= "Options",
			CLSID		= "{F-14 Options}",
		},
	},

preload_resources = {
	textures = {},
	models = {},
	fonts = {},
	explosions = {},
	},


})

mount_vfs_sound_path(current_mod_path.."/Sounds")
mount_vfs_texture_path(current_mod_path.."/Skins/ME")
mount_vfs_model_path(current_mod_path.."/Shapes")

mount_vfs_texture_path(current_mod_path.."/Textures")

--
--mount_vfs_texture_path(current_mod_path.."/CockpitTextures")
mount_vfs_texture_path(current_mod_path.."/Textures/Color")
mount_vfs_texture_path(current_mod_path.."/Textures/Color/A")
mount_vfs_texture_path(current_mod_path.."/Textures/Color/RoughMet")
mount_vfs_texture_path(current_mod_path.."/Textures/Color/Nrm")
mount_vfs_texture_path(current_mod_path.."/Textures/Color/Dynamic")
mount_vfs_texture_path(current_mod_path.."/Textures/Color/RIO")
mount_vfs_texture_path(current_mod_path.."/Textures/Pilot")
mount_vfs_texture_path(current_mod_path.."/Textures/RIO/DiffuseRM")
mount_vfs_texture_path(current_mod_path.."/Textures/RIO/Nrm")

mount_vfs_texture_path(current_mod_path.."/Textures/ChromeCatLegacy") --Legacy to be removed

mount_vfs_texture_path(current_mod_path.."/Cockpit/Resources/IndicationTextures")
mount_vfs_liveries_path(current_mod_path.."/Liveries") 


local cfg_path = current_mod_path ..  "/Entry/ConfigA.lua"
dofile(cfg_path)
FM[1] 				= self_ID
FM[2] 				= 'F14-FlightModel'
FM.config_path 		= cfg_path
FM.Type				= 0

dofile(current_mod_path.."/Entry/Views.lua")
--make_view_settings('F-14A-95-GR', ViewSettings, SnapViews)
make_view_settings('F-14A-135-GR', ViewSettings, SnapViews)
make_view_settings('F-14B', ViewSettings, SnapViews)
--make_flyable('F-14A-95-GR',current_mod_path..'/Cockpit/',FM,current_mod_path..'/Entry/comm.lua')
make_flyable('F-14A-135-GR',current_mod_path..'/Cockpit/',FM,current_mod_path..'/Entry/comm.lua')

cfg_path = current_mod_path ..  "/Entry/ConfigB.lua"
dofile(cfg_path)
FM[1] 				= self_ID
FM[2] 				= 'F14-FlightModel'
FM.config_path 		= cfg_path
FM.Type				= 0

make_flyable('F-14B',current_mod_path..'/Cockpit/',FM,current_mod_path..'/Entry/comm.lua')

plugin_done()
