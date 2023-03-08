local DialogLoader		= require('DialogLoader')
local TabGroupItem		= require('TabGroupItem')
local ColorTextStatic	= require('ColorTextStatic')
local Align				= require('Align')
local Picture			= require('Picture')
local Gui               = require('dxgui')

local window_
local staticPageNumber_
local manualFolder_ = 'Scripts/UI/'
local manualImagesPath_
local colorTextStaticFonts_
local systemFontsPath_ = tostring(os.getenv('windir')) .. '/Fonts/'
local pages_
local pageCount_
local currentPage_
local tabScrollPane_
local tabSkin_

local function loadManualFromFile(filename)
	local pages
	local f, err = loadfile(filename)

	if f then
		pages = f()
	else
		print('----------------------------------------------------')
		print('Manual file loading error!')
		print(err)
		print('----------------------------------------------------')
	end
	
	return pages, err
end

local header1Skin
local header2Skin
local header3Skin
local textSkin
local textWarningSkin
local pictureSkin

local function getHeader1Skin()
	if not header1Skin then
		header1Skin = Skin.manualHeader1()
	end
	
	return header1Skin
end

local function getHeader2Skin()
	if not header2Skin then
		header2Skin = Skin.manualHeader2()
	end
	
	return header2Skin
end

local function getHeader3Skin()
	if not header3Skin then
		header3Skin = Skin.manualHeader3()
	end
	
	return header3Skin
end

local function getTextSkin()
	if not textSkin then
		textSkin = Skin.manualText()
	end
	
	return textSkin
end

local function getTextWarningSkin()
	if not textWarningSkin then
		textWarningSkin = Skin.manualTextBordered()
	end
	
	return textWarningSkin
end

local function getPictureSkin(filename)
	if not pictureSkin then
		pictureSkin = Skin.staticSkin()
		pictureSkin.skinData.states.released[1].picture = Picture.new()		
		pictureSkin.skinData.states.released[1].picture.horzAlign.type = Align.center
	end
	
	pictureSkin.skinData.states.released[1].picture.file = manualImagesPath_ .. filename
	
	return pictureSkin
end

local function getColorTextStaticFonts()
	if not colorTextStaticFonts_ then
		
		colorTextStaticFonts_ = {
			['sans-bold'] 						= 'DejaVuLGCSans-Bold.ttf',
			['sans-bold-italic'] 				= 'DejaVuLGCSans-BoldOblique.ttf',
			['sans-light'] 						= 'DejaVuLGCSans-ExtraLight.ttf',
			['sans-italic'] 					= 'DejaVuLGCSans-Oblique.ttf',
			['sans'] 							= 'DejaVuLGCSans.ttf',
			['sans-condensed-bold'] 			= 'DejaVuLGCSansCondensed-Bold.ttf',
			['sans-condensed-bold-italic'] 		= 'DejaVuLGCSansCondensed-BoldOblique.ttf',
			['sans-condensed-italic'] 			= 'DejaVuLGCSansCondensed-Oblique.ttf',
			['sans-condensed'] 					= 'DejaVuLGCSansCondensed.ttf',
			['mono-bold'] 						= 'DejaVuLGCSansMono-Bold.ttf',
			['mono-bold-italic'] 				= 'DejaVuLGCSansMono-BoldOblique.ttf',
			['mono-italic'] 					= 'DejaVuLGCSansMono-Oblique.ttf',
			['mono'] 							= 'DejaVuLGCSansMono.ttf',
			['serif-bold'] 						= 'DejaVuLGCSerif-Bold.ttf',
			['serif-bold-italic'] 				= 'DejaVuLGCSerif-BoldItalic.ttf',
			['serif-italic'] 					= 'DejaVuLGCSerif-Italic.ttf',
			['serif'] 							= 'DejaVuLGCSerif.ttf',
			['serif-condensed-bold'] 			= 'DejaVuLGCSerifCondensed-Bold.ttf',
			['serif-condensed-bold-italic'] 	= 'DejaVuLGCSerifCondensed-BoldItalic.ttf',
			['serif-condensed-italic'] 			= 'DejaVuLGCSerifCondensed-Italic.ttf',
			['serif-condensed'] 				= 'DejaVuLGCSerifCondensed.ttf',
			['arial']							= 'arial.ttf',
			['arial-bold-italic']				= 'arialbi.ttf',
			['arial-italic']					= 'ariali.ttf',
			['arial-bold']						= 'arialbd.ttf',
		}
	
	end
	
	return colorTextStaticFonts_
end

local function getStaticFonts(skin)
	local fonts = getColorTextStaticFonts()
	local skinFontFilename = string.lower(skin.skinData.states.released[1].text.font)
	
	for name, path in pairs(fonts) do
		local fontFilename = string.lower(path)
		if skinFontFilename == fontFilename then
			local fontName = string.match(name, '(.*)[-]?') -- находим текст до первого знака '-'
			
			fonts['default'] = path
			fonts['default-bold'] = fonts[fontName .. '-bold']
			fonts['default-italic'] = fonts[fontName .. '-italic']
			fonts['default-bold-italic'] = fonts[fontName .. '-bold-italic']
			
			break
		end
	end
	
	return fonts
end

local function createStatic(text, width, skin)
	local result = ColorTextStatic.new()
	
	result:setFonts(getStaticFonts(skin))
	result:setSkin(skin)
	result:setSize(width, 0)
	result:setText(text)
	
	local w, h = result:calcSize()

	result:setSize(width, h)
	
	return result
end

local function createHeader1(text, width)
	return createStatic(text, width, getHeader1Skin())
end

local function createHeader2(text, width)
	return createStatic(text, width, getHeader2Skin())
end

local function createHeader3(text, width)
	return createStatic(text, width, getHeader3Skin())
end

local function createText(text, width)
	return createStatic(text, width, getTextSkin())
end

local function createWarning(text, width)
	return createStatic(text, width, getTextWarningSkin())
end

local function createPicture(filename, width)
	return createStatic(nil, width, getPictureSkin(filename))
end

local itemCreators = {
	header1 = createHeader1,
	header2 = createHeader2,
	header3 = createHeader3,
	text = createText,
	warning = createWarning,
	picture = createPicture,
}

local function fillPage(page, panel)
	panel:clear()
	
	local width, height = panel:getSize()
	local y = 0
	
	for i, item in ipairs(page) do
		local itemType = item[1]
		local creator = itemCreators[itemType]
		
		if creator then
			local itemContent = item[2]
			local widget = creator(itemContent, width)
			
			widget:setPosition(0, y)
			panel:insertWidget(widget)
			
			local w, h = widget:getSize()
			
			y = y + h
		end
	end
end

local function loadPages(filename)
	local pages, err = loadManualFromFile(filename)
	
	if not pages then
		pages = {{{'header1', [[Cannot load manual!]]}, {'text', 'Error:' .. err}}}
	end
	
	return pages
end

local function showPage(index)
	if currentPage_ ~= index then
		currentPage_ = index
		fillPage(pages_[index], window_.panelContent) 
		staticPageNumber_:setText(index)
	end
end

local function createTabItems(count)
	tabScrollPane_:clear()
	
	for i = 1, count do
		local tabItem = TabGroupItem.new(i)
		
		tabItem:setSkin(tabSkin_)
		tabItem.index = i
		
		function tabItem:onShow()
			showPage(tabItem.index)
		end
		
		tabScrollPane_:insertWidget(tabItem)
	end
	
	tabScrollPane_:updateWidgetsBounds()
end

local function makeTabVisible(tabItem)
	local horzScrollValue = tabScrollPane_:getHorzScrollValue()
	local x, y = tabItem:getPosition()
	local viewPosition = x - horzScrollValue
	
	if viewPosition < 0 then
		-- таб находится за левой границей tabScrollPane_
		tabScrollPane_:setHorzScrollValue(x)
	else
		local w, h = tabScrollPane_:getSize()
		
		if viewPosition >= w then
			-- таб находится за правой границей tabScrollPane_
			local tabWidth, tabHeight = tabItem:getSize()
			
			tabScrollPane_:setHorzScrollValue(x - w + tabWidth)
		end
	end
	
end

local function selectTab(index)
	local count = tabScrollPane_:getWidgetCount()
	
	for i = 0, count - 1 do
		local tabItem = tabScrollPane_:getWidget(i)
		
		if tabItem.index == index then
			tabItem:setState(true)
			makeTabVisible(tabItem)
			showPage(index)
			
			break
		end
	end
end

local function setPageNavigationBar(filename)	
	pages_			= loadPages(filename)
	pageCount_		= #pages_
	
	createTabItems(pageCount_)
	staticPageNumber_:setText(currentPage_)
	
	function window_.buttonNext:onChange()
		if currentPage_ < pageCount_ then
			selectTab(currentPage_ + 1)
		else
			selectTab(currentPage_)	
		end
	end
	
	function window_.buttonPrev:onChange()
		if currentPage_ > 1 then
			selectTab(currentPage_ - 1)
		else
			selectTab(currentPage_)	
		end
	end
	
	function window_.buttonFirst:onChange()
		selectTab(1)
	end
	
	function window_.buttonLast:onChange()
		selectTab(pageCount_)
	end

	selectTab(1)
end

local function hide()
	if window_ then
		window_:setVisible(false)		
	end	
end

local function create()
	window_ = DialogLoader.spawnDialogFromFile(manualFolder_ .. 'ManualDialog.dlg')
	
	window_:centerWindow()	
	
	staticPageNumber_		= window_.staticPageNumber
	tabScrollPane_			= window_.tabScrollPane
	tabSkin_				= window_.tabGroupItem:getSkin()
	
	-- staticPageNumber_:setPosition(734,h-25)
	
	function window_.buttonClose:onChange()
		window_:close()
	end
	
	function window_:onClose()
		hide()
        DCS.setPause(false) 
	end
end

local function show(folder)
	if not window_ then
		 create()
	end
	
	filename_ = folder .. '/manual.txt.lua'
	manualImagesPath_ = folder .. '/images/'
	setPageNavigationBar(folder .. '/manual.txt.lua')
	window_:setVisible(true)
end

local function getVisible()
	return window_:getVisible()
end

local function kill()
	if window_ then
		window_:setVisible(false)
		window_:kill()
		window_ = nil
	end
end

return {
	show		= show,
	hide		= hide,
	getVisible	= getVisible,
	kill		= kill,
}