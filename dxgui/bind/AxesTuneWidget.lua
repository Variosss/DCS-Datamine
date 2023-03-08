local base = _G

module('AxesTuneWidget')
mtab = { __index = _M }

local Factory = base.require('Factory')
local Widget = base.require('Widget')
local gui_axes_tune = base.require('gui_axes_tune')

Factory.setBaseClass(_M, Widget)

function new()
	return Factory.create(_M)
end

function construct(self)
	Widget.construct(self)
end

function newWidget(self)
	return gui_axes_tune.NewAxesTuneWidget()
end

function setDeadZone(self, value)
	gui_axes_tune.AxesTuneWidgetSetDeadZone(self.widget, value)
end 

function setSaturationX(self, value)
	gui_axes_tune.AxesTuneWidgetSetSaturationX(self.widget, value)
end 

function setSaturationY(self, value)
	gui_axes_tune.AxesTuneWidgetSetSaturationY(self.widget, value)
end 

function setSlider(self, value)
	gui_axes_tune.AxesTuneWidgetSetSlider(self.widget, value)
end 

function setInvert(self, value)
	gui_axes_tune.AxesTuneWidgetSetInvert(self.widget, value)
end 

function setUserCurve(self, value)
	gui_axes_tune.AxesTuneWidgetSetUserCurve(self.widget, value)
end 

function setInRange(self, value)
	gui_axes_tune.AxesTuneWidgetSetInRange(self.widget, value)
end 

function setOutRange(self, value)
	gui_axes_tune.AxesTuneWidgetSetOutRange(self.widget, value)
end 

function setCurvature(self, index, value)
	gui_axes_tune.AxesTuneWidgetSetCurvature(self.widget, index, value)
end 

function getCurvature(self, index)
	return gui_axes_tune.AxesTuneWidgetGetCurvature(self.widget, index)
end

function drawPrimaryPointer(self, value)
	gui_axes_tune.AxesTuneWidgetDrawPrimaryPointer(self.widget, value)
end 

function getFilterValue(self, valueIn)
	return gui_axes_tune.AxesTuneWidgetGetFilterValue(self.widget, valueIn)
end	