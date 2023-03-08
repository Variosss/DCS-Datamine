module('DemoSceneDialog', package.seeall)

local Factory	= require('Factory')
-- local Gui = require('dxgui')
-- local GuiWin = require('dxguiWin')
local DialogLoader = require('DialogLoader')
local DemoSceneWidget = require('DemoSceneWidget')

local M = {}

M.construct = function (self, text)
	self.window = DialogLoader.spawnDialogFromFile('Scripts/UI/DemoSceneDialog.dlg') 
	self.window:setText(text)
	self.demoSceneWidget = DemoSceneWidget.new()
	self.demoSceneWidget:setBounds(self.window.staticPlaceholder:getBounds())
	self.window:insertWidget(self.demoSceneWidget)
    -- window:centerWindow()
end

M.loadScript = function(self, script)
	self.demoSceneWidget:loadScript(script)
end

M.getScene = function(self)
	return self.demoSceneWidget:getScene()
end

M.show = function(self)    
    self.window:setVisible(true)
    -- DCS.banMouse(true)
    -- DCS.setPause(true)
end

M.hide = function(self)
    self.window:setVisible(false)
    -- DCS.banMouse(false)
    -- DCS.setPause(false)
end

M.getVisible = function(self)    
	return self.window:getVisible()
end

M.kill = function (self)	
	--TODO добить демосцену
   self.window:kill()
   self.window = nil
end

return Factory.createClass(M)