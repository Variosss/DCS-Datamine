livery = {
	{"F-18C-mirror", 0, "mirrors", true};						-- mirrors texture replacement with runtime rendered one
	{"map", 0, "mfd3", true};									-- kneeboard
}

-- set true to enable bake (render) to a dedicated cockpit texture
local bakeToCockpitTexture = false

if bakeToCockpitTexture == true then
	livery[#livery + 1] = {"f18c_mdi_l_additive", DIFFUSE, "LMDI_Bake", true} -- Left MDI picture
	livery[#livery + 1] = {"f18c_mdi_r_additive", DIFFUSE, "RMDI_Bake", true} -- Right MDI picture
end
