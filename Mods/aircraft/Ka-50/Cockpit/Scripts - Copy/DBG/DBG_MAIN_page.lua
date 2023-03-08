dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetScale(FOV) -- set scale factor modifier (in this case FOV - half of horizontal size)

txt_x_offset = -3.0
txt_y_offset = 0.7
 
txt_x_offset2 = -3.5
txt_y_offset2 = 1.5

--[[
  SetScale(MILLYRADIANS)
	next elements will be scaled in millyrads
  SetScale(METERS)
        next elements will be scaled in meters
  SetScale(FOV)
        and again in FOV parts
--]]

flag_flight_info = false

if flag_flight_info then
	txt_debug_pitch					= CreateElement "ceStringPoly"
	txt_debug_pitch.name			= "txt_debug_pitch"
	txt_debug_pitch.material		= "font_Ka-50_dbg"
	txt_debug_pitch.init_pos		= {txt_x_offset, txt_y_offset - 1.0, 0}
	txt_debug_pitch.value           = ""
	txt_debug_pitch.alignment       = "LeftBottom"
	txt_debug_pitch.stringdefs      = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_pitch.formats         = {"%.6f"}
	txt_debug_pitch.controllers     = {{"dbg_txt_pitch", 0}}
	Add(txt_debug_pitch)

	txt_debug_bank				   = CreateElement "ceStringPoly"
	txt_debug_bank.name			   = "txt_debug_bank"
	txt_debug_bank.material		   = "font_Ka-50_dbg"
	txt_debug_bank.init_pos	  	   = {txt_x_offset, txt_y_offset - 1.15, 0}
	txt_debug_bank.value           = ""
	txt_debug_bank.alignment       = "LeftBottom"
	txt_debug_bank.stringdefs      = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_bank.formats         = {"%.6f"}
	txt_debug_bank.controllers     = {{"dbg_txt_bank", 0}}
	Add(txt_debug_bank)

	txt_debug_heading				= CreateElement "ceStringPoly"
	txt_debug_heading.name			= "txt_debug_heading"
	txt_debug_heading.material		= "font_Ka-50_dbg"
	txt_debug_heading.init_pos		= {txt_x_offset, txt_y_offset - 1.3, 0}
	txt_debug_heading.value         = ""
	txt_debug_heading.alignment     = "LeftBottom"
	txt_debug_heading.stringdefs    = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_heading.formats       = {"%.6f"}
	txt_debug_heading.controllers   = {{"dbg_txt_heading", 0}}
	Add(txt_debug_heading)

	txt_debug_IAS				= CreateElement "ceStringPoly"
	txt_debug_IAS.name			= "txt_debug_IAS"
	txt_debug_IAS.material		= "font_Ka-50_dbg"
	txt_debug_IAS.init_pos		= {txt_x_offset, txt_y_offset - 1.45, 0}
	txt_debug_IAS.value         = ""
	txt_debug_IAS.alignment     = "LeftBottom"
	txt_debug_IAS.stringdefs    = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_IAS.formats       = {"%.6f"}
	txt_debug_IAS.controllers   = {{"dbg_txt_IAS", 0}}
	Add(txt_debug_IAS)

	txt_debug_ny				= CreateElement "ceStringPoly"
	txt_debug_ny.name			= "txt_debug_ny"
	txt_debug_ny.material		= "font_Ka-50_dbg"
	txt_debug_ny.init_pos		= {txt_x_offset, txt_y_offset - 1.6, 0}
	txt_debug_ny.value          = ""
	txt_debug_ny.alignment      = "LeftBottom"
	txt_debug_ny.stringdefs     = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_ny.formats        = {"%.6f"}
	txt_debug_ny.controllers    = {{"dbg_txt_Ny", 0}}
	Add(txt_debug_ny)

	txt_debug_ralt				= CreateElement "ceStringPoly"
	txt_debug_ralt.name			= "txt_debug_ralt"
	txt_debug_ralt.material		= "font_Ka-50_dbg"
	txt_debug_ralt.init_pos		= {txt_x_offset, txt_y_offset - 1.75, 0}
	txt_debug_ralt.value        = ""
	txt_debug_ralt.alignment    = "LeftBottom"
	txt_debug_ralt.stringdefs   = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_ralt.formats      = {"%.6f"}
	txt_debug_ralt.controllers  = {{"dbg_txt_RALT", 0}}
	Add(txt_debug_ralt)

	txt_debug_alpha				= CreateElement "ceStringPoly"
	txt_debug_alpha.name		= "txt_debug_alpha"
	txt_debug_alpha.material	= "font_Ka-50_dbg"
	txt_debug_alpha.init_pos	= {txt_x_offset, txt_y_offset - 1.9, 0}
	txt_debug_alpha.value       = ""
	txt_debug_alpha.alignment   = "LeftBottom"
	txt_debug_alpha.stringdefs  = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_alpha.formats     = {"%.6f"}
	txt_debug_alpha.controllers = {{"dbg_txt_alpha", 0}}
	Add(txt_debug_alpha)

	txt_debug_vy				= CreateElement "ceStringPoly"
	txt_debug_vy.name			= "txt_debug_vy"
	txt_debug_vy.material		= "font_Ka-50_dbg"
	txt_debug_vy.init_pos		= {txt_x_offset, txt_y_offset - 2.05, 0}
	txt_debug_vy.value          = ""
	txt_debug_vy.alignment		= "LeftBottom"
	txt_debug_vy.stringdefs		= {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_vy.formats		= {"%.6f"}
	txt_debug_vy.controllers    = {{"dbg_txt_Vy", 0}}
	Add(txt_debug_vy)
end

flag_nav_info = false

if flag_nav_info then
	txt_debug_navpos_x				= CreateElement "ceStringPoly"
	txt_debug_navpos_x.name			= "txt_debug_navpos_x"
	txt_debug_navpos_x.material		= "font_Ka-50_dbg"
	txt_debug_navpos_x.init_pos		= {txt_x_offset2,  txt_y_offset2 - 1.0, 0}
	txt_debug_navpos_x.value        = ""
	txt_debug_navpos_x.alignment    = "LeftBottom"
	txt_debug_navpos_x.stringdefs   = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_navpos_x.formats      = {"%.6f"}
	txt_debug_navpos_x.controllers  = {{"dbg_txt_navpos_x", 0}}
	Add(txt_debug_navpos_x)

	txt_debug_navpos_y				= CreateElement "ceStringPoly"
	txt_debug_navpos_y.name			= "txt_debug_navpos_y"
	txt_debug_navpos_y.material		= "font_Ka-50_dbg"
	txt_debug_navpos_y.init_pos		= {txt_x_offset2,  txt_y_offset2 - 1.15, 0}
	txt_debug_navpos_y.value        = ""
	txt_debug_navpos_y.alignment    = "LeftBottom"
	txt_debug_navpos_y.stringdefs   = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_navpos_y.formats      = {"%.6f"}
	txt_debug_navpos_y.controllers  = {{"dbg_txt_navpos_y", 0}}
	Add(txt_debug_navpos_y)

	txt_debug_navpos_x_err				= CreateElement "ceStringPoly"
	txt_debug_navpos_x_err.name			= "txt_debug_navpos_x_err"
	txt_debug_navpos_x_err.material		= "font_Ka-50_dbg"
	txt_debug_navpos_x_err.init_pos		= {txt_x_offset2,  txt_y_offset2 - 1.3, 0}
	txt_debug_navpos_x_err.value        = ""
	txt_debug_navpos_x_err.alignment    = "LeftBottom"
	txt_debug_navpos_x_err.stringdefs   = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_navpos_x_err.formats      = {"%.6f"}
	txt_debug_navpos_x_err.controllers  = {{"dbg_txt_navpos_x_err", 0}}
	Add(txt_debug_navpos_x_err)

	txt_debug_navpos_y_err				= CreateElement "ceStringPoly"
	txt_debug_navpos_y_err.name			= "txt_debug_navpos_y_err"
	txt_debug_navpos_y_err.material		= "font_Ka-50_dbg"
	txt_debug_navpos_y_err.init_pos		= {txt_x_offset2, txt_y_offset2 - 1.45, 0}
	txt_debug_navpos_y_err.value        = ""
	txt_debug_navpos_y_err.alignment    = "LeftBottom"
	txt_debug_navpos_y_err.stringdefs   = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_navpos_y_err.formats      = {"%.6f"}
	txt_debug_navpos_y_err.controllers  = {{"dbg_txt_navpos_y_err", 0}}
	Add(txt_debug_navpos_y_err)

	txt_debug_radial_err				= CreateElement "ceStringPoly"
	txt_debug_radial_err.name			= "txt_debug_radial_err"
	txt_debug_radial_err.material		= "font_Ka-50_dbg"
	txt_debug_radial_err.init_pos		= {txt_x_offset2, txt_y_offset2 - 1.6, 0}
	txt_debug_radial_err.value          = ""
	txt_debug_radial_err.alignment      = "LeftBottom"
	txt_debug_radial_err.stringdefs     = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_radial_err.formats        = {"%.6f"}
	txt_debug_radial_err.controllers    = {{"dbg_txt_radial_err", 0}}
	Add(txt_debug_radial_err)

	txt_debug_drift_angle			= CreateElement "ceStringPoly"
	txt_debug_drift_angle.name		= "txt_debug_drift_angle"
	txt_debug_drift_angle.material	= "font_Ka-50_dbg"
	txt_debug_drift_angle.init_pos	= {txt_x_offset2, txt_y_offset2 - 1.75, 0}
	txt_debug_drift_angle.value       = ""
	txt_debug_drift_angle.alignment   = "LeftBottom"
	txt_debug_drift_angle.stringdefs  = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_drift_angle.formats     = {"%.6f"}
	txt_debug_drift_angle.controllers = {{"dbg_txt_drift_angle", 0}}
	Add(txt_debug_drift_angle)

	txt_debug_sideslip_angle			  = CreateElement "ceStringPoly"
	txt_debug_sideslip_angle.name		  = "txt_debug_sideslip_angle"
	txt_debug_sideslip_angle.material	  = "font_Ka-50_dbg"
	txt_debug_sideslip_angle.init_pos	  = {txt_x_offset2, txt_y_offset2 - 1.9, 0}
	txt_debug_sideslip_angle.value        = ""
	txt_debug_sideslip_angle.alignment    = "LeftBottom"
	txt_debug_sideslip_angle.stringdefs   = {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_sideslip_angle.formats      = {"%.6f"}
	txt_debug_sideslip_angle.controllers  = {{"dbg_txt_sideslip_angle", 0}}
	Add(txt_debug_sideslip_angle)

	txt_debug_deviation					= CreateElement "ceStringPoly"
	txt_debug_deviation.name			= "txt_debug_deviation"
	txt_debug_deviation.material		= "font_Ka-50_dbg"
	txt_debug_deviation.init_pos		= {txt_x_offset2, txt_y_offset2 - 2.05, 0}
	txt_debug_deviation.value			= ""
	txt_debug_deviation.alignment		= "LeftBottom"
	txt_debug_deviation.stringdefs		= {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_deviation.formats			= {"%.6f"}
	txt_debug_deviation.controllers		= {{"dbg_txt_deviation", 0}}
	Add(txt_debug_deviation)

	txt_debug_mag_decl				= CreateElement "ceStringPoly"
	txt_debug_mag_decl.name			= "txt_debug_mag_decl"
	txt_debug_mag_decl.material		= "font_Ka-50_dbg"
	txt_debug_mag_decl.init_pos		= {txt_x_offset2, txt_y_offset2 - 2.2, 0}
	txt_debug_mag_decl.value		= ""
	txt_debug_mag_decl.alignment	= "LeftBottom"
	txt_debug_mag_decl.stringdefs	= {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_mag_decl.formats		= {"%.6f"}
	txt_debug_mag_decl.controllers	= {{"dbg_txt_mag_decl", 0}}
	Add(txt_debug_mag_decl)

	txt_debug_mag_incl				= CreateElement "ceStringPoly"
	txt_debug_mag_incl.name			= "txt_debug_mag_incl"
	txt_debug_mag_incl.material		= "font_Ka-50_dbg"
	txt_debug_mag_incl.init_pos		= {txt_x_offset2, txt_y_offset2 - 2.35, 0}
	txt_debug_mag_incl.value		= ""
	txt_debug_mag_incl.alignment	= "LeftBottom"
	txt_debug_mag_incl.stringdefs	= {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_mag_incl.formats		= {"%.6f"}
	txt_debug_mag_incl.controllers	= {{"dbg_txt_mag_incl", 0}}
	Add(txt_debug_mag_incl)

	txt_debug_latitude				= CreateElement "ceStringPoly"
	txt_debug_latitude.name			= "txt_debug_latitude"
	txt_debug_latitude.material		= "font_Ka-50_dbg"
	txt_debug_latitude.init_pos		= {txt_x_offset2, txt_y_offset2 - 2.5, 0}
	txt_debug_latitude.value		= ""
	txt_debug_latitude.alignment	= "LeftBottom"
	txt_debug_latitude.stringdefs	= {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_latitude.formats		= {"%.6f"}
	txt_debug_latitude.controllers	= {{"dbg_txt_latutude", 0}}
	Add(txt_debug_latitude)

	txt_debug_longitude				= CreateElement "ceStringPoly"
	txt_debug_longitude.name		= "txt_debug_longitude"
	txt_debug_longitude.material	= "font_Ka-50_dbg"
	txt_debug_longitude.init_pos	= {txt_x_offset2, txt_y_offset2 - 2.65, 0}
	txt_debug_longitude.value		= ""
	txt_debug_longitude.alignment	= "LeftBottom"
	txt_debug_longitude.stringdefs	= {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_debug_longitude.formats		= {"%.6f"}
	txt_debug_longitude.controllers	= {{"dbg_txt_longitude", 0}}
	Add(txt_debug_longitude)
end

flag_datalink_info = false

if flag_datalink_info then

	txt_dbg_datalnk_from				= CreateElement "ceStringPoly"
	txt_dbg_datalnk_from.name			= "txt_dbg_datalnk_from"
	txt_dbg_datalnk_from.material		= "font_Ka-50_dbg"
	txt_dbg_datalnk_from.init_pos		= {txt_x_offset2,  txt_y_offset2 - 1.0, 0}
	txt_dbg_datalnk_from.alignment		= "LeftBottom"
	txt_dbg_datalnk_from.stringdefs		= {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_dbg_datalnk_from.formats		= {"%10u"}
	txt_dbg_datalnk_from.controllers	= {{"txt_dbg_datalnk_from", 0}}
	Add(txt_dbg_datalnk_from)
	
	txt_dbg_datalnk_to					= CreateElement "ceStringPoly"
	txt_dbg_datalnk_to.name				= "txt_dbg_datalnk_to"
	txt_dbg_datalnk_to.material			= "font_Ka-50_dbg"
	txt_dbg_datalnk_to.init_pos			= {txt_x_offset2,  txt_y_offset2 - 1.15, 0}
	txt_dbg_datalnk_to.alignment		= "LeftBottom"
	txt_dbg_datalnk_to.stringdefs		= {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_dbg_datalnk_to.formats			= {"%10u"}
	txt_dbg_datalnk_to.controllers		= {{"txt_dbg_datalnk_to", 0}}
	Add(txt_dbg_datalnk_to)
	
	txt_dbg_datalnk_target				= CreateElement "ceStringPoly"
	txt_dbg_datalnk_target.name			= "txt_dbg_datalnk_target"
	txt_dbg_datalnk_target.material		= "font_Ka-50_dbg"
	txt_dbg_datalnk_target.init_pos		= {txt_x_offset2,  txt_y_offset2 - 1.3, 0}
	txt_dbg_datalnk_target.alignment	= "LeftBottom"
	txt_dbg_datalnk_target.stringdefs	= {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_dbg_datalnk_target.formats		= {"%10u"}
	txt_dbg_datalnk_target.controllers	= {{"txt_dbg_datalnk_target", 0}}
	Add(txt_dbg_datalnk_target)
	
	txt_dbg_datalnk_type				= CreateElement "ceStringPoly"
	txt_dbg_datalnk_type.name			= "txt_dbg_datalnk_type"
	txt_dbg_datalnk_type.material		= "font_Ka-50_dbg"
	txt_dbg_datalnk_type.init_pos		= {txt_x_offset2,  txt_y_offset2 - 1.45, 0}
	txt_dbg_datalnk_type.alignment		= "LeftBottom"
	txt_dbg_datalnk_type.stringdefs		= {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_dbg_datalnk_type.formats		= {"%10u"}
	txt_dbg_datalnk_type.controllers	= {{"txt_dbg_datalnk_type", 0}}
	Add(txt_dbg_datalnk_type)
	
	txt_dbg_datalnk_param				= CreateElement "ceStringPoly"
	txt_dbg_datalnk_param.name			= "txt_dbg_datalnk_param"
	txt_dbg_datalnk_param.material		= "font_Ka-50_dbg"
	txt_dbg_datalnk_param.init_pos		= {txt_x_offset2,  txt_y_offset2 - 1.6, 0}
	txt_dbg_datalnk_param.alignment		= "LeftBottom"
	txt_dbg_datalnk_param.stringdefs	= {0.012, 0.012, 0.05 * 0.01, 0.05* 0.01}
	txt_dbg_datalnk_param.formats		= {"%10u"}
	txt_dbg_datalnk_param.controllers	= {{"txt_dbg_datalnk_param", 0}}
	Add(txt_dbg_datalnk_param)
	
end
--[[
txt_fm_debug				= CreateElement "ceStringPoly"
txt_fm_debug.name			= "txt_fm_debug"
txt_fm_debug.material		= "font_Ka-50_dbg"
txt_fm_debug.init_pos		= {txt_x_offset2, txt_y_offset2 - 1.0, 0}
txt_fm_debug.value			= ""
txt_fm_debug.alignment		= "LeftBottom"
txt_fm_debug.stringdefs		= {0.016, 0.016, 0.05 * 0.01, 0.05* 0.01}
txt_fm_debug.formats		= {"%.2f"}
txt_fm_debug.controllers	= {{"txt_fm_debug", 0}}
Add(txt_fm_debug)
--]]
