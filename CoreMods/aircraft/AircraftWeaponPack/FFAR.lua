local inches = 0.0254
local inches_to_mm = inches * 100
local pounds       = 0.453592

local mk4_rocket_motor =
{
	fuel_mass   			= 3,
	boost_time  			= 0,
	work_time   			= 1.3,
	boost_factor			= 1,
	nozzle_position 	    =  {{-0.65, 0, 0}},
	nozzle_orientationXYZ   =  {{0, 0, 0}},
	tail_width  			= 0.052,
	boost_tail  			= 1,
	work_tail   			= 1,
	smoke_color 			= {0.6, 0.6, 0.6},
	smoke_transparency 		= 0.3,
	motor_length 			= 39.3 * inches
}
-- Solid-fueled rocket; 3.3 kN (750 lb) for 1.3 s
mk4_rocket_motor.impulse = 3300 / (9.8 * mk4_rocket_motor.fuel_mass / mk4_rocket_motor.work_time)

local function mk4_FFAR_fm(tbl)
	local t = 
	{
		mass        = mk4_rocket_motor.fuel_mass + 1.0,-- weight with kg
		caliber     = 2.75 * inches,  
		cx_coeff    = {0.4,0.89,0.78,0.22,1.83},
		L			= mk4_rocket_motor.motor_length + 0.3,
		I           = 1.7240,-- kgm2 - moment of inertia  I = 1/12 ML2
		Ma          = 0.23322,-- dependence moment coefficient of  by  AoA angular acceleration  T / I
		Mw          = 2.177036,--rad/s  - 57.3°/s - dependence moment coefficient by angular velocity (|V|*sin(?))/|r| -  Mw  =  Ma * t     
		wind_time   = 1.3,-- dispersion coefficient
		wind_sigma  = 36,
		freq        = 0.1,
	}
	if tbl then
		for i,o in pairs(tbl) do
			t[i] = o
		end
	end
	return t
end

local function mk4_FFAR(main,fm,warhead)
	local t = main or {}
	
	if not t.scheme then
		   t.scheme	= "nurs-standard"
	end
	
	t.category   		= CAT_ROCKETS
	t.wsTypeOfWeapon 	= {wsType_Weapon, wsType_NURS, wsType_Rocket, WSTYPE_PLACEHOLDER}
	
	t.fm 		 		= fm      or mk4_FFAR_fm()
	t.fm.shapeName		= t.model
	t.warhead    		= warhead
	----------------------------------------
	t.engine    		= mk4_rocket_motor
	t.properties = 
	{
		dist_min = 600,   -- min range, meters
		dist_max = 1200,  -- max range, meters
	}
	if not t.shape_table_data then
		t.shape_table_data ={
			{
				name     = t.model,
				file     = t.model,
				life     = 1,
				fire     = {0, 1},
				username = t.name,
				index    = WSTYPE_PLACEHOLDER,
			},
		}
	end
	declare_weapon(t)
	return t
end


------------------------------------------
local mk4_FFAR_MK1_HE   = mk4_FFAR(
--base
{
	name  			 = "FFAR Mk1 HE",
	model 			 = "ffar_mk4_m151he",
	user_name 		 = _("2.75\" FFAR, UnGd Rkts Mk1, HE"),
},
--fm
mk4_FFAR_fm({
	L 		= 54 * inches,
	mass    = 21.5 * pounds,
}),
--warhead
predefined_warhead("HYDRA_70_MK1"))

------------------------------------------
local mk4_FFAR_MK5_HEAT   = mk4_FFAR(
--base
{
	name  			 = "FFAR Mk5 HEAT",
	model 			 = "ffar_mk4_mk5",
	user_name 		 = _("2.75\" FFAR, UnGd Rkts Mk5, HEAT"),
},
--fm
mk4_FFAR_fm({
	L 		= 54 * inches,
	mass    = 21.6 * pounds,
}),
--warhead
predefined_warhead("HYDRA_70_M247"))

------------------------------------------
local mk4_FFAR_M156_WP  = mk4_FFAR(
--base
{
	name  			 = "FFAR M156 WP",
	model 			 = "ffar_mk4_m156",
	user_name 		 = _("2.75\" FFAR, UnGd Rkts M156, Wht Phos"),
	scheme			  = "nurs-marker",
},
--fm
mk4_FFAR_fm({
	L 		= 59 * inches,
	mass    = 24.7 * pounds,
}),
--warhead
predefined_warhead("HYDRA_70_M156")) 

------------------------------------------

function lau_3(CLSID,rocket)
	local data =
	{
		CLSID			= CLSID,
		category		= CAT_ROCKETS,
		Picture			= "LAU61.png",
		Count			= 19,
		Cx_pil			= 0.00146484375,
		wsTypeOfWeapon	= rocket.wsTypeOfWeapon,
		attribute		= {4,	7,	32,	WSTYPE_PLACEHOLDER},
		displayName		= _("LAU-3 pod") .. " - 19 x " .. rocket.user_name,
		Elements		= {{ ShapeName	= "LAU-3", IsAdapter = true }},
		Weight			= 34.5 + 19 * rocket.fm.mass,
		Weight_Empty	= 34.5,
		--launch animation block
		weapon_container_data =
		{
			nurs_args			= {4,5},
			launched_arg_state	= 1.0,
		}
	}
	for i = 1,data.Count do
		data.Elements[#data.Elements + 1] = {	connector_name	=	"tube_"..i,
												ShapeName		=	rocket.model}
	end
	declare_loadout(data)
end

		
function lau_68(CLSID,rocket)
	local data =
	{
		CLSID			= CLSID,
		category		= CAT_ROCKETS,
		Picture			= "LAU68.png",
		Count			= 7,
		Cx_pil			= 0.00146484375,
		wsTypeOfWeapon  = rocket.wsTypeOfWeapon,
		attribute		= {4,	7,	32,	WSTYPE_PLACEHOLDER },
		displayName		= _("LAU-68 pod").." - 7 x "..rocket.user_name,
		Elements		= {{ ShapeName	= "LAU-68" , IsAdapter = true}},
		Weight			= 41.73 + 7  * rocket.fm.mass,
	}
	for i = 1,data.Count do
		data.Elements[#data.Elements + 1] = {	connector_name	=	"tube_0"..i,
												ShapeName		=	rocket.model}
	end
	declare_loadout(data)
end

lau_3("{LAU3_FFAR_WP156}"	,mk4_FFAR_M156_WP)
lau_3("{LAU3_FFAR_MK1HE}"	,mk4_FFAR_MK1_HE)
lau_3("{LAU3_FFAR_MK5HEAT}"	,mk4_FFAR_MK5_HEAT)

lau_68("{LAU68_FFAR_WP156}"		,mk4_FFAR_M156_WP)
lau_68("{LAU68_FFAR_MK1HE}"		,mk4_FFAR_MK1_HE)
lau_68("{LAU68_FFAR_MK5HEAT}"	,mk4_FFAR_MK5_HEAT)
