local my_path = LockOn_Options.script_path.."VTB/"
dofile(my_path.."VTB_definitions.lua")

push_color("vtb_cav")

create_fromsvg("vtb-emp-aircraft", "vtb-emp-aircraft",{0,0})

-- Gun Ammo Count
create_text("txt_lg_ammo", {"%d\nOBUS"}, 3, "CenterCenter", {-19, 25}, nil, {{"vtb_emp_can_ammo", 0}})
create_text("txt_rg_ammo", {"%d\nOBUS"}, 3, "CenterCenter", { 19, 25}, nil, {{"vtb_emp_can_ammo", 1}})

local stores = {	{ pos = {-34, -31, 0}, pylon=0},
					{ pos = {-19, -31, 0}, pylon=1},
					{ pos = {-31,   0, 0}, pylon=2},
					{ pos = {  0, -12, 0}, pylon=4},
					{ pos = { 31,   0, 0}, pylon=6},
					{ pos = { 19, -31, 0}, pylon=7},
					{ pos = { 34, -31, 0}, pylon=8}	}

for i = 1, #stores do
	local pos = stores[i].pos
	local pylon = stores[i].pylon	
	create_text("txt_pylon_c" .. i, {"%dX"}, 3, "CenterCenter", stores[i].pos, nil, {{"vtb_emp_pylon_count", stores[i].pylon}})
	create_text("txt_pylon_d" .. i, {"%dX"}, 3, "CenterCenter", {0, -5}, "txt_pylon_c" .. i, {{"vtb_emp_pylon_code", stores[i].pylon}})
end

pop_color()