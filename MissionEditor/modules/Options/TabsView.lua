local TabViewGraphics		= require('Options.TabViewGraphics')
local TabViewGameplay		= require('Options.TabViewGameplay')
local TabViewSound			= require('Options.TabViewSound')
local TabViewMiscellaneous	= require('Options.TabViewMiscellaneous')
local TabViewVR	            = require('Options.TabViewVR')
local TabViewPlugins		= require('Options.TabViewPlugins')
local TabViewControls		= require('Options.TabViewControls')
local i18n					= require('i18n')

local _ = i18n.ptranslate

local container_
local containerTabs_
local containerCentral_
local containerWide_
local tabGraphics_
local tabControls_
local tabGameplay_
local tabSound_
local tabMiscellaneous_
local tabVR_
local tabPlugins_
local optionsController_
local tabViews_ = {}
local style_
local fon_ 

local function setOptionsController(controller)
	optionsController_ = controller
end

local function bindTab(tab, TabViewClass)
	local tabView
	
	if not tabView then
		local w,h = containerCentral_:getSize()
		tabView = TabViewClass.new(optionsController_, w, h-34)
		local container = tabView:getContainer()
		
		local w,h = containerCentral_:getSize()
		container:setPosition(0, 34)
		container:setSize(w, h-34)
		containerCentral_:insertWidget(container)
		
		tabViews_[tab] = tabView
		tabView:hide()
	end
	
	function tab:onShow()
		tabView:setStyle(style_)
		tabView:updateLists()
		
        -- TMP
        if tabSound_ == tab then
            local container = tabViews_[tab]:getContainer()
			
            if style_ == 'sim' then
                container.GBreathEffectCheckbox	:setEnabled(false)
                container.radioSpeechCheckbox	:setEnabled(false)
                container.subtitlesCheckbox		:setEnabled(false)
				container.voice_chatCheckbox	:setEnabled(false)				
				container.microphone_useComboList	:setEnabled(false)
            else
                container.GBreathEffectCheckbox	:setEnabled(true)
                container.radioSpeechCheckbox	:setEnabled(true)
                container.subtitlesCheckbox		:setEnabled(true)
				container.voice_chatCheckbox	:setEnabled(true)				
				container.microphone_useComboList	:setEnabled(true)
            end
			tabViews_[tab]:updateDevices()
		elseif tabGraphics_ == tab then
			local container = tabViews_[tab]:getContainer()
			local sim_style =  style_ == 'sim'
			
			container.defaultFOVSlider:setVisible(not sim_style)
			container.defaultFOVWidget:setVisible(not sim_style)
			container.defaultFOVLabel:setVisible(not sim_style)
			container.defaultFOVSlider:setEnabled(not sim_style)
			container.defaultFOVWidget:setEnabled(not sim_style)
			container.defaultFOVLabel:setEnabled(not sim_style)
			
			container.currentFOVSlider:setVisible(sim_style)
			container.currentFOVWidget:setVisible(sim_style)
			container.currentFOVLabel:setVisible(sim_style)
			container.currentFOVSlider:setEnabled(sim_style)
			container.currentFOVWidget:setEnabled(sim_style)
			container.currentFOVLabel:setEnabled(sim_style)
			
			if sim_style then 
				function container.currentFOVSlider:onChange()
					local value = self:getValue()
					DCS.setCurrentFOV(value)
					local txt = string.format('%d\194\176', math.floor(value + 0.5)) -- utf-8 degree symbol
					container.currentFOVWidget:setText(txt)
				end
				local value = DCS.getCurrentFOV()
				container.currentFOVSlider:setValue(value)
				local txt = string.format('%d\194\176', math.floor(value + 0.5)) -- utf-8 degree symbol
				container.currentFOVWidget:setText(txt)
			end
        elseif tabVR_ == tab then
			local container = tabViews_[tab]:getContainer()
            local sim_style =  style_ == 'sim'
			
			container.enableCheckbox		:setVisible(not sim_style)
			container.pixel_densitySlider	:setVisible(not sim_style)
			container.pixel_densityWidget	:setVisible(not sim_style)
			container.pixel_density		 	:setVisible(not sim_style)
		end

		tabView:show()
	end
	
	function tab:onHide()
		tabView:hide()
	end
end

local function bindControlsTab(tab)
	function tab:onShow()
		local w, h 	= containerWide_:getSize()
		TabViewControls.show(w, h)
		
		local containerCtrl = TabViewControls.getContainer()

		if not containerWide_:getWidgetIndex(containerCtrl) then
			containerWide_:insertWidget(containerCtrl)
			containerCtrl.parentContainer = containerWide_
		end
		containerWide_:setVisible(true)
		fon_:setVisible(false)
	end
	
	function tab:onHide()
		TabViewControls.hide()
		containerWide_:setVisible(false)
		fon_:setVisible(true)
	end
end

local function bindTabs()
	tabGraphics_ = containerTabs_.tabSystem
	bindTab(tabGraphics_, TabViewGraphics)
	
	tabControls_ = containerTabs_.tabControls
	bindControlsTab(tabControls_)
	
	tabGameplay_ = containerTabs_.tabGameplay
	bindTab(tabGameplay_, TabViewGameplay)
	
	tabSound_ = containerTabs_.tabSound
	bindTab(tabSound_, TabViewSound)
	
	tabMiscellaneous_ = containerTabs_.tabMiscellaneous
	bindTab(tabMiscellaneous_, TabViewMiscellaneous)
    
    tabVR_ = containerTabs_.tabVR
	bindTab(tabVR_, TabViewVR)
	
	tabPlugins_ = containerTabs_.tabPlugins
	bindTab(tabPlugins_, TabViewPlugins)
end

local function getSelectedTab()
	for i = 0, containerTabs_:getWidgetCount() - 1 do
		local tab = containerTabs_:getWidget(i)
		
		if tab:getState() then
			return tab
		end
	end
end

local function selectTab(tab)
	local selectedTab = getSelectedTab()
	
	if selectedTab ~= tab and selectedTab then
		selectedTab:onHide()
	end
	
	tab:setState(true)
	tab:onShow()
end

local function setStyle(a_style)
    style_ = a_style
	local w,h = containerCentral_:getSize()
	
    if a_style == "sim" then
        tabGraphics_:setVisible(true)
        tabControls_:setVisible(false)
        tabGameplay_:setVisible(false)
        tabMiscellaneous_:setVisible(false)
        
		if tabViews_[tabPlugins_] then
			if tabViews_[tabPlugins_]:bindControls(a_style, w, h-34) == true then
				tabPlugins_	:setVisible(true)
				tabPlugins_	:setPosition(366,0)
				tabVR_	 	:setPosition(549,0)	
			else
				tabPlugins_	:setVisible(false)
				tabVR_	 	:setPosition(366,0)	
			end
		end
        tabSound_	:setPosition(183,0)    
		tabVR_	 	:setVisible(HMD:isActive())
		tabVR_	 	:setPosition(549,0)		
    else
        tabGraphics_:setVisible(true)
        tabGraphics_:setVisible(true)
        tabControls_:setVisible(true)
        tabGameplay_:setVisible(true)
        tabMiscellaneous_:setVisible(true)
		tabPlugins_:setVisible(true)
		if tabViews_[tabPlugins_] then
			tabViews_[tabPlugins_]:bindControls(a_style, w, h-34)
		end
		tabPlugins_	:setPosition(914,0)
        tabSound_:setPosition(731,0)
		tabVR_:setVisible(HMD:isActive() or style_ ~= "sim")
		tabVR_:setPosition(1097,0)		
    end
end


local function create(a_window)
	if not container_ then
		container_			= a_window.containerMain
		containerTabs_		= a_window.containerMain.containerCentral.containerTabs
		containerCentral_	= a_window.containerMain.containerCentral
		containerWide_		= a_window.containerWide
		fon_				= a_window.containerMain.containerCentral.fon

		bindTabs()
	end
end

local function updateRelationsGraphics()
	if tabGraphics_:getState() and tabViews_[tabGraphics_] then
		tabViews_[tabGraphics_]:updateRelations('Graphics')
	end	
end

local function updateDifficulty(name)
	if tabGameplay_:getState() then
		tabViews_[tabGameplay_]:updateOption(name)
	end	
end

local function updateGraphics(name)
	if tabGraphics_:getState() and tabViews_[tabGraphics_] then
		tabViews_[tabGraphics_]:updateOption(name)
	end	
end

local function updateViewsCockpit(name)
	if tabGraphics_:getState() then
		tabViews_[tabGraphics_]:updateOption(name)
	end	
end

local function updateSound(name)
	if tabSound_:getState() then
		tabViews_[tabSound_]:updateOption(name)
	end	
end

local function updateMiscellaneous(name)
	if tabMiscellaneous_:getState() then
		tabViews_[tabMiscellaneous_]:updateOption(name)
	end	
end

local function updateVR(name)
	if tabVR_:getState() then
		tabViews_[tabVR_]:updateOption(name)
	end	
end

local function updatePlugin(pluginId, name)
	if tabPlugins_:getState() then
		tabViews_[tabPlugins_]:updateOption(pluginId, name)
	end
end

local function onOptionsSaved()
	TabViewControls.save()
end

local function onOptionsRestored()
	local checkParentVisibility = true
	
	if container_ and container_:getVisible(checkParentVisibility) then
		for tab, tabView in pairs(tabViews_) do
			if tab:getState() then
				tabView:updateWidgets()		
				break
			end
		end
	end
	
	for tab, tabView in pairs(tabViews_) do
		tabView:onOptionsRestored()	
	end	
end

local function onInputDataSaved()
end

local function onInputDataRestored()
	local checkParentVisibility = true
	
	if container_ and container_:getVisible(checkParentVisibility) then
		if tabControls_:getState() then
			TabViewControls.updateCurrentProfile()
		end
	end	
end

local function selectGraphicsTab()
	selectTab(tabGraphics_)
end

local function selectControlsTab()
	selectTab(tabControls_)
end

local function selectGameplayTab()
	selectTab(tabGameplay_)
end

local function selectSoundTab()
	selectTab(tabSound_)
end

local function selectMiscellaneousTab()
	selectTab(tabMiscellaneous_)
end

local function selectVRTab()
	selectTab(tabVR_)
end

local function selectPluginsTab()
	selectTab(tabPlugins_)
end

local function onShow(a_style)
	local selectedTab = getSelectedTab()
	
	if not selectedTab then
        if a_style ~= 'sim' then
            selectedTab = tabGraphics_
            selectedTab:setState(true)	
        else
            selectedTab = tabSound_
            selectedTab:setState(true)
        end
    else
        if a_style == 'sim' and selectedTab ~= tabSound_ and selectedTab ~= tabGraphics_ and selectedTab ~= tabVR_ then
            selectTab(tabSound_)
            selectedTab = tabSound_
        end    
	end
    
    setStyle(a_style)
    selectedTab:onShow()        
end

local function onHide()
	local selectedTab = getSelectedTab()
	
	if selectedTab then
		selectedTab:onHide()
	end
end

return {
	setOptionsController	= setOptionsController,
	create					= create,
	updateDifficulty		= updateDifficulty,
	updateGraphics			= updateGraphics,
	updateViewsCockpit		= updateViewsCockpit,
	updateSound				= updateSound,
	updateMiscellaneous		= updateMiscellaneous,
    updateVR		        = updateVR,
	updatePlugin			= updatePlugin,
	updateRelationsGraphics = updateRelationsGraphics,
	
	onOptionsSaved			= onOptionsSaved,
	onOptionsRestored		= onOptionsRestored,
	
	onInputDataSaved		= onInputDataSaved,
	onInputDataRestored		= onInputDataRestored,	
	
	selectGraphicsTab		= selectGraphicsTab,
	selectControlsTab		= selectControlsTab,
	selectGameplayTab		= selectGameplayTab,
	selectSoundTab			= selectSoundTab,
	selectMiscellaneousTab	= selectMiscellaneousTab,
    selectVRTab	            = selectVRTab,
	selectPluginsTab		= selectPluginsTab,
	
	onShow					= onShow,
	onHide					= onHide,
}
