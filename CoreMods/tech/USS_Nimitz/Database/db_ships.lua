local function ship_file(f)
	if dofile(f) then
		error("can't load file "..f)
		return
	end
	if(GT) then
		GT.shape_table_data = 
		{
			{
				file  	    = GT.visual.shape;
				username    = GT.Name;
				desrt       = GT.visual.shape_dstr;
			    classname 	= "lLandShip";
				positioning = "BYNORMAL";
			},
			{
				name  = GT.visual.shape_dstr;
				file  = GT.visual.shape_dstr;
			},
		}
		add_surface_unit(GT)
		GT = nil;
	else
		error("GT empty in file "..f)
	end;
end


local function runway_centerline(x)
	
	local p1 = {-43.836  ,-9.9819}
	local p2 = {-159.6597, 8.999}

	local dz  = p2[2] - p1[2]
	local dx  = p2[1] - p1[1]
	local rw  = -math.deg(math.atan2(dz,dx))

	return  {x,20.5,(dz/dx) * (x - p1[1]) + p1[2],rw,3.6}
end


CVN_7X_LSOView  = {cockpit = "empty", position = {--[[connector = "",]] offset = runway_centerline(-14.0) }}

local LSO_Station = { HQ_model = "LSO_HQ" 		 , dockConnector  = "LSO_Connection" , hide_argument = 821 , cameraPos 			=  {-130,21.75,-21,190}}

local hangar_camera_floor = 8.8
local hangar_camera_ceil = hangar_camera_floor + 6.4
local hangar_camera_ceil_left_front = hangar_camera_floor + 4.7
local hangar_camera_ceil_front = hangar_camera_floor + 2.5
local hangar_camera_ceil_low = hangar_camera_floor + 1.8
local hangar      = {
	HQ_model			= "Nimitz_Hangar", 
	dockPos				= {0,0,0},
	indoor				= true, 
	cameraPosLocal		= {-113,8.7 + 1.75,-10,10},
--[[	
		---------------------------------------------------
		|-------------------------------------------------|
		||                 front low                     ||   
		|-------------------------------------------------|   
		||                     |                         ||   
		||   left front middle |     right front middle  ||   
		||                     |                         ||   
		|-------------------------------------------------|   
		||  |                                         |  ||
		||  |                                         |  ||   
		||  |                                         |  ||   
  left front|                                         |right front
		||  |                                         |  ||
		||  |                                         |  ||
		||  |                                         |  ||   
		||  |                                         |  ||   
		|---|                                         |---|   
		|---|                                         |---|   
		||  |                                         |  ||
		||  |                                         |  ||
		||  |                                         |  ||
		||  |                                         |  ||
		||  |                                         |right middle
		||  |                middle                   |  ||
 left middle|                                         |---|
		||  |                                         |   |
		||  |                                         |---|
		||  |                                         |  ||
		||  |                                         |right middle low
		|---|                                         |---|   
		|---|                                         |---|   
		||  |                                         |  ||
		||  |                                         |  ||
		||  |                                         |  ||
		||  |                                         |  ||   
		||  |                                         |  ||   
   left back|                                         |right back
		||  |   /                                     |  ||   
		||  |  * cameraPosLocal                       |  ||   
		||  |                                         |  ||   
		|-------------------------------------------------|  
		---------------------------------------------------
--]]	
	cameraLimitsLocal	= 
	{
		{
			-- old outer contour
			--box 		= {-127,8.8,-19, 72,8.8 + 2.5,19}, -- in model space (x,y,z,X,Y,Z)
			
			-- internal free area
			-- middle
			box 		= {-126,hangar_camera_floor,-12.5, 50,hangar_camera_ceil,12},		
			boxPosLocal = {0,0,0,0}, -- origin to model
		},
		{
			-- front low
			box 		= {68,hangar_camera_floor,-15, 72,hangar_camera_ceil_front,15},		
			boxPosLocal = {0,0,0,0},
		},			
		{
			-- right front middle
			box 		= {50,hangar_camera_floor,-1.5, 68,hangar_camera_ceil,15},		
			boxPosLocal = {0,0,0,0},
		},
		{
			-- right front
			box 		= {7,hangar_camera_floor,11, 68,hangar_camera_ceil,15},		
			boxPosLocal = {0,0,0,0},
		},
		{
			-- right middle
			box 		= {-43,hangar_camera_floor,11, -5,hangar_camera_ceil,15},		
			boxPosLocal = {0,0,0,0},
		},
		{
			-- right middle low
			box 		= {-61,hangar_camera_floor,11, -51,hangar_camera_ceil_low,16},		
			boxPosLocal = {0,0,0,0},
		},
		{
			-- right back
			box 		= {-127,hangar_camera_floor,11, -65,hangar_camera_ceil,15},		
			boxPosLocal = {0,0,0,0},
		},
		{
			-- left front middle
			box 		= {50,hangar_camera_floor,-16, 68,hangar_camera_ceil_left_front,-1.5},		
			boxPosLocal = {0,0,0,0},
		},
		{
			-- left front
			box 		= {6,hangar_camera_floor,-16, 50,hangar_camera_ceil,-12},		
			boxPosLocal = {0,0,0,0},
		},
		{
			-- left middle
			box 		= {-61,hangar_camera_floor,-16, 2.5,hangar_camera_ceil,-12},		
			boxPosLocal = {0,0,0,0},
		},
		{
			-- left back
			box 		= {-127,hangar_camera_floor,-16, -65,hangar_camera_ceil,-12},		
			boxPosLocal = {0,0,0,0},
		},
	},
}

-- virtual station on the deck
local supercarrier = {
	HQ_model			= "Nimitz_Deck", 
	dockPos				= {0, 0, 0},
	cameraPosLocal 		= {0, 21.75, 0},
	cameraLimitsLocal	= 
	{
		{
			box 		= {-171, 20.5, -46,  170, 65, 42},		
			boxPosLocal = {0, 0, 0, 0}, -- origin to model
		},
	},
}

local br_camera_floor = 0.1
local br_camera_ceil = 3.0
local br_camera_front = -6.0
local br_camera_back = 3.2
local br_camera_left = 1.2
local br_camera_right = -5.1
local br_camera_seats_height = 1.1
local briefing_room = {
	HQ_model = "Nimitz_Briefing_Room",
	dockPos = {0, 0, 0},
	cameraPosLocal = {0.0, 1.75, -2.5},
	cameraLimitsLocal	= 
	{
		{
			box 		= {br_camera_front, br_camera_floor, br_camera_right,  br_camera_back, br_camera_ceil, br_camera_left},		
			boxPosLocal = {0, 0, 0, 0}, -- origin to model
		},
	},
}

function  CVN_7X_STATIONS(idx)

	local  boss_shape 	  = nil
	
	if idx > 72 then 
		boss_shape = "AirBoss_73-75-CPT"
	else
		boss_shape = "AirBoss_71-72-CPT"
	end
	
	return
	{
		SUPERCARRIER = supercarrier,
		LSO    = LSO_Station,				
		BOSS   = {
			HQ_model 			= boss_shape, 
			dockConnector  		= string.format("AirBoss_Connector_%d",idx), 
			hide_argument 		= 67  ,
			cameraPosLocal 	=  {2,1.75,1,0},
			cameraLimitsLocal   = 
			{
				{
					box 		= {-0.89,0.4,-2.0,	3.0,2.0,2.0}, -- in model space (x,y,z,X,Y,Z)
					boxPosLocal = { 0,0,0,0}, -- origin to model
				},
				{
					box 		= {-1.0,0.4,-2.0,	1.0,2.0,2.0}, -- in model space
					boxPosLocal = {-1,0,-0.3,-37}, -- origin to model
				},
			},
		},
		HANGAR = hangar,
		BRIEFING_ROOM = briefing_room,		
	}
end

ship_file(current_mod_path.."/Database/USS_CVN_71.lua")
ship_file(current_mod_path.."/Database/USS_CVN_72.lua")
ship_file(current_mod_path.."/Database/USS_CVN_73.lua")
ship_file(current_mod_path.."/Database/USS_CVN_74.lua") -- Stennis
ship_file(current_mod_path.."/Database/USS_CVN_75.lua")
ship_file(current_mod_path.."/Database/Arleigh_Burke_IIa.lua")

lock_player_interaction("CVN_71")
lock_player_interaction("CVN_72")
lock_player_interaction("CVN_73")
lock_player_interaction("CVN_75")
lock_player_interaction("USS_Arleigh_Burke_IIa")
