dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(FOV)
function AddElement(object)
    object.use_mipfilter = true
    Add(object)
end


local BLACK_  = MakeMaterial(nil,{0,0,0,50})
local BLACK_2 = MakeMaterial(nil,{0,0,0,250})
local BLUE_   = MakeMaterial(nil,{0,0,255,125})
local GRID_   = MakeMaterial(nil,{255,255,255,50})
local FONT_   = MakeFont({used_DXUnicodeFontData = "font_dejavu_lgc_sans_22_white"},{255,255,255,255})


local back   = CreateElement "ceMeshPoly"
local width  = 1;
local height = width * GetAspect()
local h = 0.045
local w = 0.3 * h
local text_params = {h,w,0,0}
	
	
back.name     	   =  "back"
back.material 	   =  BLACK_
back.primitivetype = "triangles"
back.vertices 	   = {{-width, height},
					  { width, height},
					  { width,-height},
					  {-width,-height}}
back.indices	  = {0,1,2;0,2,3}
back.controllers  = {{"show"},
					 {"real_time_scale_update"}}
AddElement(back)

local color_palletes = 
{
	{255,242,0,255},
	{0,123,196,255},
	{230,87,20,255},
	{54,154,61,255},
	{244,224,200,255},
	{205,231,246,255},
	{66,180,172,255},
	{191,46,123,255},
	{125,99,169,255},
	{176,0,30,255},
	{211,152,21,255},
	{236,131,173,255},
	{129,94,74,255},
	{27,117,196,255},
	{200,235,125,255},
	{200,200,102,255}
}

local back2  = CreateElement "ceMeshPoly"

back2.name     	   =  "back2"
back2.material 	   =  BLUE_
back2.primitivetype = "lines"
back2.vertices 	   = back.vertices 
back2.indices	   = {0,1,1,2,2,3,3,0}
back2.parent_element = back.name
AddElement(back2)

local zero_line 		 = CreateElement "ceMeshPoly"	
zero_line.name     	     =  "zero_line"
zero_line.material 	     =  BLUE_
zero_line.controllers    = {{"zero_line_position"}}
zero_line.primitivetype  = "lines"
zero_line.vertices 	     = {{-width, 0},{width,0}}
zero_line.indices	     = {0,1}
zero_line.parent_element = back.name
AddElement(zero_line)


for i = 0,50 do
	local ordinata_mark 		 = CreateElement "ceMeshPoly"	
	ordinata_mark.name     	     =  "ordinata_mark_"..tostring(i)
	ordinata_mark.material 	     =  GRID_
	ordinata_mark.controllers    = {{"ordinata_mark_line",i,1}}
	ordinata_mark.primitivetype  = "lines"
	ordinata_mark.vertices 	     = {{-width, 0},{width,0}}
	ordinata_mark.indices	     = {0,1}
	ordinata_mark.parent_element = back.name
	AddElement(ordinata_mark)
end

for i = 0,100 do
	local abscissa_mark 		 = CreateElement "ceMeshPoly"	
	abscissa_mark.name     	     =  "abscissa_mark_"..tostring(i)
	abscissa_mark.material 	     =  GRID_
	abscissa_mark.controllers    = {{"abscissa_mark_line",i,1}}
	abscissa_mark.primitivetype  = "lines"
	abscissa_mark.vertices 	     = {{0,-height},{0,height}}
	abscissa_mark.indices	     = {0,1}
	abscissa_mark.parent_element = back.name
	AddElement(abscissa_mark)
end

for i = 0,100 do
	local   abscissa_mark_text				= CreateElement "ceStringPoly"
	abscissa_mark_text.name					= "abscissa_mark_text"..tostring(i)
	abscissa_mark_text.alignment			= "CenterCenter"
	abscissa_mark_text.formats				= {"%.1f"}
	abscissa_mark_text.material				= FONT_
	abscissa_mark_text.stringdefs			= text_params
	abscissa_mark_text.parent_element		=  back.name
	abscissa_mark_text.controllers    		= {{"zero_line_position"},
											   {"abscissa_mark_line",i,5},
											   {"abscissa_mark_text",0}}		
	abscissa_mark_text.use_mipfilter = true
	AddElement(abscissa_mark_text)	
end

local colors = {}
for i=1,#color_palletes do
	colors[i]			   = MakeMaterial(nil,color_palletes[i])
	local 	channel		   = CreateElement "ceSimpleLineObject"
			channel.name     	   = "channel_"..tostring(i)
			channel.material 	   =  colors[i]
			channel.primitivetype  = "lines"
			channel.controllers    = {{"chart_channel",i - 1}}
			channel.init_pos       = { -width,-height}
			channel.parent_element = back.name
	AddElement(channel)
end

for i=1,#color_palletes do

	local 	legend				   = CreateElement "ceStringPoly"
			legend.name     	   = "channel_legend"..tostring(i)
			legend.material 	   =  FONT_
			legend.alignment	   = "LeftCenter"
			legend.UseBackground   =  true
			legend.BackgroundMaterial   = BLACK_2
			
			legend.stringdefs 	   =  text_params
			legend.controllers     = {{"channel_legend",i - 1,
														color_palletes[i][1]/255,
														color_palletes[i][2]/255,
														color_palletes[i][3]/255}}
			legend.init_pos        = { -width,-height + 0.1  + h * (i - 1)}
			legend.parent_element  = back.name
	AddElement(legend)
end

