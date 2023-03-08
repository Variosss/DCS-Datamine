local Data			= require('Input.Data')
local Input 		= require('Input')

local uiProfileName_

local function loadProfileName_(folder, unitName)
	local result
	local default
	local f, err = loadfile(folder .. '/name.lua')

	if f then
		result, default = f(unitName)
	end

	if not result then
		result = unitName
	end

	return result, default
end

local function ProfileInfo(folderPath, unitName)
	local name, default = loadProfileName_(folderPath, unitName)
	
	return {
		folder 					= folderPath,
		unitName				= unitName,
		name					= name,
		default					= default,	-- если в настройках не сохранен последний выбранный самолет, то при загрузке окна настроек свыбрать этот профайл
		visible					= true,		-- отображать профайл в настройках	
		loadDefaultUnitProfile	= true,		-- профили НЕ юнитов не должны пытаться загрузить профили устройств из папки дефолтного юнита
		
		LayerName = function(self, layerName)
			self.layerName = layerName
			
			return self
		end,
		
		Visible = function(self, visible)
			self.visible = visible
			
			return self
		end,
		
		LoadDefaultUnitProfile = function(self, loadDefaultUnitProfile)
			self.loadDefaultUnitProfile = loadDefaultUnitProfile
			
			return self
		end,
	}
end

local function createDefaultAircraftProfileInfo(systemConfigPath)
	local unitName = 'Default'
	local folderPath = systemConfigPath .. 'Aircrafts/' .. unitName
	
	return ProfileInfo(folderPath, unitName):LayerName(Data.getUnitMarker() .. unitName):Visible(true):LoadDefaultUnitProfile(true)
end

local function createUnitProfileInfo(unitName, folderPath)
	return ProfileInfo(folderPath, unitName):LayerName(Data.getUnitMarker() .. unitName):Visible(true):LoadDefaultUnitProfile(true)
end

local function createPluginProfileInfos(pluginPaths, profileInfos)
	for unitName, folderPath in pairs(pluginPaths) do
		table.insert(profileInfos, createUnitProfileInfo(unitName, folderPath))
	end
end

local function createExplorationsProfileInfo(systemConfigPath)
	local unitName = 'Explorations'
	local folderPath = systemConfigPath .. unitName
	
	return ProfileInfo(folderPath, unitName):LayerName('ExplorationsLayer'):Visible(false):LoadDefaultUnitProfile(false)
end

local function createJftBinocularProfileInfo(systemConfigPath)
	local unitName = 'JFT binocular'
	local folderPath = systemConfigPath .. 'JFT/binocular'
	
	return ProfileInfo(folderPath, unitName):LayerName('JFT_when_binocular_view_set'):Visible(__PRODUCT_ID__ == 2):LoadDefaultUnitProfile(false)
end

local function createJftCameraProfileInfo(systemConfigPath)
	local unitName = 'JFT camera'
	local folderPath = systemConfigPath .. 'JFT/camera'
	
	return ProfileInfo(folderPath, unitName):LayerName('JFT_when_camera_set'):Visible(__PRODUCT_ID__ == 2):LoadDefaultUnitProfile(false)
end

local function createJftGlobalProfileInfo(systemConfigPath)
	local unitName = 'JFT global'
	local folderPath = systemConfigPath .. 'JFT/global'
	
	return ProfileInfo(folderPath, unitName):LayerName('JFT_global'):Visible(__PRODUCT_ID__ == 2):LoadDefaultUnitProfile(false)
end

local function createCommandMenuProfileInfo(systemConfigPath)
	local unitName = 'CommandMenu'
	local folderPath = systemConfigPath .. unitName
	
	return ProfileInfo(folderPath, unitName):LayerName('CommandMenuItems'):Visible(false):LoadDefaultUnitProfile(false)
end

local function createTrainingWaitForUserProfileInfo(systemConfigPath)
	local unitName = 'TrainingWaitForUser'
	local folderPath = systemConfigPath .. unitName
	
	return ProfileInfo(folderPath, unitName):LayerName('TrainingWaitForUser'):Visible(false):LoadDefaultUnitProfile(false)
end

local function createUiLayerProfileInfo(systemConfigPath)
	local unitName = 'UiLayer'
	local folderPath = systemConfigPath .. unitName
	local profileInfo = ProfileInfo(folderPath, unitName):LayerName(Input.getUiLayerName()):Visible(true):LoadDefaultUnitProfile(false)
	
	uiProfileName_ = profileInfo.name
	
	return profileInfo
end

local function createCameraFreeProfileInfo(systemConfigPath)
	local unitName = 'CameraFree'
	local folderPath = systemConfigPath .. unitName
	
	return ProfileInfo(folderPath, unitName):LayerName(unitName):Visible(true):LoadDefaultUnitProfile(false)
end

local function createCameraObjectProfileInfo(systemConfigPath)
	local unitName = 'CameraObject'
	local folderPath = systemConfigPath .. unitName
	
	return ProfileInfo(folderPath, unitName):LayerName(unitName):Visible(true):LoadDefaultUnitProfile(false)
end

local function createCameraRoomProfileInfo(systemConfigPath)
	local unitName = 'CameraRoom'
	local folderPath = systemConfigPath .. unitName
	
	return ProfileInfo(folderPath, unitName):LayerName(unitName):Visible(true):LoadDefaultUnitProfile(false)
end

local function createRadioVoIPProfileInfo(systemConfigPath)
	local unitName = 'RadioVoIP'
	local folderPath = systemConfigPath .. unitName
	
	return ProfileInfo(folderPath, unitName):LayerName(unitName):Visible(true):LoadDefaultUnitProfile(false)
end

local function getUiProfileName()
	return uiProfileName_
end
	
local function createDefaultProfilesSet(sysConfigPath,additionalPaths)
	local res = 
	{
		createDefaultAircraftProfileInfo		(sysConfigPath),
		createUiLayerProfileInfo				(sysConfigPath),
		createCameraFreeProfileInfo				(sysConfigPath),
		createCameraObjectProfileInfo			(sysConfigPath),
		createCameraRoomProfileInfo				(sysConfigPath),
		createRadioVoIPProfileInfo				(sysConfigPath),
		createJftBinocularProfileInfo			(sysConfigPath),
		createJftCameraProfileInfo				(sysConfigPath),
		createJftGlobalProfileInfo				(sysConfigPath),
		createExplorationsProfileInfo			(sysConfigPath),
		createCommandMenuProfileInfo			(sysConfigPath),
		createTrainingWaitForUserProfileInfo	(sysConfigPath),
	}
	
	if additionalPaths then
		createPluginProfileInfos(additionalPaths, res)
	end
	
	return res
end

return {
	createUnitProfileInfo					= createUnitProfileInfo,
	createUiLayerProfileInfo				= createUiLayerProfileInfo,
	getUiProfileName						= getUiProfileName,
	createDefaultProfilesSet				= createDefaultProfilesSet,
}