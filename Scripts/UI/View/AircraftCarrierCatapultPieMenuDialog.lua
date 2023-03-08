-- Pie menu for the RCtrl-F9 view
local DialogLoader		= require('DialogLoader')
local gettext			= require('i_18n')
local dxgui				= require('dxgui')
local SkinUtils			= require('SkinUtils')
local Skin              = require('Skin')
local PieMenu          	= require("PieMenu")
local PieMenuItem      	= require("PieMenuItem")
local PieMenuSubItem    = require("PieMenuSubItem")
local utils				= require('utils')
local serialize			= require('serialize_to_string')

local window_
local pieMenuAircraftCarrier_

local function setBkgColor(item, color)
	local skin = item:getSkin()
	skin.skinData.states.released[1].bkg.center_center = color
	item:setSkin(skin)
end

local function setFontSize(item, sz)
	local skin = item:getSkin()
	skin.skinData.states.released[1].text.fontSize = sz
	item:setSkin(skin)
end

local blues = {
	'0x01010480',
	'0x04041080',
	'0x08084080',
	'0x1010a080',
}

local function setMenuItems()
--	print('setMenuItems()')
	for i = 1,4 do
        local name = string.format("%d", i)	           
        local menuSubItem = PieMenuSubItem.new(name)
		local skin = menuSubItem:getSkin()
		setBkgColor(menuSubItem, blues[i])
		setFontSize(menuSubItem, 32)
		menuSubItem.id = i * 10
--		print('Catapult: ', i, ', menuSubItem: ', name, 'id: ', menuSubItem.id)
		pieMenuAircraftCarrier_:insertItem(menuSubItem)
		name = name .. " SubMenu"
		local subMenu = PieMenu.new(name)
		-- 1 - shooter (yellow)
		local member_name = "Shooter"
		local menuItem = PieMenuItem.new(member_name)
		menuItem:setSkin(skin);
		setBkgColor(menuItem, '0xffff00c0')
		menuItem.id = menuSubItem.id + 1
		subMenu:insertItem(menuItem)
		-- 2 - director (yellow)
		member_name = "Director"
		menuItem = PieMenuItem.new(member_name)
		setBkgColor(menuItem, '0xffff00c0')
		menuItem.id = menuSubItem.id + 2
		subMenu:insertItem(menuItem)
		-- 3 - white1
		member_name = "White 1"
		menuItem = PieMenuItem.new(member_name)
		setBkgColor(menuItem, '0xffffffc0')
		menuItem.id = menuSubItem.id + 3
		subMenu:insertItem(menuItem)
		-- 4 - white2
		member_name = "White 2"
		menuItem = PieMenuItem.new(member_name)
		setBkgColor(menuItem, '0xffffffc0')
		menuItem.id = menuSubItem.id + 4
		subMenu:insertItem(menuItem)
		-- 5 - green_hbb
		member_name = "Green HBB"
		menuItem = PieMenuItem.new(member_name)
		setBkgColor(menuItem, '0x00ff00c0')
		menuItem.id = menuSubItem.id + 5
		subMenu:insertItem(menuItem)
		-- 6 - green_nw
		member_name = "Green NW"
		menuItem = PieMenuItem.new(member_name)
		setBkgColor(menuItem, '0x00ff00c0')
		menuItem.id = menuSubItem.id + 6
		subMenu:insertItem(menuItem)
		
		menuSubItem:setSubmenu(subMenu)				
	end	
end

-- TODO: Make custom pie menu dialog in the GUI editor	
local function create()
--	print('create()')
	window_ = DialogLoader.spawnDialogFromFile('./Scripts/UI/View/PieMenuDialog.dlg')
--	window_:setSkin(SkinUtils.setWindowBkgColor(window_:getSkin(), 0x00000080))
	local circle_skin = window_:getSkin()
	circle_skin.skinData.params.circleColor = "0xffffff00"
	window_:setSkin(circle_skin)
	pieMenuAircraftCarrier_ = window_
	setMenuItems()
	
	function pieMenuAircraftCarrier_:onChange()
		local item = self:getSelectedItem()
--		print("pieMenuAircraftCarrier_:onChange()-> id = "..item.id..", text = "..item:getText())
		onAircraftCarrierPieMenu(item.id, item:getText())
	end
	
end

local function kill()
	window_:kill()
	window_ = nil
end

local function show()
	window_:setVisible(true)
end

local function hide()
	window_:setVisible(false)
end

local function getWindow()
	return window_
end

local function isVisible()
	return window_:getVisible()
end

return {
	create								= create,
	kill								= kill,
	show								= show,
	hide								= hide,
	getWindow							= getWindow,
	isVisible							= isVisible,
}
