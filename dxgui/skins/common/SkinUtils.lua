local Skin		= require('Skin')
local Picture	= require('Picture')
local Bkg		= require('Bkg')
local Rect		= require('Rect')
local Text		= require('Text')
local dxgui		= require('dxgui')

local function setListBoxItemTextColor(textColor, skin)
	skin = skin or Skin.listBoxItemSkin()

	local states = skin.skinData.states
	local released = states.released
	
	released[1].text.color = textColor
	released[2].text.color = textColor
	
	local hover = states.hover
	
	hover[1].text.color = textColor
	
	local hoverSelected = hover[2]
	
	if hoverSelected then
		local text = hoverSelected.text
		
		if text then
			text.color = textColor
		end
	end
	
	return skin
end

local function setListBoxItemPicture(filename, skin)
	skin = skin or Skin.listBoxItemSkin()
	
	local states = skin.skinData.states
	local released = states.released
	
	released[1].picture.file = filename
	released[2].picture.file = filename
   
	local hover = states.hover
	
	if hover[1].picture then
		hover[1].picture.file = filename
	end	   
	
	if hover[2].picture then
		hover[2].picture.file = filename
	end	 
	
	return skin
end

local function setStaticPicture(filename, skin, color)
	skin = skin or Skin.staticSkin()
	
	local releasedState = skin.skinData.states.released[1]
	
	releasedState.picture = releasedState.picture or Picture.new()
	releasedState.picture.file = filename
	
	if color then 
		releasedState.picture.color = color
	end
	
	return skin
end

local function getStaticPictureFilename(skin)
	local releasedState = skin.skinData.states.released[1]
	
	if releasedState.picture then
		return releasedState.picture.file
	end
end

local function setStaticPictureRect(filename, x1, y1, x2, y2, skin)
	skin = skin or Skin.staticSkin()
	
	local releasedState = skin.skinData.states.released[1]
	
	releasedState.picture = releasedState.picture or Picture.new()
	releasedState.picture.file = filename
	releasedState.picture.rect = Rect.new(x1, y1, x2, y2)
	
	return skin
end

local function setStaticColor(color, skin)
	skin = skin or Skin.staticSkin()
	
	local released = skin.skinData.states.released[1]
	
	released.bkg = released.bkg or Bkg.new()
	released.bkg.center_center = color
	
	return skin
end

local function hexColorToRGBA256(hexColor)
	-- hexColor строка в формате 0xrrggbbaa
	local r = tonumber(			string.sub(hexColor, 1, 4)	)	-- 0xrr
	local g = tonumber('0x' .. 	string.sub(hexColor, 5, 6)	)	-- 0xgg
	local b = tonumber('0x' ..	string.sub(hexColor, 7, 8)	)	-- 0xbb
	local a = tonumber('0x' ..	string.sub(hexColor, -2)	)	-- 0xaa
	
	return r, g, b, a
end

local function RGBA256ToHexColor(r, g, b, a)
	return string.format('0x%.2x%.2x%.2x%.2x', r, g, b, a)
end

local function setPictureAlpha(picture, alpha)
	if picture.color then
		local r, g, b, a = hexColorToRGBA256(picture.color)
		
		a = alpha * 255
		
		picture.color = RGBA256ToHexColor(r, g, b, a)
	end
end

local function setStaticPictureAlpha(alpha, skin)
	skin = skin or Skin.staticSkin()
	
	local released = skin.skinData.states.released[1]
	
	released.picture = released.picture or Picture.new()
	
	setPictureAlpha(released.picture, alpha)
	
	return skin
end

local function setStaticPictureSize(horz, vert, skin)
	skin = skin or Skin.staticSkin()
	
	local released = skin.skinData.states.released[1]
	
	released.picture = released.picture or Picture.new()
	released.picture.size = {}
	released.picture.size.horz = horz
	released.picture.size.vert = vert
	
	return skin
end

local function setScrollPanePicture(filename, skin,color)
	skin = skin or Skin.staticSkin()
	
	local releasedState = skin.skinData.states.released[1]
	
	releasedState.picture = releasedState.picture or Picture.new()
	releasedState.picture.file = filename
	
	if color then 
		releasedState.picture.color = color
	end
	
	return skin
end

local function setStaticTextAlpha(alpha, skin)
	skin = skin or Skin.staticSkin()
	
	local released = skin.skinData.states.released[1]
	
	released.text = released.text or Text.new()
	
	local r, g, b, a = hexColorToRGBA256(released.text.color)
	
	a = alpha * 255
	
	released.text.color = RGBA256ToHexColor(r, g, b, a)
	
	if released.text.shadowColor then
		local sr, sg, sb, sa = hexColorToRGBA256(released.text.shadowColor)
	
		if sa > a then
			sa = a
			released.text.shadowColor = RGBA256ToHexColor(sr, sg, sb, sa)
		end
	end
	
	return skin
end

local function setStaticTextColor(color, skin)
	skin = skin or Skin.staticSkin()
	
	local released = skin.skinData.states.released[1]
	
	released.text = released.text or Text.new()
	released.text.color = color
    
    return skin
end

local function getStaticTextColor(skin)
	local released = skin.skinData.states.released[1]
	
	released.text = released.text or Text.new()
	
	return released.text.color
end

local function setButtonColor(color, skin)
	skin = skin or Skin.buttonSkin()
	
	local states = skin.skinData.states
	
	states.released[1].bkg.center_center = color
	states.pressed[1].bkg.center_center = color
	
	return skin
end

local function setButtonPicture(filename, skin)
	skin = skin or Skin.buttonSkin()
	
	local states = skin.skinData.states
	local releasedState	= states.released[1]
	local pressedSate	= states.pressed[1]
	
	releasedState.picture		= releasedState.picture or Picture.new()
	releasedState.picture.file	= filename
	
	if states.hover then
		local hoverState	= states.hover[1]
	
		hoverState.picture			= hoverState.picture or Picture.new()
		hoverState.picture.file		= filename
	end
	
	pressedSate.picture			= pressedSate.picture or Picture.new()
	pressedSate.picture.file	= filename	

	return skin
end

local function setMenuItemPicture(filename, color, skin)
	skin = skin or Skin.menuItemSkin()
	
	local states = skin.skinData.states
	local picture = states.released[1].picture
	
	picture.file = filename
	picture.color = color
	
	picture = states.released[2].picture
	
	if picture then
		picture.file = filename
		picture.color = color
	end
	
	return skin
end

local function getSkinVertScrollBarWidth(skin)
	local result = 0
	
	if skin then
		local skinData = skin.skinData
		
		result = skinData.params.vertScrollBarWidth or 0
		
		local skins = skinData.skins
		
		if skins then
			local vertScrollBarSkin = skins.vertScrollBar
			
			if vertScrollBarSkin then
				local vertScrollBarSkinParams = vertScrollBarSkin.params
				
				if vertScrollBarSkinParams then
					local minSize = vertScrollBarSkinParams.minSize
					
					if minSize then
						result = math.max(result, minSize.horz)
					end
					
					local maxSize = vertScrollBarSkinParams.maxSize
					
					if maxSize then
						result = math.min(result, maxSize.horz)
					end					   
				end
			end
		end
	end
	
	return result
end

local function setWindowPicture(filename, skin)
	skin = skin or Skin.windowSkin()
	
	local releasedState = skin.skinData.states.released[1]
	
	releasedState.picture = releasedState.picture or Picture.new()
	
	releasedState.picture.file = filename
	
	return skin
end

local function setWindowPictureAlpha(alpha, skin)
	skin = skin or Skin.windowSkin()
	
	local released = skin.skinData.states.released[1]
	
	released.picture = released.picture or Picture.new()
	
	setPictureAlpha(released.picture, alpha)
	
	return skin
end

local function setWindowHeaderHeight(skin, headerHeight)
	skin = skin or Skin.windowSkin()
	
	skin.skinData.params.headerHeight = headerHeight
	
	return skin
end

local function getWindowHeaderHeight(skin)
	skin = skin or Skin.windowSkin()
	
	return skin.skinData.params.headerHeight
end

local function setWindowBkgColor(skin, color)
	skin = skin or Skin.windowSkin()
	
	local released = skin.skinData.states.released[1]
	
	released.bkg = released.bkg or Bkg.new()
	released.bkg.center_center = color
	
	return skin
end

local function getWindowBkgColor(skin)
	skin = skin or Skin.windowSkin()
	
	local released = skin.skinData.states.released[1]
	
	released.bkg = released.bkg or Bkg.new()
	
	return released.bkg.center_center
end

return {
	setListBoxItemTextColor		= setListBoxItemTextColor,
	setListBoxItemPicture		= setListBoxItemPicture,
	setStaticPicture			= setStaticPicture,
	getStaticPictureFilename	= getStaticPictureFilename,
	setStaticPictureRect		= setStaticPictureRect,
	setStaticColor				= setStaticColor,
    setStaticPictureAlpha       = setStaticPictureAlpha,
	setStaticTextAlpha			= setStaticTextAlpha,
	getStaticTextColor			= getStaticTextColor,
    setStaticTextColor          = setStaticTextColor,
	setButtonColor				= setButtonColor,
	setButtonPicture			= setButtonPicture,
	setMenuItemPicture			= setMenuItemPicture,
	getSkinVertScrollBarWidth	= getSkinVertScrollBarWidth,
	setWindowPicture			= setWindowPicture,
	setWindowHeaderHeight		= setWindowHeaderHeight,
	getWindowHeaderHeight		= getWindowHeaderHeight,
	setWindowBkgColor			= setWindowBkgColor,
	getWindowBkgColor			= getWindowBkgColor,
    setScrollPanePicture        = setScrollPanePicture,
    setWindowPictureAlpha       = setWindowPictureAlpha,
	setStaticPictureSize		= setStaticPictureSize,
	hexColorToRGBA256			= hexColorToRGBA256,
	RGBA256ToHexColor			= RGBA256ToHexColor,
}