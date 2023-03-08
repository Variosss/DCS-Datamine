use_native_axis  = true
use_digital_zoom = false -- Set to false as digital zoom results in unacceptably low picture quality

keyboard_slew_magnifier = 5
use_synthetic_IR_effect = true -- false
			
ir_sharpness    			= 0.0002 -- sharpness of TGP IR image, Float - 0...1.

ir_levels_count 			= 9      -- TGP IR image levels count, Int.
ir_gains_count  			= 9	     -- TGP IR image gains count, Int.

-- initial IR image gain value, Int - 0...9. Used in manual gain control.
ir_init_gain    			= 3
-- initial IR image level value, Int - 0...9. Used in manual level control.
ir_init_level   			= 4

-- IR image automatic gain values, Float - 0...9. Used in ALG (Automatic Level/Gain control).
ir_auto_gain_day			= 3
ir_auto_gain_night			= 3
					 
-- IR image automatic level values, Float - 0...9. Used in ALG (Automatic Level/Gain control).
ir_auto_level_day			= 4
ir_auto_level_night			= 4

