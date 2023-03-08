local base = _G

module('me_modulesOffers')

local require       = base.require
local pairs         = base.pairs
local ipairs        = base.ipairs
local table         = base.table
local math          = base.math
local loadfile      = base.loadfile
local setfenv       = base.setfenv
local string        = base.string
local assert        = base.assert
local io            = base.io
local loadstring    = base.loadstring
local print         = base.print
local os            = base.os

local reg 				= require('reg')
local DcsWeb 			= require('DcsWeb')
local i18n 				= require('i18n')
local Window 			= require('Window')
local Static			= require('Static')
local Skin				= require('Skin')
local Button			= require('Button')
local TabGroupItem		= require('TabGroupItem')
local Panel 			= require('Panel')
local ScrollPane 		= require('ScrollPane')
local Picture  			= require('Picture')
local Tools 			= require('tools')
local lfs 				= require('lfs')
local Gui 				= require('dxgui')
local S 				= require('Serializer')
local ToggleButton		= require('ToggleButton')
local U                 = require('me_utilities')
local MsgWindow         = require('MsgWindow')
local panel_auth        = require('me_authorization')
local mod_updater       = require('me_updater')
local DialogLoader      = require('DialogLoader')
local CheckBox			= require('CheckBox')
local ComboList         = require('ComboList')
local panel_waitDsbweb  = require('me_waitDsbweb')
local mmw               = require('MainMenu')
local modulesInfo       = require('me_modulesInfo')
local Align 			= require('Align')
local Analytics			= require("Analytics")
local log      			= require('log')
local ProductType 		= require('me_ProductType') 


i18n.setup(_M)

cdata = 
{
	endOfTrial 		= _("Special Offer"),
	receive			= _("Discounts available"),
	instruction		= _("Tick the modules you would like to purchase and proceed to checkout.\nA special discount will be applied to each module."),
	Procceed		= _("Procceed"),
	NumberM			= _("Number of selected modules:"),	
	ProcceedText	= _("Procceed to add selected products to e-shop cart and securely checkout."),
	close			= _('CLOSE'),
	cancel 			= _('CANCEL'),
	question		= _('Special Offer'),
	questionText	= _('Warning! You are about to close a special offer.'),
}

local showOffersEnable	= false
local selectedProducts = {}


function create()
    wWin, hWin = Gui.GetWindowSize()
	window = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_modulesOffers.dlg', cdata)
	window:setBounds(0, 0, wWin, hWin)
	
	spPanel = window.containerMain.middlePanel.spPanel
	spPanel:setVertScrollBarStep(15)
	
	panelNoVisible = window.panelNoVisible
	pContainerMain = window.containerMain
	eDesc = panelNoVisible.eDesc
	bCloseTop = pContainerMain.headPanel.bCloseTop
	bProcceed = pContainerMain.footerPanel.bProcceed
	sNumberM = pContainerMain.footerPanel.sNumberM
	
	pModulsSkin = panelNoVisible.pModuls:getSkin()
	sImageSkin = panelNoVisible.sImage:getSkin()
	sHeaderModSkin = panelNoVisible.sHeaderMod:getSkin()
	sPriceSkin = panelNoVisible.sPrice:getSkin()
	sOldPriceSkin = panelNoVisible.sOldPrice:getSkin()
	cbEnableSkin = panelNoVisible.cbEnable:getSkin()
	
	bCloseTop.onChange = onChange_Close
	bProcceed.onChange = onChange_Procceed
	
	pContainerMain:setBounds((wWin - 1280)/2,(hWin - 768)/2, 1280, 768)
	sNumberM:setText(cdata.NumberM.." 0")
end

function show(b)	
	if b and (showOffersEnable == true or (ProductType.getType() == "STEAM") or (base.__PRODUCT_ID__ == 2) or (base.openMainMenu ~= true) ) then		
		return
	end

	if window == nil then
		create()
	end	

	ModulesNew = modulesInfo.getModulesNew()
	
	if b then
		if ModulesNew.DLC and ModulesNew.DLC.offers then 
			showOffersEnable = true
			selectedProducts = {}

			refreshPanels()
			window:setVisible(true)
		else
			--window:setVisible(true) -- TEST
			--showOffersEnable = true -- TEST
			window:setVisible(false)
		end	
	else	
		window:setVisible(false)
	end	

end
	
-------------------------------------------------------------------------------
-- 
function createPanelMod(x,y,w,h, a_data, a_parent, a_type)
	pModPanel = Panel.new()
	pModPanel:setBounds(x,y,w,h)
	pModPanel:setSkin(pModulsSkin)
	a_parent:insertWidget(pModPanel)
	
	sImage = Static.new()
	sImage:setSkin(sImageSkin)	
	pModPanel:insertWidget(sImage)
	local skin = sImage:getSkin()
	
	local a = nil
	if (a_data.imageLocal) then	
		a = lfs.attributes(a_data.imageLocal,'mode')
	end

	if a then
		skin.skinData.states.released[1].picture = Picture.new(a_data.imageLocal, nil, Align.new(Align.left),Align.new(Align.top))
	else

        skin.skinData.states.released[1].picture = Picture.new("./dxgui/skins/skinME/images/Unknown.png", nil, Align.new(Align.left),Align.new(Align.top))
	end
	sImage:setSkin(skin)
	sImage:setBounds(17, 73,110,150)
	
	sHeader = Static.new()
	sHeader:setSkin(sHeaderModSkin)
	sHeader:setWrapping(true)
	sHeader:setText(a_data.title)	
	pModPanel:insertWidget(sHeader)
	sHeader:setBounds(17,h*0.1,500,60)
	
	sText = eDesc:clone()
	sText:setText(a_data.preview)	
	pModPanel:insertWidget(sText) 		
--	sText:setSkin(sDescSkin)
--	sText:setWrapping(true)	
	
	sText:setBounds(131,h*0.1+33,w-200, 200)		


    sOldPrice = Static.new()	
	sOldPrice:setSkin(sOldPriceSkin)	
	pModPanel:insertWidget(sOldPrice)
	
	sPrice = Static.new()
	sPrice:setSkin(sPriceSkin)
	pModPanel:insertWidget(sPrice)
    
    if (a_data.dprice) and (a_data.dprice ~= "") then
        sOldPrice:setText(a_data.price)
        sPrice:setText(a_data.dprice)        
    else
        sPrice:setText(a_data.price)
    end
	
	local wPrice,nh = sPrice:calcSize()
	local wOldPrice,nh = sOldPrice:calcSize()
	
	sOldPrice:setBounds(w-150-wPrice-wOldPrice - 40,300,wOldPrice,30)
	sPrice:setBounds(w-150-wPrice-20,300,wPrice,30) 
	
	cbEnable = CheckBox.new()
	cbEnable:setSkin(cbEnableSkin)
	pModPanel:insertWidget(cbEnable)
	cbEnable:setBounds(w - 40,300,30,30)
	cbEnable.id = a_data.id
	cbEnable.onChange = onChange_cbEnable
end

function onChange_cbEnable(self)
	if self.id then
		if self:getState() == true then
			selectedProducts[self.id] = true
		else
			selectedProducts[self.id] = nil
		end
		
		local num = 0
		for k,v in base.pairs(selectedProducts) do
			num = num + 1
		end
		
		sNumberM:setText(cdata.NumberM.." "..base.tostring(num))
	end	
end

function onChange_Procceed()
	local tmpUrl = "https://www.digitalcombatsimulator.com/"..i18n.getLocale().."/shop/?ACTION=OFFER_BUY&"--.."ID[]=".."1408498".."&ID[]=".."1408499"
	for id, v in base.pairs(selectedProducts) do
		tmpUrl = tmpUrl.."&ID[]="..id
	end
	local url = DcsWeb.make_auth_url(tmpUrl)
	base.print("--onChange_Procceed--",url)
	os.open_uri(url)
	window:setVisible(false)
end

function onChange_Close()
	local handler = MsgWindow.error(cdata.questionText, cdata.question, cdata.close, cdata.cancel)
	local result = false
	function handler:onChange(buttonText)
		-- если не нажата кнопка close, то окно не закроется
		if buttonText == cdata.close then
			window:setVisible(false)
			 base.print("--dcs:shop:offer_cancel--")
			DcsWeb.send_request('dcs:shop:offer_cancel')
		else
			window:setVisible(true)
		end
		result = true
	end
	
	handler:show() 
	if not result then
		window:setVisible(true)
	end
end

function refreshPanels()		
	spPanel:removeAllWidgets()
	
	local num = 0
	 
	if ModulesNew.DLC and ModulesNew.DLC.offers then
		for k,v in ipairs(ModulesNew.DLC.offers) do	
			createPanelMod(0, 350*num, 1240, 350, v, spPanel)
			num = num + 1
		end
	end
end	
	
	