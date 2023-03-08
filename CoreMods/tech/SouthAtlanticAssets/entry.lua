local self_ID = 'South_Atlantic_Assets'
local pack_name = 'South Atlantic Assets'

--Version 6.9.9 See Changelog



declare_plugin(self_ID, {
	installed			= true, -- if false that will be place holder , or advertising
	state				= "installed",
	developerName		= _('Razbam Simulations'),
	version				= __DCS_VERSION__,		 
	binaries			= {'SouthAtlantic'},
	load_immediately	= true,
	
	encyclopedia_path	= current_mod_path..'Encyclopedia',
	dirName				= current_mod_path,
	shortName			= pack_name,
	fileMenuName		= _(pack_name),
	displayName			= _(pack_name),
	info				= _('South Atlantic Asset Pack compliments the South Atlantic map'),
	Skins				= {
							{
								name	= _("South Atlantic Asset"),
								dir		= "Theme/1"
							}
						},
})

--models

mount_vfs_model_path (current_mod_path .. '/Shapes/Weapons')

--textures

--liveries
--mount_vfs_liveries_path (current_mod_path .."/Liveries")

--loadouts

--Entries
dofile(current_mod_path ..'/Entries/navy.lua')
dofile(current_mod_path ..'/Entries/statics.lua')
dofile(current_mod_path ..'/Entries/vehicles.lua')
dofile(current_mod_path ..'/Entries/Weapons.lua')
plugin_done()