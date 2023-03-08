local base = _G

module('me_setImage')

local require = base.require
local table = base.table
local string = base.string
local print = base.print

local DialogLoader      = require('DialogLoader')
local mod_dictionary    = require('dictionary')
local ListBoxItem       = require('ListBoxItem')
local MeSettings		= require('MeSettings')
local FileDialog        = require('FileDialog')
local FileDialogFilters = require('FileDialogFilters')
local MissionModule     = require('me_mission')
local U                 = require('me_utilities')
local SkinUtils         = require('SkinUtils')
local Panel             = require('Panel')
local Skin				= require('Skin')
local Static            = require('Static')
local ScrollPane 		= require('ScrollPane')
local Button 			= base.require('Button')
local Gui				= require('dxgui')

require('i18n').setup(_M)

cdata = {
    briefingImages 	= _("BRIEFING IMAGES PANEL"),
    Blue 			= _("BLUE"),
    Red 			= _("RED"),
	Neutrals 		= _('NEUTRAL'),
}

ImagesWidgets       = {}
delButtons          = {}
Images              = {}
curCol              = 0
langs               = {}
offsetImage         = 0
selectedImage       = { row = 0, col = 0}
LastRow 			= 1
LastCol				= 1


function create(x, y, w, h)
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_setImage.dlg", cdata)    
    window:setBounds(x, y, w, h)
    
    pBox 		= window.pBox
    pTop 		= pBox.pTop
    tgBlue 		= pTop.tgBlue
    tgRed 		= pTop.tgRed
	tgNeutrals 	= pTop.tgNeutrals
    pNoVisible 	= pBox.pNoVisible
    bClose  	= pTop.bClose
    pCenter    	= pBox.pCenter

    skinLang            = pNoVisible.sLang:getSkin()
    skinImage           = pNoVisible.sImage:getSkin()
    skinBLeft           = pNoVisible.bLeft:getSkin()
    skinBRight          = pNoVisible.bRight:getSkin()
    skinBLeftSelect     = pNoVisible.bLeftSelect:getSkin()
    skinBRightSelect    = pNoVisible.bRightSelect:getSkin()
    skinBClose          = pNoVisible.bDelete:getSkin()
    skinSelected        = pNoVisible.sSelected:getSkin()
	skinButtonPic		= pNoVisible.buttonPic:getSkin()
    
    tgRed.onShow = onChange_tgRed
    tgBlue.onShow = onChange_tgBlue
	tgNeutrals.onShow = onChange_tgNeutrals
    bClose.onChange = onChange_bClose

	tgNeutrals:setVisible(true)
		
    resize(w, h)
end

function resize(w, h)
    pBox:setBounds(0, 0, w, h)
    pTop:setBounds(0, 0, w,72)
    pCenter:setBounds(0, 71, w, h-71)
    
    bClose:setPosition(w-28, 9)
end



function show(b)

    if b == true then
        getLangs()
        createPanel()
        
        if #MissionModule.mission.pictureFileNameR > 0 then
            tgRed:setState(true)
            tgBlue:setState(false)
			tgNeutrals:setState(false)
        end
        
        if #MissionModule.mission.pictureFileNameB > 0 then
            tgRed:setState(false)
            tgBlue:setState(true)
			tgNeutrals:setState(false)
        end
		
		if MissionModule.mission.pictureFileNameN and #MissionModule.mission.pictureFileNameN > 0 then
            tgRed:setState(false)
            tgBlue:setState(false)
			tgNeutrals:setState(true)
        end

        updatePanel()
    end
    
    window:setVisible(b)
end

function getVisible()
    if window then
        return window:getVisible()
    end
    return false
end

function onChange_tgRed()
    pCenter:setVisible(true)
	updatePanel()
end

function onChange_tgBlue()
    pCenter:setVisible(true)
	updatePanel()
end

function onChange_tgNeutrals()
    pCenter:setVisible(true)
	updatePanel()
end

function updatePanel()
    clearPanel()
     
    if tgRed:getState() == true then
        listPic = MissionModule.mission.pictureFileNameR  
    elseif tgBlue:getState() == true then
        listPic = MissionModule.mission.pictureFileNameB 
	else
		listPic = MissionModule.mission.pictureFileNameN 
    end
    
    local fileName
    Images = {}
    
    for kk, idRes in base.ipairs(listPic) do
        Images[kk] = {}
        --fileName, Images[kk].path = mod_dictionary.getValueResource(idRes, lang, true)  
        Images[kk] = idRes
    end
  
--base.U.traverseTable(ImagesWidgets)
---base.U.traverseTable(Images)
    for k,lang in base.pairs(langs) do
        for i = 1, 6 do
            if Images[i] then
                local fileName, path = mod_dictionary.getValueResource(Images[i+offsetImage], lang, true)
                if path then   
                    --base.print("---fileName----",k,i,fileName)
                    setPicture(ImagesWidgets[k][i], path)
                end
            end
        end
    end
end

function getLangs()
    langs = {}
    local langsTmp = mod_dictionary.getLangs()
    
    for k,v in base.pairs(langsTmp) do
        if v == "DEFAULT" then
            base.table.insert(langs,1,v)
        else
            base.table.insert(langs,v)
        end
    end
end

function onChange_ButtonPic(self, x, y, button)
	if (selectedImage.row == self.row) 
	   and ((self.col+offsetImage) == selectedImage.col) then
		changeImage(self)
	else
		setSelectImage(self.row, self.col+offsetImage)
	end
	
end
			
function createPanel()
    pCenter:removeAllWidgets()
    ImagesWidgets = {}  
	delButtons = {}	
    
    widgetSelected = Static.new()
    widgetSelected:setSkin(skinSelected)
    widgetSelected:setBounds(130,33,110,110)  
    widgetSelected:setZIndex(0)
    pCenter:insertWidget(widgetSelected)
    
    for k,v in base.pairs(langs) do
        local curLang = v
        if curLang == 'DEFAULT' then
            curLang = 'DFLT'
        end
        local newLang = Static.new(curLang)
        newLang:setSkin(skinLang)        
        newLang:setBounds(15,73+(k-1)*138,50,30)        
        pCenter:insertWidget(newLang)

        for i = 1, 6 do
            local newImage = Static.new()
            newImage:setSkin(skinImage)
            newImage:setBounds(145+110*(i-1),48+(k-1)*138,80,80)  
            pCenter:insertWidget(newImage)
            newImage.col = i
            newImage.row = k
            newImage.lang = v
            newImage:setZIndex(1)
            ImagesWidgets[k] = ImagesWidgets[k] or {}
            ImagesWidgets[k][i] = newImage
			
			
			local bButtonPic = Button.new()
            bButtonPic:setBounds(145+110*(i-1),48+(k-1)*138,80,80)
            bButtonPic:setSkin(skinButtonPic)
            pCenter:insertWidget(bButtonPic)
            bButtonPic.onChange = onChange_ButtonPic
            bButtonPic.col = i
            bButtonPic.row = k
            bButtonPic.lang = v			
            
            local bDelImage = Button.new()
            bDelImage:setBounds(225+110*(i-1),18+(k-1)*138,16,16)
            bDelImage:setSkin(skinBClose)
            pCenter:insertWidget(bDelImage)
            bDelImage.onChange = onChange_bDelImage
            bDelImage.col = i
            bDelImage.row = k
            bDelImage.lang = v
			bDelImage:setVisible(false)
			delButtons[k] = delButtons[k] or {}
			delButtons[k][i] = bDelImage
        end    

    end
    
    local bLeft = Button.new()
	bLeft:setBounds(97,76,24,24)
    bLeft:setSkin(skinBLeft)
	pCenter:insertWidget(bLeft)
    bLeft.onChange = onChange_bLeft
   
    
    local bRight = Button.new()
	bRight:setBounds(800,76,24,24)
    bRight:setSkin(skinBRight)
	pCenter:insertWidget(bRight)
    bRight.onChange = onChange_bRight
    
    bLeftSelect = Button.new()
	bLeftSelect:setBounds(120,75,18,26)
    bLeftSelect:setSkin(skinBLeftSelect)
	pCenter:insertWidget(bLeftSelect)
    bLeftSelect.onChange = onChange_bLeftSelect
   
    
    bRightSelect = Button.new()
	bRightSelect:setBounds(233,75,18,26)
    bRightSelect:setSkin(skinBRightSelect)
	pCenter:insertWidget(bRightSelect)
    bRightSelect.onChange = onChange_bRightSelect
    
    setSelectImage(1, 1)
end

function changeImage(self)
    --base.print("----    newImage==",self.col,self.row,offsetImage)
    if (self.col+offsetImage) <= #Images then
        -- изменение картинки                     
        local fileName = openImage()
        if fileName then
            local curId = Images[self.col+offsetImage]
            mod_dictionary.setValueToResource(curId, U.extractFileName(fileName), fileName, self.lang)
            updatePanel()
        end
    elseif self.row == 1 then
        --добавляем дефолтную
        local fileName = openImage()
        if fileName then
            local curId = mod_dictionary.getNewResourceId("ImageBriefing") 
            table.insert(listPic, curId)
            Images[self.col+offsetImage] = curId
            mod_dictionary.setValueToResource(curId, U.extractFileName(fileName), fileName, "DEFAULT")	
            updatePanel()
        end
    end
end

function setSelectImage(row, col)	
    selectedImage.row = row
    selectedImage.col = col
	
    updateDrawSelectImage()	
end

function updateDrawSelectImage()	
    local col = ((selectedImage.col-offsetImage)-1)	
	if LastRow > 0 and LastCol > 0 then
		delButtons[LastRow][LastCol]:setVisible(false)
	end 
	LastRow = selectedImage.row
    LastCol = selectedImage.col-offsetImage
	if LastRow > 0 and LastCol > 0 then
		delButtons[LastRow][LastCol]:setVisible(true)
	end
	
    widgetSelected:setBounds(130+110*col,33+(selectedImage.row-1)*138,110,110) 

    bLeftSelect:setBounds(120+110*col,75+(selectedImage.row-1)*138,18,26)
	bRightSelect:setBounds(233+110*col,75+(selectedImage.row-1)*138,18,26)  
end

function onChange_bDelImage(self)
    if self.row == 1 then 
        -- удаляем дефолтную
        local fname;
        fname = table.remove(listPic, self.col+offsetImage);
     
        if fname and (fname ~= '') then
            mod_dictionary.removeResource(fname)
        end        
    else
        -- удаляем из локалей
        local curId = Images[self.col+offsetImage]
        mod_dictionary.removeResourceOnlyDict(curId, self.lang)
    end   
    updatePanel()    
end

function clearPanel()
    for k,v in base.pairs(langs) do
        for i = 1, 6 do
            ImagesWidgets[k][i]:setSkin(skinImage)
        end
    end
end

function openImage()
    local path = MeSettings.getImagePath()
	local filters = {FileDialogFilters.image()}
	local fileName = FileDialog.open(path, filters, textDlg)
	
	if fileName then
		MeSettings.setImagePath(fileName) 
    end
    return fileName
end

function setPicture(widget, pathImage)
    local staticPictureSkin = widget:getSkin()
    if (pathImage) then 
		Gui.ReloadTexture(base.tempMissionPath..pathImage)
        widget:setSkin(SkinUtils.setStaticPicture(base.tempMissionPath..pathImage, staticPictureSkin))
    else
        widget:setSkin(SkinUtils.setStaticPicture(nil, staticPictureSkin))
    end
end

function onChange_bClose()
    show(false)
end

function onChange_bLeft()
    offsetImage = offsetImage - 1
    if offsetImage < 0 then
        offsetImage = 0
    end
    if selectedImage.col > offsetImage+6 then
        setSelectImage(selectedImage.row, offsetImage+6)
    end
    updatePanel() 
    updateDrawSelectImage()
end
    
function onChange_bRight()
    if #Images >= 6 then
        offsetImage = offsetImage + 1
        
        if offsetImage > #Images-5 then
            offsetImage = #Images-5
        end 
        if selectedImage.col < offsetImage+1 then
            setSelectImage(selectedImage.row, offsetImage+1)	
        end
        updatePanel() 
        updateDrawSelectImage()
    end
end

function onChange_bLeftSelect()
    if (selectedImage.col-1) > 0 then
        local curId = Images[selectedImage.col]                        
        local curIdLeft = Images[selectedImage.col-1]
        local lang = ImagesWidgets[selectedImage.row][selectedImage.col-offsetImage].lang   
        if selectedImage.row > 1 and curId ~= nil and curIdLeft ~= nil then
            -- замена выделенной с левой картинки в локалях    
            mod_dictionary.exchangeValue(curId,curIdLeft,lang)
        elseif selectedImage.row == 1 then
            -- замена выделенной с левой картинки в дефолтных 
            listPic[selectedImage.col-1] = curId
            listPic[selectedImage.col] = curIdLeft
            Images[selectedImage.col-1] = curId
            Images[selectedImage.col] = curIdLeft
         --   mod_dictionary.exchangeValue(curId,curIdLeft,lang)
        end
    end
    updatePanel() 
    updateDrawSelectImage()
end
    
function onChange_bRightSelect()
   if (selectedImage.col+1) <= #Images then
        local curId = Images[selectedImage.col]                        
        local curIdRight = Images[selectedImage.col+1]
        local lang = ImagesWidgets[selectedImage.row][selectedImage.col-offsetImage].lang   
        if selectedImage.row > 1 and curId ~= nil and curIdRight ~= nil  then
            -- замена выделенной с правой картинки в локалях                                                     
            mod_dictionary.exchangeValue(curId,curIdRight,lang)
        elseif selectedImage.row == 1 then
            -- замена выделенной с правой картинки в дефолтных 
            listPic[selectedImage.col+1] = curId
            listPic[selectedImage.col] = curIdRight
            Images[selectedImage.col+1] = curId
            Images[selectedImage.col] = curIdRight
         --   mod_dictionary.exchangeValue(curId,curIdRight,lang)
        end
    end
    updatePanel() 
    updateDrawSelectImage()
end


    




