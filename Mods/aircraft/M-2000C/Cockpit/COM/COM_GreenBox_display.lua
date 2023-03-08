local my_path = LockOn_Options.script_path.."COM/"
dofile(my_path.."COM_definitions.lua")


local	text_COM_VHF					= CreateElement "ceStringPoly"
		text_COM_VHF.name				= "text_COM_VHF"
		text_COM_VHF.material			= COM_greenbox_font
		text_COM_VHF.init_pos			= {1,0}
		text_COM_VHF.alignment			= "RightCenter"
		text_COM_VHF.formats			= {"%03.2f"}
		text_COM_VHF.stringdefs			= {0.0058,0.0058} ---- edit ---- 0.006 0.006
		text_COM_VHF.controllers 		= {{"COM_VIS"}, {"COM_VHF",0}}
Add_COM_Element(text_COM_VHF)

