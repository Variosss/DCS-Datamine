local base = _G

module('DemoSceneWidget', package.seeall)
mtab = { __index = _M }

local Factory = require('Factory')
local Widget = require('Widget')
local gui_demoscene = require('gui_demoscene')
local demosceneEnvironment = require('demosceneEnvironment')
local ED_demosceneAPI = require('ED_demosceneAPI')

Factory.setBaseClass(_M, Widget)

function new()
  return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
	-- self.scene = demosceneEnvironment.createInstance() --создаем демосцену и сохраняем указатель
	self.scenePtr = ED_demosceneAPI.create_instance() --создаем демосцену и сохраняем указатель
	gui_demoscene.SetScene(self.widget, self.scenePtr)
end

function newWidget(self)
	return gui_demoscene.NewDemoSceneWidget()
end

function loadScript(self, filename)
	ED_demosceneAPI.loadScript(self.scenePtr, filename)
end

function getScene(self)
	return demosceneEnvironment.getInterface(self.scenePtr)
end
