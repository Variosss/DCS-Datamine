dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.common_script_path.."ViewportHandling.lua")
indicator_type       = indicator_types.COMMON

----------------------
-- TODO: to do it really configurable
local HUD_only_on_start = false

init_pageID     = 1

if HUD_only_on_start then 
	purposes 	 	 		   = {100,render_purpose.HUD_ONLY_VIEW} --100 as guard to switch off general in cockpit rendering , cause purposes cannot be empty
else
	purposes 	 	 		   = {100} --100 as guard to switch off general in cockpit rendering , cause purposes cannot be empty
end
--subset ids
BASE    = 1
OVERLAY = 2
MAP     = 3
OBJECTS = 4

page_subsets  =
{
	[BASE]     = LockOn_Options.common_script_path.."KNEEBOARD/indicator/base_page.lua",
	[OVERLAY]  = LockOn_Options.common_script_path.."KNEEBOARD/indicator/overlay_page.lua",
	[OBJECTS]  = LockOn_Options.common_script_path.."KNEEBOARD/indicator/objects_page.lua",
}


pages = {{BASE,MAP,OVERLAY}}

GetSelf():Add_Map_Page(MAP,LockOn_Options.common_script_path.."KNEEBOARD/indicator/map_page.lua")

custom_images = {}

lfs = require("lfs")
number_of_additional_pages = 0
function scan_path(path)
	if not path then 
		return
	end
	for file in lfs.dir(path) do
		if file ~= "." and
		   file ~= ".." and 
		   file ~= ".svn" and 
		   file ~= "_svn"  then        
		   local fn = path.."/"..file
		   local attr = lfs.attributes (fn)
		   
		   local ext = string.sub(file,  -4) 
		   if attr.mode	 ~= "directory" then
			  if '.lua' == ext then
				  page_subsets[#page_subsets  + 1] = fn;
				  
				  local idx = #pages + 1 
				  pages[idx]				   = {BASE,#page_subsets}
				  number_of_additional_pages  = number_of_additional_pages + 1 
				  if string.sub(file,1,-5) == "1" then 
					 default_page =  idx
				  end
			  elseif '.dds' == ext or
			         '.bmp' == ext or
					 '.jpg' == ext or
					 '.png' == ext or
					 '.tga' == ext then
					custom_images[#custom_images  + 1] = fn --they will generates from C++
					number_of_additional_pages  	   = number_of_additional_pages + 1
			  end
		   end
		end
	end
end

--custom pages located in unit cockpit folder 
scan_path(LockOn_Options.script_path.."KNEEBOARD/pages")

local terrain_path = get_terrain_related_data("KNEEBOARD")
local common_path  = LockOn_Options.common_script_path.."KNEEBOARD/indicator/CUSTOM"
local user_path    = lfs.writedir().."KNEEBOARD"
local unit_name    = get_aircraft_type()

if unit_name ~= nil then
	if terrain_path then
		scan_path(terrain_path..'/'..unit_name)
	end
	scan_path(common_path ..'/'..unit_name)
	scan_path(user_path ..'/'..unit_name)
end

scan_path(terrain_path)
scan_path(common_path)
scan_path(user_path)


specific_element_id =
{
	STEERPOINT = 0,  
	RED_ZONE   = 1,
	SELF_MARK  = 2,
	TARGET_LOCATION = 3,
}

specific_element_names = {
	[specific_element_id.STEERPOINT] 		= "el_steerpoint",
	[specific_element_id.RED_ZONE]   		= "el_red_zone",
	[specific_element_id.SELF_MARK]  		= "el_self_mark_point",
	[specific_element_id.TARGET_LOCATION]	= "el_target_point",
}
function get_template(name)
	return OBJECTS
end

function get_specific_element_name_by_id(id)
	return specific_element_names[id] or "el_steerpoint"
end

if is_left == nil then
   is_left =  false
end


--used for in mission and auto scanned folders 
image_page_template  = [[ 
x  = 1 
y  = GetAspect()
SetScale(1)
picture = CreateElement 'ceTexPoly'
picture.name = 'picture'
picture.vertices   	 = {{-x,y},{x,y},{ x,-y},{-x,-y}}
picture.indices	  	 = {0,1,2;0,2,3}
picture.tex_coords   = {{0,0},{1,0},{1,1},{0,1}}
picture.h_clip_relation = 1
picture.level			= 16
picture.blend_mode		= 3
picture.material = '%s'
Add(picture)
]]

allow_manual_viewport_placement = true
manual_viewport_dlg				= "Scripts/UI/KneeboardCanvas.dlg"
manual_viewport_margin_left  	= 32
manual_viewport_margin_right 	= 0
manual_viewport_margin_up    	= 0
manual_viewport_margin_bottom	= 4


update_screenspace_diplacement(SelfWidth/SelfHeight,is_left)

if  is_left then 
	dedicated_viewport[1] 		 = dedicated_viewport[1] 	  + manual_viewport_margin_left
end

dedicated_viewport_arcade = dedicated_viewport
