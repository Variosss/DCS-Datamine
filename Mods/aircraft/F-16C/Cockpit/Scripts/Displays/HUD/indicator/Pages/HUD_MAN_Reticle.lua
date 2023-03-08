dofile(LockOn_Options.script_path.."Displays/HUD/indicator/HUD_Page_defs.lua")
dofile(LockOn_Options.script_path.."Displays/HUD/device/HUD_config.lua")
dofile(LockOn_Options.script_path.."Computers/MMC_Types.lua")
dofile(LockOn_Options.script_path.."Displays/MFD/indicator/Pages/FCR/MFD_FCR_Defs.lua")

local Bomb_MAN_Reticle_Pos = addPlaceholder("Bomb_MAN_Reticle_Pos_PH", {0,0}, nil, {{"HUD_Bomb_MAN_RETICLE_Pos"}}) 
	addStrokeLine("Bomb_MAN_STBY_Reticle_Cross_1", 2, {0, -1}, nil, Bomb_MAN_Reticle_Pos.name)
	addStrokeLine("Bomb_MAN_STBY_Reticle_Cross_2", 2, {-1, 0}, -90, Bomb_MAN_Reticle_Pos.name)
	addStrokeLine("Bomb_MAN_STBY_Reticle_Line_1", 8, {0, 50}, 0, 	Bomb_MAN_Reticle_Pos.name)
	addStrokeLine("Bomb_MAN_STBY_Reticle_Line_2", 8, {0, -50}, 180, Bomb_MAN_Reticle_Pos.name)
	addStrokeLine("Bomb_MAN_STBY_Reticle_Line_3", 8, {50, 0}, -90, 	Bomb_MAN_Reticle_Pos.name)
	addStrokeLine("Bomb_MAN_STBY_Reticle_Line_4", 8, {-50, 0}, 90, 	Bomb_MAN_Reticle_Pos.name)
	local baseAngle = math.rad(-13)	
	local offset = 0 
	for i = 1, 28 do		
		if math.fmod(i, 7) == 0 then
			baseAngle = baseAngle + math.rad(90)	
			offset = offset + 7
		end
		local posAngle = baseAngle + math.rad((i - offset) * 4.3)
		addStrokeCircle("Bomb_MAN_STBY_Reticle_circle_1_dot"..i, 0.25, {25 * math.sin(posAngle), 25 * math.cos(posAngle)}, Bomb_MAN_Reticle_Pos.name, nil, {0, math.pi * 2})
	end
	for i = 1, 32 do
		local posAngle = math.rad(i * 11.25)		
		addStrokeCircle("Bomb_MAN_STBY_Reticle_circle_2_dot"..i, 0.5, {50 * math.sin(posAngle), 50 * math.cos(posAngle)}, Bomb_MAN_Reticle_Pos.name, nil, {0, math.pi * 2})
	end
	
--Window 30
addStrokeText("HUD_Window30_Reticle_Depression", nil, STROKE_FNT_DFLT_100_NARROW, "LeftCenter", {-80, -42}, nil, {{"HUD_Window30_Reticle_Depression"}})