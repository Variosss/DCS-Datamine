local cockpit = folder.."../../../Cockpit/Scripts/"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

return {

forceFeedback = {
},
keyCommands = {
-- Right MFCD
{combos = {{key = 'JOY_BTN1'}}, down = iCommandPlaneRightMFD_OSB1 , up = iCommandPlaneRightMFD_OSB1_Off,  name = _('Right MFCD OSB 01'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN2'}}, down = iCommandPlaneRightMFD_OSB2 , up = iCommandPlaneRightMFD_OSB2_Off,  name = _('Right MFCD OSB 02'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN3'}}, down = iCommandPlaneRightMFD_OSB3 , up = iCommandPlaneRightMFD_OSB3_Off,  name = _('Right MFCD OSB 03'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN4'}}, down = iCommandPlaneRightMFD_OSB4 , up = iCommandPlaneRightMFD_OSB4_Off,  name = _('Right MFCD OSB 04'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN5'}}, down = iCommandPlaneRightMFD_OSB5 , up = iCommandPlaneRightMFD_OSB5_Off,  name = _('Right MFCD OSB 05'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN6'}}, down = iCommandPlaneRightMFD_OSB6 , up = iCommandPlaneRightMFD_OSB6_Off,  name = _('Right MFCD OSB 06'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN7'}}, down = iCommandPlaneRightMFD_OSB7 , up = iCommandPlaneRightMFD_OSB7_Off,  name = _('Right MFCD OSB 07'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN8'}}, down = iCommandPlaneRightMFD_OSB8 , up = iCommandPlaneRightMFD_OSB8_Off,  name = _('Right MFCD OSB 08'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN9'}}, down = iCommandPlaneRightMFD_OSB9 , up = iCommandPlaneRightMFD_OSB9_Off,  name = _('Right MFCD OSB 09'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN10'}}, down = iCommandPlaneRightMFD_OSB10, up = iCommandPlaneRightMFD_OSB10_Off, name = _('Right MFCD OSB 10'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN11'}}, down = iCommandPlaneRightMFD_OSB11, up = iCommandPlaneRightMFD_OSB11_Off, name = _('Right MFCD OSB 11'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN12'}}, down = iCommandPlaneRightMFD_OSB12, up = iCommandPlaneRightMFD_OSB12_Off, name = _('Right MFCD OSB 12'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN13'}}, down = iCommandPlaneRightMFD_OSB13, up = iCommandPlaneRightMFD_OSB13_Off, name = _('Right MFCD OSB 13'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN14'}}, down = iCommandPlaneRightMFD_OSB14, up = iCommandPlaneRightMFD_OSB14_Off, name = _('Right MFCD OSB 14'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN15'}}, down = iCommandPlaneRightMFD_OSB15, up = iCommandPlaneRightMFD_OSB15_Off, name = _('Right MFCD OSB 15'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN16'}}, down = iCommandPlaneRightMFD_OSB16, up = iCommandPlaneRightMFD_OSB16_Off, name = _('Right MFCD OSB 16'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN17'}}, down = iCommandPlaneRightMFD_OSB17, up = iCommandPlaneRightMFD_OSB17_Off, name = _('Right MFCD OSB 17'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN18'}}, down = iCommandPlaneRightMFD_OSB18, up = iCommandPlaneRightMFD_OSB18_Off, name = _('Right MFCD OSB 18'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN19'}}, down = iCommandPlaneRightMFD_OSB19, up = iCommandPlaneRightMFD_OSB19_Off, name = _('Right MFCD OSB 19'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN20'}}, down = iCommandPlaneRightMFD_OSB20, up = iCommandPlaneRightMFD_OSB20_Off, name = _('Right MFCD OSB 20'), category = _('Right MFCD')},


{combos = {{key = 'JOY_BTN27'}}, down = iCommandPlaneRightMFD_ADJ_Increase, up = iCommandPlaneRightMFD_ADJ_Stop, name = _('Right MFCD ADJ Increase'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN28'}}, down = iCommandPlaneRightMFD_ADJ_Decrease, up = iCommandPlaneRightMFD_ADJ_Stop, name = _('Right MFCD ADJ Decrease'), category = _('Right MFCD')},
{down = iCommandPlaneRightMFD_DSP_Increase, up = iCommandPlaneRightMFD_DSP_Stop, name = _('Right MFCD DSP Increase'), category = _('Right MFCD')},
{down = iCommandPlaneRightMFD_DSP_Decrease, up = iCommandPlaneRightMFD_DSP_Stop, name = _('Right MFCD DSP Decrease'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN25'}}, down = iCommandPlaneRightMFD_BRT_Increase, up = iCommandPlaneRightMFD_BRT_Stop, name = _('Right MFCD BRT Increase'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN26'}}, down = iCommandPlaneRightMFD_BRT_Decrease, up = iCommandPlaneRightMFD_BRT_Stop, name = _('Right MFCD BRT Decrease'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN23'}}, down = iCommandPlaneRightMFD_CON_Increase, up = iCommandPlaneRightMFD_CON_Stop, name = _('Right MFCD CON Increase'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN24'}}, down = iCommandPlaneRightMFD_CON_Decrease, up = iCommandPlaneRightMFD_CON_Stop, name = _('Right MFCD CON Decrease'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN21'}}, down = iCommandPlaneRightMFD_SYM_Up	  	 , up = iCommandPlaneRightMFD_SYM_Stop, name = _('Right MFCD SYM Increase'), category = _('Right MFCD')},
{combos = {{key = 'JOY_BTN22'}}, down = iCommandPlaneRightMFD_SYM_Dn	  	 , up = iCommandPlaneRightMFD_SYM_Stop, name = _('Right MFCD SYM Decrease'), category = _('Right MFCD')},
	
},

axisCommands = {
},
}
