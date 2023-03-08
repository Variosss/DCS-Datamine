local DialogLoader	= require('DialogLoader')
local Static		= require('Static')
local i18n			= require('i18n')
local gettext		= require('i_18n')
local U				= require('me_utilities')
local ProductType	= require('me_ProductType') 

local _ = i18n.ptranslate

local initialBounds_
local window_
local staticSkin_
local staticMourningSkin_

local function resizeScrollPaneCredits_(scrollPane)
	local x, y, w, h = scrollPane:getBounds()
	local windowWidth, windowHeight = window_:getSize()
	local bottomOffset = 26
	local Height = windowHeight - (y + bottomOffset)

	scrollPane:setSize(w, Height)
end

local function translate(text)
	return gettext.dtranslate('about', text)
end


local show
local function create_()   
	local localization = {
		about = _('DIGITAL COMBAT SIMULATOR'),
		general = _('GENERAL DATA'),
		credits = _('CREDITS'),
	}
	
	window_ = DialogLoader.spawnDialogFromFile("./MissionEditor/modules/dialogs/me_about_panel.dlg", localization)
	
	if initialBounds_ then
		window_:setBounds(unpack(initialBounds_))
	end	

	resizeScrollPaneCredits_(window_.scrollPaneCredits)
	
	local folder = './MissionEditor/data/text/'

	if ProductType.getType() == "LOFAC" then
		folder = folder .. 'lofac/'
	end
	
	staticSkin_			= window_.staticSkin:getSkin()
	staticMourningSkin_	= window_.staticMourningSkin:getSkin()
	
	U.fillScrollPaneCredits(folder .. 'AboutGeneral.txt', window_.scrollPaneGeneral, translate, staticSkin_, staticMourningSkin_)
	U.fillScrollPaneCredits(folder .. 'AboutCredits.txt', window_.scrollPaneCredits, translate, staticSkin_, staticMourningSkin_)
	

	function window_:onClose()
		show(false)
	end
end

local function create(...)
	initialBounds_ = {...}
end

-- объявлено ранее
show = function(visible)
	if visible then
		if not window_ then
			create_()
		end
		
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
