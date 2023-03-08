-- makes deep copy of all fields from source table to target table
local function copyTable(target, src)
	assert(target ~= src)
	
	if not target then
		target = {}
	end
	
	for i, v in pairs(src) do
		if type(v) == 'table' then
			if not target[i] then
				target[i] = {}
			end
			
			copyTable(target[i], v)
		else
			target[i] = v
		end
	end

	return target
end

local function mergeTablesOptions(table1, table2, bDuo)
	local result = {}
	
    if table2 then
        for k, v in pairs(table1) do
            if 'table' == type(v) then
                if nil == table2[k] then
                    result[k] = copyTable(nil, v)
                else
                    result[k] = mergeTablesOptions(v, table2[k], bDuo)
                end
            else
                if nil == table2[k] then
                    result[k] = v
                else
                    result[k] = table2[k]
                end
            end
        end
		if bDuo == true then
			for k, v in pairs(table2) do
				if nil == table1[k] then
					if 'table' == type(v) then
						result[k] = copyTable(nil, v)
					else
						result[k] = v
					end
				end
			end
		end
	end
	
	return result
end

local function mergeTables(table1, table2)
	local result = {}
	
    if table2 then
        for k, v in pairs(table1) do
            if 'table' == type(v) then
                result[k] = mergeTables(v, table2[k])
            else
                if nil == table2[k] then
                    result[k] = v
                else
                    result[k] = table2[k]
                end
            end
        end
	
		for k, v in pairs(table2) do
			if nil == table1[k] then
				if 'table' == type(v) then
					result[k] = copyTable(nil, v)
				else
					result[k] = v
				end
			end
		end
	end
	
	return result
end

-- сравниваем таблицу source с таблицей dest 
local function compareTables(dest, source, _ignoredFields)
    local EPS = 1e-10
    local tablesList = {}
    local ignoredFields = {}
    for k,v in ipairs(_ignoredFields or {}) do
        ignoredFields[v] = true
    end
    str = ''        
    function compare(dest, source, tablesList, ignoredFields, sourceKey)
        str = str .. '  '
        if (dest == nil) or (source == nil) then -- если какая-либо из таблиц пуста обрываем сравнение
            str = string.sub(str, 1, -3)
            return false 
        end
        for sourceKey, sourceValue in pairs(source) do -- идем по полям исходной таблицы
            if ignoredFields[sourceKey] == nil then -- поля нет в списке игнорируемых
                if type(sourceValue) == 'table' then -- поле - таблица
                    if tablesList[sourceValue] == nil then -- эта таблица попалась впервые
                        tablesList[sourceValue] = sourceKey
                        if not compare(dest[sourceKey], sourceValue, tablesList, ignoredFields, sourceKey) then
                            str = string.sub(str, 1, -3)
                            return false
                        end
                    end
                else -- поле - обычное значение
                    if dest[sourceKey] ~= sourceValue then
                        if ( (type(sourceValue) == 'number') 
                            and (type(dest[sourceKey]) == 'number') ) then
                            if math.abs(dest[sourceKey] - sourceValue) > EPS then
                                print(sourceKey, 'numbers differ', dest[sourceKey], sourceValue)
                                str = string.sub(str, 1, -3)
                                return false                            
                            end
                        else 
                            print(sourceKey, 'differs',dest[sourceKey], sourceValue)                        
                            str = string.sub(str, 1, -3)
                            return false
                        end
                    end
                end
            end
        end
        str = string.sub(str, 1, -3)
        return true
    end
    if (compare(dest, source, tablesList, ignoredFields)) then
        return compare(source, dest, tablesList, ignoredFields)
    else
        return false
    end
end

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

local function getNilValue()
	return '$nil$'
end

-- получить значение из таблицы по текстовому ключу вида
-- field1.field2.field3.field4.field5.[field]
-- например 't.theme.border.[4].color.[1]'
local function getTableValue(table, key)
	local result
	local currField = table
	
	if '' == key then
		result = table
	else	
		for currKey, separator in string.gmatch(key, "([^%.]+)(.?)") do
			local numericKey = string.match(currKey, "%[(.*)%]")

			if numericKey then
				currKey = tonumber(numericKey)
			end

			if '' == separator then
				result = currField[currKey]
			else
				currField = currField[currKey]
				
				if not currField then
					break
				end
			end
		end

		if getNilValue() == result then
			result = nil
		end
	end
	
	return result
end

-- установить значение в таблице по текстовому ключу вида
-- field1.field2.field3.field4.field5.[field]
-- например 't.theme.border.[4].color.[1]'
local function setTableValue(table, key, value, replaceNilValue)
	local currField = table
	local nilValue = getNilValue()

	for currKey, separator in string.gmatch(key, "([^%.]+)(.?)") do
		local numericKey = string.match(currKey, "%[(.*)%]")

		if numericKey then
			currKey = tonumber(numericKey)
		end

		if '' == separator then
			if nilValue == currField then
				currField = {}
			end
		
			currField[currKey] = value
		else
			if not currField[currKey] or (replaceNilValue and nilValue == currField[currKey])then
				currField[currKey] = {}
			end

			currField = currField[currKey]
		end
	end
end

return {
	copyTable		    = copyTable,
	mergeTables		    = mergeTables,
	compareTables	    = compareTables,
    recursiveCopyTable  = recursiveCopyTable,
	getTableValue		= getTableValue,
	setTableValue		= setTableValue,
    mergeTablesOptions  = mergeTablesOptions,
}