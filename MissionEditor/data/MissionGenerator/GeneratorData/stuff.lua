local base = _G


function getTerrainConfigPath(a_name)
    if theatresByName[a_name] then
        return theatresByName[a_name].configFilename
    end
    return nil    
end

function getTerrainPathByName(strName)
	--return base.getTerrainConfigPath(strName)
	return getTerrainConfigPath(strName)
end

function getDisplayName(unitType)    
	local unitTypeDesc = unit_by_type[unitType]
	return unitTypeDesc.DisplayName
end
