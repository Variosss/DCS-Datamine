dofile('./Scripts/UI/initGUI.lua')

local base = _G

module('StatusBarDialog')

local Gui 			= base.require("dxgui")
local GuiWin 		= base.require("dxguiWin")
local DialogLoader 	= base.require('DialogLoader')
local WidgetParams 	= base.require('WidgetParams')
local gettext 		= base.require('i_18n')
local ListBoxItem	= base.require('ListBoxItem')

local metric  = true
local alt_K   = 1
local speed_K = 3.6
local degree_symbol  = base.degree_symbol

local SB_UNIT_CLASS_UNKNOWN					= 0;
local SB_UNIT_CLASS_JET_AIRCRAFT			= 1;
local SB_UNIT_CLASS_PISTON_ENGINE_AIRCRAFT	= 2;
local SB_UNIT_CLASS_HELICOPTER				= 3;
local SB_UNIT_CLASS_WEAPON					= 4;

local unit_class_type 		  = SB_UNIT_CLASS_UNKNOWN

local function UnitClassAircraft  ()  return unit_class_type > 0 and unit_class_type < SB_UNIT_CLASS_WEAPON;     end
local function UnitClassHelicopter()  return unit_class_type == SB_UNIT_CLASS_HELICOPTER;		 end
local function UnitClassAirplane  ()  return unit_class_type > 0 and unit_class_type < SB_UNIT_CLASS_HELICOPTER; end



local sprintf = base.string.format

local math = base.math

function round(x)
  return x>=0 and base.math.floor(x+0.5) or base.math.ceil(x-0.5)
end

local degrees  = function (degrees_value) return sprintf('%d%s', round(degrees_value), degree_symbol) end 
local degreesf = function (degrees_value) return sprintf('%3.1f%s', degrees_value, degree_symbol) end 

base.setmetatable(base.dxgui, {__index = base.dxguiWin})

local function _(text) 
	return gettext.translate(text) 
end

base._ = _

local translation = {
	IAS	 =_("IAS:"),
	TS   =_("TS:"),
	FLP  =_("FLP:"),
	AOA  =_("AOA:"),
	G    =_("G:"),
	HDG  =_("HDG:"),
	LOC  =_("LOC:"),
	TRQ  =_("TRQ:"),
	MPR  =_("MPR:"),
	PRP  =_("PRP:"),
	BNK  =_("BNK:"),
	PTH  =_("PTH:"),
	RPM  =_("RPM:"),
	ALT  =_("ALT:"),
	M    =_("m"),
	KNT  =_("kn"),
	FT   =_("ft"),
	KPH  =_("kmh"),
}


local RUMBs =
{
	_("N"),		--0			0
	_("NNE"),	--22.5		1
	_("NE"),	--45		2
	_("ENE"),	--67.5		3
	_("E"),		--90		4
	_("ESE"),	--112.5		5
	_("SE"),	--135		6
	_("SSE"),	--157.5		7
	_("S"),		--180		8
	_("SSW"),	--202.5		9
	_("SW"),	--225		10
	_("WSW"),	--247.5		11
	_("W"),		--270		12
	_("WNW"),	--292.5		13
	_("NW"),	--315		14
	_("NNW"),	--337.5		15
	_("N")		--360		16
};

function getRumb(degrees_value)
	degrees_value = base.math.fmod(degrees_value,360.0);
	if (degrees_value < 0) then
		degrees_value = degrees_value + 360;
	end
	local rmb = degrees_value / 22.5;
	return RUMBs[base.math.floor(rmb + 0.5)  + 1];
end


function make_same_pos(source,dest)
  if not dest then 
	return
  end
  local x_p, y_p, w_p, h_p = source:getBounds()
  local x  ,   y,   w,   h = dest:getBounds()
  dest:setPosition(x_p,y_p,w,h) 
end

function move(dest,dx,dy)
  if not dest then 
	return
  end
 
  local x  ,   y,   w,   h = dest:getBounds()
  
  local dx = dx or 0
  local dy = dy or 0
 
  dest:setPosition(x + dx,y + dy,w,h) 
  
  return x + dx,y + dy,w,h
end

function unitChanged(tp,hum,cpt,alt)
	unit_class_type	     	   = tp
	local unit_is_human   	   = hum or false
	local camera_is_in_cockpit = cpt or false
	local alternative		   = alt or false
	
	local aircraft  = UnitClassAircraft()
	if  aircraft and not alternative then 
		window.SPD_ALT.SPD:setText(translation.IAS)
	else 
		window.SPD_ALT.SPD:setText(translation.TS)
	end
	
	window.PROPENGINE:setVisible(unit_class_type == SB_UNIT_CLASS_PISTON_ENGINE_AIRCRAFT and unit_is_human) 
	window.HELICOPTER:setVisible(unit_class_type == SB_UNIT_CLASS_HELICOPTER)
	window.GWEAPON   :setVisible(unit_class_type == SB_UNIT_CLASS_WEAPON)
	window.AIRPLANE  :setVisible(UnitClassAirplane())
    window.AOA	     :setVisible(aircraft)
	if not aircraft then
		window.RPM	   		:setVisible(false)
		window.RPMSINGLE	:setVisible(false)
	end
end

local function updateTimeSlider()
	if	base.getModelTime ~= nil and time_control_dlg ~=nil then
		time_control_dlg.model_time_0_slider:setValue(base.getModelTime())
	end
end

local wind_data =
{
	[0]    = {speed = 0,dir = 0},  --{speed,dir}
	[500]  = {speed = 0,dir = 0},  --{speed,dir}
	[2000] = {speed = 0,dir = 0},  --{speed,dir}
	[8000] = {speed = 0,dir = 0},  --{speed,dir}
}

local function sendWind(level)
	local sp
	local dir
	if  level < 100 then 
		sp  = wind_data[500].speed
		dir = wind_data[500].dir
	else
		sp  = wind_data[level].speed
		dir = wind_data[level].dir
	end
	if base.setWindAtLevel then
	   base.setWindAtLevel(level,sp,dir)
	end
end

local function updateWind()
	for i,p in base.pairs(wind_data) do
		local sp,dir = base.getWindAtLevel(i)
		p.speed = sp
		p.dir   = dir
	end

	local  wind =  time_control_dlg.pWind
		
	wind.sp_wind_ground:setValue(wind_data[0].speed)
	wind.sp_wind_500   :setValue(wind_data[500].speed)
	wind.sp_wind_2000  :setValue(wind_data[2000].speed)
	wind.sp_wind_8000  :setValue(wind_data[8000].speed)

	wind.d_wind_ground :setValue(wind_data[500] .dir)
	wind.d_wind_2000   :setValue(wind_data[2000].dir)
	wind.d_wind_8000   :setValue(wind_data[8000].dir)
	
	wind.e_wind_ground :setValue(wind_data[500] .dir)
	wind.e_wind_2000   :setValue(wind_data[2000].dir)
	wind.e_wind_8000   :setValue(wind_data[8000].dir)
end
	
local function onChangeClouds(changed_preset)
	local clouds 			 = time_control_dlg.pClouds.c_clouds
	local clouds_level 		 = time_control_dlg.pClouds.sp_clouds_level
	local selected 			 = clouds:getSelectedItem()
	if  selected then
		local preset = selected.preset
		local level  = clouds_level:getValue()
		if changed_preset then
			clouds_level:setRange(preset.presetAltMin,preset.presetAltMax)
			if	level > preset.presetAltMax then
				level = preset.presetAltMax
				clouds_level:setValue(level)
			elseif level < preset.presetAltMax then
				level = preset.presetAltMin
				clouds_level:setValue(level)
			end
		end
		base.setClouds(preset.id,level)
	end
end
	
local function weather_time_create()

	local localization =
	{
		wind    		= _("WIND"),
		speed  	 		= _("WIND SPEED"),
		dir     		= _("WIND DIRECTION"),
		atGround    	= _('at 10 m'),
		at500       	= _('at 500 m'),
		at2000      	= _('at 2000 m'),
		at8000      	= _('at 8000 m'),
		TimeOfTheDay 	= _('TIME OF DAY'),
		ms				= _('m/s'),
		clouds_select	= _('CLOUDS'),
		clouds_level	= _('CLOUDS LEVEL'),
	}
	time_control_dlg = DialogLoader.spawnDialogFromFile("Scripts/UI/timeControl.dlg",localization)
	local tx,ty,tw,th = time_control_dlg:getBounds()
	local     x,y,w,h = window:getBounds()
	time_control_dlg:setBounds(x + w - tw - 8,y - th - 8,tw,th)
	time_control_dlg:setVisible(true)
	time_control_dlg.model_time_0_slider.onChange = function(self)
		if	base.setModelTime ~= nil then
			base.setModelTime(self:getValue())
		end
	end
	
	local clouds 		= time_control_dlg.pClouds.c_clouds
	if not cloud_presets then 
		cloud_presets = base.dofile("Config/Effects/getCloudsPresets.lua")
	end
	local clouds_i = {}
	for i,o in base.pairs(cloud_presets) do
		clouds_i[#clouds_i + 1] = o
	end

	base.table.sort(clouds_i,function(op1, op2) return op1.order < op2.order end)

	for i,o in base.ipairs(clouds_i) do
		local	item 				= ListBoxItem.new(o.readableName)
				item.preset			= o
		clouds:insertItem(item)
	end

	
	clouds.onChange = function(self)
		onChangeClouds(true)
	end
	
	time_control_dlg.pClouds.sp_clouds_level:setStep(500)
	time_control_dlg.pClouds.sp_clouds_level.onChange = function(self)
		onChangeClouds(false)
	end
	
	updateWind()

	local  wind =  time_control_dlg.pWind

	wind.sp_wind_ground.onChange = function(self)
		wind_data[0].speed 	 = self:getValue()
		sendWind(0)
		local sp,dir = base.getWindAtLevel(500)
		wind.sp_wind_500:setValue(sp)
	end
	wind.sp_wind_500.onChange  	= function(self)
		wind_data[500].speed 	= self:getValue()
		sendWind(500)
		local sp,dir = base.getWindAtLevel(0)
		wind.sp_wind_ground:setValue(sp)
	end
	wind.sp_wind_2000.onChange 	= function(self)
		wind_data[2000].speed 	= self:getValue()
		sendWind(2000)
	end
	wind.sp_wind_8000.onChange = function(self)
		wind_data[8000].speed 	= self:getValue()
		sendWind(8000)
	end
	wind.d_wind_ground.onChange = function(self)
		local value 		= self:getValue()
		wind_data[0]  .dir 	= value
		wind_data[500].dir 	= value
		wind.e_wind_ground:setValue(math.floor(value+0.5))
		sendWind(500)
	end	
	wind.d_wind_2000.onChange 	= function(self)
		local value 		= self:getValue()
		wind_data[2000].dir = value
		wind.e_wind_2000:setValue(math.floor(value+0.5))
		sendWind(2000)
	end
	wind.d_wind_8000.onChange = function(self)
		local value 		= self:getValue()
		wind_data[8000].dir = value
		wind.e_wind_8000:setValue(math.floor(value+0.5))
		sendWind(8000)
	end
	wind.e_wind_ground.onChange = function(self)
		local value 		= self:getValue()
		wind_data[0]  .dir 	= value
		wind_data[500].dir 	= value
		wind.d_wind_ground:setValue(value)
		sendWind(500)
	end	
	wind.e_wind_2000.onChange 	= function(self)
		local value 		= self:getValue()
		wind_data[2000].dir = value
		wind.d_wind_2000:setValue(value)
		sendWind(2000)
	end
	wind.e_wind_8000.onChange = function(self)
		local value 		= self:getValue()
		wind_data[8000].dir = value
		wind.d_wind_8000:setValue(value)
		sendWind(8000)
	end
end

local function init(new_window)
	local screenWidth, screenHeight = Gui.GetWindowSize()

	window = new_window

	local w, h = window:getSize()
	window:setBounds(0, screenHeight - 29, screenWidth, 29)

  
	window.AIRPLANE.FLP				:setText(translation.FLP)
	window.AOA.AOA					:setText(translation.AOA)
	window.AOA.G					:setText(translation.G)
	window.GWEAPON.G				:setText(translation.G)
	window.HEADINGLOCATION.HEADING	:setText(translation.HDG)
	window.HEADINGLOCATION.LOCATION	:setText(translation.LOC)
	window.HELICOPTER.TRQ			:setText(translation.TRQ)
	window.PROPENGINE.MPR			:setText(translation.MPR)
	window.PROPENGINE.PRP			:setText(translation.PRP)
	window.PTCHBANK.BANK			:setText(translation.BNK)
	window.PTCHBANK.PITCH			:setText(translation.PTH)
	window.RPM.RPM					:setText(translation.RPM)
	window.RPMSINGLE.RPM			:setText(translation.RPM)
	window.SPD_ALT.ALT				:setText(translation.ALT)


	local tx,ty,tw,th 		  = move(window.TIME_DATE,screenWidth - w)
	local oldx,oldy,oldw,oldh = window.BUTTONS:getBounds()
	window.BUTTONS:setPosition(tx - oldw,ty,oldw,oldh)
	
	window.BUTTONS.VISUALIZER.onChange = function()
		if	base.forceVisualizerMode ~= nil then
			local mode  = base.getVisualizerMode()  --VIS 0, FLIR 1, NVG 2
			mode = mode + 1
			if	mode > 2 then 
				mode = 0
			end
			base.forceVisualizerMode(mode)
			local mode_applied = base.getVisualizerMode()
			if 		mode_applied == 1 then
				window.BUTTONS.VISUALIZER:setText("FLIR")
			elseif	mode_applied == 2 then 
				window.BUTTONS.VISUALIZER:setText("NVG")
			else
				window.BUTTONS.VISUALIZER:setText("VIS")
			end
		end
	end
	
	window.TIME_DATE.TIME_CONTROL.onChange = function()
		if not time_control_dlg then
			weather_time_create()
		else
			time_control_dlg:setVisible(not time_control_dlg:isVisible())
			if time_control_dlg:isVisible() then
				updateWind()
			end
		end
		updateTimeSlider()
		
	end

	

	make_same_pos(window.AIRPLANE,window.HELICOPTER)
	make_same_pos(window.AIRPLANE,window.WEAPON)
	make_same_pos(window.AOA     ,window.GWEAPON)
	make_same_pos(window.RPM     ,window.RPMSINGLE)

	unitChanged(SB_UNIT_CLASS_UNKNOWN)
	
	setCursorAllowed(false)
end

function create()
  init(DialogLoader.spawnDialogFromFile("Scripts/UI/StatusbarExtended.dlg"))
end

function show()
	if not window then
	   create()
	end
	window:setVisible(true)
end

function hide()
  if window then
    window:setVisible(false)
  end
end

function visible()
	if not window then
	    return false
	else
		return window:getVisible()
	end
end

local function kill_time_control()
	if time_control_dlg then
		time_control_dlg:kill()
		time_control_dlg = nil
	end
end
function kill()
	Gui.SetWaitCursor(false)
	
	if window then
		window:kill()
		window = nil
	end
	
	kill_time_control()
end

function setCameraName(name, fontColor)
	local cameraName = window.TIME_DATE.CAMERA

	cameraName:setText(name)
	
	local skin = cameraName:getSkin()
	
	skin.skinData.states.released[1].text.color = fontColor

	cameraName:setSkin(skin)
end

function setMetric(value)
  metric = value
  if metric then     
     alt_K   = 1
	 speed_K = 3.6
	 window.SPD_ALT.SPDUNITS:setText(translation.KPH)
	 window.SPD_ALT.ALTUNITS:setText(translation.M)
  else
     alt_K   = 3.28084
	 speed_K = 3600/1852
 	 window.SPD_ALT.SPDUNITS:setText(translation.KNT)
	 window.SPD_ALT.ALTUNITS:setText(translation.FT)
  end
end


function setUnit(name,flagFilename,dist,direction)

	if dist ~= nil then
		dist = dist * 0.001 -- km
		if  not metric then
			dist = dist * 0.539957
		end
		name = name..sprintf("(%0.1f,%s)",dist,getRumb(direction))
	end
	window.UNIT.UNIT:setText(name)

	local flag 	= window.UNIT.FLAG
	local skin 	= flag:getSkin()
	local picture = skin.skinData.states.released[1].picture

	if '' == flagFilename then
		picture.file = nil
	else
		picture.file = flagFilename
	end
	flag:setSkin(skin)
end

function setMagnetic(mag_string)
  window.HEADINGLOCATION.MAGNETIC:setText(mag_string ..'/')
end

function setEulerAngles(yaw_str,yaw,pitch,bank)
  window.HEADINGLOCATION.HEADINGVALUE:setText(sprintf('%s(%s)',yaw_str,getRumb(yaw)))
  window.PTCHBANK.PITCHVALUE:setText(degrees(pitch))
  window.PTCHBANK.BANKVALUE:setText (degrees(bank))
end


function setSpeed(value)
  window.SPD_ALT.SPDVALUE:setText(sprintf('%4.f'  , value * speed_K))
end

function setAltitude(value)
  value = value * alt_K
  if value < 0.0 then
	value = base.math.ceil(value)
  else
    value = base.math.floor(value)
  end
  window.SPD_ALT.ALTVALUE:setText(sprintf('%5d', value))
end

function setGandAoA(g,aoa)
  local G_ = sprintf('%-4.1f' ,g)
  if aoa ~= nil then
	 window.AOA.AOAVALUE:setText(degreesf(aoa))
  end
  window.AOA.GVALUE:setText(G_)
  window.GWEAPON.GVALUE:setText(G_)
end

function setCoords(value)
  window.HEADINGLOCATION.LOCATIONVALUE:setText(value)  
end

function setUnitSpecific(a1,a2,a3,a4,a5,a6,a7)
	if not UnitClassAircraft() then 
		return
	end
	local rpm1 = a1
	local rpm2 = a2
	window.RPM	    :setVisible(rpm2 ~= nil)
	window.RPMSINGLE:setVisible(rpm2 == nil)
	
	if rpm2 == nil then 
		window.RPMSINGLE.RPM_1_VALUE:setText(sprintf("%d%%",rpm1 * 100))
	else
		window.RPM.RPM_1_VALUE:setText(sprintf("%d%%",rpm1 * 100))
		window.RPM.RPM_2_VALUE:setText(sprintf("%d%%",rpm2 * 100))
	end
	
	if  UnitClassAirplane()  then
		window.AIRPLANE.FLPVALUE:setText(sprintf("%d%%",a3 * 100))
		if  window.PROPENGINE:isVisible() then
			window.PROPENGINE.MPRVALUE:setText(a4)
			window.PROPENGINE.PRPVALUE:setText(degrees(a5))
		end	
	end
 
end

function setTime(DD,MM,YYYY,hh,mm,ss,sim_speed)
  window.TIME_DATE.DATE:setText(sprintf('%02d/%02d/%02d',DD,MM,YYYY))
  window.TIME_DATE.TIME:setText(sprintf('%02d:%02d:%02d' ,hh,mm,ss))
  window.TIME_DATE.SIMSPEED:setText(sim_speed)
end

function setCursorAllowed(value)
	if not base.allow_gm_tools or base.allow_gm_tools() == false then 
		value = false
	end
	window:setHasCursor(value)
	window.BUTTONS:setVisible(window:getHasCursor())
	window.TIME_DATE.TIME_CONTROL:setVisible(window:getHasCursor())
	if not value and time_control_dlg then 
	   time_control_dlg:setVisible(false)
	end
end


function unit_test(wnd)
	wnd:localize(translation)
	base.allow_gm_tools = function () return true end
	init(wnd)
	setCursorAllowed(true)
end

function unit_test_done(wnd)
	kill_time_control()
end
