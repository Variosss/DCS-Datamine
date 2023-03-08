
forward_tank_fuel_level_bias		= {{math.rad(0.0), math.rad(360.0), math.rad(1.0)}} -- radians
forward_tank_fuel_level_counter_K1	= 1.1
forward_tank_fuel_level_counter_K2	= 0.45
forward_tank_fuel_level_min		= math.rad(0.0)
forward_tank_fuel_level_max		= math.rad(360.0)

rear_tank_fuel_level_bias		= {{math.rad(0.0), math.rad(360.0), math.rad(1.0)}} -- radians
rear_tank_fuel_level_counter_K1		= 1.1
rear_tank_fuel_level_counter_K2		= 0.45
rear_tank_fuel_level_min		= math.rad(0.0)
rear_tank_fuel_level_max		= math.rad(360.0)

FuelMeterIndicator = {isLagElement = true, valmin = 0, valmax = 1, T1 = 1.3}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()