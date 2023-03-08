local base = _G

module('me_encyclopedia')

local require = base.require
local pairs = base.pairs
local ipairs = base.ipairs
local string = base.string
local table = base.table

local Window = 			require('Window')
local U = 				require('me_utilities')
local i18n = 			require('i18n')
local lfs = 			require('lfs') 
local MainMenu = 		require('MainMenu')
local DemoSceneWidget 	= require('DemoSceneWidget')
local loadLiveries		= require('loadLiveries')
local DialogLoader		= require('DialogLoader')
local Gui               = require('dxgui')
local Analytics			= require("Analytics")  
local Static			= require("Static")  
local ListBoxItem		= require('ListBoxItem')
local demosceneEnvironment  = require('demosceneEnvironment')
local ED_demosceneAPI 		= require('ED_demosceneAPI')
local SkinUtils 		= require('SkinUtils')
local DB						= require('me_db_api')
i18n.setup(_M)

local DCS 				= require('DCS')

local editBoxDetails
local buttonPrev
local buttonNext

local DSWidget

local cdata = {
		Encyclopedia = _('ENCYCLOPEDIA'),
		Plane = _('AIRCRAFTS'),
		Helicopter = _('HELICOPTERS'),
		Ship = _('SHIPS'),
		Tech = _('VEHICLES'),
		Weapon = _('WEAPONS'),
        SAM = _('AIR DEFENSE'),
		previous = _('previous'),
		next = _('next'),
		cancel = _('CLOSE'),
		Personnel = _('PERSONNEL ASSETS'),
		Miscellanious = _('MISCELLANIOUS'),
	}

function loadData()
    Encyclopedia = loadArticles()

	local container = window.containerMain.pButtons

    buttons = {
        { 
            name = 'radiobuttonAircraft',
            button = container.radiobuttonAircrafts,
            category = 'Plane',
            displayName = cdata.Plane
            },
        { 
            name = 'radiobuttonHelicopters',
            button = container.radiobuttonHelicopters,
            category = 'Helicopter',
            displayName = cdata.Helicopter
            },
        { 
            name = 'radiobuttonShips',
            button = container.radiobuttonShips,
            category = 'Ship',
            displayName = cdata.Ship
            },
        { 
            name = 'radiobuttonTech',
            button = container.radiobuttonTech,
            category = 'Tech',
            displayName = cdata.Tech
            },
        { 
            name = 'radiobuttonWeapon',
            button = container.radiobuttonWeapon,
            category = 'Weapon',
            displayName = cdata.Weapon
            },
        { 
            name = 'radiobuttonSAM',
            button = container.radiobuttonSAM,
            category = 'SAM',
            displayName = cdata.SAM
            },
		{ 
            name = 'radiobuttonPersonnel',
            button = container.radiobuttonPersonnel,
            category = 'Personnel',
            displayName = cdata.Personnel
            },
		{ 
            name = 'radiobuttonMiscellanious',
            button = container.radiobuttonMiscellanious,
            category = 'Miscellanious',
            displayName = cdata.Miscellanious
            },
    }
end

local function create_()
    window = DialogLoader.spawnDialogFromFile('MissionEditor/modules/dialogs/me_encyclopedia.dlg', cdata)
        
    containerMain = window.containerMain
    pLeft = containerMain.pLeft
	
    editBoxDetails = pLeft.editBoxDetails
    buttonPrev = pLeft.buttonPrev
    buttonNext = pLeft.buttonNext
    pTop = containerMain.pTop
    pDown = containerMain.pDown
    staticPicture = containerMain.staticPicture
    staticPictureSkin = staticPicture:getSkin()
    picture = staticPictureSkin.skinData.states.released[1].picture
    currentTabName = pLeft.currentTabName
    pButtons = containerMain.pButtons

    loadData()    
   
    buttons[1].button:setState(true)
    comboboxObject = containerMain.pLeft.comboboxObject
    fillObjects(buttons[1])
	
    resize()
    
	initDemoScene()
   
    setupCallbacks()
    showDetails()
end

function resize()
    w, h = Gui.GetWindowSize()
    
    window:setBounds(0, 0, w, h)
    containerMain:setBounds(0, 0, w, h)
    
    local wP, hP = pLeft:getSize()
    
    pButtons:setPosition((w-767-wP)/2, 78)
    
    pTop:setBounds(0, 0, w, 50)
    pTop.btnClose:setPosition(w-32, 18)
    
    pDown:setBounds(0, h-50, w, 50)
    
    staticPicture:setBounds(0, 50, w, h-100)    
    pLeft:setBounds(w-wP, 50, wP, h-100)
    
    editBoxDetails:setSize(wP-6, h-213)
end

---------------------------------------------------------------	
function initDemoScene()

	if  guiSceneVR_Encyclopedia then
		DSWidget 		  = Static.new()
		DSWidget.getScene = function (self)
			return demosceneEnvironment.getInterface(guiSceneVR_Encyclopedia)
		end
		DSWidget.loadScript = function (self,filename)
			return ED_demosceneAPI.loadScript(guiSceneVR_Encyclopedia, filename)
		end
	else
		DSWidget = DemoSceneWidget.new()
	end

	local x, y, w, h = staticPicture:getBounds()
	DSWidget:setBounds(x, y, w, h)
	containerMain:insertWidget(DSWidget,0)
	DSWidget:loadScript('Scripts/DemoScenes/encyclopediaScene.lua')

	DSWidget:addMouseDownCallback(function(self, x, y, button)
		DSWidget.bEncMouseDown = true
		DSWidget.mouseX = x
		DSWidget.mouseY = y
		DSWidget.cameraAngH = base.enc.cameraAngH
		DSWidget.cameraAngV = base.enc.cameraAngV
		
		local sceneAPI = DSWidget:getScene()
		sceneAPI:setUpdateFunc('enc.encyclopediaSceneUpdateNoRotate')
		
		self:captureMouse()
	end)
	
	DSWidget:addMouseUpCallback(function(self, x, y, button)
		DSWidget.bEncMouseDown = false	
		self:releaseMouse()
	end)
	
   	DSWidget:addMouseMoveCallback(function(self, x, y)
		if DSWidget.bEncMouseDown == true then
			base.enc.cameraAngH = DSWidget.cameraAngH + (DSWidget.mouseX - x) * base.enc.mouseSensitivity
			base.enc.cameraAngV = DSWidget.cameraAngV - (DSWidget.mouseY - y) * base.enc.mouseSensitivity
			
			if base.enc.cameraAngV > base.math.pi * 0.48 then 
				base.enc.cameraAngV = base.math.pi * 0.48
			elseif base.enc.cameraAngV < -base.math.pi * 0.48 then 
				base.enc.cameraAngV = -base.math.pi * 0.48 
			end
		end
	end)
	
	DSWidget:addMouseWheelCallback(function(self, x, y, clicks)
		base.enc.cameraDistMult = base.enc.cameraDistMult - clicks*base.enc.wheelSensitivity
		local multMax = 2.3 - base.math.mod(2.3, base.enc.wheelSensitivity)
		if base.enc.cameraDistMult>multMax then base.enc.cameraDistMult = multMax end
		return true
	end)
end

function uninitialize()
	if DSWidget ~= nil then
        containerMain:removeWidget(DSWidget)
        DSWidget:destroy()
        DSWidget = nil
	end
end

function isVisible()
    if window then
        return window:isVisible()
    else
        return false
    end
end

function setupCallbacks()
    pDown.btnCancel.onChange = onButtonClose
    pTop.btnClose.onChange = onButtonClose
    for i = 1, #buttons do
        buttons[i].button.onChange = onButtonCategoryChange
    end
    comboboxObject.onChange = onChangeObject
    buttonPrev.onChange = onButtonPrev
    buttonNext.onChange = onButtonNext
	
    window:addHotKeyCallback('escape'	, onButtonClose)
    window:addHotKeyCallback('left'		, onButtonPrev)
    window:addHotKeyCallback('right'	, onButtonNext)
	window:addHotKeyCallback('home'		, onLiveryNext)
	window:addHotKeyCallback('end'		, onLiveryPrev)
end

function onLiveryChange(self,dir)
	if not DSWidget.modelObj or
	   not DSWidget.modelObj.valid or
	   not DSWidget.article then
		return
	end
	local liveries 		 = DSWidget.article.liveries or {}
	
	local liveries_count = #liveries
	
	if liveries_count < 1 then
		return
	end
	
	if not DSWidget.article.lastLivery then
		   DSWidget.article.lastLivery  = 1
	end

	if dir > 0 then
		if not DSWidget.article.lastLivery then
		   DSWidget.article.lastLivery  = 1
		elseif	DSWidget.article.lastLivery > liveries_count - 1 then
				DSWidget.article.lastLivery  = 1
		else
			DSWidget.article.lastLivery = DSWidget.article.lastLivery + 1
		end
	else
		if not DSWidget.article.lastLivery then
			   DSWidget.article.lastLivery  = liveries_count
		elseif DSWidget.article.lastLivery  < 2 then
			DSWidget.article.lastLivery  = liveries_count
		else
			DSWidget.article.lastLivery = DSWidget.article.lastLivery - 1
		end
	end
	
	DSWidget.modelObj:setAircraftBoardNumber(base.string.format("%02d",10 + DSWidget.article.lastLivery))

	local livery = liveries[DSWidget.article.lastLivery].itemId

	DSWidget.modelObj:setLivery(livery,DSWidget.article.liveryEntryPoint)
end

function onLiveryNext(self)
	onLiveryChange(self,1)
end

function onLiveryPrev(self)
	onLiveryChange(self,-1)
end

function onButtonNext(self)
	local selectedItem = comboboxObject:getSelectedItem()
	local nextItemIndex = comboboxObject:getItemIndex(selectedItem) + 1
	
	if nextItemIndex < comboboxObject:getItemCount() then
		comboboxObject:onChange(comboboxObject:getItem(nextItemIndex))
	end
end

function onButtonPrev(self)
	local selectedItem = comboboxObject:getSelectedItem()
	local prevItemIndex = comboboxObject:getItemIndex(selectedItem) - 1
	
	if prevItemIndex >= 0 then
		comboboxObject:onChange(comboboxObject:getItem(prevItemIndex))
	end   
end

function onChangeObject(self, item)
    self:setText(item:getText())
    updateDetails(getSelectedObjectParameters())
    updateButtons(item)
end

function onButtonClose()
    show(false)
	
    if not returnToEditor then
        MainMenu.show(true)
    else
		if base.MapWindow.isEmptyME() ~= true then
			base.MapWindow.show(true)
		else
			base.MapWindow.showEmpty(true)
		end	
    end
end

function onButtonCategoryChange(self)
    for k,v in pairs(buttons) do
        if v.button == self then 
            fillObjects(v)
            showDetails()
            return
        end
    end    
end

function fillObjects(button)
    local objects = {}
    local category = button.category
    if Encyclopedia[category] then
        for objectName, data in pairs(Encyclopedia[category]) do
            table.insert(objects,{name = objectName, article = data})
        end
    end
    table.sort(objects, function (left, right)
		return left.name < right.name
	end)
	
	comboboxObject:clear()  
	
    for i, v in ipairs(objects) do
      local item = ListBoxItem.new(v.name)
      item.index = i

      comboboxObject:insertItem(item)
	  --highlight dummy articles in list 
	  if not base.__FINAL_VERSION__ and v.article.dummy then
		local tmpSkin = item:getSkin()
		local newSkin = SkinUtils.setListBoxItemTextColor('0xffaaffff', tmpSkin)
		item:setSkin(newSkin) 
	  end
	  
    end

    comboboxObject:selectItem(comboboxObject:getItem(0))

    if objects[1] then
        comboboxObject:setText(objects[1].name)
    end
    
    updateButtons()
end


-- returns full path to image
function getImagePath(name)
    return 'MissionEditor/data/images/Encyclopedia/' ..  name
end


local function articleInitLiveries(article)
	if not article.liveryEntryPoint then
		   article.liveryEntryPoint = article.unit_type or article.model
	end
	if not article.liveries then				
		article.liveries = loadLiveries.loadSchemes(article.liveryEntryPoint)
		if #article.liveries < 1 then
			local str = ""
			if article.dummy then 
				str = "dummy "
			end
			str = str ..  base.string.format("no liveries \'%s\' (unit = \'%s\',model = \'%s\')",base.tostring(article.liveryEntryPoint),base.tostring(article.unit_type),base.tostring(article.model))
			base.print(str)
		end
	end
end

function updateDetails(category, object, displayName)
    local cat = Encyclopedia[category]
    local article
    
    if cat then
        article = cat[object]
    end

    local text
    
    if not article then
        text = ''
    else
        text = article.line
    end

    editBoxDetails:setText(text)
    currentTabName:setText(displayName)
    
    local filename
    
    if article and article.image then
        filename = article.image
    end
	
	local setStaticPicture = function (file)
	    picture.file = file
        staticPicture:setSkin(staticPictureSkin)
        staticPicture:setVisible(true)
	end

	local sceneAPI = DSWidget:getScene()	
	if DSWidget.modelObj ~= nil and DSWidget.modelObj.obj ~= nil then
		sceneAPI.remove(DSWidget.modelObj)
	end
	
	DSWidget.modelObj = nil
	
	-- если есть модель - показываем
	if article then
        if (article.model ~= "") then
            staticPicture:setVisible(false)
            base.print("Load model: "..article.model)
            local md = sceneAPI:addModel(article.model, 0, base.enc.objectHeight, 0)
            sceneAPI:setEnable(md.valid)--отключаем рисовалку если модель не загружена
			if	md.valid then

				articleInitLiveries(article)

				local x0,y0,z0,x1,y1,z1 = md:getBBox()
				local dx = 0
				local dz = 0
				if category == 'Miscellanious' then
					dx = -(x0+x1)*0.5
					dz = -(z0+z1)*0.5
				end
				local dy = -(y0+y1)*0.5
				
                md.transform:setPosition(dx, base.enc.objectHeight + dy , dz) --выравниваем по центру баундинг бокса

                base.enc.cameraDistMult 	= 0
                base.enc.cameraAngV 		= base.enc.cameraAngVDefault
                base.enc.cameraDistance		= md:getRadius() / base.math.tan(base.math.rad(base.enc.cameraFov*0.5))
				
				-----------------------------------------
				DSWidget.modelObj = md
				DSWidget.article  = article
				----------------------------------------------
				onLiveryNext()

				----------------------------------------------
				base.enc.onChangeModel(md,category)
                ----------------------------------------------
				sceneAPI:setUpdateFunc('enc.encyclopediaSceneUpdate')
				
				if article.encyclopediaAnimation and article.encyclopediaAnimation.args then
					for arg, value in base.pairs(article.encyclopediaAnimation.args) do
						md:setArgument(arg, value)
						base.print("--setArgument--",article.unit_type, arg,value)	
					end				
				end
            else
				setStaticPicture(filename)
            end
        else
            sceneAPI:setEnable(false)
			setStaticPicture(filename)
        end    
	else
		sceneAPI:setEnable(false)
	end	
end

function updateButtons(item)
	item = item or comboboxObject:getSelectedItem()
	
	if item then
		local itemIndex = comboboxObject:getItemIndex(item)
		
		buttonPrev:setEnabled(itemIndex > 0)
		buttonNext:setEnabled(itemIndex < comboboxObject:getItemCount() - 1)
	else
		buttonPrev:setEnabled(false)	
		buttonNext:setEnabled(false)
	end
end

function show(b, fromEdtitor)
    if b then
		guiSceneVR_Encyclopedia = base.switchVRSceneToEncyclopedia()
        returnToEditor = fromEdtitor
        if not window then    
            create_()
        end 
        
        if DSWidget == nil then
            initDemoScene()
        end    

        window:setVisible(true)
        showDetails()
		Analytics.pageview(Analytics.Encyclopedia)
    else
		base.switchVRSceneToMain()
        
        if window then
            window:setVisible(false)
        end
    end
end

function getSelectedObjectParameters()
    local category
    local displayName
    for k,v in pairs(buttons) do
        if v.button:getState() then 
            category = v.category
            displayName = v.displayName
            break
        end
    end    
    local object = comboboxObject:getText()
    return category, object, displayName
end

function showDetails()
    updateDetails(getSelectedObjectParameters())
end


-- returns list of files in directory best suited for current locale
function getBestLocalizedFiles(path)
    local files = { }

    for file in lfs.dir(path) do
        local fullPath = path .. '/' .. file
        if 'file' == lfs.attributes(fullPath).mode then
            local unllzedName, lang, country = i18n.getLocalizationInfo(file)
            local score = i18n.getLocaleScore(lang, country)
            if 0 < score then
                local choice = files[unllzedName]
                if not choice then
                    files[unllzedName] = { name = file, score = score }
                else
                    if choice.score < score then
                        choice.name = file
                        choice.score = score
                    end
                end
            end
        end
    end

    local res = { }
    for _k, v in pairs(files) do
        table.insert(res, path .. '/' .. v.name)
    end

    return res
end

-- remove trailing and leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(8programming)
local function trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- load article from text file.
function loadArticle(fileName, pluginPath)
    local f = base.io.open(fileName)

    if not f then
        return nil
    end

    local lineNo = 1
    local article = { line = "" }
	local imageName
	
	local 	stringNormalize = function (str)
		return string.gsub(str,string.char(13), '')-- в конце строки откуда-то берется символ с кодом 13, его надо отрезать
	end
	
    for line in f:lines() do
        if 1 == lineNo then
            article.name = line
        elseif 2 == lineNo then
            article.image 	  	= stringNormalize(line)
			imageName 			= article.image
			if (pluginPath) then
				article.image = pluginPath.."/"..article.image
			else
				article.image = getImagePath(article.image)
			end
		elseif 3 == lineNo then
			article.model 	  = stringNormalize(line)
		elseif 4 == lineNo then
  			article.unit_type = stringNormalize(line)
			trim(article.unit_type)
			if article.unit_type == '' then
			   article.unit_type = nil
			end
		elseif 5 < lineNo then
            article.line = article.line .. line .. '\n'
        end		
        lineNo = lineNo + 1
    end
	
	--если нету модели - берем имя картинки, ибо часто совпадает с названием модели
	if article.model == nil or article.model == "" then 
		base.print("no model")
		local s, e = base.string.find(imageName, '/')
		if s == nil then s=0 end
		local s1, e1 = base.string.find(imageName, '%.', s+1)				
		if s1 == nil then article.model = base.string.sub(imageName, s+1)
		else article.model = base.string.sub(imageName, s+1, s1-1) end
		-- base.print('modelName by imageName: ', article.model)
		-- base.print(base.tostring(s)..'/'..base.tostring(s1))
	end

    f:close()

    return article
end


-- load articles for specified category best matching current locale
function loadCategory(path, a_category, pluginPath)
    local category = a_category or {}

    local files = getBestLocalizedFiles(path)
    for _k, name in pairs(files) do
		if   string.sub(name,-4) == '.txt' then 
			local article = loadArticle(name, pluginPath)
			if (not article) or (not article.name) then
				base.print('Error loading article', name)
			else		
				category[article.name] = article
			end
		end
    end
    return category
end


-- load articles for encyclopedia
-- articles splited to categories, each stored in its own directory
function loadArticles()
	local enc = { }
	local path = 'MissionEditor/data/scripts/Enc'	
	
	local function load(a_path, pluginPath)		
		for file in lfs.dir(a_path) do
			if '.' ~= string.sub(file, 1, 1) then
				local fullPath = a_path .. '/' .. file
				if 'directory' == lfs.attributes(fullPath).mode then
					enc[file] = loadCategory(fullPath, enc[file], pluginPath)
				end
			end
		end
	end
	
	load(path)
	if (base.plugins) then
		for i, plugin in ipairs(base.plugins) do
			if (plugin.encyclopedia_path) then
				load(plugin.encyclopedia_path,plugin.encyclopedia_path)
			end
		end
	end	
	
	local  models_already_existed  = {}
	local  models_hidden  = {}
	
	for i,t in pairs(enc) do 
		for i,a in pairs(t) do 
			if  a.model then
			
				--articleInitLiveries(a)
				
				models_already_existed[base.string.upper(a.model)] = a
			end			
		end				
	end
	------------------------------------------------------------
	-- auto create articles  
	------------------------------------------------------------
	local function find_shape (cat,obj)
		if obj.Shape then 
			return obj.Shape 
		elseif obj.visual then
			return obj.visual.shape 
		elseif obj.model then
			return obj.model
		elseif obj.ShapeName then
			return obj.ShapeName
		elseif cat == 'Weapon' then
			if obj.ws_type and obj.ws_type[1] == 4 then
				if 		obj.ws_type[2] == 4 then --missiles
					return DCS.getModelNameByShapeTableIndex(3,obj.ws_type[4]) -- 3 wShapeN_MissileTable
				elseif 	obj.ws_type[2] == 5 then --bomb
					return DCS.getModelNameByShapeTableIndex(2,obj.ws_type[4]) -- 2 wShapeN_BombTable
				end
			end
		end
	
		return nil
	end 
	
	local function find_encyclopedia_hidden(t)
		if t then
			for i,o in ipairs(t) do
				if base.type(o) == 'string' and o == 'encyclopedia_hidden' then
					return true
				end
			end
		end
		return false
	end

	local function try_make_dummy_article(cat,obj)
		local shape  =  find_shape(cat,obj)
		if not shape or shape == "" then
			return
		end
		-- skip some oddities and service stuff
		if models_hidden[base.string.upper(shape)] == true then
			return
		end
		
		local up = base.string.upper(shape)
		if models_already_existed[up] == nil then		
			local article = {
				model 	  	= shape,
				line 		= "",
				dummy 		= true,
			}
			
			if not enc[cat] then
				   enc[cat] = {}
			end

			local disp_name

			if  cat == 'Weapon' then
				disp_name  			= obj.display_name
				article.unit_type   = obj.name
			else 
				disp_name  = obj.DisplayName
			
				if not disp_name then 
					disp_name = obj.Name
				end
				if not disp_name then 
					disp_name = shape
				end
			
				if obj.swapped_names then
					article.unit_type  = obj.type
				else
					article.unit_type  = obj.Name
				end
			end
			
			if article.unit_type == nil then
			   article.unit_type  = shape		   
			end	
		
			if obj.livery_entry ~= nil then 
			   article.liveryEntryPoint = obj.livery_entry
			end
			
			article.encyclopediaAnimation = obj.encyclopediaAnimation 
			
			--articleInitLiveries(article)

			if not base.__FINAL_VERSION__ then
			
				local marker 		= "<ENCYCLOPEDIA AUTOGEN>"
				local path_expected = base.tostring(cat).."/"..disp_name
				
				article.line = '--------------------------------\n'
				article.line = article.line .. disp_name .. 			'\n' -- 1 article.name 
				article.line = article.line .. 							'\n' -- 2 image - not used
				article.line = article.line .. shape ..					'\n' -- 3 model
				article.line = article.line .. article.unit_type..		'\n' -- 4 unit_type
				article.line = article.line .. marker				..  '\n' -- article.line
				
				if  obj._origin ~= nil then 
					article.line = article.line .. "'"..obj._origin	.."'"..'\n' -- article.line
				end
				if  obj._file ~= nil then 
					article.line = article.line .. "'"..obj._file	.."'"..'\n' -- article.line
				end
				
				article.line = article.line .. '--------------------------------'
				
				base.print(marker..path_expected)
			end
			
			enc[cat][disp_name]				= article
			models_already_existed[up]   	= article
		elseif obj.encyclopediaAnimation then
			models_already_existed[up].encyclopediaAnimation = obj.encyclopediaAnimation 
		end
	end

	local units		 = {
						{base.db.Units.Planes.Plane					,'Plane'},
						{base.db.Units.Helicopters.Helicopter		,'Helicopter'},
						{base.db.Units.Cars.Car						,'Tech'},
						{base.db.Units.Ships.Ship					,'Ship'},
						
						{base.db.Units.Fortifications.Fortification	,'Miscellanious'},
						{base.db.Units.GroundObjects.GroundObject	,'Miscellanious'},
						{base.db.Units.Warehouses.Warehouse			,'Miscellanious'},
						{base.db.Units.Cargos.Cargo					,'Miscellanious'},
						
						{base.weapons_table.weapons.bombs			,'Weapon'},
						{base.weapons_table.weapons.nurs			,'Weapon'},
						{base.weapons_table.weapons.missiles		,'Weapon'},
						{base.weapons_table.weapons.torpedoes		,'Weapon'},
						{base.rockets								,'Weapon'},
						{base.bombs									,'Weapon'},				
					}
			



	for x,cat in ipairs( units ) do
		for i,obj in pairs(cat[1]) do	
			local shape  =  find_shape(cat[2],obj)
			if shape and shape ~= "" then
				if cat[2] == 'Weapon' then
					if find_encyclopedia_hidden(obj.add_attributes) then
						models_hidden[base.string.upper(shape)] = true
					end
				else
					if obj.encyclopedia_hidden then
						models_hidden[base.string.upper(shape)] = true
					end		
					if find_encyclopedia_hidden(obj.tags) then
						models_hidden[base.string.upper(shape)] = true
					end
				end
			end
		end
	end
	
--	base.U.traverseTable(models_hidden)
--	base.print("---models_hidden---")
		
	for x,cat in ipairs( units ) do
		for i,obj in pairs(cat[1]) do			
			try_make_dummy_article(cat[2],obj)
		end
	end
	
	------------------------------------------------------------

    return enc
end


