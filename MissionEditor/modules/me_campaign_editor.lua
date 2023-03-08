local base = _G

module('me_campaign_editor')

local require = base.require
local print = base.print
local assert = base.assert
local tostring = base.tostring
local pairs = base.pairs
local ipairs = base.ipairs
local string = base.string
local table = base.table
local io = base.io
local tonumber = base.tonumber

local Static = require('Static')
local GridHeaderCell = require('GridHeaderCell')
local EditBox = require('EditBox')
local Panel = require('Panel')
local U = require('me_utilities')
local S = require('Serializer')
local FileDialog = require('FileDialog')
local FileDialogFilters = require('FileDialogFilters')
local MeSettings = require('MeSettings')
local OF = require('me_openfile')
local MsgWindow = require('MsgWindow')
local Window = require('Window')
local lfs = require('lfs')
local i18n = require('i18n')
local minizip = require('minizip')
local DialogLoader		= require('DialogLoader')
local ListBoxItem		= require('ListBoxItem')
local SkinUtils         = require('SkinUtils')
local Gui               = require('dxgui')
local Analytics		= require("Analytics")
local log      			= require('log')

i18n.setup(_M)

local cdata = {
    exit                    = _('EXIT'),
    campaign_editor         = _('CAMPAIGN BUILDER'),
    new                     = _('New'),
    open                    = _('Open'),
    save                    = _('Save'),
    save_as                 = _('Save As'),
    name                    = _('name'),
    Name                    = _('Name'),
    Range                   = _('Range_camp', 'Range'),
	SkipScore				= _('Skip Score'),
    campaign                = _('Campaign'),
    campaign_images         = _('Campaign images'),
    description             = _('Description'),
    stage_operations        = _('stage operations'),
    mission_operations      = _('mission operations'),
    start_stage             = _('start stage'),
    up                      = _('Up'),
    down                    = _('Down'),
    add                     = _('Add'),
    remove                  = _('Remove'),
    stages                  = _('Stages'),
    stage                   = _('stage'),
    move                    = _('move'),
    position                = _('position'),
    leftBtn                 = _('CLOSE'),
    unique_mission          = _('UNIQUE MISSION'),
    missions                = _('Missions'),
    msg_interval_error      = _('can not convert to number string'),
    ok                      = _('OK'),
    message                 = _('MESSAGE'),
    msg_interval_out_of_range = _('Number is out of range [0..100]'),
    msg_interval_has_holes  = _('Stage interval contains holes'),
    msg_interval_incomplete = _('Stage interval incomplete'),
    file_exists             = _('Can not copy file to temp folder, file already exist !!!'),
    file_not_found          = _('Mission file not found '),
    openCampaign            = _('Choose campaign file to open'),
    saveCampaign            = _('Save campaign'),
    saveCampaignAs          = _('Save campaign as...'),
    addMission              = _('Choose mission file to add'),
    openPicture             = _('Choose picture for campaign'),
    new_campaign            = _('New Campaign'),
    new_stage               = _("Stage"),
    moveStagePosition       = _('move\nstage\nposition'),
    save_campaign_failed    = _('Can not write to file:'),
    save_campaign           = _('SAVE CAMPAIGN'),
    Success                 = _('Success final image'),
    Failed                  = _('Failed final image'),
    upload                  = _('SELECT IMAGE'),
    cancel                  = _('CLOSE'),
    tblName                 = _('Name'),
    Start                   = _('Start'),
    CampName                = _('Name'),
	locale                  = _('Locale'),
    tooltipPic              = _('Select image 512x512 pixels'),  
    tooltipCampPic          = _('Select image 273x130 pixels'),  
}

currentCampaign = nil
currentStage = nil
currentMission = nil
modified = true
curFilePath = nil
local locales = nil 

local VERSION = 1
local rowHeight = 18
local editBoxIntervalSkin
local staticIntervalSkin
local staticStagesGridCellSkin
local stSelectedImgSkin
local stSuccessUploadImgSkin
local stFailUploadImgSkin
local stStaticMisSkin
local eSkipScoreSkin
local eSkipScoreSSkin	


IntervalContainer = {}
IntervalContainer.new = function (text, selected)
    local container = Panel.new()
    local widget
    
    widget = Static.new(' ..')
    widget:setBounds(0,0,75,18)
    widget.container = container
    if selected == true then
        widget:setSkin(cellSkin2s)
    else
        widget:setSkin(staticIntervalSkin)
    end
    intervalStatic = widget
    container:insertWidget(widget)
    
    widget = EditBox.new('0')
    widget:setBounds(5,0,31,18)
    widget:setZIndex(1)
    widget.container = container
    if selected == true then
        widget:setSkin(eRangeSkin_s)
    else
        widget:setSkin(eRangeSkin)
    end
    
    widget.onFocus =  onIntervalStartFocus
    intervalStartEdit = widget
    container:insertWidget(widget)

    widget = EditBox.new('100')
    widget:setBounds(41,0,39,18)
    widget:setZIndex(1)
    widget.container = container
    if selected == true then
        widget:setSkin(eRangeSkin2_s)
    else
        widget:setSkin(eRangeSkin2)
    end
    widget.onFocus = onIntervalEndFocus
    intervalEndEdit = widget
    container:insertWidget(widget)
    
    container.intervalStartEdit = intervalStartEdit
    container.intervalEndEdit = intervalEndEdit
    container.intervalStatic = intervalStatic    
    container.setText = IntervalContainer.setText
    container.setSkinSelect = IntervalContainer.setSkinSelect
    return container
end


IntervalContainer.setText = function(self, text)
    self.intervalStartEdit:setText(text[1])
    self.intervalEndEdit:setText(text[2]) 
end

IntervalContainer.setSkinSelect = function(self, b_select)
    if b_select == true then
        self.intervalStartEdit:setSkin(eRangeSkin_s)
        self.intervalStatic:setSkin(dt_selected)
        self.intervalEndEdit:setSkin(eRangeSkin2_s) 
    else
        self.intervalStartEdit:setSkin(eRangeSkin)
        self.intervalStatic:setSkin(staticIntervalSkin)
        self.intervalEndEdit:setSkin(eRangeSkin2)
    end

end

function create()
    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_campaign_editor.dlg', cdata)
   

    bodyPanel               = window.mainPanel.bodyPanel
    leftPanel               = bodyPanel.leftPanel
    panelRes                = leftPanel.panelRes
    buttonCampPic           = leftPanel.buttonCampPic
    buttonSuccessPic        = panelRes.buttonSuccessPic
    buttonFailedPic         = panelRes.buttonFailedPic
    stSelectedImg           = leftPanel.stSelectedImg -- под buttonCampPic
    stSuccessUploadImg      = panelRes.stSuccessUploadImg
    stFailUploadImg         = panelRes.stFailUploadImg
    topButtonPanel          = leftPanel.topButtonPanel
    buttonOpen              = topButtonPanel.buttonOpen
    buttonNew               = topButtonPanel.buttonNew
    buttonSave              = topButtonPanel.buttonSave
    buttonSaveAs            = topButtonPanel.buttonSaveAs
    rightPanel              = bodyPanel.rightPanel
    scrollgridStages        = rightPanel.scrollgridStages
    btnStageAdd             = rightPanel.btnStageAdd
    btnStageRemove          = rightPanel.btnStageRemove
    btnTickUp               = rightPanel.btnTickUp
    btnTickDown             = rightPanel.btnTickDown
    scrollgridMissions      = rightPanel.scrollgridMissions
    btnMisAdd               = rightPanel.btnMisAdd
    btnMisRemove            = rightPanel.btnMisRemove
    invisiblePanel          = rightPanel.invisiblePanel
    btnCancel               = window.mainPanel.btnCancel 
    btnClose                = window.mainPanel.headPanel.btnClose
    
    secondPanel             = leftPanel.secondPanel
    editboxName             = secondPanel.editboxName
    clLocale                = secondPanel.clLocale
    eCampaignDesc           = leftPanel.thirdPanel.meditboxCampaignDescription
    edStageName             = invisiblePanel.edStageName
    edStageName_selected    = invisiblePanel.edStageName_selected
    
    editBoxIntervalSkin     = edStageName:getSkin()
    staticIntervalSkin      = invisiblePanel.stTblText_middle:getSkin()
    staticStagesGridCellSkin    = invisiblePanel.stTblText_middle:getSkin()
    stSelectedImgSkin           = stSelectedImg:getSkin()
    stSuccessUploadImgSkin      = stSuccessUploadImg:getSkin()
    stFailUploadImgSkin         = stFailUploadImg:getSkin()
    
    eRangeSkin_s  =  invisiblePanel.eRange_selected:getSkin()
    eRangeSkin  =  invisiblePanel.eRange:getSkin()
    eRangeSkin2_s  =  invisiblePanel.eRange_selected2:getSkin()
    eRangeSkin2  =  invisiblePanel.eRange2:getSkin()
    
    cellSkin1     = invisiblePanel.stTblText_middle:getSkin()
    cellSkin1s    = invisiblePanel.stTblText_middle_selected:getSkin()
    cellSkin2     = invisiblePanel.stTblText_left:getSkin()
    cellSkin2s    = invisiblePanel.stTblText_left_selected:getSkin()
    cellSkin3     = invisiblePanel.tbl_tick:getSkin()
    cellSkin3s    = invisiblePanel.tbl_tick_selected:getSkin()
    dt_selected   = invisiblePanel.dt_selected:getSkin()

    edStageNameSelSkin  = edStageName_selected:getSkin()
    edStageNameSkin     = edStageName:getSkin()
    stStaticMisSkin     = cellSkin2
	eSkipScoreSkin		= invisiblePanel.eSkipScore:getSkin()
	eSkipScoreSelSkin	= invisiblePanel.eSkipScoreS:getSkin()
    
    skinCell = 
    {
        [1] = 
        {
            cellSkin1s,edStageNameSelSkin,{[0] = cellSkin1s, [1] = cellSkin3s},
        },
        [0] =
        {
            cellSkin1,edStageNameSkin,{[0] = cellSkin1, [1] = cellSkin3},
        },    
    }
    
    skinCellM = 
    {
        [1] = 
        {
            cellSkin1s,cellSkin2s, eSkipScoreSelSkin
        },
        [0] =
        {
            cellSkin1,cellSkin2, eSkipScoreSkin
        },  		
    }
    
    local w, h = Gui.GetWindowSize()
    window:setBounds(0, 0, w, h)
    window.mainPanel:setBounds((w-1280)/2, (h-768)/2, 1280, 768)
    
    setupCallbacks()
    
    loadLocales()
end

function setupCallbacks()
    btnCancel.onChange = onButtonExit
    btnClose.onChange = onButtonExit

    buttonOpen.onChange         = onButtonCampaignOpen
    buttonNew.onChange          = onButtonCampaignNew
    btnMisAdd.onChange          = onButtonMissionAdd
    btnMisRemove.onChange       = onButtonMissionRemove
    btnTickUp.onChange          = onButtonStageUp
    btnTickDown.onChange        = onButtonStageDown
    btnStageAdd.onChange        = onButtonStageAdd
    btnStageRemove.onChange     = onButtonStageRemove
    buttonSave.onChange         = onButtonCampaignSave
    buttonSaveAs.onChange       = onButtonCampaignSaveAs
    buttonSuccessPic.onChange   = onButtonSuccessPic
    buttonFailedPic.onChange    = onButtonFailedPic
    ----window.missionsContainer.uniqueMissionCheckbox.onChange = onCheckboxUniqueMission
    buttonCampPic.onChange      = onButtonCampaignPicture
    clLocale.onChange           = onChangeClLocale
    
    window:addHotKeyCallback('escape', onButtonExit)    
    
    function scrollgridStages:onMouseDown(x, y, button)
      if 1 == button then
        local col, row = self:getMouseCursorColumnRow(x, y)
        
        if -1 < col and -1 < row then
          local cell = self:getCell(col, row)
          
          if cell then
            onGridStagesMouseDown(cell)
          end
        end
      end
    end
    
    function scrollgridMissions:onMouseDown(x, y, button)
      if 1 == button then
        local col, row = self:getMouseCursorColumnRow(x, y)
        
        if -1 < col and -1 < row then
          local cell = self:getCell(col, row)
          
          if cell then
            onGridMissionsMouseDown(cell)
          end
        end
      end
    end    
end

function loadLocales()
    local f = base.loadfile("MissionEditor/data/scripts/Langs.lua")
	local env = {}	
    locales = nil
    if f then
        base.setfenv(f, env)
        f()
        locales = env.locales
    end    
    
    function compareLocales(tab1, tab2)
        return tab1.locale < tab2.locale
    end
    
    table.sort(locales, compareLocales)

    function fillListLoacales(locales)
        local locale = i18n.getLocale()
        local firstItem
        for k,v in base.ipairs(locales) do
            local item = ListBoxItem.new(v.locale.." "..v.name)
            item.locale = v.locale
            clLocale:insertItem(item)
            
            if k == 1 then
                firstItem = item
            end
          
            if base.string.upper(locale) == item.locale then
                firstItem = item
            end
        end 
        clLocale:selectItem(firstItem)
    end
    
    if locales then
        fillListLoacales(locales)
    end
end

function onChangeClLocale(self)
    local selLocale = clLocale:getSelectedItem().locale
    
    currentCampaign.name            = currentCampaign["name_"..selLocale] or currentCampaign.name
    currentCampaign.description     = currentCampaign["description_"..selLocale] or currentCampaign.description
    currentCampaign.picture         = currentCampaign["picture_"..selLocale] or currentCampaign.picture
    currentCampaign.pictureFailed   = currentCampaign["pictureFailed_"..selLocale] or currentCampaign.pictureFailed
    currentCampaign.pictureSuccess  = currentCampaign["pictureSuccess_"..selLocale] or currentCampaign.pictureSuccess

    update()
end

function show(b, a_returnScreen)
	
    if (b) then 
		if not window then
			create()
		end
		
		returnScreen = a_returnScreen
        clearTempFolder()
        onButtonCampaignNew()
		Analytics.pageview(Analytics.CampaignBuilder)
    end   
	
    if window then
        window:setVisible(b)
    end

	if (b == false) and (returnScreen == 'editor') then		
		if base.MapWindow.isEmptyME() ~= true then
			base.MapWindow.show(true)
		else
			base.MapWindow.showEmpty(true)
		end	
	end
end

function update()
    editboxName:setText(currentCampaign.name)
    updateCampaignDescription(currentCampaign.description)
    updateStagesGrid()
    updateMissionsScrollgrid()
    updateCampaignPicture() 
    updateSuccessPicture() 
    updateFailedPicture() 
    
end

function updateCampaignPicture()
    local campaignPicture = currentCampaign.picture
    local filename
    
    if campaignPicture and campaignPicture ~= '' then
        if currentCampaign.directory then
            filename = currentCampaign.directory .. '/' .. campaignPicture
        else
            filename = base.tempCampaignPath .. '/' .. campaignPicture
        end
    else
        filename = "dxgui\\skins\\skinme\\images\\window\\campaing_builder\\bgnew.png"
    end
    
    setCampaignPicture(filename)
end

function updateSuccessPicture()
    local pictureSuccess = currentCampaign.pictureSuccess
    local filename
    
    if pictureSuccess and pictureSuccess ~= '' then
        if currentCampaign.directory then
            filename = currentCampaign.directory .. '/' .. pictureSuccess
        else
            filename = base.tempCampaignPath .. '/' .. pictureSuccess
        end
    else
        filename = 'dxgui\\skins\\skinme\\images\\window\\campaing_builder\\bgnew.png'
    end
    
    setSuccessPicture(filename)
end

function updateFailedPicture()
    local pictureFailed = currentCampaign.pictureFailed
    local filename
    
    if pictureFailed and pictureFailed ~= '' then
        if currentCampaign.directory then
            filename = currentCampaign.directory .. '/' .. pictureFailed
        else
            filename = base.tempCampaignPath .. '/' .. pictureFailed
        end
    else
        filename = 'dxgui\\skins\\skinme\\images\\window\\campaing_builder\\bgnew.png'
    end
    
    setFailedPicture(filename)
end

function clearControls()
    editboxName:setText('')
    
    scrollgridStages:clearRows()
    scrollgridMissions:clearRows()
end

function loadCampaign(filepath)
    if not filepath then return end      
    currentCampaign = nil
    
    local campaignDir = U.extractDirName(filepath)
    local f = assert(base.loadfile(filepath))
	
    if f then
		local env = {}
        base.setfenv(f, env)
		local ok, res = base.pcall(f)
		if not ok then
			log.error('ERROR: loadCampaignEditor failed to pcall "'..filepath..'": '..res)
			return
		end
        currentCampaign = env.campaign
        currentCampaign.directory = campaignDir
        currentCampaign.fullPath = filepath        
        for i, stage in pairs(currentCampaign.stages) do 
            --U.traverseTable(stage)
            for j, mission in pairs(stage.missions) do
                local fullPath = campaignDir .. mission.file
                if not isFileExist(fullPath) then
                    showError(cdata.file_not_found .. '(' .. fullPath .. ')')
                end
                mission.fullpath = fullPath
            end
        end
        ----------------------
        local selLocale = clLocale:getSelectedItem().locale
        currentCampaign.name = currentCampaign["name_"..selLocale] or currentCampaign.name
        currentCampaign.description = currentCampaign["description_"..selLocale] or currentCampaign.description
        currentCampaign.picture = currentCampaign["picture_"..selLocale] or currentCampaign.picture
        currentCampaign.pictureFailed = currentCampaign["pictureFailed_"..selLocale] or currentCampaign.pictureFailed
        currentCampaign.pictureSuccess = currentCampaign["pictureSuccess_"..selLocale] or currentCampaign.pictureSuccess
        
        -----------------
        
        
        local tmp
        
        tmp, currentStage = base.next(currentCampaign.stages)
        --U.traverseTable(currentStage)
        update()
    end
end

function saveCampaign(fName)
    local filepath = fName--U.fixPath(fName)
    
    local selLocale = clLocale:getSelectedItem().locale
  
    if not currentCampaign then return end
    local necessaryUnits = getNecessaryUnits(currentCampaign)
    currentCampaign.necessaryUnits = necessaryUnits
    currentCampaign.name = editboxName:getText()
    currentCampaign["name_"..selLocale] = editboxName:getText()
    currentCampaign.description = eCampaignDesc:getText()
    currentCampaign["description_"..selLocale] = eCampaignDesc:getText() 
    currentCampaign.version = VERSION
    currentCampaign["picture_"..selLocale] = currentCampaign.picture
    currentCampaign["pictureFailed_"..selLocale] = currentCampaign.pictureFailed
    currentCampaign["pictureSuccess_"..selLocale] = currentCampaign.pictureSuccess
 
 
    print('saving campaign', fName)
    local f = io.open(fName, 'w')
    if f then
        local s = S.new(f)
        s:serialize_simple2('campaign', currentCampaign)
        f:close()
	else
		MsgWindow.error(cdata.save_campaign_failed.." " .. fName, cdata.save_campaign, cdata.ok):show()
		return false
    end

    local campaignDir = U.extractDirName(filepath)

    for i, stage in pairs(currentCampaign.stages) do 
        for j, mission in pairs(stage.missions) do
            local misName = mission.file
            local fullPath = campaignDir .. misName
            local attr = lfs.attributes(fullPath)
            if not attr then
                local missionPath
                if currentCampaign.directory then -- кампания существующая, копируем в новое место
                    missionPath = currentCampaign.directory .. misName
                else -- кампания не сохранена, копируем из временной директории
                    missionPath = base.tempCampaignPath .. misName--U.fixPath(base.tempCampaignPath .. misName)
                end

                local mission = assert(io.open(missionPath, 'rb'))
                local data  = mission:read('*a')
                
				--тут ошибки при сохранении не обрабатываем, считаем что если файл кампании сохранился,
				--то и эти сохранятся
                local file, err = io.open(fullPath, 'wb')
                if file then
                    file:write(data)
                    file:close()
				else
					log.error('ERROR: save campaign failed: '..err)	
                end
                mission:close()
            end
        end
    end
    local dir = currentCampaign.directory
    currentCampaign.directory = campaignDir
    currentCampaign.fullPath = filepath
    if  (currentCampaign.picture ~= nil) and (currentCampaign.picture ~= '') then
        copyFile(dir, currentCampaign.picture)
    end
    if  (currentCampaign.pictureSuccess ~= nil) and (currentCampaign.pictureSuccess ~= '') then
        copyFile(dir, currentCampaign.pictureSuccess)
    end
    if  (currentCampaign.pictureFailed ~= nil) and (currentCampaign.pictureFailed ~= '') then
        copyFile(dir, currentCampaign.pictureFailed)
    end
    
    for k,v in base.ipairs(locales) do    
        if v.locale ~= selLocale then
            local keyPic = "picture_"..v.locale
            if currentCampaign[keyPic] ~= nil then            
                copyFile(dir, currentCampaign[keyPic])
            end
            
            local keySucc = "pictureSuccess_"..v.locale
            if currentCampaign[keySucc] ~= nil then            
                copyFile(dir, currentCampaign[keySucc])
            end
            
            local keyFail = "pictureFailed_"..v.locale
            if currentCampaign[keyFail] ~= nil then            
                copyFile(dir, currentCampaign[keyFail])
            end
        end
        
    end

	return true
end


function updateCampaignDescription(description)
    eCampaignDesc:setText(description)
end


function updateStagesGrid()
    scrollgridStages:clearRows()
    
    for i, stage in ipairs(currentCampaign.stages) do
        scrollgridStages:insertRow(rowHeight)
        
        local rowIndex = i - 1
        
        local isSel = 0 
        if currentStage == stage then 
            isSel = 1
        end 
        
        local isStart = 0
        if (rowIndex+1) == currentCampaign.startStage then 
            isStart = 1
        end
         
        local numCol = 0 
        
        ------1
        local cell = Static.new()
        cell:setSkin(skinCell[isSel][numCol+1])
        cell.data = {row = rowIndex, stage = stage}
      --  cell.onMouseDown = onGridStagesMouseDown
        scrollgridStages:setCell(numCol, rowIndex, cell)        
        numCol = numCol + 1 
        
        ------2
        cell = EditBox.new(stage.name)
        cell:setSkin(skinCell[isSel][numCol+1])
        cell.data = {row = rowIndex, stage = stage}
     --   cell.onFocus = onGridStagesFocus
        scrollgridStages:setCell(numCol, rowIndex, cell)
        numCol = numCol + 1 
        
         ------3
        cell = Static.new()
        cell:setSkin(skinCell[isSel][numCol+1][isStart])
        cell.data = {row = rowIndex, stage = stage}
        cell.setStart = true
    --    cell.onMouseDown = onGridStagesSetStart
        scrollgridStages:setCell(numCol, rowIndex, cell)
        numCol = numCol + 1 
         

        if currentStage == stage then 
            currentStageIndex = i
        end
    end
   
    if not currentStage then 
        scrollgridStages:selectRow(0)
        currentStage = currentCampaign.stages[1]
        currentStageIndex = 1
    else
        scrollgridStages:selectRow(currentStageIndex - 1)
    end
end


local function getSortedMissions()
    local stageIndex = scrollgridStages:getSelectedRow() + 1
    local stage = currentCampaign.stages[stageIndex]
    local missions = stage.missions
    
    table.sort(missions,function(p1,p2)
            local op1 = p1.interval[1] or 0
            local op2 = p2.interval[1] or 0
            if p1.interval[1] == p2.interval[1] then
                if p1.interval[2] == p2.interval[2] then
                    return p1.fullpath < p2.fullpath
                else
                    return p1.interval[2] < p2.interval[2]
                end    
            else
                return p1.interval[1] < p2.interval[1]
            end
        end
        )  
        
    return missions
end

local function getRowWidgets()
    local result = { 
        {
            widget = Static,
            skin = staticStagesGridCellSkin,
        },
        {
            widget = Static,
            skin = stStaticMisSkin,
        },                
        {
            widget = IntervalContainer,
            skin = nil,
        }, 
		{
            widget = EditBox,
            skin = eSkipScoreSkin,
			numeric = true,
			onChange = onChange_SkipScore
        },		
    }
    
    return result
end

local function createMissionsScrollgridRow(index, mission, widgetInfos)
    local intrevalStr = {tostring(mission.interval[1]) , tostring(mission.interval[2])}
    local text = {tostring(index), mission.file, intrevalStr, mission.skipScore}
    
    local select = false
    if currentMissionIndex == index-1 then
        select = true
    end
    
    for i, widgetInfo in ipairs(widgetInfos) do
        local widget = widgetInfo.widget.new()
        local skin = widgetInfo.skin

		if widgetInfo.numeric then
			widget:setNumeric(true)
		end
		
        if skin then
            if select == false then
                widget:setSkin(skin)
            else
                widget:setSkin(skinCellM[1][i])
            end 
        end  

		if widgetInfo.onChange then
			widget.onChange = onChange_SkipScore
		end
        
        widget:setText(text[i])

        local data = {row = index - 1, mission = mission, stage = stage}
        
        widget.data = data
        scrollgridMissions:setCell(i - 1, index - 1, widget)
    end
end

function updateMissionsScrollgrid()
    -- очищаем грид
    scrollgridMissions:clearRows() 

    local missions = getSortedMissions()
    local widgets = getRowWidgets()

    local currentMissionIndex = 1

    for i, mission in ipairs(missions) do
        scrollgridMissions:insertRow(rowHeight)
        
        createMissionsScrollgridRow(i, mission, widgets)
        
        if currentMission == mission then
            currentMissionIndex = i
        end
    end
    
    currentMission = missions[currentMissionIndex]   
    selectMission(currentMissionIndex - 1)
end


function onButtonCampaignNew() 
    clearTempFolder()
    clearControls()    
    currentCampaign = nil
    currentStage = nil
    currentMission = nil
    curFilePath = nil

    currentCampaign = {
        name = cdata.new_campaign, 
        description = '', 
        startStage = 1,
        stages = {
            [1] = {
                name = cdata.new_stage .. ' 1',
                missions = {}
                },
            },
        }
    editboxName:setText(currentCampaign.name)
    update()
end

function onButtonCampaignOpen()
	local path = MeSettings.getCampaignPath()
	local filters = {FileDialogFilters.campaign()}
	local filename = FileDialog.open(path, filters, cdata.openCampaign)
	
	if filename then
		loadCampaign(filename)
		MeSettings.setCampaignPath(filename)
        curFilePath = filename
	end 
end

local function saveCampaignDialog(caption)
    if not currentCampaign then return end
    if not checkIntervals() then return end
	
	local path = MeSettings.getCampaignPath()
	local filters = {FileDialogFilters.campaign()}
	local filename = FileDialog.save(path, filters, caption)
	
    if filename then
		if saveCampaign(filename) then
			MeSettings.setCampaignPath(filename)
            curFilePath = filename
		end
	end
end

function onButtonCampaignSave()
    if (curFilePath == nil) then
        saveCampaignDialog(cdata.saveCampaign)
    else
        if not currentCampaign then return end
        if not checkIntervals() then return end
        if saveCampaign(curFilePath) then
            MeSettings.setCampaignPath(curFilePath)
        end
    end
end

function onButtonCampaignSaveAs()
	saveCampaignDialog(cdata.saveCampaignAs)
end

function onButtonExit()
    currentCampaign = nil
    currentStage = nil
    currentMission = nil

	if returnScreen ~= 'editor' then
		base.mmw.show(true)
	end
    show(false)
end

function updateRowSkin(a_stageIndex)
    local isSel = 0 
    if currentStageIndex == (a_stageIndex + 1) then 
        isSel = 1
    end 
    
    local isStart = 0
    if (a_stageIndex+1) == currentCampaign.startStage then 
        isStart = 1
    end
        
    local cell = scrollgridStages:getCell(0, a_stageIndex)
    cell:setSkin(skinCell[isSel][1])
    
    cell = scrollgridStages:getCell(1, a_stageIndex)
    cell:setSkin(skinCell[isSel][2])
    
    cell = scrollgridStages:getCell(2, a_stageIndex)
    cell:setSkin(skinCell[isSel][3][isStart]) 
end

function selectStage(a_stageIndex, a_stage)
    local old_currentStageIndex = currentStageIndex
    
    currentStage = a_stage
    currentStageIndex = a_stageIndex + 1
    currentMission = nil
    
    updateRowSkin(old_currentStageIndex-1)
    updateRowSkin(a_stageIndex)
end

function onGridStagesMouseDown(cell, x, y, button)
    if cell.setStart == true then
        onGridStagesSetStart(cell)
    else    
        scrollgridStages:selectRow(cell.data.row)
        updateMissionsScrollgrid()
        selectStage(cell.data.row, cell.data.stage)
    end
end

function onGridStagesFocus(self, focused)
    if not currentCampaign then return end
    --print('onGridStagesFocus', focused, self.data.row )
    if focused then
        onGridStagesMouseDown(self)
    else 
        currentStage.name = assert(self:getText())
        local index, count  = self:getSelection()
        self:setSelection(index,0)
    end
end

function onGridStagesSetStart(cell)
    local old_startStage = currentCampaign.startStage

    currentCampaign.startStage = cell.data.row + 1
    updateRowSkin(cell.data.row)
    updateRowSkin(old_startStage-1)
end

function selectMission(a_indexRow)    
    scrollgridMissions:selectRow(a_indexRow)
end

function updateMissionRowSkin(a_Index, b_select)

    local cell = scrollgridMissions:getCell(0, a_Index)
    cell:setSkin(skinCellM[b_select][1])
    
    cell = scrollgridMissions:getCell(1, a_Index)
    cell:setSkin(skinCellM[b_select][2])
    
    cell = scrollgridMissions:getCell(2, a_Index)
    cell:setSkinSelect(b_select==1)
	
	cell = scrollgridMissions:getCell(3, a_Index)
    cell:setSkin(skinCellM[b_select][3])
end

function onGridMissionsMouseDown(self, x, y, button)
    local old_indexMission = scrollgridMissions:getSelectedRow()
    selectMission(self.data.row)
    --updateInterval()
    currentMission = self.data.mission
    
    updateMissionRowSkin(old_indexMission, 0)
    updateMissionRowSkin(self.data.row, 1)
end


function onButtonMissionAdd()
    if not currentCampaign then return end
	
	local path = MeSettings.getMissionPath()
	local filters = {FileDialogFilters.mission(), FileDialogFilters.all()}
	local filename = FileDialog.open(path, filters, cdata.addMission)
	
	if filename then
        local mission = {
            file = U.extractFileName(filename), 
		    interval = {0, 100}, 
            description = '',
            fullpath = filename,
			skipScore = 100,
        }

        table.insert(currentStage.missions, mission)
        currentMission = mission
        updateMissionsScrollgrid()    
        copyMission(filename)
		
		MeSettings.setMissionPath(filename)
	end
end

function onButtonMissionRemove()
    if not currentCampaign then return end
    if currentStage and (#currentStage.missions<1) then 
        return
    end
    local row = scrollgridMissions:getSelectedRow()
    local widget = scrollgridMissions:getCell(0, row)
    local mission = widget.data.mission
    for i = 1,#currentStage.missions do
        if currentStage.missions[i] == mission then 
            table.remove(currentStage.missions, i)
        end
    end
    currentMission = nil
    updateMissionsScrollgrid()
    --updateInterval()
end


function onIntervalStartFocus(self, focused)
    --print('onIntervalStartFocus', focused, self.container.data.row)
    if focused then
        intervalStartText = self:getText()
    else 
        if not checkInterval(self, 1) then
            self:setText(intervalStartText)
        end
        local index, count  = self:getSelection()
        self:setSelection(index,0)
    end
end

function onIntervalEndFocus(self, focused)
    --print('onIntervalEndFocus', focused, self.container.data.row)
    if focused then
        intervalEndText = self:getText()
    else 
        if not checkInterval(self, 2) then
            self:setText(intervalEndText)
        end
        local index, count  = self:getSelection()
        self:setSelection(index,0)
    end
end

function onButtonStageAdd()
    if not currentCampaign then return end
    local stage = {
        name = cdata.new_stage .. ' ' .. tostring(#currentCampaign.stages + 1), 
        missions = {}
        }
    table.insert(currentCampaign.stages, stage)
    currentStage = stage
    currentStageIndex = #currentCampaign.stages
    selectMission(currentStageIndex - 1)
    
    updateStagesGrid()
    updateMissionsScrollgrid()
    --updateInterval()
end

function onButtonStageRemove()
    if not currentCampaign then return end
    if #currentCampaign.stages == 1 then -- последняя ступень, удалять нельзя
        return
    end
    for i = 1, #currentCampaign.stages do 
        if currentCampaign.stages[i] == currentStage then
            table.remove(currentCampaign.stages, i)
            if #currentCampaign.stages < currentCampaign.startStage then
                currentCampaign.startStage = 1
            end
        end
    end
    currentStage = nil
    currentStageIndex = 0
    updateStagesGrid()
    updateMissionsScrollgrid()
    --updateInterval()

end


function onButtonStageUp()
    if not currentCampaign then return end
    if (currentStageIndex ~=1) and (currentStageIndex ~=0) then
        currentCampaign.stages[currentStageIndex - 1],currentCampaign.stages[currentStageIndex] = currentCampaign.stages[currentStageIndex],currentCampaign.stages[currentStageIndex-1]
        currentStageIndex  = currentStageIndex - 1
        currentStage = currentCampaign.stages[currentStageIndex]
        scrollgridStages:selectRow(currentStageIndex - 1)
        updateStagesGrid()
        updateMissionsScrollgrid()
        --updateInterval()
    end
end

function onButtonStageDown()
    if not currentCampaign then return end
    if (currentStageIndex ~= #currentCampaign.stages) and (currentStageIndex ~=0)then
        currentCampaign.stages[currentStageIndex + 1],currentCampaign.stages[currentStageIndex] = currentCampaign.stages[currentStageIndex],currentCampaign.stages[currentStageIndex+1]
        currentStageIndex  = currentStageIndex + 1
        currentStage = currentCampaign.stages[currentStageIndex]
        scrollgridStages:selectRow(currentStageIndex - 1)
        updateStagesGrid()
        updateMissionsScrollgrid()
        --updateInterval()
    end
end

function showError(text)
    local caption = cdata.message
    local buttonText = cdata.ok
    
    MsgWindow.error(text, caption, buttonText):show()
end

function checkInterval(widget, intervalInd)
    if not currentCampaign then return end
    if not currentMission then return end
    
    local number = tonumber(widget:getText())
    if number then
        if (number >= 0) and (number <= 100) then 
            currentMission.interval[intervalInd] = number
            --print('check passed, new value', number, 'for', intervalInd,'curr Mission', currentMission)
            --updateMissionsScrollgrid()
            return true
        else
            showError(cdata.msg_interval_out_of_range)
            return false
        end                
    else
        showError((cdata.msg_interval_error .. '"' .. widget:getText() .. '"'))
        return false
    end
    --widget:setText( tostring(currentMission.interval[intervalInd]) )
end

function checkIntervals()
    local print = print
    for i = 1, #currentCampaign.stages do -- идем по всем ступеням
        local intervals = {} -- создаем массив интервалов
        if #currentCampaign.stages[i].missions ~= 0 then 
            for j = 1, #currentCampaign.stages[i].missions do -- переписываем интервалы в массив интервалов
                                                                -- попутно меняя местами границы интервала, если нужно
                local interval = currentCampaign.stages[i].missions[j].interval
                if interval[1] > interval[2] then -- swap 
                    interval[1], interval[2] = interval[2], interval[1]
                end
                table.insert(intervals, interval)
            end
            -- сортируем интервалы по возрастанию левой границы
            table.sort(intervals, function(p1, p2) return p1[1] < p2[1] end)
            --local interval  = intervals[1] -- первый интервал списка, он же общий интервал ступени
            local interval = {}
            interval[1] = intervals[1][1] -- первый интервал списка, он же общий интервал ступени
            interval[2] = intervals[1][2] -- первый интервал списка, он же общий интервал ступени
            -- просматрваем все интервалы со 2-ого
            local counter = 2
            while counter <= #intervals do -- 
                --print('counter =', counter) 
                local curr_interval = intervals[counter]
                if interval[2] >= (curr_interval[1] - 1) then --интервалы пересекаются
                    --print('interval[2] >= (curr_interval[1] - 1)', interval[2] , (curr_interval[1] - 1))
                    -- правая граница общего интервала больше левой границы текущего интервала
                    if interval[2] <= curr_interval[2] then 
                        --print('interval[2] <= curr_interval[2]',interval[2] , curr_interval[2])
                        -- правая граница общего интервала меньше правой границы текущего  интервала
                        -- расширяем общий интервал 
                        interval[2] = curr_interval[2]
                    end
                    -- удаляем текущий интервал, т.к. он уже объединен в общий
                    table.remove(intervals,counter)
                    --print('',)
                elseif interval[2] >= curr_interval[2] then -- интервалы пересекаются
                    print('interval[2] >= curr_interval[2]',interval[2] , curr_interval[2])
                    -- правая граница общего интервала больше правой границы текущего интервала
                    -- текущий интервал целиком лежит в общем
                    --interval[2] = curr_interval[2]
                    table.remove(intervals,counter)
                    --print('',)
                else  --интервалы не пересекаются
                    -- interval = curr_interval
                    -- counter = counter + 1
                    --print('intervals does not intersect')
                    local msg = ' (' .. currentCampaign.stages[i].name .. ')'
                    showError(cdata.msg_interval_has_holes .. msg)
                    return false
                end
            end

            -- if #intervals > 1 then
            -- end
            -- проверяем перекрывают ли интервалы кампаний интервал [0..100]
            --print('interval ',interval[1] ,interval[2])
            if (interval[1] ~= 0) or (interval[2] ~= 100) then
                local msg = ' (' .. currentCampaign.stages[i].name .. ') [' .. tostring(interval[1]) .. '..' .. tostring(interval[2]) .. ']'
                showError(cdata.msg_interval_incomplete .. msg)
                return false
            end
        else
            local msg = ' (' .. currentCampaign.stages[i].name .. ')'
            showError(cdata.msg_interval_incomplete .. msg)
            return false
        end        
    end
    return true
end

function copyMission(filepath)
    local dirName
    if currentCampaign.directory then
        dirName = currentCampaign.directory
    else
        dirName = base.tempCampaignPath
    end
    
    --print('opening mission for copy', filepath)
    local mission = assert(io.open(filepath, 'rb'))
    local data  = mission:read('*a')
    
    local filename = U.extractFileName(filepath)
    
    local fullPath = dirName .. filename
    
    local attr = lfs.attributes(fullPath)
    if attr and attr.mode == 'file' then        
        mission:close()
        return
    end
    
    local file, err = io.open(fullPath, 'wb')
    if file then
        --print('saving '..fullPath)
        file:write(data)
        file:close()
	else
		log.error('ERROR: copy mission campaign failed: '..err)	
    end
    mission:close()
end

function copyFile(dir, fileName)
    if (dir ~= nil) then
        copyPicture(dir .. '/' .. fileName)
    else
        --копирование в темп не проверяем
        copyPicture(base.tempCampaignPath .. '/' .. fileName)    
    end
end

function copyPicture(filepath)
    local dirName
	
    if currentCampaign.directory then
        dirName = currentCampaign.directory
    else
        dirName = base.tempCampaignPath
    end
    
    local infile = assert(io.open(filepath, 'rb'))
    local data  = infile:read('*a')
    local filename = U.extractFileName(filepath)
    local fullPath = dirName .. filename
    
    local attr = lfs.attributes(fullPath)
    if attr and attr.mode == 'file' then
        infile:close()
        return true, filename
    end
    
    local file = io.open(fullPath, 'wb')
    if not file then return false end

	print('saving '..fullPath)
	file:write(data)
	file:close()
	
	return true, filename
end

function clearTempFolder()
    local function eraseFolder(folder)
        for file in lfs.dir(folder) do
            local a = assert(lfs.attributes(folder .. '/' .. file))
            if (a.mode == 'directory') and (file ~= '.') and (file ~= '..') then
                eraseFolder(folder .. '/' .. file)
                lfs.rmdir(folder .. '/' .. file)
            elseif a.mode == 'file' then
                base.os.remove(folder .. '/' .. file)
            end
        end
    end

    local a
    local dir = base.tempCampaignPath
    
    if not lfs.dir(dir)() then
        print('creating temporary dir '..dir)
        lfs.mkdir(dir)
    end
    
    eraseFolder(dir)
end

function isFileExist(fullPath)
    local attr = lfs.attributes(fullPath)
    if not attr then
        return false
    else
        if 'file' == attr.mode then
            return true
        else
            return false
        end
    end
end


    
function setCampaignPicture(filename)  
	Gui.ReloadTexture(filename)
    stSelectedImg:setSkin(SkinUtils.setStaticPicture(filename, stSelectedImgSkin))
end

function setSuccessPicture(filename) 
	Gui.ReloadTexture(filename)
    stSuccessUploadImg:setSkin(SkinUtils.setStaticPicture(filename, stSuccessUploadImgSkin))
end

function setFailedPicture(filename)   
	Gui.ReloadTexture(filename)
    stFailUploadImg:setSkin(SkinUtils.setStaticPicture(filename, stFailUploadImgSkin))
end

function onButtonCampaignPicture(self)
	local path = MeSettings.getImagePath()
	local filters = {FileDialogFilters.image()}
	local filename = FileDialog.open(path, filters, cdata.openPicture)
	
	if filename then
        local res, fileNameShort = copyPicture(filename)
        if res then
            currentCampaign.picture = fileNameShort
			setCampaignPicture(filename)
			MeSettings.setImagePath(filename)
		else
			MsgWindow.error(cdata.save_campaign_failed.." " .. filename, cdata.save_campaign, cdata.ok):show()
		end
	end
end

function onButtonSuccessPic(self)
    local path = MeSettings.getImagePath()
	local filters = {FileDialogFilters.image()}
	local filename = FileDialog.open(path, filters, cdata.openPicture)
	
	if filename then
        local res, fileNameShort = copyPicture(filename)
        if res then
            currentCampaign.pictureSuccess = fileNameShort
			setSuccessPicture(filename)
			MeSettings.setImagePath(filename)
		else
			MsgWindow.error(cdata.save_campaign_failed.." " .. filename, cdata.save_campaign, cdata.ok):show()
		end
	end
end

function onButtonFailedPic(self)
    local path = MeSettings.getImagePath()
	local filters = {FileDialogFilters.image()}
	local filename = FileDialog.open(path, filters, cdata.openPicture)
	
	if filename then
        local res, fileNameShort = copyPicture(filename)
        if res then
            currentCampaign.pictureFailed = fileNameShort
			setFailedPicture(filename)
			MeSettings.setImagePath(filename)
		else
			MsgWindow.error(cdata.save_campaign_failed.." " .. filename, cdata.save_campaign, cdata.ok):show()
		end
	end
end
 
function getNecessaryUnits(a_currentCampaign)
    local necessaryUnits = {}
    for k,stage in base.pairs(a_currentCampaign.stages) do
        for kk, mission in base.pairs(stage.missions) do
            local type = getTypePlayerUnit(mission.fullpath)
            if type then
                necessaryUnits[type] = type
            end
        end
    end
    return necessaryUnits
end

function getTypePlayerUnit(a_fullpath)
    local zipFile, err = minizip.unzOpen(a_fullpath, 'rb') 
    if zipFile == nil then 
        base.print("Can not read file " .. a_fullpath .. '\n' .. (err or ''), 'Error');
        return false;
    end;

    local misStr
    if zipFile:unzLocateFile('mission') then
        misStr = zipFile:unzReadAllCurrentFile(false)
    end
    zipFile:unzClose()

    local fun, errStr = base.loadstring(misStr)
    if not fun then
        print("error loading campaign mission".. a_fullpath, errStr)
        return false
    end
    
    local env = { }
    base.setfenv(fun, env)
    fun()
    mission = env.mission
    
    
    for k,coalition in base.pairs(mission.coalition) do
        for kk,country in base.pairs(coalition.country) do           
            if country.plane and country.plane.group then 
                local result = gettUnitType(country.plane.group)
                if result then
                    return result
                end    
            end
            
            if country.helicopter and country.helicopter.group then 
                local result = gettUnitType(country.helicopter.group)
                if result then
                    return result
                end                 
            end
        end    
    end
    return
end

function gettUnitType(a_groups)
    for kkk,group in base.pairs(a_groups) do
        for kkkk, unit in base.pairs(group.units) do  
            if unit.skill == "Player" then  
                return unit.type
            end
        end
    end
end

function onChange_SkipScore(self)
	local value = base.tonumber(self:getText())
	if value == nil or value > 100 then
		value = 100
	end
	self.data.mission.skipScore = value
	self:setText(value)
end