-- internationalization rotinues

local base = _G

module('i18n')


local T = base.require('tools')
gettext = base.require('i_18n')
local lfs = base.require('lfs')


-- current language
local localeLang = "en"

-- current country
local localeCountry = "US"


-- find first occurrence of characted in string
-- return index of character or zero if character is not found
function find(string, start, char)
    local len = base.string.len(string)
    for i = start, len do
        if base.string.sub(string, i, i) == char then
            return i
        end
    end
    return 0
end

-- find backward one of characters lister in chars string.
function findBack(str, chars)
    local len = base.string.len(str)
    local sublen = base.string.len(chars)
    for i = len, 1, -1 do
        local ch = base.string.sub(str, i, i)
        for j = 1, sublen do
            if base.string.sub(chars, j, j) == ch then
                return i
            end
        end
    end
    return 0
end


-- parse locale string
-- returns two strings: language and country
function parseLocale(locale)
    local idx = find(locale, 1, '_')
    if 0 == idx then
        local ch = base.string.sub(locale, 1, 1)
        if ('A' <= ch) and ('Z' >= ch) then
            return '', locale
        else
            return locale, ''
        end
    end

    local language = base.string.sub(locale, 1, idx - 1)
    local country = base.string.sub(locale, idx + 1, find(locale, 1, '.') - 1)
    return language, country
end


-- set current locale
-- locale is string in format lang_country where lang and country
-- is two letters ISO codes
function setLocale(dir)
    localeLang, localeCountry = gettext.get_locale()
    base.print('locale:', localeLang, localeCountry)

	if dir == '' then
		return localeLang, localeCountry;
	end;
	
    gettext.set_locale_dir(dir)
    return localeLang, localeCountry;
end

function getLocale()
    return localeLang, localeCountry;
end; 

-- returns name of file and extension
function splitFileName(fileName)
    local name = ""
    local ext = ""
    local path = '';
    local file = '';
    
    local start = findBack(fileName, '\\/')
    if 0 == start then
        start = 1
    end
    local dotIdx = find(fileName, start, '.')
    if 0 < dotIdx then
        name = base.string.sub(fileName, 1, dotIdx - 1)
        local fNameIdx = find(fileName, start, '.')
        ext = base.string.sub(fileName, dotIdx)
        
        start = findBack(name, '\\/')
        if 0 ~= start then
            path = base.string.sub(name, 1, start)
            file = base.string.sub(fileName, start + 1)
        else
            file = name .. ext;
        end
    else
        name = fileName
    end
    --base.print(name, ext, path, file);
    return name, ext, path, file
end

-- returns list of localized file names
function getNamesList(fileName)
    local res = { }
    local name, ext, path, file = splitFileName(fileName)    
    local names = {
        name .. '_' .. localeLang .. '_' .. localeCountry .. ext,
        name .. '_' .. localeLang .. ext,
        name .. '_' .. localeCountry .. ext,
        path .. localeLang .. '_' .. localeCountry .. '/' .. file,
        path .. localeLang .. '/' .. file,
        path .. localeCountry .. '/' .. file,
        fileName,
        };
        
    for k,name in base.ipairs(names) do
        base.table.insert(res, name)
    end;
   
    return res
end

-- find and open localized name
function openLocalized(fileName)
    local fileNames = getNamesList(fileName)
    for _, v in base.ipairs(fileNames) do
        local f = base.io.open(v)
        if f then
            return f
        end
    end
    return nil
end


-- find name of localized file
function getLocalizedFileName(fileName)
    local fileNames = getNamesList(fileName)
    for _, v in base.ipairs(fileNames) do
		local f = lfs.attributes(v)		
        if (f) and (f.mode == 'file') then
            return v
        end
    end
    return nil
end


function getLocalizedDirName(path)
    local i1, i2 =  base.string.find(path, '[\\/]$');
    if i1 then 
        path = base.string.sub(path, 1, i1 - 1);
    end
    local names = {
        path .. '/' .. localeLang .. '_' .. localeCountry,
        path .. '/' .. localeLang,
        path .. '/' .. localeCountry ,
        path,
        };
        
    for k, dirName in base.ipairs(names) do
        --base.print('getLocalizedDirName, trying:', dirName)
        local a, err = lfs.attributes(dirName)
        if a then
            if a.mode == 'directory' then
                --base.print('getLocalizedDirName, success:', dirName)
                return dirName
            end;
        else
            if err then 
                base.print('getLocalizedDirName, error getting dir attributes', err)
            end;
        end
    end
    return nil
end


-- load lua table from file
function loadTable(fileName)
    local name = getLocalizedFileName(fileName)
    if not name then
        return nil
    end
    return T.safeDoFile(name)
end


-- broken simulation of pgettext
function ptranslate(...)
	local select = base.select
    local key = select(1, ...)
	
    if key == '' then 
        return ''
    end
	
    local msg = gettext.translate(key)
	
    if 1 == select('#', ...) then
        return msg
    else
        if key == msg then
            return select(2, ...)
        else
            return msg
        end
    end
end

-- setup localization
function setup(env)
    env._ = ptranslate
end

-- returns name of non-localized file, language code and country code
function getLocalizationInfo(fileName)
    local localeStart = find(fileName, 1, '_')
    if 0 == localeStart then
        return fileName, '', ''
    end

    local localeEnd = findBack(fileName, '.')
    local unllzedName
    if 0 ~= localeEnd then
        unllzedName = base.string.sub(fileName, 1, localeStart - 1) ..
                            base.string.sub(fileName, localeEnd)
    else
        unllzedName = base.string.sub(fileName, 1, localeStart - 1)
        localeEnd = base.string.len(fileName) + 1
    end

    local locale = base.string.sub(fileName, localeStart + 1, localeEnd - 1)
    local lang, country = parseLocale(locale)

    return unllzedName, lang, country
end

-- compare given lang and country against current and returns locale score
-- 0 means locale is not suited for current setting.  greater scrore is
-- better locale matching
function getLocaleScore(lang, country)
    local score = 0

    if ('' == lang) and ('' == country) then
        return 1
    end

    if lang == localeLang then
        score = score + 2
    else
        return 0
    end

    if country == localeCountry then
        score = score + 1
    end

    return score
end

-- returns localized value of key
-- key uses the same suffixes as files
function getLocalizedValue(table, key)
    if not table then
        return nil
    end
    local names = getNamesList(key)
    for _k, name in base.pairs(names) do
        local v = table[name]
        if v then
            return v
        end
    end
    return nil
end

