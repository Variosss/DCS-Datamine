local base = _G

module('me_training')

local require       = base.require
local print       	= base.print
local tostring      = base.tostring
local ipairs        = base.ipairs
local pairs         = base.pairs
local string        = base.string
local table         = base.table

local ListBoxItem   = require('ListBoxItem')
local MissionModule = require('me_mission')
local i18n          = require('i18n')
local lfs           = require('lfs')
local Tools         = require('tools')
local videoPlayer   = require("me_video_player")
local Skin          = require('Skin')
local mod_updater   = require('me_updater')
local MsgWindow     = require('MsgWindow')
local MeSettings	= require('MeSettings')
local Static        = require('Static')
local UC			    = require('utils_common')
local TheatreOfWarData  = require('Mission.TheatreOfWarData')
local DialogLoader	= require('DialogLoader')
local Gui           = require('dxgui')
local textutil 		= require('textutil')
local Grid          = require('Grid')
local GridHeaderCell= require('GridHeaderCell')
local Panel         = require('Panel')
local Analytics		= require("Analytics")
local waitScreen   	= require('me_wait_screen')
local ProductType	= require('me_ProductType') 
local mod_dictionary    = require('dictionary')

i18n.setup(_M)

local listBoxItemTaskSkin = Skin.listBoxItemTrainingTaskSkin()
local listBoxItemLessonSkin = Skin.listBoxItemTrainingLessonSkin()

local tblTrainingDataById = {}
local dynPanels = {}
local curGrid

cdata = {
    Training_cap    = _('TRAINING'),
    leftBtn         = _('CANCEL'),
    rightBtn        = _('START'),
    
    trainingTask    = _('Training Task'),
    description     = _('Description'),
    lessons         = _('Lessons'),
    download        = _('Install'),
    delete          = _('DELETE'),
    cancel          = _('CANCEL'),
    deleteMsg       = _('Are you sure to delete training lessons?'),
    installToolTip  = _('Install training videos'),
    Modules         = _("Modules"),
	AddMission		= _("Missions with"),
	Name			= _("Name_training", "Name"),
	Map				= _("Map_training", "Map"),
	need_modules 	= _('Need modules for load mission: '),
}


curLesson = 0
curCLSID  = -1	
compId = ""
compIds = nil
local offsetY = 0


local function create_()
    window = DialogLoader.spawnDialogFromFile("MissionEditor/modules/dialogs/me_training_dialog.dlg", cdata)
	
	containerMain = window.containerMain
	
	panelNoVisible = window.panelNoVisible
	spLesson = containerMain.spLesson
    gridLessons = containerMain.spLesson.gridLessons
    editBoxDescription = containerMain.editBoxDescription
	downloadBtn = containerMain.panelBtn.downloadBtn
    deleteBtn = containerMain.panelBtn.deleteBtn
    listModuls = containerMain.listModuls
    listModuls.onChange = onListModulsChange
	
	curGrid = gridLessons
    
    listBoxModulItemSkin = window.listBoxModulItem:getSkin()
    
    nameCellSkin = window.staticNameCell:getSkin()
    nameHoverCellSkin = window.staticNameHoverCell:getSkin()
    nameSelectedCellSkin = window.staticNameSelectedCell:getSkin()
	headerSkin = panelNoVisible.gridHeader:getSkin()
	gridAddLessonsSkin = panelNoVisible.gridAddLessons:getSkin()
	sHeaderAddLessonsSkin = panelNoVisible.sHeaderAddLessons:getSkin()
	widgetAddMSkin = panelNoVisible.widgetAddM:getSkin()
	widgetModuleSkin = panelNoVisible.widgetModule:getSkin()
	
	rightBtn = containerMain.footerPanel.rightBtn
    leftBtn = containerMain.footerPanel.leftBtn
    btnClose = containerMain.headPanel.btnClose
	
    video_win = videoPlayer.create()
    
    setupCallbacks()    
	
	trainingDir = nil
	updateData()
    fillModulesCombo() 
    resize()    
end

function resize()
    w, h = Gui.GetWindowSize()
    
    window:setBounds(0, 0, w, h)
    containerMain:setBounds((w-1280)/2, (h-768)/2, 1280, 768)
end

function updateDownload(a_data)
    if a_data.id == nil then
		downloadBtn:setVisible(false)
        deleteBtn:setVisible(false)
		return
	end
	
    compId  = tblTrainingDataById[a_data.id].training_id
	if a_data.loc_training then
        downloadBtn:setText(cdata.download.." ("..a_data.loc_training..")")
    end

    if (ProductType.getOpt('enableTrainingLinks') == false) then
        downloadBtn:setVisible(false)
        deleteBtn:setVisible(false)
    else
        compIds = mod_updater.getInstalledComponents(tblTrainingDataById[a_data.id].training_ids)
        local bVisibleDelBtn = compIds ~= nil and compIds ~= ""
       -- downloadBtn:setVisible(compId ~= nil and not(bVisibleDelBtn))  
		downloadBtn:setVisible(false)    
        deleteBtn:setVisible(bVisibleDelBtn)
    end
end

--
function compTable(tab1, tab2)
	if (tab1.keySort < tab2.keySort) then
		return true
	end
	
	return false
end

function getModulMissionsData(plugin)
	local result
	local pluginMissions = plugin.Missions
	
	if pluginMissions and base.type(pluginMissions) == "table" then
		for missionName, mission in pairs(pluginMissions) do
			local name = plugin.id .. missionName
			local training_id
			local enable = false
			local loc_training 
			local dir
			dir = plugin.dirName.."/Missions/Training"
			local a, err 		= lfs.attributes(dir)
			if (a and (a.mode == 'directory')) then
				enable = true 
			else
				dir = plugin.dirName.."/Missions/"..locale.."/Training"
				local dirEN = plugin.dirName.."/Missions/EN/Training"
				local a, err 		= lfs.attributes(dir)
				local aEN, errEN 	= lfs.attributes(dirEN)
				if (a and (a.mode == 'directory')) then
					enable = true
				elseif (mission.training_ids and mission.training_ids[locale]) then
					enable = true
					training_id = mission.training_ids[locale]
					loc_training = locale
				elseif aEN and (aEN.mode == 'directory') then
					dir = dirEN
					enable = true                            
				end 
			end

			if enable == false and mission.training_ids and mission.training_ids['EN'] then
				enable = true
				training_id = mission.training_ids['EN']
				loc_training = 'EN'
			end 

			if dir and enable == true then
				result = {}
				result.CLSID = name
				result.id = plugin.id
				result.training_ids = mission.training_ids
				result.training_id = training_id
				result.loc_training = loc_training
				result.dir = base.string.gsub(dir, '/', '\\')
				result.loc_training = loc_training
				result.shortName = _(plugin.shortName)
				
				for pluginSkinName, pluginSkin in pairs(plugin.Skins) do	
					result.pathPl = plugin.dirName.."/"..pluginSkin.dir                    
				end 
			end 
		end
	end  
	
	return result
end

function addAttachModulMissionsData(plugin)
	local result
	local attachMissionsToMods = plugin.attachMissionsToMods

	if attachMissionsToMods then
		for k,v in base.pairs(attachMissionsToMods) do
			tblTrainingAttachDataById[k] = {}
			tblTrainingAttachDataById[k][plugin.id] = {}
			tblTrainingAttachDataById[k][plugin.id].dir = plugin.dirName.."/"..v.MissionsDir.."/Training"
			tblTrainingAttachDataById[k][plugin.id].name = v.name
		end
	
	end
end

function updateData()
	locale = base.string.upper(i18n.getLocale())
	tblTrainingDataById = {} -- таблица каталогов обучения по id модуля
	tblTrainingAttachDataById = {}-- таблица каталогов обучения добавленныеиз других модулей по id куда добавляются
	tblTrainingData = {} -- таблица каталогов обучения в массиве упорядоченном по локализованному shortName модуля

	for pluginName, plugin in pairs(base.plugins) do
        if plugin.applied == true then
			if plugin.Skins ~= nil then
				tblTrainingDataById[plugin.id] = getModulMissionsData(plugin)
			end
			addAttachModulMissionsData(plugin)
			base.table.insert(tblTrainingData, tblTrainingDataById[plugin.id])
        end  	
    end    
	
	local function compTable(tab1, tab2)
        return textutil.Utf8Compare(tab1.shortName, tab2.shortName)
    end
	
	base.table.sort(tblTrainingData, compTable)
end

function fillModulesCombo()	
    listModuls:clear()
	
	for k, data in pairs(tblTrainingData) do
		local listItem = ListBoxItem.new(data.shortName) 
		listItem.data = {}
		listItem.data.CLSID = data.CLSID
		listItem.data.id = data.id
		listItem:setSkin(listBoxModulItemSkin)
		if data.pathPl then
			local SkinItem = listItem:getSkin()
			local filename = data.pathPl..'\\icon 76x76.png'
			if lfs.attributes(filename)	== nil then
				filename = 'dxgui\\skins\\skinME\\images\\default-76x76.png'
			end
			SkinItem.skinData.states.released[1].picture.file = filename
			SkinItem.skinData.states.released[2].picture.file = filename
			SkinItem.skinData.states.hover[1].picture.file = filename
			SkinItem.skinData.states.hover[2].picture.file = filename
			listItem:setSkin(SkinItem)
		end
		listModuls:insertItem(listItem)	
	end
	    
end

function addGrid(dir, shortName, addId)
	local panel =  Panel.new()
	
	local sHeaderAddLessons = Static.new()
	sHeaderAddLessons:setSkin(sHeaderAddLessonsSkin)
	sHeaderAddLessons:setBounds(0,0,640,34)
	panel:insertWidget(sHeaderAddLessons)
	
	local sAddM = Static.new()
	sAddM:setSkin(widgetAddMSkin)	
	sAddM:setText(cdata.AddMission)
	panel:insertWidget(sAddM)
	local widthAddM, tmp = sAddM:calcSize()
	sAddM:setBounds(0,0,widthAddM,34)
	
	
	local sModule = Static.new()
	sModule:setSkin(widgetModuleSkin)
	sModule:setBounds(widthAddM+10,0,500,34)
	sModule:setText(shortName)
	panel:insertWidget(sModule)
		
	offsetY = offsetY + 34	
	panel:setPosition(0,offsetY)
	offsetY = offsetY + 29

	local grid = Grid.new() 
	grid.addId = addId
	panel.grid = grid
	grid:setSkin(gridAddLessonsSkin)
	
	local gridHeaderName = GridHeaderCell.new()
    gridHeaderName:setSkin(headerSkin) 
	gridHeaderName:setText(cdata.Name)	
    grid:insertColumn(489,gridHeaderName)
	
	local gridHeaderMap = GridHeaderCell.new()
    gridHeaderMap:setSkin(headerSkin) 
	gridHeaderMap:setText(cdata.Map)		
    grid:insertColumn(151, gridHeaderMap)
	
	panel:insertWidget(grid)
	loadDir(dir) 
	local sizeGridY = fillLessons(grid, dir)
	grid:setPosition(0,34)
	grid:setSize(640,sizeGridY)
	panel:setSize(640,sizeGridY+34)
	offsetY = offsetY + sizeGridY+34
	
	spLesson:insertWidget(panel)
	setupCallbacksAddGrid(grid)  
	
	return panel
end

function fillAttachModulMissions(id)
	local attachModulMissions = tblTrainingAttachDataById[id]
	
	for k,v in base.pairs(dynPanels) do
		spLesson:removeWidget(v)
	end
	dynPanels = {}
	
	if attachModulMissions then
		for id,v in base.pairs(attachModulMissions) do
			base.table.insert(dynPanels,addGrid(v.dir, v.name, id))	
		end
	end

	spLesson:updateWidgetsBounds()
end

function onListModulsChange(self, item)    

	loadDir(tblTrainingDataById[item.data.id].dir)    
    curCLSID = item.data.CLSID
	offsetY = 0
    offsetY = offsetY + fillLessons(gridLessons, tblTrainingDataById[item.data.id].dir)
	fillAttachModulMissions(tblTrainingDataById[item.data.id].id)
    selectLesson(0)
	
	updateDownload(item.data)
end

-- —формировать список обучающих тем и миссий.
function loadDir(dirName)
	lessons = {}
	local numTask = 1

    if not dirName then
        return
    end    
    
	local env = {}
	env._ = _
	local f, err = base.loadfile(dirName.."\\lessons.lua")
	if f == nil then
		print(err)
	else
		base.setfenv(f, env)
		local ok, res = base.pcall(f)
		if not ok then
			log.error('ERROR: loadMissions() failed to pcall "'..dirName.."\\lessons.lua"..'": '..res)
			return
		end

		if env == nil then
			print('Error loading ' .. dirName.."\\lessons.lua")
		else
			lessons = env.lessons
		end
	end 
end

function isEmptyTable(tab)
	for _, _ in base.pairs(tab) do
		return false
	end
	return true
end

function isValidateMission(mis)
	if (mis.file == nil) then
		return false
	end
	return true
end


function setupCallbacks()
    downloadBtn.onChange = onButtonDownload
    deleteBtn.onChange = onButtonDelete
    leftBtn.onChange = onButtonBack
    rightBtn.onChange = onButtonStart
    btnClose.onChange = onButtonBack

    window:addHotKeyCallback('escape', onButtonBack)
    window:addHotKeyCallback('return', onButtonStart)    
    
    setupCallbacksAddGrid(gridLessons)  
end



function selectRowMove(grid, rowIndex)
	local nameCell = grid:getCell(0, rowIndex)    

	if nameCell and grid:getSelectedRow() ~= rowIndex then
		nameCell:setSkin(nameHoverCellSkin)

		local statusCell = grid:getCell(1, rowIndex)
		statusCell:setSkin(nameHoverCellSkin)
	end
end 

function unSelectRow(grid, rowIndex)
    local nameCellLast = grid:getCell(0, rowIndex)
    
    if nameCellLast then
		nameCellLast:setSkin(nameCellSkin)
        grid:getCell(1, rowIndex):setSkin(nameCellSkin)
	end
end

local function getCurGrid(a_addId)
	for k,v in base.pairs(dynPanels) do
		if v.grid.addId == a_addId then
			return v.grid
		end
	end
end

function selectLesson(a_index, a_addId)
	curGrid = getCurGrid(a_addId) or gridLessons

    if a_index ~= nil and curGrid:getRowCount() > a_index then
        curGrid:selectRow(a_index)
        rowLast = a_index
        
        local nameCell = curGrid:getCell(0, a_index)  
        if nameCell then
            setDescriptionText(nameCell.data.description)     
        end    
    end    
end

function onButtonDownload()
    mod_updater.installComponent(compId)
end

function onButtonDelete()
    local handler = MsgWindow.question(cdata.deleteMsg, cdata.delete, cdata.delete, cdata.cancel)
		
    function handler:onChange(buttonText)
        if buttonText == cdata.delete then
            if compIds and compIds ~= "" then
                mod_updater.uninstallComponent(compIds)
            end
        end		
    end	
    
    handler:show()      
end

function onButtonBack()
    if (videoPlayer.isVisible() == true) then
        videoPlayer.onExit()
    else
        show(false)
        base.mmw.show(true)
    end
end

function onButtonStart()    
    --base.mmw.show(true)
    local item = curGrid:getCell(0, curGrid:getSelectedRow())
	if (item == nil) then
		base.print("item == nil")
		return
	end	
    
    --show(false)
    
    local file = item.data.file
    local path = item.data.path .. '/' .. file
    
	MeSettings.setLastTraining(curCLSID, curLesson, curGrid.addId)
    
    local posPoint = base.string.find(file, '.', 1, 1) 
	local type = base.string.sub(file, posPoint + 1)
	
	local TestFile = base.io.open(path, 'rb')
    if TestFile then
        TestFile:close()
		
		
		
        if (type ~= 'trk') and (type ~= 'miz') then
            base.music.stop()
            videoPlayer.show(true, path)            
        else
			local desc, requiredModules = mod_dictionary.getMissionDescription(path, i18n.getLocale())	
			
			if requiredModules and base.next(requiredModules) then
				local txtMsg = cdata.need_modules
				local enable = false
				for k,v in pairs(requiredModules) do            
					if (base.enableModules[v] ~= true) then
						txtMsg = txtMsg .." ".. v .. "\n"
						enable = true
					end
				end  

				if enable then
					MsgWindow.warning(txtMsg,  _('WARNING'), 'OK'):show()
					return false
				end
			end
	
            base.music.stop()
			waitScreen.setUpdateFunction(function()
				MissionModule.play({ file = path, command = '--training'},'training', "", true, nil, true)
			end)
            show(false)
        end
    else
       -- show(true)
    end
end


function setStartLesson(a_curLesson, a_CLSID, a_addId)
	trainingDir = nil
	local i = 0
	local data = {}
	local firstTrainingData = nil
	local CLSID = a_CLSID

	for i=0,listModuls:getItemCount()-1 do	
        local item = listModuls:getItem(i)
		if firstTrainingData == nil then
			firstTrainingData 		= {}
			firstTrainingData.CLSID 	= item.data.CLSID
            firstTrainingData.id	= item.data.id
            firstTrainingData.item  = item
		end

		if (item.data.CLSID == CLSID) then
            data.id	= item.data.id
            data.item           = item
		end
	end

	if (firstTrainingData ~= nil) then
		if (data.id == nil) then
            data.id	 = firstTrainingData.id 
            data.item = firstTrainingData.item 
			CLSID = firstTrainingData.CLSID			
		end
		if (data.id ~= nil) then
			listModuls:selectItem(data.item)
            listModuls:setItemVisible(data.item)
			
            loadDir(tblTrainingDataById[data.id].dir) 
			offsetY = 0	
            offsetY = offsetY + fillLessons(gridLessons, tblTrainingDataById[data.id].dir)
			fillAttachModulMissions(data.id)
            selectLesson(a_curLesson, a_addId)            
		end	
	end

	updateDownload(data)
end


function setDescriptionText(text)
    text = (text or "")..'\n'
    editBoxDescription:setText(text)
end

function show(b)
    if b then
        if not window then    
            create_()
        end    
        
		curCLSID, curLesson, addId = MeSettings.getLastTraining()
		curCLSID	= curCLSID or -1
		curLesson	= curLesson or 0

        setStartLesson(curLesson, curCLSID, addId)
		Analytics.pageview(Analytics.Traning)
		-- при показе окна таблица уроков получает фокус по умолчанию.
		if gridLessons then
			gridLessons:setFocused(b)
		end
    end
	
    if window then
        window:setVisible(b)
    end
end

function fillLessons(a_grid, a_path)
    a_grid:clearRows()  
    setDescriptionText("")   
	local sizeY = 0
    
    if lessons == nil then
        return
    end
    
    local rowHeight = 18
    local rowIndex = 0 
    
    for i, lesson in base.ipairs(lessons) do 
        local ext = UC.getExtension(a_path.."\\"..lesson.file)
        local bNoMis = false
        if ext ~= "miz" and ext ~= "trk" then
            bNoMis = true
        end

		local validFile = false
		local theatreName, sortie, description
		if bNoMis == true then
			theatreName = ""
			sortie = lesson.name or lesson.file
			description = lesson.description or ""
			validFile = true
		else
			local data = UC.getMissionData(a_path.."\\"..lesson.file, i18n.getLocale())
			if data ~= nil then 
				theatreName, sortie, description = data.theatreName, data.sortie, data.desc
				validFile = true	
			end
		end
		
		if sortie == "" then
			sortie = lesson.file
		end
		
		if validFile == true then 
			if bNoMis == true or TheatreOfWarData.isEnableTheatre(theatreName) == true then            
				a_grid:insertRow(rowHeight)
				local lessonCell = Static.new(lesson.name or sortie)
				lessonCell:setSkin(nameCellSkin)
				lessonCell:setTooltipText(lesson.name or sortie)
				a_grid:setCell(0, rowIndex, lessonCell)
				lessonCell.data = {row = rowIndex, description = lesson.description or description, file = lesson.file, path = a_path} 
				local lessonCell2 = Static.new(_(theatreName))
				lessonCell2:setSkin(nameCellSkin)
				a_grid:setCell(1, rowIndex, lessonCell2)            
				rowIndex = rowIndex + 1
			end
		end
    end
		
	sizeY = rowIndex*(rowHeight+1) + 30
	a_grid:setSize(640,rowIndex*(rowHeight+1) + 30)
	return sizeY
end

local function onSelectRow(grid, row)
	local cell = grid:getCell(0, row)

	if cell then
		setDescriptionText(cell.data.description)
		curLesson = row
		curGrid = grid
		
		return true
	end
	
	return false
end

function setupCallbacksAddGrid(a_grid)  
	function a_grid:onMouseDown(x, y, button)
		if 1 == button then
			local col, row = self:getMouseCursorColumnRow(x, y)
			
			if -1 < col and -1 < row then
				self:selectRow(row)  
			end
			
			onSelectRow(self, row)
		end
    end 
	
	function onMouseDoubleDown(self, x, y, button)
		if 1 == button then
			
			local col, row = self:getMouseCursorColumnRow(x, y)
			
			if -1 < col and -1 < row then
				self:selectRow(row)  
			end
            
			if onSelectRow(self, row) then
				onButtonStart()
			end
		end
    end 
	
	a_grid:addMouseDoubleDownCallback(onMouseDoubleDown)
	
	a_grid:addHoverRowCallback(function(grid, currHoveredRow, prevHoveredRow)
		if -1 < prevHoveredRow then
			unSelectRow(grid, prevHoveredRow)
		end
		
		if -1 < currHoveredRow then
			selectRowMove(grid, currHoveredRow)
		end	
	end)	
	
	a_grid:addSelectRowCallback(function(grid, currSelectedRow, prevSelectedRow)
		unSelectRow(grid, prevSelectedRow)
		onSelectRow(grid, currSelectedRow)
	end)
end