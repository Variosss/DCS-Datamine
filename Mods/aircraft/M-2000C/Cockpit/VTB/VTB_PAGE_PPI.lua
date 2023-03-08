local my_path = LockOn_Options.script_path.."VTB/"
dofile(my_path.."VTB_definitions.lua")
dofile(my_path.."VTB_elements.lua")

local ac_y = -47.5
local aircraft_pos = {0.0, ac_y}
local range_scale = 95.0


create_dummy("vtb-aircraft-pos", aircraft_pos, nil)

create_radar_video("vtb-aircraft-pos", range_scale)

create_heading_tape()
create_elev_scale()
create_attitude()
create_speed_vector()
create_flight_data()

create_radar_grid("ppi", aircraft_pos)
create_sweep(aircraft_pos, range_scale)
create_tdc(aircraft_pos, range_scale)
create_waypoints(aircraft_pos, range_scale)

create_radar_text()
create_lock_info()
create_aa_director()

create_synth_contacts(64, aircraft_pos, range_scale)
create_jam_sources(32, aircraft_pos, range_scale)
create_lock_contact(aircraft_pos, range_scale)
create_do_contact(aircraft_pos, range_scale)

create_mdo()

create_message()


--create_fromsvg("vtb-test-rect", 	"vtb-test-rect", {0,0}, nil, {})


---vtb_r_txt_jammed			= CreateElement "ceStringPoly"
---vtb_r_txt_jammed.name		= "vtb_r_txt_jammed"
---vtb_r_txt_jammed.material	= "vtb_green"
---vtb_r_txt_jammed.init_pos	= {-0.65, 0.67, 0.0}
---vtb_r_txt_jammed.alignment	= "CenterCenter"
---vtb_r_txt_jammed.formats	= {"%s"}
---vtb_r_txt_jammed.stringdefs	= {0.005,0.005}
---vtb_r_txt_jammed.controllers = {{"txt_radar_jammed"}}
---Add_VTB_Element(vtb_r_txt_jammed)





