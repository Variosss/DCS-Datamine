livery = {
    {"main", 0 ,"MB339A_ARMADA_4-A-115",false};
	{"main", ROUGHNESS_METALLIC ,"MB339A_ARMADA_RoughMet",false};
	{"defa_l", 0, "MB339A_ARMADA_GUNPODS_L", false};
	{"defa_r", 0, "MB339A_ARMADA_GUNPODS_R", false};
	{"pylons", 0, "MB339A_ARMADA_PYLONS", false};
	{"pylons", ROUGHNESS_METALLIC , "MB339A_PYLONS_RoughMet", true};
	
	{"tanks_L", 0 ,"MB339A_ARMADA_TANKS_L",false};
	{"tanks_L", ROUGHNESS_METALLIC,"MB339A_TANKS_Roughmet", true},
	{"tanks_R", 0 ,"MB339A_ARMADA_TANKS_R",false};
	{"tanks_R", ROUGHNESS_METALLIC,"MB339A_TANKS_Roughmet", true},
	{"tanks_sub", 0 ,"MB339A_ARMADA_TANKS_L",false};
	{"tanks_sub", ROUGHNESS_METALLIC,"MB339A_TANKS_Roughmet", true},
	
	{"MB339_HGU33", 0 ,"MB339_HGU33_ARMADA",false};
	{"patch ftv", 0 ,"patches_ARMADA",false};
	{"MB339_Pilot_PAN", 0 ,"MB339_Pilot_ARMADA",false};
	
	{"MB339_HGU33", ROUGHNESS_METALLIC ,"MB339_HGU33_AMI_RoughMet",true};	

}
name = "ARMADA Argentina | Camo (Lt. Crippa's killmark)"
countries = {"ARG"}


custom_args = 
{
	[999] = 1, --PRE-MLU
	[477] = 0, --gunsight	
	[550] = 0.8, --HGU33
}
