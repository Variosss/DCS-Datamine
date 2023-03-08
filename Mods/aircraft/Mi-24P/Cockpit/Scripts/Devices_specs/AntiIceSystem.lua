device_timer_dt	= 0.05

AntiIceCurrent = {valmin = 0, valmax = 50, T1 = 0.9, T2 = 0.316, wmax = 0, bias = {{valmin = 0, valmax = 8, bias = 0.5}}}

-- ElecConsumerGlazingHeaterParams settings:
ElecConsumerGlazingHeaterParams = 
{
	7.3, 			-- load DC current ECS, [A]
	true,
	100.0,			-- AC voltage value after which the Glazing Heater is off, [V]
	190.0, 			-- AC voltage value after which the Glazing Heater is on, [V]
	208.0			-- nominal AC voltage value Glazing Heater, [V]
}

capacity_glass = 900.0
glass_thermal_conductivity = 0.39 -- коэф-т теплопродности стекла [Вт/(м·К)]
glass_surface_area = 2490.0/10000.0 -- [m2]
glazing_thickness = 0.05 -- [m]
power_consumption_heated_low = 1120.0 -- [Wt]
power_consumption_heated_hight = 1660.0 -- [Wt]
coolingCoeff = 1

need_to_be_closed = true -- close lua state after initialization
