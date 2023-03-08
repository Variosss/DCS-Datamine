
device_timer_dt	= 0.2
			
-- messages[ID] = {sys no, with callsign, times to repeat, time to play} -- description (optional)
messages = {}
messages[1]   = {wMsgA10_VMU_Alert, 			false, 1, 1.0} -- ALERT
messages[2]   = {wMsgA10_VMU_Altitude, 			false, 1, 1.0} -- ALTITUDE
messages[3]   = {wMsgA10_VMU_WarningAutopilot, 	false, 1, 1.0} -- WARNING AUTOPILOT
messages[4]   = {wMsgA10_VMU_Ceiling, 			false, 1, 1.0} -- CEILING
messages[5]   = {wMsgA10_VMU_IFF, 				false, 1, 1.0} -- IFF
messages[6]   = {wMsgA10_VMU_Obstacle, 			false, 1, 1.0} -- OBSTACLE
messages[7]   = {wMsgA10_VMU_Pullup, 			false, 1, 1.0} -- PULL UP
messages[8]   = {wMsgA10_VMU_Speedbreak, 		false, 1, 1.0} -- SPEEDBRAKE

need_to_be_closed = true -- close lua state after initialization
