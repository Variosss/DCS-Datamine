local base = _G

module('EditSceneWidget', package.seeall)
mtab = { __index = _M }

local Factory = require('Factory')
local Widget = require('Widget')
local gui_editscene = require('gui_editscene')
local editorEnvironment = require('editorEnvironment')
local ED_editAPI = require('ED_editAPI')

Factory.setBaseClass(_M, Widget)

function new()
  return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
	-- self.scene = demosceneEnvironment.createInstance() --создаем демосцену и сохраняем указатель
	self.scenePtr = ED_editAPI.createInstance() --создаем демосцену и сохраняем указатель
	gui_editscene.SetScene(self.widget, self.scenePtr)
end

function newWidget(self)
	return gui_editscene.NewEditSceneWidget()
end

function loadScript(self, filename)
	ED_editAPI.loadScript(self.scenePtr, filename)
end

function getScene(self)
	return editorEnvironment.getInterface(self.scenePtr)
end
