livery = {
    {"main", 0 ,"MB339A_UAE",false};
	{"main", ROUGHNESS_METALLIC,"MB339A_UAE_Roughmet", false};
	
	{"pylons", 0, "MB339A_UAE_PYLONS", false};
	{"pylons", ROUGHNESS_METALLIC , "MB339A_PYLONS_RoughMet", true};	
	{"tanks_L", 0 ,"MB339A_UAE_TANKS_L",false};
	{"tanks_L", ROUGHNESS_METALLIC,"MB339A_TANKS_Roughmet", true},
	{"tanks_R", 0 ,"MB339A_UAE_TANKS_R",false};
	{"tanks_R", ROUGHNESS_METALLIC,"MB339A_TANKS_Roughmet", true},
	{"tanks_sub", 0 ,"MB339A_UAE_TANKS_L",false};
	{"tanks_sub", ROUGHNESS_METALLIC,"MB339A_TANKS_Roughmet", true},	
--COMUNI
	{"MB339_Pilot_PAN", 0 ,"MB339_Pilot_UAE",false};
	{"MB339_HGU33", 0 ,"MB339_HGU33_AMI",true};
	{"MB339_HGU33", ROUGHNESS_METALLIC,"MB339_HGU33_AMI_RoughMet",true};
	{"patch ftv", 0 ,"empty",true};
}
name = "UAE Air Force"
countries = {"ARE"}

custom_args = {
    [999] = 1, --Pre-MLU
	[550] = 0, --HGU55P	
}