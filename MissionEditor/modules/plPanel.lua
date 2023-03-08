--Контрол 

local base = _G

module('plPanel')
mtab = { __index = _M }

local require = base.require
local pairs = base.pairs
local math = base.math
local table = base.table
local string = base.string
local DialogLoader      = require('DialogLoader')
local Factory           = require('Factory')
local Panel             = require('Panel')
local Static            = require('Static')
local gui               = require('dxgui')
local Skin              = require('Skin')
local ToggleButton      = require('ToggleButton')
local lfs 				= require('lfs')
local textutil 			= require('textutil')
local i18n               = require('i18n')

i18n.setup(_M)


local contWidthMain = 86
local contWidthMenu = 103
local lrButWidth = 25
local contWidth 
local callbackCloseInfo = nil

local staticSkinsLoaded = false
local staticStateSkin
local staticNameSkin
local staticVersionSkin

local mainPanelButtonSkin = Skin.plPanel_mainButtonSkin()
local normalPanelButtonSkin = Skin.toggleButtonPlPlaginSkin()


--make short version 2.3.0.143455 -> 2.3.0 : DEBUG -> DEBUG
local __DCS_VERSION__short = base.__DCS_VERSION__

local index = 1
for word in base.__DCS_VERSION__:gmatch("%w+") do 
    if index < 4 then
        if index == 1 then
            __DCS_VERSION__short = ""
        end
        __DCS_VERSION__short =	__DCS_VERSION__short .. word
        if index < 3 then
        __DCS_VERSION__short =	__DCS_VERSION__short .. '.'
        end
    end
    index = index + 1
end

-------------------------------------------------------------------------------
--
function new()
  return Factory.create(_M)
end


-------------------------------------------------------------------------------
--
function construct(self)
    local dialog = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_plugin_panel.dlg", cdata)
    local panelWidgets = dialog.panelWidgets
    
    dialog:removeWidget(panelWidgets)
    
    if not staticSkinsLoaded then
        staticStateSkin = dialog.staticState:getSkin()
        staticNameSkin = dialog.staticName:getSkin()
        staticVersionSkin = dialog.staticVersion:getSkin()
        staticSkinsLoaded = true
    end    
    
    dialog:kill()
    
    self.ContainerWidgets    = panelWidgets
    self.LeftButton          = panelWidgets.buttonLeft
	
	self.ContainerEl         = panelWidgets.panelElements
    self.RightButton         = panelWidgets.buttonRight	

    self.LeftButton.parent = self 
	self.ContainerEl.parent = self 	
    self.RightButton.parent = self 

    self.RightButton.onChange  = onChangeRightButton 
    self.LeftButton.onChange   = onChangeLeftButton   
	
	self.data 			= {}
	self.numBut 		= 0 		-- число кнопок элементов в панели
	self.firstElement 	= 0 	-- первый элемент
	self.m_callbackEl	= nil
	self.numEl 			= 0 -- число элементов для отображения
	self.Style 			= "normal"   --"main"
end


-------------------------------------------------------------------------------
--
function create(self, a_x, a_y, a_w, a_h,a_data, a_callback, a_style, a_callbackCloseInfo)
    self.ContainerWidgets:setBounds(a_x, a_y, a_w, a_h)
	
	m_x = a_x
	m_y = a_y
	m_w = a_w
	m_h = a_h
	
	if (a_style ~= nil) then
		self.Style = a_style
		contWidth = contWidthMain
	else
		contWidth = contWidthMenu
	end

	callbackCloseInfo = a_callbackCloseInfo
	
	setData(self,a_data, a_callback)
	
    return self.ContainerWidgets;
end


-------------------------------------------------------------------------------
--
function onChangeRightButton(self)
    local parent = self.parent
    
	parent.firstElement = parent.firstElement + 1
	if (parent.firstElement >= (parent.numEl - parent.numBut)) then
		parent.firstElement = parent.numEl - parent.numBut
		self:setEnabled(false)		
	end
	parent.LeftButton:setEnabled(true)
    updateDataButtons(parent)
	callbackCloseInfo()
end

-------------------------------------------------------------------------------
--
function onChangeLeftButton(self)
    local parent = self.parent
    
	parent.firstElement = parent.firstElement - 1
	if (parent.firstElement <= 0) then
		parent.firstElement = 0
		self:setEnabled(false)		
	end
	parent.RightButton:setEnabled(true)
    updateDataButtons(parent)
	callbackCloseInfo()
end

-------------------------------------------------------------------------------
--
function pushButton(self, a_CLSID)
	local numElem = 0
	for k, data in pairs(self.data) do	
		numElem = numElem +1;
	end
	
	local widgetCount = self.ContainerEl:getWidgetCount()
	
	for k, v in pairs(self.data) do		
		if (v.data.CLSID == a_CLSID) then
			if ((numElem - k) >= widgetCount) then
				self.firstElement = k
			else
				self.firstElement = numElem - widgetCount				
			end
		end	
	end	
	
	self.LeftButton:setEnabled(true)
	self.RightButton:setEnabled(true)
	if (self.firstElement == 0) then
		self.LeftButton:setEnabled(false)
	end
	if ((numElem - self.firstElement) == self.ContainerEl:getWidgetCount()) then
		self.RightButton:setEnabled(false)
	end
	
	updateDataButtons(self)
	
	local widgetCounter = self.ContainerEl:getWidgetCount() - 1
	
	for i = 0, widgetCounter do	
		local buttonEl = self.ContainerEl:getWidget(i).but

		if (buttonEl.data.CLSID == a_CLSID) then
			buttonEl:setState(true)			
			self.data[buttonEl.num+self.firstElement].selected = true
		else
			buttonEl:setState(false)
		end	
	end	
end

-------------------------------------------------------------------------------
--
function deselectAll(self)
	local widgetCounter = self.ContainerEl:getWidgetCount() - 1
	
	for i = 0, widgetCounter do	
		self.ContainerEl:getWidget(i).but:setState(false)
	end
end

-------------------------------------------------------------------------------
--
local function compTable(tab1, tab2)
    if (tab1.data.id == "Nevada") then
        return true
    end
    if (tab2.data.id == "Nevada") then
        return false
    end
	return textutil.Utf8Compare((tab1.data.name or tab1.name), (tab2.data.name or tab2.name))
end

-------------------------------------------------------------------------------
--
function setData(self, a_data, a_callback)  --a_data = {data = {...}} or {name = ... , data = {...}}
	-- сортировка
	local tmpData = {}	
	
    for k,v in pairs(a_data) do	
		if v.data.state ~= nil then
			table.insert(tmpData, v)
		end
	end
    
	table.sort(tmpData, compTable)
	
	self.numEl = 0 -- число элементов для отображения
	for k,v in pairs(tmpData) do
		self.data[self.numEl] = v
		self.numEl = self.numEl + 1		
	end
	
	local maxBut = math.floor(m_w / (contWidth+1)) -- максимально влезает без кнопок прокрутки
	local maxButWithLR = math.floor((m_w-lrButWidth*2)/ (contWidth+1)) -- максимально влезает c кнопками прокрутки
	
	
	if (self.numEl > maxBut) then
		--делаем панель с кнопками
		self.RightButton:setVisible(true)
		self.LeftButton:setVisible(true)
		self.ContainerEl:setBounds(lrButWidth, 0, maxButWithLR*(contWidth+1), m_h)
		self.LeftButton:setBounds(0, 0, lrButWidth, m_h)
		self.RightButton:setBounds(maxButWithLR*(contWidth+1)+lrButWidth, 0, lrButWidth, m_h)
		self.numBut = maxButWithLR
	else
		self.RightButton:setVisible(false)
		self.LeftButton:setVisible(false)
		self.ContainerEl:setBounds(0, 0, self.numEl*(contWidth+1), m_h)
		self.numBut = self.numEl
	end
	
	createButtons(self, self.numBut, a_callback)
	updateDataButtons(self)

end

function getPanelButtonSkin(self)
    if (self.Style == "main") then		
        return mainPanelButtonSkin
    else
        return normalPanelButtonSkin
    end	
end

-------------------------------------------------------------------------------
--
function createButtons(self, a_numBut, a_callback)
	self.ContainerEl:removeAllWidgets()
	
	for i=0, a_numBut-1 do
		local cont = Panel.new()
		cont:setBounds(i*contWidth+i, 0, contWidth, m_h)
		self.ContainerEl:insertWidget(cont)	
		cont.parent = self		
		local but = ToggleButton.new()
		
		if (self.Style == "main") then		
			but:setBounds(0, 20, contWidth, m_h-60)
		else
			but:setBounds(0, 0, contWidth, m_h)
		end	
        
        but:setSkin(self:getPanelButtonSkin())
        
		but.num = i
		but.main = self.ContainerEl.parent
		cont:insertWidget(but)
		cont.but = but				
		
				
		local widState = Static.new()
		widState:setBounds(0, 0, contWidth, 20)
		widState:setSkin(staticStateSkin)
		cont:insertWidget(widState)
		cont.widState = widState
		
		local widName = Static.new()
		widName:setBounds(0, m_h - 55, contWidth, 30)
		widName:setSkin(staticNameSkin)	
		cont:insertWidget(widName)
		cont.widName = widName
		
		local widVersion = Static.new()
		widVersion:setBounds(0, m_h - 25, contWidth, 15)
		widVersion:setSkin(staticVersionSkin)
		cont:insertWidget(widVersion)
		cont.widVersion = widVersion
		
		if (self.Style ~= "main") then	
			widState:setVisible(false)
			widName:setVisible(false)
			widVersion:setVisible(false)
		end
	end
	self.m_callbackEl = a_callback
end

local function processPluginVersion(in_v)
	if not in_v then 
		return ""
	end

	--may be it is really better do not show row of same symbols for each module 
	local res = string.gsub (in_v,base.__DCS_VERSION__,"") -- remove __DCS_VERSION__ 
	res 	  = string.gsub (res ,__DCS_VERSION__short,"") -- remove __DCS_VERSION__short
	res		  =	string.match(res,'^%s*(.*)')			   -- trim spaces 

	return res
end

-------------------------------------------------------------------------------
--
function updateDataButtons(self)
	local num = 0
	local widgetCounter = self.ContainerEl:getWidgetCount() - 1
	
	for i = 0, widgetCounter do	
		local contEl = self.ContainerEl:getWidget(i)
		local buttonEl = contEl.but
		local data = contEl.parent.data
		local firstElement = contEl.parent.firstElement
		buttonEl:setText(data[num+firstElement].name)
		buttonEl.data = data[num+firstElement].data
		buttonEl.onChange = function(self)
			if (self:getState() == true) then
				for k,v in pairs(data) do
					v.selected = false
				end
				data[self.num+firstElement].selected = true
				updateDataButtons(buttonEl.main)
			else
				self:setState(true)
			end	
			local coordRV = {}
			coordRV.x, coordRV.y = buttonEl:widgetToWindow(contWidth,0)
			contEl.parent.m_callbackEl(buttonEl.data, coordRV)			
		end
		
		if (data[num+firstElement].data.name ~= nil) then
			contEl.widName:setText(data[num+firstElement].data.name)
		else
			contEl.widName:setText("");	
		end
		
		contEl.widVersion:setText(processPluginVersion(data[num+firstElement].data.version));	
		
		if (data[num+firstElement].data.dirSkins ~= nil) then
			if (self.Style == "main") then				
				setImageBut(buttonEl, data[num+firstElement])			
			else
				if (data[num+firstElement].name ~= nil) then
					buttonEl:setText(data[num+firstElement].name)
				end
			end
		else
			
		end
		
		if data[num+firstElement].selected == true then
			buttonEl:setState(true)
		else
			buttonEl:setState(false)
		end
		num = num + 1
	end
end

-------------------------------------------------------------------------------
--
function setImageBut(a_buttonEl, a_data)
	local nameIcon = "icon";
    local tooltip = ""

	if (a_data.data.state == "sale") then
		nameIcon = "icon_buy"
        tooltip = _("BUY NOW!")
	end
    
	local image = a_data.data.dirSkins.."/"..nameIcon..".png"
	
	local icon_attr = lfs.attributes(image)		
	if (icon_attr == nil) or (icon_attr.mode ~= 'file') then
		image = "dxgui/skins/skinME/images/default-86x86.png" 
	end
				
	local imageSelect = a_data.data.dirSkins.."/icon_select.png"
	local b = lfs.attributes(imageSelect)				
	if (b == nil) or (b.mode ~= 'file') then
		imageSelect = image
	end
	
	local imageActive = a_data.data.dirSkins.."/icon_active.png"
	b = lfs.attributes(imageActive)				
	if (b == nil) or (b.mode ~= 'file') then
		imageActive = image
	end
	
	local skin = a_buttonEl:getSkin()
	local states = skin.skinData.states
	states.released[1].picture.file = image
	states.released[2].picture.file = image			
	states.hover[1].picture.file = imageSelect
	states.hover[2].picture.file = imageSelect 
	states.pressed[1].picture.file = imageActive
	states.pressed[2].picture.file = imageActive				
	states.disabled[1].picture.file = image
	states.disabled[2].picture.file = image
	a_buttonEl:setSkin(skin)
    
    a_buttonEl:setTooltipText(tooltip)
end
