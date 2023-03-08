function create_default_lamp(arg_, controller_) 
	local _lamp	= CreateGauge()
	_lamp.arg_number = arg_
	_lamp.input	= {0.0, 1.0}
	_lamp.output = {0.0, 1.0}
	_lamp.controller = controller_
	return _lamp
end

--lamp_ENGINE_OIL_PRESS = create_default_lamp(91, controllers.ENGINE_OIL_PRESS)
