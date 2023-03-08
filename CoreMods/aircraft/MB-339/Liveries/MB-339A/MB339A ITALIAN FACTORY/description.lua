livery = {
    {"main", 0 ,"../MB339 'Factory'/MB339A_FACTORY",false};	
	{"main", ROUGHNESS_METALLIC,"../MB339 'Factory'/MB339A_FACTORY_Roughmet", false},
	{"main", DECAL,"MB339A_SVBIA_DECAL", false},	
	{"pylons", 0, "../MB339 'Factory'/MB339A_FACTORY_PYLONS", false};
	{"pylons", ROUGHNESS_METALLIC , "../MB339 'Factory'/MB339A_FACTORY_PYLONS_Roughmet", false};	
	{"tanks_L", 0 ,"../MB339 'Factory'/MB339A_FACTORY_TANKS",false}; --TT320/TT500 L
	{"tanks_L", ROUGHNESS_METALLIC,"../MB339 'Factory'/MB339A_FACTORY_TANKS_Roughmet", false},
	{"tanks_R", 0 ,"../MB339 'Factory'/MB339A_FACTORY_TANKS",false}; --TT320/TT500 R
	{"tanks_R", ROUGHNESS_METALLIC,"../MB339 'Factory'/MB339A_FACTORY_TANKS_Roughmet", false},
	{"tanks_sub", 0 ,"../MB339 'Factory'/MB339A_FACTORY_TANKS",false}; --FT330
	{"tanks_sub", ROUGHNESS_METALLIC,"../MB339 'Factory'/MB339A_FACTORY_TANKS_Roughmet", false},	
--COMUNI
	{"MB339_Pilot_PAN", 0 ,"MB339_Pilot_AMI-K2B",true};
	{"MB339_HGU33", 0 ,"MB339_HGU33_212",true};
	{"MB339_HGU33", ROUGHNESS_METALLIC,"MB339_HGU33_AMI_RoughMet",true};
	{"patch ftv", 0 ,"patches_AMI",true};
}
name = "Italian Orange/White"
countries = {"ITA"}
order     = -4
custom_args = 
{
	[999] = 1, --PRE-MLU
	[477] = 0, --gunsight
	[550] = 0.8,
}