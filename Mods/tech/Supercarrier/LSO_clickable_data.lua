local gettext = require("i_18n")
_ = gettext.translate

pointer_scale_factor = 0.01

function BUTTON(hint_,command_,arg_)
	return  {	
		class 				= {class_type.BTN},
		hint  				= hint_,
		device 				= 0,
		action 				= {command_},
		stop_action 		= {command_},
		arg 				= {arg_},
		arg_value			= {1}, 
		arg_lim 			= {{0,1}},
		use_release_message = {true},
	}
end
elements = {}
elements["Button_Connector_027_R"]		= BUTTON(_("Cut Lights")	,--[[COMMAND INDEX--]] 2,  27 )
elements["Button_Connector_028_R"]		= BUTTON(_("WaveOff Lights"),--[[COMMAND INDEX--]] 3,  28 )
elements["Button_Connector_034_R"]		= BUTTON(_("Deck On")		,--[[COMMAND INDEX--]] 4,  34 )


