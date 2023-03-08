
local i18n              = require('i18n')

local curLang
local localeU = string.upper(i18n.getLocale())
local selectLang

function setSelectLang(a_lang)
    selectLang = a_lang
    curLang = a_lang
end

function setCurLang(a_lang)
    curLang = a_lang
end

function getCurLangForLoad()
    if selectLang then
        return selectLang
    end
    
    return localeU
end

function getCurLang()
    if selectLang then
        return selectLang
    end
    if curLang == nil then
        return localeU
    end
    return curLang
end

return {
	setSelectLang = setSelectLang,
    setCurLang  = setCurLang,
    getCurLang  = getCurLang,
    getCurLangForLoad = getCurLangForLoad,
}