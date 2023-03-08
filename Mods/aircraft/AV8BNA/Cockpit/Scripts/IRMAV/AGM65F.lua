local gettext = require("i_18n")

use_native_axis  = true

keyboard_slew_magnifier = 5.0
use_synthetic_IR_effect = true
			
ir_sharpness    = 0.0002 -- sharpness of IR image, Float - 0...1.
ir_levels_count = 8      -- IR image levels count, Int.
ir_gains_count  = 8	     -- IR image gains count, Int.
ir_init_gain    = 4		 -- initial IR image gain value, Int - 0...8.
ir_init_level   = 4      -- initial IR image level value, Int - 0...8.

need_to_be_closed = true