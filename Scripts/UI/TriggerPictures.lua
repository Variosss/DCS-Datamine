local DialogLoader	= require('DialogLoader')
local UpdateManager	= require('UpdateManager')
local DCS			= require('DCS')
local dxgui			= require('dxgui')

local window_
local staticPicture_
local skin_
local picture_
local pictures_	= {}
local pool_		= {}
local pictureMaxWidth_
local pictureMaxHeight_

local function create()
	window_				= DialogLoader.spawnDialogFromFile('./Scripts/UI/TriggerPictures.dlg')
	staticPicture_		= DialogLoader.findWidgetByName(window_, "staticPicture")
	skin_				= staticPicture_:getSkin() 
	skinPicture_		= skin_.skinData.states.released[1].picture
	skinPicture_.size	= { 
		horz = 0, 
		vert = 0,
	}
	
	window_:removeWidget(staticPicture_)	
	
	window_:setSize(dxgui.GetScreenSize())
	
	local vx, vy, vw, vh = window_:getViewBounds()
	local border = 20 -- pixels
	
	pictureMaxWidth_	= vw - border * 2
	pictureMaxHeight_	= vh - border * 2
	
	staticPicture_:setSize(pictureMaxWidth_, pictureMaxHeight_)
	staticPicture_:setPosition(border, border)	
end

local function getWidgetFromPool()
	if #pool_ > 0 then
		return table.remove(pool_)
	else
		return staticPicture_:clone()
	end
end

local function putWidgetToPool(widget)	
	table.insert(pool_, widget)
end

local function clear()
	if window_ then
		while #pictures_ > 0 do 
			local picture = table.remove(pictures_)
			
			putWidgetToPool(picture.widget)
		end
	
		window_:removeAllWidgets()
	end
end

local function update()
	local currTime = DCS.getModelTime()
	local count = #pictures_
	local appearTime = 0.3
	
	for i = count, 1, -1 do
		local picture = pictures_[i]
		
		if currTime - picture.start < appearTime then
			picture.widget:setOpacity((currTime - picture.start) / appearTime)
		else
			picture.widget:setOpacity(1)
		end
	
		-- если время показа картинки 0,
		-- то показываем до вызова clear() DCSCORE-2754
		if picture.duration > 0 then 
			if currTime - picture.start > picture.duration then		
				window_:removeWidget(picture.widget)
				
				putWidgetToPool(picture.widget)
				table.remove(pictures_, i)
			end
		end
	end
	
	if #pictures_ == 0 then
		window_:setVisible(false)
		
		return true -- UpdateManager сам удалит эту функцию если картинок больше нет
	end	
end

local alignments = {
	'min'	,
	'middle',
	'max'	,
}

local function getAlignment(alignment)
	return alignments[alignment + 1] or alignments[2]
end

local function show(filename, duration, clearview, horzAlign, vertAlign, size, sizeUnits)
	if not window_ then 
		create()
	end

	if clearview then
		clear()
		window_:setVisible(false)
	end
	
	if filename ~= '' then
		local w, h = dxgui.GetTextureSize(filename)
		
		if w then
			-- растягиваем картинку на весь экран
			local coeff = math.min(pictureMaxWidth_ / w, pictureMaxHeight_ / h)
			
			if horzAlign then
				if size > 0 then
					if sizeUnits == 0 then 
						-- percent of original size
						coeff = size / 100
					else 
						-- percent of window size
						coeff = math.min((pictureMaxWidth_ * size / 100) / w, (pictureMaxHeight_ * size / 100) / h)
					end
				end
				
				skinPicture_.horzAlign.type = getAlignment(horzAlign)
				skinPicture_.vertAlign.type = getAlignment(vertAlign)				
			end
		
			skinPicture_.size.horz	= coeff * w
			skinPicture_.size.vert	= coeff * h
			skinPicture_.file		= filename

			local widget = getWidgetFromPool()

			widget:setSkin(skin_)
			widget:setOpacity(0)
			
			window_:insertWidget(widget)
			
			table.insert(pictures_, {	widget		= widget,
										duration	= duration,
										filename	= filename,
										start		= DCS.getModelTime(),		
									})
									
			UpdateManager.add(update)
			window_:setVisible(true)
		end
	end
end

return {
	show = show,
	clear = clear,
}