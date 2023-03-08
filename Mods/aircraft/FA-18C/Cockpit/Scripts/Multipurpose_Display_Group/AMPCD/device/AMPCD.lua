dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/device/MDG_device_common.lua") -- MDG IDs

--local gettext = require("i_18n")
--_ = gettext.translate

device_timer_dt	= 0.05

selfID = MDG_SELF_IDS.HI

-- TODO: to set actual consumption
--ElecConsumerParams = {200.0, true, 100.9, 103.1, 115}

need_to_be_closed = true -- close lua state after initialization
