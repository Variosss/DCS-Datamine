local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.2

initial_brightness	= 255.0

sunshadeFilter = {valmin = 0, valmax = 1, dvalue = 4}

HUD_FAILURE = 0
Damage = {	{Failure = HUD_FAILURE, Failure_name = "HUD_FAILURE", Failure_editor_name = _("HUD failure"), Element = 3, Slope_param = 1}, 
			{Failure = HUD_FAILURE, Failure_name = "HUD_FAILURE", Failure_editor_name = _("HUD failure"), Element = 4, Slope_param = 1}, 
			{Failure = HUD_FAILURE, Failure_name = "HUD_FAILURE", Failure_editor_name = _("HUD failure"), Element = 5, Slope_param = 1}}
		
need_to_be_closed = true -- lua_state  will be closed in post_initialize()