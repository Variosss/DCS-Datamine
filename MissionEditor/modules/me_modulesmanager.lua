local base = _G

module('me_modulesmanager')

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
local UpdateManager 	= require('UpdateManager')
local textutil 			= require('textutil')
local ListBoxItem		= require('ListBoxItem')
local DB 				= require('me_db_api')


i18n.setup(_M)

cdata = 
{
	modulesmanager 	        = _("Module manager"),
	--close			        = _("CLOSE"),
	tSO				        = _("Special offers"),
	tBU				        = _("Bundles"),
	tAA				        = _("Modules"),
    tSAMods                 = _("Modules"),
	tSA				        = _("Installed"),
    tAD				        = _("Available DLC"),
    tADCamp                 = _("Campaigns"),    
    tSACamp                 = _("Campaigns"),
    tADTerr                 = _("Terrains"),
    tSATerr                 = _("Terrains"),
    needRestart             = _("The game needs to be restarted for these changes to take effect. Do you want to restart now?"),
    needDelete              = _("Are you sure you want to remove the module"),
    DELETE                  = _("DELETE"),
	CANCEL					= _("CANCEL"),
    yes                     = _('YES'),
    no                      = _('NO'),
    restart                 = _('RESTART'),
    applyChangesCap         = _("APPLY CHANGES"),
    applyChanges            = _("Apply changes? (Need restart the game)"),
    login                   = _('Log In'),
    logout                  = _('Log Out'),
    more                    = _("More..."),
    buy                     = _("Buy"),
    back                    = _("Back..."),
    install                 = _("Install"),
    serial_number           = _("Serial number"),
    sf_tooltip              = _("Activation/Deactivation"),
    logout_tooltip          = _("Log out from digitalcombatsimulator.com"),
    login_tooltip           = _("Log in to digitalcombatsimulator.com"),
    more_tooltip            = _("Display more information"),
    buy_tooltip             = _("Buy module"),
    back_tooltip            = _("Go back"),
    install_tooltip         = _("Install module"),
    modul_btn_onoff_tooltip = _("Enable/Disable module"),
    serial_number_tooltip   = _("Show serial number"),
    copy_tooltip            = _("Copy serial number to clipboard"),
    hide_tooltip            = _("Hide serial number"),
    remove_tooltip          = _("Remove module"),
    Refresh                 = _("Refresh"),
    update_tooltip          = _("Refresh modules"),
	DeleteSelected			= _("Delete selected"),
	DeleteSelected_tooltip  = _("Delete selected modules"),
    warningLogin            = _("Not logged in - module installation is not available!"),
    choose_to_install       = _("Choose to install"),
    installModsList         = _("Now you can install modules:"),
    cancel                  = _("Cancel"),
    ok                      = _("Ok"),
    InstallMods             = _("Install Modules"),
    ErrorInDataMessage      = _("FAILED TO RETRIEVE DATA"),
    ErrorInData             = _("An error occurred while receiving data, try later."),
    tWarning                = _("This DLC requires the following modules to be installed:"),
	Clear					= _("Clear"),
	warning					= _('WARNING'), 
	SelectAll				= _('Select All'), 	
	JET						= _('JET ENGINE'), 	
	PISTON					= _('PISTON ENGINE'), 	
	WING					= _('ROTARY WING'), 	
	OTHER					= _('OTHER'), 
	all		 				= _("ALL"),
}

local tblCatNames = {}		
tblCatNames['Piston engine plane']	= _('A/C piston')
tblCatNames['Jet engine plane'] 	= _('A/C jet')
tblCatNames['Helicopter'] 			= _('A/C rotary wing')
tblCatNames['Tech pack'] 			= _('Tech pack')
tblCatNames['Campaign'] 			= _('Campaigns')
tblCatNames['Terrain'] 				= _('Terrains')
tblCatNames['Bundle'] 				= _('Other')

local cats = {'Jet engine plane', 'Piston engine plane', 'Helicopter', 'Terrain', 'Tech pack', 'Bundle', 'Campaign'}

local pluginsEnabledOld = {}
local pluginsEnabledNew = {}
local flagNeedMessage = true
local sizeStringModulText = 20

local buttonH = 26
local offsetTextBut = 20  -- по 10 с каждой стороны

local InfoBuyMods = {}
local appliedMod_by_updateid = {}
local installedMod_by_updateid = {}
local needInstallShow = true
local enableUpdater = false
local selectedForDelete = {}
local modDisplayNameByUpdateId = {}

local developerLink = {
	["Eagle Dynamics"] = "http://www.digitalcombatsimulator.com/",
	["Belsimtek"] = "http://www.digitalcombatsimulator.com/",
	["VEAO Simulations"] = "http://veaosimulations.co.uk/",
	["AvioDev"] = "http://www.aviodev.com/",
	["Leatherneck"] = "http://leatherneck-sim.com/",
	["RAZBAM"] = "http://www.razbamsims.com/",
	["Polychop Simulations"] = "http://www.polychop-sims.com/",
	["Heatblur Simulations"] = "http://www.heatblur.com/",
	["Magnitude 3 LLC"] = "http://magnitude-3.com/",
	["Raia Software"] = "http://www.tacview.net/",
}


 
-------------------------------------------------------------------------------
-- 
function create(x, y, w, h)
    xWin, yWin, wWin, hWin = x, y, w, h
    
    widthWin = w
    heightWin = h
    
    if w > 1280 then
        w = 1280
    end

	h = h*0.8
    if h < 768 then
        h = 768
    end
    

    widthMain = w
    heightMain = h
   
    window = DialogLoader.spawnDialogFromFile('./MissionEditor/modules/dialogs/me_modulesmanager.dlg', cdata)
	window:setBounds(xWin, yWin, wWin, hWin)
	panelNoVisible = window.panelNoVisible
	
	window:addHotKeyCallback('escape', function() show(false) end)

	spPanelSkin = panelNoVisible.spPanel:getSkin()
	pModulsSkin = panelNoVisible.pModuls:getSkin()
	tgItemSkin  = panelNoVisible.tgItem:getSkin()
	spPanelGreyTopSkin = panelNoVisible.spPanelGreyTop:getSkin()
	btnBuySkin = panelNoVisible.btnBuy:getSkin()
	sPriceSkin = panelNoVisible.sPrice:getSkin()
	sOldPriceSkin = panelNoVisible.sOldPrice:getSkin()
	checkBoxPlusSkin = panelNoVisible.checkBoxPlus:getSkin()
	sImageSkin = panelNoVisible.sImage:getSkin()
	sHeaderModSkin = panelNoVisible.sHeaderMod:getSkin()
	eDesc = panelNoVisible.eDesc
	bbCloseKeySkin = panelNoVisible.bbCloseKey:getSkin()
	bbCopySkin = panelNoVisible.bbCopy:getSkin()
	bbDeleteSkin = panelNoVisible.bbDelete:getSkin()
	cbDeleteSkin = panelNoVisible.cbDelete:getSkin()
	btnSerialSkin = panelNoVisible.btnSerial:getSkin()
	clKeySkin = panelNoVisible.clKey:getSkin()
	sNameModSkin = panelNoVisible.sNameMod:getSkin()
	btnDeveloperSkin = panelNoVisible.btnDeveloper:getSkin()
	pModulsNoLineSkin = panelNoVisible.pModulsNoLine:getSkin()
	btnLinkSkin = panelNoVisible.btnLink:getSkin()
	btnLinkNoBorderSkin = panelNoVisible.btnLinkNoBorder:getSkin()
	tbCampSkin = panelNoVisible.tbCamp:getSkin()
 
    installModsPanel = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/installMods.dlg', cdata)
	installModsPanel:addHotKeyCallback('escape', function() installModsPanel:setVisible(false) end)

    if mod_updater.isEnable() then
        enableUpdater = true
    end
	
	pContainerMain = window.containerMain
	footerPanel = pContainerMain.footerPanel
	middlePanel = pContainerMain.middlePanel
	
	pContainerMain:setBounds((widthWin - widthMain)/2,(heightWin - heightMain)/2, widthMain, heightMain)
	
	footerPanel:setBounds(0,heightMain-51, 1280, 50)
	middlePanel:setSize(1280, heightMain - 90)
  
	bCloseTop = pContainerMain.headPanel.bCloseTop
	bCloseTop.onChange = function ()
		show(false)
	end
  
    bCloseBottom = pContainerMain.footerPanel.bCloseBottom --Button.new()
	bCloseBottom.onChange = function ()
		show(false)
	end
	
	bUpdate = pContainerMain.footerPanel.bUpdate
	bUpdate.onChange = refresh 
	bDeleteSelected = pContainerMain.footerPanel.bDeleteSelected
	bDeleteSelected.onChange = onDeleteSelected 
	bDeleteSelected:setEnabled(false)
	bLoginLogout = pContainerMain.middlePanel.panelTabstop.bLoginLogout
    bLoginLogout:setText(cdata.login)
    local nw,nh = bLoginLogout:calcSize()
    bLoginLogout:setText(cdata.logout)
    bLoginLogout:setTooltipText(cdata.logout_tooltip)
    local nw2,nh2 = bLoginLogout:calcSize()   
    if nw2 > nw then
        nw = nw2
    end
	nw = nw + 10
    bLoginLogout:setBounds(w-20-nw, 14, nw, 18)       
    
    bLoginLogout:setVisible(false)
    
    bLoginLogout.onChange = function(self)
        if self:getState() == false then            
            panel_auth.show(true, setAutorization) 
            bLoginLogout:setVisible(false)            
        else
            sLogin:setVisible(false)
            panel_auth.logout(setAutorization)
            sTextWarning:setVisible(true)
            refresh()
        end
        updateTextLoginLogout()    
	end
    
	sLogin = pContainerMain.middlePanel.panelTabstop.sLogin
    sLogin:setVisible(false)
	sLogin:setPosition(w-20-nw-10-340, 9)
    
    local sTestText = Static.new()	-- расчет размера строки
	sTestText:setSkin(Skin.modul_text())
    sTestText:setWrapping(true)	
	sTestText:setText("W")	
    local nw, sizeTextString = sTestText:calcSize()  
    sTestText:setText("W\nW")	
    local nw, sizeTextStringD = sTestText:calcSize()  
    sizeStringModulText = sizeTextStringD-sizeTextString
    sTestText:destroy()
	
    -- Акции
	bSO = pContainerMain.middlePanel.panelTabstop.tab_special 
	bSO.onShow = onChange_bSO
	
	-- Наборы Bundles
	bBU = pContainerMain.middlePanel.panelTabstop.tab_bundles 
	bBU.onShow = onChange_bBU
	
    -- Модули
	bAA = pContainerMain.middlePanel.panelTabstop.tab_module 
	bAA.onShow = onChange_bAA

    ---Available DLC
    bAD = pContainerMain.middlePanel.panelTabstop.tab_additions
	bAD.onShow = onChange_bAD
    
    -- Установленные
	bSA = pContainerMain.middlePanel.panelTabstop.tab_install
	bSA.onShow = onChange_bSA
    
	pPanel = Panel.new()
	pPanel:setBounds(0, 98, widthMain, heightMain-149)
	pPanel:setSkin(pModulsNoLineSkin)
	pContainerMain:insertWidget(pPanel)
    
    heightPanel1 = heightMain-149
    heightPanel2 = heightPanel1-30
	
	pPanelSO = ScrollPane.new()
	pPanelSO:setBounds(0,0,widthMain-1,heightPanel1)
	pPanelSO:setSkin(spPanelSkin)  --vertScroll_moduls
	pPanelSO:setVertScrollBarStep(15)
	pPanel:insertWidget(pPanelSO)
	
	pPanelBU = ScrollPane.new()
	pPanelBU:setBounds(0,0,widthMain-1,heightPanel1)
	pPanelBU:setSkin(spPanelSkin)  --vertScroll_moduls
	pPanelBU:setVertScrollBarStep(15)
	pPanel:insertWidget(pPanelBU)

	pPanelAA = ScrollPane.new()
	pPanelAA:setBounds(0,0,widthMain-1,heightPanel1)
	pPanelAA:setSkin(spPanelSkin)
	pPanelAA:setVertScrollBarStep(15)
	pPanel:insertWidget(pPanelAA)
	
	pPanelSA = ScrollPane.new()
	pPanelSA:setBounds(0,0,widthMain-1,heightPanel1)
	pPanelSA:setSkin(spPanelGreyTopSkin)
	pPanelSA:setVertScrollBarStep(15)
	pPanel:insertWidget(pPanelSA)
    
    -- кнопка модов в Установленные
    bSAMods = TabGroupItem.new()
    bSAMods:setSkin(tgItemSkin)
	bSAMods:setBounds(0,0,194,30)
	bSAMods:setText(cdata.tSAMods)
    pPanelSA:insertWidget(bSAMods)
    bSAMods.onShow = onChange_bSAMods
    
    -- кнопка кампаний в Установленные
    bSACamp = TabGroupItem.new()
    bSACamp:setSkin(tgItemSkin)
	bSACamp:setBounds(195,0,194,30)
	bSACamp:setText(cdata.tSACamp)
    pPanelSA:insertWidget(bSACamp)
    bSACamp.onShow = onChange_bSACamp
    pPanelSA:setVisible(false)
    
     -- кнопка terrain в Установленные
    bSATerr = TabGroupItem.new()
    bSATerr:setSkin(tgItemSkin)
	bSATerr:setBounds(390,0,194,30)
	bSATerr:setText(cdata.tSATerr)
    pPanelSA:insertWidget(bSATerr)
    bSATerr.onShow = onChange_bSATerr
    pPanelSA:setVisible(false)
 
    pPanelSAMods = ScrollPane.new()
	pPanelSAMods:setBounds(0,30,widthMain-1,heightPanel2)
	pPanelSAMods:setSkin(spPanelSkin)
	pPanelSAMods:setVertScrollBarStep(50)
	pPanelSA:insertWidget(pPanelSAMods)	
    pPanelSAMods:setVisible(false)
    
    pPanelSACamp = ScrollPane.new()
	pPanelSACamp:setBounds(0,30,widthMain-1,heightPanel2)
	pPanelSACamp:setSkin(spPanelSkin)
	pPanelSACamp:setVertScrollBarStep(50)
	pPanelSA:insertWidget(pPanelSACamp)
    pPanelSACamp:setVisible(false)
    
    pPanelSATerr = ScrollPane.new()
	pPanelSATerr:setBounds(0,30,widthMain-1,heightPanel2)
	pPanelSATerr:setSkin(spPanelSkin)
	pPanelSATerr:setVertScrollBarStep(50)
	pPanelSA:insertWidget(pPanelSATerr)
    pPanelSATerr:setVisible(false)
    
    pPanelAD = ScrollPane.new()
	pPanelAD:setBounds(0,0,widthMain-1,heightPanel1)
	pPanelAD:setSkin(spPanelGreyTopSkin)
	pPanel:insertWidget(pPanelAD)
    pPanelAD:setVisible(false)
    
    -- кнопка кампаний в Available DLC
    bADCamp = TabGroupItem.new()
    bADCamp:setSkin(tgItemSkin)
	bADCamp:setBounds(0,0,194,30)
	bADCamp:setText(cdata.tADCamp)
    pPanelAD:insertWidget(bADCamp)
    bADCamp.onShow = onChange_bADCamp
    
	--кнопки фильтра кампаний
	tbCampFilter_JET = ToggleButton.new(cdata.JET)
	tbCampFilter_JET:setBounds(330,45,110,24)
	tbCampFilter_JET:setSkin(tbCampSkin)
	tbCampFilter_JET.onChange = onChange_campFilterClass
	tbCampFilter_JET:setState(true)
	pPanelAD:insertWidget(tbCampFilter_JET)	
	
	tbCampFilter_PISTON = ToggleButton.new(cdata.PISTON)
	tbCampFilter_PISTON:setBounds(460,45,110,24)
	tbCampFilter_PISTON:setSkin(tbCampSkin)
	tbCampFilter_PISTON.onChange = onChange_campFilterClass
	tbCampFilter_PISTON:setState(true)
	pPanelAD:insertWidget(tbCampFilter_PISTON)	
	
	tbCampFilter_WING = ToggleButton.new(cdata.WING)
	tbCampFilter_WING:setBounds(590,45,110,24)
	tbCampFilter_WING:setSkin(tbCampSkin)
	tbCampFilter_WING.onChange = onChange_campFilterClass
	tbCampFilter_WING:setState(true)
	pPanelAD:insertWidget(tbCampFilter_WING)	
	
	tbCampFilter_OTHER = ToggleButton.new(cdata.OTHER)
	tbCampFilter_OTHER:setBounds(720,45,110,24)
	tbCampFilter_OTHER:setSkin(tbCampSkin)
	tbCampFilter_OTHER.onChange = onChange_campFilterClass
	tbCampFilter_OTHER:setState(true)
	pPanelAD:insertWidget(tbCampFilter_OTHER)	
	
	clCampFilter_LA = ComboList.new()
	clCampFilter_LA:setBounds(900,45,210,24)
	clCampFilter_LA:setSkin(clKeySkin)
	clCampFilter_LA.onChange = onChange_campFilter
	pPanelAD:insertWidget(clCampFilter_LA)
	----------------
	
    pPanelADCamp = ScrollPane.new()
	pPanelADCamp:setBounds(0,80,widthMain-1,heightPanel2-50)
	pPanelADCamp:setSkin(spPanelSkin)
	pPanelADCamp:setVertScrollBarStep(15)
	pPanelAD:insertWidget(pPanelADCamp)	
 --   pPanelADCamp:setVisible(false)
 
    -- кнопка terrain в Available DLC
    bADTerr = TabGroupItem.new()
    bADTerr:setSkin(tgItemSkin)
	bADTerr:setBounds(195,0,194,30)
	bADTerr:setText(cdata.tADTerr)
    pPanelAD:insertWidget(bADTerr)
    bADTerr.onShow = onChange_bADTerr
    
    pPanelADTerr = ScrollPane.new()
	pPanelADTerr:setBounds(0,30,widthMain-1,heightPanel2)
	pPanelADTerr:setSkin(spPanelSkin)
	pPanelADTerr:setVertScrollBarStep(15)
	pPanelAD:insertWidget(pPanelADTerr)
    
    sTextWarning = Static.new() 
    sTextWarning:setText(cdata.warningLogin)
    sTextWarning:setSkin(Skin.modul_textWarning())
    sTextWarning:setBounds(0, heightMain-120, widthMain, 30)
    pPanel:insertWidget(sTextWarning)
	
	pPanelMore = Panel.new()
	pPanelMore:setBounds(0, 95,widthMain,heightPanel1)
	pPanelMore:setSkin(Skin.panel_modul_more())
	window:insertWidget(pPanelMore)
	pPanelMore:setVisible(false)
	
	bBack = Button.new()
	bBack:setSkin(Skin.modul_btn_back())	
	bBack:setText(cdata.back)
    bBack:setTooltipText(cdata.back_tooltip)
	bBack:setBounds(widthMain-100, heightPanel1-30, 100, 20)
	pPanelMore:insertWidget(bBack)
	bBack.onChange = function(self)
						pPanelMore:setVisible(false)
                        setVisibleMainPanel(true)
					end
	
	sImageMore = Static.new()
	sImageMore:setSkin(Skin.staticSkin())
	sImageMore:setBounds(20,92,150,210)
	pPanelMore:insertWidget(sImageMore)
	local skin = sImageMore:getSkin()
	skin.skinData.states.released[1].picture = Picture.new("./dxgui/skins/skinME/images/Unknown.png")
	sImageMore:setSkin(skin)
	
	sHeaderMore = Static.new()
	sHeaderMore:setSkin(sHeaderModSkin)
	sHeaderMore:setWrapping(true)	
	sHeaderMore:setBounds(20,28,widthMain-260,60)
	pPanelMore:insertWidget(sHeaderMore)
	
	sTextMore = eDesc:clone()
	sTextMore:setBounds(190,87,widthMain-190, heightPanel1-117)
	pPanelMore:insertWidget(sTextMore)
	
	sOldPriceMore = Static.new()	
	sOldPriceMore:setSkin(sOldPriceSkin)
	sOldPriceMore:setBounds(50,322,90,30)
	--sOldPriceMore:setText(a_data.dprice)	
	pPanelMore:insertWidget(sOldPriceMore)
	
	sPriceMore = Static.new()
	sPriceMore:setSkin(Skin.modul_more_price1())
	sPriceMore:setBounds(50,352,90,30)
	--sPriceMore:setText(a_data.price)	
	pPanelMore:insertWidget(sPriceMore)
	
	bbBuyMore = Button.new()
	--bbBuyMore:setBounds(60,320,50,30)
	bbBuyMore:setSkin(btnBuySkin)
	bbBuyMore:setText(cdata.buy)	
    bbBuyMore:setTooltipText(cdata.buy_tooltip)
	pPanelMore:insertWidget(bbBuyMore)
	--bbBuyMore.blink = a_data.blink
	bbBuyMore.onChange = onChangeBuy
	--local nw,nh = bbBuyMore:calcSize()
    --nw = nw + offsetTextBut
	bbBuyMore:setBounds(20, 380, 150, buttonH)
    

    bbLoadMore = Button.new()
	bbLoadMore:setSkin(btnBuySkin)
	bbLoadMore:setText(cdata.install)
    bbLoadMore:setTooltipText(cdata.install_tooltip)
	bbLoadMore:setVisible(false) ---!!!!!!!!!!!!!!!!!!!!!!!
	pPanelMore:insertWidget(bbLoadMore)
 --   bbLoadMore.update_id = a_data.update_id
    bbLoadMore.onChange = onChangeLoad
    bbLoadMore:setBounds(20, 380, 150, buttonH)
    
    plugins_authorization() 
    
    if pluginsEnabledOld ~= nil then
        U.recursiveCopyTable(pluginsEnabledNew, pluginsEnabledOld)
    end
    
    fillAppliedModsByUpdateId()
    
end	

function setVisibleMainPanel(a_visible)
    bSO:setVisible(a_visible)
	bBU:setVisible(a_visible)
	bAA:setVisible(a_visible)
    bSA:setVisible(a_visible)
    bAD:setVisible(a_visible)
    pPanel:setVisible(a_visible)
end


-------------------------------------------------------------------------------
-- 
function update_clCampFilter_LA()
	clCampFilter_LA:clear()

	if (ModulesNew == nil or ModulesNew.DLC == nil) then
		return
	end
	
	local campLAbyType = {}
	local listCampLAbyLA = {}
	
	if ModulesNew.DLC.campaigns and panel_auth.getOfflineMode() ~= true then
		local tmpS = ""
		for k,v in ipairs(ModulesNew.DLC.campaigns) do		
			if (mod_updater.isInstalledComponent(v.update_id) == false) or v.have == '0' then
				if verifyFilterCampClass(v) == true then
					if v.aircraft then						
						for kk, aircraftType in base.pairs(v.aircraft) do							
							if campLAbyType[aircraftType] == nil then
								campLAbyType[aircraftType] = 1
								local name
								if aircraftType == "CA" then
									name = _("Combined Arms")
								else 
									local unitDef = DB.unit_by_type[aircraftType]
									-- if unitDef == nil then
										-- tmpS = tmpS..", "..aircraftType
									-- end
									name = (unitDef and unitDef.DisplayName) or aircraftType
								end

								base.table.insert(listCampLAbyLA, {name = name, id = aircraftType})
							end
						end	
					end	
				end	
			end
		end
	end
	
	function compareTbl(tbl1, tbl2)
		return textutil.Utf8Compare(tbl1.name, tbl2.name)	
	end

	base.table.sort(listCampLAbyLA, compareTbl)
	
	local item = ListBoxItem.new(cdata.all)
	item.id = "all"
	clCampFilter_LA:insertItem(item)
		
	for i, v in ipairs(listCampLAbyLA) do
		local item = ListBoxItem.new(v.name)
		item.id = v.id
		clCampFilter_LA:insertItem(item)
    end
	
	clCampFilter_LA:selectItem(clCampFilter_LA:getItem(0))
end

-------------------------------------------------------------------------------
-- 
function onChange_campFilter()
	updatePanelCamp()
	createPanelCamp()
end

-------------------------------------------------------------------------------
-- 
function onChange_campFilterClass()
	--обновляем список
	update_clCampFilter_LA()
	
	onChange_campFilter()
end

-------------------------------------------------------------------------------
-- 
function refresh()
    modulesInfo.loadData()	
    
    refreshPanels()
end

-------------------------------------------------------------------------------
-- 
function onDeleteSelected()
	local modIds = ""
	for k, v in base.pairs(selectedForDelete) do
		modIds = modIds..v.." "
	end
	
	local msg = _("The following modules will be deleted:").."\n"

	for k, v in base.pairs(selectedForDelete) do
		msg = msg.."- "..(modDisplayNameByUpdateId[v] or v).."\n"
	end
	
    local handler = MsgWindow.warning(msg, cdata.warning, cdata.DELETE, cdata.CANCEL)
		
	function handler:onChange(buttonText)
		if buttonText == cdata.DELETE then
			mod_updater.uninstallComponent(modIds)
		end		
	end	
	
	handler:show()  
end

-------------------------------------------------------------------------------
-- 
function refreshPanels()
	ModulesNew = modulesInfo.getModulesNew()
    --base.U.traverseTable(ModulesNew)
    updateData()	
    createPanelsInstall()
end

-------------------------------------------------------------------------------
-- 
function updateTextLoginLogout()
    if (bLoginLogout:getState() == true) then
        bLoginLogout:setText(cdata.login)
        bLoginLogout:setTooltipText(cdata.login_tooltip)
    else
        bLoginLogout:setText(cdata.logout)
        bLoginLogout:setTooltipText(cdata.logout_tooltip)
    end
end

-------------------------------------------------------------------------------
-- 
function onChange_bSO()
	pPanelSO:setVisible(true)
	pPanelBU:setVisible(false)
	pPanelAA:setVisible(false)
	pPanelSA:setVisible(false)
    pPanelAD:setVisible(false)
end

-------------------------------------------------------------------------------
-- 
function onChange_bBU()
	pPanelSO:setVisible(false)
	pPanelBU:setVisible(true)
	pPanelAA:setVisible(false)
	pPanelSA:setVisible(false)
    pPanelAD:setVisible(false)
end
-------------------------------------------------------------------------------
-- 
function onChange_bAA()
	pPanelSO:setVisible(false)
	pPanelBU:setVisible(false)
	pPanelAA:setVisible(true)
	pPanelSA:setVisible(false)
    pPanelAD:setVisible(false)
end

-------------------------------------------------------------------------------
-- 
function onChange_bSA()
	pPanelSO:setVisible(false)
	pPanelBU:setVisible(false)
	pPanelAA:setVisible(false)
	pPanelSA:setVisible(true)
    pPanelAD:setVisible(false)
    
    pPanelSAMods:setVisible(true)
    pPanelSACamp:setVisible(false)
    pPanelSATerr:setVisible(false) 
    bSAMods:setState(true)
end

-------------------------------------------------------------------------------
-- 
function onChange_bAD()
	pPanelSO:setVisible(false)
	pPanelBU:setVisible(false)
	pPanelAA:setVisible(false)
	pPanelSA:setVisible(false)
    pPanelAD:setVisible(true)
    
    pPanelADCamp:setVisible(true)
    pPanelADTerr:setVisible(false)
    bADCamp:setState(true)
	
	tbCampFilter_JET:setVisible(true)
	tbCampFilter_PISTON:setVisible(true)
	tbCampFilter_WING:setVisible(true)
	tbCampFilter_OTHER:setVisible(true)
	clCampFilter_LA:setVisible(true)
end

-------------------------------------------------------------------------------
-- переключение внутри Available DLC
function onChange_bADCamp()
    pPanelADCamp:setVisible(true)
    pPanelADTerr:setVisible(false)
	
	tbCampFilter_JET:setVisible(true)
	tbCampFilter_PISTON:setVisible(true)
	tbCampFilter_WING:setVisible(true)
	tbCampFilter_OTHER:setVisible(true)
	clCampFilter_LA:setVisible(true)
end

-------------------------------------------------------------------------------
-- переключение внутри Available DLC
function onChange_bADTerr()
    pPanelADCamp:setVisible(false)
    pPanelADTerr:setVisible(true)
	
	tbCampFilter_JET:setVisible(false)
	tbCampFilter_PISTON:setVisible(false)
	tbCampFilter_WING:setVisible(false)
	tbCampFilter_OTHER:setVisible(false)
	clCampFilter_LA:setVisible(false)
end

-------------------------------------------------------------------------------
-- переключение внутри Installed
function onChange_bSAMods()
    pPanelSAMods:setVisible(true)
    pPanelSACamp:setVisible(false)   
    pPanelSATerr:setVisible(false)     
end

-------------------------------------------------------------------------------
-- переключение внутри Installed
function onChange_bSACamp()
    pPanelSAMods:setVisible(false)
    pPanelSACamp:setVisible(true) 
    pPanelSATerr:setVisible(false) 
end

-------------------------------------------------------------------------------
-- переключение внутри Installed
function onChange_bSATerr()
    pPanelSAMods:setVisible(false)
    pPanelSACamp:setVisible(false) 
    pPanelSATerr:setVisible(true) 
end


-------------------------------------------------------------------------------
-- 
function show(b)
	if(b==true) then
        flagNeedMessage = true
		Analytics.pageview(Analytics.ModuleManager)
		update_bDeleteSelected()
	else
		selectedForDelete = {} -- сбрасываем выбранное для удаления
        Exit()
	end
	
	window:setVisible(b)
    if(b==true) then
        verifyAuthorization()		
		if modulesInfo.isUpdating() == true then
			panel_waitDsbweb.show(true)
			modulesInfo.addCallbackEndUpdating(refreshPanels)
		else
			refreshPanels()
		end
    end    
end

-------------------------------------------------------------------------------
-- 
function setAutorization(result)
    if result == true then
        bLoginLogout:setState(false)    

        sLogin:setText(panel_auth.getLogin())
     --   local nw = sLogin:calcSize()  
     --   sLogin:setBounds(widthMain-220-nw,9,nw,20)
        sLogin:setVisible(true)
        sTextWarning:setVisible(false)
    else
        bLoginLogout:setState(true)
        sLogin:setVisible(false)
        sTextWarning:setVisible(true)
    end
    updateTextLoginLogout()
 --   bLoginLogout:setVisible(true)
    refresh()
end

-------------------------------------------------------------------------------
-- 
function createPanelMod(x,y,w,h, a_data, a_parent, a_type, a_noAddNeedUnstall)
	pModPanel = Panel.new()
	pModPanel:setBounds(x,y,w,h)
	pModPanel:setSkin(pModulsSkin)
	a_parent:insertWidget(pModPanel)
	
	--print("------------------------")
	--base.U.traverseTable(a_data)
	--print("----a_data.price=",a_data.price)
	
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
        if a_type == 'campaigns' then
            skin.skinData.states.released[1].picture = Picture.new("./dxgui/skins/skinME/images/Unknown.png", nil, Align.new(Align.left),Align.new(Align.top))
        else
            skin.skinData.states.released[1].picture = Picture.new("./dxgui/skins/skinME/images/Unknown.png", nil, Align.new(Align.left),Align.new(Align.top))
        end    
	end;
	sImage:setSkin(skin)
	
	sHeader = Static.new()
	sHeader:setSkin(sHeaderModSkin)
	sHeader:setWrapping(true)
	sHeader:setText(a_data.title)	
	pModPanel:insertWidget(sHeader)
	
	sText = eDesc:clone()
	sText:setText(a_data.preview)
	pModPanel:insertWidget(sText)
    
    sTextWarningMod = Static.new()	
	sTextWarningMod:setSkin(Skin.modul_text_warning_mod())
	sTextWarningMod:setWrapping(true)		
	pModPanel:insertWidget(sTextWarningMod)
    btnsNecessaryModuls = nil
--[[
    a_data.required_products = 
    {
        {"A-10C", "F-15C"},
        {"Ka-50", "P-51D"},
      --  {"F-15C", "F-15C", "F-15C",},
      --  {"A-10C", "P-51D"},
        
    }]]
    
    local function createTxtStringRequired(a_required_products, a_index, a_resultTbl, a_curRow)
        if a_required_products[a_index] ~= nil then
            for k , updateId in base.pairs(a_required_products[a_index]) do                
                local curRow = {}
                if a_index > 1 then
                    U.recursiveCopyTable(curRow, a_curRow)                
                end
                table.insert(curRow,updateId)
                createTxtStringRequired(a_required_products, a_index+1, a_resultTbl, curRow)
            end
        else
            table.insert(a_resultTbl,a_curRow)
        end    
    end
	
	local function addButton(title, skinBtn, row, modul)
		local btnNes = Button.new()
	
		btnNes:setSkin(skinBtn)	
		btnNes:setText(title)
		btnNes.offsetY = (row-1) * 20
		btnNes:setBounds(0, 0, 800, 20)
		local sts = Static.new()
		sts:setSkin(skinBtn)
		sts:setText(title)
		btnNes.offsetX = lastW
		local wWid, hWid = sts:calcSize()
		lastW = lastW + wWid
		btnNes:setSize(wWid, hWid)                 
		pModPanel:insertWidget(btnNes)
		if modul then
			btnNes.blink = modulesInfo.getModulBlinkByModulId(modul.modulId) -- modul and modul.blink or nil
		end
		btnNes.onChange = onChangeBuy
		base.table.insert(btnsNecessaryModuls,btnNes)
	end
    
    if a_data.required_products then
        if verifyAllowedBuy(a_data) == false then
            btnsNecessaryModuls = {}
            local text = cdata.tWarning
            sTextWarningMod:setText(cdata.tWarning)  

            local result = {}
            local title = ""
            createTxtStringRequired(a_data.required_products, 1, result, {})
            
            for k, row in base.pairs(result) do 
                lastW,lastH = 0
                for kk, updateId in base.pairs(row) do
                    local modul = modulesInfo.getModulByUpdateId(updateId) or modulesInfo.getTerrainById(updateId)
                    
                    if kk == 1 then
						addButton(k..". ",btnLinkNoBorderSkin, k, modul)
						addButton(modul and modul.title or updateId,btnLinkSkin, k, modul)
                    else
						addButton(" + ",btnLinkNoBorderSkin, k, modul)
						addButton(modul and modul.title or updateId,btnLinkSkin, k, modul)
                    end
                end
            end
        end    
    end
    
    sIconWarning = Static.new()	
	sIconWarning:setSkin(Skin.modul_icon_warning_mod())
	pModPanel:insertWidget(sIconWarning)
	
	bbMore = Button.new()
	bbMore:setSkin(Skin.btn_MORE_modul())	
	bbMore:setText(cdata.more)
    bbMore:setTooltipText(cdata.more_tooltip)
	pModPanel:insertWidget(bbMore)
	bbMore.data = a_data
	bbMore.onChange = onChangeMore
    bbMore:setVisible(false) --отключено
	
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
	
	bbBuy = Button.new()
	bbBuy:setSkin(btnBuySkin)
	bbBuy:setText(cdata.buy)
    bbBuy:setTooltipText(cdata.buy_tooltip)    
	pModPanel:insertWidget(bbBuy)
	bbBuy.blink = a_data.blink--'http://www.digitalcombatsimulator.com/index.php?end_pos=1322&scr=shop&lang=en'-- 
	bbBuy.onChange = onChangeBuy
	
	bbLoad = Button.new()
	bbLoad:setSkin(btnBuySkin)
	bbLoad:setText(cdata.install)
    bbLoad:setTooltipText(cdata.install_tooltip)
	bbLoad:setVisible(false) ---!!!!!!!!!!!!!!!!!!!!!!!
	pModPanel:insertWidget(bbLoad)
    bbLoad.update_id = a_data.update_id
    bbLoad.onChange = onChangeLoad
   
	if a_data.have == '0' then
		if a_data.blink == nil then
			bbBuy:setVisible(false)
		else	
			bbBuy:setVisible(true)
		end
		bbLoad:setVisible(false)
	else
		bbBuy:setVisible(false)
		bbLoad:setVisible(true)
		
		if a_noAddNeedUnstall ~= true and a_data.update_id and installedMod_by_updateid[a_data.update_id] ~= true then
			base.table.insert(needInstall, {update_id = a_data.update_id, name = a_data.title, category = a_data.type})
		end    
	end
  
    if a_data.required_products then
        bbBuy:setEnabled(verifyAllowedBuy(a_data))
    end
	
	resizePanelMod(x,y,w,h, (a_data.dprice ~= ""), a_type)
end

-------------------------------------------------------------------------------
-- 
function resizePanelMod(x,y,w,h, a_bOld, a_type) -- a_bOld - отображать старую цену
	local nh
	local nw
	
    local wMore,nh = bbMore:calcSize()
	local wPrice,nh = sPrice:calcSize()
	local wOldPrice,nh = sOldPrice:calcSize()
    
	if (bbBuy:isVisible() == true) then
		nw,nh = bbBuy:calcSize()
        nw = nw + offsetTextBut
        bbBuy:setBounds(w-196, 300, 144, buttonH)
	else	
		nw,nh = bbLoad:calcSize()
        nw = nw + offsetTextBut
        bbLoad:setBounds(w-196, 300, 144, buttonH)
	end  
	
    local offsetImage = 0 
    local decHtext = 0 
    sTextWarningMod:setVisible(false)
    sIconWarning:setVisible(false)
    if a_type == 'campaigns' then        
		sImage:setBounds(17, 73,110,150)
		offsetImage = 131 
		
		sIconWarning:setBounds(offsetImage+7,h-125,20, 20)
		sTextWarningMod:setBounds(offsetImage+30,h-122,w-nw-30-wMore-20-wPrice-offsetImage-10, 30)
        if btnsNecessaryModuls and #btnsNecessaryModuls > 0 then  
			decHtext = 70
            for k,btnNM in base.pairs(btnsNecessaryModuls) do
                btnNM:setPosition(offsetImage+7+btnNM.offsetX, h-95+btnNM.offsetY)          
            end
            sTextWarningMod:setVisible(true)
            sIconWarning:setVisible(true)
        end
    else	
        sImage:setBounds(17, 73,110,150)
        offsetImage = 131 
		sIconWarning:setBounds(offsetImage+7,h-125,20, 20)
        sTextWarningMod:setBounds(offsetImage+30,h-122,w-nw-30-wMore-20-wPrice-offsetImage-10, 30)
		if btnsNecessaryModuls and #btnsNecessaryModuls > 0 then  
			decHtext = 70
            for k,btnNM in base.pairs(btnsNecessaryModuls) do
                btnNM:setPosition(offsetImage+7+btnNM.offsetX, h-95+btnNM.offsetY)          
            end
            sTextWarningMod:setVisible(true)
            sIconWarning:setVisible(true)
        end	
    end
	sHeader:setBounds(17,h*0.1,w-200,60)
	sText:setBounds(offsetImage,h*0.1+33,w-30-offsetImage-10, math.ceil((220-decHtext)/sizeStringModulText) * sizeStringModulText)
	bbMore:setBounds(w-wMore-10-wPrice-36, 90, wMore, buttonH)
	
	if (a_bOld == true) then
		sOldPrice:setBounds(w-190-wPrice-wOldPrice - 40,300,wOldPrice,30)
		sPrice:setBounds(w-190-wPrice-20,300,wPrice,30) 
	else
		sPrice:setBounds(w-190-wPrice-20,300,wPrice,30)
	end

end

-------------------------------------------------------------------------------
-- 
function createPanelInstallMod(x,y,w,h, a_data, a_parent, a_type)
    local modul = {}
    modul = modulesInfo.getModulIDS(a_data.update_id) or modul

    pModPanel = Panel.new()
	pModPanel:setBounds(x,y,w,h)
	pModPanel:setSkin(pModulsSkin)
	a_parent:insertWidget(pModPanel)
    
    local sNameMod = Static.new()
	sNameMod:setSkin(sNameModSkin)
    sNameMod:setBounds(20,10,600,30)

	sNameMod:setText(modul.title_mm or _(a_data.displayName)  or a_data.defDisplayName)	
	if a_data.update_id then
		modDisplayNameByUpdateId[a_data.update_id] = modul.title_mm or _(a_data.displayName)  or a_data.defDisplayName	
	end
	pModPanel:insertWidget(sNameMod)
	
	local cbDelete = CheckBox.new()
	cbDelete:setSkin(cbDeleteSkin)	
	pModPanel:insertWidget(cbDelete)
	cbDelete.data = a_data
	cbDelete.onChange = onChangeCbDelete
	local nwDel,nh = cbDelete:calcSize()
    nwDel = nwDel + offsetTextBut
    lOffset = w-nwDel-190
    cbDelete:setBounds(lOffset, (h - nh)/2, nwDel, nh)
    if cbDelete.data == nil or cbDelete.data.update_id == nil or enableUpdater == false then
        cbDelete:setVisible(false)
	else
		cbDelete:setState(selectedForDelete[cbDelete.data.update_id] ~= nil)
    end
    
    local bbDelete = Button.new()
	bbDelete:setSkin(bbDeleteSkin)	
	--bbDelete:setText(_("DELETE"))
    bbDelete:setTooltipText(cdata.remove_tooltip)
	pModPanel:insertWidget(bbDelete)
	bbDelete.data = a_data
	bbDelete.onChange = onChangeDelete
	local nwDel,nh = bbDelete:calcSize()
    nwDel = nwDel + offsetTextBut
    lOffset = w-nwDel-20
    bbDelete:setBounds(lOffset, (h - nh)/2, nwDel, nh)
    if bbDelete.data == nil or bbDelete.data.update_id == nil or enableUpdater == false then
        bbDelete:setVisible(false)
    end
    
    local bbDRM = Button.new()
	bbDRM:setSkin(btnSerialSkin)	
	bbDRM:setText("DRM")
    bbDRM:setTooltipText(cdata.sf_tooltip)
	pModPanel:insertWidget(bbDRM)
	bbDRM.data = a_data
	bbDRM.onChange = onChangeDRM
	local nwSF,nh = bbDRM:calcSize()
    nwSF = nwSF + offsetTextBut
    local lOffset = w-nwSF-nwDel-20
    bbDRM:setBounds(lOffset, 11, nwSF, buttonH)
    if bbDRM.data ~= nil and bbDRM.data.DRM_controller ~= nil then
        local attributes = lfs.attributes(bbDRM.data.dirName .. '/' .. bbDRM.data.DRM_controller)		    
		if not (attributes and attributes.mode == 'file')  then
            bbDRM:setVisible(false)
        end 
    else
        bbDRM:setVisible(false)
    end

    local bbKey = Button.new()
	bbKey:setSkin(btnSerialSkin)	
	bbKey:setText(cdata.serial_number)
    bbKey:setTooltipText(cdata.serial_number_tooltip)
	pModPanel:insertWidget(bbKey)
    bbKey:setBounds(20,20,600,buttonH)
	bbKey.data = a_data
    bbKey.modul = modulesInfo.getModulIDS(a_data.update_id)
--    if (bbKey.modul == nil or bbKey.modul.protectionType ~= "starforce") then
        bbKey:setVisible(false)
--    else
--       bbKey:setVisible(true)
--    end
	bbKey.onChange = onChangeKey
	local nwKey,nh = bbKey:calcSize()
    nwKey = nwKey + offsetTextBut
  --  lOffset = lOffset - nwKey-30
    lOffset = lOffset - 320 - 30
    bbKey:setBounds(lOffset, 11, 320, buttonH)
    
    local bbCopy = Button.new()
    bbCopy:setSkin(bbCopySkin)	
    bbCopy:setBounds(lOffset+320-2*buttonH-15, 12, buttonH, buttonH)
    bbCopy:setTooltipText(cdata.copy_tooltip)
    pModPanel:insertWidget(bbCopy)
    bbCopy:setVisible(false)
    bbCopy.onChange = onChangeCopy
    bbKey.bbCopy = bbCopy
    
    local clKey = ComboList.new()
    clKey:setSkin(clKeySkin)	
    clKey:setBounds(lOffset, 11, 320-2*buttonH-30, buttonH)
    pModPanel:insertWidget(clKey)
    clKey:setVisible(false)
    bbKey.clKey = clKey
    bbCopy.clKey = clKey
    
    local bbCloseKey = Button.new()
    bbCloseKey:setSkin(bbCloseKeySkin)	
    bbCloseKey:setBounds(lOffset+320-buttonH, 12, buttonH, buttonH)
    pModPanel:insertWidget(bbCloseKey)
    bbCloseKey:setTooltipText(cdata.hide_tooltip)
    bbCloseKey:setVisible(false)
    bbKey.bbCloseKey = bbCloseKey    
    bbCloseKey.bbKey = bbKey
    bbCloseKey.clKey = clKey
    bbCloseKey.bbCopy = bbCopy
    bbCloseKey.onChange = onChangeCloseKey
    
    local nwCH = 0
    local nh
    if a_type ~= 'campaigns' then
        local bbEnable = CheckBox.new()
        bbEnable:setSkin(checkBoxPlusSkin)	
        bbEnable:setTooltipText(cdata.modul_btn_onoff_tooltip)
        pModPanel:insertWidget(bbEnable)
        if (pluginsEnabledOld[a_data.id] ~= nil)then
            bbEnable:setState(pluginsEnabledOld[a_data.id])      
        else
            bbEnable:setState(true)           
        end    
        --base.print("--------",a_data.id, pluginsEnabledOld[a_data.id], bbEnable:getState())

        bbEnable:setBounds(20,10, 60,30)
        bbEnable.data = a_data
        bbEnable.onChange = onChangeCH
        nwCH,nh = bbEnable:getSize()
        lOffset = lOffset - nwCH-50
        bbEnable:setBounds(lOffset, (h - nh)/2, nwCH, nh)
        
        --sNameMod:setBounds(20,15,lOffset - nwCH - 285,30)
    end
	
	lOffset = lOffset - nwCH - 245
	local sNameDeveloper = Button.new()
	sNameDeveloper:setSkin(btnDeveloperSkin)
    sNameDeveloper:setBounds(lOffset,0, 245,50)
	sNameDeveloper.onChange = onChangeNameDeveloper
	sNameDeveloper.developerLink = a_data.developerLink or developerLink[(modul.developerName or a_data.developerName)]
	if sNameDeveloper.developerLink == nil then
		sNameDeveloper:setEnabled(false)
	end
	sNameDeveloper:setText(modul.developerName or a_data.developerName)	
	pModPanel:insertWidget(sNameDeveloper)

end

function onChangeNameDeveloper(self)
	if self.developerLink then
		local url = DcsWeb.make_auth_url(self.developerLink)
        os.open_uri(url)
	end
end

-------------------------------------------------------------------------------
--
function onChangeCH(self)
    pluginsEnabledNew[self.data.id] = self:getState()
    if flagNeedMessage then
        local handler = MsgWindow.question(cdata.needRestart, cdata.restart, cdata.yes, cdata.no)
		
        function handler:onChange(buttonText)
            if buttonText == cdata.yes then
                savePluginsEnabled(pluginsEnabledNew, lfs.writedir()..'Config/pluginsEnabled.lua')
                base.restartME()
            end
			
            flagNeedMessage = false
        end	
		
        handler:show()        
    end
end

-------------------------------------------------------------------------------
--
function onChangeCbDelete(self)
	if self:getState() then
		selectedForDelete[self.data.update_id] = self.data.update_id
	else
		selectedForDelete[self.data.update_id] = nil
	end
	
	update_bDeleteSelected()
end

-------------------------------------------------------------------------------
--
function update_bDeleteSelected()
	bDeleteSelected:setEnabled(false)
	bDeleteSelected:setTooltipText(cdata.DeleteSelected_tooltip) 
	
	local text = ""
	for k, v in base.pairs(selectedForDelete) do
		if text ~= "" then
			text = text..", "
		end
		bDeleteSelected:setEnabled(true)
		text = text..(modDisplayNameByUpdateId[v] or v)
	end
	bDeleteSelected:setTooltipText(cdata.DeleteSelected_tooltip..": "..text) 
end

-------------------------------------------------------------------------------
--
function onChangeDelete(self)    
    local data = self.data
    local dName = data.displayName
    if dName then
        dName = " \""..dName.."\""
    else
        dName = ""
    end
    local msg = cdata.needDelete..dName.."?"
    local handler = MsgWindow.question(msg, cdata.DELETE, cdata.yes, cdata.no)
		
        function handler:onChange(buttonText)
            if buttonText == cdata.yes then
                local modname = data.update_id
               -- base.print("----modname=",modname)
                mod_updater.uninstallComponent(modname)
            end		
        end	
		
        handler:show()  
end


-------------------------------------------------------------------------------
--
function onChangeDRM(self)
	os.run_process(self.data.dirName .. '/' .. self.data.DRM_controller, "")	
end
        
-------------------------------------------------------------------------------
--
function onChangeKey(self)
    downloadKey(self)
    self:setVisible(false)
    self.bbCopy:setVisible(true)
    self.clKey:setVisible(true)
    self.bbCloseKey:setVisible(true)
end

-------------------------------------------------------------------------------
--
function onChangeCopy(self)
    Gui.CopyTextToClipboard(self.clKey:getText())
end

-------------------------------------------------------------------------------
--
function onChangeCloseKey(self)
    self:setVisible(false)
    self.bbCopy:setVisible(false)
    self.clKey:setVisible(false)
    self.bbKey:setVisible(true)
end

-------------------------------------------------------------------------------
-- 
function plugins_authorization() 
    local f,err = loadfile(lfs.writedir()..'Config/pluginsEnabled.lua')
    if not f then
       pluginsEnabledOld = {}
       return
    end
    local env = {_ = function(p) return p end} -- ;
    setfenv(f, env)
    local ok, res = base.pcall(f)
	if not ok then
		log.error('ERROR: plugins_authorization() failed to pcall: '..res)
		pluginsEnabledOld = {}	
		return
	end
	
    if (env.pluginsEnabled) then
        pluginsEnabledOld = env.pluginsEnabled
    else
        pluginsEnabledOld = {}
    end
end

-------------------------------------------------------------------------------
--
function compareModulesData(a_ModulesNew, a_ModulesOld)
	local result = true
	for k,v in pairs(a_ModulesNew.DLC.moduls) do		
		if (a_ModulesOld.DLC.moduls == nil) 
			or (a_ModulesOld.DLC.moduls[k] == nil) 
			or (v.date ~= a_ModulesOld.DLC.moduls[k].date) then
			result = false
		end
	end
	
	return result;
end

-------------------------------------------------------------------------------
--
function onChangeBuy(self)
    if (self.blink) then	
        local url = DcsWeb.make_auth_url(self.blink)
        os.open_uri(url)
		
		Analytics.buy_request(self.blink)
    end
end

-------------------------------------------------------------------------------
--
function onChangeLoad(self)
    if (self.update_id) then	        
        commandInstall = self.update_id
        --base.print("----commandInstall=",commandInstall)
        activationStatusTbl = {}
        panel_waitDsbweb.show(true)
        
        activationModul(self.update_id)
                
        panel_waitDsbweb.startWait(verifyActivationModul, activationModulEnd)
	end
end  


-------------------------------------------------------------------------------
--
function onChangeMore(self)
	if (self.data) then
		updateMorePanel(self.data)
		pPanelMore:setVisible(true)
        setVisibleMainPanel(false)
	end
end


-------------------------------------------------------------------------------
--
function createPanelsInstall()
    local numSO = 0
	local numAA = 0	
	local numBU = 0	
	local heightP = 350
	
	if (ModulesNew == nil or ModulesNew.DLC == nil) then
		return
	end
	
	if ModulesNew.DLC.moduls and panel_auth.getOfflineMode() ~= true then
		for k,v in ipairs(ModulesNew.DLC.moduls) do	
			if (mod_updater.isInstalledComponent(v.update_id) == false) or v.have == '0' then
				if (v.dprice ~= "") then
					createPanelMod(0, heightP*numSO, widthMain-1, heightP, v, pPanelSO)
					numSO = numSO + 1
				else
					createPanelMod(0, heightP*numAA, widthMain-1, heightP, v, pPanelAA)
					numAA = numAA + 1			
				end
			end
		end
	end
	
	if ModulesNew.DLC.bundles and panel_auth.getOfflineMode() ~= true then
		for k,v in ipairs(ModulesNew.DLC.bundles) do	
			if (mod_updater.isInstalledComponent(v.update_id) == false) or v.have == '0' then
				createPanelMod(0, heightP*numBU, widthMain-1, heightP, v, pPanelBU)
				numBU = numBU + 1
			end
		end
	end
    
    createPanelCamp()
	update_clCampFilter_LA()
    
    local numADTerr = 0
    if ModulesNew.DLC.terrains and panel_auth.getOfflineMode() ~= true then
        for k,v in ipairs(ModulesNew.DLC.terrains) do	
            if (mod_updater.isInstalledComponent(v.update_id) == false) or v.have == '0' then
                createPanelMod(0, heightP*numADTerr, widthMain-2, heightP, v, pPanelADTerr, 'terrain')
                numADTerr = numADTerr + 1			
            end
        end
    end
    
    local numSAMods = 0
    local numSATerr = 0
    local numSACamp = 0

    for k,v in pairs(base.plugins) do
        if  v.state == "installed" and not v.is_core then
            if v._loader_info.type == "aircraft" or v._loader_info.type == "tech" then
                createPanelInstallMod(0, 50*numSAMods, widthMain-2, 50, v, pPanelSAMods)
                numSAMods = numSAMods + 1
            elseif v._loader_info.type == "terrain" then
                createPanelInstallMod(0, 50*numSATerr, widthMain-2, 50, v, pPanelSATerr)
                numSATerr = numSATerr + 1
            end            
        end
        if v._loader_info and v._loader_info.type == "campaign" then 
            createPanelInstallMod(0, 50*numSACamp, widthMain-2, 50, v, pPanelSACamp, 'campaigns')
            numSACamp = numSACamp + 1
        end
    end

	setVisibleTabs((numSO ~= 0), (numBU ~= 0),(numAA ~= 0),(numSA ~= 0))
    verifyNeedInstall()
end

function verifyFilterCampClass(a_camp)
	local result = false
	
	if tbCampFilter_JET:getState() == true and a_camp.class == 'Jet' then
		result = true	
	end

	if tbCampFilter_PISTON:getState() == true and a_camp.class == 'Piston' then
		result = true	
	end
	
	if tbCampFilter_WING:getState() == true and a_camp.class == 'Rotary' then
		result = true	
	end
	
	if tbCampFilter_OTHER:getState() == true and (a_camp.class == 'Other' or a_camp.class == nil) then
		result = true	
	end
	
	return result
end

function verifyFilterCamp(a_camp)
	local result = false
	
	result = verifyFilterCampClass(a_camp)
	
	if result == true then
		local item = clCampFilter_LA:getSelectedItem()
		local resultA = false
		if item == nil or item.id == "all" then	
			resultA = true
		else
			if a_camp.aircraft then					
				for kk, aircraftType in base.pairs(a_camp.aircraft) do
					if item.id == aircraftType then
						resultA = true
					end
				end	
			end	
		end
		result = result and resultA
	end
	
	return result
end

function createPanelCamp()
	if (ModulesNew == nil or ModulesNew.DLC == nil) then
		return
	end
	
	local heightP = 350
	local numADCamp = 0
	if ModulesNew.DLC.campaigns and panel_auth.getOfflineMode() ~= true then
		for k,v in ipairs(ModulesNew.DLC.campaigns) do	
			if (mod_updater.isInstalledComponent(v.update_id) == false) or v.have == '0' then
				if verifyFilterCamp(v) == true then
					createPanelMod(0, heightP*numADCamp, widthMain-2, heightP, v, pPanelADCamp, 'campaigns')
					numADCamp = numADCamp + 1
				end	
			end
		end
	end
	
end

-------------------------------------------------------------------------------
--
function setVisibleTabs(a_bSO, a_bBU, a_bAA, a_bSA)
	pPanelSO:setVisible(false)
	pPanelBU:setVisible(false)
	pPanelAA:setVisible(false)
	pPanelSA:setVisible(false)
    pPanelAD:setVisible(false)
	
	if a_bSO == false then
		bSO:setEnabled(false)
		pPanelAA:setVisible(true)
		bAA:setState(true)
	else
		bSO:setEnabled(true)
		pPanelSO:setVisible(true)
		bSO:setState(true)
	end

	if a_bBU == false then
		pPanelBU:setEnabled(false)
		--pPanelAA:setVisible(true)
		--bAA:setState(true)
	else
		bBU:setEnabled(true)
		--pPanelBU:setVisible(true)
		--bBU:setState(true)
	end
	
	if a_bSA == false then
		bSA:setEnabled(false)
	else
		bSA:setEnabled(true)
	end
	 
	if panel_auth.getOfflineMode() == true then
		bSO:setEnabled(false)
		bBU:setEnabled(false)
		bAA:setEnabled(false)
		bAD:setEnabled(false)	
		
		bSA:setState(true)
		onChange_bSA()
	end
end

-------------------------------------------------------------------------------
--
function updateMorePanel(a_data)
	local skin = sImageMore:getSkin()
	local a = nil
	if (a_data.imageLocal) then	
		a = lfs.attributes(a_data.imageLocal,'mode')
	end
	
	if a then
		skin.skinData.states.released[1].picture = Picture.new(a_data.imageLocal)
	else
		skin.skinData.states.released[1].picture = Picture.new("./dxgui/skins/skinME/images/Unknown.png")
	end;
	
	sImageMore:setSkin(skin)
	
	sHeaderMore:setText(a_data.title)	    
	sTextMore:setText(a_data.description)    
	if (a_data.dprice) and (a_data.dprice ~= "") then
		sOldPriceMore:setText(a_data.price)
        sPriceMore:setText(a_data.dprice)        
		sOldPriceMore:setVisible(true)
	else
        sPriceMore:setText(a_data.price)	
		sOldPriceMore:setVisible(false)
	end		
	bbBuyMore.blink         = a_data.blink
    bbLoadMore.update_id    = a_data.update_id
    
    if a_data.have == '0' then
        bbBuyMore:setVisible(true)
        bbLoadMore:setVisible(false)
    else
        bbBuyMore:setVisible(false)
        bbLoadMore:setVisible(true)
    end    
end

-------------------------------------------------------------------------------
--
function updatePanels()
	if (ModulesNew == nil) or (ModulesNew.DLC == nil)  or (ModulesNew.DLC.moduls == nil) then
		return
	end
    
    needInstall = {}
    
    pPanelSO:removeAllWidgets()
	pPanelBU:removeAllWidgets()
    pPanelAA:removeAllWidgets()
    pPanelSAMods:removeAllWidgets()    
    pPanelSATerr:removeAllWidgets()
	pPanelSACamp:removeAllWidgets()   
    pPanelADTerr:removeAllWidgets()	
	updatePanelCamp()
end

function updatePanelCamp()
	if (ModulesNew == nil) or (ModulesNew.DLC == nil)  or (ModulesNew.DLC.moduls == nil) then
		return
	end
	
	pPanelADCamp:removeAllWidgets()
end

-------------------------------------------------------------------------------
-- 
function updateData()	
    if modulesInfo.isErrorLoad() or (ModulesNew and ModulesNew.DLC and ModulesNew.DLC.moduls and ModulesNew.DLC.moduls[0] 
        and ModulesNew.DLC.moduls[0].logged_in
        and ModulesNew.DLC.moduls[0].logged_in == '0')then
        
        if (base.__FINAL_VERSION__ or panel_auth.isAutorization()) and panel_auth.getOfflineMode() ~= true then
            MsgWindow.warning(cdata.ErrorInData, cdata.ErrorInDataMessage, cdata.ok):show()
        end
    end    

    updatePanels() 
end

-------------------------------------------------------------------------------
-- 
function fillListMods()
	local vOffset = 0
	sectionCollapse = sectionCollapse or {}	
	local mawW = 300
	local tabOrder = 1
	local skinCB = installModsPanel.pNoVisible.checkBoxEx:getSkin()
	local skinTB = installModsPanel.pNoVisible.tbSection:getSkin()
	
	listMods:removeAllWidgets()
	
	local tmpTblModsByCat = {} -- после фильтра
	
	for k,v in base.pairs(tblModsByCat) do
		for kk,vv in base.ipairs(v) do
			local findText = installModsPanel.pBox.eSearch:getText()
			
			if findText == nil or findText == "" or  nil ~= textutil.Utf8FindNoCase(vv.name, findText) then
				tmpTblModsByCat[k] = tmpTblModsByCat[k] or {}
				base.table.insert(tmpTblModsByCat[k], vv)
			end
		end
	end
	
	widgetsByCat = {}
		
	for k,v in base.pairs(cats) do		
		if tmpTblModsByCat[v] then
			widgetsByCat[v] = {}

			local btnSection = ToggleButton.new()
			btnSection:setSkin(skinTB)
			btnSection:setTabOrder(tabOrder)
			listMods:insertWidget(btnSection)
			btnSection:setBounds(6, vOffset-1, 20, 20)
			btnSection:setState(sectionCollapse[v] == nil or sectionCollapse[v] == true)
			tabOrder = tabOrder + 1
			btnSection.onChange = function(self)
				sectionCollapse[v] = self:getState()
				UpdateManager.add(function()			
					fillListMods()
					return true
				end)
			end
				
			local cbCat = CheckBox.new()
			cbCat:setSkin(skinCB)	
			cbCat:setTooltipText(cdata.choose_to_install)
			cbCat:setText(tblCatNames[v].." ("..#tblModsByCat[v]..")")
			cbCat:setTabOrder(tabOrder) 
			cbCat.category = v
			listMods:insertWidget(cbCat)
			
			local itemW = cbCat:calcSize()
			if itemW > mawW then
				mawW = itemW
			end
			cbCat:setBounds(25, vOffset, itemW+5, 20)
			cbCat:setState(stateForInstall[v].state)
			vOffset = vOffset + 20  
			tabOrder = tabOrder + 1
			cbCat.onChange = function(self)
				local value = self:getState()
				for n, wid in base.ipairs(widgetsByCat[self.category]) do
					wid:setState(value)	
					stateForInstall[self.category].state = value
					stateForInstall[self.category]['mods'][wid.update_id] = value
				end
				updateCounter()
			end
			
			if (sectionCollapse[v] == nil or sectionCollapse[v] == true) then
				for kk,vv in base.ipairs(tmpTblModsByCat[v]) do
					local cbEnable = CheckBox.new()
					cbEnable:setSkin(skinCB)	
					cbEnable:setTooltipText(cdata.choose_to_install)
					cbEnable:setText(vv.name)
					cbEnable:setTabOrder(tabOrder) 
					listMods:insertWidget(cbEnable)
					base.table.insert(widgetsByCat[v], cbEnable)					
					
					local itemW = cbEnable:calcSize()
					if itemW + 45 > mawW then
						mawW = itemW + 45
					end
					cbEnable:setBounds(45, vOffset, itemW+5, 20)
					cbEnable:setState(stateForInstall[v]['mods'][vv.update_id] == true)
					cbEnable.update_id = vv.update_id
					cbEnable.category = v
					vOffset = vOffset + 20  
					tabOrder = tabOrder + 1	

					cbEnable.onChange = function(self)
						stateForInstall[self.category]['mods'][self.update_id] = self:getState()
						updateCounter()
					end					
				end
			end
		end
	end
		
	if (vOffset > 400) then
		vOffset = 400
	end    
	installModsPanel:setBounds(0, 0, widthWin, heightWin)        		
			
	local xLM, yLM, wLM, hLM = listMods:getBounds()
	listMods:setBounds(xLM, yLM, mawW+30, vOffset+42)
	
	installModsPanel.pBox.eSearch:setSize(mawW+10, 22)
	installModsPanel.pBox.bClearSearch:setPosition(mawW+24, 48)
				
	wMP = mawW+70         
	installModsPanel.pBox:setBounds((widthWin - wMP)/2, (hWin - (yLM+vOffset+98))/2, wMP, yLM+vOffset+98)
	installModsPanel.pBox.sHeader:setSize(wMP, 40)
	installModsPanel.pBox.bClose:setPosition(wMP-37, 11)
	installModsPanel.pBox.sCounter:setPosition(wMP-86, 89)
	
	local xBC, yBC, wBC, hBC = installModsPanel.pBox.bCancel:getBounds()
	installModsPanel.pBox.bCancel:setBounds((wMP/2+10), yLM+vOffset+58, wBC, hBC)
	
	local xBO, yBO, wBO, hBO = installModsPanel.pBox.bOk:getBounds()
	installModsPanel.pBox.bOk:setBounds((wMP/2-10-wBO), yLM+vOffset+58, wBO, hBO)
	
	installModsPanel:setVisible(true)
	needInstallShow = false
					
	local bClear = installModsPanel.pBox.bClear
	bClear.onChange = function()
		for k,v in base.pairs(stateForInstall) do
			v.state = false
			for kk,vv in base.pairs(v.mods) do
				v.mods[kk] = false
			end
		end	
			
		fillListMods()	
	end
	
	local bSelectAll = installModsPanel.pBox.bSelectAll
	bSelectAll.onChange = function()
		for k,v in base.pairs(stateForInstall) do
			v.state = true
			for kk,vv in base.pairs(v.mods) do
				v.mods[kk] = true
			end
		end	
			
		fillListMods()	
	end
	
	updateCounter()
end

-------------------------------------------------------------------------------
-- 
function updateCounter()
	local iCounter = 0
	local iCounterSel = 0
	for k,v in base.pairs(stateForInstall) do
		for update_id, vv in base.pairs(v.mods) do			
			iCounter = iCounter + 1
			if vv == true then	
				iCounterSel = iCounterSel + 1
			end
		end
	end
	
	installModsPanel.pBox.sCounter:setText('('..iCounterSel..'/'..iCounter..')')
end

-------------------------------------------------------------------------------
-- 
function verifyNeedInstall()
    if panel_auth.getOfflineMode() ~= true and needInstall and #needInstall > 0 and needInstallShow == true then
        listMods = installModsPanel.pBox.listMods
        
		tblModsByCat = {}
		
		for k,v in base.pairs(needInstall) do
			if v.category and tblCatNames[v.category] ~= nil then
				tblModsByCat[v.category] = tblModsByCat[v.category] or {}
				base.table.insert(tblModsByCat[v.category], v)
			else
				tblModsByCat['Bundle'] = tblModsByCat['Bundle'] or {}
				base.table.insert(tblModsByCat['Bundle'], v)
			end

		end
        
        local bCancel = installModsPanel.pBox.bCancel
        bCancel.onChange = function()
            installModsPanel:setVisible(false)
        end
		
		installModsPanel.pBox.bClose.onChange = function()
            installModsPanel:setVisible(false)
        end
        
        local bOk = installModsPanel.pBox.bOk
        bOk.onChange = function()
            activationStatusTbl = {}
            panel_waitDsbweb.show(true)
            commandInstall = "" 
            installModsPanel:setVisible(false)
			
			for k,v in base.pairs(stateForInstall) do
				for update_id, vv in base.pairs(v.mods) do
					if vv == true then
						activationModul(update_id)
						commandInstall = commandInstall.." "..update_id
					end
				end
			end

            panel_waitDsbweb.startWait(verifyActivationModul, activationModulEnd)
        end
		
		installModsPanel.pBox.eSearch.onChange = function()
			fillListMods()
		end
		
		installModsPanel.pBox.bClearSearch.onChange = function()
			installModsPanel.pBox.eSearch:setText("")
			fillListMods()
		end
		
		stateForInstall = {}
		for k,v in base.pairs(cats) do	
			if tblModsByCat[v] then
				stateForInstall[v] = {}
				stateForInstall[v].state = true
				stateForInstall[v].mods = {}
				for kk,vv in base.ipairs(tblModsByCat[v]) do
					stateForInstall[v]['mods'][vv.update_id] = true
				end
			end
		end
		
        fillListMods()		
    end
end

-------------------------------------------------------------------------------
-- 
function savePluginsEnabled(a_table, fName)	 
    local f, err = io.open(fName, 'w')	
	
    if f then
        local sr = S.new(f) 
        sr:serialize_simple2('pluginsEnabled', a_table)
        f:close()
	else
		log.error('ERROR: savePluginsEnabled() failed: '..err)	
    end
end
    
-------------------------------------------------------------------------------
-- 
function Exit()
    --panel_auth.logout(setAutorization)
    if U.compareTables(pluginsEnabledNew, pluginsEnabledOld) == false then
        local handler = MsgWindow.question(cdata.applyChanges, cdata.applyChangesCap, cdata.yes, cdata.no)
		
        function handler:onChange(buttonText)
            if buttonText == cdata.yes then            
                savePluginsEnabled(pluginsEnabledNew, lfs.writedir()..'Config/pluginsEnabled.lua')
                base.restartME()
            end
			
            flagNeedMessage = false
        end	
		
        handler:show()
    end  
    mmw.show(true)    
end

-------------------------------------------------------------------------------
-- 
function downloadKey(a_bbKey)
    Serials = nil
    clKey = a_bbKey.clKey
    if (a_bbKey.modul) then
        panel_waitDsbweb.show(true)
        DcsWeb.send_request('dcs:serial', {update_id = a_bbKey.modul.update_id})
        panel_waitDsbweb.startWait(verifyStatusDownloadKey, downloadKeyEnd)
    end
end

-------------------------------------------------------------------------------
-- 
function downloadKeyEnd()
    local response = DcsWeb.get_data('dcs:serial')
    local Serials = {}
    
    if statusDownloadKey >= 400 then
        base.print("ERROR activation DcsWeb.get_data() ",response)
    else
        local tmpSerials, errStr = loadstring(response);
        setfenv(tmpSerials, Serials);
        tmpSerials()
    end
       
    local serials = {}
    if (Serials.serials and Serials.serials[0]) then
        for k,v in pairs(Serials.serials) do
            table.insert(serials,{name = v})
        end
    else
        table.insert(serials,{name = _('No key')})
    end   
        
    U.fillComboList(clKey, serials)
end

-------------------------------------------------------------------------------
-- 
function verifyStatusDownloadKey()
    statusDownloadKey = DcsWeb.get_status('dcs:serial')
    
    if statusDownloadKey ~= 102 then                      
        return true, statusDownloadKey     
    end
    return false
end

-------------------------------------------------------------------------------
-- 
function verifyAuthorization()
  --  panel_auth.silentAutorization()
	if not base.__FINAL_VERSION__ then
		setAutorization(panel_auth.isAutorization())
	end
end

-------------------------------------------------------------------------------
-- 
function activationModul(a_updateid)
    local modul = modulesInfo.getModulByUpdateId(a_updateid)
    
    if modul == nil then
        modul = modulesInfo.getCampById(a_updateid)
    else
        modul = modulesInfo.getTerrainById(a_updateid)
    end
    
    if modul == nil or modul.protect_path == nil then
        return
    end
        
    if (a_updateid) then
        local nameItem = 'activ_'..a_updateid
        DcsWeb.send_request('dcs:serial', {update_id = a_updateid}, nameItem)
        activationStatusTbl[nameItem] = {} 
        activationStatusTbl[nameItem].status = false
        activationStatusTbl[nameItem].updateid = a_updateid
        activationStatusTbl[nameItem].protect_path = modul.protect_path
    end
end

-------------------------------------------------------------------------------
-- 
function activationModulEnd()
    for k,v in base.pairs(activationStatusTbl) do        
        if v.status ~= false then            
            local response = DcsWeb.get_data(k)
            if v.status >= 400 then
                base.print("ERROR activation DcsWeb.get_data() ",response)
            else    
                local serialKeys = {}    
                local tmpSerials, errStr = loadstring(response);
                setfenv(tmpSerials, serialKeys);
                tmpSerials()
                
                if (serialKeys.serials ~= nil) and (serialKeys.serials[0] ~= nil) then
                    local key = base.string.gsub(serialKeys.serials[0], "-", "")
                    reg.regAdd("SOFTWARE\\"..v.protect_path.."\\Keys\\Settings\\Binding\\Hardware\\AutoActivation", "SilentActivationSerialNumber", key)   
                else
                    base.print("No key for ",v.updateid)
                end
            end
        end                  
    end

    if commandInstall ~= "" then   
        mod_updater.installComponent(commandInstall) --там выход есть
    end    
    installModsPanel:setVisible(false)
end

-------------------------------------------------------------------------------
--
function verifyActivationModul()
    local result = true
    for k,v in base.pairs(activationStatusTbl) do
        if (v.status == false) then
            local status = DcsWeb.get_status(k)                    
            if status ~= 102 then
                activationStatusTbl[k].status = status
            end
            result = false
        end    
    end
    return result
end

-------------------------------------------------------------------------------
-- заполняем appliedMod_by_updateid
function fillAppliedModsByUpdateId()
    appliedMod_by_updateid = {}
    installedMod_by_updateid = {}  

    for k,plugin in base.pairs(base.plugins) do        
        if plugin.state == "installed" and plugin.is_core == false and plugin.update_id then        
            installedMod_by_updateid[plugin.update_id] = true
			
			if modulesInfo.IdenticalModules[plugin.update_id] then
				for k,v in base.pairs(modulesInfo.IdenticalModules[plugin.update_id]) do
					installedMod_by_updateid[v] = true	
				end
			end
        end
        
        if plugin.applied == true and plugin.is_core == false and plugin.update_id then 
            appliedMod_by_updateid[plugin.update_id] = true
        end    
    end
end

-------------------------------------------------------------------------------
--
function modulIsApplied(a_updateid)
    return appliedMod_by_updateid[a_updateid] == true
end

-------------------------------------------------------------------------------
-- проверяем можно ли покупать
function verifyAllowedBuy(a_data)
    --[[
required_products = {
[1] = {},
[2] = {},
...
}
т.е. между [1] и [2] и ... [N]  - И
внутри - ИЛИ
]]


    if a_data.required_products then
        local result = true
        
        for k,v in base.pairs(a_data.required_products) do
            local bSec = false
            for kk,updateid in base.pairs(v) do
                if appliedMod_by_updateid[updateid] == true then
                    bSec = true
                end            
            end
            if bSec == false then
                result = false
            end
        end
    
        return result
    end
    
    return false
end
