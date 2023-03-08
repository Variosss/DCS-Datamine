-- UV-26 CMD control panel
local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.125

ElecConsumerParamsLight = {0.5, true}

ripple_quantities = {
{0, 99999},
{1, 1},
{2, 2},
{3, 3},
{4, 4},
{5, 12},
{6, 6},
{7, 15},
{8, 8}
}

init_ripple_quantity_program = 1

num_in_burst = {
{1, 1},
{2, 2},
{3, 3},
{4, 4},
{5, 5},
{6, 6},
{7, 7},
{8, 8}
}

init_num_in_burst_program = 1

ripple_intervals = {
{0, 0.125},
{1, 1.0},
{2, 2.0},
{3, 3.0},
{4, 4.0},
{5, 5.0},
{6, 6.0},
{7, 0.25},
{8, 8.0},
{9, 0.5}
}

init_ripple_intervals_program = 0

init_mode_of_indication = 0
init_current_board = 0

UV26_LEFT_DISPENSER_FAILURE = 0
UV26_RIGHT_DISPENSER_FAILURE = 1
Damage = {	{Failure = UV26_LEFT_DISPENSER_FAILURE, Failure_name = "UV26_LEFT_DISPENSER_FAILURE", Failure_editor_name = _("UV-26 left dispenser failure"), Element = 23}, 
			{Failure = UV26_RIGHT_DISPENSER_FAILURE, Failure_name = "UV26_RIGHT_DISPENSER_FAILURE", Failure_editor_name = _("UV-26 right dispenser failure"), Element = 24}}
		  
need_to_be_closed = true -- lua_state  will be closed in post_initialize()
