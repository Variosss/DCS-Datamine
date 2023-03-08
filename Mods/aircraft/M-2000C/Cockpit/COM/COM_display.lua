local my_path = LockOn_Options.script_path.."COM/"
dofile(my_path.."COM_definitions.lua")

local	text_COM_UHF2					= CreateElement "ceStringPoly"
		text_COM_UHF2.name				= "text_COM_UHF2"
		text_COM_UHF2.material			= COM_gauge_font
		text_COM_UHF2.init_pos			= {0.97,0.32}
		text_COM_UHF2.alignment			= "RightCenter"
		text_COM_UHF2.formats			= {"%03.2f"}
		text_COM_UHF2.stringdefs		= {0.0056,0.0056}
		---text_COM_UHF2.value 			= "********"
		text_COM_UHF2.controllers 		= {{"COM_VIS"}, {"COM_UHF2",0}}
Add_COM_Element(text_COM_UHF2)

local	text_COM_UHF1					= CreateElement "ceStringPoly"
		text_COM_UHF1.name				= "text_COM_UHF1"
		text_COM_UHF1.material			= COM_gauge_font
		text_COM_UHF1.init_pos			= {0.97,-0.32}
		text_COM_UHF1.alignment			= "RightCenter"
		text_COM_UHF1.formats			= {"%03.2f"}
		text_COM_UHF1.stringdefs		= {0.0056,0.0056}
		---text_COM_UHF1.controllers 		= {{"COM_VIS"}, {"COM_VHF",0}}
		text_COM_UHF1.controllers 		= {{"COM_VIS"}, {"COM_UHF1",0}}
Add_COM_Element(text_COM_UHF1)