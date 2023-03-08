local Gui		   = require('dxgui')
local DialogLoader  = require('DialogLoader')
local i18n		  = require('i18n')
local UpdateManager = require('UpdateManager')
local SkinUtils  	= require('SkinUtils')

local _ = i18n.ptranslate

local timeAnimation_
local startAnimationTime_
local window_
local listWaits = {}

local function create(x, y, w, h)
	local localization = {
		waitData	= _('loading...'),
		loading		= _('loading...'),
	}
	
	window_ = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_waitDsbweb_screen.dlg", localization)

	window_:setBounds(x, y, w, h)
  
	local staticLoading = window_.staticLoading
	local staticLoadingWidth, staticLoadingHeight = staticLoading:getSize()
  
	staticLoading:setPosition((w - staticLoadingWidth) / 2, h / 2 + 250)
	
	sImage = window_.sImage
	
	local sImageWidth, sImageHeight = sImage:getSize()	
	
	sImage:setPosition((w - sImageWidth) / 2, (h - sImageHeight)/ 2)
	
	sImageSkin = sImage:getSkin()
  
	window_.staticInfo:setVisible(false)  
end

function show(b)
	if window_ then
		window_:setVisible(b)
	end
end

local function setUpdateFunction(func)
	window_:setVisible(true)

	UpdateManager.add(function()
		func()			
		window_:setVisible(false)
		-- удаляем себя из UpdateManager
		return true
	end)
end

function startWait(a_funVerifyStatus, a_funCallBack)
	table.insert(listWaits, {
			funVerifyStatus = a_funVerifyStatus,
			funCallBack = a_funCallBack,
	})
	
	startAnimationTime_ = os.clock()
	timeAnimation_ = 1
	
	-- UpdateManager сам проверяет чтобы функция не добавлялась несколько раз
	UpdateManager.add(processing)
end

function processing()
	for i, itemWait in pairs(listWaits) do
		local res, status = itemWait.funVerifyStatus()
		local currentTime = os.clock()
		
		if currentTime - startAnimationTime_ > 0.25 then
			timeAnimation_ = timeAnimation_ + 1 
			startAnimationTime_ = currentTime
		end
		
		-- Анимация
		if timeAnimation_ > 6 then
			timeAnimation_ = 1
		end
		
		local texName = "dxgui\\skins\\skinME\\images\\Loading\\load_" .. tostring(timeAnimation_) .. ".png"
		
		sImage:setSkin(SkinUtils.setStaticPicture(texName, sImageSkin))
	  
		if res == true then
			itemWait.funCallBack(status)
			table.remove(listWaits, i) 
			
			break   
		end
	end
	
	if #listWaits == 0 then
		show(false)
		
		-- удаляем себя из UpdateManager
		return true
	end
end

return {
	create				= create,
	startWait			= startWait,
	show				= show,
	setUpdateFunction 	= setUpdateFunction,
}