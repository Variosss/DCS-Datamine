local base = _G

function getTerrainPathByName(strName)
	return base.getTerrainConfigPath(strName)
end

local function value2string(val)
    local t = type(val)
    if t == "number" or t == "boolean" then
        return tostring(val)
    elseif t == "table" then
        local str = ''
        local k,v
        for k,v in pairs(val) do
            str = str ..'['..value2string(k)..']='..value2string(v)..','
        end
        return '{'..str..'}'
    else
        return string.format("%q", tostring(val))
    end
end

function value2code(val)
    return 'return ' .. value2string(val)
end

function value2table(val)
    return value2string(val)
end
--[[
local function recursiveCopyTable(dest, source)
    local _tablesList = {}
    
    function copy(dest, source, tablesList)
        
        for sourceKey, sourceValue in pairs(source) do
            if type(sourceValue) == 'table' then
                if tablesList[sourceValue] == nil then
                    dest[sourceKey] = dest[sourceKey] or {}
                    tablesList[sourceValue] = dest[sourceKey]                    
                    copy(dest[sourceKey], sourceValue, tablesList)
                else
                    dest[sourceKey] = tablesList[sourceValue]
                end
            else
                dest[sourceKey] = sourceValue
            end
        end
    end
    
    copy(dest, source, _tablesList)


end
]]