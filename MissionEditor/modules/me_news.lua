local base = _G

module('me_news')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local tonumber = base.tonumber
local string = base.string
local math = base.math
local table = base.table
local os = base.os
local io = base.io
local assert = base.assert
local print = base.print
local unpack = base.unpack

local DcsWeb            = require('DcsWeb')
local S 			    = require('Serializer')
local i18n 			    = require('i18n')
local Window 		    = require('Window')
local Button 		    = require('Button')
local ScrollPane 	    = require('ScrollPane')
local Static		    = require('Static')
local U 			    = require('me_utilities')
local Panel 		    = require('Panel')
local lfs 			    = require('lfs')
local Tools 		    = require('tools')
local EditBox		    = require('EditBox')
local ToggleButton	    = require('ToggleButton')
local DialogLoader	    = require('DialogLoader')
local UpdateManager	    = require('UpdateManager')
local Gui               = require('dxgui')
local panel_waitDsbweb  = require('me_waitDsbweb')
local panel_auth		= require('me_authorization')
local ProductType 		= require('me_ProductType') 
local log      			= require('log')

i18n.setup(_M)

cdata =
{
	news = _("NEWS"),
	link = _("LINK"),
	
	days = 
	{
		[0] = _("Sunday"),
		[1] = _("Monday"),
		[2] = _("Tuesday"),
		[3] = _("Wednesday"),
		[4] = _("Thursday"),
		[5] = _("Friday"),
		[6] = _("Saturday"),
	},
	
	months =
	{
		[1]  = _("January"),
		[2]  = _("February"),
		[3]  = _("March"),
		[4]  = _("April"),
		[5]  = _("May"),
		[6]  = _("June"),
		[7]  = _("July"),
		[8]  = _("August"),
		[9]  = _("September"),
		[10] = _("October"),
		[11] = _("November"),
		[12] = _("December"),
	},
}

local curNews = 1
local panelOpened = false
local needOpenPanel	= false
local lastClock
local xPos = 0

-------------------------------------------------------------------------------
--
function create(x, y, w, h)
	local form = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_news.dlg', cdata)

	panel = form.panel
	panel:setPosition(-272, y)
	xPos = -272

	e_text = panel.e_text
	t_text = panel.t_text
	OCButton = panel.OCButton

	OCButton.onChange = function(self)
		needOpenPanel = self:getState()
		Gui.EnableHighSpeedUpdate(true)
	end
	
	leftButton = panel.leftButton
	leftButton.onChange = function(self)
		if (curNews < 10) then
			curNews = curNews + 1
		end	
		showNews()
	end
	
	rightButton = panel.rightButton
	rightButton.onChange = function(self)		
		if (curNews > 1) then
			curNews = curNews - 1
		end	
		showNews()
	end
	
	linkButton = panel.linkButton	
	linkButton.onChange = function(self)
		os.open_uri(News.news[curNews].link)
	end
	
	return panel
end

-------------------------------------------------------------------------------
--
function show(visible)		
	if (ProductType.getOpt('noNews') == true) then
		panel:setVisible(false)
		return
	end
	
	panel:setVisible(visible)
	
	if visible then
		UpdateManager.add(update)	
        showNews()        
	else
		UpdateManager.delete(update)
	end
	
end

-------------------------------------------------------------------------------
--
function showNews()
	if (News == nil or News.news == nil or News.news[curNews] == nil or ProductType.getOpt('noNews') == true) then
		panel:setVisible(false)
		return
	end
	
	panel:setVisible(true)
	local tmpNews = News.news[curNews]
	t_text:setText(formatData(tmpNews.date))
	e_text:setText(tmpNews.title..'\n\n' .. tmpNews.description)
end

-------------------------------------------------------------------------------
--
function formatData(a_str)  --"21.12.2012"
	if (a_str == nil) then
		return ""
	end
	
	local firstPoint = string.find(a_str, '%.', 1) 
	local secondPoint = string.find(a_str, '%.', firstPoint+1) 
	
	local day 	= tonumber(string.sub(a_str, 1, firstPoint))
	local month = tonumber(string.sub(a_str, firstPoint+1, secondPoint))
	local year 	= tonumber(string.sub(a_str, secondPoint+1))
	
	local str 	= ""
	
    local d = math.floor((14 - month) / 12)
    local y = year - d
    local m = month + 12 * d - 2
    local res = math.fmod(7000 + (day + y + math.floor(y / 4) 
				- math.floor(y / 100) + math.floor(y / 400) 
				+ math.floor((31 * m) / 12)), 7)

	local strDay = cdata.days[res]
	local strMonth = cdata.months[month]
	
	str = strDay..", "..day.." "..strMonth.." "..year

	return str
end

-------------------------------------------------------------------------------
--
function findTags(a_text)
	local replaceTag = function (a_tag)
		local htmlTag = htmlTags[a_tag]
		
		if htmlTag then				
			return string.char(unpack(htmlTag))
		end		
		
		return false
	end
	
	return string.gsub(a_text, "&%a-%d-;", replaceTag)
end

-------------------------------------------------------------------------------
--
function updateNews()
	if panel_auth.getOfflineMode() == true or ProductType.getOpt('noNews') == true then
		applyNews(nil)
		showNews()
		return
	end
    if (base.START_PARAMS and base.START_PARAMS.returnScreen and base.START_PARAMS.returnScreen == "") then      
        DcsWeb.send_request('dcs:news')        
    end
    
    panel_waitDsbweb.startWait(verifyUpdateNews, end_updateNews)  	
end

-------------------------------------------------------------------------------
--
function updateOfflineMode(a_offlineMode)
	if a_offlineMode == true then
		linkButton:setVisible(false)
	else
		linkButton:setVisible(true)
	end	
end

-------------------------------------------------------------------------------
--
function verifyUpdateNews()
    statusNews = DcsWeb.get_status('dcs:news')
    
    if statusNews ~= 102 then                      
        return true, statusNews     
    end
    return false
end

-------------------------------------------------------------------------------
--
function end_updateNews()
    local news_status
    local news_data = ''
    
    news_data = DcsWeb.get_data('dcs:news')
    
    if statusNews >= 400 then
        base.print("ERROR news DcsWeb.get_data() ",news_data)
        news_data = ''
    else  
        news_data = string.gsub(news_data, "\\\"", "\"")
        news_data = findTags(news_data)
    end

	local tmpNews = nil
	local errStr  = nil	
	
	if (news_data ~= '') then
		tmpNews, errStr = base.loadstring(news_data)
	end
	
	applyNews(tmpNews)
    showNews()
end

function applyNews(tmpNews)
	News = {}
	NewsOld = {}
	
	-- читаем старый файл
    local pathNewsOld = lfs.writedir() .. 'MissionEditor/news.lua'
    local a, err = lfs.attributes(pathNewsOld)
    if (a and a.mode == 'file')  then
        NewsOld = Tools.safeDoFile(pathNewsOld)
    end  
		
	if (not tmpNews) then
        if (base.START_PARAMS and base.START_PARAMS.returnScreen and base.START_PARAMS.returnScreen == "" 
			and panel_auth.getOfflineMode() ~= true ) then
            print("error loading news", errStr)	
        end
		News = NewsOld	 
	else		
		base.setfenv(tmpNews, News)
		tmpNews()
		
		if ((NewsOld ~= nil)  and (News ~= nil)
			and (compareNews(News, NewsOld) == false)) then
			needOpenPanel = true
			Gui.EnableHighSpeedUpdate(true)
			OCButton:setState(true)
		end	

		function saveInFile(a_table)	 
			local f, err = io.open(lfs.writedir() .. 'MissionEditor/news.lua', 'w')
			if f then
				local sr = S.new(f) 
				sr:serialize_simple2('news', a_table.news)
				f:close()
			else
				log.error('ERROR: save news failed: '..err)	
			end
		end
		
		saveInFile(News)
	end

end

-------------------------------------------------------------------------------
--
function compareNews(a_News, a_NewsOld)
	local result = true
	for k,v in pairs(a_News.news) do		
		if (a_NewsOld.news == nil) 
			or (a_NewsOld.news[k] == nil) 
			or (v.date ~= a_NewsOld.news[k].date) then
			result = false
		end
	end
	
	return result
end

-------------------------------------------------------------------------------
--
function updateAnimations(a_dtime)
	if not panelOpened and needOpenPanel then
		-- открываем окно
		local x, y = panel:getPosition()
		local speed = 0.5 --* (1+math.abs(math.abs(xPos)-150)/50)

		xPos = xPos + speed * a_dtime
		
		if (xPos > 0) then
			xPos = 0
			panelOpened = true
			Gui.EnableHighSpeedUpdate(false)
		end	
		
		panel:setPosition(xPos, y)
	end
	
	if panelOpened and not needOpenPanel then
		-- закрываем окно
		local x, y = panel:getPosition()
		local speed = 0.5 --* (1+math.abs(math.abs(xPos)-150)/50)

		xPos = xPos - speed * a_dtime
		
		if (xPos < -272) then
			xPos = -272
			panelOpened = false
			Gui.EnableHighSpeedUpdate(false)
		end	
		
		panel:setPosition(xPos, y)
	end
end

function update()
    local realClock = os.clock() * 1000
	
	if lastClock then
		updateAnimations(realClock - lastClock)
	end
	
	lastClock = realClock
end

htmlTags = Tools.safeDoFile("./MissionEditor/modules/noLoc/htmlTags.lua").htmlTags
