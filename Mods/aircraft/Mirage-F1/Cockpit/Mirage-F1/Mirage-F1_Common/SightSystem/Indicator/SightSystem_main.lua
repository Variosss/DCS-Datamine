dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/SightSystem/Indicator/SightSystem_tools.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/SightSystem/SightSystem_scales.lua")

local meanGunLineLen								= 4.5
local meanGunLinePosY								= 53.5 - meanGunLineLen

do
	local halfWidth 								= TFOV_radius -- mils
	local step 										= 5 -- mils
	--local step 									= 13.5 * degToMil -- mils
	--local lines_count 							= math.ceil(halfWidth / step)
	--local lines_count 							= 3
	local lines_count 								= 16
	
	--local grid 									= drawIndicatorRefGrid(lines_count, step, 2 * halfWidth, true, halfWidth)
	--grid.init_pos 								= {0, 0}
end

total_field_of_view	 				  				= CreateElement "ceMeshPoly"
total_field_of_view.name 			  				= "TFOV"
total_field_of_view.material		  				= "SIGHT_SYSTEM_BACKLIGHT_GREEN"
total_field_of_view.h_clip_relation   				= h_clip_relations.INCREASE_IF_LEVEL
total_field_of_view.level			  				= INDICATOR_DEFAULT_LEVEL - 1 
total_field_of_view.collimated	  	  				= true
total_field_of_view.isvisible		  				= false
set_circle(total_field_of_view, TFOV_radius)
total_field_of_view.init_pos						= {0, 0}
total_field_of_view.parent_element    				= boresightPos.name
Add(total_field_of_view)

local drawBlackShield 								= false --true

if drawBlackShield == true then
	local black_shield 								= CreateElement "ceMeshPoly"
	black_shield.name 								= "black_shield"
	black_shield.primitivetype 						= "triangles"
	black_shield.vertices 							= {{-TFOV_radius, -TFOV_radius}, {-TFOV_radius, TFOV_radius}, {TFOV_radius, TFOV_radius}, {TFOV_radius, -TFOV_radius}}
	black_shield.indices  							= default_box_indices
	black_shield.material 							= "DBG_BLACK"
	black_shield.h_clip_relation 					= determineClipRelation(h_clip_relations.COMPARE)
	black_shield.level			 					= INDICATOR_DEFAULT_LEVEL
	black_shield.init_pos							= {0, 0}
	black_shield.parent_element						= boresightPos.name
	black_shield.additive_alpha						= false
	Add(black_shield)
end

local drawMarkupAndTemplate							= true

if drawMarkupAndTemplate then
	
	--[[
	local drawTemplate 								= false --true
	if drawTemplate then
		local templateSideLen 						= 67.5
		local templateVerts 						= {{-templateSideLen, -templateSideLen}, {-templateSideLen, templateSideLen}, {templateSideLen, templateSideLen}, {templateSideLen, -templateSideLen}}
		local templateTexScale 						= 0.0073 --0.0072
		local templateTexParams 					= {0.5, 0.5, templateTexScale, templateTexScale}
		local template 								= AddTexuredElement("template", templateVerts, templateTexParams, nil, {0, 0})
		template.material 							= "SYMB_SIGHT_SYSTEM_TEMPLATE"
	end
	--]]
	
	local drawMarkup 								= false --true
	if drawMarkup then
		local dbgLineSpanLong 						= 20
		add_debug_marker("dbgMarkerFRL", {0, -radarDatumPosY}, dbgLineSpanLong, dbgLineSpanLong, "FRL")
		
		local dbgLineSpanShort 						= 1.7
		local dbgLineSpanMid 						= 5
		add_debug_marker("dbgMarkerRadarDatum", {0, 0}, dbgLineSpanShort, dbgLineSpanShort, "radar", {dbgLineSpanLong * 0.5, dbgLineSpanLong * 0.5})
		
		add_debug_marker("dbgMarkerRadarDatumLeftEdge", {-15, 0}, dbgLineSpanShort, dbgLineSpanMid)
		add_debug_marker("dbgMarkerRadarDatumRightEdge", {15, 0}, dbgLineSpanShort, dbgLineSpanMid)
		
		add_debug_marker("dbgMarkerRadarDatumLeftInnerEdge", {-2, 0}, dbgLineSpanShort, dbgLineSpanMid)
		add_debug_marker("dbgMarkerRadarDatumRightInnerEdge", {2, 0}, dbgLineSpanShort, dbgLineSpanMid)
		
		add_debug_marker("dbgMarkerRadarDatumTopLowerEdge", {0, 2}, dbgLineSpanShort, dbgLineSpanShort)
		add_debug_marker("dbgMarkerRadarDatumTopUpperEdge", {0, 6}, dbgLineSpanShort, dbgLineSpanShort)
		
		add_debug_marker("dbgMarkerMeanGunLineTop", {0, 53.5}, dbgLineSpanLong, dbgLineSpanLong, "gun line top")

		
		add_debug_marker("dbgMarkerAttitudeReticleLeftEdge", {-59, 0}, dbgLineSpanShort, dbgLineSpanMid)
		add_debug_marker("dbgMarkerAttitudeReticleRightEdge", {59, 0}, dbgLineSpanShort, dbgLineSpanMid)
		
		add_debug_marker("dbgMarkerAttitudeReticleLeftInnerEdge", {-26, 0}, dbgLineSpanShort, dbgLineSpanMid)
		add_debug_marker("dbgMarkerAttitudeReticleRightInnerEdge", {26, 0}, dbgLineSpanShort, dbgLineSpanMid)
	end
end

drawDbgGeometry = false --true

local reticlesLights = {
	fixed 		= 0,
	moving 		= 1,
	target 		= 2,
	attitude 	= 3
}

function setBrightnessController(element, type_, specificBrightnessK_)
	local specificBrightnessK 						= 1
	
	if specificBrightnessK_ ~= nil then
		specificBrightnessK 						= specificBrightnessK_
	end
	
	element.controllers								= {{"element_brightness", type_, specificBrightnessK}}
end

-- Radar datum
do
	local radarDatumPlaceholder 					= addPlaceholder("radarDatumPlaceholder")
	local originDistanceFromCenter					= 2.25
	
	-- 13 mrad
	local radarDatumRightLine 						= SightAddLine("radarDatumRightLine", 12.5, getTexParams(52, 42), nil, {originDistanceFromCenter, 0}, nil, nil, 2, SIGHT_COLOR_WHITE)
	radarDatumRightLine.parent_element  			= radarDatumPlaceholder.name
	setBrightnessController(radarDatumRightLine, reticlesLights.fixed)
	
	local radarDatumLeftLine 						= Copy(radarDatumRightLine)
	radarDatumLeftLine.name							= "radarDatumLeftLine"
	radarDatumLeftLine.init_pos						= {-originDistanceFromCenter, 0}
	radarDatumLeftLine.init_rot						= {180}
	radarDatumLeftLine.controllers					= {{"alt_vel_scl_brt_and_visibility", hideIfOut, position, sign}}
	setBrightnessController(radarDatumLeftLine, reticlesLights.fixed)
	Add(radarDatumLeftLine)
	
	-- 4 mrad
	local radarDatumTopLine 						= SightAddLine("radarDatumTopLine", 3.5, getTexParams(434, 42), nil, {0, originDistanceFromCenter}, {90}, nil, 2, SIGHT_COLOR_WHITE)
	radarDatumTopLine.parent_element  				= radarDatumPlaceholder.name
	setBrightnessController(radarDatumTopLine, reticlesLights.fixed)
end

-- Mean Gun Line
do
	-- 4 mrad (originally 4.5)
	local meanGunLine = SightAddLine("meanGunLine", 4, getTexParams(598, 42), nil, {0, meanGunLinePosY}, {90}, nil, 2, SIGHT_COLOR_AMBER)
	setBrightnessController(meanGunLine, reticlesLights.fixed)
end

-- Distance/Heading scale
do
	local distHeadingScaleLevel						= INDICATOR_DEFAULT_LEVEL + 1
	
	local distanceHeadingScaleRadius				= 59
	
	local distHeadingScalePos						= {0, meanGunLinePosY + meanGunLineLen + 1.8}
	local distHeadingRadiusCenter					= {distHeadingScalePos[1], distHeadingScalePos[2] + distanceHeadingScaleRadius}
	
	drawDbgGeometry 								= false --true
	
	local maskAngle 								= 16
	local maskCathetus1 							= distanceHeadingScaleRadius + 2
	local maskCathetus2 							= maskCathetus1 * math.tan(math.rad(maskAngle))
	
	local maskVerts 								= {{0, 0}, {maskCathetus2, -maskCathetus1}, {-maskCathetus2, -maskCathetus1}}
	
	local maskIndices 								= buildConvexPolyIndices(#maskVerts)
	
	local openMask 									= openMaskArea("distHeadSclOpenMask", maskVerts, nil, distHeadingScaleLevel - 1)
	openMask.indices  								= maskIndices
	openMask.init_pos 								= distHeadingRadiusCenter
	--openMask.isvisible  							= true
	
	local distHeadSclRotatingPlaceholder 			= addPlaceholder("distHeadSclRotatingPlaceholder", distHeadingRadiusCenter, {{"distance_heading_scale"}})
	--distHeadSclRotatingPlaceholder.init_rot		= {-100} -- test
	
	local distHeadSclSectorPlaceholders             = {}
	for i = 1, 4 do
		distHeadSclSectorPlaceholders[i]			= addPlaceholder("distHeadSclSectorPlaceholder"..i, nil, {{"distance_heading_scale_sector", i - 1}})
		distHeadSclSectorPlaceholders[i].parent_element	= distHeadSclRotatingPlaceholder.name
	end
	
	drawDbgGeometry 								= false
	
	local distHeadSclSectorPlaceholder
	for i = 0, 35 do
		if i < 9 then
			distHeadSclSectorPlaceholder			= distHeadSclSectorPlaceholders[1]
		elseif i >= 9 and i < 18 then
			distHeadSclSectorPlaceholder			= distHeadSclSectorPlaceholders[2]
		elseif i >= 18 and i < 27 then
			distHeadSclSectorPlaceholder			= distHeadSclSectorPlaceholders[3]
		else
			distHeadSclSectorPlaceholder			= distHeadSclSectorPlaceholders[4]
		end
		
		local longTickAngle							= -i * 10
		local longTickPos 							= {-distanceHeadingScaleRadius * math.sin(math.rad(longTickAngle)), -distanceHeadingScaleRadius * math.cos(math.rad(longTickAngle))}
		local longTick 								= SightAddLine("longTick_"..i, 3, getTexParams(338, 96), nil, longTickPos, {90 - longTickAngle}, distHeadingScaleLevel, 3, SIGHT_COLOR_AMBER)
		longTick.parent_element 					= distHeadSclSectorPlaceholder.name
		setBrightnessController(longTick, reticlesLights.fixed)
		
		local txtValue
		if i == 0 then
			txtValue = "O" -- '0' with large gaps
		else
			local units = i % 10
			local tenths = (i - units) / 10
			
			local txtTenths
			if tenths == 0 then
				txtTenths = "O" -- '0' with large gaps
			elseif tenths == 1 then
				txtTenths = "I" -- right edge aligned '1'
			else
				txtTenths = ""..tenths
			end
			
			local txtUnits
			if units == 0 then
				txtUnits = "O" -- '0' with large gaps
			elseif units == 6 then
				txtUnits = "G" -- '6' with large gaps
			elseif units == 8 then
				txtUnits = "B" -- '8' with large gaps
			elseif units == 9 then
				txtUnits = "J" -- '9' with large gaps
			else
				txtUnits = ""..units
			end
			
			txtValue = txtTenths..txtUnits
		end
		
		local distHeadNumber 						= SightAddText_Pos_Val("distHeadNumber_"..i, nil, {4.8, -font_2_interchar * 0.5}, distHeadingScaleLevel, "CenterBottom", txtValue, 2, SIGHT_COLOR_AMBER)
		distHeadNumber.parent_element 				= longTick.name
		distHeadNumber.init_rot						= {-90}
		setBrightnessController(distHeadNumber, reticlesLights.fixed)
		
		for j = 1, 4 do
			local shortTickAngle					= longTickAngle - j * 2
			local shortTickPos 						= {-distanceHeadingScaleRadius * math.sin(math.rad(shortTickAngle)), -distanceHeadingScaleRadius * math.cos(math.rad(shortTickAngle))}
			local shortTick 						= SightAddLine("shortTick_"..i.."_"..j, 1.5, getTexParams(492, 96), nil, shortTickPos, {90 - shortTickAngle}, distHeadingScaleLevel, 3, SIGHT_COLOR_AMBER)
			shortTick.parent_element 				= distHeadSclSectorPlaceholder.name
			setBrightnessController(shortTick, reticlesLights.fixed)
		end
	end
	
	local closeMask 								= closeMaskArea("distHeadSclCloseMask", maskVerts, nil, distHeadingScaleLevel)
	closeMask.indices  								= maskIndices
	closeMask.init_pos 								= distHeadingRadiusCenter
end

-- Attitude Reticle
do
	drawDbgGeometry 								= false --true

	local attitudeReticlePlaceholder 				= addPlaceholder("attitudeReticlePlaceholder", nil, {{"attitude_reticle"}})

	-- Horizon Line - parts common to both Normal and Simplified reticles
	local commonLine1_distFromCenter				= 26.5
	
	local attitudeReticleCommonLine1_right			= SightAddLine("attitudeReticleCommonLine1_right", 33, getTexParams(52, 150), nil, {commonLine1_distFromCenter, 0}, nil, nil, 1, SIGHT_COLOR_GREEN)
	attitudeReticleCommonLine1_right.parent_element = attitudeReticlePlaceholder.name
	setBrightnessController(attitudeReticleCommonLine1_right, reticlesLights.attitude)
	
	local attitudeReticleCommonLine1_left			= Copy(attitudeReticleCommonLine1_right)
	attitudeReticleCommonLine1_left.name			= "attitudeReticleCommonLine1_left"
	attitudeReticleCommonLine1_left.init_pos		= {-commonLine1_distFromCenter, 0}
	attitudeReticleCommonLine1_left.init_rot		= {180}
	setBrightnessController(attitudeReticleCommonLine1_left, reticlesLights.attitude)
	Add(attitudeReticleCommonLine1_left)
	
	local line2_init_pos 							= {(33 - 19) * 0.5, -1.6}
	local attitudeReticleCommonLine2_right			= SightAddLine("attitudeReticleCommonLine2_right", 19, getTexParams(52, 205), nil, {line2_init_pos[1], line2_init_pos[2]}, nil, nil, 3, SIGHT_COLOR_GREEN)
	attitudeReticleCommonLine2_right.parent_element = attitudeReticleCommonLine1_right.name
	setBrightnessController(attitudeReticleCommonLine2_right, reticlesLights.attitude)
	
	local attitudeReticleCommonLine2_left			= Copy(attitudeReticleCommonLine2_right)
	attitudeReticleCommonLine2_left.name			= "attitudeReticleCommonLine2_left"
	attitudeReticleCommonLine2_left.parent_element  = attitudeReticleCommonLine1_left.name
	attitudeReticleCommonLine2_left.init_pos		= {line2_init_pos[1], -line2_init_pos[2]}
	setBrightnessController(attitudeReticleCommonLine2_left, reticlesLights.attitude)
	Add(attitudeReticleCommonLine2_left)
	
	local line3_init_pos 							= {(33 - 5) * 0.5, -2.65}
	local attitudeReticleCommonLine3_right			= SightAddLine("attitudeReticleCommonLine3_right", 5, getTexParams(52, 258), nil, {line3_init_pos[1], line3_init_pos[2]}, nil, nil, 4, SIGHT_COLOR_GREEN)
	attitudeReticleCommonLine3_right.parent_element = attitudeReticleCommonLine1_right.name
	setBrightnessController(attitudeReticleCommonLine3_right, reticlesLights.attitude)
	
	local attitudeReticleCommonLine3_left			= Copy(attitudeReticleCommonLine3_right)
	attitudeReticleCommonLine3_left.name			= "attitudeReticleCommonLine3_left"
	attitudeReticleCommonLine3_left.parent_element  = attitudeReticleCommonLine1_left.name
	attitudeReticleCommonLine3_left.init_pos		= {line3_init_pos[1], -line3_init_pos[2]}
	setBrightnessController(attitudeReticleCommonLine3_left, reticlesLights.attitude)
	Add(attitudeReticleCommonLine3_left)
	
	
	-- Normal
	local attRetNormlPlaceholder					= addPlaceholder("attRetNormlPlaceholder", nil, {{"attitude_reticle_type", 0}})
	attRetNormlPlaceholder.parent_element 			= attitudeReticlePlaceholder.name
	
	local attRetNormlPartVisUpperPlaceholder		= addPlaceholder("attRetNormlPartVisUpperPlaceholder", nil, {{"attitude_reticle_part_visibility", 1}})
	attRetNormlPartVisUpperPlaceholder.parent_element = attRetNormlPlaceholder.name
	
	local attRetNormlPartVisLowerPlaceholder		= addPlaceholder("attRetNormlPartVisLowerPlaceholder", nil, {{"attitude_reticle_part_visibility", -1}})
	attRetNormlPartVisLowerPlaceholder.parent_element = attRetNormlPlaceholder.name
	
	drawDbgGeometry 								= false --true
	
	local centerDonutHalfWidth 						= 2.6
	local centerDonutVerts 							=
		{{-centerDonutHalfWidth, -centerDonutHalfWidth},
		 {-centerDonutHalfWidth, centerDonutHalfWidth},
		 {centerDonutHalfWidth, centerDonutHalfWidth},
		 {centerDonutHalfWidth, -centerDonutHalfWidth}}
	
	local centerDonut								= SightAddTexuredElement("centerDonut", centerDonutVerts, getTexParams(426, 322), nil, nil, nil, nil, SIGHT_COLOR_GREEN)
	centerDonut.parent_element 						= attRetNormlPlaceholder.name
	setBrightnessController(centerDonut, reticlesLights.attitude)
	
	local normalSclMilPerDeg						= 3.5
	
	local attRetDashHalfWidth 						= 1.5
	
	local attitudeReticleCrossVerts 				=
		{{-attRetDashHalfWidth, -attRetDashHalfWidth},
		 {-attRetDashHalfWidth, attRetDashHalfWidth},
		 {attRetDashHalfWidth, attRetDashHalfWidth},
		 {attRetDashHalfWidth, -attRetDashHalfWidth}}
	
	local attitudeReticleDashVerts 					=
		{{-attRetDashHalfWidth, -line4_HalfWidth},
		 {-attRetDashHalfWidth, line4_HalfWidth},
		 {attRetDashHalfWidth, line4_HalfWidth},
		 {attRetDashHalfWidth, -line4_HalfWidth}}
	
	local numbersHorizShift							= font_0_interchar * 0.5
	local line2_shiftY								= 1.1
	
	local attRetNormlPlaceholderToUsePositive
	local attRetNormlPlaceholderToUseNegative
		
	for i = 0, 8 do
		
		if i < 4 then
			attRetNormlPlaceholderToUsePositive		= attRetNormlPlaceholder
			attRetNormlPlaceholderToUseNegative		= attRetNormlPlaceholder
		else
			attRetNormlPlaceholderToUsePositive		= attRetNormlPartVisUpperPlaceholder
			attRetNormlPlaceholderToUseNegative		= attRetNormlPartVisLowerPlaceholder
		end
		
		local baseDegrees							= i * 10 + 5
		
		local attitudeReticleCross					=
			SightAddTexuredElement("attitudeReticleCross_"..baseDegrees, attitudeReticleCrossVerts, getTexParams(196, 322), nil, {0, baseDegrees * normalSclMilPerDeg}, nil, nil, SIGHT_COLOR_GREEN)
		attitudeReticleCross.parent_element 		= attRetNormlPlaceholderToUsePositive.name
		setBrightnessController(attitudeReticleCross, reticlesLights.attitude)
		
		local attitudeReticleDash					=
			SightAddTexuredElement("attitudeReticleDash_"..baseDegrees, attitudeReticleDashVerts, getTexParams(294, 322), nil, {0, -baseDegrees * normalSclMilPerDeg}, nil, nil, SIGHT_COLOR_GREEN)
		attitudeReticleDash.parent_element 			= attRetNormlPlaceholderToUseNegative.name
		setBrightnessController(attitudeReticleDash, reticlesLights.attitude)
		
		local numberDegrees							= baseDegrees + 5
		
		local numberPosPositive						= numberDegrees * normalSclMilPerDeg
		local numberPosNegative						= -numberDegrees * normalSclMilPerDeg
		
		local txtValue
		
		if numberDegrees == 10 then
			txtValue = "IO" -- right edge aligned '1' + '0' with large gaps
			
			-- positive pair
			
			local attitudeReticleMidLine1_right_positive	=
				SightAddLine("attitudeReticleMidLine1_right_positive", 19, getTexParams(52, 205), nil, {commonLine1_distFromCenter, numberPosPositive}, nil, nil, 3, SIGHT_COLOR_GREEN)
			attitudeReticleMidLine1_right_positive.parent_element = attRetNormlPlaceholderToUsePositive.name
			setBrightnessController(attitudeReticleMidLine1_right_positive, reticlesLights.attitude)
			
			local attitudeReticleMidLine1_left_positive		= Copy(attitudeReticleMidLine1_right_positive)
			attitudeReticleMidLine1_left_positive.name		= "attitudeReticleMidLine1_left_positive"
			attitudeReticleMidLine1_left_positive.init_pos	= {-commonLine1_distFromCenter, numberPosPositive}
			attitudeReticleMidLine1_left_positive.init_rot	= {180}
			setBrightnessController(attitudeReticleMidLine1_left_positive, reticlesLights.attitude)
			Add(attitudeReticleMidLine1_left_positive)
			
			drawDbgGeometry 								= false --true
			
			local mid_line2_init_pos 						= {commonLine1_distFromCenter + (19 - 1.5) * 0.5, numberPosPositive - line2_shiftY}
			local attitudeReticleMidLine2_right_positive	=
				SightAddLine("attitudeReticleMidLine2_right_positive", 1.8, getTexParams(52, 312), nil, {mid_line2_init_pos[1], mid_line2_init_pos[2]}, nil, nil, 4, SIGHT_COLOR_GREEN)
			attitudeReticleMidLine2_right_positive.parent_element = attRetNormlPlaceholderToUsePositive.name
			setBrightnessController(attitudeReticleMidLine2_right_positive, reticlesLights.attitude)
			
			local attitudeReticleMidLine2_left_positive		= Copy(attitudeReticleMidLine2_right_positive)
			attitudeReticleMidLine2_left_positive.name		= "attitudeReticleMidLine2_left_positive"
			attitudeReticleMidLine2_left_positive.init_pos	= {-mid_line2_init_pos[1], mid_line2_init_pos[2]}
			attitudeReticleMidLine2_left_positive.init_rot	= {180}
			setBrightnessController(attitudeReticleMidLine2_left_positive, reticlesLights.attitude)
			Add(attitudeReticleMidLine2_left_positive)
			
			-- negative pair
			
			local attitudeReticleMidLine1_right_negative	= Copy(attitudeReticleMidLine1_right_positive)
			attitudeReticleMidLine1_right_negative.name		= "attitudeReticleMidLine1_right_negative"
			attitudeReticleMidLine1_right_negative.init_pos	= {commonLine1_distFromCenter, numberPosNegative}
			attitudeReticleMidLine1_right_negative.parent_element = attRetNormlPlaceholderToUseNegative.name
			setBrightnessController(attitudeReticleMidLine1_right_negative, reticlesLights.attitude)
			Add(attitudeReticleMidLine1_right_negative)
			
			local attitudeReticleMidLine1_left_negative		= Copy(attitudeReticleMidLine1_left_positive)
			attitudeReticleMidLine1_left_negative.name		= "attitudeReticleMidLine1_left_negative"
			attitudeReticleMidLine1_left_negative.init_pos	= {-commonLine1_distFromCenter, numberPosNegative}
			attitudeReticleMidLine1_left_negative.parent_element = attRetNormlPlaceholderToUseNegative.name
			setBrightnessController(attitudeReticleMidLine1_left_negative, reticlesLights.attitude)
			Add(attitudeReticleMidLine1_left_negative)
			
			local attitudeReticleMidLine2_right_negative	= Copy(attitudeReticleMidLine2_right_positive)
			attitudeReticleMidLine2_right_negative.name		= "attitudeReticleMidLine2_right_negative"
			attitudeReticleMidLine2_right_negative.init_pos	= {mid_line2_init_pos[1], numberPosNegative - line2_shiftY}
			attitudeReticleMidLine2_right_negative.parent_element = attRetNormlPlaceholderToUseNegative.name
			setBrightnessController(attitudeReticleMidLine2_right_negative, reticlesLights.attitude)
			Add(attitudeReticleMidLine2_right_negative)
			
			local attitudeReticleMidLine2_left_negative		= Copy(attitudeReticleMidLine2_left_positive)
			attitudeReticleMidLine2_left_negative.name		= "attitudeReticleMidLine2_left_negative"
			attitudeReticleMidLine2_left_negative.init_pos	= {-mid_line2_init_pos[1], numberPosNegative - line2_shiftY}
			attitudeReticleMidLine2_left_negative.parent_element = attRetNormlPlaceholderToUseNegative.name
			setBrightnessController(attitudeReticleMidLine2_left_negative, reticlesLights.attitude)
			Add(attitudeReticleMidLine2_left_negative)
		else
			
			local tenths									= i + 1
			
			if tenths == 6 then
				txtValue = "GO" -- '6' with large gaps + '0' with large gaps
			elseif tenths == 8 then
				txtValue = "BO" -- '8' with large gaps + '0' with large gaps
			elseif tenths == 9 then
				txtValue = "JO" -- '9' with large gaps + '0' with large gaps
			else
				txtValue = ""..tenths.."O" -- + '0' with large gaps
			end
			
			local distFromCenter
			if numberDegrees == 20 then
				distFromCenter = commonLine1_distFromCenter
			elseif numberDegrees == 30 then
				distFromCenter = commonLine1_distFromCenter / 3 * 2
			elseif numberDegrees == 40 then
				distFromCenter = commonLine1_distFromCenter / 5 * 1.8
			else
				distFromCenter = commonLine1_distFromCenter / 5
			end
			
			-- positive pair
			
			local attitudeReticleShortLine1_right_positive		=
				SightAddLine("attitudeReticleShortLine1_right_positive_"..numberDegrees, 5, getTexParams(228, 258), nil, {distFromCenter, numberPosPositive}, nil, nil, 3, SIGHT_COLOR_GREEN)
			attitudeReticleShortLine1_right_positive.parent_element = attRetNormlPlaceholderToUsePositive.name
			setBrightnessController(attitudeReticleShortLine1_right_positive, reticlesLights.attitude)
			
			local attitudeReticleShortLine1_left_positive		= Copy(attitudeReticleShortLine1_right_positive)
			attitudeReticleShortLine1_left_positive.name		= "attitudeReticleShortLine1_left_positive_"..numberDegrees
			attitudeReticleShortLine1_left_positive.init_pos	= {-distFromCenter, numberPosPositive}
			attitudeReticleShortLine1_left_positive.init_rot	= {180}
			setBrightnessController(attitudeReticleShortLine1_left_positive, reticlesLights.attitude)
			Add(attitudeReticleShortLine1_left_positive)
			
			drawDbgGeometry 									= false --true
			
			local short_line2_init_pos 							= {distFromCenter + (5 - 1.8) * 0.5, numberPosPositive - line2_shiftY}
			local attitudeReticleShortLine2_right_positive		=
				SightAddLine("attitudeReticleShortLine2_right_positive_"..numberDegrees, 1.8, getTexParams(52, 312), nil, {short_line2_init_pos[1], short_line2_init_pos[2]}, nil, nil, 4, SIGHT_COLOR_GREEN)
			attitudeReticleShortLine2_right_positive.parent_element = attRetNormlPlaceholderToUsePositive.name
			setBrightnessController(attitudeReticleShortLine2_right_positive, reticlesLights.attitude)
			
			local attitudeReticleShortLine2_left_positive		= Copy(attitudeReticleShortLine2_right_positive)
			attitudeReticleShortLine2_left_positive.name		= "attitudeReticleShortLine2_left_positive_"..numberDegrees
			attitudeReticleShortLine2_left_positive.init_pos	= {-short_line2_init_pos[1], short_line2_init_pos[2]}
			attitudeReticleShortLine2_left_positive.init_rot	= {180}
			setBrightnessController(attitudeReticleShortLine2_left_positive, reticlesLights.attitude)
			Add(attitudeReticleShortLine2_left_positive)
			
			-- negative pair
			
			local attitudeReticleShortLine1_right_negative		= Copy(attitudeReticleShortLine1_right_positive)
			attitudeReticleShortLine1_right_negative.name		= "attitudeReticleShortLine1_right_negative_"..numberDegrees
			attitudeReticleShortLine1_right_negative.init_pos	= {distFromCenter, numberPosNegative}
			attitudeReticleShortLine1_right_negative.parent_element = attRetNormlPlaceholderToUseNegative.name
			setBrightnessController(attitudeReticleShortLine1_right_negative, reticlesLights.attitude)
			Add(attitudeReticleShortLine1_right_negative)
			
			local attitudeReticleShortLine1_left_negative		= Copy(attitudeReticleShortLine1_left_positive)
			attitudeReticleShortLine1_left_negative.name		= "attitudeReticleShortLine1_left_negative_"..numberDegrees
			attitudeReticleShortLine1_left_negative.init_pos	= {-distFromCenter, numberPosNegative}
			attitudeReticleShortLine1_left_negative.parent_element = attRetNormlPlaceholderToUseNegative.name
			setBrightnessController(attitudeReticleShortLine1_left_negative, reticlesLights.attitude)
			Add(attitudeReticleShortLine1_left_negative)
			
			local attitudeReticleShortLine2_right_negative		= Copy(attitudeReticleShortLine2_right_positive)
			attitudeReticleShortLine2_right_negative.name		= "attitudeReticleShortLine2_right_negative_"..numberDegrees
			attitudeReticleShortLine2_right_negative.init_pos	= {short_line2_init_pos[1], numberPosNegative - line2_shiftY}
			attitudeReticleShortLine2_right_negative.parent_element = attRetNormlPlaceholderToUseNegative.name
			setBrightnessController(attitudeReticleShortLine2_right_negative, reticlesLights.attitude)
			Add(attitudeReticleShortLine2_right_negative)
			
			local attitudeReticleShortLine2_left_negative		= Copy(attitudeReticleShortLine2_left_positive)
			attitudeReticleShortLine2_left_negative.name		= "attitudeReticleShortLine2_left_negative_"..numberDegrees
			attitudeReticleShortLine2_left_negative.init_pos	= {-short_line2_init_pos[1], numberPosNegative - line2_shiftY}
			attitudeReticleShortLine2_left_negative.parent_element = attRetNormlPlaceholderToUseNegative.name
			setBrightnessController(attitudeReticleShortLine2_left_negative, reticlesLights.attitude)
			Add(attitudeReticleShortLine2_left_negative)
		end
		
		local numberPositive 						=
			SightAddText_Pos_Val("pitchNumberPositive_"..numberDegrees, nil, {numbersHorizShift, numberPosPositive}, nil, "CenterCenter", txtValue, 0, SIGHT_COLOR_GREEN)
		numberPositive.parent_element 				= attRetNormlPlaceholderToUsePositive.name
		setBrightnessController(numberPositive, reticlesLights.attitude)
		
		local numberNegative 						= Copy(numberPositive)
		numberNegative.name							= "pitchNumberNegative_"..numberDegrees
		numberNegative.init_pos						= {numbersHorizShift, numberPosNegative}
		numberNegative.parent_element 				= attRetNormlPlaceholderToUseNegative.name
		setBrightnessController(numberNegative, reticlesLights.attitude)
		Add(numberNegative)
	end
	
	-- Simplified
	local attRetSimplPlaceholder					= addPlaceholder("attRetSimplPlaceholder", nil, {{"attitude_reticle_type", 1}})
	attRetSimplPlaceholder.parent_element 			= attitudeReticlePlaceholder.name
	
	local attRetSimplCenterLineHalfWidth 			= 15
	local attRetSimplCenterLineVerts 				=
		{{-attRetSimplCenterLineHalfWidth - line1_HalfWidth, -line1_HalfWidth},
		 {-attRetSimplCenterLineHalfWidth - line1_HalfWidth, line1_HalfWidth},
		 {attRetSimplCenterLineHalfWidth + line1_HalfWidth , line1_HalfWidth},
		 {attRetSimplCenterLineHalfWidth + line1_HalfWidth, -line1_HalfWidth}}
	
	local attRetSimplCenterLine						=
		SightAddTexuredElement("attRetSimplCenterLine", attRetSimplCenterLineVerts, getTexParams(408, 410), nil, nil, nil, nil, SIGHT_COLOR_GREEN)
	attRetSimplCenterLine.parent_element 			= attRetSimplPlaceholder.name
	setBrightnessController(attRetSimplCenterLine, reticlesLights.attitude)
	
	local auxMarkStep 								= -43.6
	
	local attRetSimplAuxMarkHalfWidth 				= 9
	local attRetSimplAuxMarkVerts 					=
		{{-attRetSimplAuxMarkHalfWidth - line3_HalfWidth, -line3_HalfWidth},
		 {-attRetSimplAuxMarkHalfWidth - line3_HalfWidth, line3_HalfWidth},
		 {attRetSimplAuxMarkHalfWidth + line3_HalfWidth , line3_HalfWidth},
		 {attRetSimplAuxMarkHalfWidth + line3_HalfWidth, -line3_HalfWidth}}
	
	local attRetSimplAuxMark1						=
		SightAddTexuredElement("attRetSimplAuxMark1", attRetSimplAuxMarkVerts, getTexParams(268, 464), nil, {0, auxMarkStep}, nil, nil, SIGHT_COLOR_GREEN)
	attRetSimplAuxMark1.parent_element 				= attRetSimplCenterLine.name
	setBrightnessController(attRetSimplAuxMark1, reticlesLights.attitude)
	
	local attRetSimplAuxMark2						= Copy(attRetSimplAuxMark1)
	attRetSimplAuxMark2.name						= "attRetSimplAuxMark2"
	attRetSimplAuxMark2.init_pos					= {0, auxMarkStep * 2}
	setBrightnessController(attRetSimplAuxMark2, reticlesLights.attitude)
	Add(attRetSimplAuxMark2)
end

drawDbgGeometry 									= false --true

-- Indicator Lights
do
	-- large circle (~6 mrad) diameter
	local largeCircleHalfWidth 						= 4
	local largeCircleVerts 							=
		{{-largeCircleHalfWidth, -largeCircleHalfWidth},
		 {-largeCircleHalfWidth, largeCircleHalfWidth},
		 {largeCircleHalfWidth, largeCircleHalfWidth},
		 {largeCircleHalfWidth, -largeCircleHalfWidth}}

	local largeCircleTexParams 						= getTexParams(160, 578)

	-- 'Firing zone' light
	local upperLargeCirclePosY						= -26
	SightAddTexuredElement("firingZoneLight", largeCircleVerts, largeCircleTexParams, {{"indicator_light", 0}, {"element_brightness", reticlesLights.fixed}}, {0, upperLargeCirclePosY}, nil, nil, SIGHT_COLOR_GREEN)
	
	-- 'Limitatinos exceeded' light
	local lowerLargeCirclePosY						= upperLargeCirclePosY - 31
	SightAddTexuredElement("limitationsExceededLight", largeCircleVerts, largeCircleTexParams, {{"indicator_light", 1}, {"element_brightness", reticlesLights.fixed}}, {0, lowerLargeCirclePosY}, nil, nil, SIGHT_COLOR_RED)
	
	
	local sideLightsShiftX							= 25
	local sideLightsShiftY							= -15
		
	-- 'Missile ready' lights
	
	-- triangle (~4 mrad wide)
	local triangleBoxHalfWidth 						= 3
	local triangleBoxVerts 							=
		{{-triangleBoxHalfWidth, -triangleBoxHalfWidth},
		 {-triangleBoxHalfWidth, triangleBoxHalfWidth},
		 {triangleBoxHalfWidth, triangleBoxHalfWidth},
		 {triangleBoxHalfWidth, -triangleBoxHalfWidth}}

	local rightTriangle 							=
		SightAddTexuredElement("missileReadyLightRight", triangleBoxVerts, getTexParams(488, 578), {{"indicator_light", 3}, {"element_brightness", reticlesLights.fixed}}, {sideLightsShiftX, upperLargeCirclePosY + sideLightsShiftY}, nil, nil, SIGHT_COLOR_WHITE)
	
	local leftTriangle 								= Copy(rightTriangle)
	leftTriangle.name 								= "missileReadyLightLeft"
	leftTriangle.init_pos							= {-sideLightsShiftX, upperLargeCirclePosY + sideLightsShiftY}
	leftTriangle.controllers						= {{"indicator_light", 2}, {"element_brightness", reticlesLights.fixed}}
	Add(leftTriangle)
	
	-- 'Missile locked on' lights
	
	-- small circle (~4 mrad) diameter
	local smallCircleHalfWidth 						= 3
	local smallCircleVerts 							=
		{{-smallCircleHalfWidth, -smallCircleHalfWidth},
		 {-smallCircleHalfWidth, smallCircleHalfWidth},
		 {smallCircleHalfWidth, smallCircleHalfWidth},
		 {smallCircleHalfWidth, -smallCircleHalfWidth}}

	local rightCircle 								=
		SightAddTexuredElement("missileLockedOnLightRight", smallCircleVerts, getTexParams(332, 578), {{"indicator_light", 5}, {"element_brightness", reticlesLights.fixed}}, {sideLightsShiftX, lowerLargeCirclePosY + sideLightsShiftY}, nil, nil, SIGHT_COLOR_AMBER)
	
	local leftCircle 								= Copy(rightCircle)
	leftCircle.name 								= "missileLockedOnLightLeft"
	leftCircle.init_pos								= {-sideLightsShiftX, lowerLargeCirclePosY + sideLightsShiftY}
	leftCircle.controllers							= {{"indicator_light", 4}, {"element_brightness", reticlesLights.fixed}}
	Add(leftCircle)
end

-- Target Reticle
do
	-- 2.5 mrad
	local targetReticleHalfWidth 					= 4.5 * 0.5
	local targetReticleVerts 						=
		{{-targetReticleHalfWidth, -targetReticleHalfWidth},
		 {-targetReticleHalfWidth, targetReticleHalfWidth},
		 {targetReticleHalfWidth, targetReticleHalfWidth},
		 {targetReticleHalfWidth, -targetReticleHalfWidth}}

	SightAddTexuredElement("targetReticle", targetReticleVerts, getTexParams(624, 578), {{"target_reticle"}, {"element_brightness", reticlesLights.target}}, {0, 0}, nil, nil, SIGHT_COLOR_AMBER)
end

drawDbgGeometry 									= false

-- Moving Reticle
do
	local movidngReticleCentralDot					= make2milCentralDot("movidngReticleCentralDot", SIGHT_COLOR_WHITE)
	--movidngReticleCentralDot.init_pos				= {-30, 40}
	movidngReticleCentralDot.controllers			= {{"moving_reticle"}, {"element_brightness", reticlesLights.moving}}
	
	-- Radar Command Reticle
	
	local radarCommandReticlePlaceholder 			= addPlaceholder("radarCommandReticlePlaceholder", nil, {{"moving_reticle_kind", 0}})
	radarCommandReticlePlaceholder.parent_element	= movidngReticleCentralDot.name
	
	drawDbgGeometry 								= false --true
	
	-- 9 mrad
	local radarCommandReticleRightLine 				= SightAddLine("radarCommandReticleRightLine", 8.5, getTexParams(52, 96), nil, {16.5, 0}, nil, nil, 1, SIGHT_COLOR_WHITE)
	radarCommandReticleRightLine.parent_element  	= radarCommandReticlePlaceholder.name
	setBrightnessController(radarCommandReticleRightLine, reticlesLights.moving)
	
	local radarCommandReticleLeftLine 				= Copy(radarCommandReticleRightLine)
	radarCommandReticleLeftLine.name				= "radarCommandReticleLeftLine"
	radarCommandReticleLeftLine.init_pos			= {-16.5, 0}
	radarCommandReticleLeftLine.init_rot			= {180}
	setBrightnessController(radarCommandReticleLeftLine, reticlesLights.moving)
	Add(radarCommandReticleLeftLine)
	
	-- A/A Firing Reticle
	
	local firingReticlePlaceholder 					= addPlaceholder("firingReticlePlaceholder", nil, {{"moving_reticle_kind", 1}})
	firingReticlePlaceholder.parent_element			= movidngReticleCentralDot.name
	
	--local firingReticleTestMark					= SightAddLine("firingReticleTestMark", 3.7, getTexParams(704, 205), nil, {0, 0}, nil, nil, 3, SIGHT_COLOR_BLUE)
	--firingReticleTestMark.parent_element			= firingReticlePlaceholder.name
	--firingReticleTestMark.controllers				= {{"aa_firing_reticle_diam_tst_mark"}}
		
	local maskVerts
	
	do
		local maskHalfWidth								= 0.5
		local maskStart									= 0 --7
		local maskLen									= 28
		maskVerts 										=
			{{-maskHalfWidth, -maskHalfWidth + maskStart},
			 {-maskHalfWidth, maskLen},
			 {maskHalfWidth, maskLen},
			 {maskHalfWidth, -maskHalfWidth + maskStart}}
	end
	
	--[[
	function addVaneMask(name, controllers, level)
		local mask 									= SightAddLine(name, 25, getTexParams(52, 923), controllers, {0, 0}, {0}, level, 1, SIGHT_COLOR_WHITE)
		mask.level			 						= level
		mask.isvisible  							= drawDbgGeometry
		
		return mask
	end
	
	function openVaneMask(name, controllers, level)
		local mask 									= addVaneMask(name, controllers, level)
		mask.h_clip_relation 						= determineClipRelation(h_clip_relations.INCREASE_IF_LEVEL, true)
		
		return mask
	end
	
	function closeVaneMask(name, controllers, level)
		local mask 									= addVaneMask(name, controllers, level)
		mask.h_clip_relation 						= determineClipRelation(h_clip_relations.DECREASE_IF_LEVEL, true)
		
		return mask
	end
	--]]
	
	local firingReticleLevel						= INDICATOR_DEFAULT_LEVEL + 1
	
	drawDbgGeometry 								= false
	drawDbgMarkers  								= false
	disable_clipping   								= false
	
	local countOfVanes								= 6
	
	for i = 1, countOfVanes do
		local angleDeg 								= (i - 1) * 60
		
		local openMask 								= openMaskArea("firingReticleOpenMask_" .. i, maskVerts, {{"aa_firing_reticle_vane_mask_pos", math.rad(angleDeg)}}, firingReticleLevel-1)
		--local openMask 							= openVaneMask("firingReticleOpenMask_" .. i, nil, firingReticleLevel-1)
		openMask.parent_element 					= firingReticlePlaceholder.name
		--openMask.init_rot							= {90 - angleDeg} -- for openVaneMask
		--openMask.init_rot							= {angleDeg} -- now is rotated in the controller (due to the order of init_pos and init_rot applied)
	end
	
	--drawDbgGeometry 								= false
	
	local firingReticleVanesPlaceholder 			= addPlaceholder("firingReticleVanesPlaceholder", nil, {{"aa_firing_reticle_diam"}})
	firingReticleVanesPlaceholder.parent_element	= firingReticlePlaceholder.name
	--firingReticleVanesPlaceholder.init_rot		= {-25} --{-3}
		
	local closingMaskPlaceholder 					= addPlaceholder("closingMaskPlaceholder")
	closingMaskPlaceholder.parent_element			= firingReticlePlaceholder.name
	
	local toDrawStaticVanes							= false
	if toDrawStaticVanes then
		-- 2 X 1.2 mrad
		local vaneHalfWidth 						= 4.5 * 0.5
		local vaneVerts 							=
			{{-vaneHalfWidth, -vaneHalfWidth},
			 {-vaneHalfWidth, vaneHalfWidth},
			 {vaneHalfWidth, vaneHalfWidth},
			 {vaneHalfWidth, -vaneHalfWidth}}
		
		-- 40 mil diameter
		local radius = 20
		
		for i = 1, countOfVanes do
			local angleDeg 							= (i - 1) * 60
			local angleRad 							= math.rad(angleDeg)
			local vane 								=
				SightAddTexuredElement("firingReticleVaneStatic_" .. i, vaneVerts, getTexParams(728, 578), nil, {radius * math.sin(angleRad), radius * math.cos(angleRad)}, {-angleDeg}, nil, SIGHT_COLOR_WHITE)
			vane.parent_element  					= firingReticlePlaceholder.name
			setBrightnessController(vane, reticlesLights.moving)
		end
	end
	
	local vaneLenX 									= 24.5
	local vaneLenYup 								= 6.5
	local vaneLenYdown								= 1.5
	
	local vaneVerts 								=
		{{-1, -vaneLenYdown},
		 {-1, vaneLenYup},
		 {vaneLenX, vaneLenYup},
		 {vaneLenX, -vaneLenYdown}}
	
	local vanesBrightnessK 							= {0.5, 0.75, 1, 0.75, 1, 0.75}
	
	for i = 1, countOfVanes do
		local angleDeg 								= (i - 1) * 60
		
		local vane 									=
			SightAddTexuredElement("firingReticleVane_" .. i, vaneVerts, getTexParams(52, 843), nil, nil, {90 - angleDeg}, firingReticleLevel, SIGHT_COLOR_WHITE)
		vane.parent_element  						= firingReticleVanesPlaceholder.name
		setBrightnessController(vane, reticlesLights.moving, vanesBrightnessK[i])
		--vane.h_clip_relation  						= h_clip_relations.NULL
				
		local closeMask 							= closeMaskArea("firingReticleCloseMask_" .. i, maskVerts, {{"aa_firing_reticle_vane_mask_pos", math.rad(angleDeg)}}, firingReticleLevel)
		--local closeMask 							= closeVaneMask("firingReticleCloseMask_" .. i, nil, firingReticleLevel)
		closeMask.parent_element 					= closingMaskPlaceholder.name
		--closeMask.init_rot						= {90 - angleDeg} -- for openVaneMask
		--closeMask.init_rot						= {angleDeg} -- now is rotated in the controller (due to the order of init_pos and init_rot applied)
	end
end

do
	local dbgDisableScalesMask						= false

	local scalesLevel
	local hideElemsOutOfMask
	if dbgDisableScalesMask == true then
		scalesLevel									= INDICATOR_DEFAULT_LEVEL
		hideElemsOutOfMask							= 0
	else
		scalesLevel									= INDICATOR_DEFAULT_LEVEL + 1
		hideElemsOutOfMask							= 1
	end
	
	local function setBrightnessAndVisibCtrlr(element, hideIfOut, position, sign)
		local sign_ = 0
		if sign ~= nil then
			sign_ = sign
		end
		
		element.controllers							= {{"alt_vel_scl_brt_and_visibility", hideIfOut, position, sign_}}
	end
	
	drawDbgGeometry 								= false --true
	
	local function addReference(name, parent_name, color, sign)
		local line 									= SightAddLine(name, 3.7, getTexParams(560, 205), nil, {-2.5, 0}, {180}, scalesLevel, 2, color)
		line.parent_element							= parent_name
		setBrightnessAndVisibCtrlr(line, 0, 0, sign)
		
		return line
	end
	
	local function addLongTick(name, parent_name, init_pos, color)
		local line 									= SightAddLine(name, 3.7, getTexParams(704, 205), nil, init_pos, nil, scalesLevel, 3, color)
		line.parent_element							= parent_name
		setBrightnessAndVisibCtrlr(line, 1, init_pos[2])
		
		return line
	end
	
	local scalesPos									= {54.5, 0}	
	
	-- altVelSclMaskHalfHeight is defined in SightSystem_scales.lua
	--local altVelSclMaskHalfHeight					= 22
	local maskWidthLeft 							= -8
	local maskWidthRight 							= 18
	local maskIntermPtX								= 1.3
	local maskIntermPtHalfHeight					= 6

	local maskVerts 								=
		{{maskWidthLeft,  -maskIntermPtHalfHeight},
		 {maskWidthLeft,   maskIntermPtHalfHeight},
		 {maskIntermPtX,   altVelSclMaskHalfHeight},
		 {maskWidthRight,  altVelSclMaskHalfHeight},
		 {maskWidthRight, -altVelSclMaskHalfHeight},
		 {maskIntermPtX,  -altVelSclMaskHalfHeight},
		}

	local maskIndices 								= buildConvexPolyIndices(#maskVerts)
	
	if dbgDisableScalesMask == false then
		-- Open scales masking window
		local openMask 								= openMaskArea("altitudeVelocitySclOpenMask", maskVerts, nil, scalesLevel - 1)
		openMask.indices  							= maskIndices
		openMask.init_pos 							= scalesPos
		--openMask.isvisible 						= true
	end
	
	local scalesPlaceholder 						= addPlaceholder("scalesPlaceholder", scalesPos)

	
	-- Velocity or Missle Flight Time Scale
	
	local function addVerticalTick(name, parent_name, init_pos)
		local verticalTickHalfWidth 				= 1.6
		local verticalTickVerts 					=
			{{-verticalTickHalfWidth, -line3_HalfWidth},
			 {-verticalTickHalfWidth, line3_HalfWidth},
			 {verticalTickHalfWidth, line3_HalfWidth},
			 {verticalTickHalfWidth, -line3_HalfWidth}}

		local line 									= SightAddTexuredElement(name, verticalTickVerts, getTexParams(724, 258), nil, init_pos, nil, scalesLevel, SIGHT_COLOR_AMBER)
		line.init_rot								= {90}
		line.parent_element							= parent_name
		setBrightnessAndVisibCtrlr(line, 1, init_pos[2])
		
		return line
	end
	
	local function addPlusSign(name, parent_name, init_pos)
		local horTick 								= addLongTick(name.."_horTick", parent_name, init_pos, SIGHT_COLOR_AMBER)
	
		addVerticalTick(name.."vertTick", parent_name, {init_pos[1] + 1.5, init_pos[2]})
		
		return horTick
	end
	
	local function addDot(name, parent_name, init_pos)
		local dotHalfWidth 							= 1.1
		local dotVerts 								=
			{{-dotHalfWidth, -dotHalfWidth},
			 {-dotHalfWidth, dotHalfWidth},
			 {dotHalfWidth, dotHalfWidth},
			 {dotHalfWidth, -dotHalfWidth}}

		local dot 									= SightAddTexuredElement(name, dotVerts, getTexParams(948, 204), nil, init_pos, nil, scalesLevel, SIGHT_COLOR_AMBER)
		dot.parent_element							= parent_name
		setBrightnessAndVisibCtrlr(dot, 1, init_pos[2])
		
		return dot
	end
	
	local function addVsymbol(name, parent_name, init_pos)
		local VsymbolHalfWidth 						= 2.5
		local VsymbolHeight 						= 6
		local VsymbolVerts 							=
			{{-VsymbolHalfWidth, -line2_HalfWidth},
			 {-VsymbolHalfWidth, VsymbolHeight},
			 {VsymbolHalfWidth, VsymbolHeight},
			 {VsymbolHalfWidth, -line2_HalfWidth}}

		local symbol =
			SightAddTexuredElement(name, VsymbolVerts, getTexParams(875, 464), nil, init_pos, nil, scalesLevel, SIGHT_COLOR_AMBER)
		symbol.parent_element						= parent_name
		setBrightnessAndVisibCtrlr(symbol, 1, init_pos[2])
		
		return symbol
	end
	
	local scaleMovablePlaceholder 					= addPlaceholder("scaleMovablePlaceholder", nil, {{"alt_vel_scl_pos"}})
	scaleMovablePlaceholder.parent_element			= scalesPlaceholder.name
	
	local velScalePlaceholder 						= addPlaceholder("velScalePlaceholder", nil, {{"alt_vel_scl_scale_kind", 0}})
	velScalePlaceholder.parent_element				= scaleMovablePlaceholder.name
	
	-- -85 mil for upper V without partially visible 100
	
	drawDbgGeometry 								= false --true
	
	-- TODO: visibility and brightness controllers
	addReference("velocityScaleReference", scalesPlaceholder.name, SIGHT_COLOR_AMBER, 1)
	
	local VsymbolShiftX								= 9.2
	local VsymbolShiftY								= 4
	
	local velocityDigitsShiftX						= 4
	local dotShiftX									= 1.5
	
	-- Initial position
	local verticalPos								= 0
	
	-- lower V symbol (inverted)
	local VsymbolLower 								= addVsymbol("VsymbolLower", velScalePlaceholder.name, {VsymbolShiftX, verticalPos - VsymbolShiftY})
	VsymbolLower.init_rot							= {180}
	
	-- from '600' to '250'
	for i = 1, 8 do
		local digits 								= velocityScaleMils[i][1]
		local plusSign 								= addPlusSign("velocityScalePlusSign_"..digits, velScalePlaceholder.name, {0, verticalPos})
		local velocityNumber 						= SightAddText_Pos_Val("velocityScaleDigits_"..digits, nil, {velocityDigitsShiftX, verticalPos}, scalesLevel, "LeftCenter", ""..digits, 3, SIGHT_COLOR_AMBER)
		velocityNumber.parent_element				= velScalePlaceholder.name
		setBrightnessAndVisibCtrlr(velocityNumber, 1, verticalPos)
		
		-- Move pos
		verticalPos									= verticalPos + velocityScaleMils[i][2]
	end
	
	-- '200'
	local plusSign200 								= addPlusSign("velocityScalePlusSign_200", velScalePlaceholder.name, {0, verticalPos})
	local velocityNumber200 						= SightAddText_Pos_Val("velocityScaleDigits_200", nil, {velocityDigitsShiftX, verticalPos}, scalesLevel, "LeftCenter", "200", 3, SIGHT_COLOR_AMBER)
	velocityNumber200.parent_element				= velScalePlaceholder.name
	setBrightnessAndVisibCtrlr(velocityNumber200, 1, verticalPos)
	
	-- dots from '200' to '150'
	for i = 1, 4 do
		-- Move pos
		verticalPos									= verticalPos + velocityScaleMils[9][2] / 5
		addDot("velocityScaleDotPositive_1"..(10-i).."0", velScalePlaceholder.name, {dotShiftX, verticalPos})
	end
	
	-- '150'
	-- Move pos to '150'
	verticalPos										= verticalPos + velocityScaleMils[9][2] / 5
	local plusSign150 								= addPlusSign("velocityScalePlusSign_150", velScalePlaceholder.name, {0, verticalPos})
	local velocityNumber150 						= SightAddText_Pos_Val("velocityScaleDigits_150", nil, {velocityDigitsShiftX, verticalPos}, scalesLevel, "LeftCenter", "I50", 3, SIGHT_COLOR_AMBER)
	velocityNumber150.parent_element				= velScalePlaceholder.name
	setBrightnessAndVisibCtrlr(velocityNumber150, 1, verticalPos)
	
	-- dots from '150' to '100'
	for i = 1, 4 do
		-- Move pos
		verticalPos									= verticalPos + velocityScaleMils[10][2] / 5
		addDot("velocityScaleDotPositive_1"..(5-i).."0", velScalePlaceholder.name, {dotShiftX, verticalPos})
	end
	
	-- Move pos to '100'
	verticalPos										= verticalPos + velocityScaleMils[10][2] / 5
	
	-- from '100' to '0'
	for i = 1, 5 do
		local digits								= (6-i) * 20
		
		local plusSign 								= addPlusSign("velocityScalePlusSign_"..digits, velScalePlaceholder.name, {0, verticalPos})
		
		local txtDigits
		if digits == 100 then
			txtDigits = "I00"
		else
			txtDigits = ""..digits
		end
		
		local velocityNumber 						= SightAddText_Pos_Val("velocityScaleDigitsPositive_"..digits, nil, {velocityDigitsShiftX, verticalPos}, scalesLevel, "LeftCenter", txtDigits, 3, SIGHT_COLOR_AMBER)
		velocityNumber.parent_element				= velScalePlaceholder.name
		setBrightnessAndVisibCtrlr(velocityNumber, 1, verticalPos)
		
		local dot									= addDot("velocityScaleDotPositive_"..digits, velScalePlaceholder.name, {dotShiftX, verticalPos + velocityScaleMils[11][2] * 0.5})
		
		-- Move pos
		verticalPos									= verticalPos + velocityScaleMils[11][2]
	end
	
	-- '0'
	local zeroTick1									= addLongTick("velocityScaleTick_0_1", velScalePlaceholder.name, {0, verticalPos}, SIGHT_COLOR_AMBER)
	addLongTick("velocityScaleTick_0_2", velScalePlaceholder.name, {11, verticalPos}, SIGHT_COLOR_AMBER)
	
	local velocityNumber0 							= SightAddText_Pos_Val("velocityScaleDigits_0", nil, {velocityDigitsShiftX + 1.6, verticalPos}, scalesLevel, "LeftCenter", "0", 3, SIGHT_COLOR_AMBER)
	velocityNumber0.parent_element					= velScalePlaceholder.name
	setBrightnessAndVisibCtrlr(velocityNumber0, 1, verticalPos)
	
	-- Move pos to '-20'
	verticalPos										= verticalPos + velocityScaleMils[11][2]
		
	-- from '0' to '-100'
	for i = 1, 5 do
		local digits								= i * 20
		
		local tick 									= addLongTick("velocityScaleTick_"..digits, velScalePlaceholder.name, {0, verticalPos}, SIGHT_COLOR_AMBER)
		
		local txtDigits
		if digits == 100 then
			txtDigits = "I00"
		else
			txtDigits = ""..digits
		end
		
		local velocityNumber 						= SightAddText_Pos_Val("velocityScaleDigits_"..digits, nil, {velocityDigitsShiftX, verticalPos}, scalesLevel, "LeftCenter", txtDigits, 3, SIGHT_COLOR_AMBER)
		velocityNumber.parent_element				= velScalePlaceholder.name
		setBrightnessAndVisibCtrlr(velocityNumber, 1, verticalPos)
		
		local dot									= addDot("velocityScaleDot_"..digits, velScalePlaceholder.name, {dotShiftX, verticalPos - velocityScaleMils[11][2] * 0.5})
		
		if i ~= 5 then
			-- Move pos
			verticalPos								= verticalPos + velocityScaleMils[11][2]
		end
	end
	
	-- upper V symbol
	local VsymbolUpper 								= addVsymbol("VsymbolUpper", velScalePlaceholder.name, {VsymbolShiftX, verticalPos + VsymbolShiftY})
	
	
	-- Move pos to the 'no scales pos'
	verticalPos										= verticalPos + altVelSclNoScalePos
	
	
	-- Altitude Scale
	
	local function addShortestTick(name, parent_name, init_pos)
		local shortestTickHalfWidth 				= 1.8
		local shortestTickVerts 					=
			{{-shortestTickHalfWidth, -line3_HalfWidth},
			 {-shortestTickHalfWidth, line3_HalfWidth},
			 {shortestTickHalfWidth, line3_HalfWidth},
			 {shortestTickHalfWidth, -line3_HalfWidth}}

		local line 									= SightAddTexuredElement(name, shortestTickVerts, getTexParams(866, 258), nil, init_pos, nil, scalesLevel, SIGHT_COLOR_GREEN)
		line.parent_element							= parent_name
		setBrightnessAndVisibCtrlr(line, 1, init_pos[2])
		
		return line
	end
	
	local altScalePlaceholder 						= addPlaceholder("altScalePlaceholder", nil, {{"alt_vel_scl_scale_kind", 1}})
	altScalePlaceholder.parent_element				= scaleMovablePlaceholder.name
	
	addReference("altitudeScaleReference", scalesPlaceholder.name, SIGHT_COLOR_GREEN, -1)
	
	local drawTxt									= true
	
	local altitudeDigitsShiftX						= 4
	
	-- Move pos to '0'
	verticalPos										= verticalPos + altVelSclNoScalePos
	
	for i = 1, #altitudeScaleMils do
		local digits 								= altitudeScaleMils[i][1]
			
		if digits > 100 and digits < 350 then
			drawTxt									= true
		end
			
		if drawTxt == true then
			local longTick 							= addLongTick("altitudeScaleTick_"..digits, altScalePlaceholder.name, {0, verticalPos}, SIGHT_COLOR_GREEN)
			
			local txtSize
			if digits < 1000 then
				txtSize = 3
			else
				txtSize = 1
			end
			
			local txtDigits
			if digits == 100 then
				txtDigits = "I00"
			elseif digits == 150 then
				txtDigits = "I50"
			elseif digits > 900 then
				if digits == 1000 then
					txtDigits = "I000"
				elseif digits == 1100 then
					txtDigits = "II00"
				else
					txtDigits = "I"..(digits % 1000)
				end
			else
				txtDigits = ""..digits
			end
			
			local txtPosX
			local txtAlignment
			
			if i == 1 then
				txtPosX 							= altitudeDigitsShiftX + 3.5
				txtAlignment						= "CenterCenter"
				
				local longTick2 					= addLongTick("altitudeScaleTick_"..digits.."_2", altScalePlaceholder.name, {txtPosX * 2, verticalPos}, SIGHT_COLOR_GREEN)
				longTick2.init_rot					= {180}
			else
				txtPosX 							= altitudeDigitsShiftX
				txtAlignment						= "LeftCenter"
			end
			
			local altitudeNumber 					= SightAddText_Pos_Val("altitudeScaleDigits_"..digits, nil, {txtPosX, verticalPos}, scalesLevel, txtAlignment, txtDigits, txtSize, SIGHT_COLOR_GREEN)
			altitudeNumber.parent_element			= altScalePlaceholder.name
			setBrightnessAndVisibCtrlr(altitudeNumber, 1, verticalPos)
			
			if i == 1 then
				local shortestTickShiftX			= 3.5
				local shortestTickShiftY			= 2
				
				addShortestTick("shortestTickLeft", altScalePlaceholder.name, {txtPosX - shortestTickShiftX, verticalPos - shortestTickShiftY})
				addShortestTick("shortestTickRight", altScalePlaceholder.name, {txtPosX + shortestTickShiftX, verticalPos - shortestTickShiftY})
				addShortestTick("shortestTickLower", altScalePlaceholder.name, {txtPosX, verticalPos - shortestTickShiftY * 2})
			end
		else
			local shortTick 						= SightAddLine("altitudeScaleTick_"..digits, 2.4, getTexParams(842, 204), nil, {0, verticalPos}, nil, scalesLevel, 3, SIGHT_COLOR_GREEN)
			shortTick.parent_element				= altScalePlaceholder.name
			setBrightnessAndVisibCtrlr(shortTick, 1, verticalPos)
		end
		
		-- Move pos
		verticalPos									= verticalPos + altitudeScaleMils[i][2]
		drawTxt										= not drawTxt
	end
	
	-- Short tick at '1950' (without digits)
	local shortTick1950 							= SightAddLine("altitudeScaleTick_1950", 2.4, getTexParams(842, 204), nil, {0, verticalPos}, nil, scalesLevel, 3, SIGHT_COLOR_GREEN)
	shortTick1950.parent_element					= altScalePlaceholder.name
	setBrightnessAndVisibCtrlr(shortTick1950, 1, verticalPos)
	
	if dbgDisableScalesMask == false then
		-- Close scales masking window
		local closeMask 								= closeMaskArea("altitudeVelocitySclCloseMask", maskVerts, nil, scalesLevel)
		closeMask.indices  								= maskIndices
		closeMask.init_pos 								= scalesPos
	end
end

drawDbgGeometry 									= false

