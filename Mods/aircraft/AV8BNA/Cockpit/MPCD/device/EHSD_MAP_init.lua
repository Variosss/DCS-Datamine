device_timer_dt			  = 0.05

local units_scale_factor = 1

use_lat_lon 	= false

function NM(nm)
	return nm * 1852.0 * units_scale_factor 
end

-- Only charts 2,3,6 are working

chart_defaults = {
	{scale = NM(3.0),  chart = 2 },	-- 1
	{scale = NM(5.0),  chart = 2 },	-- 2
	{scale = NM(6.0),  chart = 2 },	-- 3
	{scale = NM(13.0), chart = 3 },	-- 4
	{scale = NM(13.0), chart = 3 },	-- 5
	{scale = NM(25.0), chart = 3 },	-- 6
	{scale = NM(50.0), chart = 6 },	-- 7
	{scale = NM(100),  chart = 6 },	-- 8
}

default_scale = chart_defaults[4].scale
default_chart = chart_defaults[4].chart

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
	map_pages[#map_pages + 1] = default_map(1)	--,x_bullseye,z_bullseye)
	map_pages[#map_pages + 1] = default_map(2)	--,x_bullseye,z_bullseye)
	map_pages[#map_pages + 1] = default_map(3)	--,x_bullseye,z_bullseye)
	map_pages[#map_pages + 1] = default_map(4)	--,x_bullseye,z_bullseye)
	map_pages[#map_pages + 1] = default_map(5)	--,x_bullseye,z_bullseye)
	map_pages[#map_pages + 1] = default_map(6)	--,x_bullseye,z_bullseye)
	map_pages[#map_pages + 1] = default_map(7)	--,x_bullseye,z_bullseye)
	map_pages[#map_pages + 1] = default_map(8)	--,x_bullseye,z_bullseye)
end

number_of_additional_pages = 2
