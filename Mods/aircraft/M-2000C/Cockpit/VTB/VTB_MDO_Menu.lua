-- MANUAL RADAR TARGET MENU

-- LEFT
--[[
local	MDO_DT_Label				= CreateElement "ceStringPoly"
		MDO_DT_Label.name			= "MDO_DT_Label"
		MDO_DT_Label.material		= "vtb_green"
		MDO_DT_Label.init_pos		= {-0.9, 0.35, 0.0}
		MDO_DT_Label.alignment		= "CenterCenter"
		MDO_DT_Label.stringdefs		= vtb_font_size_default
		MDO_DT_Label.value			= "DT"
		MDO_DT_Label.controllers	= {{"VTB_MDO_Mode"}}
Add_VTB_Element(MDO_DT_Label)
--]]

--local	MDO_DT_Label 				= create_vtb_stt_textured_box( 20, 489, 68, 519)
--		MDO_DT_Label.name			= "MDO_DT_Label"
--		MDO_DT_Label.init_pos		= {-0.9, 0.35, 0.0}
--		MDO_DT_Label.controllers  	= {{"VTB_MDO_Mode"}}
--		MDO_DT_Label.additive_alpha	= true
--Add_VTB_Element(MDO_DT_Label)
--
--local	MDO_DT_Value				= CreateElement "ceStringPoly"
--		MDO_DT_Value.name			= "MDO_DT_Value"
--		MDO_DT_Value.material		= "vtb_green"
--		MDO_DT_Value.init_pos		= {-0.9, 0.25, 0.0}
--		MDO_DT_Value.alignment		= "CenterCenter"
--		MDO_DT_Value.stringdefs		= vtb_font_size_default
--		MDO_DT_Value.formats		= {"%03d"}
--		MDO_DT_Value.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_DeltaTime"}}
--Add_VTB_Element(MDO_DT_Value)
--
--local	MDO_N_Label					= CreateElement "ceStringPoly"
--		MDO_N_Label.name			= "MDO_N_Label"
--		MDO_N_Label.material		= "vtb_green"
--		MDO_N_Label.init_pos		= {-0.9, -0.05, 0.0}
--		MDO_N_Label.alignment		= "CenterCenter"
--		MDO_N_Label.stringdefs		= vtb_font_size_default
--		MDO_N_Label.value			= "N"
--		MDO_N_Label.controllers		= {{"VTB_MDO_Mode"}}
--Add_VTB_Element(MDO_N_Label)
--
--local	MDO_N_Value					= CreateElement "ceStringPoly"
--		MDO_N_Value.name			= "MDO_N_Value"
--		MDO_N_Value.material		= "vtb_green"
--		MDO_N_Value.init_pos		= {-0.9, -0.15, 0.0}
--		MDO_N_Value.alignment		= "CenterCenter"
--		MDO_N_Value.stringdefs		= vtb_font_size_default
--		MDO_N_Value.formats			= {"%02d"}
--		MDO_N_Value.controllers		= {{"VTB_MDO_Mode"}, {"VTB_MDO_BE_Index"}}
--Add_VTB_Element(MDO_N_Value)
--
--local	MDO_P_Label 				= create_vtb_stt_textured_box( 21, 523, 41, 556)
--		MDO_P_Label.name			= "MDO_DT_Label"
--		MDO_P_Label.init_pos		= {-0.9, -0.35, 0.0}
--		MDO_P_Label.controllers  	= {{"VTB_MDO_Mode"}}
--		MDO_P_Label.additive_alpha	= true
--Add_VTB_Element(MDO_P_Label)
--
--local	MDO_P_Value_C				= CreateElement "ceStringPoly"
--		MDO_P_Value_C.name			= "MDO_P_Value_C"
--		MDO_P_Value_C.material		= "vtb_green"
--		MDO_P_Value_C.init_pos		= {-0.9, -0.45, 0.0}
--		MDO_P_Value_C.alignment		= "CenterCenter"
--		MDO_P_Value_C.stringdefs	= vtb_font_size_default
--		MDO_P_Value_C.formats		= {"%03d"}
--		MDO_P_Value_C.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_Rho_CValue"}}
--Add_VTB_Element(MDO_P_Value_C)
--
--local	MDO_P_Value_N				= CreateElement "ceStringPoly"
--		MDO_P_Value_N.name			= "MDO_P_Value_N"
--		MDO_P_Value_N.material		= "vtb_green"
--		MDO_P_Value_N.init_pos		= {-0.9, -0.55, 0.0}
--		MDO_P_Value_N.alignment		= "CenterCenter"
--		MDO_P_Value_N.stringdefs	= vtb_font_size_default
--		MDO_P_Value_N.formats		= {"%03d"}
--		MDO_P_Value_N.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_Rho_NValue"}}
--Add_VTB_Element(MDO_P_Value_N)
--
--local	MDO_O_Label 				= create_vtb_stt_textured_box( 44, 522, 74, 557)
--		MDO_O_Label.name			= "MDO_O_Label"
--		MDO_O_Label.init_pos		= {-0.9, -0.75, 0.0}
--		MDO_O_Label.controllers  	= {{"VTB_MDO_Mode"}}
--		MDO_O_Label.additive_alpha	= true
--Add_VTB_Element(MDO_O_Label)
--
--local	MDO_O_Value_C				= CreateElement "ceStringPoly"
--		MDO_O_Value_C.name			= "MDO_O_Value_C"
--		MDO_O_Value_C.material		= "vtb_green"
--		MDO_O_Value_C.init_pos		= {-0.9, -0.85, 0.0}
--		MDO_O_Value_C.alignment		= "CenterCenter"
--		MDO_O_Value_C.stringdefs	= vtb_font_size_default
--		MDO_O_Value_C.formats		= {"%03d"}
--		MDO_O_Value_C.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_Theta_CValue"}}
--Add_VTB_Element(MDO_O_Value_C)
--
--local	MDO_O_Value_N				= CreateElement "ceStringPoly"
--		MDO_O_Value_N.name			= "MDO_O_Value_N"
--		MDO_O_Value_N.material		= "vtb_green"
--		MDO_O_Value_N.init_pos		= {-0.9, -0.95, 0.0}
--		MDO_O_Value_N.alignment		= "CenterCenter"
--		MDO_O_Value_N.stringdefs	= vtb_font_size_default
--		MDO_O_Value_N.formats		= {"%03d"}
--		MDO_O_Value_N.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_Theta_NValue"}}
--Add_VTB_Element(MDO_O_Value_N)
--
---- RIGHT
--local	MDO_C_Label					= CreateElement "ceStringPoly"
--		MDO_C_Label.name			= "MDO_C_Label"
--		MDO_C_Label.material		= "vtb_green"
--		MDO_C_Label.init_pos		= {0.85, 0.35, 0.0}
--		MDO_C_Label.alignment		= "CenterCenter"
--		MDO_C_Label.stringdefs		= vtb_font_size_default
--		MDO_C_Label.value			= "C"
--		MDO_C_Label.controllers		= {{"VTB_MDO_Mode"}}
--Add_VTB_Element(MDO_C_Label)
--
--local	MDO_C_Value_C				= CreateElement "ceStringPoly"
--		MDO_C_Value_C.name			= "MDO_C_Value_C"
--		MDO_C_Value_C.material		= "vtb_green"
--		MDO_C_Value_C.init_pos		= {0.85, 0.25, 0.0}
--		MDO_C_Value_C.alignment		= "CenterCenter"
--		MDO_C_Value_C.stringdefs	= vtb_font_size_default
--		MDO_C_Value_C.formats		= {"%03d"}
--		MDO_C_Value_C.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_C_CValue"}}
--Add_VTB_Element(MDO_C_Value_C)
--
--local	MDO_C_Value_N				= CreateElement "ceStringPoly"
--		MDO_C_Value_N.name			= "MDO_C_Value_N"
--		MDO_C_Value_N.material		= "vtb_green"
--		MDO_C_Value_N.init_pos		= {0.85, 0.15, 0.0}
--		MDO_C_Value_N.alignment		= "CenterCenter"
--		MDO_C_Value_N.stringdefs	= vtb_font_size_default
--		MDO_C_Value_N.formats		= {"%03d"}
--		MDO_C_Value_N.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_C_NValue"}}
--Add_VTB_Element(MDO_C_Value_N)
--
--local	MDO_Z_Label					= CreateElement "ceStringPoly"
--		MDO_Z_Label.name			= "MDO_Z_Label"
--		MDO_Z_Label.material		= "vtb_green"
--		MDO_Z_Label.init_pos		= {0.85, -0.05, 0.0}
--		MDO_Z_Label.alignment		= "CenterCenter"
--		MDO_Z_Label.stringdefs		= vtb_font_size_default
--		MDO_Z_Label.value			= "Z"
--		MDO_Z_Label.controllers		= {{"VTB_MDO_Mode"}}
--Add_VTB_Element(MDO_Z_Label)
--
--local	MDO_Z_Value_C				= CreateElement "ceStringPoly"
--		MDO_Z_Value_C.name			= "MDO_Z_Value_C"
--		MDO_Z_Value_C.material		= "vtb_green"
--		MDO_Z_Value_C.init_pos		= {0.85, -0.15, 0.0}
--		MDO_Z_Value_C.alignment		= "CenterCenter"
--		MDO_Z_Value_C.stringdefs	= vtb_font_size_default
--		MDO_Z_Value_C.formats		= {"%03d"}
--		MDO_Z_Value_C.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_Z_CValue"}}
--Add_VTB_Element(MDO_Z_Value_C)
--
--local	MDO_Z_Value_N				= CreateElement "ceStringPoly"
--		MDO_Z_Value_N.name			= "MDO_Z_Value_N"
--		MDO_Z_Value_N.material		= "vtb_green"
--		MDO_Z_Value_N.init_pos		= {0.85, -0.25, 0.0}
--		MDO_Z_Value_N.alignment		= "CenterCenter"
--		MDO_Z_Value_N.stringdefs	= vtb_font_size_default
--		MDO_Z_Value_N.formats		= {"%03d"}
--		MDO_Z_Value_N.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_Z_NValue"}}
--Add_VTB_Element(MDO_Z_Value_N)
--
--local	MDO_M_Label					= CreateElement "ceStringPoly"
--		MDO_M_Label.name			= "MDO_M_Label"
--		MDO_M_Label.material		= "vtb_green"
--		MDO_M_Label.init_pos		= {0.9, -0.45, 0.0}
--		MDO_M_Label.alignment		= "CenterCenter"
--		MDO_M_Label.stringdefs		= vtb_font_size_default
--		MDO_M_Label.value			= "M"
--		MDO_M_Label.controllers		= {{"VTB_MDO_Mode"}}
--Add_VTB_Element(MDO_M_Label)
--
--local	MDO_M_Value_C				= CreateElement "ceStringPoly"
--		MDO_M_Value_C.name			= "MDO_M_Value_C"
--		MDO_M_Value_C.material		= "vtb_green"
--		MDO_M_Value_C.init_pos		= {0.85, -0.55, 0.0}
--		MDO_M_Value_C.alignment		= "CenterCenter"
--		MDO_M_Value_C.stringdefs	= vtb_font_size_default
--		MDO_M_Value_C.formats		= {"%1.1f"}
--		MDO_M_Value_C.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_M_CValue"}}
--Add_VTB_Element(MDO_M_Value_C)
--
--local	MDO_M_Value_N				= CreateElement "ceStringPoly"
--		MDO_M_Value_N.name			= "MDO_M_Value_N"
--		MDO_M_Value_N.material		= "vtb_green"
--		MDO_M_Value_N.init_pos		= {0.85, -0.65, 0.0}
--		MDO_M_Value_N.alignment		= "CenterCenter"
--		MDO_M_Value_N.stringdefs	= vtb_font_size_default
--		MDO_M_Value_N.formats		= {"%1.1f"}
--		MDO_M_Value_N.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_M_NValue"}}
--Add_VTB_Element(MDO_M_Value_N)
--
--local	MDO_T_Label					= CreateElement "ceStringPoly"
--		MDO_T_Label.name			= "MDO_T_Label"
--		MDO_T_Label.material		= "vtb_green"
--		MDO_T_Label.init_pos		= {0.85, -0.85, 0.0}
--		MDO_T_Label.alignment		= "CenterCenter"
--		MDO_T_Label.stringdefs		= vtb_font_size_default
--		MDO_T_Label.value			= "T"
--		MDO_T_Label.controllers		= {{"VTB_MDO_Mode"}}
--Add_VTB_Element(MDO_T_Label)
--
--local	MDO_T_Value_C				= CreateElement "ceStringPoly"
--		MDO_T_Value_C.name			= "MDO_T_Value_C"
--		MDO_T_Value_C.material		= "vtb_green"
--		MDO_T_Value_C.init_pos		= {0.85, -0.95, 0.0}
--		MDO_T_Value_C.alignment		= "CenterCenter"
--		MDO_T_Value_C.stringdefs	= vtb_font_size_default
--		MDO_T_Value_C.formats		= {"%d.%02d"}
--		MDO_T_Value_C.controllers	= {{"VTB_MDO_Mode"}, {"VTB_MDO_T_CValue"}}
--Add_VTB_Element(MDO_T_Value_C)

