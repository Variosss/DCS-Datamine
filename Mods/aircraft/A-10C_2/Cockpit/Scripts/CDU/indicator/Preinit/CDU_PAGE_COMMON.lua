dofile(LockOn_Options.common_script_path.."elements_defs.lua")

HorizontalSize	= 0.0041
VerticalSize	= HorizontalSize
VerticalSpacing = 0.0015

txtDBG1					= CreateElement "ceStringPoly"
txtDBG1.name			= "txtDBG1"
txtDBG1.material		= "font_CDU"
txtDBG1.init_pos		= {0.0, 0.0, 0.0}
txtDBG1.alignment		= "CenterCenter"
txtDBG1.value			= "123    890  3456    12 4\n                        \nAAAAAA        AAAAA A AA\nA     AAAAAAAAAAA     AA\nAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAA\nAAAAAAAAAAAAAAAAAAAAAAAA\n[AA            ]        \n"
txtDBG1.stringdefs		= {VerticalSize, HorizontalSize, 0.0, VerticalSpacing}
Add(txtDBG1)
