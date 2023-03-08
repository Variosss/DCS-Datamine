livery = {
    {"main", 0 ,"MB339A_MAIN_DIF_NAT",false};	
	{"main", ROUGHNESS_METALLIC,"MB339A_MAIN_ROUGHMET_NAT", false},
	
	{"misti", 0 ,"MB339A_MISTI_DIF_NAT",false};
	{"misti", ROUGHNESS_METALLIC,"MB339A_MISTI_ROUGHMET_NAT",false};
	
	{"pylons", 0, "MB339A_PYLONS_DIF_NAT", false};
	{"pylons", ROUGHNESS_METALLIC , "MB339A_PYLONS_ROUGHMET_NAT", false};	
	
	{"MB339_Pilot_PAN", 0 ,"MB339A_Pilot_NAT",false};
	{"MB339_HGU33", 0 ,"MB339_HGU33_AMI",true};
}
name = "UAE Natioanl Acrobatic Team 'al-Fursān' "
countries = {"ARE", "ITA"}
order     = -5
custom_args = 
{
	[999] = 0, --MLU
	[477] = 1, --PAN no gunsight
	[550] = 0.8,
}