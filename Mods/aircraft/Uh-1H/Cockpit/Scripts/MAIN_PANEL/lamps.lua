function create_default_lamp(arg_, controller_) 
	local _lamp	= CreateGauge()
	_lamp.arg_number = arg_
	_lamp.input	= {0.0, 1.0}
	_lamp.output = {0.0, 1.0}
	_lamp.controller = controller_
	return _lamp
end

lamp_ENGINE_OIL_PRESS = create_default_lamp(91, controllers.ENGINE_OIL_PRESS)
lamp_ENGINE_ICING     = create_default_lamp(92, controllers.ENGINE_ICING)
lamp_ENGINE_ICE_JET   = create_default_lamp(93, controllers.ENGINE_ICE_JET)
lamp_ENGINE_CHIP_DET  = create_default_lamp(94, controllers.ENGINE_CHIP_DET)
lamp_LEFT_FUEL_BOOST  = create_default_lamp(95, controllers.LEFT_FUEL_BOOST)
lamp_RIGHT_FUEL_BOOST = create_default_lamp(96, controllers.RIGHT_FUEL_BOOST)
lamp_ENG_FUEL_PUMP    = create_default_lamp(97, controllers.ENG_FUEL_PUMP)
lamp_20_MINUTE        = create_default_lamp(98, controllers.lamp20_MINUTE)
lamp_FUEL_FILTER      = create_default_lamp(99, controllers.FUEL_FILTER)
lamp_GOV_EMERG        = create_default_lamp(100, controllers.GOV_EMERG)
lamp_AUX_FUEL_LOW     = create_default_lamp(101, controllers.AUX_FUEL_LOW)
lamp_XMSN_OIL_PRESS   = create_default_lamp(102, controllers.XMSN_OIL_PRESS)
lamp_XMSN_OIL_HOT     = create_default_lamp(103, controllers.XMSN_OIL_HOT)
lamp_HYD_PRESSURE     = create_default_lamp(104, controllers.HYD_PRESSURE)
lamp_ENGINE_INLET_AIR = create_default_lamp(105, controllers.ENGINE_INLET_AIR)
lamp_INST_INVERTER    = create_default_lamp(106, controllers.INST_INVERTER)
lamp_DC_GENERATOR     = create_default_lamp(107, controllers.DC_GENERATOR)
lamp_EXTERNAL_POWER   = create_default_lamp(108, controllers.EXTERNAL_POWER)
lamp_CHIP_DETECTOR    = create_default_lamp(109, controllers.CHIP_DETECTOR)
lamp_IFF              = create_default_lamp(110, controllers.IFF)
lamp_ARMED            = create_default_lamp(254, controllers.ARMED)
lamp_SAFE             = create_default_lamp(255, controllers.SAFE)
lamp_FIRE             = create_default_lamp(275, controllers.FIRE)
lamp_LOW_RPM          = create_default_lamp(276, controllers.LOW_RPM)
lamp_MASTER           = create_default_lamp(277, controllers.MASTER_CAUTION)

lamp_IFF_REPLY 		  = create_default_lamp(76, controllers.IFF_REPLY)
lamp_IFF_TEST 		  = create_default_lamp(77, controllers.IFF_TEST)
