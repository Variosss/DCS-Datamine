local base = _G

module('dictionary')

local U = base.require('me_utilities')
local lfs = base.require('lfs')
local i18n = base.require('i18n')
local MsgWindow = base.require('MsgWindow')
local minizip = base.require('minizip')

i18n.setup(_M)

local dictionary = {}
dictionary.DEFAULT = {}

local mapResource = {}
mapResource.DEFAULT = {}

local resourceFilesSim = {}

local resourceCounter = {}

-- maximum dictionary ID number
local maxDictId


-------------------------------------------------------------------------------
-- 
function getDictionary()
    return dictionary
end

-------------------------------------------------------------------------------
-- 
function getMapResource()
    return mapResource
end

-------------------------------------------------------------------------------
-- 
function resetDictionary()
    dictionary = {}
    dictionary.DEFAULT = {}
    curDict = 'DEFAULT'
    resourceFilesSim = {}   
    mapResource = {}
    mapResource.DEFAULT = {}
    resourceCounter = {}
	clearedKeys = {}
         
end

function extractFileName(filePath)
    if not filePath then
        return nil
    end
    local lFilePath =  filePath   
    local revPath = base.string.reverse(lFilePath)
    local lastSlash = base.string.find(revPath, '[/\\]')
	if lastSlash then 
		lFilePath = base.string.sub(lFilePath, base.string.len(lFilePath) - lastSlash + 2)
    end
	return lFilePath
end

function extractFirstDir(filePath)
    if filePath == nil then
		return nil
	end
    local firstSlash = base.string.find(filePath, '[/\\]')
	if firstSlash then 
		filePath = base.string.sub(filePath, 0, firstSlash-1)
    end
	return filePath
end

function findDir(filePath, dir)
    return base.string.find(base.string.upper(filePath), dir) ~= nil
end

function extractSecondDir(filePath)
    if filePath == nil then
		return nil
	end
    local firstSlash = base.string.find(filePath, '[/\\]')
	if firstSlash then 
		filePath = base.string.sub(filePath, firstSlash+1)
    end
    local firstSlash = base.string.find(filePath, '[/\\]')
	if firstSlash then 
		filePath = base.string.sub(filePath, 1, firstSlash-1)
    end
	return filePath
end

-------------------------------------------------------------------------------
-- загрузка словарей
function loadDict(zipFile, a_locale)        
    zipFile:unzGoToFirstFile()
    dictionary = {DEFAULT = {}}
    local mapResource = {}
    mapResource.DEFAULT = {}
    while true do
        local filename = zipFile:unzGetCurrentFileName()        
        local shortFileName = extractFileName(filename)
        local dirName = extractFirstDir(filename, 1)

        if shortFileName == 'dictionary' and dirName == 'l10n' then
            local nameDict = extractSecondDir(filename)            
            local dict = zipFile:unzReadAllCurrentFile(false)
            
            if dict then
                local fun, errStr = base.loadstring(dict)
                if not fun then
                    base.print("error loading dictionary",nameDict, errStr)
                    return false
                end
                
                local env = { }
                base.setfenv(fun, env)
                fun()
                                
                dictionary[nameDict] = env.dictionary
            end    
        end
        
        if shortFileName == 'mapResource' and dirName == 'l10n' then
            local nameDict = extractSecondDir(filename)
            local dict = zipFile:unzReadAllCurrentFile(false)
            
            if dict then
                local fun, errStr = base.loadstring(dict)
                if not fun then
                    base.print("error loading resource dictionary", errStr)
                    return false
                end
                
                local env = { }
                base.setfenv(fun, env)
                fun()
                                
                mapResource[nameDict] = env.mapResource
            end  
        end

        if not zipFile:unzGoToNextFile() then
			break
		end
    end
    
    local localeU = base.string.upper(a_locale)
    if dictionary[localeU] ~= nil then
        curDict = localeU
    else
        curDict = 'DEFAULT'
    end    
    
    return dictionary, curDict, mapResource
end

-------------------------------------------------------------------------------
-- загрузка словарей
function loadDictionary(zipFile, a_locale)      
    dictionary, curDict, mapResource = loadDict(zipFile, a_locale) 
    return dictionary, curDict
end

-------------------------------------------------------------------------------
--
function addKeyToDict(a_key)
  --  base.print("----addKeyToDict=",a_key, curDict)
  --  dictionary['DEFAULT'][a_key] = ""
    
 --   if curDict ~= nil and dictionary[curDict] then
 --       dictionary[curDict][a_key] = ""
 --   end
 
   -- добавляем ключи всем
    for k,v in base.pairs(dictionary) do
        v[a_key] = ""
    end
end


function removeKey(a_key)
    if dictionary['DEFAULT'][a_key] == nil then
        base.print("ERROR Not Key in dictionary:",a_key)
        return
    end
    
    for k_curDict,v in base.pairs(dictionary) do
        if v[a_key] then
            v[a_key] = nil
        end    
    end
end

-------------------------------------------------------------------------------
--
function setValueToDict(a_key, a_value)
  --  base.print("----setValueToDict=",a_key, a_value)
    if dictionary['DEFAULT'][a_key] == nil then
        base.print("ERROR Not Key in dictionary:",a_key)
        return
    end
    
    
    for k_curDict,v in base.pairs(dictionary) do
        if v[a_key] == "" then
            v[a_key] = a_value
        end    
    end
    
    if  curDict ~= nil and dictionary[curDict] then
        dictionary[curDict][a_key] = a_value
    end
  --  base.U.traverseTable(dictionary)
end

-------------------------------------------------------------------------------
--
function setValueToDictEx(a_key, a_value, a_locale)
    if dictionary[a_locale] then
        dictionary[a_locale][a_key] = a_value
    end
end

function getCopyDictionary()
	local result = {}
	U.recursiveCopyTable(result, dictionary)
	return result
end

-------------------------------------------------------------------------------
--
function clearDict(a_key)
	if a_key then
		if dictionary['DEFAULT'][a_key] then
			clearedKeys[a_key] = dictionary['DEFAULT'][a_key]
		end
		for dict,v in base.pairs(dictionary) do
			if v[a_key] then				
				v[a_key] = nil	
			end
		end
	end
end

-------------------------------------------------------------------------------
--
function getValueDictDEFAULT(a_key)
	local result 
	if dictionary and dictionary['DEFAULT'] 
            and dictionary['DEFAULT'][a_key]  then
        result = dictionary['DEFAULT'][a_key]
    elseif clearedKeys[a_key] then
		result = clearedKeys[a_key]
	else
        result = a_key
    end
        
    return result
end

-------------------------------------------------------------------------------
--
function getValueDict(a_key)
    local result 
--    base.print("//--/-/-/-/-/-/-/-/////-")
 --   base.U.traverseTable(dictionary)
    if dictionary and curDict and  dictionary[curDict] and dictionary[curDict][a_key] then
        result = dictionary[curDict][a_key]
    
    elseif dictionary and dictionary['DEFAULT'] 
            and dictionary['DEFAULT'][a_key]  then
            result = dictionary['DEFAULT'][a_key]
    else
        result = a_key
    end
        
   -- base.print("------getValueDict=",a_key, result)
    return result
end

-------------------------------------------------------------------------------
--
function fixDict(a_table, a_field, a_value, a_comment)
    local dictId = getNewDictId(a_comment)
    setValueToDict(dictId, a_value or "")
    textToME(a_table, a_field, dictId)
end

-------------------------------------------------------------------------------
--
function fixDictAll(a_table, a_field, a_value, a_comment, a_locTbl)
	local dictId = getNewDictId(a_comment)
	for k,v in base.pairs(a_locTbl) do
		setValueToDictEx(dictId, v[a_value] or "", k)
	end
    textToME(a_table, a_field, dictId)
end

-------------------------------------------------------------------------------
-- регистрируем файл ресурсов
-- запоминаем ключ, имя файла, путь внутри миссии
function setValueToResource(a_key, a_fileName, a_fullName, a_dict, a_bCopyFile)
    --base.print("-------------------setValueToResource=",a_key, a_fileName, a_fullName, a_dict)
    local dict = a_dict or curDict
	if a_key == nil or a_key == "" then
		a_key = getNewResourceId("Action") 
	end	
    
    --проверяем на наличие, если уже есть - удаляем
    local enable = getValueResource(a_key, a_dict, true)
    --base.print("--enable=",enable)
    if enable ~= nil then
        removeFileFromMission(a_key)
    end

   -- base.print("--dict=",mapResource['DEFAULT'][a_key],dict)
   -- base.print("-------------------mapResource['DEFAULT'][a_key]=",dict, mapResource['DEFAULT'][a_key])
    if mapResource['DEFAULT'][a_key] == nil then        
        mapResource['DEFAULT'][a_key] = a_fileName
    elseif  dict ~= nil and mapResource['DEFAULT'][a_key] ~= a_fileName then
        mapResource[dict] = mapResource[dict] or {}
        mapResource[dict][a_key] = a_fileName
    end
    
    if (a_bCopyFile == nil or a_bCopyFile == false) and resourceCounter[a_fileName] == nil then    
        insertFileIntoMission(a_fullName, a_fileName, a_key, dict)
    else
        copyFileInMission(a_fileName)
    end   
	return a_key	
end

function exchangeValue(a_key1, a_key2, a_dict)
    if mapResource[a_dict] ~= nil then
        local valueId1 = mapResource[a_dict][a_key1]
        local valueId2 = mapResource[a_dict][a_key2]
        mapResource[a_dict][a_key1] = valueId2 
        mapResource[a_dict][a_key2] = valueId1
    end
end

-------------------------------------------------------------------------------
--
function fixValueToResource(a_key, a_fileName, a_fullName, a_dict, a_bCopyFile)
   -- base.print("-------------------setValueToResource=",a_key, a_fileName, a_fullName, a_dict)
    
    local dict = a_dict or curDict
    
    --проверяем на наличие, если уже есть - удаляем
    local enable = getValueResource(a_key, a_dict, true)
    if enable ~= nil then
        removeFileFromMission(a_key)
    end

  --  base.print("-------------------mapResource['DEFAULT'][a_key]=",dict, mapResource['DEFAULT'][a_key])
    if mapResource['DEFAULT'][a_key] == nil then        
        mapResource['DEFAULT'][a_key] = a_fileName
    elseif  dict ~= nil and mapResource['DEFAULT'][a_key] ~= a_fileName then
        mapResource[dict] = mapResource[dict] or {}
        mapResource[dict][a_key] = a_fileName
    end
    
    -- полный путь к файлу назначения
    local fullPath = base.tempMissionPath .. a_fullName;    
 --   base.print('-------fullPath', fullPath);
       
    if resourceCounter[a_fileName] then -- есть уже запись о файле
		resourceCounter[a_fileName] = resourceCounter[a_fileName] + 1
        file = base.io.open(fullPath, 'rb') -- проверяем, есть ли уже файл с таким именем
        if file then -- такой файл уже есть, надо сравнить размер
            file:close();
            return true;
        else -- файл прописан в таблице, но открыть его не удается
			showWarningMessageBox(_('Can not open file for reading ') .. a_fileName)
        end
    else -- такого файла нет, надо удалить старый файл, если таковой имелся
        resourceCounter[a_fileName] = 1 
    end;
end

-------------------------------------------------------------------------------
--
function clearResourceExceptDEFAULT(a_key)
	if mapResource then
		for dict,v in base.pairs(mapResource) do
			--base.print("--clearResourceExceptDEFAULT--",dict,a_key,mapResource[dict] and mapResource[dict][a_key])
			if dict ~= 'DEFAULT' then
				if mapResource[dict] and mapResource[dict][a_key]  then
					removeResourceOnlyDict(a_key, dict)
				end
			end
		end
	end
end

-------------------------------------------------------------------------------
--
function getValueResourceDEFAULT(a_key)
	local fileName  -- имя файла
    local path 
    --base.print("//--/-/-/-/-/-/-/-/////-")

	if mapResource and mapResource['DEFAULT'] and a_noDefault ~= true
            and mapResource['DEFAULT'][a_key]  then
            fileName = mapResource['DEFAULT'][a_key]
            path = "l10n/DEFAULT/"..fileName 
    else
        fileName = nil
    end
    
    --base.print("------getValueResource=",a_key, fileName, path)
    return fileName, path
end

-------------------------------------------------------------------------------
--
function getValueResource(a_key, a_dict, a_noDefault)
    local fileName  -- имя файла
    local path 
    local dict = a_dict or curDict
    --base.print("//--/-/-/-/-/-/-/-/////-")
    --base.U.traverseTable(mapResource)
    --base.print("----a_key, a_dict=",a_key, dict, mapResource[dict])
    if mapResource and dict and  mapResource[dict] and mapResource[dict][a_key] then
        fileName = mapResource[dict][a_key]
        path = "l10n/"..dict.."/"..fileName         
    elseif mapResource and mapResource['DEFAULT'] and a_noDefault ~= true
            and mapResource['DEFAULT'][a_key]  then
            fileName = mapResource['DEFAULT'][a_key]
            path = "l10n/DEFAULT/"..fileName 
    else
        fileName = nil
    end
    
    --base.print("------getValueResource=",a_key, fileName, path)
    return fileName, path
end

-------------------------------------------------------------------------------
--  true - если ресурс есть для заданного языка
function resourceExists(a_key, a_dict)
    if mapResource and a_dict and mapResource[a_dict] and mapResource[a_dict][a_key] then
        return true
    end
    return false
end

-------------------------------------------------------------------------------
-- 
function insertFileIntoMission(filePath, a_fileName, a_key, a_dict)
--base.print("-----**--",filePath, a_fileName, a_key)

    local dict = a_dict or curDict
    -- если имя файла не задано выстригаем его из полного пути
    if not a_fileName then
        a_fileName = extractFileName(filePath)
    end;
    
    if a_key == nil then
        a_key = a_fileName
    end
       
    -- читаем исходный файл
    local file = base.io.open(filePath, 'rb')
    local data;
    if file then
        data = file:read('*a');
        file:close();
    else
		showWarningMessageBox(_('Can not open file for reading ') .. filePath)	
        --base.print("----ERROR---  Can not open file for reading")
        return false
    end;

    --base.print("-----a_fileName=",a_fileName,filePath)
    local ext = U.getExtension(a_fileName)
    local fileName = a_fileName

    --base.U.traverseTable(mapResource)
    --base.print("--curDict---",dict)
    if mapResource[dict] and mapResource[dict][a_key] ~= nil then        
        fileName = "l10n/"..dict.."/"..fileName
    else
        fileName = "l10n/DEFAULT/"..fileName    
    end    
                
    local dirName = base.tempMissionPath;
    
    for w in base.string.gmatch(fileName, '[^><|?*:/\\]+/') do 
        --print('w: ', w)
        dirName = dirName .. w;
        local a = lfs.attributes(dirName,'mode')
        if not a then
            --print('creating dir: ', dirName)
            lfs.mkdir(dirName);
            --base.debug.debug();
        end;
    end;
    
    -- полный путь к файлу назначения
    local fullPath = base.tempMissionPath .. fileName;    
   --base.print('fullPath', fullPath);  
   -- base.print("----- resourceCounter[a_fileName]---",resourceCounter[a_fileName],a_fileName)
    if resourceCounter[a_fileName] then -- есть уже запись о файле
		resourceCounter[a_fileName] = resourceCounter[a_fileName] + 1
        file = base.io.open(fullPath, 'rb') -- проверяем, есть ли уже файл с таким именем
        if file then -- такой файл уже есть, надо сравнить размер
            file:close();
            -- проверку размера временно убрали, т.к. lfs.attributes(fullPath, 'size') не поддерживается сейчас dsb
           -- local size = lfs.attributes(fullPath, 'size');
           -- print('size', size,'#data', #data);
           -- if #data ~= size then
                -- файл  с другим размером и таким же названием уже присутствует в миссии
                -- сообщаем об ошибке и выходим ничего не добавляя
           --     local w = MsgWindow.new('File "'..fileName..'" with different size "' ..#data.. '" already present in mission', ' Warning', 'warning', 'OK')
           --     w:setVisible(true);
           --     return false;
           -- end;
            -- файл с таким размером и именем уже есть в миссии, ничего добавлять не надо
            --base.print("----fileENABLE----")
            return true;
        else -- файл прописан в таблице, но открыть его не удается
			showWarningMessageBox(_('Can not open file for reading ') .. fileName)
        end
    else -- такого файла нет, надо удалить старый файл, если таковой имелся
      --  if oldFileName and (oldFileName ~= '') then -- надо удалить предыдущий файл
      --      print('removing', base.tempMissionPath .. oldFileName);
      --      removeFileFromMission(oldFileName)
            --base.os.remove(base.tempMissionPath .. oldFileName)
      --  end;
        resourceCounter[a_fileName] = 1 
    end;
    
    --открываем (создаем) файл назначения
    file = base.assert(base.io.open(fullPath, 'wb'))
    if file then
       -- base.print('saving '..fullPath)
        file:write(data)
        file:close();
    end
   -- base.print("------insertFile=",a_fileName,fullPath)
   
    
    return true;
end;

-------------------------------------------------------------------------------
-- распаковка ресурсов миссии
function unpackFiles(zipFile)
--base.print("-------start----unpackFiles(zipFile)")

	resourceFilesSim = {}	
    zipFile:unzGoToFirstFile()
    while true do        
        local filename = zipFile:unzGetCurrentFileName()
		filename = base.string.gsub(filename, "%s+/", "/")

        local shortName = extractFileName(filename)
        --base.print('-----    filename =',filename,shortName)        
        if (filename ~= 'mission') and (filename ~= 'options') and (filename ~= 'warehouses') 
			and (filename ~= "signature.bin") and (filename ~= "rts.txt") and (filename ~= "manifest.json") 
			and (filename ~= 'theatre') and (shortName ~= 'dictionary') and (shortName ~= 'mapResource') 
			and (filename ~= 'path') and ('/' ~= base.string.sub(filename, -1, -1)) then            
            --base.print('UNPACKING: '..filename)            
            local dirName = base.tempMissionPath;
            --print(dirName)
            --for w in base.string.gmatch(filename, '%w+/') do
            --base.print("-----filename=",filename)
            local dirFile = U.extractDirName(filename)
            --base.print("----dirName=",dirName,filename)
            
            local ext = U.getExtension(filename)
            --base.print("-----ext =", ext,filename)
            
            local nameDict = extractSecondDir(filename)
            --base.print("-----nameDict =", nameDict,filename)
            
            if (dirFile == nil or dirFile == "") then
                filename = "l10n/DEFAULT/"..filename
            end 
            
            for w in base.string.gmatch(filename, '[^><|?*:/\\]+/') do 
                --print('w: ', w)
                dirName = dirName .. w;
                local a = lfs.attributes(dirName,'mode')
                if not a then
                    --print('creating dir: ', dirName)
                    lfs.mkdir(dirName);
                    --base.debug.debug();
                end;
            end;
            
            local fullPath = base.tempMissionPath .. filename
            --base.print("----fullPath=",dirName,fullPath)
            
            local firstDir = extractFirstDir(filename, 1)
            --base.print("----fff----",((firstDir == "l10n" and findDir(filename,"KNEEBOARD")) or (firstDir ~= "l10n")),firstDir)
            if (firstDir ~= nil and ((firstDir == "l10n" and findDir(filename,"KNEEBOARD")) or (firstDir ~= "l10n"))) then
                resourceFilesSim[filename] = fullPath
            end   
            
            base.assert(zipFile:unzUnpackCurrentFile(fullPath))           
        end
		
		if (filename == "signature.bin") or (filename == "manifest.json") then
			local fullPath = base.tempMissionPath .. filename
			resourceFilesSim[filename] = fullPath
			base.assert(zipFile:unzUnpackCurrentFile(fullPath))   
		end
		
		if filename == "rts.txt" then
			local fullPath = base.tempDataDir .. filename
			base.assert(zipFile:unzUnpackCurrentFile(fullPath))   
		end
		
        if not zipFile:unzGoToNextFile() then
			break
		end
    end
	--base.U.traverseTable(resourceFilesSim)
    --base.print("-------end----unpackFiles(zipFile)")
	return resourceFilesSim    
end;

function isSignedMission()
	return resourceFilesSim["signature.bin"] ~= nil
end

-------------------------------------------------------------------------------
--
function packMissionResources(miz)
--base.print("-----packMissionResources---")
local resourceFilesEnable = {}
    for dict,v in base.pairs(mapResource) do
        for key, fileName in base.pairs(v) do   
            --base.print("------ADDD--111---",key, fileName)
            local path = "l10n/"..dict.."/"..fileName    
            if resourceFilesEnable[path] == nil then                    
                resourceFilesEnable[path] = 1
                local fullPath = base.tempMissionPath .. path;
                local a = lfs.attributes(fullPath,'mode')
                if a then
                    miz:zipAddFile(path, fullPath)
                end    
            end
        end
    end
    
    for file, fullPath in base.pairs(resourceFilesSim) do
        --base.print("------ADDD-----",file, fullPath)
        miz:zipAddFile(file, fullPath)
    end
	
	local a, err =  lfs.attributes(base.tempDataDir .. "rts.txt")
	if a then
		miz:zipAddFile("rts.txt", base.tempDataDir .. "rts.txt")
	end
    --base.print("-----END--------------")
end

-------------------------------------------------------------------------------
--
function copyFileInMission(a_fileName)
    if resourceCounter[a_fileName] then -- есть уже запись о файле
		resourceCounter[a_fileName] = resourceCounter[a_fileName] + 1
    end
end

-------------------------------------------------------------------------------
--
function setResourceCounter(a_fileName, a_num)
    resourceCounter[a_fileName] = a_num
end

-------------------------------------------------------------------------------
--
function getResourceCounter(a_fileName)
    return resourceCounter[a_fileName]
end

-------------------------------------------------------------------------------
--
function getFullPath(a_fileName)
    return mapResource[curDict][a_fileName] 
        or mapResource['DEFAULT'][a_fileName]
end


-------------------------------------------------------------------------------
--
function removeResource(a_key, a_dict)   
    if a_dict then
        if mapResource[a_dict] == nil or mapResource[a_dict][a_key] == nil then
            return
        end
    end
 
    for k,v in base.pairs(mapResource) do
        if v[a_key] ~= nil then
            removeFileFromMission(a_key, a_dict)
            v[a_key] = nil
        end
    end
end

-------------------------------------------------------------------------------
--
function removeResourceOnlyDict(a_key, a_dict)   
    if a_dict then
        if mapResource[a_dict] == nil or mapResource[a_dict][a_key] == nil then
            return
        end
    end
 
    removeFileFromMission(a_key, a_dict)
    mapResource[a_dict][a_key] = nil
end

-------------------------------------------------------------------------------
--
function removeFileFromMission(a_key, a_dict)
--base.print('----removeFileFromMission', a_key, a_dict);
    local fileName, path = getValueResource(a_key, a_dict)
	if (fileName == nil or fileName == "") then
		return
	end
    
    local dict = a_dict or curDict
    
    --base.print('----removing', fileName, path);
    local fullPath = base.tempMissionPath .. path;
	if 	resourceCounter == nil or
		resourceCounter[fileName] == nil then
		return
	end
	
    fileName = extractFileName(fileName);
    
	-- base.print("-----resourceCounter[fileName]=",resourceCounter[fileName])         
	resourceCounter[fileName] = resourceCounter[fileName] - 1
	if resourceCounter[fileName] == 0 then
		local file = base.io.open(fullPath, 'rb')
		--print('removing', base.tempMissionPath .. fileName);
		if file then
			file:close();
            --base.print("----remove=",fileName,fullPath)
			base.os.remove(fullPath);
		end;
		resourceCounter[fileName] = nil;        
	end  
    if mapResource[dict] and mapResource[dict][a_key] then
        mapResource[dict][a_key] = nil
    else
        mapResource['DEFAULT'][a_key] = nil
    end     
end;

-------------------------------------------------------------------------------
-- текст в формат редактора
function textToME(a_table, a_nameVar, a_key, a_comment)
    a_table[a_nameVar] = getValueDict(a_key)
    a_table['KeyDict_'..a_nameVar] = a_key
end

-------------------------------------------------------------------------------
--текст в формат миссии
function textToMis(a_table, a_nameVar, a_value, a_key)
    if a_value == nil then
        a_value = ""
    end
    setValueToDict(a_key, a_value)
    a_table[a_nameVar] = a_key
end

-------------------------------------------------------------------------------
--возвращает список языков
function getLangs()
    local result = {}
    for k,v in base.pairs(dictionary) do
        base.table.insert(result, k)
    end

    return result
end

function isLang(a_lang)
    local langU = base.string.upper(a_lang)
    if dictionary[langU] ~= nil then
        --base.print("----isLang----langU=",langU,true)
        return true
    end
    --base.print("----isLang----langU=",langU,false)
    return false
end

function addNewLang(a_lang)
    local langU = base.string.upper(a_lang)
    --base.print("-----addNewLang(a_lang)",langU, dictionary[langU])
    if dictionary[langU] ~= nil then
        return false
    end
    --base.print("-----addNewLang(a_lang)",langU)
    dictionary[langU] = {}

   return true
end

function deleteLang(a_lang)
    local langU = base.string.upper(a_lang)
    if langU == 'DEFAULT' then
        return
    end
    dictionary[langU] = nil
    mapResource[langU] = nil
end


function CopyKeysToNewDict(a_lang)
    local langU = base.string.upper(a_lang)
    U.recursiveCopyTable(dictionary[langU], dictionary['DEFAULT'])
end

function setCurDictionary(a_curDict)
    curDict = a_curDict
end

function getCurDictionary()
    return curDict
end

function showWarningMessageBox(text, caption)
	MsgWindow.warning(text, caption or _('WARNING'), 'OK'):show()
end

-------------------------------------------------------------------------------
--
function getNewDictId(a_comment)
    local newId
    maxDictId = maxDictId + 1
    if a_comment then
        newId = 'DictKey_'..a_comment.."_"..maxDictId
    else
        newId = 'DictKey_'..maxDictId
    end
    addKeyToDict(newId)
    return newId
end

-------------------------------------------------------------------------------
--
function getNewResourceId(a_preName)
    local newId
    maxDictId = maxDictId + 1
    newId = 'ResKey_'..a_preName..'_'..maxDictId
    return newId
end

-------------------------------------------------------------------------------
--
function setMaxDictId(a_maxDictId)
    maxDictId = a_maxDictId
end

-------------------------------------------------------------------------------
--
function getMaxDictId()
    return maxDictId
end

-------------------------------------------------------------------------------
--вытаскивает из миссии задачу игрока
local function getPlayerTaskCountrySide(a_mission)
	for k,coal in base.pairs({a_mission.coalition.blue, a_mission.coalition.red}) do
		for k1,country in base.pairs(coal.country) do
			if country.plane then
				for k2,group in base.pairs(country.plane.group) do
					for k3,unit in base.pairs(group.units) do					
						if unit.skill == "Player" then
							local enemy = {}
							local allies = {}
							if coal.name == 'BLUE' then
								enemy = a_mission.coalitions['red']
								allies = a_mission.coalitions['blue']
							elseif coal.name == 'RED' then
								enemy = a_mission.coalitions['blue']
								allies = a_mission.coalitions['red']
							end							
							return {task = group.task, countryId = country.id, side = coal.name, allies = allies,
									enemy = enemy, payload = unit.payload, unitType = unit.type}
						end
					end
				end
			end	
		end
	end

	return {task = nil, countryId = nil, side = nil, allies = {}, enemy = {}, payload = {}}
end

-------------------------------------------------------------------------------
--
function getMissionDescription(a_fileName, a_locale, a_needTask, a_needTheatre)
    local zipFile = minizip.unzOpen(a_fileName, 'rb')
    if not zipFile then
        return ''
    end
    local misStr
    if zipFile:unzLocateFile('mission') then
        misStr = zipFile:unzReadAllCurrentFile(false)
    end
	
	if misStr == nil then
		return ''
	end
    local funD = base.loadstring(misStr)
    local envD = { }
    base.setfenv(funD, envD)
    
    status, err = base.pcall(funD)
    if not status then 
        --base.print("----status, err=",status, err)
        return " "
    end

    local mission = envD.mission
    local description = mission.descriptionText 
    local requiredModules = mission.requiredModules or {}
	local task = nil
	local theatre = nil
	local unitType = nil
	local sortie = mission.sortie
	if a_needTask == true then
		local tmp = getPlayerTaskCountrySide(mission)
		task = tmp.task
		unitType = tmp.unitType
	end
	if a_needTheatre then
		theatre = mission.theatre 
	end
    
    zipFile:unzGoToFirstFile()
    
    local dictionary = {DEFAULT = {}}

    while true do
        local filename = zipFile:unzGetCurrentFileName()        
        local shortFileName = extractFileName(filename)
        local dirName = extractFirstDir(filename, 1)
        if shortFileName == 'dictionary' and dirName == 'l10n' then
            local nameDict = extractSecondDir(filename)            
            local dict = zipFile:unzReadAllCurrentFile(false)
            
            if dict then
                local fun, errStr = base.loadstring(dict)
                if not fun then
                    base.print("error loading dictionary", errStr)
                    return false
                end
                
                local env = { }
                base.setfenv(fun, env)
                fun()
       
                dictionary[nameDict] = env.dictionary
            end    
        end
        if not zipFile:unzGoToNextFile() then
			break
		end
    end    
        
    zipFile:unzClose()
    
    local lang = base.string.upper(a_locale)
    
    if dictionary[lang] and dictionary[lang][description] ~= nil and dictionary[lang][sortie] ~= nil then
        return dictionary[lang][description], requiredModules, task, theatre,unitType, dictionary[lang][sortie]
    elseif dictionary["DEFAULT"] and dictionary["DEFAULT"][description] ~= nil and dictionary["DEFAULT"][sortie] ~= nil then
        return dictionary["DEFAULT"][description], requiredModules, task, theatre,unitType, dictionary["DEFAULT"][sortie]
    else    
        return description, requiredModules, task, theatre, unitType, sortie
    end
end

-------------------------------------------------------------------------------
--
function getBriefingData(a_fileName, a_locale)
base.print("---getBriefingData---",a_fileName, a_locale)
    local zipFile = minizip.unzOpen(a_fileName, 'rb')
    if not zipFile then
        return ''
    end
    local misStr
    if zipFile:unzLocateFile('mission') then
        misStr = zipFile:unzReadAllCurrentFile(false)
    end
	
	if misStr == nil then
		zipFile:unzClose()
		base.print("--- not misStr---")
		return ''
	end
    local funD,err = base.loadstring(misStr)
    local envD = { }

	if funD then
        base.setfenv(funD, envD)
    else
        base.print("--ERROR getBriefingData, funD==nil",a_fileName,err)
		zipFile:unzClose()
        return ''
    end
    
    status, err = base.pcall(funD)
    if not status then 
        base.print("----status, err=",status, err)
		zipFile:unzClose()
        return " "
    end

    local mission = envD.mission

    
    zipFile:unzGoToFirstFile()
    
    local dictionary  = {DEFAULT = {}}
	local mapResource = {DEFAULT = {}}

    while true do
        local filename = zipFile:unzGetCurrentFileName()        
        local shortFileName = extractFileName(filename)
        local dirName = extractFirstDir(filename, 1)
        if shortFileName == 'dictionary' and dirName == 'l10n' then
            local nameDict = extractSecondDir(filename)            
            local dict = zipFile:unzReadAllCurrentFile(false)
            
            if dict then
                local fun, errStr = base.loadstring(dict)
                if not fun then
                    base.print("error loading dictionary", errStr)
					zipFile:unzClose()
                    return false
                end
                
                local env = { }
                base.setfenv(fun, env)
                fun()
       
                dictionary[nameDict] = env.dictionary
            end    
        end
		
		if shortFileName == 'mapResource' and dirName == 'l10n' then
            local nameDict = extractSecondDir(filename)            
            local dict = zipFile:unzReadAllCurrentFile(false)
            
            if dict then
                local fun, errStr = base.loadstring(dict)
                if not fun then
                    base.print("error loading mapResource", errStr)
					zipFile:unzClose()
                    return false
                end
                
                local env = { }
                base.setfenv(fun, env)
                fun()
       
                mapResource[nameDict] = env.mapResource
            end    
        end
		
        if not zipFile:unzGoToNextFile() then
			break
		end
    end    
        
    zipFile:unzClose()
    
    local lang = base.string.upper(a_locale)
	
	local result = {}
	
	local function getText(a_key)
		local result
		
		if dictionary[lang] and dictionary[lang][a_key] ~= nil then
			return dictionary[lang][a_key]
		elseif dictionary["DEFAULT"] and dictionary["DEFAULT"][a_key] ~= nil then
			return dictionary["DEFAULT"][a_key]
		else    
			return a_key
		end
		
		return result
	end
	
	local function getResource(a_key)
		local result
		
		if mapResource[lang] and mapResource[lang][a_key] ~= nil then
			return "l10n\\"..lang.."\\"..mapResource[lang][a_key]
		elseif mapResource["DEFAULT"] and mapResource["DEFAULT"][a_key] ~= nil then
			return "l10n\\DEFAULT\\"..mapResource["DEFAULT"][a_key]
		else    
			return a_key
		end
		
		return result
	end
	
	result.sortie 					= getText(mission.sortie)
	result.descriptionNeutralsTask 	= getText(mission.descriptionNeutralsTask)
	result.descriptionBlueTask 		= getText(mission.descriptionBlueTask)
	result.descriptionRedTask 		= getText(mission.descriptionRedTask)
	result.descriptionText 			= getText(mission.descriptionText)
	local tmp = getPlayerTaskCountrySide(mission)
	result.task = tmp.task
	result.countryId = tmp.countryId 
	result.side = tmp.side 
	result.allies = tmp.allies 
	result.enemy = tmp.enemy 
	result.payload = tmp.payload
	result.date = mission.date
	result.start_time = mission.start_time
	result.playerUnitType = tmp.unitType
	
	result.pictureFileNameB = {}
	for index, curFile in base.pairs(mission.pictureFileNameB) do
		result.pictureFileNameB[index] = getResource(curFile)
	end
	
	if mission.pictureFileNameN then
		result.pictureFileNameN = {}
		for index, curFile in base.pairs(mission.pictureFileNameN) do
			result.pictureFileNameN[index] = getResource(curFile)
		end
	end
	
	result.pictureFileNameR = {}
	for index, curFile in base.pairs(mission.pictureFileNameR) do
		result.pictureFileNameR[index] = getResource(curFile)
	end
	
	result.weather = mission.weather

	return result
end

-------------------------------------------------------------------------------
--
function getCampaignData(a_fileName, a_locale)
--base.print("---getCampaignData---",a_fileName, a_locale)
    local zipFile = minizip.unzOpen(a_fileName, 'rb')
    if not zipFile then
        return nil
    end
    local misStr
    if zipFile:unzLocateFile('mission') then
        misStr = zipFile:unzReadAllCurrentFile(false)
    end
	
	if misStr == nil then
		return nil
	end
    local funD,err = base.loadstring(misStr)
    local envD = { }

	if funD then
        base.setfenv(funD, envD)
    else
        base.print("--ERROR getCampaignData, funD==nil",a_fileName,err)
        return nil
    end
    
    status, err = base.pcall(funD)
    if not status then 
        --base.print("----status, err=",status, err)
        return nil
    end

    local mission = envD.mission

    
    zipFile:unzGoToFirstFile()
    
    local dictionaryTMP  = {DEFAULT = {}}

    while true do
        local filename = zipFile:unzGetCurrentFileName()        
        local shortFileName = extractFileName(filename)
        local dirName = extractFirstDir(filename, 1)
        if shortFileName == 'dictionary' and dirName == 'l10n' then
            local nameDict = extractSecondDir(filename)            
            local dict = zipFile:unzReadAllCurrentFile(false)
            
            if dict then
                local fun, errStr = base.loadstring(dict)
                if not fun then
                    base.print("error loading dictionary", errStr)
                    return nil
                end
                
                local env = { }
                base.setfenv(fun, env)
                fun()
       
                dictionaryTMP[nameDict] = env.dictionary
            end    
        end
		
        if not zipFile:unzGoToNextFile() then
			break
		end
    end    
        
    zipFile:unzClose()
    
    local lang = base.string.upper(a_locale)
	
	local result = {}
	
	local function getText(a_key)
		local result
		
		if dictionaryTMP[lang] and dictionaryTMP[lang][a_key] ~= nil then
			return dictionaryTMP[lang][a_key]
		elseif dictionaryTMP["DEFAULT"] and dictionaryTMP["DEFAULT"][a_key] ~= nil then
			return dictionaryTMP["DEFAULT"][a_key]
		else    
			return a_key
		end
		
		return result
	end
	
	result.sortie 					= getText(mission.sortie)
	result.descriptionNeutralsTask 	= getText(mission.descriptionNeutralsTask)
	result.descriptionBlueTask 		= getText(mission.descriptionBlueTask)
	result.descriptionRedTask 		= getText(mission.descriptionRedTask)
	result.descriptionText 			= getText(mission.descriptionText)
	local tmp = getPlayerTaskCountrySide(mission)
--	result.task = tmp.task
	result.countryId = tmp.countryId 
	result.side = tmp.side 
--	result.allies = tmp.allies 
--	result.enemy = tmp.enemy 
--	result.payload = tmp.payload
	result.date = mission.date
	result.start_time = mission.start_time
	
--	result.weather = mission.weather

	return result
end

