-- Timer update time
device_timer_dt = 0.025

ElecConsumerParamsLight = {0.5, true}

num_in_burst = 2
ripple_interval = 0.075
ripple_quantity = 1
dispence_interval = 2.3

LEFT_DISPENSER_FAILURE = 0
RIGHT_DISPENSER_FAILURE = 1

Damage = {	{Failure = LEFT_DISPENSER_FAILURE, Element = 23}, 
			{Failure = RIGHT_DISPENSER_FAILURE, Element = 24}}
			
			
need_to_be_closed = true -- lua_state  will be closed in post_initialize()
