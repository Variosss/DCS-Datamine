livery = {
    {"main", 0 ,"MB339A_PERU_DIFF",false};
	{"main", ROUGHNESS_METALLIC,"MB339A_PERU_ROUGHMET", false};
	
	{"pylons", 0, "MB339A_PERU_PYLONS", false };
	{"pylons", ROUGHNESS_METALLIC , "MB339A_PYLONS_RoughMet", true};	
	{"tanks_L", 0 ,"MB339A_PERU_TANKS_L",false};
	{"tanks_L", ROUGHNESS_METALLIC,"MB339A_PERU_TANKS_ROUGHMET", false},
	{"tanks_R", 0 ,"MB339A_PERU_TANKS_R",false};
	{"tanks_R", ROUGHNESS_METALLIC,"MB339A_PERU_TANKS_ROUGHMET", false},
	{"tanks_sub", 0 ,"MB339A_PERU_TANKS_L",false};
	{"tanks_sub", ROUGHNESS_METALLIC,"MB339A_PERU_TANKS_ROUGHMET", false},	
	{"defa_l", 0, "MB339A_DEFA_DIFF", false};
	{"defa_r", 0, "MB339A_DEFA_DIFF", false};
--COMUNI

	{"MB339_Pilot_PAN", 0 ,"MB339_Pilot_AMI-T85",true};
	{"MB339_HGU33", 0 ,"MB339_HGU33_AMI",true};
	{"MB339_HGU33", ROUGHNESS_METALLIC,"MB339_HGU33_AMI_RoughMet",true};
	{"patch ftv", 0 ,"patches_FAP",false};
}
name = "Peruvian Air Force | Camo (Late)"
countries = {"PER"}

custom_args = {
    [999] = 1, --Pre-MLU
	[550] = 0, --HGU55P	
}