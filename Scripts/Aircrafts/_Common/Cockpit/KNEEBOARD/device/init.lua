
device_timer_dt			  = 0.05

local units_scale_factor = 1
terrainVersion          = get_terrain_related_data("edterrainVersion") or 3.0
theatre					= get_terrain_related_data("name")

local caucasus   = theatre == "Caucasus"

if terrainVersion < 4.0 then
	dofile(LockOn_Options.common_script_path.."tools.lua")
	use_lat_lon 	= true
	lat_lon_aspect,meters_per_lon_degree = get_lat_lon_scaling()
	units_scale_factor    = 1 / meters_per_lon_degree
end

function NM(nm)
	return nm * 1852.0 * units_scale_factor 
end
if terrainVersion < 4.0 then
	chart_defaults = 	{
	{scale = NM(5)  ,chart =3 },
	{scale = NM(10) ,chart =3 },
	{scale = NM(20) ,chart =5 },
	{scale = NM(40) ,chart =6 },
	{scale = NM(80) ,chart =7 },
	{scale = NM(160),chart =8 },
	}
elseif caucasus then -- 2,3,6 now only working
	chart_defaults = 	{
	{scale = NM(5)  ,chart =2 },
	{scale = NM(10) ,chart =2 },
	{scale = NM(20) ,chart =3 },
	{scale = NM(40) ,chart =3 },
	{scale = NM(80) ,chart =6 },
	{scale = NM(160),chart =6 },
	}
else
	chart_defaults = 	{
	{scale = NM(5)  ,chart =2 },
	{scale = NM(10) ,chart =2 },
	{scale = NM(20) ,chart =4 },
	{scale = NM(40) ,chart =4 },
	{scale = NM(80) ,chart =5 },
	{scale = NM(160),chart =6 },
	}
end

default_scale = chart_defaults[2].scale
default_chart = chart_defaults[3].chart

function default_map(i,xx,zz)
	return {scale = chart_defaults[i].scale,
			chart = chart_defaults[i].chart,
			x = xx or x_start,
			z = zz or z_start,
			dont_use_in_waypoint_check = true}
end

need_to_be_closed  = true

local aspect_ratio_fov  = 0.214/0.142

function test_contain(map,threshold,X,Z)
	if map.dont_use_in_waypoint_check or 
	   map.x  == nil or 
	   map.z == nil then
	   return false
	end
	local z_max = map.scale *( 1 - threshold) 
	local x_max = map.scale *( aspect_ratio_fov - threshold) 
	
	local d_x =  X  - map.x
	local d_z =  Z  - map.z
	
	if 	map.rotation ~= nil then
		local sin_a = math.sin(-map.rotation)
		local cos_a = math.cos(-map.rotation)
		local x = d_x
		local z = d_z

		d_z = z * cos_a - x * sin_a	  
		d_x = z * sin_a + x * cos_a
	end

	return math.abs(d_x) < x_max and
		   math.abs(d_z) < z_max		   
end

function on_waypoint_adding(x,z,course)

	if not map_pages then
		map_pages = {}
	else
		for i,map in ipairs(map_pages) do
			if test_contain(map,0.01,x,z) then 
				-- ok waypoint are can be shown on existing charts
				return 
			end
		end	
	end
	-- nothing found , generate new map
	map_pages[#map_pages + 1] = {scale     = default_scale,
								 chart     = default_chart,
								 rotation  = 0,--course,
								 x  = x,
								 z =  z}
end

function generate_maps()
	if not map_pages then
		map_pages = {}
	end
	--add common set of charts
	map_pages[#map_pages + 1] = default_map(4)--,x_bullseye,z_bullseye)
	map_pages[#map_pages + 1] = default_map(5,x_bullseye,z_bullseye)
	map_pages[#map_pages + 1] = default_map(6)--,x_bullseye,z_bullseye)
end

number_of_additional_pages = 2

note_generate_template  = [[
dofile(LockOn_Options.common_script_path.."KNEEBOARD/indicator/definitions.lua")
SetScale(FOV)
local row 			 = GetAspect() / 16
local font_height 	 = 0.65 * row
local pict 			 = add_picture("notepad_32.dds")
pict.controllers 	 = {{"to_render_target",1}}
local note			 = CreateElement "ceStringPoly"
note.material		 = FONT_NOTE
note.init_pos		 = {0.05,0.0025 - row + font_height}
note.controllers	 = $_
note.stringdefs		 = { font_height * GetScale(), 0.8 * font_height * GetScale(),0,row *  GetScale()  -  font_height * GetScale()}
note.pretty_tabs	 = true
note.alignment		 = "LeftTop"
note.use_mipfilter 	 = true
note.parent_element	 = pict.name
Add(note)]]
