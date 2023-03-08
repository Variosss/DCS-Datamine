-- Datalink
local gettext = require("i_18n")
_ = gettext.translate

device_timer_dt = 0.1
flash_timing_interval = 0.25

TELECODE_FAILURE = 0
Damage = {{Failure = TELECODE_FAILURE, Failure_name = "TELECODE_FAILURE", Failure_editor_name = _("Telecode failure"), Element = 55}}

need_to_be_closed = true -- lua_state  will be closed in post_initialize()
