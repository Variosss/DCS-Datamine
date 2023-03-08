log.set_output('animator-log', 'ANIMATOR', log.ALL, log.MESSAGE)

--autoexecute sample for model viewer
--mount_vfs_liveries_path("Mods/aircrafts/Wunderluft/Liveries")
--mount_vfs_texture_path("Mods/aircrafts/Wunderluft/Textures/base_zip_package")

--LoadModel("Bazar/World/Shapes/A-10.edm")
--LoadLivery("A-10C","184th FS Arkansas ANG, Fort Smith (FS)")
--SetArgument(0,1)
--SetArgument(3,1)
--SetArgument(5,0.75)

animator = 
{
	statistics_enabled = true;
}

local lfs = require("lfs")
local function service_file(file)
	return file == "." or
		   file == ".." or 
		   file == ".svn" or 
		   file == "_svn" 
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
print("scan for environment cubes")
print("----------------------------------------------------------------")
scan_for_environment_cubes("Bazar/EffectViewer/envcubes")
print("scan done")
print("----------------------------------------------------------------")
print("mount extra stuff")
print("----------------------------------------------------------------")
mount_vfs_liveries_path     ("CoreMods/tech/USS_Nimitz/animations/liveries")
mount_vfs_animations_path   ("CoreMods/tech/USS_Nimitz/animations/animations")
mount_vfs_models_path       ("CoreMods/tech/USS_Nimitz/animations/models")
mount_vfs_textures_path     ("CoreMods/tech/USS_Nimitz/animations/textures")

mount_vfs_liveries_path     ("CoreMods/tech/Animals/Liveries")
mount_vfs_models_path       ("CoreMods/tech/Animals/models")
mount_vfs_textures_path	    ("CoreMods/tech/Animals/Textures")
mount_vfs_animations_path   ("CoreMods/tech/Animals/animations")

mount_vfs_models_path       ("CoreMods/characters/models")
mount_vfs_textures_path	    ("CoreMods/characters/textures")
mount_vfs_animations_path   ("CoreMods/characters/animations")
mount_vfs_animations_path   ("Mods/tech/WIP/Animations")
mount_vfs_models_path       ("Mods/tech/WIP/Shapes")


--here is textures for  Bazar/World/Shapes/air_closedguardhouse_03a.edm
mount_vfs_textures_path("Mods/terrains/Caucasus/Models/Communication/Communication.texture.zip") 


print("done")
print("----------------------------------------------------------------")

--local f = LoadStaticCharacterModel; 
--local file_name = "carrier_technician.chanimgpu";
--local file_name = "carrier_shooter.chanimgpu";
--local file_name = "carrier_tech_USA.chanimgpu";
--f(file_name);

--[[
LoadModel("d:\\Projects\\trunk\\LockOnExe\\Bazar\\World\\Shapes\\farp.edm");
Move(0, -1.22, 0);
local d = 10;
local f = LoadLodModel; local file_name = "tech.lds";
--local f = LoadStaticCharacterModel; local file_name = "tech_animation.chanimgpu";
--local f = LoadCharacterModel;
if f ~= nil then
    for i = -d,d do
        for j = -d,d do
            --f("d:\\Projects\\trunk\\LockOnExe\\Data\\tech_animation.lua")
            --f("d:\\Projects\\trunk\\LockOnExe\\Data\\tech_animation.chanimgpu")
            --f("tech_animation.chanimgpu")
            f(file_name);
            Move(i, 0, j);
        end;
    end;
end;
--]]


--LoadModel("d:\\Projects\\trunk\\LockOnExe\\Bazar\\World\\Shapes\\farp.edm");
--Move(0, -1.22, 0);
--AddModel("carrier_shooter.chanimgpu")

--LoadCarrierModel('c:\\Work\\Trunk\\LockOnExe\\CoreMods\\tech\\USS_Nimitz\\Shapes\\Nimitz_CVN_71.lods');
--LoadCarrierCrew('c:\\Work\\Trunk\\LockOnExe\\CoreMods\\tech\\USS_Nimitz\\scripts\\crew.lua');

    
