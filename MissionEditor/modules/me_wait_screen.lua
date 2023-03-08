-- Из-за того, что рисование GUI сейчас вызывается в середине рисования симулятора,
-- то нет возможности сразу отобразить на экране окно после вызова window_:setVisible(true).
-- Окно появится только на следующем кадре.
-- Чтобы реализовать функциональность окна ожидания, в UpdateManager добавляется функция,
-- которая будет вызвана на следующем кадре.
-- Соответственно, выход их функции setUpdateFunction() будет произведен практически немедленно.
-- Это ограничивает использование модуля me_wait_screen для тех случаев, когда код, помещенный в
-- функцию, передаваемую в UpdateManager возвращает результат, либо вызывается внутри большого блока кода.
local Gui				= require('dxgui')
local DialogLoader		= require('DialogLoader')
local UpdateManager		= require('UpdateManager')
local i18n				= require('i18n')

local _ = i18n.ptranslate

local window_
local text_

local function create()
	local cdata = {
		info		= '',
		loading		= _('loading...'),
		disclaimer	= _("Disclaimer_info"),
	}
	
	window_ = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_wait_screen.dlg", cdata)
	
	local screenWidth, screenHeight = Gui.GetScreenSize()

	window_:setBounds(0, 0, screenWidth, screenHeight)
	
	if text_ then		
		window_.staticInfo:setText(text_)
	end
end

local function setText(text)
	if window_ then
		window_.staticInfo:setText(text)
	else
		text_ = text
	end
end

function showSplash(visible, a_text, a_noVisibleLoading)
    if not window_ then
		create()
	end
	
	if a_noVisibleLoading == true then
		window_.staticLoading:setVisible(false)
	else
		window_.staticLoading:setVisible(true)
	end
	
    if a_text then
        window_.staticInfo:setText(a_text)
    else
        window_.staticInfo:setText("")
    end
	window_:setVisible(visible)
	Gui.SetWaitCursor(trvisibleue)
end

function showMini(visible, a_text)
	if not windowMini_ then
		windowMini_ = DialogLoader.spawnDialogFromFile("./Scripts/UI/DebriefingProgressDialog.dlg", localization)
		windowMini_:setSize(372, 78)
		windowMini_:centerWindow()	
		windowMini_.progressBar:setRange(0, 100)
		windowMini_.progressBar:setSize(332, 20)
	end
	windowMini_.progressBar:setValue(0)
	windowMini_.sText:setText(a_text or "")
	
	windowMini_:setVisible(visible)
end

function setMiniText(a_text)
	windowMini_.sText:setText(a_text)
end

function setMiniValue(a_value)
	windowMini_.progressBar:setValue(a_value)
end

local function setUpdateFunction(func, winsplash)
	if not window_ then
		create()
	end
	
	window_:setVisible(true)
	
	if winsplash then
		 winsplash:setVisible(true)
	end

	Gui.SetWaitCursor(true)
	
	UpdateManager.add(function()
		func()
		
		if winsplash then
			 winsplash:setVisible(false)
		end
		
		window_:setVisible(false)
		
		Gui.SetWaitCursor(false)
		
		-- удаляем себя из UpdateManager
		return true
	end)
end

local function getVisible()
	if window_ then
		return window_:getVisible()
	end
	
	return false
end

return {
	setUpdateFunction	= setUpdateFunction,
	setText				= setText,
	getVisible			= getVisible,
    showSplash          = showSplash,
	showMini			= showMini,
	setMiniText			= setMiniText,
	setMiniValue		= setMiniValue,
}
