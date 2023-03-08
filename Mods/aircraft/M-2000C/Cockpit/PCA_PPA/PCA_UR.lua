local my_path = LockOn_Options.script_path.."PCA_PPA/"
dofile(my_path.."PCA_definitions.lua")

for i = 0, 4 do
	elem					= CreateElement "ceStringPoly"
	elem.name				= "PCA_LCD_1_"..i
	elem.material			= pca_gauge_font
	elem.init_pos			= {-1.018 + 0.408*i,-0.02} --{-1.0065 + 0.414*i,-0.02}
	elem.alignment			= "LeftCenter"
	elem.formats			= {"%s"}
	elem.stringdefs			= pca_font_size_default
	elem.controllers 		= {{"PCA_LCD_CODE",i}}
	Add_PCA_Element(elem)
end

