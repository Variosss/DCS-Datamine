device_timer_dt	= 0.02

LEFT_WING_OUT 		= 0
LEFT_WING_CENTER 	= 1
LEFT_WING_IN 		= 2
RIGHT_WING_IN 		= 3
RIGHT_WING_CENTER 	= 4
RIGHT_WING_OUT 		= 5

Damage = {	
	{Failure = LEFT_WING_IN,		Element = 35, Integrity_Treshold = 0.2},
	{Failure = LEFT_WING_CENTER,	Element = 29, Integrity_Treshold = 0.2},
	{Failure = LEFT_WING_OUT,		Element = 23, Integrity_Treshold = 0.2},
	{Failure = RIGHT_WING_IN,		Element = 36, Integrity_Treshold = 0.2},
	{Failure = RIGHT_WING_CENTER,	Element = 30, Integrity_Treshold = 0.2},
	{Failure = RIGHT_WING_OUT,		Element = 24, Integrity_Treshold = 0.2},
}
	
need_to_be_closed = true -- close lua state after initialization 