dofile(LockOn_Options.script_path.."ARC_210\\indicator\\arc_210_useful_definitions.lua")

--AddBackground()

AddRT()

AddTextLabel("EXIT", "LeftTop", 0, max_pixels_count_y, predefined_fonts[1], "font_ARC210_small")
add_static_hint(1, "Exit Menus")

AddTextLabel("LIGHT\nTEST", "LeftCenter", 0, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
AddTextLabel("SWITCH\nTEST MODE", "CenterCenter", 80, max_pixels_count_y/2, predefined_fonts[1], "font_ARC210_small")
AddTextLabel(" RT:  984-1528-038", "LeftBottom", 0, 10, predefined_fonts[1], "font_ARC210_small")
--AddTextLabel("MORE", "LeftBottom", 0, 0, predefined_fonts[1], "font_ARC210_small")

last_switch_label					= CreateElement "ceStringPoly"
last_switch_label.name				= "last_switch_label"
last_switch_label.material			= "font_ARC210_small"
last_switch_label.alignment			= "LeftBottom"
last_switch_label.formats			= {"RCU:  984-1541-007", "TOD SEND", "TOD RECV", "GPS", "RT SELECT", "SQUELCH OFF", "SQUELCH ON",
										"MENU TIME", "AM/FM", "XMT/RCV SEND", "OFFSET RCV", "ENTER", "ECCM MASTER MODE", "ECCM MODE",
										"PRESET MODE", "MANUAL MODE", "MARITIME MODE", "243 GUARD MODE", "121 GUARD MODE",
										 "FREQ KNOB 5 #00", "FREQ KNOB 5 #25", "FREQ KNOB 5 #50", "FREQ KNOB 5 #75",
										 "FREQ KNOB 4 #0", "FREQ KNOB 4 #1", "FREQ KNOB 4 #2", "FREQ KNOB 4 #3", "FREQ KNOB 4 #4",
										 "FREQ KNOB 4 #5", "FREQ KNOB 4 #6", "FREQ KNOB 4 #7", "FREQ KNOB 4 #8", "FREQ KNOB 4 #9",
										 "FREQ KNOB 3 #0", "FREQ KNOB 3 #1", "FREQ KNOB 3 #2", "FREQ KNOB 3 #3", "FREQ KNOB 3 #4",
										 "FREQ KNOB 3 #5", "FREQ KNOB 3 #6", "FREQ KNOB 3 #7", "FREQ KNOB 3 #8", "FREQ KNOB 3 #9",
										 "FREQ KNOB 2 #0", "FREQ KNOB 2 #1", "FREQ KNOB 2 #2", "FREQ KNOB 2 #3", "FREQ KNOB 2 #4",
										 "FREQ KNOB 2 #5", "FREQ KNOB 2 #6", "FREQ KNOB 2 #7", "FREQ KNOB 2 #8", "FREQ KNOB 2 #9",
 										 "FREQ KNOB 1 #0", "FREQ KNOB 1 #1", "FREQ KNOB 1 #2", "FREQ KNOB 1 #3",
 										 "CHANNEL INCREMENT", "CHANNEL DECREMENT", "OFF MODE", "TR+G MODE",
 										 "TR MODE", "ADF MODE", "CHG PRST MODE", "TEST", "ZEROIZE MODE"}
last_switch_label.init_pos			= {0, 0}
last_switch_label.stringdefs		= predefined_fonts[1]
last_switch_label.controllers		= {{"temp_setting_label"}}
SetLowerLeftCornerOrigin(last_switch_label)
Add(last_switch_label)
use_mipfilter(last_switch_label)

