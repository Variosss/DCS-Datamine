local base = _G

module('me_predicates', package.seeall)

local Button                = require('Button')
local Panel                 = require('Panel')
local ComboList             = require('ComboList')
local CheckBox              = require('CheckBox')
local EditBox               = require('EditBox')
local ListBox               = require('ListBox')
local ListBoxItem           = require('ListBoxItem')
local SpinBox               = require('SpinBox')
local Static                = require('Static')
local U                     = require('me_utilities')
local Mission               = require('me_mission')
local FileDialog            = require('FileDialog')
local FileDialogFilters     = require('FileDialogFilters')
local MeSettings            = require('MeSettings')
local i18n                  = require('i18n')
local DB                    = require('me_db_api')
local Terrain               = require('terrain')
local mod_dictionary        = require('dictionary')
local music                 = require('me_music')
local TriggerZoneController	= require('Mission.TriggerZoneController')
local CoalitionUtils	    = require('Mission.CoalitionUtils')
local AirdromeData		    = require('Mission.AirdromeData')
local SoundPlayer           = require('SoundPlayer')
local OptionsData           = require('Options.Data')
local SkinUtils         	= require('SkinUtils')
local ProductType 			= require('me_ProductType') 
i18n.setup(_M)

function null_transform(cdata,param) -- to make sure we will use serializeFunc instead of displayFunc
    return param 
end 

local function flag_with_id(inid,initvalue, intitle)

return {  	id 		= inid or "flag",
			title 	= intitle,
			type 	= "text",
			default = tostring(initvalue or 1),
			serializeFunc   = null_transform,
			displayFunc     = function(cdata,param) return '"'..param..'"' end,}	
			
end

local FLAG_FIELD =  flag_with_id("flag")

local locale = i18n.getLocale()

local SPINBOX_MAX_VALUE = 1000000000 -- по просьбе Белова пишу, что это связано с ограничением разрядности спинбокса
local SPINBOX_MAX_NEGATIVE_VALUE = -1000000000 -- по просьбе Белова пишу, что это связано с ограничением разрядности спинбокса

local staticSkin
local buttonSkin
local comboListSkin
local spinBoxSkin
local editBoxSkin
local checkBoxSkin

function loadSkins(skinsPanel)
	staticSkin = skinsPanel.static:getSkin()
	buttonSkin = skinsPanel.button:getSkin()
	comboListSkin = skinsPanel.comboList:getSkin()
	spinBoxSkin = skinsPanel.spinBox:getSkin()
	editBoxSkin = skinsPanel.editBox:getSkin()
	checkBoxSkin = skinsPanel.checkBox:getSkin()
end

function bombLister()
    local paramBomb = {}
    paramBomb[2] = {base.wsType_Bomb}
    paramBomb[3] = {   base.wsType_Bomb_BetAB,
                            base.wsType_Bomb_A,
                            base.wsType_Bomb_Cluster,
                            base.wsType_Bomb_ODAB,
                            base.wsType_Bomb_Antisubmarine,
                            base.wsType_Bomb_Fire,
                            base.wsType_Bomb_Lighter,
							32,
                            wsType_Bomb_Guided
                        }
    function verifyParam(a_wsType)
        if (paramBomb[2] == nil) then
            return true
        end

        local result1 = false
        for k,v in pairs(paramBomb[2]) do
            if (v == a_wsType[2]) then
                result1 = true
            end
        end
        
        local result2 = false
        for k,v in pairs(paramBomb[3]) do
            if (v == a_wsType[3]) then
                result2 = true
            end
        end
        
        if (result1 == true) and (result2 == true) then
            return true
        else
            return false
        end
    end
    
	local bombs = {}
	for i,o in pairs(DB.getBombs()) do
		local weapon_type_  = {o[1],o[2],o[3],i}
		local nameDisp = base.get_weapon_display_name_by_wstype(weapon_type_)
		if (verifyParam(weapon_type_) == true and nameDisp ~= "") then
            table.insert(bombs,{id = weapon_type_, name = nameDisp})			
        end
	end
	table.sort(bombs, U.namedTableComparator)
	
    return bombs
end 

function missileLister()
	local paramMissile = {}
    paramMissile[2] = {base.wsType_Missile}
    paramMissile[3] = {   base.wsType_AA_Missile,
                            base.wsType_AS_Missile,
                            base.wsType_Rocket,
                            base.wsType_SA_Missile,
                            base.wsType_SS_Missile,
                            base.wsType_AS_TRAIN_Missile,
                        }
    function verifyParam(a_wsType)
        if (paramMissile[2] == nil) then
            return true
        end

        local result1 = false
        for k,v in pairs(paramMissile[2]) do
            if (v == a_wsType[2]) then
                result1 = true
            end
        end
        
        local result2 = false
        for k,v in pairs(paramMissile[3]) do
            if (v == a_wsType[3]) then
                result2 = true
            end
        end
        
        if (result1 == true) and (result2 == true) then
            return true
        else
            return false
        end
    end
	
	local missiles = {}
	for i,o in pairs(DB.getMissiles()) do
		local weapon_type_  = {o[1],o[2],o[3],i}
		local nameDisp = base.get_weapon_display_name_by_wstype(weapon_type_)
		if (verifyParam(weapon_type_) == true and nameDisp ~= "") then
            table.insert(missiles,{id = weapon_type_, name = nameDisp})			
        end
	end
	table.sort(missiles, U.namedTableComparator)
	
    return missiles 
end 

function mlrsLister()
	local wstype_missiles = DB.getMissiles()
	local missiles = {}
	local list =
	{
		180, -- SMERCH_9M55F
		95, -- SMERCH_RAKETA 9M55K
		179,-- URAGAN_RAKETA
		94,  -- GRAD_RAKETA
		131, -- M26_RAKETA
	}
	
	for i,o in pairs(list) do
		if wstype_missiles[o] then
			local weapon_type_  = {wstype_missiles[o][1],wstype_missiles[o][2],wstype_missiles[o][3],o}
			local nameDisp = base.get_weapon_display_name_by_wstype(weapon_type_)
            table.insert(missiles,{id = weapon_type_, name = nameDisp})			
        end
	end
	
	table.sort(missiles, U.namedTableComparator)
	
    return missiles 
end

function signalFlareColorLister()
    
    local colors = { {id="0",name=_("GREEN"),},{id="1",name=_("RED")},{id="2",name=_("WHITE")},{id="3",name=_("ORANGE")} }    
    return colors
end

  

function airdromeLister()
	local result = {}

    for id, airdrome in pairs(AirdromeData.getTblOriginalAirdromes()) do
        local nameAirdrome
        if airdrome.display_name then
            nameAirdrome = _(airdrome.display_name) 
        else			
            nameAirdrome = airdrome.names[locale] or airdrome.names['en']
        end
		table.insert(result, {id=id,name=nameAirdrome})
    end
	return result
end

function helipadLister()
	local result = {}
    for __, coalition in pairs(Mission.mission.coalition) do
        for __, country in  ipairs(coalition.country) do
		    for __, group in ipairs(country.static.group) do 
				for __, unit in ipairs(group.units) do
					if DB.isFARP(unit.type) then
						table.insert(result, {id=unit.unitId,name=unit.name})
					end
				end;
			end;        
		end;
	end;
	return result
end;

function coalitionIdToName(cdata, coalitionName)
	return CoalitionUtils.coalitionNameToLocalizedName(coalitionName, _("UNKNOWN"))
end

function coalitionIdToName2(cdata, id)
	return CoalitionUtils.coalitionIdToLocalizedName(id, _("UNKNOWN"))
end

function airdromeIdToName(cdata, id)
    for airdromeID, airdrome in pairs(AirdromeData.getTblOriginalAirdromes()) do
		if airdromeID == id then 
            local nameAirdrome			
            if airdrome.display_name then
                nameAirdrome = _(airdrome.display_name) 
            else
                nameAirdrome = airdrome.names[locale] or airdrome.names['en']
            end
            return nameAirdrome 
        end;
    end;
	return "INVALID AIRDROME ID";
end

function helipadIdToName(cdata, id)
    for __, coalition in pairs(Mission.mission.coalition) do
        for __, country in  ipairs(coalition.country) do
		    for __, group in ipairs(country.static.group) do 
				for __, unit in ipairs(group.units) do
					if unit.unitId == id then return unit.name end
				end;
			end;        
		end;
	end;

	return "INVALID HELIPAD ID";
end

-- groups enumerator
function groupsLister()
    local groups = { }
    for k, v in pairs(Mission.group_by_id) do
        if v then
            table.insert(groups, { id=k, name=v.name })
        end
    end
    table.sort(groups, U.namedTableComparator)
    return groups
end

-- cargos enumerator
function cargosLister()
    local cargos = { }
    for k, v in pairs(Mission.unit_by_id) do
        if v and v.canCargo and v.canCargo == true then
            table.insert(cargos, { id=k, name=v.name })
        end
    end
    table.sort(cargos, U.namedTableComparator)
    return cargos
end

-- units enumerator
local function unitsLister()
    local units = { }
    for k, v in pairs(Mission.unit_by_id) do
        if v then
            table.insert(units, { id=k, name=v.name })
        end
    end
    table.sort(units, U.namedTableComparator)
    return units
end

-- units Vehicles+Ships enumerator
local function unitsVSLister()
    local units = { }
    for k, v in pairs(Mission.unit_by_id) do
        if v and (v.boss.type == 'vehicle' or v.boss.type == 'ship') then
            table.insert(units, { id=k, name=v.name })
        end
    end
    table.sort(units, U.namedTableComparator)
    return units
end


-- conver unitId to unit name
function unitIdToName(cdata, id)
    return id and Mission.unit_by_id[id] and Mission.unit_by_id[id].name or ""
end

-- conver groupId to unit name
function groupIdToName(cdata, id)
    return id and Mission.group_by_id[id] and Mission.group_by_id[id].name or ""
end

-- return true if unit with specified ID exists
function isUnitExists(id)
    return nil ~= Mission.unit_by_id[id]
end

function isGroupExists(id)
    return nil ~= Mission.group_by_id[id]
end

function unitTypeLister()
	local unitTypes = {}
	
	table.insert(unitTypes, {id		= "ALL", 		name	= cdata.ALL})
	table.insert(unitTypes, {id		= "AIRPLANE", 	name	= cdata.AIRPLANE})
	table.insert(unitTypes, {id		= "HELICOPTER", name	= cdata.HELICOPTER})
	table.insert(unitTypes, {id		= "NAVAL", 		name	= cdata.NAVAL})
	table.insert(unitTypes, {id		= "GROUND", 	name	= cdata.GROUND})
	
    return unitTypes
end

-- zones enumerator
function zonesLister()
    local zones = {}
	
    for i, triggerZoneId in pairs(TriggerZoneController.getTriggerZoneIds()) do
		table.insert(zones, { 
			id		= triggerZoneId, 
			name	= TriggerZoneController.getTriggerZoneName(triggerZoneId),
			})
    end
	
    table.sort(zones, U.namedTableComparator)
	
    return zones
end

function bombTypeToName(a_cdata, a_type)
    if (a_type == nil) or (a_type == "") then
        return ""
    end 
    return base.get_weapon_display_name_by_wstype(a_type)
end

function weaponSerialize(a_cdata, a_type)
	return base.wsTypeToString(a_type)
end

-- conver zoneId to zone name
function zoneIdToName(cdata, id)
	return TriggerZoneController.getTriggerZoneName(id) or ''
end

-- return true if zone with specified ID exists
function isZoneExists(id)
    return TriggerZoneController.getTriggerZoneExists(id)
end

local COCKPIT_ADDITIONAL_PLUGIN =
{
	id              = "COCKPIT_ADDITIONAL_PLUGIN",
	type            = "text",
	default         = "",
	displayFunc     = function(cdata,param) return '"'..param..'"' end,
	serializeFunc   = null_transform,
}



UNIT_SELECTOR =  {
	id				= "unit",
	type			= "combo",
	comboFunc		= unitsLister,
	displayFunc		= unitIdToName,
	existsFunc		= isUnitExists,
	serializeFunc	= null_transform,
	default			= "",
}

VEHICLE_SELECTOR =  {
	id				= "unit",
	type			= "combo",
	comboFunc		= unitsVSLister,
	displayFunc		= unitIdToName,
	existsFunc		= isUnitExists,
	serializeFunc	= null_transform,
	default			= "",
}

-- list of available rules for score calculation their arguments
rulesDescr = {    
    {
        name = "c_unit_damaged",
        fields = {
			UNIT_SELECTOR,
        }
    },
    {
        name = "c_unit_alive",
        fields = {
			UNIT_SELECTOR,
        }
    },
    {
        name = "c_unit_dead",
        fields = {
			UNIT_SELECTOR,
        }
    },
    {
        name = "c_group_alive",
        fields = {
            {
                id = "group",
                type = "combo",
                comboFunc = groupsLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
                default = "",
            }
        }
    },
    {
        name = "c_group_dead",
        fields = {
            {
                id = "group",
                type = "combo",
                comboFunc = groupsLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
                default = "",
            }
        }
    },
    {
        name = "c_time_after",
        fields = {
            {
                id = "seconds",
                type = "spin",
                default = 10,
                min = 1,
                max = SPINBOX_MAX_VALUE,
                step = 1
            }
        }
    },
    {
        name = "c_time_before",
        fields = {
            {
                id = "seconds",
                type = "spin",
                default = 10,
                min = 1,
                max = SPINBOX_MAX_VALUE,
                step = 1
            }
        }
    },
    {
        name = "c_flag_is_true",
        fields = {
			FLAG_FIELD,
        },
    },
    {
        name = "c_flag_is_false",
        fields = {
			FLAG_FIELD,
        },
    },
    {
        name = "c_flag_more",
        fields = {
			FLAG_FIELD,
            {
                id = "value",
                type = "spin",
                default = 10,
                min = 0,
                max = SPINBOX_MAX_VALUE,
                step = 1,
            },
        },
    },
    {
        name = "c_flag_less",
        fields = {
			FLAG_FIELD,
            {
                id = "value",
                type = "spin",
                default = 10,
                min = 0,
                max = SPINBOX_MAX_VALUE,
                step = 1,
            },
        },
    },
    {
        name = "c_flag_less_flag",
        fields = {
			FLAG_FIELD,
			flag_with_id("flag2")
        },
    },
    {
        name = "c_flag_equals",
        fields = {
			FLAG_FIELD,
            {
                id = "value",
                type = "spin",
                default = 10,
                min = 0,
                max = SPINBOX_MAX_VALUE,
                step = 1,
            },
        },
    },
    {
        name = "c_flag_equals_flag",
        fields = {
			FLAG_FIELD,
			flag_with_id("flag2")
        },
    },
    {
        name = "c_time_since_flag",
        fields = {
			FLAG_FIELD,
            {
                id = "seconds",
                type = "spin",
                default = 10,
                min = 1,
                max = SPINBOX_MAX_VALUE,
                step = 1
            }
        }
    },
    {
        name = "c_bomb_in_zone",
        fields = {
            {
                id = "typebomb",
                type = "combo",
                comboFunc = bombLister,
                displayFunc = bombTypeToName,
                compareFunc = function(left, right)
                    return left[1] == right[1] and left[2] == right[2] and left[3] == right[3] and left[4] == right[4]
                end,
                serializeFunc = weaponSerialize,
                default = "",
            },        
            {
				id = "numbombs",
				type = "spin",
				default = 1,
				min = 1,
				max = 100000,
			},       
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            }        
        }
    },
	{
        name = "c_dead_zone",
        fields = {		
			{
				id = "zone",
				type = "combo",
				comboFunc = zonesLister,
				displayFunc = zoneIdToName,
				existsFunc = isZoneExists,
				serializeFunc = null_transform,
				default = "",
			} 
		}		
	},
    {
        name = "c_missile_in_zone",
        fields = {
            {
                id = "typemissile",
                type = "combo",
                comboFunc = missileLister,
                displayFunc = bombTypeToName,
                compareFunc = function(left, right)
                    return left[1] == right[1] and left[2] == right[2] and left[3] == right[3] and left[4] == right[4]
                end,
                serializeFunc = weaponSerialize,
                default = "",
            },        
            {
				id = "nummissiles",
				type = "spin",
				default = 1,
				min = 1,
				max = 100000,
			},       
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            }        
        }
    },
	{
        name = "c_mlrs_in_zone",
        fields = {
            {
                id = "typemlrs",
                type = "combo",
                comboFunc = mlrsLister,
                displayFunc = bombTypeToName,
                compareFunc = function(left, right)
                    return left[1] == right[1] and left[2] == right[2] and left[3] == right[3] and left[4] == right[4]
                end,
                serializeFunc = weaponSerialize,
                default = "",
            },        
            {
				id = "nummissiles",
				type = "spin",
				default = 1,
				min = 1,
				max = 100000,
			},       
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            }        
        }
    },
    {
        name = "c_unit_in_zone",
        fields = {
			UNIT_SELECTOR,
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            }
        }
    },
    {
        name = "c_unit_out_zone",
        fields = {
			UNIT_SELECTOR,
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            }
        }
    },
    {
        name = "c_unit_in_zone_unit",
        fields = {
			UNIT_SELECTOR,
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "zoneunit",
                type = "combo",
                comboFunc = unitsLister,
                displayFunc = unitIdToName,
                existsFunc = isUnitExists,
                serializeFunc = null_transform,
                default = "",
            },
        }
    },
    {
        name = "c_unit_out_zone_unit",
        fields = {
			UNIT_SELECTOR,
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "zoneunit",
                type = "combo",
                comboFunc = unitsLister,
                displayFunc = unitIdToName,
                existsFunc = isUnitExists,
                serializeFunc = null_transform,
                default = "",
            },
        }
    },
    {
        name = "c_random_less",
        fields = {
            {
                id = "percent",
                type = "spin",
                default = 10,
            }
        }
    },
    {
        name = "c_unit_altitude_higher",
        fields = {
			UNIT_SELECTOR,
            {
                id = "altitude",
                type = "positive_number",
                default = 1,
            },
        }
    },
    {
        name = "c_unit_altitude_lower",
        fields = {
			UNIT_SELECTOR,
            {
                id = "altitude",
                type = "positive_number",
                default = 1,
            },
        }
    },
    {
        name = "c_unit_altitude_higher_AGL",
        fields = {
			UNIT_SELECTOR,
            {
                id = "altitude",
                type = "positive_number",
                default = 1,
            },
        }
    },
    {
        name = "c_unit_altitude_lower_AGL",
        fields = {
			UNIT_SELECTOR,
            {
                id = "altitude",
                type = "positive_number",
                default = 1,
            },
        }
    },
    {
        name = "c_unit_speed_higher",
        fields = {
			UNIT_SELECTOR,
            {
                id = "speedU",
                type = "spin",
                default = 100,
                measureUnits = U.speedUnits,
            },
        }
    },
    {
        name = "c_unit_speed_lower",
        fields = {
			UNIT_SELECTOR,
            {
                id = "speedU",
                type = "spin",
                default = 100,
                measureUnits = U.speedUnits,
            },
        }
    },
	{
        name = "c_unit_heading",
        fields = {
			UNIT_SELECTOR,
            {
                id = "min_unit_heading",
                type = "positive_number",
                default = 0,
            },
			{
                id = "max_unit_heading",
                type = "positive_number",
                default = 360,
            },
        }
    },
 	{
        name = "c_unit_pitch",
        fields = {
			UNIT_SELECTOR,
            {
                id = "min_unit_pitch",
                type = "number",
                default = -180,
            },
			{
                id = "max_unit_pitch",
                type = "number",
                default = 180,
            },
        }
    },
	{
        name = "c_unit_bank",
        fields = {
			UNIT_SELECTOR,
            {
                id = "min_unit_bank",
                type = "number",
                default = -180,
            },
			{
                id = "max_unit_bank",
                type = "number",
                default = 180,
            },
        }
    },
	{
        name = "c_unit_vertical_speed",
        fields = {
			UNIT_SELECTOR,
            {
                id = "min_unit_vertical_speed",
                type = "number",
                default = -300,
            },
			{
                id = "max_unit_vertical_speed",
                type = "number",
                default = 300,
            },
        }
    },
	{
        name = "c_mission_score_higher",
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNameRedBlueOffline,
                displayFunc = coalitionIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "score",
                type = "spin",
                default = 50,
                min = -100,
                max = 100,
            },
        }
    },
	{
        name = "c_mission_score_lower",
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNameRedBlueOffline,
                displayFunc = coalitionIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "score",
                type = "spin",
                default = 50,
                min = -100,
                max = 100,
            },
        }
    },
    {
        name = "c_coalition_has_airdrome",
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNeutralRedBlueId,
                displayFunc = coalitionIdToName2,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "airdromelist",
                type = "combo",
                comboFunc = airdromeLister,
                displayFunc = airdromeIdToName,
                serializeFunc = null_transform,
                default = "",
            },
        }
    },
    {
        name = "c_coalition_has_helipad",
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNeutralRedBlueId,
                displayFunc = coalitionIdToName2,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "helipadlist",
                type = "combo",
                comboFunc = helipadLister,
                displayFunc = helipadIdToName,
                serializeFunc = null_transform,
                default = "",
            },
        }
    },

	-- predicates for cockpit triggers
	{
        name = "c_cockpit_highlight_visible",
        fields = {
			{
			    id   	= "highlight_id",
                type 	= "spin",
                default = 0,
                min 	= 0,
                max 	= 100,
                step 	= 1
			},
        }
    },
    {
        name = "c_argument_in_range",
        fields = {
            {
                id = "argument",
                type = "spin",
				default = 0,
				min 	= 0,
				max     = 999999,
				step 	= 1,
            },
			{
                id 		= "_min",
                type 	= "spin",
				default = 0,
				min 	= -1,
				max     = 1,
				step 	= 0.05,
            },
			{
                id 		= "_max",
                type 	= "spin",
				default = 0,
				min 	= -1,
				max     = 1,
				step 	= 0.05,
            },
			COCKPIT_ADDITIONAL_PLUGIN,
        },
    },
    {
        name = "c_cockpit_param_in_range",
        fields = {
             {
			    id 				= "cockpit_param",
                type 			= "text",
                default 		= "",
                displayFunc 	= function(cdata,param) return '"'..param..'"' end,
                serializeFunc 	= null_transform,
            },
            {
                id = "_min2",
                type = "spin",
 				default = 0,
				min 	=-1000000000,
				max     = 1000000000,
				step 	= 0.05,
            },
            {
                id = "_max2",
                type = "spin",
  				default = 0,
				min 	=-1000000000,
				max     = 1000000000,
				step 	= 0.05,
            },
        },
    },
    {
        name = "c_cockpit_param_equal_to",
        fields = {
			{
			    id 				= "cockpit_param",
                type 			= "text",
                default 		= "",
                displayFunc 	= function(cdata,param) return '"'..param..'"' end,
                serializeFunc 	= null_transform,
            },
			{
			    id 				= "value_text",
                type 			= "text",
                default 		= "",
                displayFunc 	= function(cdata,param) return '"'..param..'"' end,
                serializeFunc 	= null_transform,
            },
        },
	},
	{
		name = "c_cockpit_param_is_equal_to_another",
        fields = {
			{
			    id 				= "cockpit_param",
                type 			= "text",
                default 		= "",
                displayFunc 	= function(cdata,param) return '"'..param..'"' end,
                serializeFunc 	= null_transform,
            },
			{
			    id 				= "cockpit_param2",
                type 			= "text",
                default 		= "",
                displayFunc 	= function(cdata,param) return '"'..param..'"' end,
                serializeFunc 	= null_transform,
            },
        },
    },
    {
        name = "c_indication_txt_equal_to",
        fields = {
			{
			    id   	= "indicator_id",
                type 	= "spin",
                default = 0,
                min 	= 0,
                max 	= 100,
                step 	= 1
			},
            {
			    id 				= "element_name",
                type 			= "text",
                default 		= "",
                displayFunc 	= function(cdata,param) return '"'..param..'"' end,
                serializeFunc 	= null_transform,
            },
			{
			    id 				= "element_value",
                type 			= "text",
                default 		= "",
                displayFunc 	= function(cdata,param) return '"'..param..'"' end,
                serializeFunc 	= null_transform,
            },
        },
	},
	{
        name = "c_all_of_group_in_zone",
        fields = {
            {
                id = "group",
                type = "combo",
                comboFunc = groupsLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            },
        }
	},
	{
        name = "c_all_of_group_out_zone",
        fields = {
            {
                id = "group",
                type = "combo",
                comboFunc = groupsLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            },
        }
	},
	{
        name = "c_part_of_group_in_zone",
        fields = {
            {
                id = "group",
                type = "combo",
                comboFunc = groupsLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            },
        }
	},
    {
        name = "c_cargo_unhooked_in_zone",
        fields = {
            {
                id = "cargo",
                type = "combo",
                comboFunc = cargosLister,
                displayFunc = unitIdToName,
                existsFunc = isUnitExists,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            },
        }
	},    
	{
        name = "c_part_of_group_out_zone",
        fields = {
            {
                id = "group",
                type = "combo",
                comboFunc = groupsLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            },
        }
	},
	{
        name = "c_all_of_coalition_in_zone",
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNameRedBlue,
                displayFunc = coalitionIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            },
			{
                id = "unitType",
                type = "combo",
                comboFunc = unitTypeLister,
                serializeFunc = null_transform,
                default = "ALL",
            },
        }
	},
	{
        name = "c_all_of_coalition_out_zone",
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNameRedBlue,
                displayFunc = coalitionIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            },
			{
                id = "unitType",
                type = "combo",
                comboFunc = unitTypeLister,
                serializeFunc = null_transform,
                default = "ALL",
            },
        }
	},
	{
        name = "c_part_of_coalition_in_zone",
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNameRedBlue,
                displayFunc = coalitionIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            },
			{
                id = "unitType",
                type = "combo",
                comboFunc = unitTypeLister,
                serializeFunc = null_transform,
                default = "ALL",
            },
        }
	},
	{
        name = "c_part_of_coalition_out_zone",
        fields = {
            {
                id = "coalitionlist",
                type = "combo",
                comboFunc = CoalitionUtils.listerNameRedBlue,
                displayFunc = coalitionIdToName,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            },
			{
                id = "unitType",
                type = "combo",
                comboFunc = unitTypeLister,
                serializeFunc = null_transform,
                default = "ALL",
            },
        }
	},
	{
        name = "c_player_score_more",
        fields = {
            {
                id = "scores",
                type 	= "spin",
				default = 100,
				min 	= 0,
				max     = 10000,
				step 	= 1,
            },
        }
	},
	{
        name = "c_player_score_less",
        fields = {
            {
                id = "scores",
                type 	= "spin",
				default = 100,
				min 	= 0,
				max     = 10000,
				step 	= 1,
            },
        }
	},
	{
        name = "c_group_life_less",
        fields = {
            {
                id = "group",
                type = "combo",
                comboFunc = groupsLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
                default = "",
            },
            {
                id = "percent",
                type = "spin",
                default = 10,
            },
        }
	},
	{
        name = "c_unit_life_less",
        fields = {
			UNIT_SELECTOR,
            {
                id = "percent",
                type = "spin",
                default = 10,
            },
        }
	},
	{
        name = "c_unit_argument_in_range",
        fields = {
			UNIT_SELECTOR,
            {
                id = "argument",
                type = "spin",
				default = 0,
				min 	= 0,
				max     = 2048,
				step 	= 1,
            },
			{
                id 		= "_min",
                type 	= "spin",
				default = 0,
				min 	= -1,
				max     = 1,
				step 	= 0.05,
            },
			{
                id 		= "_max",
                type 	= "spin",
				default = 0,
				min 	= -1,
				max     = 1,
				step 	= 0.05,
            },
        }
	},
	{
        name = "c_player_unit_argument_in_range",
        fields = {
            {
                id = "argument",
                type = "spin",
				default = 0,
				min 	= 0,
				max     = 2048,
				step 	= 1,
            },
			{
                id 		= "_min",
                type 	= "spin",
				default = 0,
				min 	= -1,
				max     = 1,
				step 	= 0.05,
            },
			{
                id 		= "_max",
                type 	= "spin",
				default = 0,
				min 	= -1,
				max     = 1,
				step 	= 0.05,
            },
        }
	},
	["or"] = -- special predicates have individual key
	{
        name = "or",
		pseudo = true,
		no_and_before = true,
		no_and_after = true,
        fields = {},
	},
--[[
	{
        name = "(",
		pseudo = true,
        fields = {},
	},
	{
        name = ")",
		pseudo = true,
        fields = {},
	},
	{
        name = "not",
		pseudo = true,
        fields = {},
	},
--]]
	{
		name = "c_predicate",
		fields = {
            {
                id = "text",
                type = "medit",
                default = "",
                displayFunc = convertMultilineText,
                serializeFunc = convertMultilineText2,
            }			
		}
	},
	{
        name = "c_signal_flare_in_zone",
        fields = {
            {
                id = "flare_color",
                type = "combo",
                comboFunc = signalFlareColorLister,
                serializeFunc = null_transform,
                default = "",
            },
			{
				id = "numflares",
				type = "spin",
				default = 1,
				min = 1,
				max = 10,
			},
            {
                id = "zone",
                type = "combo",
                comboFunc = zonesLister,
                displayFunc = zoneIdToName,
                existsFunc = isZoneExists,
                serializeFunc = null_transform,
                default = "",
            }        
        }
    },
	{	
        name = "c_unit_hit",
        fields = {
			UNIT_SELECTOR,
            {
				id = "numhits",
				type = "spin",
				default = 1,
				min = 1,
				max = 100,
			},
        }    
	},
	{
        name = "c_unit_fuel_less",
        fields = {
			UNIT_SELECTOR,
			{
                id = "fuel_percent",
				type = "spin",
				default = 50,
				min 	= 0,
				max     = 200,
				step 	= 1,
            },     
        }
    },
	{
        name = "c_unit_fuel_higher",
        fields = {
			UNIT_SELECTOR,
			{
                id = "fuel_percent",
				type = "spin",
				default = 90,
				min 	= 0,
				max     = 200,
				step 	= 1,
            },     
        }
    },
	{
        name = "c_group_member_fuel_less",
        fields = {
			{
                id = "group",
                type = "combo",
                comboFunc = groupsLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
                default = "",
            },
			{
                id = "fuel_percent",
				type = "spin",
				default = 50,
				min 	= 0,
				max     = 200,
				step 	= 1,
            },
			{
                id = "members_number",
                type 	= "spin",
				default = 1,
				min 	= 1,
				max     = 4,
				step 	= 1,
            },
        }
    },
	{
        name = "c_group_member_fuel_higher",
        fields = {
			{
                id = "group",
                type = "combo",
                comboFunc = groupsLister,
                displayFunc = groupIdToName,
                existsFunc = isGroupExists,
                serializeFunc = null_transform,
                default = "",
            },
			{
                id = "fuel_percent",
				type = "spin",
				default = 90,
				min 	= 0,
				max     = 200,
				step 	= 1,
            },
			{
                id = "members_number",
                type 	= "spin",
				default = 1,
				min 	= 1,
				max     = 4,
				step 	= 1,
            },
        }
    },
	
};

cdata = {
    ChooseMissionFile = _('Choose mission file'),

    predicates = {
        c_unit_alive = _("UNIT ALIVE"),
        c_unit_dead = _("UNIT DEAD"),
        c_group_alive = _("GROUP ALIVE"),
        c_group_dead = _("GROUP DEAD"),
        c_unit_damaged = _("UNIT DAMAGED"),
        c_time_after = _("TIME MORE"),
        c_time_before = _("TIME LESS"),
        c_bomb_in_zone = _("BOMB IN ZONE"),
		c_dead_zone = _("MAP OBJECT IS DEAD"), 
        c_missile_in_zone = _("MISSILE IN ZONE"),
		c_mlrs_in_zone = _("MLRS IN ZONE"),
        c_unit_in_zone = _("UNIT IN ZONE"),
        c_unit_out_zone = _("UNIT OUTSIDE ZONE"),
        c_unit_in_zone_unit = _("UNIT IN MOVING ZONE"),
        c_unit_out_zone_unit = _("UNIT OUTSIDE OF MOVING ZONE"),
        c_flag_is_true = _("FLAG IS TRUE"),
        c_flag_is_false = _("FLAG IS FALSE"),
        c_flag_more = _("FLAG IS MORE"),
        c_flag_less = _("FLAG IS LESS"),
        c_flag_less_flag = _("FLAG IS LESS THAN FLAG"),
		c_flag_equals = _("FLAG EQUALS"),
		c_flag_equals_flag = _("FLAG EQUALS FLAG"),
        c_time_since_flag = _("TIME SINCE FLAG"),
        c_random_less 	= _("RANDOM"),
        c_unit_altitude_higher = _("UNIT'S ALTITUDE HIGHER THAN"),
        c_unit_altitude_lower = _("UNIT'S ALTITUDE LOWER THAN"),
		c_unit_altitude_higher_AGL = _("UNIT'S AGL ALTITUDE HIGHER THAN"),
        c_unit_altitude_lower_AGL  = _("UNIT'S AGL ALTITUDE LOWER THAN"),
        c_unit_speed_higher = _("UNIT'S SPEED HIGHER THAN"),
        c_unit_speed_lower = _("UNIT'S SPEED LOWER THAN"),
		
		c_unit_heading 			 = _("UNIT'S HEADING IN LIMITS"),
		c_unit_pitch  			 = _("UNIT'S PITCH IN LIMITS"),
		c_unit_bank    			 = _("UNIT'S BANK IN LIMITS"),
		c_unit_vertical_speed    = _("UNIT'S VERTICAL SPEED IN LIMITS"),
		
		
	
        c_mission_score_higher = _("MISSION SCORE HIGHER THAN"),
        c_mission_score_lower = _("MISSION SCORE LOWER THAN"),
		c_coalition_has_airdrome = _("COALITION HAS AIRDROME"),
		c_coalition_has_helipad  = _("COALITION HAS HELIPAD"),	
		c_cockpit_param_in_range    = _("COCKPIT PARAM IN RANGE"),
		c_cockpit_param_equal_to    = _("COCKPIT PARAM EQUAL TO"),
		c_argument_in_range		    = _("COCKPIT ARGUMENT IN RANGE"),
		c_cockpit_highlight_visible = _("COCKPIT HIGHLIGHT IS VISIBLE"),
		c_cockpit_param_is_equal_to_another = _("COCKPIT PARAM IS EQUAL TO ANOTHER"),
		c_indication_txt_equal_to           = _("COCKPIT INDICATION TEXT IS EQUAL TO"),
		c_all_of_group_in_zone = _("ALL OF GROUP IN ZONE"),
		c_all_of_group_out_zone = _("ALL OF GROUP OUT OF ZONE"),
		c_part_of_group_in_zone = _("PART OF GROUP IN ZONE"),
		c_part_of_group_out_zone = _("PART OF GROUP OUT OF ZONE"),
		c_all_of_coalition_in_zone = _("ALL OF COALITION IN ZONE"),
		c_all_of_coalition_out_zone = _("ALL OF COALITION OUT OF ZONE"),
		c_part_of_coalition_in_zone = _("PART OF COALITION IN ZONE"),
		c_part_of_coalition_out_zone = _("PART OF COALITION OUT OF ZONE"),
		c_player_score_more = _("PLAYER SCORES MORE"),
		c_player_score_less = _("PLAYER SCORES LESS"),
        
        c_cargo_unhooked_in_zone = _("CARGO UNHOOKED IN ZONE"),
		
		c_group_life_less = _("GROUP ALIVE LESS THAN"),
		c_unit_life_less = _("UNIT'S LIFE LESS THAN"),
		c_unit_argument_in_range = _("UNIT'S ARGUMENT IN RANGE"),
		c_player_unit_argument_in_range = _("PLAYER'S UNIT ARGUMENT IN RANGE"),

		c_predicate = _("LUA PREDICATE"),
		
		-- pseudo predicates
		["or"] = _("[OR]"),
		
		c_signal_flare_in_zone 	= _("SIGNAL FLARE IN ZONE"),
		c_unit_hit				= _("UNIT HITS"),
		c_unit_fuel_less		= _("UNIT FUEL LESS THEN"),
		c_unit_fuel_higher		= _("UNIT FUEL HIGHER THEN"),
		c_group_member_fuel_less	= _("GROUP MEMBERS FUEL LESS THEN"),
		c_group_member_fuel_higher	= _("GROUP MEMBERS FUEL HIGHER THEN"),
--[[
		["not"] = _("OPERATOR [NOT]"),
		["("] = _("OPEN PARETHENESS [(]"),
		[")"] = _("CLOSE PARETHENESS [)]"),
--]]
    },

    values = {
        unit            = _("UNIT:"),
        group           = _("GROUP:"),
        cargo           = _("CARGO:"),
        zone            = _("ZONE:"),
        typebomb        = _("TYPE BOMB:"),
        typemissile     = _("TYPE MISSILE:"),
        numbombs        = _("BOMB QUANTITY:"),
        nummissiles     = _("VALUE:"),
        seconds         = _("SECONDS:"),
        flag            = _("FLAG:"),
        flag2           = _("FLAG:"),
        percent         = "%",
        zoneunit        = _("ZONE UNIT:"),
        coalitionlist   = _("COALITION:"),
        altitude        = _("ALTITUDE:"),
        speed           = _("SPEED m/c:"),
        speedU          = _("SPEED:"),
        airdromelist    = _("AIRDROME:"),
		helipadlist     = _("FARP:"),
        _min            = _("MIN:"),
        _max            = _("MAX:"),
		_min2           = _("MIN:"),
        _max2           = _("MAX:"),
		
		cockpit_param   = _("PARAM:"),
        cockpit_param2  = _("PARAM:"),
		argument        = _("argument:"),
		command	        = _("COMMAND:"),
		value           = _("VALUE:"),
		element_name    = _("ELEM NAME:"),
		highlight_id    = _("ID:"),
		scores          =  _("SCORES:"),
		min_unit_vertical_speed = _("MIN:"),
		max_unit_vertical_speed = _("MAX:"),
		min_unit_heading = _("MIN:"),
		max_unit_heading = _("MAX:"),
		min_unit_pitch  = _("MIN:"),
		max_unit_pitch  = _("MAX:"),
		min_unit_bank   = _("MIN:"),
		max_unit_bank   = _("MAX:"),
		flare_color     = _("FLARE COLOR"),
		numflares       = _("VALUE:"),
		numhits			= _("HITS NUMBER:"),
		unitType		= _("UNIT TYPE")..":",
		fuel_percent	= _("FUEL PERCENT:"),
		members_number	= _("MEMBERS NUMBER:"),
    },

	ALL 		= _("ALL"),
	AIRPLANE 	= _("AIRPLANE"),
	HELICOPTER 	= _("HELICOPTER"),
	NAVAL 		= _("NAVAL"),
	GROUND 		= _("GROUND"),

}

if ProductType.getType() == "LOFAC" then
    cdata.predicates.c_mission_score_higher = _("MISSION SCORE HIGHER THAN-LOFAC")
    cdata.predicates.c_mission_score_lower = _("MISSION SCORE LOWER THAN-LOFAC")
    cdata.ChooseMissionFile = _('Choose mission file-LOFAC')
    cdata.predicates.c_unit_life_less = _("UNIT'S LIFE LESS THAN-LOFAC")
    cdata.predicates.c_unit_in_zone_unit = _("UNIT IN MOVING ZONE-LOFAC")
    cdata.predicates.c_unit_out_zone_unit = _("UNIT OUTSIDE OF MOVING ZONE-LOFAC")
    cdata.predicates.c_unit_life_less = _("UNIT'S LIFE LESS THAN-LOFAC")
    cdata.predicates.c_unit_in_zone_unit = _("UNIT IN MOVING ZONE-LOFAC")
    cdata.values.zoneunit        = _("ZONE UNIT:-LOFAC")
    cdata.values.unit            = _("UNIT:-LOFAC")
end

-- return index of value in table
function getIndex(table, value)
  local idx = 1 
  for _tmp, v in ipairs(table) do
      if v == value then
          return idx
      end
      idx = idx + 1
  end
  return idx
end


-- add rules to the list
function rulesToList(list, rules, cdata)
	list:clear()
	if rules then
		for _tmp, v in ipairs(rules) do			
			local item = U.addListBoxItem(list, getRuleAsText(v, cdata), v)
			if v.colorItem then
				local tmpSkin = item:getSkin()
				local newSkin = SkinUtils.setListBoxItemTextColor(v.colorItem, tmpSkin)
				item:setSkin(newSkin)
			end
		end
	end
	list:onChange(nil)
end


-- build text from rule
function getRuleAsText(rule, cdata)
    local ruleDescr = rule.predicate
	if ruleDescr.pseudo then return getPredicateName(ruleDescr, cdata) else
		local str = getPredicateName(ruleDescr, cdata) .. ' ('

		local first = true
		local needComma = false
		for _tmp, field in ipairs(ruleDescr.fields) do
			if needComma then
				str = str .. ', '
			else
				needComma = true
			end

			local text
			if field.displayFunc then
                text = field.displayFunc(cdata, rule[field.id] or field.default, rule["data"])
			else
                if (field.type == "file_edit") or (field.type == "file_script") or (field.type == "file_img") then
                    text = tostring(mod_dictionary.getValueResource(rule[field.id]) or field.default)
                else
                    text = tostring(rule[field.id] or field.default)
                end
			end

			if first and ruleDescr.firstValueAsName then
				str = text .. ' ('
				needComma = false
			else
				str = str .. text
			end

			first = false
		end

		str = str .. ')'
		return str
	end
end

-- returns localized version of getRuleAsText function
function ruleTextFunc(cdata)
    return function (rule) 
        return getRuleAsText(rule, cdata) 
    end
end



-- update row in list
function updateListRow(list, displayFunc)
    local item = list:getSelectedItem()
    if item then
        local struct = item.itemId
        item:setText(displayFunc(struct))
    end
end


-- gets structure from list, sets value in structure and update row in list
-- in order to get value it uses function getValueFunc(control)
function bindAbstractValue(	control, list, valueName, displayFunc, 
							getValueFunc)
    function control:onChange(itemValue)  
        local item = list:getSelectedItem()
        if item then
            local struct = item.itemId
			local tmp
            struct[valueName], tmp = getValueFunc(control, itemValue, struct[valueName])   
			if tmp then
				struct["data"] = tmp
			end	
            updateListRow(list, displayFunc)
        end
    end
    
    local item = list:getSelectedItem()
    local struct
    if item then
        struct = item.itemId
    end
    return (struct[valueName] == nil or struct[valueName] == "")
end

-- links value in text editor control, value in structure and list box
function bindTextValue(control, list, valueName, displayFunc)
    bindAbstractValue(control, list, valueName, displayFunc,
        function (c, itemValue)         
            local text = c:getText();    
            return text; 
        end)
end

function bindResourceValue(control, list, valueName, displayFunc)
    bindAbstractValue(control, list, valueName, displayFunc,
        function (c, itemValue)          
            local text =c.file 
            --base.print("--------text=",text)    
            return text; 
        end)
end

-- links value in combo box, value in structure and list box
function bindComboValue(control, list, valueName, displayFunc)
    return bindAbstractValue(control, list, valueName, displayFunc,
        function (combo, item)
            if not combo.nameValue then
                return combo:getText()
            else
                return item.id, item.data
            end
        end)
end


-- links value in spinbox control, value in structure and list box
function bindNumValue(control, list, valueName, displayFunc)
    bindAbstractValue(control, list, valueName, displayFunc,
        function (c) 
            local value = c:getValue()
            if control.controlU then
                value = control.controlU:getValue()             
            end  
            return value 
            end)
end

-- links value in spinbox control, value in structure and list box
function bindNumValuePositive(control, list, valueName, displayFunc)
    bindAbstractValue(control, list, valueName, displayFunc,
        function (c) 
            local text = c:getText();
            local number = text and tonumber(text) or 0;
            return (number > 0) and number or 0;
        end)
end

-- links value in checkbox control, value in structure and list box
function bindCheckboxValue(control, list, valueName, displayFunc)
    bindAbstractValue(control, list, valueName, displayFunc,
        function (c) return c:getState(); end)
end

-- returns display name of predicate
function getPredicateName(desc, cdata)
    return cdata.predicates[desc.name] or desc.name
end

-- fill predicates combo with predicate values
function fillPredicatesCombo(combo, descr, cdata)
	local function PredicatesComparator(v1, v2)
		if not v1 then
			return true
		end
		
		if not v2 then
			return false
		end

		return getPredicateName(v1, cdata) < getPredicateName(v2, cdata)
	end

    combo:clear()

    base.table.sort(descr, PredicatesComparator)

    local first = nil
    for _tmp, v in ipairs(descr) do
        local item = U.addComboBoxItem(combo, getPredicateName(v, cdata), v)
        if not first then
            first = item
        end
    end
    if first then
        combo.selectedItem = first.itemId
        combo:setText(getPredicateName(first.itemId, cdata))        
    end
end


-- fill dictionary
function fillDict(combo, fun, needDefault)
    local first 
    if fun then
        local tbl = fun()
        for _tmp, v in ipairs(tbl) do
            local item
            if type(v) == 'table' then
                combo.nameValue = true
                item = ListBoxItem.new(v.name)
                item.id = v.id
                item.name = v.name
				item.data = v.data
                combo:insertItem(item)               
            else
                combo.nameValue = false
                item = U.addComboBoxItem(combo, v)                
            end
            if first == nil then
                first = item
            end 
        end
    end
    
    if first and needDefault then
        combo:selectItem(first)
        combo:onChange(first)
    end
end


local function trivialComapreFunc(left, right)
	return left == right
end

-- set value of combo box
-- if combo box works with tuple, finds text in tuples list
function setComboListValue(comboList, value, compareFunc)
	compareFunc = compareFunc or trivialComapreFunc
    if not comboList.nameValue then
        comboList:setText(value)
    else
        local itemCounter = comboList:getItemCount() - 1
		
        for i = 0, itemCounter do
			local item = comboList:getItem(i)
			
            if compareFunc and compareFunc(item.id, value) then
                comboList:selectItem(item)
				
                return
            end
        end
    end
end

-- create widgets for predicate editing
function updateArgumentsPanel(rule, list, ctr, labelX, comboX, labelW, 
        comboW, comboH, cdata)
		
    local ruleDescr = rule.predicate

    ctr:removeAllWidgets()
    
    local offsetX, _tmp, ctrW, _tmp = ctr:getBounds()
    labelX = labelX - offsetX
	labelW = labelW + 40
    comboX = comboX - offsetX + 40
	comboW = comboW - 40

    local y = 1
    for _tmp, field in ipairs(ruleDescr.fields) do
		
		local _x, _y, _w, _h = comboX, y, comboW, comboH;
		local label = Static.new(cdata.values[field.title or field.id])
		label:setSkin(staticSkin)		
		label:setBounds(labelX, y, labelW, comboH)
		ctr:insertWidget(label)
	
		local control
		if (field.type == "combo") then
			control = ComboList.new()
			control:setSkin(comboListSkin)
			local needDefault = bindComboValue(control, list, field.id, ruleTextFunc(cdata))
			fillDict(control, field.comboFunc, needDefault)
			local value = rule[field.id]
			if not value then value = field.default end
			setComboListValue(control, value, field.compareFunc)
		elseif (field.type == "spin") then 
            if field.measureUnits then
                local container = Panel.new();
                _h = 1.5 * comboH
                control = SpinBox.new()
                control:setSkin(spinBoxSkin)
                local min = 0
                local max = 1000
                local step = 1
                if (nil ~= field.min) and (nil ~= field.max) then
                    control:setRange(field.min, field.max)
                    min = field.min
                    max = field.max
                end
                if nil ~= field.step then
                    control:setStep(field.step)
                    if field.step < 1 then
                        control:setAcceptDecimalPoint(true)
                    end
                    step = field.step
                end			
                bindNumValue(control, list, field.id, ruleTextFunc(cdata))
                control:setBounds(0, 0, comboW*0.52, comboH)
                container:insertWidget(control)

                local label = Static.new()
                label:setSkin(staticSkin)	            
                label:setBounds(comboW*0.54, 0, comboW*0.2, comboH)
                container:insertWidget(label)
            
                controlU = U.createUnitSpinBox(label, control, U.speedUnits, min, max, step) 
                controlU:setUnitSystem(OptionsData.getUnits())  
                controlU:setValue(rule[field.id] or field.default)        
                control.controlU = controlU
                control = container
            else
                control = SpinBox.new()
                control:setSkin(spinBoxSkin)
                if (nil ~= field.min) and (nil ~= field.max) then
                    control:setRange(field.min, field.max)
                end
                if nil ~= field.step then
                    control:setStep(field.step)
                    if field.step < 1 then
                        control:setAcceptDecimalPoint(true)
                    end
                end
                bindNumValue(control, list, field.id, ruleTextFunc(cdata))
                control:setValue(rule[field.id] or field.default)
            end
		elseif (field.type == "spinbearing") then
			control = SpinBox.new()
			control:setSkin(spinBoxSkin)
			control:setRange(0, 359)
			control:setStep(1)
			bindNumValue(control, list, field.id, ruleTextFunc(cdata))
			control:setValue(rule[field.id])
		elseif (field.type == "positive_number") then            
            control = EditBox.new()
            control:setSkin(editBoxSkin)
            control:setNumber(true);            
            bindNumValuePositive(control, list, field.id, ruleTextFunc(cdata))	
            control:setText(rule[field.id])   
		elseif (field.type == "checkbox") then
			control = CheckBox.new()
			control:setSkin(checkBoxSkin)
			bindCheckboxValue(control, list, field.id, ruleTextFunc(cdata))
			control:setState(rule[field.id])
		elseif (field.type == "medit") then
			control = EditBox.new()
			control:setSkin(editBoxSkin)
			control:setMultiline(true)
			bindTextValue(control, list, field.id, ruleTextFunc(cdata))
			control:setText(rule[field.id])
			_x, _y, _w, _h = comboX, y, comboW, 5*comboH;
		elseif (field.type == "file_edit") then
			local container = Panel.new();
            _h = 3.5 * comboH
			local edit = EditBox.new()
			edit:setSkin(editBoxSkin)
            edit:setReadOnly(true)
            edit.file = ruleDescr.file 
			control = edit;
			bindResourceValue(control, list, field.id, ruleTextFunc(cdata))
            control:setText(mod_dictionary.getValueResource(rule[field.id]))
			control:setBounds(0, 0, comboW*0.69, comboH)
			container:insertWidget(control)
			control = Button.new()
			control:setSkin(buttonSkin)
			control.edit = edit;
			bindAbstractValue(control, list, field.id, ruleTextFunc(cdata),
								chooseSound);

			control:setBounds(comboW*0.71, 0, comboW*0.29, comboH)
			control:setText(cdata.open);
			container:insertWidget(control)
                 
            control = SoundPlayer.new() 
            control.edit = edit;
            container:insertWidget(control:getContainer())  
            control:setBounds(0, comboH*1.5, comboW, 60) 
            edit.SoundPlayer = control 
            if edit.file then
                local tmp, path = mod_dictionary.getValueResource(edit.file)
				if path then
					control:setPathSound(base.tempMissionPath .. path)
				else
					control:setPathSound()
				end
            end    
			control = container;
            
			
		elseif (field.type == "file_miz") then
			local container = Panel.new();
			local edit = EditBox.new()
			edit:setSkin(editBoxSkin)
            edit:setReadOnly(true)            
			control = edit;
			bindTextValue(control, list, field.id, ruleTextFunc(cdata))
			control:setText(rule[field.id])
			control:setBounds(0, 0, comboW*0.69, comboH)
			container:insertWidget(control)
			control = Button.new()
			control:setSkin(buttonSkin)
			control.edit = edit;
			bindAbstractValue(control, list, field.id, ruleTextFunc(cdata),
								chooseMiz);

			control:setBounds(comboW*0.71, 0, comboW*0.29, comboH)
			control:setText(cdata.open);            
			container:insertWidget(control)
			control = container;     
		elseif (field.type == "file_img") then
			local container = Panel.new();
			local edit = EditBox.new()
			edit:setSkin(editBoxSkin)
            edit:setReadOnly(true)
            edit.file = ruleDescr.file 
			control = edit;
			bindResourceValue(control, list, field.id, ruleTextFunc(cdata))
			control:setText(mod_dictionary.getValueResource(rule[field.id]))
			control:setBounds(0, 0, comboW*0.69, comboH)
			container:insertWidget(control)
			control = Button.new()
			control:setSkin(buttonSkin)
			control.edit = edit;
			bindAbstractValue(control, list, field.id, ruleTextFunc(cdata),
								chooseImg);

			control:setBounds(comboW*0.71, 0, comboW*0.29, comboH)
			control:setText(cdata.open);
			container:insertWidget(control)
			control = container;
		elseif (field.type == "file_script") then
			local container = Panel.new();
			local edit = EditBox.new()
			edit:setSkin(editBoxSkin)
            edit:setReadOnly(true)
            edit.file = ruleDescr.file 
			control = edit;
			bindTextValue(control, list, field.id, ruleTextFunc(cdata))
			control:setText(mod_dictionary.getValueResource(rule[field.id]))
			control:setBounds(0, 0, comboW*0.69, comboH)
			container:insertWidget(control)
			control = Button.new()
			control:setSkin(buttonSkin)
			control.edit = edit;
			bindAbstractValue(control, list, field.id, ruleTextFunc(cdata),
								chooseScript);

			control:setBounds(comboW*0.71, 0, comboW*0.29, comboH)
			control:setText(cdata.open);
			container:insertWidget(control)
			control = container;		
		else
			control = EditBox.new()
			control:setSkin(editBoxSkin)
			bindTextValue(control, list, field.id, ruleTextFunc(cdata))
			control:setText(rule[field.id])
		end
		control:setBounds(_x, _y, _w, _h)
		ctr:insertWidget(control)
  
		y = _y + _h + 2
    end

	ctr:setSize(ctrW, y)
	
	return y
end


-- copy default values from rule descriptions
function setRuleDefaults(rule, descr)
    for _tmp, v in ipairs(descr.fields) do
        if not rule[v.id] then
            rule[v.id] = v.default
        end
    end
end


-- create new rule from description
function createRule(descr)
    local res = { predicate = descr; }
    setRuleDefaults(res, descr)
    return res
end


-- show or hide widgets (passed as variable length arguments) and remove
-- all children from container
function showWidgets(visible, container, ...)
    for _tmp, v in ipairs{...} do
        v:setVisible(visible)
    end
    if not visible then
        container:removeAllWidgets()
		container:setVisible(false)
	else
		container:setVisible(true)
    end
end


-- index rules by name
function getRulesIndex(rules)
    local result = { }
    for _tmp, rule in pairs(rules) do
        result[rule.name] = rule
    end
    return result
end


local function valueToString(value)
	if base.type(value) ==  "string" then
	   return base.string.format('%q', value)
	elseif value ~= nil then
	   return base.tostring(value)
	else
		return ''
	end
end

local function addValuesToString(...)
	local str = ''
	--base.print(' ---------- addValuesToString -------------')
	for index, value in base.ipairs{...} do
		--base.print("---addValuesToString---",index,value,valueToString(value))
		if base.string.len(str) > 0 then
			str = str..', '
		end
		str = str..valueToString(value)
	end
	return str
end

-- convert rule to function call
function actionToString(rule)
	if rule.predicate.pseudo then 
        return rule.predicate.name 
    else
		local str = rule.predicate.name .. '(';
		local firstArg = true
		for _tmp, field in ipairs(rule.predicate.fields) do
			if not firstArg then
			  str = str .. ', '
			else
			  firstArg = false
			end
            
            local value
            if field.id == "text" and rule.predicate.name ~= 'a_do_script' then
                str = str .. 'getValueDictByKey('
                value = rule.KeyDict_text
            elseif field.id == "radiotext" then  
                str = str .. 'getValueDictByKey('
                value = rule.KeyDict_radiotext
			elseif field.id == "comment" then  
                str = str .. 'getValueDictByKey('
                value = rule.KeyDict_comment	
            else
                if field.type == "file_edit" or field.type == "file_script" or field.type == "file_img" then
                    str = str .. 'getValueResourceByKey('
                end
                value = rule[field.id]
            end
			
			if not value then value = field.default end
			if field.serializeFunc then
				str = str..addValuesToString(field.serializeFunc(cdata, value))
			elseif field.serializeTblFunc then	
				str = str..field.serializeTblFunc(cdata, value, rule.data)
			elseif field.displayFunc then
				str = str..addValuesToString(field.displayFunc(cdata, value))
			else
                if field.id == "frequency" then  
                    str = str..valueToString(value*1000)
                else
                    str = str..valueToString(value)
                end
			end
            if (field.id == "text" or field.id == "comment" or field.type == "file_edit"
                or field.id == "radiotext" or field.type == "file_script"  or field.type == "file_img")
				 and rule.predicate.name ~= 'a_do_script' then
                str = str .. ')'
            end    
		end
		str = str .. ')'
		return str
	end
end

local fileDialogDataHolder = {}

local function addFileDialogData(type, filters)
	local getPathFuncName = 'get' .. type .. 'Path'
	local setPathFuncName = 'set' .. type .. 'Path'
	
	fileDialogDataHolder[type] = {
		getPathFunc     = MeSettings[getPathFuncName], 
		savePathFunc    = MeSettings[setPathFuncName],
		filters         = filters,
	}
end

addFileDialogData('Sound', {FileDialogFilters.sound()})
addFileDialogData('Mission', {FileDialogFilters.mission()})
addFileDialogData('Image', {FileDialogFilters.image()})
addFileDialogData('Script', {FileDialogFilters.script()})

function chooseAndAttachFile(type, caption, edit, oldFile)
 --base.print("---chooseAndAttachFile---",edit.file,type, caption, oldFile)

	local fileDialogData = fileDialogDataHolder[type]
	local filename = FileDialog.open(fileDialogData.getPathFunc(), fileDialogData.filters, caption)
    local text
	
	if filename then
		fileDialogData.savePathFunc(filename)  
		if type ~= 'Script' then
			edit.file = mod_dictionary.setValueToResource(edit.file,U.extractFileName(filename),filename)
		else
			edit.file = mod_dictionary.setValueToResource(edit.file,U.extractFileName(filename),filename, "DEFAULT")
		end
        text = edit.file-- mod_dictionary.getValueResource(edit.file)
        edit:setText(mod_dictionary.getValueResource(edit.file))
        if edit.SoundPlayer then
            local tmp, path = mod_dictionary.getValueResource(edit.file)            
			if path then
				edit.SoundPlayer:setPathSound(base.tempMissionPath .. path)
			else
				edit.SoundPlayer:setPathSound()
			end
        end
        edit:onChange()    
    else    
        text = edit.file
	end
  
    return text
end

function chooseFile(type, caption, edit, oldFile)
	local fileDialogData = fileDialogDataHolder[type]
	local filename = FileDialog.open(fileDialogData.getPathFunc(), fileDialogData.filters, caption)
	
	if filename then
		fileDialogData.savePathFunc(filename)		

		edit:setText(U.extractFileName(filename))
		edit:onChange()
	end
    
    return edit:getText()
end

function chooseSound(control, itemValue, oldFile)
	return chooseAndAttachFile('Sound', _('Choose sound file'), control.edit, oldFile)
end

function chooseMiz(control, itemValue, oldFile)
	return chooseFile('Mission', cdata.ChooseMissionFile, control.edit, oldFile)
end

function chooseImg(control, itemValue, oldFile)
	return chooseAndAttachFile('Image', _('Choose image file'), control.edit, oldFile)
end

function chooseScript(control, itemValue, oldFile)
	return chooseAndAttachFile('Script', _('Choose script'), control.edit, oldFile)
end

-- returns true if predicate valid
function isValidRule(rule)
    if not rule or not rule.predicate or not rule.predicate.fields then return false end
    
    for _tmp, v in pairs(rule.predicate.fields) do
        if v.existsFunc and (not v.existsFunc(rule[v.id])) then
            return false
        end
        
        if rule.predicate.name == 'a_out_sound' 
            or rule.predicate.name == 'a_out_sound_c' 
            or rule.predicate.name == 'a_out_sound_s'  
            or rule.predicate.name == 'a_out_sound_g'
			or rule.predicate.name == 'a_out_picture' 
			or rule.predicate.name == 'a_out_picture_c' 
			or rule.predicate.name == 'a_out_picture_s' 
			or rule.predicate.name == 'a_out_picture_g' then
            
            if rule.file == nil or mod_dictionary.getValueResource(rule.file) == nil then
                return false
            end
        end        

    end
    return true
end


-- remove all invalid rules from rules list
function removeInvalidRules(rulesList)
    local toRemove = { }

	for i = #rulesList, 1, -1 do
		local rule = rulesList[i]
		
		if i == #rulesList and rule.predicate and rule.predicate.name == 'or' then
			rulesList[i] = nil
		end		
    end
	
    for i = 1, #rulesList do
        if not isValidRule(rulesList[i]) then
            table.insert(toRemove, i)
        end
    end

    for i = 1, #toRemove do
        table.remove(rulesList, toRemove[i] - (i - 1))
    end
end

