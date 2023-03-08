local my_path = LockOn_Options.script_path.."VTB/"
dofile(my_path.."VTB_definitions.lua")
dofile(my_path.."VTB_elements.lua")

local ac_y = 2.5
local aircraft_pos = {0.0, ac_y}
local range_scale = 50.0

create_dummy("vtb-aircraft-pos", aircraft_pos, nil)

create_heading_tape()
create_attitude()
create_speed_vector()
create_flight_data()

create_cad_grid(aircraft_pos)
create_tdc(aircraft_pos, range_scale)
create_waypoints(aircraft_pos, range_scale)


create_radar_text()
create_lock_info()

create_do_contact(aircraft_pos, range_scale)

create_mdo()



