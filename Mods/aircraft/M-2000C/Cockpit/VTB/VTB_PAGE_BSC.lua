local my_path = LockOn_Options.script_path.."VTB/"
dofile(my_path.."VTB_definitions.lua")
dofile(my_path.."VTB_elements.lua")

local ac_y = -47.5
local aircraft_pos = {0.0, ac_y}
local range_scale = 95.0
local az_mm_per_deg = 1.04;

create_dummy("vtb-aircraft-pos", aircraft_pos, nil)

create_radar_video("vtb-aircraft-pos", range_scale)

create_heading_tape()
create_elev_scale()
create_attitude()
create_speed_vector()
create_flight_data()

create_radar_grid("bsc", aircraft_pos)
create_sweep(aircraft_pos, range_scale, az_mm_per_deg)
create_tdc(aircraft_pos, range_scale, az_mm_per_deg)
create_waypoints(aircraft_pos, range_scale, az_mm_per_deg)

create_radar_text()
create_lock_info()
create_aa_director()

create_synth_contacts(64, aircraft_pos, range_scale, az_mm_per_deg)
create_jam_sources(32, aircraft_pos, range_scale, az_mm_per_deg)
create_lock_contact(aircraft_pos, range_scale, az_mm_per_deg)
create_do_contact(aircraft_pos, range_scale, az_mm_per_deg)

create_mdo()

create_message()




