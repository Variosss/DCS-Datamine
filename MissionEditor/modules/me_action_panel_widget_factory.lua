-- модуль для создания виджетов в панели действий
local base = _G

module('me_action_panel_widget_factory')

local require = base.require

local Static			= require('Static')
local Panel				= require('Panel')
local ScrollPane 		= require('ScrollPane')
local EditBox			= require('EditBox')
local CheckBox			= require('CheckBox')
local Button			= require('Button')
local ComboList			= require('ComboList')
local SpinBox			= require('SpinBox')
local Dial				= require('Dial')
local CheckListTree		= require('CheckListTree')
local CheckListTreeMulty= require('CheckListTreeMulty')
local ListBox			= require('ListBox')
local ListBoxItem 		= require('ListBoxItem')
local Skin				= require('Skin')
local ScrollPane		= require('ScrollPane')

local panelSkin
local staticSkin
local editBoxSkin
local checkBoxSkin
local buttonSkin
local comboListSkin
local spinBoxSkin
local dialSkin
local checkListTreeSkin
local skinScrollPane

function initSkins(window)
	local panel = window.skinPanel
	
	panelSkin = panel:getSkin()
	staticSkin = panel.static:getSkin()
	editBoxSkin = panel.editBox:getSkin()
	checkBoxSkin = panel.checkBox:getSkin()
	buttonSkin = panel.button:getSkin()
	comboListSkin = panel.comboList:getSkin()
	spinBoxSkin = panel.spinBox:getSkin()
	dialSkin = panel.dial:getSkin()
	checkListTreeSkin = panel.checkListTree:getSkin()	
	listBoxSkin	= panel.listBox:getSkin()
    listBoxItemSkin = panel.listBoxItem:getSkin()
	skinScrollPane = window.skinScrollPane:getSkin()
end

local function createWidget(widgetTable, skin, text, x, y, w, h)
	local widget = widgetTable.new()
	
	if text then
		widget:setText(text)
	end
	
	if x then
		widget:setBounds(x, y, w, h)
	end
	
	widget:setSkin(skin)
	
	return widget
end

function createStatic(text, x, y, w, h)
	-- почти все статики создаются в одном и том же месте
	return createWidget(Static, staticSkin, text, x, y, w, h)
end

function createEditBox(x, y, w, h)
	return createWidget(EditBox, editBoxSkin, nil, x, y, w, h)
end

function createComboList(x, y, w, h)
	return createWidget(ComboList, comboListSkin, nil, x, y, w, h)
end

function createCheckBox(text, x, y, w, h)
	return createWidget(CheckBox, checkBoxSkin, text, x, y, w, h)
end

function createButton(text, x, y, w, h)
	return createWidget(Button, buttonSkin, text, x, y, w, h)
end

function createSpinBox(min, max, x, y, w, h)
	local spinBox = createWidget(SpinBox, spinBoxSkin, nil, x, y, w, h)
	
	spinBox:setRange(min, max)
	spinBox:setValue(1)
	
	return spinBox
end

function createPanel(x, y, w, h)
	return createWidget(Panel, panelSkin, nil, x, y, w, h)
end

function createScrollPane(x, y, w, h)
	return createWidget(ScrollPane, skinScrollPane, nil, x, y, w, h)
end

function createDial(x, y, w, h)
	return createWidget(Dial, dialSkin, nil, x, y, w, h)
end

function createCheckListTree(x, y, w, h)
	return createWidget(CheckListTree, checkListTreeSkin, nil, x, y, w, h)
end

function createCheckListTreeMulty(x, y, w, h)
	return createWidget(CheckListTreeMulty, checkListTreeSkin, nil, x, y, w, h)
end

function createListBox(x, y, w, h)
	local listBox = ListBox.new()
	listBox:setBounds(x, y, w, h)
	listBox:setSkin(listBoxSkin)
	return listBox
end

function createListBoxItem(text,x, y, w, h)
	local listListBox = ListBoxItem.new(text)
	listListBox:setBounds(x, y, w, h)
	listListBox:setSkin(listBoxItemSkin)
	return listListBox
end