local base = _G

module('me_coords_info')

local DialogLoader	= base.require('DialogLoader')
local Static		= base.require('Static')
local i18n			= base.require('i18n')
local MapWindow		= base.require('me_map_window')
local U				= base.require('me_utilities')
local Terrain		= base.require('terrain')
local UC			= base.require('utils_common')
local OptionsData	= base.require('Options.Data')

i18n.setup(_M)

local cdata = 
{
	coord 				= _("COORDINATES"),
	Metric				= _("Metric"),
	Lat_Long			= _("Lat Long"),
	Lat_Long_Decimal	= _("Lat Long Decimal Minutes"),
	MGRS_GRID			= _("MGRS GRID"),
	Precise_Lat_Long	= _("Precise Lat/Long"),
	Altitude 			= _("Altitude_coord","Altitude"),
	feet				= _('feet'),
	m					= _('m'),
    Ok          		= _("Ok"),

    
}

function create_()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_coords_info.dlg", cdata)
    window:setPosition(100, 100)
    
	window.btnOk.onChange = onChange_Ok
	
	e_Metric 			= window.e_Metric
	e_Lat_Long			= window.e_Lat_Long
	e_Lat_Long_Decimal	= window.e_Lat_Long_Decimal
	e_Precise_Lat_Long	= window.e_Precise_Lat_Long
	e_MGRS_GRID			= window.e_MGRS_GRID
	e_AltM				= window.e_AltM
	e_AltFeet			= window.e_AltFeet
end


function show(b)
    if b == true then
		if not window then
			create_()
		end
        window:setVisible(true)
        update()
    elseif window then
        window:setVisible(false)
    end
end

function update()
	x, y = MapWindow.getCurPosition()	
	if x == nil or y == nil then
		show(false)
		return 
	end

	local lat, long = MapWindow.convertMetersToLatLon(x, y)
	local datum = OptionsData.getMiscellaneous('Datum')
	if datum == 2 then
		lat, long = UC.LL_datum_convert(1, 2, lat, long)
	end	
	
	e_Metric:setText(U.text_coords_Metric(x,y))
	e_Lat_Long:setText(U.text_coords_LatLong('lat', U.toRadians(lat)).."   "..U.text_coords_LatLong('long', U.toRadians(long)))
	e_Lat_Long_Decimal:setText(U.text_coords_LatLongD('lat', U.toRadians(lat)).."   "..U.text_coords_LatLongD('long', U.toRadians(long)))
	e_Precise_Lat_Long:setText(U.text_coords_LatLongHornet('lat', U.toRadians(lat)).."   "..U.text_coords_LatLongHornet('long', U.toRadians(long)))
	e_MGRS_GRID:setText(Terrain.GetMGRScoordinates(x,y))
	
	local alt = Terrain.GetHeight(x, y)
	
	e_AltM:setText(base.math.floor(alt+0.5))
	e_AltFeet:setText(base.math.floor(alt/0.3048+0.5))
end

function onChange_Ok()
    show(false)
end


