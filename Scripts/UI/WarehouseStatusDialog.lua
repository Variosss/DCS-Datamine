local base = _G

module('WarehouseStatusDialog')

local require = base.require
local tostring = base.tostring

local DialogLoader 	    = require('DialogLoader')	
local Static 			= require('Static')
local GridHeaderCell 	= require('GridHeaderCell')
local RadioButton       = require('RadioButton')
local gettext			= require('i_18n')

local function _(text) 
	return gettext.translate(text) 
end

local colums = {170,91,24}
local cellSkin

function radio_button_item(radioButton,i)
	function radioButton:onChange()
		if selectResourceGroup then
		   selectResourceGroup(i)
		end
	end
	return radioButton
end

function create()
	local localization = {
		warehouseState	= _('Warehouse State'),
		ok				= _('OK'),
		type			= _('type'),
		count			= _('count'),
		a2aMissiles		= _('A2A MISSILES'),
		a2gMissiles		= _('A2G MISSILES'),
		rockets			= _('ROCKETS'),
		bombs			= _('BOMBS'),
		bombsGuided		= _('BOMBS GUIDED'),
		fuelTanks		= _('FUEL TANKS'),
		aircraft		= _('AIRCRAFT'),
		jetFuel			= _('JET FUEL'),
		gasoline		= _('GASOLINE'),
		methanolMix		= _('METHANOL MIX'),
		diesel			= _('DIESEL'),
		misc			= _('MISC'),
	}
	
	window = DialogLoader.spawnDialogFromFile('Scripts/UI/WarehouseStatusDialog.dlg', localization)
	window:centerWindow()
    
    cellSkin = window.panel0.staticCell:getSkin()
    
    function window.panel0.buttonOk:onChange()
        show(false)
    end

    function window.bClose:onChange()
        show(false)
    end
    
	rc_list = window.panel0.rc_list
	MISSILES_A2A = radio_button_item(window.panel0.MISSILES_A2A, 0)
	MISSILES_A2G = radio_button_item(window.panel0.MISSILES_A2G, 1)
	ROCKETS		 = radio_button_item(window.panel0.ROCKETS		, 2)
	BOMBS		 = radio_button_item(window.panel0.BOMBS		, 3)
	BOMBS_GUIDED = radio_button_item(window.panel0.BOMBS_GUIDED, 4)
	FUEL_TANKS	 = radio_button_item(window.panel0.FUEL_TANKS	, 5)
	AIRCRAFTS	 = radio_button_item(window.panel0.AIRCRAFTS	, 6)
	MISC		 = radio_button_item(window.panel0.MISC 		, 7)
end

function destroy()
	if window then
	   window:kill()
	   window = nil
	end
end;

function show(state)
	if state and not window then
	   create()
	end
	if window then
	   window:setVisible(state);
	end
end

function set_row_count(count,do_not_decrease)
	if  not window or 
		not rc_list then
		return
	end
	local c = rc_list:getRowCount()
	if  c > count then
		if do_not_decrease then
		   return
		end
		for i = c - 1,count - 1,-1 do
			rc_list:clearRow(i)
		end
	elseif c < count then
		for i = c,count-1 do
			rc_list:insertRow(15)
			for j = 0,rc_list:getColumnCount() - 1 do
				local cell = Static.new('')
				cell:setSkin(cellSkin)
				rc_list:setCell(j,i,cell)			
			end
		end		
	end
end

function update_item(row,item,status)
	if  window and rc_list then
		local w1 = rc_list:getCell(0,row)
		local w2 = rc_list:getCell(1,row)	
		if w1 and w2 then
		   w1:setText(item)	
		   w2:setText(status)		
  	    end
	end
end

function set_fuel(jet,gas,methanol,diesel)
	
	if not window then return end
	
	local txt = function (item,value)
		if item then
			if value < 10 then
				item:setText("EMPTY")
			elseif value < 100 then
				item:setText("< 100 kg")
			else
				item:setText(base.string.format("%.1f t",value/1000.0))
			end
		end
	end
	txt(window.panel0.jet_fuel,jet)
	txt(window.panel0.gasoline,gas)
	txt(window.panel0.methanol,methanol)
	txt(window.panel0.diesel  ,diesel)
end

function test_fill()
	local eqp_table = {}
  local row_count = 100
  set_row_count(row_count)
	for i = 1,row_count  do
		update_item(i-1,"equipment_" .. tostring(i),i)
	end
end
