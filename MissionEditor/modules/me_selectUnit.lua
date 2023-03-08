local base = _G

module('me_selectUnit')

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


local U 				= require('me_utilities')	
local MapWindow 		= require('me_map_window')
local DialogLoader		= require('DialogLoader')
local Gui               = require('dxgui')
local ListBoxItem		= require('ListBoxItem')
local Static            = require('Static')
local TextUtil          = require('textutil')
local i18n				= require('i18n')

i18n.setup(_M)

local cdata = 
{

}

local X = 0
local Y = 0
local winW
local winH

function create()
	window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_selectUnit.dlg', cdata)
	
	winW, winH = Gui.GetWindowSize()
	window:setBounds(0, 0, winW, winH)
	listBox = window.listBox
	sTest = window.sTest
	
	window:addMouseDownCallback(function(wnd, x, y, button)
		local widgetPtr = Gui.FindWidgetAtScreenPoint(x, y)
		local widget = window.widgets[widgetPtr] -- перевести из указателя С++ в виджет Lua

		if widget == nil then
			show(false)
		end
	end) 
	
	listBox.onChange = listBox_onChange
end

function listBox_onChange(self)
	item = self:getSelectedItem()
	
	if callBack then
		callBack(item.data.mapId, true, true, MapX, MapY, true)
	end
	show(false)
end


function show(b, listUnits, a_callBack, x, y, mapX, mapY)
	if not window then
		create()
	end
	
	X = x
	Y = y
	MapX = mapX
	MapY = mapY
	
	callBack = a_callBack
	updateList(listUnits or {})
	window:setVisible(b)
end

local function compareUnits(left, right)
	return TextUtil.Utf8Compare(left.displayName, right.displayName) 
end

function updateList(listUnits)
	listBox:clear()
	
	if listUnits and #listUnits > 0 then
		local w = 100
		local h = 2
		base.table.sort(listUnits, compareUnits)
		for k,v in base.pairs(listUnits) do
			local text
			local newItem
			if v.type == "unit" or v.type == "group" then
				text = v.unit.type..": "..v.displayName
				if v.wptName then
					text = text.." ".._("WP")..": "..v.wptName
				end
				newItem = ListBoxItem.new(text)
			elseif v.type == "obj2" then
				text = v.displayName
				newItem = ListBoxItem.new(text)
			end
			
			sTest:setText(text)
			local nw,nh = sTest:calcSize()
			if (nw+30) > w then
				w = nw + 30
			end
			h = h + 20
			newItem.data = v
			listBox:insertItem(newItem)
		end
		if h > 202 then
			h = 202
		end
		listBox:setSize(w, h)
		if (Y+h+30) > winH then
			Y = winH - h-30
		end
		listBox:setPosition(X,Y)
		listBox:setVisible(true)
	else
		listBox:setVisible(false)
	end
end

