
--wInfo_weapon_data_by_CLSID = {}

local wInfo_files = {
	"Scripts/Database/PlaneConst.lua",
	"Scripts/Database/HelicopterConst.lua",
	"Scripts/Database/SFM_data.lua",
    "Scripts/Aircrafts/_Common/Damage.lua",
    "Scripts/Aircrafts/_Common/AIControl.lua",
    "Scripts/Aircrafts/_Common/DefaultMechTiming.lua",
    "Scripts/Aircrafts/_Common/helicopter_exhaust.lua",
    "Scripts/Aircrafts/_Common/Lights.lua",
	"Config/World/World.lua",
}

local k,v
for k,v in ipairs(wInfo_files) do
    local res, err = pcall(dofile, v)
    if not res then
        print("Error loading "..v..": "..err)
    end
end
