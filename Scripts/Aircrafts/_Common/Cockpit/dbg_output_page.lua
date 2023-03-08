dofile(LockOn_Options.common_script_path.."elements_defs.lua")
SetScale(FOV)
function AddElement(object)
    object.use_mipfilter = true
    Add(object)
end

local width  = 1;
local height = 1

local aspect    = 1
local dxx 		= 0
local dxy 		= 0

function pixels(p)
	return 2 * p / 768
end

local sz  		= pixels(256)
local spacing   = pixels(5)

local tex_dummy   = CreateElement "ceSimple"
      tex_dummy.name = "tex_dummy"
	  tex_dummy.init_pos = {-width,height} 
AddElement(tex_dummy)

local back2  = CreateElement "ceMeshPoly"




local BLACK_  = MakeMaterial(nil,{0,0,0,255})
local GREEN_  = MakeMaterial(nil,{0,255,0,255})
local FONT_   = MakeFont({used_DXUnicodeFontData = "font_dejavu_lgc_sans_22"},{0,255,0,255})

back2.name     	    =  "back2"
back2.material 	    =  GREEN_
back2.primitivetype = "lines"
back2.vertices 	    = {{-width, height},
					  { width, height},
					  { width,-height},
					  {-width,-height}}
back2.indices	    = {0,1,1,2,2,3,3,0}
AddElement(back2)

local back3  = CreateElement "ceMeshPoly"

back3.name     	    =  "back3"
back3.material 	    =  GREEN_
back3.primitivetype = "lines"
back3.vertices 	    = {{-width + 0.02, height - 0.02},
					  {  width - 0.02, height - 0.02},
					  {  width - 0.02,-height + 0.02},
					  { -width + 0.02,-height + 0.02}}
back3.indices	    = {0,1,1,2,2,3,3,0}
AddElement(back3)


function add_texture_view(name,mirrored)

	local back  = CreateElement "ceMeshPoly"
	
	
	back.material 	   =  BLACK_
	back.primitivetype = "triangles"
	back.vertices = {{ 0,  0},
				     {sz,  0},
				     {sz, -sz},
				     { 0, -sz}}
	back.indices	 = {0,1,2;0,2,3}
	back.init_pos   = {(spacing + 1) * dxx * sz, -(spacing + 1) * dxy * sz} 
	back.parent_element = tex_dummy.name
	AddElement(back)

	local tx  = CreateElement "ceTexPoly"
	
	
	tx.material  = MakeMaterial(name,{255,255,255,255}) --"render_target_3"
	tx.vertices  = back.vertices
	tx.indices	 = back.indices
	if mirrored then
		tx.tex_coords = {{1,0},{0,0},{0,1},{1,1}}
	else 
		tx.tex_coords = {{0,0},{1,0},{1,1},{0,1}}
	end
	tx.parent_element = back.name
	AddElement(tx)
	
	local   box					= CreateElement "ceMeshPoly"
			box.primitivetype  	= "lines"
			box.material	   	= GREEN_
			box.vertices       	= tx.vertices
			box.indices			= {0,1,1,2,2,3,3,0}
			box.parent_element	=  tx.name
			box.screenspace 	= ScreenType.SCREENSPACE_TRUE
			AddElement(box)
			   
	local   text						= CreateElement "ceStringPoly"
			text.alignment				= "LeftTop"
			text.value					= string.upper(name)
			text.material				= FONT_
			text.stringdefs				= {0.003,0.5 * 0.003,0,0}
			text.UseBackground			= true
			text.BackgroundMaterial		= BLACK_
			text.parent_element			= tx.name
			text.use_mipfilter = true
		    AddElement(text)
			
	dxx = dxx  + 1
	local x = (spacing + 1) * dxx * sz
	if x > 2 * aspect - sz then
	   dxy = dxy + 1
	   dxx = 0
	end 
end

add_texture_view("mfd0")



