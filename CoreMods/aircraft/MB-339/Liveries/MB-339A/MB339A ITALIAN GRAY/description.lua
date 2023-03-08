livery = {
    {"main", 0 ,"MB339A_ITA-GREY_MAIN",false};
	{"main", ROUGHNESS_METALLIC,"MB339A_ITA-GREY_MAIN_Roughmet", false};
	{"tanks_L", 0 ,"MB339A_ITA-GREY_TANKS",false}; --TT320/TT500 L
	{"tanks_L", ROUGHNESS_METALLIC,"MB339A_ITA-GREY_TANKS_Roughmet", false},
	{"tanks_R", 0 ,"MB339A_ITA-GREY_TANKS",false}; --TT320/TT500 R
	{"tanks_R", ROUGHNESS_METALLIC,"MB339A_ITA-GREY_TANKS_Roughmet", false},
	{"tanks_sub", 0 ,"MB339A_ITA-GREY_TANKS",false}; --FT330
	{"tanks_sub", ROUGHNESS_METALLIC,"MB339A_ITA-GREY_TANKS_Roughmet", false},
	
	{"pylons", 0, "MB339A_AMI_PYLONS", true};
	{"pylons", ROUGHNESS_METALLIC , "MB339A_PYLONS_RoughMet", true};	
	{"MB339_Pilot_PAN", 0 ,"MB339_Pilot_AMI-T85",true};
	{"MB339_HGU33", 0 ,"MB339_HGU33_AMI",true};
	{"MB339_HGU33", ROUGHNESS_METALLIC,"MB339_HGU33_AMI_RoughMet",true};
	{"patch ftv", 0 ,"patches_AMI",true};
}
name = "Italian Gray"
countries = {"ITA"}
order     = -1
custom_args = {
    [999] = 0, --0=MLU --1=PRE-MLU
	[477] = 0, --0=gunsight --1=No gunsight/PAN
	[550] = 0, --0=HGU55P -- 0.8= HGU33
}
