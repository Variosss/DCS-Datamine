local DialogLoader		= require('DialogLoader')
local Factory			= require('Factory')
local ListBoxItem		= require('ListBoxItem')
local TabViewBase		= require('Options.TabViewBase')
local i18n				= require('i18n')
local MultiTabGroup		= require('Options.MultiTabGroup')
local DbOption			= require('Options.DbOption')
local PluginsInfo		= require('Options.PluginsInfo')

local function loadPluginContainer(self, pluginInfo)
	local resourceFilename = pluginInfo.optionsFolder .. '/' .. 'options.dlg'
	local dataFilename = pluginInfo.optionsFolder .. '/' .. 'optionsData.lua'
	local localization
	
	local func, err = loadfile(dataFilename)
	
	if func then
		local env = {_ = i18n.ptranslate}
		
		setfenv(func, env)
		local ok, res = pcall(func)
		if not ok then
			log.error('ERROR: loadPluginContainer() failed to pcall "'..dataFilename..'": '..res)
		else
			localization = env.cdata
		end
	else
		print(err)
	end
	
	local window = DialogLoader.spawnDialogFromFile(resourceFilename, localization)
	local container = window.containerPlugin
	
	window:removeWidget(container)
	window:kill()
	
	return container
end

local function getPluginFunctions(self, pluginId)
	local controller = self.controller_
	
	local getFunc = function(name)
		return controller.getPlugin(pluginId, name)
	end
	
	local setFunc = function(name, value)
		controller.setPlugin(pluginId, name, value)
	end
	
	local getDbValuesFunc = function(name)
		return controller.getPluginValues(pluginId, name)
	end
	
	local getRelationsFunc = function(name)
		return controller.getPluginRelationsFunc(pluginId, name)
	end

	return getFunc, setFunc, getDbValuesFunc, getRelationsFunc
end

local function onShowTab(self, item)
    if self.pPluginContainer then
        self.pPluginContainer:removeAllWidgets()
    end
    
	local tmpPluginDb
	
	if not item.container then
		local container = loadPluginContainer(self, item.pluginInfo)
		
		container:setBounds(self.pPluginContainer.staticDialogPlaceholder:getBounds())

		local pluginId = item.pluginInfo.id
		local getPlugin, setPlugin, getPluginDbValues, relationsFunc = getPluginFunctions(self, pluginId)		
		
		tmpPluginDb = self.controller_.getPluginDb(pluginId)
		if tmpPluginDb then
			self:bindContainer(container, tmpPluginDb, getPlugin, setPlugin, getPluginDbValues, true, relationsFunc)

			if container.buttonTest then
				if ED_PUBLIC_AVAILABLE then
					container.buttonTest:setVisible(false)
				end
				container.buttonTest.onChange = function ()
					local AirSettings = require('me_AirAdjustments')
					for k, v in pairs(_G.aircraftsFlyableByPluginId[item.pluginInfo.id]) do
						AirSettings.show(true, v, item.pluginInfo)
						break
					end
				end
			end
		end
		item.container = container
	end
    
    self.pPluginContainer:insertWidget(item.container)
	
	self:updateWidgets()
	
	item.container:setVisible(true)
	
	if tmpPluginDb and tmpPluginDb.callbackOnShowDialog then
		tmpPluginDb.callbackOnShowDialog(item.container)
	end	
end

local function onChange_listModuls(self, item)
	onShowTab(self.parent,item)
end

local function loadFromResource(self)	
	local window = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_options_plugins.dlg')
	local container = window.containerMain.containerPlugins
    self.listModuls = container.listModuls
    self.listModuls.parent = self
    self.listModuls.onChange = onChange_listModuls
    self.listBoxDriveItemSkin = container.listBoxModulItem:getSkin()
    self.pPluginContainer = container.pPluginContainer
	
	window.containerMain:removeWidget(container)
	window:kill()
	
	return container
end

local function onHideTab(self, item)
	if item.container then
		item.container:setVisible(false)
	end
end

local function bindControls(self, a_style, a_w, a_h)
	if self.listModuls == nil then
		return
	end
	self.listModuls:setSize(252, a_h)
	self.listModuls:clear()
	
	local setIcon = function (listItem,icon) 
		local SkinItem = listItem:getSkin()
		local filename = icon
		if not filename or lfs.attributes(filename)	== nil then
			filename = 'dxgui\\skins\\skinME\\images\\default-38x38.png'
		end
		SkinItem.skinData.states.released[1].picture.file 	= filename
		SkinItem.skinData.states.released[2].picture.file 	= filename
		SkinItem.skinData.states.hover[1].picture.file 		= filename
		SkinItem.skinData.states.hover[2].picture.file 		= filename
		listItem:setSkin(SkinItem)
	end

	local bEnable = false
	for i, pluginInfo in ipairs(PluginsInfo.getOptionsInfo()) do
		if a_style ~= "sim" or pluginInfo.allow_in_simulation == true then
			local listItem = ListBoxItem.new(_(pluginInfo.name))            
			listItem.pluginInfo = pluginInfo
			listItem:setSkin(self.listBoxDriveItemSkin)
			if pluginInfo.skinFolder then
				setIcon(listItem,pluginInfo.skinFolder..'\\icon-38x38.png')
			else 
				setIcon(listItem,pluginInfo.icon)	
			end
			self.listModuls:insertItem(listItem)
			bEnable = true
		end
	end
	
	return bEnable
end

local function updateOption(self, pluginId, name)
	local updateFunction = self.updateFunctions_[pluginId] and self.updateFunctions_[pluginId][name]
	
	if updateFunction then
		updateFunction()
	end
end

local function getCurrentPluginId(self)
    local item = self.listModuls:getSelectedItem()
	if item then
		return item.pluginInfo.id
	end
end

local function setUpdateFunction(self, optionName, func)
	local pluginId = getCurrentPluginId(self)
	
	self.updateFunctions_[pluginId] = self.updateFunctions_[pluginId] or {}
	self.updateFunctions_[pluginId][optionName] = func
end

local function getUpdateFunction(self, optionName)
	local pluginId = getCurrentPluginId(self)
	
	return self.updateFunctions_[pluginId][optionName]
end

local function getUpdateFunctions(self)
	local pluginId = getCurrentPluginId(self)
	
	return self.updateFunctions_[pluginId]
end

local function show(self)
	local pluginId = getCurrentPluginId(self)
	
	if not pluginId then
		local tabCount = self.listModuls:getItemCount()--   self.multiTabGroup_:getTabCount()
		
		if tabCount > 0 then
			local item = self.listModuls:getItem(0)  ---self.multiTabGroup_:getTab(0)
			
            self.listModuls:selectItem(item)
			onShowTab(self, item)
		end
	end
	
	TabViewBase.show(self)
end

return Factory.createClass({
	construct			= construct,
	bindControls		= bindControls,
	loadFromResource	= loadFromResource,
	updateOption		= updateOption,
	setUpdateFunction	= setUpdateFunction,
	getUpdateFunction	= getUpdateFunction,
	getUpdateFunctions	= getUpdateFunctions,
	show 				= show,
}, TabViewBase)
