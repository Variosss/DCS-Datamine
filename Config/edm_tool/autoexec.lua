local lfs = require("lfs")
local function service_file(file)
	return file == "." or
		   file == ".." or 
		   file == ".svn" or 
		   file == "_svn" 
end

function scan_for_textures(path)
	local lower_case      = path:lower()
	if lower_case:find("liveries") then
	   mount_vfs_liveries_path(path)
	   return
	end
	if lower_case:find("terrains") then
	   return
    end
	local is_texture_path  = lower_case:find("texture") ~= nil
	local mounted_already  = false 
	for file in lfs.dir(path) do
		if not service_file(file) then
		   local fn 	  = path.."/"..file
		   local attrMode 	  = lfs.attributes (fn, "mode")     
		   if attrMode == "directory" then
			  scan_for_textures(fn)
		   elseif is_texture_path then
			  local ext = string.sub(file,-4)
			  if '.zip' == ext then
					mount_vfs_texture_path(fn)
			  elseif not mounted_already and (
				 '.dds' == ext or
			     '.bmp' == ext or
				 '.jpg' == ext or
				 '.png' == ext or
				 '.tga' == ext) then
					mount_vfs_texture_path(path)
					mounted_already = true
			  end
		   end
		end
	end
end

function scan_for_environment_cubes(path)
	local lower_case = path:lower()	
	for file in lfs.dir(path) do
		if not service_file(file) then
			local fn = path.."/"..file
			local attrMode = lfs.attributes(fn, "mode")
			if attrMode == "file" then
				local ext = string.sub(file,-4) 
				if '.dds' == ext then
					AddEnvironmentMap(file)
				end
			end
		end
	end
end

print("----------------------------------------------------------------")
print("scan for textures and liveries")
scan_for_textures("CoreMods")
print("----------------------------------------------------------------")
scan_for_textures("Mods")
scan_for_environment_cubes("Bazar/EffectViewer/envcubes")
print("scan done")
print("----------------------------------------------------------------")

mount_vfs_liveries_path     ("CoreMods/tech/USS_Nimitz/animations/liveries")
mount_vfs_animations_path   ("CoreMods/tech/USS_Nimitz/animations/animations")
mount_vfs_models_path       ("CoreMods/tech/USS_Nimitz/animations/models")
mount_vfs_textures_path     ("CoreMods/tech/USS_Nimitz/animations/textures")
