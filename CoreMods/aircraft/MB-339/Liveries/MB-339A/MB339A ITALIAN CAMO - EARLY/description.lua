livery = {
    {"main", 0 ,"MB339A_ITA-CAMO_MAIN",false};
	{"main", ROUGHNESS_METALLIC,"MB339A_ITA-CAMO_MAIN_Roughmet", false};
--	{"main", DECAL,"MB339A_ITA-CAMO_DECAL", false},	
	{"tanks_L", 0 ,"MB339A_ITA-CAMO_TANKS",false}; --TT320/TT500 L
	{"tanks_L", ROUGHNESS_METALLIC,"MB339A_ITA-CAMO_TANKS_Roughmet", false},
	{"tanks_R", 0 ,"MB339A_ITA-CAMO_TANKS",false}; --TT320/TT500 R
	{"tanks_R", ROUGHNESS_METALLIC,"MB339A_ITA-CAMO_TANKS_Roughmet", false},
	{"tanks_sub", 0 ,"MB339A_ITA-CAMO_TANKS",false}; --FT330
	{"tanks_sub", ROUGHNESS_METALLIC,"MB339A_ITA-CAMO_TANKS_Roughmet", false},
	
	{"pylons", 0, "MB339A_AMI_PYLONS", true};
	{"pylons", ROUGHNESS_METALLIC , "MB339A_PYLONS_RoughMet", true};
	{"MB339_Pilot_PAN", 0 ,"MB339_Pilot_AMI-K2B",true};
	{"MB339_HGU33", 0 ,"MB339_HGU33_212",true};
	{"MB339_HGU33", ROUGHNESS_METALLIC,"MB339_HGU33_AMI_RoughMet",true};
	{"patch ftv", 0 ,"patches_AMI",true};
}
name = "Italian Camo - Early"
countries = {"ITA"}
order     = -3
custom_args = {
    [999] = 1, --Pre-MLU
	[477] = 0, --gunsight	
	[550] = 0.8, --HGU33
}