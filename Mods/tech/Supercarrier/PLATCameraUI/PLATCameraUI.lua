package.path =	package.path
				.. ';./Scripts/?.lua;'
				.. './Scripts/Common/?.lua;'
				.. './Scripts/UI/?.lua;'
				.. './dxgui/bind/?.lua;'
				.. './dxgui/loader/?.lua;'
				.. './dxgui/skins/skinME/?.lua;'
				.. './dxgui/skins/common/?.lua;'
				.. './MissionEditor/modules/?.lua;'
				
local DialogLoader			= require('DialogLoader')
local gettext				= require('i_18n')
local dxgui					= require('dxgui')
local SkinUtils 			= require('SkinUtils')

local function _(text) 
    return gettext.translate(text) 
end

local LSOStation_
local LSOStationCuePanel_

local platcam_
local platcam_night = nil
local localization  = 
{
}
function bindPLATCameraPicture(pict)
	local skin = LSOStation_.PLATCamera:getSkin()  
	LSOStation_.PLATCamera:setSkin(SkinUtils.setStaticPicture(pict,skin))
end


local hookToRamp0  = 464
local hookToRamp30 = 104

local hookTouchDown0  		= 728
local hookTouchDown350 	  	= 14

local function setHookToRampMarkerPos(widget,feet)
	if feet > 45 or feet < -10 then
		widget:setVisible(false)
		return
	else
		widget:setVisible(true)
	end

	local pixel_y = hookToRamp0 + feet * (hookToRamp30 - hookToRamp0)/30
		
	local x,y   = widget:getPosition()
	local w,h   = widget:getSize()
	local x0,y0 = LSOStation_.STATIC_GRID:getPosition()
	
	pixel_y = pixel_y - 0.5 * h + y0

	widget:setPosition(x,pixel_y)
end

function setHookTouchdownMarkerPos(widget,feet)
	if feet > 350 or feet < 0 then
		widget:setVisible(false)
		return
	else
		widget:setVisible(true)
	end
	
	local pixel_x = hookTouchDown0 + feet * (hookTouchDown350 - hookTouchDown0)/350
	
	local x,y   = widget:getPosition()
	local w,h   = widget:getSize()
	local x0,y0 = LSOStation_.STATIC_GRID:getPosition()
	
	pixel_x = pixel_x - 0.5 * w + x0
	
	widget:setPosition(pixel_x,y)
end

function setHookToRampMarker(feet)
	setHookToRampMarkerPos(LSOStation_.HTR_MARKER,feet)
end

function setHookTouchdownMarker(feet)
	setHookTouchdownMarkerPos(LSOStation_.HTD_MARKER,feet)
end

function setHookToRampDesired(feet)
	setHookToRampMarkerPos(LSOStation_.HTR_DESIRED,feet)
end

function setHookTouchdownDesired(feet)
	setHookTouchdownMarkerPos(LSOStation_.HTD_DESIRED,feet)
end

local ropes = {170,210,250,290}

function setDesiredRope(idx)
	setHookTouchdownMarkerPos(LSOStation_.ROPE_DESIRED,ropes[idx])
end


local function setPLATCameraBounds(x,y,w,h)
	platcam_:setBounds(x,y,w,h)

	if platcam_.REFERENCE then

		local aspect = 1274/928
		local w_1 = h * aspect
		local x_1 = w/2 - w_1/2

		platcam_.REFERENCE:setBounds(w/2 - 1274/2,h/2 - 928/2,1274,928)
	end
	local symbol      = 57
	
	local w1 = 1274
	local h1 = 928
	if w1 > w then
	   w1 = w 
	end
	
	if h1 > h then
	   h1 = h 
	end
	
	local column_0    =  w/2 - 440
	local column_1    =  w/2 + 3 * symbol
	
	local row_0       =  (h/2 - h1/2) + 10
	local row_1       =  row_0 + 70
	local row_3       =  (h/2 + h1/2) - 136
	
	platcam_.DATE	      :setPosition(column_0,row_0)
	platcam_.LOCAL_TIME    :setPosition(column_0,row_1)
	platcam_.ARCFT_SPEED   :setPosition(column_0,row_3)
	platcam_.CARRIER_STATUS:setPosition(column_1,row_0)
	platcam_.CARRIER_ID    :setPosition(column_1 + 3 * symbol,row_0)
	platcam_.DECK_WIND     :setPosition(column_1 + 72,row_1)
	
	
	platcam_.W		   		 :setPosition(column_0 + 5 * symbol	,row_3)
	platcam_.DISTANCE   		 :setPosition(w /2	,row_3)
	platcam_.VERTICAL_SPEED   :setPosition(column_1 + 3 * symbol ,row_3)
end

local function create_PLATCamera()
	platcam_	= DialogLoader.spawnDialogFromFile('Mods/tech/Supercarrier/PLATCameraUI/PLATCameraUI.dlg', localization)
	platcam_:setVisible(false)
	if platcam_.REFERENCE then
	   platcam_.REFERENCE:setVisible(false)
	end
	platcam_.CARRIER_ID:setText("74")
	
	setPLATCameraBounds(0,0,1174,828)
	platcam_night = nil
end


local cue_panel_grid 		= {}
local cue_panel_aircraft 	= {}
local case_III_idx			= 0

local cue_panel_columns = {14,71,203,265,335,381,443,466,793}
local cue_panel_row_0   = 74


local function cue_panel_grid_set(row,column,value)
	if not value  then
	   if cue_panel_grid[row] and cue_panel_grid[row][column] then
		  cue_panel_grid[row][column]:setVisible(false)
		  return
	   end
	end 
	
	if not cue_panel_grid[row] then
	    cue_panel_grid[row]  = {}
	end
	local widget = cue_panel_grid[row][column]
	if not widget then
		widget						 = LSOStationCuePanel_.text_template:clone()
	    cue_panel_grid[row][column]  = widget

		local x, y, w, h	= widget:getBounds()

		widget:setBounds(cue_panel_columns[column],cue_panel_row_0 + 27 * (row - 1),cue_panel_columns[column + 1] - cue_panel_columns[column], h)
		LSOStationCuePanel_:insertWidget(widget)
	end 
	widget:setVisible(true)
	widget:setText(value)
end

local function cue_panel_aircraft_set(idx,x,z,yaw,boardnumber,fuel)

	local x0 		= 1097
	local y0 		= 341
	local twoMiles  = 66
	local pix_y 	= y0 - twoMiles * x / (1852 * 2)
	local pix_x 	= x0 + twoMiles * z / (1852 * 2)
	
	if  pix_y < 22 or pix_y > 748 or pix_x < 812 then
		return
	end
	
	if not cue_panel_aircraft[idx] then
	    cue_panel_aircraft[idx] = LSOStationCuePanel_.aircraft:clone()
		LSOStationCuePanel_:insertWidget(cue_panel_aircraft[idx])
	end	
	
	local widget = cue_panel_aircraft[idx]
	widget:setVisible(true)	
	
	widget.aircraft:setAngle(math.deg(yaw))
	widget.board:setText(boardnumber) 
	widget.fuel:setText(string.format("%0.1f",fuel*0.001)) 
	
	local x,y =  widget.aircraft:getPosition()
	widget:setPosition(pix_x - 24 - x,pix_y - 40 - y)
end

function cleanCuePanel()
	for i,o in pairs(cue_panel_grid) do
		if o then
			for j,w in pairs(o) do
				if w then 
					w:setVisible(false)
				end
			end
		end
	end
	
	case_III_idx = 0
	
	for i,w in pairs(cue_panel_aircraft) do
		if w then 
			w:setVisible(false)
		end
	end
	
	LSOStation_.CASE_III_1:setVisible(false)
	LSOStation_.CASE_III_2:setVisible(false)
	LSOStation_.CASE_III_3:setVisible(false)
	
end

function setCuePanelInfo(idx,status,boardnumber,pilot,x,z,yaw,fuelstate,col3,col5,col6,col7,col8)
	cue_panel_grid_set(idx,1,boardnumber)
	cue_panel_grid_set(idx,2,pilot)
	cue_panel_grid_set(idx,3,col3)
	cue_panel_grid_set(idx,4,string.format("%0.1f/00",fuelstate*0.001))
	cue_panel_grid_set(idx,5,col5)
	cue_panel_grid_set(idx,6,col6)
	cue_panel_grid_set(idx,7,col7)
	cue_panel_grid_set(idx,8,col8)
	
	local active    = status > -1 and status < 2
	local iscaseiii = status > 0
	if iscaseiii then
		case_III_idx = case_III_idx + 1
		cue_panel_aircraft_set(case_III_idx,x,z,yaw,boardnumber,fuelstate)
		if  case_III_idx < 4 and boardnumber then
			local caseiii_cue = {LSOStation_.CASE_III_1,LSOStation_.CASE_III_2,LSOStation_.CASE_III_3}
			local c = caseiii_cue[case_III_idx]
			c:setVisible(true)
			c:setText(boardnumber)
		end
	end
end

local function onCuePanelCreate()
	LSOStationCuePanel_:setVisible(true)
	LSOStationCuePanel_.text_template:setVisible(false)
	LSOStationCuePanel_.aircraft:setVisible(false)
end



function setCaseIIIStack(brd1,brd2,brd3)
	LSOStation_.CASE_III_1:setText(brd1 or "")
	LSOStation_.CASE_III_2:setText(brd2 or "")
	LSOStation_.CASE_III_3:setText(brd3 or "")
end

local function onLSOStationCreate()
	
	local x, y = LSOStation_.SIG_CLEAR:getPosition()
	LSOStation_.SIG_FOUL:setPosition(x, y)
	setHookToRampMarker	  (20)
	setHookTouchdownMarker(200)
	
	setHookToRampDesired(14.1)
	setHookTouchdownDesired(230)
	
	setDesiredRope(3)
	
	LSOStation_.CASE_III_1:setVisible(false)
	LSOStation_.CASE_III_2:setVisible(false)
	LSOStation_.CASE_III_3:setVisible(false)

	LSOStation_.OVERTEMP:setVisible(false)
end

local function create_LSOStation()
	LSOStation_	= DialogLoader.spawnDialogFromFile('Mods/tech/Supercarrier/PLATCameraUI/LSOStation.dlg', localization)
	LSOStation_:setVisible(true)
	if LSOStation_.REFERENCE then
	   LSOStation_.REFERENCE:setVisible(false)
	end
	bindPLATCameraPicture("LSOFRAME")
	onLSOStationCreate()

	
	LSOStationCuePanel_ = DialogLoader.spawnDialogFromFile('Mods/tech/Supercarrier/PLATCameraUI/LSOStationScreen2.dlg', localization)
	onCuePanelCreate()
end


function setCarrierID(unitType)
	local v = string.match(unitType,"%d+")
	if v == nil then 
	   v = "XX"
	end
	platcam_.CARRIER_ID:setText(tostring(v))
end

function create()
	create_PLATCamera()
	create_LSOStation()
end


function kill()
	platcam_:kill()
	platcam_ = nil
	if  LSOStation_ then
		LSOStation_:kill()
		LSOStation_ = nil
	end
	
	if  LSOStationCuePanel_ then
		LSOStationCuePanel_:kill()
		LSOStationCuePanel_ = nil
	end
end

local function show_windows(val)

	if  platcam_ then
		platcam_   :setVisible(val)
	end
	if  LSOStation_ then
		LSOStation_:setVisible(val)
	end
	if  LSOStationCuePanel_ then
		LSOStationCuePanel_:setVisible(val)
	end
end

function show()	
	show_windows(true)
end

function hide()
	show_windows(false)
end

function setDeckWind(deckwind,crosswind_component)

	local wnd    = string.format("%02d",math.abs(deckwind) * 1.94384)
	local cross  = crosswind_component * 1.94384

	platcam_.DECK_WIND:setText(wnd)
	LSOStation_.DECK_WIND:setText(wnd)
	
	if cross > 1 then
		LSOStation_.CROSSWIND_PORT:setVisible(true)
		LSOStation_.CROSSWIND_PORT:setText(string.format("%2d P",cross + 0.5))
		LSOStation_.CROSSWIND_STAR:setVisible(false)
	elseif cross < -1 then
		LSOStation_.CROSSWIND_STAR:setVisible(true)
		LSOStation_.CROSSWIND_STAR:setText(string.format("%2d S",math.abs(cross) + 0.5))
		LSOStation_.CROSSWIND_PORT:setVisible(false)
	else
		LSOStation_.CROSSWIND_PORT:setVisible(false)
		LSOStation_.CROSSWIND_STAR:setVisible(false)
	end

end

function setShipYawPitchRoll(heading,pitch,roll)
	-- heading - magnetic

	LSOStation_.MAGNETIC_HEADING:setText(string.format("SH %03d DEG",heading))
	if roll > 0 then
		LSOStation_.LIST_VALUE:setText(string.format("%0.1f STBD DOWN",roll))
	else
		LSOStation_.LIST_VALUE:setText(string.format("%0.1f STBD UP",math.abs(roll)))
	end

	if pitch > 0 then
		LSOStation_.TRIM_VALUE:setText(string.format("%0.1f BOW UP",pitch))
	else
		LSOStation_.TRIM_VALUE:setText(string.format("%0.1f BOW DOWN",math.abs(pitch)))
	end
end

function adjustGate(fov,distance,optimal_glissade_delta_h)

	if  distance < 35 then
		distance = 35
	end

	local x,y,w,h   = platcam_:getBounds()

	local tan_half_fov  		 =  math.tan(math.rad(fov/2))
	local w_gate      			 =  w * math.tan(math.rad(1/2)) / tan_half_fov
	local tan_half_vertical_FOV  =  tan_half_fov * h / w 
	

	
	local d_pixels     	=  h * (optimal_glissade_delta_h/distance) / (2 * tan_half_vertical_FOV)
	
	local sz			= 4
	local h_gate		=  w_gate * h / w  
	local center_gate	= h/2 - d_pixels

	platcam_.HORIZONTAL_LEFT :setBounds(0				  ,center_gate - sz/2	 ,w/2 - w_gate/2,sz)
	platcam_.HORIZONTAL_RIGHT:setBounds(w/2 + w_gate/2     ,center_gate - sz/2	 ,w/2 - w_gate/2,sz)
	platcam_.VERTICAL_TOP 	:setBounds(w/2 - sz/2		  ,0		 	 ,sz			,center_gate - h_gate/2)
	platcam_.VERTICAL_BOTTOM :setBounds(w/2 - sz/2		  ,center_gate + h_gate/2,sz	,h - center_gate - h_gate/2)
	
end

function setFoulDeck(val)

	LSOStation_.SIG_FOUL :setVisible(val > 0)
	LSOStation_.SIG_CLEAR:setVisible(val < 1)
	
	if val < 1 then
		platcam_.CARRIER_STATUS:setText("C")
		platcam_.CARRIER_STATUS:setVisible(true)
	else
		platcam_.CARRIER_STATUS:setText("F")
		platcam_.CARRIER_STATUS:setVisible(val  > 1)
	end
end

function setAircraftData(distance,speed,Vy,waveoff)
	platcam_.ARCFT_SPEED   :setText(string.format("%03d",speed    * 1.94384))
	
	local d = math.floor(distance * 3.28084 / 100) * 100
	local v = -Vy * 3.28084
	if v < 0 then 
	   v = 0
	end
	platcam_.DISTANCE      :setText(string.format("%05d",d))
	platcam_.VERTICAL_SPEED:setText(string.format("%02d",v))
	platcam_.W:setVisible(waveoff)
end


function setHook(touchdown,ramp)
	setHookToRampMarker	  (ramp * 3.28084)
	setHookTouchdownMarker(touchdown * 3.28084)
end

function setDate(Y,M,D)
	platcam_.DATE:setText(string.format("%02d-%02d-%02d",M,D,Y))
end

function setTime(H,M,S)
	platcam_.LOCAL_TIME:setText(string.format("%02d:%02d:%02d",H,M,S))
end

function setNightMode(night)

	if platcam_night ~= nil and  night == platcam_night then
	   return
	end
	
	platcam_.DATE				:setEnabled(not night)
	platcam_.LOCAL_TIME			:setEnabled(not night)
	platcam_.ARCFT_SPEED		:setEnabled(not night)
	platcam_.CARRIER_STATUS		:setEnabled(not night)
	platcam_.CARRIER_ID			:setEnabled(not night)
	platcam_.DECK_WIND			:setEnabled(not night)
	platcam_.W					:setEnabled(not night)
	platcam_.DISTANCE			:setEnabled(not night)
	platcam_.VERTICAL_SPEED		:setEnabled(not night)
	platcam_.HORIZONTAL_LEFT	:setEnabled(not night)
	platcam_.HORIZONTAL_RIGHT	:setEnabled(not night)
	platcam_.VERTICAL_TOP 		:setEnabled(not night)
	platcam_.VERTICAL_BOTTOM 	:setEnabled(not night)
	
	platcam_night = night
end

function getPLATCamera()
	return platcam_.widget
end

function getLSOStation()
	return LSOStation_.widget
end

function getLSOStationCuePanel()
	return LSOStationCuePanel_.widget
end

function unit_test_cuepanel(wnd)
	LSOStationCuePanel_ = wnd
	onCuePanelCreate();
	setCuePanelInfo(8,-1,"401","DENISKIN",-10000,-10000,-0.5,6000)
	setCuePanelInfo(4,-1,"302","GERASEV" ,0,0,0,6000)
	
end 


function unit_test(wnd)
	platcam_ = wnd
	
	if not platcam_.CARRIER_ID then
		return
	end
	
	show()
	platcam_.CARRIER_ID:setText("74")
	
	setPLATCameraBounds(100,100,1274,928)
	adjustGate(60,100,0)
	
	setAircraftData(1000,100, -5)
	
	setHookToRampMarker(15)
	setHookTouchdownMarker(230)
	
	setDesiredRope(3)

end
