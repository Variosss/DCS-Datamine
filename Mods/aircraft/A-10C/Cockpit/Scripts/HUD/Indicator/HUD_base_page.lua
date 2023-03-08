dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

function from3dsMaxVertex(x_3dsmax,y_3dsmax,z_3dsmax)
	return {-y_3dsmax/GetScale(),z_3dsmax/GetScale(),x_3dsmax/GetScale()}
end

glass = CreateElement "ceMeshPoly"
glass.vertices = {	
			from3dsMaxVertex(	1.2213,	-0.1018,	-0.3586),
			from3dsMaxVertex(	0.9527,	-0.1018,	-0.0384),
			from3dsMaxVertex(	1.2200,	-0.1018,	-0.3597),
			from3dsMaxVertex(	0.9513,	-0.1018,	-0.0396),
			from3dsMaxVertex(	0.9527,	 0.1018,	-0.0384),
			from3dsMaxVertex(	1.2213,	 0.1018,	-0.3586),
			from3dsMaxVertex(	1.2200,	 0.1018,	-0.3597),
			from3dsMaxVertex(	0.9513,	 0.1018,	-0.0396),
			from3dsMaxVertex(	1.0239,	-0.1083,	-0.0407),
			from3dsMaxVertex(	1.3161,	-0.1083,	-0.3890),
			from3dsMaxVertex(	1.3161,	 0.1083,	-0.3890),
			from3dsMaxVertex(	1.0239,	 0.1083,	-0.0407),
			from3dsMaxVertex(	1.3147,	-0.1083,	-0.3901),
			from3dsMaxVertex(	1.0225,	-0.1083,	-0.0419),
			from3dsMaxVertex(	1.0225,	 0.1083,	-0.0419),
			from3dsMaxVertex(	1.3147,  0.1083,	-0.3901),
}

glass.indices = { 
			 0 ,    5 ,    4 ;
			 4 ,    1 ,    0 ;
			 2 ,    3 ,    7 ;
			 7 ,    6 ,    2 ;
			 3 ,    2 ,    0 ;
			 0 ,    1 ,    3 ;
			 1 ,    4 ,    7 ;
			 7 ,    3 ,    1 ;
			 7 ,    4 ,    5 ;
			 5 ,    6 ,    7 ;
			 0 ,    2 ,    6 ;
			 6 ,    5 ,    0 ;
			 9 ,   10 ,   11 ;
			11 ,    8 ,    9 ;
			12 ,   13 ,   14 ;
			14 ,   15 ,   12 ;
			 8 ,   11 ,   14 ;
			14 ,   13 ,    8 ;
			13 ,   12 ,    9 ;
			 9 ,    8 ,   13 ;
			12 ,   15 ,   10 ;
			10 ,    9 ,   12 ;
			14 ,   11 ,   10 ;
			10 ,   15 ,   14 ;
}
glass.material		  = "INDICATION_COMMON_RED"
glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL
glass.level			  = HUD_NOCLIP_LEVEL
glass.isdraw		  = true
glass.isvisible		  = false
glass.controllers     = {{"set_origin_to_cockpit_shape"}}  -- as geometry exported from max is better to render with same origin as cockpit shape

Add(glass)

total_field_of_view = CreateElement "ceMeshPoly"
total_field_of_view.name = "total_field_of_view"
total_field_of_view.primitivetype = "triangles"

num_points = 32
step = math.rad(360.0/num_points)

verts = {}
for i = 1, num_points do
	verts[i] = { TFOV * math.cos(i * step), TFOV * math.sin(i * step)}
end

total_field_of_view.vertices = verts

inds = {}
j = 0
for i = 0, 29 do
	j = j + 1
	inds[j] = 0
	j = j + 1
	inds[j] = i + 1
	j = j + 1
	inds[j] = i + 2
end

total_field_of_view.indices			= inds
total_field_of_view.init_pos		= FROM_HUD_CENTER(0,-9)
total_field_of_view.material		= "DBG_RED"
total_field_of_view.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view.level			= HUD_DEFAULT_LEVEL - 1
total_field_of_view.isdraw			= true
total_field_of_view.change_opacity	= false
total_field_of_view.collimated 		= true
total_field_of_view.isvisible		= HUD_SHOW_FOV
Add(total_field_of_view)


DrawRefLines = false

if DrawRefLines then

	local material 	    = MakeMaterial("<REF_LINES>", 	   {200,50,200, 255})
	
	local font     		= MakeFont({used_DXUnicodeFontData = "font_dejavu_lgc_sans_22_white"}, {200,50,200, 255})
	local cross = function(init_pos,span,label)
		local cross           	= CreateElement "ceMeshPoly"
			cross.primitivetype   = "lines"
			cross.vertices        = { {-0.5 * span, 0.0},
									  { 0.5 * span, 0.0},
								    { 0,-0.5 * span},
									{ 0, 0.5 * span}}
									
									
			cross.indices         = {0, 1, 2,3}
			cross.material        = material
			cross.init_pos        = init_pos or {0, 0, 0}
			cross.collimated      = true
		Add(cross)
		
		local   lab					= CreateElement "ceStringPoly"
			lab.alignment			= "LeftCenter"
			lab.value				= label or "<REF>"
			lab.material			= font
			lab.stringdefs			= {0.01,0.003,0,0}
			lab.use_mipfilter 		= true
			lab.init_pos        	= {0.5 * span,0}
			lab.parent_element    	= cross.name
			lab.collimated		    = true
		Add(lab)	
		
		return cross
	end
	
	
	
	local ZSL_ref 			= cross(nil,40,"ZSL")
	ZSL_ref.controllers 	= {{"ZeroLine"}}

	local GBL_ref 			= cross({0,GBL_CROSS_pos,0},20,"GBL")
	
	
	local HUD_center		= cross(FROM_HUD_CENTER(0,0),20,"HUD_CENTER")
	
end

--------------------------------------------------------------------------------

-- reference grid
--drawIndicatorRefGrid(17, 10, 260, true, 170)

if _DEBUG_ then

local 	dbg_solution 		   		= CreateElement "ceMeshPoly"
		dbg_solution.name       	= "dbg_solution"
		dbg_solution.primitivetype  = "triangles"
		dbg_solution.vertices   	= {{-2, 2},
									   { 2, 2},
									   { 2,-2},
									   {-2,-2},
									   }
		dbg_solution.indices    	= default_box_indices
		dbg_solution.material   	= "INDICATION_COMMON_RED"
		dbg_solution.controllers	= {{"dbg_solution_point"}}
		dbg_solution.collimated 	= true
		dbg_solution.additive_alpha = true
		Add(dbg_solution)

local 	dbg_SPI		   			= CreateElement "ceMeshPoly"
		dbg_SPI.name       		= "dbg_SPI"
		dbg_SPI.primitivetype   = "triangles"
		dbg_SPI.vertices   		= {{-2, 2},
								   { 2, 2},
								   { 2,-2},
								   {-2,-2},
								   }
		dbg_SPI.indices    	= default_box_indices
		dbg_SPI.material   	= "INDICATION_COMMON_BLUE"
		dbg_SPI.controllers	= {{"dbg_spi_point"}}
		dbg_SPI.collimated 	= true
		dbg_SPI.additive_alpha = true
		Add(dbg_SPI)
	
end
