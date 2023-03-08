local DialogLoader	= require('DialogLoader')
local Static		= require('Static')
local i18n			= require('i18n')
local gettext		= require('i_18n')
local U				= require('me_utilities')

local _ = i18n.ptranslate

local window_
local staticSkin_
local staticMourningSkin_
local winX_,winY_,winW_,winH_


local function translate(text)
	return gettext.dtranslate('about', text)
end

local show
local function create_()   
	local localization = {
		credits = _('CREDITS'),
	}
	
	window_ = DialogLoader.spawnDialogFromFile("./MissionEditor/modules/dialogs/me_about_modules.dlg", localization)

	pBox = window_.pBox
	bClose = pBox.bClose
	sTitle = pBox.pCenter.sTitle
	
	window_:setBounds(winX_,winY_,winW_,winH_)
	local wB,hB = pBox:getSize()
	pBox:setPosition((winW_-wB)/2, (winH_-hB)/2)
	
	staticSkin_			= window_.pNoVisible.staticSkin:getSkin()
	staticMourningSkin_	= window_.pNoVisible.staticMourningSkin:getSkin()
	
	window_:addHotKeyCallback('escape', onChange_bClose)
	
	bClose.onChange = onChange_bClose
end

function onChange_bClose()
	show(false)
end

local function create(x,y,w,h)
	winX_,winY_,winW_,winH_ = x,y,w,h
end

-- объявлено ранее
show = function(visible, path, title)
	if visible and path then
		if not window_ then
			create_()
		end
		
		sTitle:setText(title)
		U.fillScrollPaneCredits(path, pBox.pCenter.scrollPaneCredits, translate, staticSkin_, staticMourningSkin_)
		window_:setVisible(true)
	else
		if window_ then
			window_:setVisible(false)
		end
	end
end

return {
	create	= create,
	show	= show,
}
