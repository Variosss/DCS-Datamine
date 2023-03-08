local my_path = LockOn_Options.script_path.."FUEL/"
dofile(my_path.."FUEL_definitions.lua")

txt_fuel_g					= CreateElement "ceStringPoly"
txt_fuel_g.name				= "txt_fuel_g"
txt_fuel_g.material			= fuel_gauge_font
txt_fuel_g.init_pos			= {0.8,0.0}
txt_fuel_g.alignment		= "RightCenter"
txt_fuel_g.formats			= {"%03.f"}
txt_fuel_g.stringdefs		=  {0.009,0.009}
txt_fuel_g.controllers 		= {{"visFUEL_USE"}, {"txtFUEL_USE",0}}
Add_FUEL_Element(txt_fuel_g)
