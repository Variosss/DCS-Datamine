local self_ID = "F-14B AI by Heatblur Simulations"

declare_plugin(self_ID,
{
installed 	 = true,
dirName	 	 = current_mod_path,
version		 = __DCS_VERSION__,
state		 = "installed",
info		 = _("F-14B AI"),
encyclopedia_path = current_mod_path..'/Encyclopedia',
binaries     =
{
  'F14-AI',
},
load_immediately = true,
})

mount_vfs_model_path(current_mod_path.."/Shapes")
mount_vfs_model_path(current_mod_path.."/Shapes/Forrestal")

mount_vfs_liveries_path(current_mod_path.."/Liveries")
mount_vfs_liveries_path(current_mod_path.."/../F14_liveries/Liveries")

mount_vfs_texture_path	(current_mod_path ..  "/Textures")
mount_vfs_texture_path(current_mod_path.."/Textures/LNS_F14_Exterior")
mount_vfs_texture_path(current_mod_path.."/Textures/Diffuse_RoughMet")
mount_vfs_texture_path(current_mod_path.."/Textures/Lights")
mount_vfs_texture_path(current_mod_path.."/Textures/Normals")
mount_vfs_texture_path(current_mod_path.."/Textures/Ordinance")
mount_vfs_texture_path(current_mod_path.."/Textures/Forrestal")
mount_vfs_texture_path(current_mod_path.."/Textures/LOD")
mount_vfs_texture_path(current_mod_path.."/Textures/A")
--[[
mount_vfs_texture_path(current_mod_path.."/Textures/F-14B_Base")
mount_vfs_texture_path(current_mod_path.."/Textures/F-14B_Pilot")
mount_vfs_texture_path(current_mod_path.."/Textures/F-14B_TacNumbers")
mount_vfs_texture_path(current_mod_path.."/Textures/F-14B_Weapons")
]]


---------------------------------------------------------

dofile(current_mod_path.."/Entry/F-14B.lua")
dofile(current_mod_path.."/Entry/F-14A.lua")
dofile(current_mod_path.."/Entry/Weapons.lua")
dofile(current_mod_path.."/Entry/CV-59-Equipment.lua")

---------------------------------------------------------

---------------------------------------------------------
-- CV-59 USS Forrestal
---------------------------------------------------------
local function ship_file(f)
	if dofile(f) then
		error("can't load file "..f)
		return
	end
	if(GT) then
		GT.shape_table_data = 
		{
			{
				file  	    = GT.visual.shape;
				username    = GT.Name;
				desrt       = GT.visual.shape_dstr;
			    classname 	= "lLandShip";
				positioning = "BYNORMAL";
			},
			{
				name  = GT.visual.shape_dstr;
				file  = GT.visual.shape_dstr;
			},
		}
		add_surface_unit(GT)
		GT = nil;
	else
		error("GT empty in file "..f)
	end;
end

ship_file(current_mod_path.."/Entry/CV-59-Forrestal.lua")
---------------------------------------------------------

plugin_done()
