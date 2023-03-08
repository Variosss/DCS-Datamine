--Контрол из комбобокса и кнопок его листающих, для точек маршрута ЛА

local base = _G

module('me_spin_wpt')
mtab = { __index = _M }

local require = base.require
local pairs = base.pairs
local tostring = base.tostring

local DialogLoader = require('DialogLoader')
local Factory = require('Factory')
local Panel = require('Panel')
local ComboList = require('ComboList')
local Button = require('Button')
local ListBoxItem = require("ListBoxItem")
local mod_mission = require('me_mission')

local U = require('me_utilities')

-------------------------------------------------------------------------------
--
function new()
  return Factory.create(_M)
end

-------------------------------------------------------------------------------
--
function construct(self)
    local dialog = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_spin_wpt.dlg", cdata)
    local panelWidgets = dialog.panelWidgets
    
    dialog:removeWidget(panelWidgets)
    dialog:kill()
    
    self.ContainerWidgets    = panelWidgets
    self.LeftButton          = panelWidgets.buttonLeft
    self.CenterCombo         = panelWidgets.comboList
    self.RightButton         = panelWidgets.buttonRight

    self.LeftButton.parent = self    
    self.CenterCombo.parent = self    
    self.RightButton.parent = self    

    self.RightButton.onChange  = onChangeRightButton 
    self.LeftButton.onChange   = onChangeLeftButton  
    self.CenterCombo.onChange  = onChangeCenterCombo    

    self.indexToindex = {}
    self.indexToindex.r = {}
end



-------------------------------------------------------------------------------
--
function create(self, a_x, a_y, a_w, a_h)
    setBounds(self, a_x, a_y, a_w, a_h)
    
    return self.ContainerWidgets;
end


-------------------------------------------------------------------------------
--
function getText(self)
    return self.CenterCombo:getText()
end

-------------------------------------------------------------------------------
--
function setBounds(self, a_x, a_y, a_w, a_h)
    local x = a_x or 0
    local y = a_y or 0
    local w = a_w or 100
    local h = a_h or U.widget_h
    self.ContainerWidgets:setBounds(x, y, w, h)
    self.LeftButton:setBounds(0, 0, h, h)
    self.CenterCombo:setBounds(h, 0, w-2*h, h)
    self.RightButton:setBounds(w-h, 0, h, h)
end

-------------------------------------------------------------------------------
--
function onChangeRightButton(self)
    local item = self.parent.CenterCombo:getSelectedItem()
    local index = self.parent.CenterCombo:getItemIndex(item)
    item = self.parent.CenterCombo:getItem(index+1)    
    if (item) then
        self.parent.CenterCombo:selectItem(item)
        self.parent.CenterCombo:onChange(self.parent.CenterCombo)
    end
end

-------------------------------------------------------------------------------
--
function onChangeLeftButton(self)
    local item = self.parent.CenterCombo:getSelectedItem()
    local index = self.parent.CenterCombo:getItemIndex(item)
    item = self.parent.CenterCombo:getItem(index-1)
    if (item) then
        self.parent.CenterCombo:selectItem(item)
        self.parent.CenterCombo:onChange(self.parent.CenterCombo)
    end
end

-------------------------------------------------------------------------------
--
function onChangeCenterCombo(self)
    self.parent:onChange(self.parent)
end

-------------------------------------------------------------------------------
--a_index - текущий элемент, a_maxIndex-максимальный элемент, a_country- страна,
--a_startIndex - начальный элемент отображения, a_endIndex - конечный элемент отображения
--a_exceptList - список элементов которых не должно быть в списке (таблица)
function setWPT(self, a_index, a_maxIndex, a_country, a_startIndex, a_endIndex, a_exceptList)
    if a_startIndex == nil then
        a_startIndex = 1
    end
    if a_endIndex == nil then
        a_endIndex = a_maxIndex
    end
    
    function isExept(a_index)
        if (a_exceptList == nil) then
            return false
        end      
        for k,v in pairs(a_exceptList) do
            if (v == a_index) then
                return true
            end
        end        
        return false
    end
    
    self.indexToindex = {}
    self.indexToindex.r = {}
    self.CenterCombo:removeAllItems()
    
    local index = 1
    for i=1,a_maxIndex do
        if (i >= a_startIndex) and (i <= a_endIndex) and (isExept(i) == false) then
            local name = tostring(i-1)
            name = mod_mission.reNameWaypoints(name, i, a_maxIndex, a_country)
            
            local item = ListBoxItem.new(name)
            self.CenterCombo:insertItem(item);
            self.indexToindex[i] = index
            self.indexToindex['r'][index] = i
            index = index + 1
        end
    end

    setCurIndex(self, a_index)
end

-------------------------------------------------------------------------------
--
function clear(self)
	self.indexToindex = {}
    self.indexToindex.r = {}
    self.CenterCombo:removeAllItems()
end

-------------------------------------------------------------------------------
--
function setCurIndex(self, index)
	if self.indexToindex[index] ~= nil then
		local item = self.CenterCombo:getItem(self.indexToindex[index]-1)
		self.CenterCombo:selectItem(item)
	else
		self.CenterCombo:selectItem(nil)
	end
end

-------------------------------------------------------------------------------
--
function setEnabled(self, a_enabled)
    self.LeftButton:setEnabled(a_enabled)
    self.CenterCombo:setEnabled(a_enabled)
    self.RightButton:setEnabled(a_enabled)
end

-------------------------------------------------------------------------------
--
function getCurIndex(self)
    local item = self.CenterCombo:getSelectedItem()
	if item then
		local index = self.indexToindex.r[self.CenterCombo:getItemIndex(item)+1]
		return index; -- потомучто в контроле индексы с 0 
	else
		return nil
	end
end

