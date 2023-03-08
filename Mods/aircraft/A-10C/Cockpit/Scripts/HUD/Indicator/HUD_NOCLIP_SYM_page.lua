dofile(LockOn_Options.script_path.."HUD/Indicator/HUD_definitions.lua")

-- This page must be placed after all other pages - 
--		total FOV becomes invalid after this page elements are drawn

NoClipSymbologyBox_sizeX = 230
NoClipSymbologyBox_sizeY = NoClipSymbologyBox_sizeX

NoClipSymbologyBox = CreateElement "ceMeshPoly"
NoClipSymbologyBox.name = "NoClipSymbologyBox"
NoClipSymbologyBox.primitivetype = "triangles"

NoClipSymbologyBox.vertices	= {{-NoClipSymbologyBox_sizeX, -NoClipSymbologyBox_sizeY},
							{-NoClipSymbologyBox_sizeX, NoClipSymbologyBox_sizeY},
							{NoClipSymbologyBox_sizeX, NoClipSymbologyBox_sizeY},
							{NoClipSymbologyBox_sizeX, -NoClipSymbologyBox_sizeY}
							}

NoClipSymbologyBox.indices		    = default_box_indices
NoClipSymbologyBox.init_pos		    = {0, 0, 0}
NoClipSymbologyBox.material		    = "DBG_BLUE"
NoClipSymbologyBox.h_clip_relation  = h_clip_relations.INCREASE_IF_LEVEL
NoClipSymbologyBox.level			= HUD_NOCLIP_LEVEL
NoClipSymbologyBox.isdraw			= true
NoClipSymbologyBox.change_opacity	= false
NoClipSymbologyBox.isvisible		= true
NoClipSymbologyBox.collimated		= true
Add(NoClipSymbologyBox)

---------------------------------------------------------
--[[
dbg_val1                 = CreateElement "ceStringPoly"
dbg_val1.name            = "dbg_val1"
dbg_val1.material        = "font_HUD_DBG"
dbg_val1.init_pos        = {-30, 0, 0}
dbg_val1.alignment       = "LeftCenter"
dbg_val1.stringdefs      = predefined_font_0
dbg_val1.additive_alpha	 = true
dbg_val1.collimated	     = true
dbg_val1.controllers     = {{"dbg_val1_txt"}}
dbg_val1.h_clip_relation = h_clip_relations.COMPARE
dbg_val1.level           = HUD_DEFAULT_LEVEL
dbg_val1.use_mipfilter	 = true
dbg_val1.formats         = {"TAU: %2.3f"}
Add(dbg_val1)

dbg_val2                 = Copy(dbg_val1)
dbg_val2.name            = "dbg_val2"
dbg_val2.init_pos        = {-30, -10, 0}
dbg_val2.controllers	 = {{"dbg_val2_txt"}}
dbg_val2.formats         = {"T: %2.3f"}
Add(dbg_val2)

dbg_val3                 = Copy(dbg_val1)
dbg_val3.name            = "dbg_val3"
dbg_val3.init_pos        = {-30, -20, 0}
dbg_val3.controllers	 = {{"dbg_val3_txt"}}
dbg_val3.formats         = {"   %2.3f"}
Add(dbg_val3)

dbg_val4                 = Copy(dbg_val1)
dbg_val4.name            = "dbg_val4"
dbg_val4.init_pos        = {-30, -30, 0}
dbg_val4.controllers	 = {{"dbg_val4_txt"}}
dbg_val4.formats         = {"   %2.3f"}
Add(dbg_val4)
--]]
---------------------------------------------------------

AddHUDTextElement_Pos("Steer_Point_Number_ID", 
				  {{"steer_point_number_id_txt", 0.1667}},
				  FROM_HUD_CENTER(70, -76.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

AddHUDTextElement_Pos_Formats("SPDis_to_go_Num_Targ_Elev", 
				  {{"SPDis_to_go_Num_Targ_Elev_txt", 0.1667}}, 
				  FROM_HUD_CENTER(70, -89), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter",
				  {"%s", "/", "%d", "DTS", "XXXX"})		  
				  
AddHUDTextElement_Pos("Time_on_Target", 
				  {{"Time_on_Target_txt"}}, 
				  FROM_HUD_CENTER(70, -101.5), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")				  				  

AddHUDTextElement_Pos("Current_Time", 
				  {{"hack_mode", 1}, {"Current_Time_txt"}}, 
				  FROM_HUD_CENTER(70, -114), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

HackTime		= AddHUDTextElement_Pos("HackTime",
				  {{"hack_mode", 2}, {"Time_to_Target_txt"}}, 
				  FROM_HUD_CENTER(70, -114), 
				  nil,
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")		

local len = 26
local halfheight = 5
local horshift = -1
local vertshift = 0.3
addHWLine("HackTimeBoxLine1", len, len, {{"hack_box"}}, 
			{horshift, halfheight + vertshift, 0}, {0, 0, 0}, "HackTime", HUD_DEFAULT_LEVEL)

addHWLine("HackTimeBoxLine2", len, len, {{"hack_box"}}, 
			{horshift, -halfheight + vertshift, 0}, {0, 0, 0}, "HackTime", HUD_DEFAULT_LEVEL)

addHWLine("HackTimeBoxLine3", halfheight * 2, halfheight * 2, {{"hack_box"}}, 
			{len + horshift, -halfheight + vertshift, 0}, {90, 0, 0}, "HackTime", HUD_DEFAULT_LEVEL)

addHWLine("HackTimeBoxLine4", halfheight * 2, halfheight * 2, {{"hack_box"}}, 
			{horshift, -halfheight + vertshift, 0}, {90, 0, 0}, "HackTime", HUD_DEFAULT_LEVEL)
		
DepressiblePipperOccultWndPnt2			= CreateDummy()
DepressiblePipperOccultWndPnt2.name		= "DepressiblePipperOccultWndPnt2"
DepressiblePipperOccultWndPnt2.level 	= HUD_DEFAULT_LEVEL
DepressiblePipperOccultWndPnt2.controllers	= {{"Depressible_Pipper_pos", ZSL}}
Add(DepressiblePipperOccultWndPnt2)				

clip_sizeX = 12
clip_sizeY = 12

DeprPipper_OccultVerts = {{-clip_sizeX, -clip_sizeY},
						  {-clip_sizeX, clip_sizeY},
						  {clip_sizeX, clip_sizeY},
						  {clip_sizeX, -clip_sizeY}
						 }

CloseOccultWnd("Depressible_Pipper_clip21",
			DeprPipper_OccultVerts,
			nil, 
			"DepressiblePipperOccultWndPnt2", 
			HUD_DEFAULT_LEVEL + 2)
			
CloseOccultWnd("Depressible_Pipper_clip22",
			DeprPipper_OccultVerts, 
			nil,
			"DepressiblePipperOccultWndPnt2", 
			HUD_DEFAULT_LEVEL + 1)

AddHUDTexElement("HookShip",
				{{-8, -8}, {-8, 8}, 
				{8, 8}, {8, -8}},
				{1.055/texture_size, 15.445/texture_size, tex_scale, tex_scale},
				{{"EGI_on"}, {"HookShip_pos", 158, ZSL}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)
	  
Hookship_RelBearing = AddHUDTextElement_Pos("Hookship_RelBearing",
				  {{"HookShip_IsSPI", 1}, {"SPI_RelativeBearing"}}, 
				  {-5.5, 13.0, 0.0}, 
				  "HookShip",
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

Hookship_Distance = AddHUDTextElement_Pos("Hookship_Distance",
				  {{"HookShip_IsSPI", 1}, {"SPI_distance"}}, 
				  {-5.5, -13.0, 0.0}, 
				  "HookShip",
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

HLL_stencil1X = 7.5

HLL_stencil1				= CreateElement "ceMeshPoly"
HLL_stencil1.name			= "HLL_stencil1"
HLL_stencil1.primitivetype	= "triangles"
HLL_stencil1.vertices		= {{-HLL_stencil1X, -HLL_stencil1X},
							   {-HLL_stencil1X, HLL_stencil1X},
							   {HLL_stencil1X, HLL_stencil1X},
							   {HLL_stencil1X, -HLL_stencil1X}
							  }
HLL_stencil1.indices  		= default_box_indices
HLL_stencil1.init_pos 		= {0, 0, 0}
HLL_stencil1.material 		= "DBG_RED"
HLL_stencil1.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
HLL_stencil1.level			= HUD_DEFAULT_LEVEL
HLL_stencil1.parent_element	= "HookShip"
HLL_stencil1.isdraw 		= true
HLL_stencil1.isvisible 		= false
HLL_stencil1.collimated		= true
Add(HLL_stencil1)


HLL_stencil2_X = 26
HLL_stencil2_Y = 8

HLL_stencil2				= Copy(HLL_stencil1)
HLL_stencil2.name			= "HLL_stencil2"
HLL_stencil2.vertices		= {{0, -HLL_stencil2_Y},
							   {0, HLL_stencil2_Y},
							   {HLL_stencil2_X, HLL_stencil2_Y},
							   {HLL_stencil2_X, -HLL_stencil2_Y}
							  }
HLL_stencil2.material 		= "DBG_GREEN"
HLL_stencil2.controllers    = {{"HLL_LocatorLine_Stencil"}}
HLL_stencil2.isvisible 		= false
Add(HLL_stencil2)

				  
HookShip_locator_line				 = CreateDummy()
HookShip_locator_line.name			 = "HookShip_locator_line"
HookShip_locator_line.parent_element = "HookShip"
HookShip_locator_line.controllers	 = {{"HookShip_locator_line"}}
Add(HookShip_locator_line)

AddHUDTexElement("HookShip_line1", 
				{{0, -2}, {0, 2}, 
				{20, 2}, {20, -2}},
				{0.24/texture_size, 16.75/texture_size, tex_scale, tex_scale},
				nil,
				{3.5, -3.0, 0.0},
				{0.0, 0.0, 0.0},
				"HookShip_locator_line",
				HUD_DEFAULT_LEVEL)

AddHUDTexElement("HookShip_line2", 
				{{0, -2}, {0, 2}, 
				{20, 2}, {20, -2}},
				{0.24/texture_size, 16.75/texture_size, tex_scale, tex_scale},
				nil,
				{3.5, 3.0, 0.0},
				{0.0, 0.0, 0.0},
				"HookShip_locator_line",
				HUD_DEFAULT_LEVEL)

HLL_stencil11					= Copy(HLL_stencil1)
HLL_stencil11.name				= "HLL_stencil11"
HLL_stencil11.material 			= "DBG_RED"
HLL_stencil11.h_clip_relation	= h_clip_relations.DECREASE_IF_LEVEL
HLL_stencil11.level				= HUD_DEFAULT_LEVEL + 1
HLL_stencil11.isdraw 			= true
HLL_stencil11.isvisible 		= false
Add(HLL_stencil11)

HLL_stencil21					= Copy(HLL_stencil2)
HLL_stencil21.name				= "HLL_stencil21"
HLL_stencil21.material 			= "DBG_RED"
HLL_stencil21.h_clip_relation	= h_clip_relations.DECREASE_IF_LEVEL
HLL_stencil21.level				= HUD_DEFAULT_LEVEL + 1
HLL_stencil21.isvisible 		= false
Add(HLL_stencil21)


Pipper_Reticle_pntOccultWnd1	= CreateDummy()
Pipper_Reticle_pntOccultWnd1.name	= "Pipper_Reticle_pntOccultWnd1"
Pipper_Reticle_pntOccultWnd1.level 	= HUD_DEFAULT_LEVEL
Pipper_Reticle_pntOccultWnd1.controllers =
	{{"MasterArmSafe", 0}, {"OccultWndModeContol"}, {"pipper_reticle_pos", ZSL, 100, TFOV, 28},
	 {"pipper_reticle_max_defl", 160, CCRP_MaxPiperDefl}}
Add(Pipper_Reticle_pntOccultWnd1)
			
clip_sizeX = 25
clip_sizeY = 18

CCIP_OccultVerts = {{-clip_sizeX, -clip_sizeY},
					{-clip_sizeX, clip_sizeY},
					{clip_sizeX, clip_sizeY},
					{clip_sizeX, -clip_sizeY}
				   }
						
OpenOccultWnd("clipReticleCCIP_Bomb11",
			CCIP_OccultVerts,
			{{"OccultWndReticle", 2}}, 
			"Pipper_Reticle_pntOccultWnd1", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipReticleCCIP_Bomb21",
			CCIP_OccultVerts, 
			{{"OccultWndReticle", 2}}, 
			"Pipper_Reticle_pntOccultWnd1", 
			HUD_DEFAULT_LEVEL + 1)

clip_sizeX = 18

CCRP_OccultVerts = {{-clip_sizeX, -clip_sizeY},
					{-clip_sizeX, clip_sizeY},
					{clip_sizeX, clip_sizeY},
					{clip_sizeX, -clip_sizeY}
				   }

OpenOccultWnd("clipReticleCCRP11",
			CCRP_OccultVerts,
			{--[[{"IsIAM", 0},--]] {"OccultWndReticle", 3}}, 
			"Pipper_Reticle_pntOccultWnd1", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipReticleCCRP21",
			CCRP_OccultVerts,
            nil,
			"Pipper_Reticle_pntOccultWnd1", 
			HUD_DEFAULT_LEVEL + 1)

clip_sizeX = 12
clip_sizeY = 12

GUNS_OccultVerts = {{-clip_sizeX, -clip_sizeY},
					{-clip_sizeX, clip_sizeY},
					{clip_sizeX, clip_sizeY},
					{clip_sizeX, -clip_sizeY}
				   }

OpenOccultWnd("clipReticleGUNS11",
			GUNS_OccultVerts,
			{{"OccultWndReticle", 1}}, 
			"Pipper_Reticle_pntOccultWnd1", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipReticleGUNS21",
			GUNS_OccultVerts,
			{{"OccultWndReticle", 1}}, 
			"Pipper_Reticle_pntOccultWnd1", 
			HUD_DEFAULT_LEVEL + 1)

Pipper_Reticle_dashOccultWnd1		= CreateDummy()
Pipper_Reticle_dashOccultWnd1.name	= "Pipper_Reticle_dashOccultWnd1"
Pipper_Reticle_dashOccultWnd1.level 	= HUD_DEFAULT_LEVEL
Pipper_Reticle_dashOccultWnd1.controllers 
	= {{"MasterArmSafe", 0}, {"IsMaverickSelected", 0}, {"OccultWndModeContol"}, {"pipper_reticle_dashed_pos", ZSL, TFOV, 28, 20}}
Add(Pipper_Reticle_dashOccultWnd1)

clip_sizeX = 25
clip_sizeY = 18

Dash_OccultVerts = {{-clip_sizeX, -clip_sizeY},
					{-clip_sizeX, clip_sizeY},
					{clip_sizeX, clip_sizeY},
					{clip_sizeX, -clip_sizeY}
				   }
			
OpenOccultWnd("clipReticle31",
			Dash_OccultVerts,
			nil, 
			"Pipper_Reticle_dashOccultWnd1", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipReticle41",
			Dash_OccultVerts,
			nil, 
			"Pipper_Reticle_dashOccultWnd1", 
			HUD_DEFAULT_LEVEL + 1)			


clipGunCross_pnt1		= CreateDummy()
clipGunCross_pnt1.name	= "clipGunCross_pnt1"
clipGunCross_pnt1.level 	= HUD_DEFAULT_LEVEL
clipGunCross_pnt1.controllers =
	{{"MasterArmSafe", 0}, {"OccultWndModeContol"}, {"pipper_reticle_pos", ZSL, 100, TFOV, 28, 1},
	 {"pipper_reticle_max_defl", 160, CCRP_MaxPiperDefl, 1}, {"GunCrossOccultWnd_show"}}
Add(clipGunCross_pnt1)
					
GunCross_sizeX = 12
GunCross_sizeY = 14.5

Cross_OccultVerts = {{-GunCross_sizeX, -GunCross_sizeY},
					 {-GunCross_sizeX, GunCross_sizeY},
					 {GunCross_sizeX, GunCross_sizeY},
					 {GunCross_sizeX, -GunCross_sizeY}
				    }

OpenOccultWnd("clipGunCross11",
			Cross_OccultVerts,
			nil, 
			"clipGunCross_pnt1",
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipGunCross21",
			Cross_OccultVerts,
			nil,
			"clipGunCross_pnt1", 
			HUD_DEFAULT_LEVEL + 1)
			
			
clipWindGunCross_pnt1		= CreateDummy()
clipWindGunCross_pnt1.name	= "clipWindGunCross_pnt1"
clipWindGunCross_pnt1.level 	= HUD_DEFAULT_LEVEL
clipWindGunCross_pnt1.controllers	= {{"MasterArmSafe", 0}, {"GunSymbologyAvail", 1}, {"OccultWndModeContol"}, {"GunCrossOccultWnd_show"}, {"Wind_Corrected_gun_cross_pos", 160, ZSL}}
Add(clipWindGunCross_pnt1)
			
OpenOccultWnd("clipGunCross31",
			Cross_OccultVerts,
			nil,
			"clipWindGunCross_pnt1", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipGunCross41",
			Cross_OccultVerts,
			nil,
			"clipWindGunCross_pnt1", 
			HUD_DEFAULT_LEVEL + 1)			
		

clipRangeGunCross_pnt1		= CreateDummy()
clipRangeGunCross_pnt1.name	= "clipRangeGunCross_pnt1"
clipRangeGunCross_pnt1.level 		= HUD_DEFAULT_LEVEL
clipRangeGunCross_pnt1.init_pos		= {0.0, -15.0, 0.0}
clipRangeGunCross_pnt1.parent_element = "clipGunCross_pnt1"
Add(clipRangeGunCross_pnt1)					

GunCross_txt_sizeX = 10
GunCross_txt_sizeY = 4

Cross_txt_OccultVerts = {{-GunCross_txt_sizeX, -GunCross_txt_sizeY},
						 {-GunCross_txt_sizeX, GunCross_txt_sizeY},
						 {GunCross_txt_sizeX, GunCross_txt_sizeY},
						 {GunCross_txt_sizeX, -GunCross_txt_sizeY}
						}

OpenOccultWnd("clipGunCross_txt11",
			Cross_txt_OccultVerts,
			{{"GunCross_txt_OccultWnd"}}, 
			"clipRangeGunCross_pnt1", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipGunCross_txt21",
			Cross_txt_OccultVerts,
			{{"GunCross_txt_OccultWnd"}}, 
			"clipRangeGunCross_pnt1", 
			HUD_DEFAULT_LEVEL + 1)
	
clipReticle4_8_12_pnt1		= CreateDummy()
clipReticle4_8_12_pnt1.name		= "clipReticle4_8_12_pnt1"
clipReticle4_8_12_pnt1.level 	= HUD_DEFAULT_LEVEL
clipReticle4_8_12_pnt1.controllers	= {{"MasterArmSafe", 0}, {"GunSymbologyAvail", 1}, {"OccultWndModeContol"}, {"gun_4_8_12_reticle", 160, ZSL, 1}}
Add(clipReticle4_8_12_pnt1)


clip_sizeX = 12
clip_sizeY = 12

Ret4_8_12_OccultVerts = {{-clip_sizeX, -clip_sizeY},
						 {-clip_sizeX, clip_sizeY},
						 {clip_sizeX, clip_sizeY},
						 {clip_sizeX, -clip_sizeY}
						}

OpenOccultWnd("clipReticle4_8_12_11",
			Ret4_8_12_OccultVerts,
			nil, 
			"clipReticle4_8_12_pnt1", 
			HUD_DEFAULT_LEVEL)
			
OpenOccultWnd("clipReticle4_8_12_21",
			Ret4_8_12_OccultVerts,
			nil, 
			"clipReticle4_8_12_pnt1", 
			HUD_DEFAULT_LEVEL + 1)

TVV = AddHUDTexElement("total_velocity_vector",
					{{-12.0, -6.0}, {-12.0, 10.0}, 
					{12.0, 10.0}, {12.0, -6.0}}, 
					{1.415/texture_size, 2.955/texture_size, tex_scale, tex_scale},
					{{"EGI_attitude_on"},{"total_velocity_vector_pos"}},
					{0.0, 0.0, 0.0},
					{0.0, 0.0, 0.0},
					nil,
					HUD_DEFAULT_LEVEL)

--[[
DBG_TVV             = Copy(TVV)
DBG_TVV.material    = "INDICATION_HUD_DBG"
DBG_TVV.controllers	= {{"total_velocity_vector_DBG_pos"}}
Add(DBG_TVV)
--]]

SPI_LL_stencilLine_X = 23
SPI_LL_stencilLine_Y = 1.5
SPI_LL_stencilLine_X2 = 5

SPI_LL_stencilLine					= CreateElement "ceMeshPoly"
SPI_LL_stencilLine.name				= "SPI_LL_stencilLine"
SPI_LL_stencilLine.primitivetype	= "triangles"
SPI_LL_stencilLine.vertices = {{-SPI_LL_stencilLine_X, -SPI_LL_stencilLine_Y},
								{-SPI_LL_stencilLine_X, SPI_LL_stencilLine_Y},
								{SPI_LL_stencilLine_X2, SPI_LL_stencilLine_Y},
								{SPI_LL_stencilLine_X2, -SPI_LL_stencilLine_Y}
							  }
SPI_LL_stencilLine.indices  		= default_box_indices
SPI_LL_stencilLine.init_pos 		= {0, 0, 0}
SPI_LL_stencilLine.material 		= "DBG_RED"
SPI_LL_stencilLine.h_clip_relation	= h_clip_relations.INCREASE_IF_LEVEL
SPI_LL_stencilLine.level			= HUD_DEFAULT_LEVEL
SPI_LL_stencilLine.parent_element	= "total_velocity_vector"
SPI_LL_stencilLine.controllers		= {{"EGI_on"}, {"SPI_LL_stencilLine"}}
SPI_LL_stencilLine.isdraw 			= true
SPI_LL_stencilLine.isvisible 		= false
SPI_LL_stencilLine.collimated		= true
Add(SPI_LL_stencilLine)					

SPI_LL_stencilSymbolSize = 3.5
SPI_LL_stencilSymbol				= CreateElement "ceMeshPoly"
SPI_LL_stencilSymbol.name			= "SPI_LL_stencilSymbol"
SPI_LL_stencilSymbol.primitivetype	= "triangles"
SPI_LL_stencilSymbol.vertices	= {{-SPI_LL_stencilSymbolSize, -SPI_LL_stencilSymbolSize},
								   {-SPI_LL_stencilSymbolSize, SPI_LL_stencilSymbolSize},
								   {SPI_LL_stencilSymbolSize, SPI_LL_stencilSymbolSize},
								   {SPI_LL_stencilSymbolSize, -SPI_LL_stencilSymbolSize}
								  }
SPI_LL_stencilSymbol.indices  		= default_box_indices
SPI_LL_stencilSymbol.init_pos 		= {0, 0, 0}
SPI_LL_stencilSymbol.material 		= "DBG_GREEN"
SPI_LL_stencilSymbol.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
SPI_LL_stencilSymbol.level			= HUD_DEFAULT_LEVEL
SPI_LL_stencilSymbol.parent_element	= "total_velocity_vector"
SPI_LL_stencilSymbol.controllers	= {{"SPI_LL_IsTGP", 0}, {"SPI_LL_stencilSymbol"}}
SPI_LL_stencilSymbol.isdraw 		= true
SPI_LL_stencilSymbol.isvisible 		= false
SPI_LL_stencilSymbol.collimated		= true
Add(SPI_LL_stencilSymbol)

SPI_LL_stencilTGPsize = 2
SPI_LL_stencilTGP					= CreateElement "ceMeshPoly"
SPI_LL_stencilTGP.name				= "SPI_LL_stencilTGP"
SPI_LL_stencilTGP.primitivetype		= "triangles"
SPI_LL_stencilTGP.vertices = {{-SPI_LL_stencilTGPsize, -SPI_LL_stencilTGPsize},
							  {-SPI_LL_stencilTGPsize, SPI_LL_stencilTGPsize},
							  {SPI_LL_stencilTGPsize, SPI_LL_stencilTGPsize},
							  {SPI_LL_stencilTGPsize, -SPI_LL_stencilTGPsize}
						     }
SPI_LL_stencilTGP.indices  			= default_box_indices
SPI_LL_stencilTGP.init_pos 			= {0, 0, 0}
SPI_LL_stencilTGP.init_rot 			= {45, 0, 0}
SPI_LL_stencilTGP.material 			= "DBG_GREY"
SPI_LL_stencilTGP.h_clip_relation = h_clip_relations.INCREASE_IF_LEVEL
SPI_LL_stencilTGP.level				= HUD_DEFAULT_LEVEL
SPI_LL_stencilTGP.parent_element	= "total_velocity_vector"
SPI_LL_stencilTGP.controllers		= {{"SPI_LL_IsTGP", 1}, {"SPI_LL_stencilSymbol"}}
SPI_LL_stencilTGP.isdraw 			= true
SPI_LL_stencilTGP.isvisible 		= false
SPI_LL_stencilTGP.collimated		= true
Add(SPI_LL_stencilTGP)

AddHUDTexElement("SPI_LL", 
				{{-1, -1}, {-1, 1},
				{23,1},	{23, -1}},
				{12.45/texture_size, 14.45/texture_size, tex_scale, tex_scale},
				{{"SPI_LL_pos"}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"total_velocity_vector",
				HUD_DEFAULT_LEVEL)

SPI_LL_stencilLine1					= Copy(SPI_LL_stencilLine)
SPI_LL_stencilLine1.name			= "SPI_LL_stencilLine1"
SPI_LL_stencilLine1.h_clip_relation	= h_clip_relations.DECREASE_IF_LEVEL
SPI_LL_stencilLine1.level			= HUD_DEFAULT_LEVEL + 1
SPI_LL_stencilLine1.isvisible 		= false
Add(SPI_LL_stencilLine1)

SPI_LL_stencilSymbol1					= Copy(SPI_LL_stencilSymbol)
SPI_LL_stencilSymbol1.name				= "SPI_LL_stencilSymbol1"
SPI_LL_stencilSymbol1.h_clip_relation	= h_clip_relations.DECREASE_IF_LEVEL
SPI_LL_stencilSymbol1.level				= HUD_DEFAULT_LEVEL + 1
SPI_LL_stencilSymbol1.isvisible 		= false
Add(SPI_LL_stencilSymbol1)

SPI_LL_stencilTGP1					= Copy(SPI_LL_stencilTGP)
SPI_LL_stencilTGP1.name				= "SPI_LL_stencilTGP1"
SPI_LL_stencilTGP1.h_clip_relation	= h_clip_relations.DECREASE_IF_LEVEL
SPI_LL_stencilTGP1.level			= HUD_DEFAULT_LEVEL + 1
SPI_LL_stencilTGP1.isvisible 		= false
Add(SPI_LL_stencilTGP1)				  

VVA = AddHUDTexElement("velocity_vector_arrow",
				{{-13.0, -3.0}, {-13.0, 3.0}, 
				{13.0, 3.0}, {13.0, -3.0}}, 
				{16.15/texture_size, 12.73/texture_size, tex_scale, tex_scale},
				{{"velocity_vector_arrow_dir", 90}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"total_velocity_vector",
				HUD_DEFAULT_LEVEL)

TD_Box_SPI = AddHUDTexElement("TD_Box_SPI",
				{{-4.5, -4.5}, {-4.5, 4.5}, 
				{4.5, 4.5}, {4.5, -4.5}},
				{5.46/texture_size, 2.41/texture_size, tex_scale, tex_scale},
				{{"EGI_on"}, {"TD_Box_SPI_pos"}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)

TD_Box_steerpoint = AddHUDTexElement("TD_Box_Steerpoint", 
				{{-4.5, -4.5}, {-4.5, 4.5}, 
				{4.5, 4.5}, {4.5, -4.5}},
				{5.46/texture_size, 2.41/texture_size, tex_scale, tex_scale},
				{{"EGI_on"}, {"TD_Box_Steerpoint_pos"}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)

LastMarkpointSymbol = AddHUDTextElement_Pos_Val("LastMarkpointSymbol",
				  {{"LastMarkpointSymbol"}},
				  {0.0, -13.0, 0.0}, 
				  "SPI_point",
				  HUD_DEFAULT_LEVEL,
				  "CenterCenter",
				  "M")

				
IAM_tgt_symbol = AddHUDTexElement("IAM_tgt_symbol",
				{{-6.0, -6.0}, {-6.0, 6.0}, 
				{6.0, 6.0}, {6.0, -6.0}}, 
				{15.22/texture_size, 11.37/texture_size, tex_scale, tex_scale},
				{{"IAM_tgt_symbol_pos"}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0 , 0.0},
				nil,
				HUD_DEFAULT_LEVEL)


SPI_point				= CreateDummy()
SPI_point.name			= "SPI_point"
SPI_point.init_pos		= {0.0, 0.0, 0.0}
SPI_point.controllers	= {{"EGI_on"},{"SPI_pnt_pos"}}
Add(SPI_point)				
				
SPI_RelBearing = AddHUDTextElement_Pos("SPI_RelBearing",
				  {{"Hook_or_IAM_IsSPI", 0}, {"SPI_RelativeBearing"}}, 
				  {-7.0, 10.0, 0.0}, 
				  "SPI_point",
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

SPI_Distance = AddHUDTextElement_Pos("SPI_Distance",
				  {{"Hook_or_IAM_IsSPI", 0}, {"SPI_distance"}}, 
				  {-7.0, -10.0, 0.0}, 
				  "SPI_point",
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")
				  
IAM_RelBearing = AddHUDTextElement_Pos("IAM_RelBearing",
				  {{"Hook_or_IAM_IsSPI", 1}, {"SPI_RelativeBearing"}}, 
				  {-5.5, 13.0, 0.0}, 
				  "SPI_point",
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

IAM_Distance = AddHUDTextElement_Pos("IAM_Distance",
				  {{"Hook_or_IAM_IsSPI", 1}, {"SPI_distance"}}, 
				  {-5.5, -13.0, 0.0}, 
				  "SPI_point",
				  HUD_DEFAULT_LEVEL,
				  "LeftCenter")

AddHUDTexElement("TDC_Box", 
				{{-4.7, -4.7}, {-4.7, 4.7}, 
				{4.7, 4.7}, {4.7, -4.7}},
				{5.48/texture_size, 2.42/texture_size, tex_scale, tex_scale},
				{{"EGI_attitude_on"},{"TDC_Box_pos", 158, ZSL}},
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)

AddHUDTexElement("TDC_dot", 
				{{-1, -1}, {-1, 1}, 
				{1, 1}, {1, -1}},
				{15.75/texture_size, 10.43/texture_size, tex_scale, tex_scale},
				nil,
				{0.0, 0.0, 0.0},
				{0.0, 0.0, 0.0},
				"TDC_Box",
				HUD_DEFAULT_LEVEL)

TDC_InvCrsSize = 5.2
AddHUDTexElement("TDC_InvalidCross", 
				{{-TDC_InvCrsSize, -TDC_InvCrsSize}, {-TDC_InvCrsSize, TDC_InvCrsSize}, 
				{TDC_InvCrsSize, TDC_InvCrsSize}, {TDC_InvCrsSize, -TDC_InvCrsSize}},
				{2.66/texture_size, 15.04/texture_size, tex_scale, tex_scale},
				{{"TDC_InvalidCross"}},
				{0.0, -0.5, 0.0},
				{0.0, 0.0, 0.0},
				"TDC_Box",
				HUD_DEFAULT_LEVEL)

AddHUDTexElement("TGP_Symbol", 
				{{-3, -3}, {-3, 3}, 
				{3, 3}, {3, -3}},
				{6.52/texture_size, 2.28/texture_size, tex_scale, tex_scale},
				{{"TGP_Symbol_pos", 158, ZSL}},
				{0.0, 0.0, 0.0},	
				{45.0, 0.0, 0.0},
				nil,
				HUD_DEFAULT_LEVEL)
