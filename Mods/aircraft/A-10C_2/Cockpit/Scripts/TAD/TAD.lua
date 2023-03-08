dofile(LockOn_Options.common_script_path.."tools.lua")

depression_X 		  = 0	
depression_Y 		  = (0.5 - 0.275) * 2

local units_scale_factor = 1

terrainVersion          = get_terrain_related_data("edterrainVersion") or 3.0
theatre					= get_terrain_related_data("name")

local caucasus   = theatre == "Caucasus"

if terrainVersion < 4.0 then
	dofile(LockOn_Options.common_script_path.."tools.lua")
	use_lat_lon 		  = true
	lat_lon_aspect,meters_per_lon_degree = get_lat_lon_scaling()
	units_scale_factor    = 1 / meters_per_lon_degree
else
	use_lat_lon 		  = false
end

device_timer_dt		  = 0.05

cursor_size			  = 20 / 570

local ring_coeff      = 250 / (570 / 2)
range_bump_threshold   = 4 / (570 / 2)
cursor_limX           = ring_coeff - range_bump_threshold
cursor_limY           = cursor_limX

function NM(nm)
	return nm * 1852.0 * units_scale_factor  / ring_coeff
end

charts = 
{
	"1:50K",
	"1:100K",
	"NO MAP",
	"1:250K",
	"NO MAP",
	"1:500K",
	"1:1M",	
	"1:2M",
	"1:5M",
}
if terrainVersion < 4.0 then

charts = 
{
	"1:50K",
	"1:100K",
	"NO MAP",
	"1:250K",
	"NO MAP",
	"1:500K",
	"1:1M",	
	"1:2M",
	"1:5M",
}

scales = {
	{scale = NM(5)  ,chart ={4,4,4} ,description = {"5"  ,"7.5"}},
	{scale = NM(10) ,chart ={6,4,4} ,description = {"10" ,"15"}},
	{scale = NM(20) ,chart ={7,6,4} ,description = {"20" ,"30"}},
	{scale = NM(40) ,chart ={8,7,6} ,description = {"40" ,"60"}},
	{scale = NM(80) ,chart ={9,8,7} ,description = {"80" ,"120"}},
	{scale = NM(160),chart ={9,8,7} ,description = {"160","240"}},
}
elseif caucasus then -- 2,3,6 now only working
	charts = 
	{
		"NO MAP", -- RCS_100K 		= 1 //NO MAP
		"1:250K", -- RCS_250K 		= 2 //OK
		"1:500K", -- RCS_500K 		= 3 //OK
		"NO MAP", -- RCS_1M 		= 4 //NO MAP
		"NO MAP", -- RCS_2M 		= 5 //NO MAP
		"1:5M",   -- RCS_5M 		= 6 //OK
	}
scales = 	{
	{scale = NM(5)  ,chart ={2,2,2} ,description = {"5"  ,"7.5"}},
	{scale = NM(10) ,chart ={3,2,2} ,description = {"10" ,"15"}},
	{scale = NM(20) ,chart ={3,2,2} ,description = {"20" ,"30"}},
	{scale = NM(40) ,chart ={6,3,3} ,description = {"40" ,"60"}},
	{scale = NM(80) ,chart ={6,3,3} ,description = {"80" ,"120"}},
	{scale = NM(160),chart ={6,6,6} ,description = {"160","240"}},
}
else

charts = 
{
	"NO MAP", -- RCS_100K 		= 1 //NO MAP
	"1:250K", -- RCS_250K 		= 2 //OK
	"NO MAP", -- RCS_500K 		= 3 //NO MAP
	"1:1M",	  -- RCS_1M 		= 4 //OK
	"1:2M",   -- RCS_2M 		= 5 //OK
	"1:5M",   -- RCS_5M 		= 6 //OK
}

scales = 	{
	{scale = NM(5)  ,chart ={2,2,2} ,description = {"5"  ,"7.5"}},
	{scale = NM(10) ,chart ={4,2,2} ,description = {"10" ,"15"}},
	{scale = NM(20) ,chart ={4,2,2} ,description = {"20" ,"30"}},
	{scale = NM(40) ,chart ={5,4,4} ,description = {"40" ,"60"}},
	{scale = NM(80) ,chart ={5,4,4} ,description = {"80" ,"120"}},
	{scale = NM(160),chart ={6,5,5} ,description = {"160","240"}},
}
end

dofile(LockOn_Options.script_path .. "TAD/Profiles.lua")

-- SETTINGS_PATH is left for compatibility with old missions
SETTINGS_PATH = "TAD/settings.lua"
dofile(LockOn_Options.common_script_path.."mission_prepare.lua")
