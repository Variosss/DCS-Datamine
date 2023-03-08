local base = _G

local require = base.require
local pairs = base.pairs
local loadfile = base.loadfile
local setfenv = base.setfenv
local pairs = base.pairs
local string = base.string
local print = base.print
local table = base.table

module('censorship')

local lfs 				= require('lfs')
local U                 = require('me_utilities')
local i18n 				= require('i18n')
local textutil          = require('textutil')

tblStr = {}
isInit = false

function init()
    local path = 'Data//censor.lua'
    local a, errB = lfs.attributes(path)
    local list_str = {}
    local localeU = string.upper(i18n.getLocale())
    if (a and a.mode == 'file')  then
        local f, err = loadfile(path) 
        if f then    
            local env = {}
            setfenv(f, env)
            f()
            --U.traverseTable(env)
            if env and env[localeU] then
                list_str = env[localeU]
            end
		else
			 print('Failed to load censor.lua: '..err)
        end  		
    end 
    
    tblStr = {}
    for k,v in pairs(list_str) do 
        tblStr[k] = {}
        tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(v), "%%", "%%%%")
		tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(tblStr[k].str), "%(", "%%(")
		tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(tblStr[k].str), "%)", "%%)")
		tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(tblStr[k].str), "%.", "%%.")
		tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(tblStr[k].str), "%+", "%%+")
		tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(tblStr[k].str), "%-", "%%-")
		tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(tblStr[k].str), "%*", "%%*")
		tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(tblStr[k].str), "%]", "%%]")
		tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(tblStr[k].str), "%?", "%%?")
		tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(tblStr[k].str), "%[", "%%[")
		tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(tblStr[k].str), "%^", "%%^")
		tblStr[k].str = string.gsub(textutil.Utf8ToUpperCase(tblStr[k].str), "%$", "%%$")
		--print("---init---",textutil.Utf8ToUpperCase(v),"==",tblStr[k].str)
		
        local len = textutil.Utf8Len(v)
        local rep = ""
        for i=1, len do
            rep = rep .."*"
        end
        tblStr[k].rep = rep
    end  
    isInit = true    
end

function censor(a_str)
    if isInit == false then
        init()
    end
    local pos1,pos2
    local strU = textutil.Utf8ToUpperCase(a_str)
    local second = 1
    local first = 1
    local toRep ={}
    for k,v in pairs(tblStr) do
        local tmpRep;
        first = 1
        while (first ~= nil) do
            first, second =string.find(strU,v.str, second)
            if first ~= nil then
				--print("--censor---",strU,"==",v.str)
                a_str = string.sub(a_str, 1, first-1)..v.rep..string.sub(a_str, second+1)
                strU = textutil.Utf8ToUpperCase(a_str)
            end
        end   
    end    

    return a_str
end

