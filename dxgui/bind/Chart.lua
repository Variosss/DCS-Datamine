local base = _G

module('Chart')
mtab = { __index = _M }

local require = base.require

local Factory = 	require('Factory')
local Widget = 		require('Widget')
local gui = 		require('dxgui')

Factory.setBaseClass(_M, Widget)

function new(text)
	return Factory.create(_M, text)
end

function construct(self, text)
	Widget.construct(self, text)
end

function newWidget(self)
	return gui.NewChart()
end

-- values - массив значений
function setValues(self, values)
	gui.ChartSetValues(self.widget, values)
end

function setAnimationEaseValues(self, type)
-- enum AnimationEasingType
-- {
	-- ANIMATION_EASING_NONE = 0,
	-- ANIMATION_EASING_LINEAR,
	-- ANIMATION_EASING_BACK_IN,
	-- ANIMATION_EASING_BACK_OUT,
	-- ANIMATION_EASING_BACK_INOUT,
	-- ANIMATION_EASING_BOUNCE_IN,
	-- ANIMATION_EASING_BOUNCE_OUT,
	-- ANIMATION_EASING_BOUNCE_INOUT,
	-- ANIMATION_EASING_CIRC_IN,
	-- ANIMATION_EASING_CIRC_OUT,
	-- ANIMATION_EASING_CIRC_INOUT,
	-- ANIMATION_EASING_CUBIC_IN,
	-- ANIMATION_EASING_CUBIC_OUT,
	-- ANIMATION_EASING_CUBIC_INOUT,
	-- ANIMATION_EASING_ELASTIC_IN,
	-- ANIMATION_EASING_ELASTIC_OUT,
	-- ANIMATION_EASING_ELASTIC_INOUT,
	-- ANIMATION_EASING_EXPO_IN,
	-- ANIMATION_EASING_EXPO_OUT,
	-- ANIMATION_EASING_EXPO_INOUT,
	-- ANIMATION_EASING_QUAD_IN,
	-- ANIMATION_EASING_QUAD_OUT,
	-- ANIMATION_EASING_QUAD_INOUT,
	-- ANIMATION_EASING_QUART_IN,
	-- ANIMATION_EASING_QUART_OUT,
	-- ANIMATION_EASING_QUART_INOUT,
	-- ANIMATION_EASING_QUINT_IN,
	-- ANIMATION_EASING_QUINT_OUT,
	-- ANIMATION_EASING_QUINT_INOUT,
	-- ANIMATION_EASING_SINE_IN,
	-- ANIMATION_EASING_SINE_OUT,
	-- ANIMATION_EASING_SINE_INOUT = 31,

	-- ANIMATION_EASING_count,
-- };
	gui.ChartSetAnimationEaseValues(self.widget, type)
end