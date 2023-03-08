
device_timer_dt			= 0.2
pause_play_time			= 0.01

RI65_messages =
{
	path = "Aircrafts/MI-24P/Cockpit/RI65/", 
	check_msg = { msg = "device RI-65 is without fail", duration = 4.4, prioritity = 13 }, -- RI-65 ready

	messages =
	{		
		{ msg = "board", duration = 1.4 },
		{ msg = "0-end", duration = 1.0 },
		{ msg = "1-end", duration = 1.0 },
		{ msg = "2-end", duration = 1.0 },
		{ msg = "3-end", duration = 1.0 },
		{ msg = "4-end", duration = 1.0 },
		{ msg = "5-end", duration = 1.0 },
		{ msg = "6-end", duration = 1.0 },
		{ msg = "7-end", duration = 1.0 },
		{ msg = "8-end", duration = 1.0 },
		{ msg = "9-end", duration = 1.0 },
		{ msg = "left engine fire", duration = 4.4,	prioritity = 12, extra_message = 1 },							-- Fire in the left engine
		{ msg = "right engine fire", duration = 4.4, prioritity = 11, extra_message = 1 },	        				-- Fire in the right engine
		{ msg = "main transmission fire", duration = 4.4, prioritity = 10, extra_message = 1 },          			-- Fire in the main reductor
		{ msg = "apu fire", duration = 4.4,	prioritity = 9, extra_message = 1 },	        						-- Fire in the APU
		{ msg = "left engine vibration", duration = 4.4, prioritity = 8 },         									-- dangerous vibration of the left engine
		{ msg = "right engine vibration", duration = 4.4, prioritity = 8 },	        								-- dangerous vibration of the right engine
		{ msg = "main hydraulics failure", duration = 4.4,	prioritity = 7 },          								-- failure of the main hydraulic system
		{ msg = "common hydro", duration = 4.4,	prioritity = 6 },	        										-- failure of the auxiliary hydraulic system
		{ msg = "emergency fuel", duration = 4.4, prioritity = 5 },	        										-- emergency fuel balance
		{ msg = "device RI-65 is without fail", duration = 4.4, prioritity = 3 },	        						-- Low oil pressure in the main reductor
		{ msg = "pump the feeder fuel tank failure", duration = 4.4, prioritity = 3 },	    						-- feedtank pump failed
		{ msg = "lower gear", duration = 4.4, prioritity = 0 },	        											-- lower gear		
		{ msg = "generator failure", duration = 4.4, prioritity = 0 },	        									-- generator failure		
	},	
}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
