dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.common_script_path.."tools.lua")

SetScale(FOV)
dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_sizes.lua")
SetCustomScale(x_size)

local use_make_material = true

if  disposition == nil then
	if GetRenderTarget() == 1 then	
		disposition = "L"
	else								
		disposition = "R" 	end
end

if disposition == "L" then 
	DEFAULT_LEVEL		= 4 
else					   
	DEFAULT_LEVEL  		= 6
end

local     texture 					 = get_render_to_texture()
default_aspect,meters_per_lon_degree = get_lat_lon_scaling()

function NM(nm)
	return nm * 1852.0 / meters_per_lon_degree
end

local default_size = NM(5)
local patt_ = "%s %02.f %06.3f\n%s%03.f %06.3f"

function lat_lon_disp_(lat,lon)
			   
	local hemisphere_NS = (lat > 0) and "N" or "S"
	local hemisphere_EW = (lon > 0) and "E" or "W"
	
	lat = math.abs(lat)
	lon = math.abs(lon)
	
		
	local _lat,mm_lat = math.modf(lat,1.0)
	local _lon,mm_lon = math.modf(lon,1.0)
		
	mm_lon = mm_lon * 60
	mm_lat = mm_lat * 60

	return string.format(patt_,
						 hemisphere_NS,
						 _lat,
						 mm_lat,
						 hemisphere_EW,
						 _lon,
						 mm_lon)
end


local BLACK_  = MakeMaterial(nil,{0,0,0,255})
local FONT_   = MakeFont({used_DXUnicodeFontData = "font_dejavu_lgc_sans_22"},{0,255,0,255})

-- NOTE: the function is currently not used
function tad_chart(chart_id,material,lat_min,lat_max,lon_min,lon_max,chart_aspect)

local  			lat_center =  (lat_min + 0.5*(lat_max - lat_min))/default_aspect
local  			lon_center =  (lon_min + 0.5*(lon_max - lon_min))
local           sz_x =  0.5*(lat_max - lat_min) / chart_aspect
local           sz_z =  0.5*(lon_max - lon_min)

local 			draw_lat_center = (lat_min + 0.5*(lat_max - lat_min))/chart_aspect
local 			draw_lon_center = lon_center

local chart		    = create_chart(chart_id,lat_min / default_aspect,lat_max / default_aspect,lon_min,lon_max)
local chart_box     = {min = {x = -sz_x,z = -sz_z},max = {x =  sz_x,z =  sz_z}}
local chart_center  = chart:get_center()
local k 		    = chart_aspect / default_aspect

local 	element					= CreateElement "ceTexPoly"
		element.name 			= string.upper(material)
		element.primitivetype   = "triangles"
		if use_make_material then
			element.material	   	= MakeMaterial("tad/"..material..'.bmp.dds',{255,255,255,255})
		else
			element.material	   	= material
		end
		if texture then
			element.vertices        ={{ chart_box.min.x , chart_box.min.z},
									  { chart_box.min.x , chart_box.max.z},
									  { chart_box.max.x , chart_box.max.z},
									  { chart_box.max.x , chart_box.min.z}}
			element.init_pos		= { chart_center.z,0,chart_center.x}
			element.init_rot		= {0,0,90}
			element.screenspace		= 2
			element.worldspace		= true
		else
			element.vertices        ={{ (chart_box.min.x / default_size), k * (chart_box.min.z  / default_size)},
									  { (chart_box.min.x / default_size), k * (chart_box.max.z  / default_size)},
									  { (chart_box.max.x / default_size), k * (chart_box.max.z  / default_size)},
									  { (chart_box.max.x / default_size), k * (chart_box.min.z  / default_size)}}
			element.controllers		= {{"tad_pos_symbology_available"}, {"tad_depress",GetScale(),GetScale()},
									   {"tad_chart_relative_position",draw_lat_center * k , draw_lon_center,GetScale(),GetScale(),1},
									   {"tad_chart_scale_position"   ,default_size , default_size },
									   {"video_brightness",0.1,1.0,1.0/63.0},
									   {"video_contrast"  ,0  ,1.0,1.0/32.0}
									   }
		end
		element.indices			= {0,1,2;0,2,3}
		element.tex_coords		= {{0,1},
								   {0,0},
								   {1,0},
								   {1,1}}	
		element.use_mipfilter 	= true
		element.h_clip_relation = h_clip_relations.COMPARE
		element.level 		    = DEFAULT_LEVEL
	    Add(element)
	    --local use_box = true
		if use_box then
		local    box				= CreateElement "ceMeshPoly"
				 box.primitivetype  = "lines"
				 box.material	   	= "DBG_GREEN"
				 box.vertices       = element.vertices
				 if texture then
					box.screenspace	= 2
					box.worldspace		= true
				 end
				 box.indices			= {0,1,1,2,2,3,3,0}
				 box.parent_element		=  element.name

			   Add(box)
			   
		local   text						= CreateElement "ceStringPoly"
				text.alignment				= "CenterCenter"
				text.value					= string.upper(material)..'\n'..
											  lat_lon_disp_(lat_min + 0.5*(lat_max - lat_min),
														    lon_min + 0.5*(lon_max - lon_min))
				text.material				= FONT_
				text.stringdefs				= {(5 * (chart_id - 3) + 1)*0.005,(4 * (chart_id - 3) + 1)*0.003,0,0}
				text.UseBackground			= true
				text.BackgroundMaterial		= BLACK_
				text.parent_element			=  element.name
				text.use_mipfilter = true
				Add(text)
				
		local    center_				= CreateElement "ceMeshPoly"
				 center_.primitivetype  = "lines"
				 center_.material	   	= "DBG_GREEN"
				 center_.vertices       = element.vertices
				 if texture then
					center_.screenspace	= 2
					center_.worldspace		= true
				 end
				 center_.indices			= {0,2,1,3}
				 center_.parent_element		=  element.name

			   Add(center_)		
		end
		chart:add_element(element)
end
