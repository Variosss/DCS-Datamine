function trav(tableName)
    return traverseTable(tableName,1,'')
end 

-- отладочная функция для сериализации таблицы на экран
function traverseTable(_t, _numLevels, _tabString, filename, filter)
    local _tablesList = {}
    filter = filter or {}
    fun = print
    local out
    if ( filename and (filename ~= '') ) then
        out = io.open(filename, 'w')
        print('Opening', filename)
        fun = function (...)
            out:write(..., '\n')
        end
    end
    function _traverseTable(t, tabString, tablesList, numLevels, filter)
        if (numLevels <1) then 
            return
        end

      for k,v in pairs(t or {} ) do      
            if type(k) == "number" then
                k = '[' .. tostring(k) .. ']'
            else
                k = '["' .. tostring(k) .. '"]'
            end
        if type(v) == "table" then 
            local skip = false
            for i,ignoredField in ipairs(filter) do
                if ignoredField == k then
                    skip = true
                    break
                end
            end
            if skip == false then
                local str = string.gsub(tostring(v), 'table: ','')
                if not tablesList[v] then
                    tablesList[v] = tostring(k)
                    fun(tabString  .. tostring(k) .. "--[[" .. str .. "--]]  = {")
                    --numLevels = numLevels - 1
                    _traverseTable(v, tabString .. '    ', tablesList, numLevels - 1, filter)
                    fun(tabString .. "}")
                else 
                    fun(tabString .. k .. " = -> " .. (tostring(tablesList[v])  or '') .. "--[[" .. str .. "--]],")
                end
            end
        elseif type(v) == "function" then
          fun(tabString .. k .. " = " .. "function() {},")
        elseif type(v) == "string" then
          fun(tabString .. k .. " = '" .. v .. "'")
        else
          fun(tabString .. k .. " = " .. tostring(v) or '' .. ",")
        end
      end        
    end 

    if not _t then 
        fun('traverseTable(): nil value')
        return
    end
    
    if 'table' ~= type(_t) then 
        fun('traverseTable(): not a table', tostring(_t)  or '')
        return
    end
    fun('displaying table:', (tostring(_t) or ''), tostring(_numLevels) or '')
    
    if _numLevels == nil then 
        _numLevels  = math.huge
    end
    
    if (_numLevels <1) then 
        return
    end
    
    if _tabString == nil then
        _tabString = ""
    end
    
    if not _tablesList then 
        _tablesList = {}
    end 
    --fun('_numLevels',_numLevels)
    for k,v in ipairs(filter) do
        print(k,v)
    end
    _traverseTable(_t, _tabString, _tablesList, _numLevels, filter)
    if (out ~= nil) then
        out:close()
    end
   print('traverseTable done') 
end
