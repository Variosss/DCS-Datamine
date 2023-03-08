local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt		= 0.2

-- feet!!!
altitudePointer = {isLagElement = true, valmin = -10, valmax = 5100, T1 = 0.214, bias = {{valmin = -10, valmax = 5100, bias = 0.1}}}
flags = {valmin = 0, valmax = 1, dvalue = 20}

elecModeFlag = {valmin = 0, valmax = 1, dvalue = 10}

error_k			= 0.983


ID2163A_FAILURE_TOTAL = 0
--TODO добавить номер элемента для повреждения
Damage = {Failure = ID2163A_FAILURE_TOTAL, Failure_name = "ID2163A_FAILURE_TOTAL", Failure_editor_name = _("Radar altimeter height indicator total failure"), Element = 1, Integrity_Treshold = 0.5, work_time_to_fail_probability = 0.5, work_time_to_fail = 3600*300}

need_to_be_closed = true -- close lua state after initialization 