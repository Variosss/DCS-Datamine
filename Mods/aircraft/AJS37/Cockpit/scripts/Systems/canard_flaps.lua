local flaps_settings = GetSelf()
local dev = GetSelf()

local update_time_step = 0.05
make_default_activity(update_time_step)

local sensor_data = get_base_data()

print("SETTING CANARD FLAPS SYSTEM SETTINGS:")

local FLAPS_RETRACTED_ANGLE = -4 -- -7 -4 or 0
local FLAPS_EXTENDED_ANGLE = 30 -- 30?

local flapsretr_param = get_param_handle("FLAPS_RETRACTED_ANGLE")
local flapsext_param = get_param_handle("FLAPS_EXTENDED_ANGLE")
flapsretr_param:set(FLAPS_RETRACTED_ANGLE)
flapsext_param:set(FLAPS_EXTENDED_ANGLE)
