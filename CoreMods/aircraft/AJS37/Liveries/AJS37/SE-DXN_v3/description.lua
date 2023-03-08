livery = {

    --Diffuse  -----------------------------------
    {"LNS_VIG_EXT_FUS_T", 0 ,"LNS_VIG_FUSELAGE_T",false};
    {"LNS_VIG_EXT_FUS_L", 0 ,"LNS_VIG_FUSELAGE_L",false};
    {"LNS_VIG_EXT_FUS_R", 0 ,"LNS_VIG_FUSELAGE_R",false};
    {"LNS_VIG_EXT_WING_L", 0 ,"LNS_VIG_WING_L",false};
    {"LNS_VIG_EXT_WING_R", 0 ,"LNS_VIG_WING_L",false};
    
    {"HB_VIG_EXT_TailTacNo", 0 ,"HB_VIG_TacNo_Black",false};
    {"HB_VIG_EXT_TailTacNo_02", 0 ,"HB_VIG_TacNo_Black",false};
    
    --Specular -----------------------------------
    {"LNS_VIG_EXT_WING_L", ROUGHNESS_METALLIC ,"LNS_VIG_WING_L_RoughMet",false};
    {"LNS_VIG_EXT_WING_R", ROUGHNESS_METALLIC ,"LNS_VIG_WING_L_RoughMet",false};
    {"LNS_VIG_EXT_FUS_L", ROUGHNESS_METALLIC ,"LNS_VIG_FUSELAGE_L_RoughMet",false};
    {"LNS_VIG_EXT_FUS_R", ROUGHNESS_METALLIC ,"LNS_VIG_FUSELAGE_R_RoughMet",false};
    {"LNS_VIG_EXT_FUS_T", ROUGHNESS_METALLIC ,"LNS_VIG_FUSELAGE_T_RoughMet",false};
    
    --Pylons -------------------------------------
    
    {"LNS_VIG_PYLONS_02", 0 ,"Pilon_01",false};
    {"LNS_VIG_Pylons_01", 0 ,"Pilon_02",false};
    {"LNS_VIG_WING_PYLONS", 0 ,"Pilon_03",false};
    {"LNS_VIG_OUTER_PYLONS", 0 ,"Pilon_04",false};
    
    {"LNS_VIG_PYLONS_02", ROUGHNESS_METALLIC ,"Pilon_01_RoughMet",false};
    {"LNS_VIG_Pylons_01", ROUGHNESS_METALLIC ,"Pilon_02_RoughMet",false};
    {"LNS_VIG_WING_PYLONS", ROUGHNESS_METALLIC ,"Pilon_03_RoughMet",false};
    {"LNS_VIG_OUTER_PYLONS", ROUGHNESS_METALLIC ,"Pilon_04_RoughMet",false};
    
    {"AGM_65B", DIFFUSE, "RB75_Diff", true};
    
    }

name = "SE-DXN v3 by 000rick000"

custom_args = 
{
    [850] = 0.1, -- turn on/off vertical tail dynamic numbers (< 0.5 is on)
}


--countries = {"USA", "FRA", "UKR", "SPN", "NETH", "TUR", "BEL", "GER", "NOR", "CAN", "DEN", "UK", "GRG", "ISR", "ABH", "RSO"}