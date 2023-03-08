
lau115_weight	= 54.4
lau127_weight	= 45.3

LAU_117_mass	= 59

bru_33VER_mass	= 91			-- 200 lb
bru_41MER_mass	= 127.913		-- 282 lb
bru_55VER_mass	= 87.5			-- 193 lb
bru_57VER_mass	= 112			-- 247 lb
ter_9a_mass		= 53			-- 117 lb

-- TER-9/A
local ter_9a_conn = 
{
	[1] = { connector_name = "Point01" },	-- chin
	[2] = { connector_name = "Point02" },	-- left shoulder
	[3] = { connector_name = "Point03" },	-- right shoulder
}

local ter_9a_adapter = { ShapeName = "TER-9A", IsAdapter = true, }

element_self_attach_point = 
{	
	["BDU-33"] = {0.180,0,0}
}

local function ter_9a_element(element,i)
	return { ShapeName = element, connector_name = ter_9a_conn[i].connector_name, attach_point_position = element_self_attach_point[element]}
end

function ter_9a_two_left(element)
	return	{
		ter_9a_adapter,
		ter_9a_element(element, 1),	
		ter_9a_element(element, 2),
	}
end

function ter_9a_two_right(element)
	return	{
		ter_9a_adapter,
		ter_9a_element(element, 1),	
		ter_9a_element(element, 3),
	}
end

function ter_9a_three(element)
	return	{
		ter_9a_adapter,
		ter_9a_element(element, 1),	
		ter_9a_element(element, 2),
		ter_9a_element(element, 3),
	}
end

-- Rafaut AUF2 Bomb Rack
function create_AUF2(bomb_shape, mass, tbl)
	local rafaut_rot = 0
	local rafaut_auf2_points = {
		[1] = {Position = {-0.011874, -0.162894, -0.220}, Rotation = { rafaut_rot, 0, 0} },-- left
		[2] = {Position = {-0.011874, -0.162894,  0.220}, Rotation = {-rafaut_rot, 0, 0} },-- right
	}
	local elements = {}

	tbl.category 	= CAT_BOMBS
	tbl.attribute	= {wsType_Weapon, wsType_Bomb, wsType_Container, WSTYPE_PLACEHOLDER}
	tbl.Count		= 2
	tbl.Cx_pil		= 0.001 + 2 * tbl.Cx_pil
	tbl.displayName = "AUF2 - 2 x " .. tbl.displayName
	tbl.Weight		= 75 + 2 * mass

	table.insert(elements, { ShapeName = "M-2000C_AUF2", IsAdapter = true })
	for i = 1, 2 do
		table.insert(elements, {
			ShapeName = bomb_shape, Position = rafaut_auf2_points[i].Position,
			Rotation = rafaut_auf2_points[i].Rotation
		})
	end

	tbl.Elements = elements

	return tbl
end

---Create a container model and fill it with subshapes
---@param shape				string filename of the container model
---@param element			string filename of the subshape model/CLSID of the subpayload
---@param count				number quantity of subshapes
---@param pattern			string optional; default "tube_%02d" - base attach connector name
---@param indexSkipTable	table optional; default {} - table of indexes of connectors to skip
---@param isElementAsCLSID	boolean optional; default false - whether the subelement is a ShapeName or a CLSID
---@return					table ret shape table of the container with attached subshapes
function ContainerWithSubshapes(shape, element, count, pattern, indexSkipTable, isElementAsCLSID)
	indexSkipTable = indexSkipTable or {}
	isElementAsCLSID = isElementAsCLSID or false
	local skipTable = {}
	local ret = {{ ShapeName = shape, IsAdapter = true }}

	if #indexSkipTable > 0 then
		for _, i in pairs(indexSkipTable) do
			skipTable[i] = true
		end
	end

	if element ~= nil and count ~= nil then
		pattern = pattern or "tube_%02d"
		for i = 1, count + #indexSkipTable do
			if not skipTable[i] then
				if isElementAsCLSID then
					ret[#ret + 1] = {
						payload_CLSID	= element,
						connector_name	= string.format(pattern, i)
					}
				else
					ret[#ret + 1] = {
						ShapeName		= element,
						connector_name	= string.format(pattern, i)
					}
				end
			end
		end
	end

	return ret
end

---Declare multiple loadouts based on one launcher (e.g. rockets); the indices of specificParams tables in the function call will be used as CLSID
---@param launcherCommonParams	table Parameters that are common for the base launcher
---@param specificParams		table Parameters that are specific for a loadout (wsTypeOfWeapon, mass of single munition, munitions count etc)
---@param weaponList			table List of weapon descriptors that should be used for the loadouts (can be nil, but then wsTypeOfWeapon should be provided for each specificParams entry)
function BatchDeclareLoadout(launcherCommonParams, specificParams, weaponList)
	local function calcFullMass(currentParamTable)
		local fullMass = launcherCommonParams.Weight_Empty

		if currentParamTable.multiWeaponTable then
			for wpnIndex, wpnCount in pairs(currentParamTable.multiWeaponTable) do
				fullMass = fullMass + weaponList[wpnIndex].fm.mass * wpnCount
			end
		elseif weaponList then
			fullMass = fullMass + math.min(currentParamTable.wpnCount or launcherCommonParams.Count) * (currentParamTable.singleWpnMass or weaponList[currentParamTable.weaponResName].fm.mass)
		else
			fullMass = fullMass + math.min(currentParamTable.wpnCount or launcherCommonParams.Count) * (currentParamTable.singleWpnMass or 0)
		end

		return fullMass
	end

	for index, value in pairs(specificParams) do
		currentLoadoutParams = {
			category			= launcherCommonParams.category,
			CLSID				= index,
			wsTypeOfWeapon		= value.wsTypeOfWeapon or weaponList[value.weaponResName].wsTypeOfWeapon,
			attribute			= value.attribute or launcherCommonParams.attribute,

			Picture				= value.Picture or launcherCommonParams.Picture,
			PictureBlendColor	= value.PictureBlendColor or nil,
			Cx_pil				= value.Cx_pil or launcherCommonParams.Cx_pil,
			displayName			= value.displayName or launcherCommonParams.displayNamePfx .. weaponList[value.weaponResName].displayName or nil,
			Count				= math.min(value.wpnCount or launcherCommonParams.Count),
			Elements			= value.Elements or
								launcherCommonParams.Elements or
								ContainerWithSubshapes(launcherCommonParams.modelFileName, weaponList[value.weaponResName].model, launcherCommonParams.Count, launcherCommonParams.connNamePattern),
			Weight				= calcFullMass(value),
			Weight_Empty		= launcherCommonParams.Weight_Empty,

			shape_table_data	= value.shape_table_data or {}
		}

		declare_loadout(currentLoadoutParams)
	end
end
