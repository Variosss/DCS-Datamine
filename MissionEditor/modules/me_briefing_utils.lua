local MissionModule			= require('me_mission')
local crutches				= require('me_crutches')
local CoalitionController	= require('Mission.CoalitionController')

local function extractPlayerDetails()
    local enemy = ''
    local alliesString = ''
    local countryName
    local enemiesString = ''
    local group
    local country
    local coalition
    local playerUnit
    local player
	local coalitionName
    local sortie = ''

    local mission = MissionModule.mission
    if not MissionModule.unit_by_id then
        print('MissionModule.unit_by_id .. does not exist')
        return false
    end
    
	local playerCountryId
    for id, unit in pairs(MissionModule.unit_by_id) do
        if unit.skill == crutches.getPlayerSkill() then
            group = unit.boss
            local country = group.boss
            coalition = country.boss
            countryName = country.name
			playerCountryId = country.id
            playerUnit = unit
            player = unit
            break
        end
    end

    if (mission.sortie) then
        sortie = mission.sortie
    end
    
	local RedCoalitionNames = {}
	local BlueCoalitionNames = {}
	local NeutralCoalitionNames = {}
	
	function getCountryCoalitionNames()
		local tmpCountry = {}
		for id, unit in pairs(MissionModule.unit_by_id) do
			local group = unit.boss
            local country = group.boss   
			local coalitionNameCountry = country.boss.name
			
			if playerCountryId ~= country.id and tmpCountry[country.id] == nil then				
				tmpCountry[country.id] = country.id
				if coalitionNameCountry == CoalitionController.redCoalitionName() then
					table.insert(RedCoalitionNames, CoalitionController.getCountryNameById(country.id))
				elseif coalitionNameCountry == CoalitionController.blueCoalitionName() then
					table.insert(BlueCoalitionNames, CoalitionController.getCountryNameById(country.id))
				elseif coalitionNameCountry == CoalitionController.neutralCoalitionName() then
					table.insert(NeutralCoalitionNames, CoalitionController.getCountryNameById(country.id))
				end		
			end	
		end	
		CoalitionController.sortCountryNames(RedCoalitionNames)
		CoalitionController.sortCountryNames(BlueCoalitionNames)
		CoalitionController.sortCountryNames(NeutralCoalitionNames)
	end
	getCountryCoalitionNames()
	
    if player then 		
        countryName = countryName or ''
		
		local redCoalitionName = CoalitionController.redCoalitionName()
		local blueCoalitionName = CoalitionController.blueCoalitionName()
		local neutralCoalitionName = CoalitionController.neutralCoalitionName()
		local separator = ' - '
       
        if coalition.name == redCoalitionName then
            coalitionName = redCoalitionName
            enemy = blueCoalitionName
			alliesString = table.concat(RedCoalitionNames, separator)
			enemiesString = table.concat(BlueCoalitionNames, separator)
        elseif coalition.name == blueCoalitionName then
            coalitionName = blueCoalitionName
            enemy = redCoalitionName
			alliesString = table.concat(BlueCoalitionNames, separator)
			enemiesString = table.concat(RedCoalitionNames, separator)
		else
			coalitionName = neutralCoalitionName
			alliesString = table.concat(NeutralCoalitionNames, separator)
        end
    end

    return  playerUnit, 
            player, 
            group, 
            countryName, 
            coalition, 
            alliesString, 
            enemiesString, 
            sortie, 
            coalitionName
end
    
return {
	extractPlayerDetails = extractPlayerDetails,
}