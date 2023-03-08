-- BAP100 DEFINITION / RAZBAM
local bap100_shape = "M-2000c_BAP100"

BAP100  = {
	category  		= CAT_BOMBS,
	name      		= "BAP_100",
	model     		= bap100_shape,
	user_name 		= _("BAP-100"),
	wsTypeOfWeapon  = {wsType_Weapon, wsType_Bomb, wsType_Bomb_BetAB, WSTYPE_PLACEHOLDER},
	scheme    		= "bomb-concrete",
	class_name		= "wAmmunition",
	
	type    	= 1,
	mass    = 32.5,			-- Actual data
	hMin    = 50.0,
	hMax    = 3000.0,
	Cx      = 0.004,		-- 100mm diameter, 0.5 true Cx
	VyHold  = -50.0,		-- Ask ED about this?
	Ag      = -5.0,			-- Ask ED about this?
	
	-- Explosive should be 8.75 (3.5kg with 0.4 ratio) but in order to damage runways properly it needs to be increased
	warhead = penetrating_warhead(20.0, 100.0),


	--From BetAB500SHP
    fm =
    {
        mass            = 32.5,
        caliber         = 0.10,
        cx_coeff        = {1.000000, 0.820000, 0.650000, 0.142000, 2.110000},
        L               = 1.8,
        I               = 8.775, -- Model of a 1.8m 32.5kg bar
        Ma              = 10.0,  -- Very large, but needed in the parachute phase to nose down, as the parachute has a very high AoA moment coefficient. Doesn't affect much the boost phase
        Mw              = 100.0, -- Very large, but needed to damp the oscillations caused by previous coefficient, and also realistic of the chute forces.
        wind_time       = 5.0,
        wind_sigma      = 5.0,
        cx_factor       = 800, 
    },
	
 	--From BetAB500SHP
	control = 
    {
        delay_par   = 0.5,			-- Actual data
        delay_eng   = 4.25,			-- Actual data is 3.75s but this results in too low impact angle which should be 70° from 300ft
    },
	
	engine =
    {
        fuel_mass   = 8.5,			-- Actual data
        impulse     = 160,			-- Is that Isp (specific impulse) ? 130 gives too low impact speed which is documented to 240m/s
        boost_time  = 0,
        work_time   = 0.3,			-- Actual data
        boost_factor= 1,
        nozzle_position =  {{-0.8, -0.08, 0}},
		nozzle_orientationXYZ =  {{0, 0, 0}},
        tail_width  = 1.0,
        boost_tail  = 1,
        work_tail   = 1,

        smoke_color = {0.7, 0.7, 0.7},
        smoke_transparency = 0.1,
    },
	
	

	
 	-- Is this data for BombSight? What do these numbers correspond to?
	targeting_data = 
	{
		v0 = 200,
		data =
		{
			{1.000000, 		20.200000, 0.000000},
			{10.000000, 	20.277292, 0.000140},
			{20.000000, 	20.974612, -0.001161},
			{30.000000, 	22.769170, -0.004716},
			{40.000000, 	24.530820, -0.008370},
			{50.000000, 	26.006583, -0.011409},
			{60.000000, 	27.225948, -0.013867},
			{70.000000, 	28.244350, -0.015948},
			{80.000000, 	29.104125, -0.017757},
			{90.000000, 	29.847648, -0.019331},
			{100.000000, 	30.497785, -0.020713},
			{200.000000, 	34.417633, -0.029035},
			{300.000000, 	36.463728, -0.032998},
			{400.000000, 	37.804113, -0.035178},
			{500.000000, 	38.757713, -0.036380},
			{600.000000, 	39.461708, -0.036995},
			{700.000000, 	39.992857, -0.037257},
			{800.000000, 	40.400741, -0.037312},
			{900.000000, 	40.719782, -0.037253},
			{1000.000000, 	40.974474, -0.037137},
			{1100.000000, 	41.182447, -0.036998},
			{1200.000000, 	41.356427, -0.036855},
			{1300.000000, 	41.505608, -0.036721},
			{1400.000000, 	41.636693, -0.036598},
			{1500.000000, 	41.754532, -0.036490},
			{1600.000000, 	41.862668, -0.036396},
			{1700.000000, 	41.963673, -0.036315},
			{1800.000000, 	42.059437, -0.036246},
			{1900.000000, 	42.151341, -0.036187},
			{2000.000000, 	42.240399, -0.036136},
			{3000.000000, 	43.072382, -0.035844},
			{4000.000000, 	43.883330, -0.035602},
			{5000.000000, 	44.690588, -0.035290},
			{6000.000000, 	45.492075, -0.034901},
			{7000.000000, 	46.284544, -0.034433},
			{8000.000000, 	47.064678, -0.033892},
			{9000.000000, 	47.829238, -0.033280},
			{10000.000000, 	48.574960, -0.032601},   
		}       
	},
	
	
	shape_table_data =
	{
		{
			name	 = bap100_shape,
			file     = bap100_shape,
			life     = 1,
			fire     = {0, 1},
			username = _("BAP-100"),
			index    = WSTYPE_PLACEHOLDER,
		},
	}
	
}

declare_weapon(BAP100)


local defaultArgs = {
					[1]	=	{1,	1},
					[2]	=	{2,	1},
					} -- end of DrawArgs

declare_loadout({
	category		=	CAT_BOMBS,
	CLSID			= 	"{BAP_100}",
	Picture			=	"betab500shp.png",
	displayName		=	_("BAP-100 Anti-Runway"),
	wsTypeOfWeapon	=	BAP100.wsTypeOfWeapon,
	attribute		=	BAP100.wsTypeOfWeapon,
	Count			=	1,
	Weight			=	bap100_bomb_weight,
	Elements		=	{
		[1]	= {
			DrawArgs = defaultArgs,
			Position	=	{0,	0,	0},
			ShapeName	=	bap100_shape,
		}, 
	}, -- end of Elements
})






-- BAP100 BOMB RACK
local bap100_rack_adapter =  {  ShapeName = "M-2000c_BAP_Rack", IsAdapter = true }
local function bap100_rack_elements(num)
	local result = { bap100_rack_adapter }
	for i=18, 19-num,-1 do
		result[#result+1]= {
			ShapeName = bap100_shape,
			DrawArgs = defaultArgs,
			connector_name	= string.format("str_pnt_%03d", i)
			}
	end
	return result
end

local bap100_rack_weight = 75


--Create 6, 12 and 18 racks
for num=6, 18,6 do
	declare_loadout({
		category		= CAT_BOMBS,
		CLSID			= string.format("{M2KC_BAP100_%d_RACK}", num) ,
		attribute		= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER},
		wsTypeOfWeapon	= BAP100.wsTypeOfWeapon,
		Count			= num,
		Cx_pil			= 0.0005 + num * 0.0001,
		Cx_item			= 0.0001,
		Picture			= "betab500shp.png",
		displayName		= _("BAP-100 x "..num),
		Weight			= bap100_rack_weight + num * BAP100.mass,
		Elements		= bap100_rack_elements(num)
	})
end


