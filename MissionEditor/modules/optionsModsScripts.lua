local base = _G

local require = base.require
local table = base.table
local pairs = base.pairs
local string = base.string

local DbOption  = require('Options.DbOption')
local i18n		= require('i18n')
local lfs       = require("lfs")
local DCS    	= require('DCS')

local _ = i18n.ptranslate

module('optionsModsScripts')

local modLiveries = {}
--	table 'modLiveries' will be filled by function 'scan_modLiveries_in_dir'
--	modLiveries = {
--		["XXXX"] = { -- current module\Liveries\XXXX\default ...
--   		[1] = "default",
--   		[2] = "english",
--   		...
--   	},
-- 	}

function FileMode( filepath, filename )
	-- IGNORE, fast return
	if filename == "." or filename == ".." then
		return
	end

	local attr,err = lfs.attributes ( filepath .. "\\" .. filename )
	-- our interest
	if attr and (attr.mode == "directory" or attr.mode == "file")then
		return attr.mode
	end

	return 
end

--
-- fill table 'modLiveries' with Liveries info of all available Mods
--
local liveryfoldername
function scan_modLiveries_in_dir( path )
		if not path then
			return
		end
	--for modname in lfs.dir( path ) do
		if "directory" == FileMode( path, "Liveries" )
		then
			for liveryclass in lfs.dir( path .. "\\Liveries" ) do
				if "directory" == FileMode( path .. "\\Liveries", liveryclass ) then
					for liveryname in lfs.dir( path .. "\\Liveries\\" .. liveryclass) do
						if "directory" == FileMode( path .. "\\Liveries\\" .. liveryclass, liveryname ) then
							-- check ffile 'description.lua' DO exist in this directory
							if "file" == FileMode( path .. "\\Liveries\\" .. liveryclass .."\\".. liveryname, "description.lua" ) then
								-- all check ok, insert this mod Liveries info into global table modLiveries
                                modLiveries[liveryclass] = modLiveries[liveryclass] or {}
								
								liveryfoldername = liveryclass
                                if string.lower(liveryname) == 'default' then
                                    table.insert( modLiveries[liveryclass], 1, liveryname)
                                else
                                    table.insert( modLiveries[liveryclass], liveryname)
                                end                                        
							end -- of if description.lua is file
						end -- of if liveryname is directory
					end -- of for liveryname
				end -- of if liveryclass is directory
			end -- of for liveryclass
		end -- of if modname is directory and modname\\Liveries is directory
	--end -- of for modname
end -- of function scan_modLiveries_in_dir

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end


function getTblCPLocalList(modulelocation)
    modLiveries = {}    
    scan_modLiveries_in_dir(modulelocation) 
    scan_modLiveries_in_dir(lfs.writedir())  

    local tblCPLocalList = {}
    if modLiveries then
        for liveryclass, liveries in pairs(modLiveries) do
            local tblItems = {}
            for k, v in pairs(liveries) do
                local opname = firstToUpper(v)
                table.insert(tblItems, DbOption.Item(_(opname.."_liv",opname)):Value(v))	                
            end
            tblCPLocalList[liveryclass] = DbOption.new():setValue(liveries[1]):combo(tblItems)
        end
        
        return tblCPLocalList
    end
    
    
end

function getCPLocalList(liveryName)
	local liveriesData = DCS.getObjectLiveriesNames(liveryName, nil, base.string.lower(i18n.getLocale())) -- 'USA' заменить на nil когда функцию допилят

	if liveriesData and liveriesData[1] then
		local tblItems = {}
		for k,v in base.ipairs(liveriesData) do
			local opname = firstToUpper(v[2])
            table.insert(tblItems, DbOption.Item(_(opname.."_liv",opname)):Value(v[1]))
		end 

		return DbOption.new():setValue(liveriesData[1][1]):combo(tblItems)
	end
end
