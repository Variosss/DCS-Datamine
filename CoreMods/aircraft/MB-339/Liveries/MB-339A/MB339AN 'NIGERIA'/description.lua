livery = {
    {"main", 0 ,"MB339A_NIGERIA",false};
	{"main", ROUGHNESS_METALLIC,"MB339A_NIGERIA_Roughmet", false};
	
	{"pylons", 0, "MB339A_AMI_PYLONS", true};
	{"pylons", ROUGHNESS_METALLIC , "MB339A_PYLONS_RoughMet", true};	
	{"tanks_L", 0 ,"MB339A_NIGERIA_TANKS",false};
	{"tanks_L", ROUGHNESS_METALLIC,"MB339A_NIGERIA_TANKS_Roughmet", false};
	{"tanks_R", 0 ,"MB339A_NIGERIA_TANKS",false};
	{"tanks_R", ROUGHNESS_METALLIC,"MB339A_NIGERIA_TANKS_Roughmet", false};
	{"tanks_sub", 0 ,"MB339A_NIGERIA_TANKS",false};
	{"tanks_sub", ROUGHNESS_METALLIC,"MB339A_NIGERIA_TANKS_Roughmet", false};	
--COMUNI
	{"MB339_Pilot_PAN", 0 ,"MB339_Pilot_NIGERIA",false};
	{"MB339_HGU33", 0 ,"MB339_HGU33_AMI",true};
	{"MB339_HGU33", ROUGHNESS_METALLIC,"MB339_HGU33_AMI_RoughMet",true};
	{"patch ftv", 0 ,"empty",true};
}
name = "Nigerian Air Force | Camo (Low-Vis)"
countries = {"NGA"}

custom_args = {
    [999] = 1, --Pre-MLU
	[550] = 0, --HGU55P	
}