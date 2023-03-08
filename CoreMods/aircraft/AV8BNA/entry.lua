local self_ID  = "AV-8B N/A AI by RAZBAM Sims"
declare_plugin(self_ID,
{
	installed	= true,
	dirName		= current_mod_path,
	version		= __DCS_VERSION__, 
	state		= "installed",
	info		= _("The AV-8B Harrier II Night Attack is a single-engine ground-attack aircraft that constitutes the second generation of the Harrier Jump Jet family. Capable of vertical or short takeoff and landing (V/STOL), the aircraft was designed in the late 1970s as an Anglo-American development of the British Hawker Siddeley Harrier, the first operational V/STOL aircraft. Named after a bird of prey, it is primarily employed on light attack or multi-role missions, ranging from close air support of ground troops to armed reconnaissance."),
	encyclopedia_path = current_mod_path..'/Encyclopedia',
	binaries	=
	{
		'AV8B_AI',
	},
})
---------------------------------------------------------------------------------------
mount_vfs_model_path   (current_mod_path.."/Shapes")
mount_vfs_model_path   (current_mod_path.."/Shapes/KC130")
mount_vfs_model_path   (current_mod_path.."/Shapes/KC135MPRS")
mount_vfs_model_path   (current_mod_path.."/Shapes/LHA_Tarawa")
mount_vfs_model_path   (current_mod_path.."/Shapes")
mount_vfs_liveries_path(current_mod_path.."/Liveries")
mount_vfs_texture_path (current_mod_path.."/Textures/AV8BNA")
mount_vfs_texture_path (current_mod_path.."/Textures/KC130")
mount_vfs_texture_path (current_mod_path.."/Textures/KC135MPRS")
mount_vfs_texture_path (current_mod_path.."/Textures/LHA_Tarawa")
---------------------------------------------------------------------------------------
dofile(current_mod_path.."/AV8BNA.lua")
dofile(current_mod_path.."/KC130.lua")
dofile(current_mod_path.."/KC135MPRS.lua")
dofile(current_mod_path.."/LHA_Tarawa.lua")
---------------------------------------------------------------------------------------
plugin_done()-- finish declaration , clear temporal data
