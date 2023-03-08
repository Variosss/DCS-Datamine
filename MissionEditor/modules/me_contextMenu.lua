local base = _G

module('me_contextMenu')

local require       = base.require
local pairs         = base.pairs
local ipairs        = base.ipairs
local table         = base.table
local math          = base.math
local loadfile      = base.loadfile
local setfenv       = base.setfenv
local string        = base.string
local assert        = base.assert
local io            = base.io
local loadstring    = base.loadstring
local print         = base.print
local os            = base.os


local U 					= require('me_utilities')	
local MapWindow 			= require('me_map_window')
local DialogLoader			= require('DialogLoader')
local Gui               	= require('dxgui')
local Static            	= require('Static')
local TextUtil          	= require('textutil')
local i18n					= require('i18n')
local Terrain         		= require('terrain')
local TriggerZoneController	= require('Mission.TriggerZoneController')
local MapController			= require('Mission.MapController')
local Menu 					= require('Menu')
local MenuItem 				= require('MenuItem')
local MenuSeparatorItem 	= require('MenuSeparatorItem')
local MenuSubItem 			= require('MenuSubItem')

i18n.setup(_M)

local cdata = 
{

}

local X = 0
local Y = 0
local winW
local winH
local objects

function command_assignAs(a_object)
	--base.print("---command_assignAs---")

	local radius = a_object.radius
	
	local properties = {}
	base.table.insert(properties, {["key"] = "ROLE",["value"] = ""})
	base.table.insert(properties, {["key"] = "VALUE",["value"] = ""})
	base.table.insert(properties, {["key"] = "OBJECT ID",["value"] = a_object.id})
	base.table.insert(properties, {["key"] = "NAME"     ,["value"] = a_object.model})

	local sinRot = base.math.sin(-a_object.rotation) 
	local cosRot = base.math.cos(-a_object.rotation) 
	local dx = a_object.sizeOBB[1] / 2
	local dy = a_object.sizeOBB[2] / 2
				
	local points = {
		{x = -dx*cosRot-(-dy*sinRot), y = -dx*sinRot+(-dy*cosRot)},
		{x = dx*cosRot-(-dy*sinRot), y = dx*sinRot+(-dy*cosRot)},
		{x = dx*cosRot-(dy*sinRot), y = dx*sinRot+(dy*cosRot)},
		{x = -dx*cosRot-(dy*sinRot), y = -dx*sinRot+(dy*cosRot)},		
	}
	
	local triggerZoneId = TriggerZoneController.addTriggerZone(a_object.model,a_object.center[1], a_object.center[2], radius, properties, nil, 2, points)
												
	MapController.onToolbarTriggerZone(true)
	MapController.selectObject(triggerZoneId)
	TriggerZoneController.selectTriggerZone(triggerZoneId)
end

local listCommands = 
{
	{command  = "assignAs", displayName = _("assign as ..."), func = command_assignAs}
}

function create()
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_contextMenu.dlg', cdata)
	
	winW, winH = Gui.GetWindowSize()
	sTest = window.sTest
	menu = window.menu
		
	window:addMouseDownCallback(function(wnd, x, y, button)
		local widgetPtr = Gui.FindWidgetAtScreenPoint(x, y)
		local widget = window.widgets[widgetPtr] -- перевести из указателя С++ в виджет Lua

		if widget == nil then
			show(false)
		end
	end) 
	
	miTemplSkin 	= window.miTempl:getSkin()
	msiTemplSkin 	= window.msiTempl:getSkin()
	
	menu:setVisible(true)
end

function show(b, x, y)
	if not window then
		create()
	end
	
	objects = nil
	
	if b == false or x == nil or y == nil then
		menu:setVisible(false)
		return
	end
	
	mapX, mapY = base.me_map_window.getMapPoint(x, y)
	objects = Terrain.getObjectsAtMapPoint(mapX, mapY)
	
	menu:setPosition(x, y)
	
	if mapX == nil or mapY == nil or objects == nil or #objects == 0 then
		menu:setVisible(false)
		return
	end
	
	updateList(listCommands)
	menu:setVisible(true)

end

local function compareUnits(left, right)
	return TextUtil.Utf8Compare(left.displayName, right.displayName) 
end

function updateList(listCommands)
	menu:clear()
	
	if #objects == 1 then
		if listCommands and # listCommands > 0 then
			base.table.sort(listCommands, compareUnits)
			for k,v in base.pairs(listCommands) do
				local menuItem = MenuItem.new()
				menuItem:setSkin(miTemplSkin)
				menuItem:setText(v.displayName)
				menuItem.data = v
				menuItem.command = v.command
				menuItem.func = v.func
				menuItem.mapObject = objects[1]
				menu.onChange = function(self, item)
					item.func(item.mapObject)
				end
					
				menu:insertItem(menuItem)
			end
		end
	else
		if listCommands and # listCommands > 0 then

			base.table.sort(listCommands, compareUnits)
			for k,v in base.pairs(listCommands) do				
				local submenu = Menu.new()
				submenu:setSkin(menu:getSkin())
				for kk,vv in base.ipairs(objects) do
					local menuItem = MenuItem.new()	
					menuItem:setSkin(miTemplSkin)					
					menuItem:setText(vv.model)
					menuItem.mapObject = vv
					menuItem.func = v.func
					submenu:insertItem(menuItem)					
				end
				submenu.onChange = function(self, item)
					item.func(item.mapObject)
				end
				
				local menuSubItem = MenuSubItem.new(v.displayName, submenu)
				menuSubItem:setSkin(msiTemplSkin)
				menuSubItem.data = v
				menuSubItem.command = v.command
				menu:insertItem(menuSubItem)
			end
		end	
	end
end



