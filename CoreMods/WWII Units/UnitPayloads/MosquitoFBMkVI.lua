local unitPayloads = {
	["name"] = "MosquitoFBMkVI",
	["payloads"] = {
		[1] = {
			["displayName"] = "250 lb S.A.P*2; 500 lb S.A.P.*2",
			["name"] = "250 lb S.A.P*2; 500 lb S.A.P.*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{British_SAP_500LB_Bomb_Mk5}",
					["num"] = 2,
				},
				[2] = {
					["CLSID"] = "{British_SAP_500LB_Bomb_Mk5}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{British_SAP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 4,
				},
				[4] = {
					["CLSID"] = "{British_SAP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 11,
				[2] = 32,
			},
		},
		[2] = {
			["displayName"] = "500 lb GP Mk.V*2, 500 lb GP Short tail*2",
			["name"] = "500 lb GP Mk.V*2, 500 lb GP Short tail*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{British_GP_500LB_Bomb_Mk5}",
					["num"] = 2,
				},
				[2] = {
					["CLSID"] = "{British_GP_500LB_Bomb_Mk5}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{British_MC_500LB_Bomb_Mk1_Short_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 4,
				},
				[4] = {
					["CLSID"] = "{British_MC_500LB_Bomb_Mk1_Short_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 11,
				[2] = 32,
				[3] = 31,
				[4] = 34,
			},
		},
		[3] = {
			["displayName"] = "100 gal Drop tank*2, 500 lb MC Short tail*2",
			["name"] = "100 gal Drop tank*2, 500 lb MC Short tail*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{MOSQUITO_100GAL_SLIPPER_TANK}",
					["num"] = 2,
				},
				[2] = {
					["CLSID"] = "{MOSQUITO_100GAL_SLIPPER_TANK}",
					["num"] = 1,
				},
				[3] = {
					["CLSID"] = "{British_MC_500LB_Bomb_Mk1_Short_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 4,
				},
				[4] = {
					["CLSID"] = "{British_MC_500LB_Bomb_Mk1_Short_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 3,
				},
			},
			["tasks"] = {
				[1] = 11,
				[2] = 32,
			},
		},
		[4] = {
			["displayName"] = "RP-3 60lb SAP No2 Mk.I*8, 250 lb A.A.P.*2",
			["name"] = "RP-3 60lb SAP No2 Mk.I*8, 250 lb A.A.P.*2",
			["pylons"] = {
				[1] = {
					["CLSID"] = "",
					["num"] = 1,
					["settings"] = {
						["GUI_fuze_type"] = 1,
						["arm_delay_ctrl_TP17MkI"] = 0.64,
						["function_delay_ctrl_TP17MkI"] = 1800,
					},
				},
				[2] = {
					["CLSID"] = "",
					["num"] = 2,
				},
				[3] = {
					["CLSID"] = "{British_SAP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 3,
					["settings"] = {
						["GUI_fuze_type"] = 1,
						["arm_delay_ctrl_TP30MkIII"] = 1.2,
						["function_delay_ctrl_TP30MkIII"] = 0,
					},
				},
				[4] = {
					["CLSID"] = "{British_SAP_250LB_Bomb_Mk5_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 4,
					["settings"] = {
						["GUI_fuze_type"] = 1,
						["arm_delay_ctrl_TP30MkIII"] = 1.2,
						["function_delay_ctrl_TP30MkIII"] = 0,
					},
				},
				[5] = {
					["CLSID"] = "{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_LEFT_WING_RAILS}",
					["num"] = 5,
				},
				[6] = {
					["CLSID"] = "{MOSSIE_4_British_HE_60LBSAPNo2_3INCHNo1_ON_RIGHT_WING_RAILS}",
					["num"] = 6,
				},
			},
			["tasks"] = {
				[1] = 11,
				[2] = 30,
				[3] = 31,
				[4] = 32,
			},
		},
		[5] = {
			["displayName"] = "100 gal. Drop tank*2, 250 lb MC Mk.II, RP-3 60lb F No1 Mk.I*4",
			["name"] = "100 gal. Drop tank*2, 250 lb MC Mk.II, RP-3 60lb F No1 Mk.I*4",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{MOSSIE_2_British_HE_60LBFNo1_3INCHNo1_ON_LEFT_WING_RAILS}",
					["num"] = 5,
				},
				[2] = {
					["CLSID"] = "{MOSSIE_2_British_HE_60LBFNo1_3INCHNo1_ON_RIGHT_WING_RAILS}",
					["num"] = 6,
				},
				[3] = {
					["CLSID"] = "{MOSQUITO_100GAL_SLIPPER_TANK}",
					["num"] = 1,
				},
				[4] = {
					["CLSID"] = "{MOSQUITO_100GAL_SLIPPER_TANK}",
					["num"] = 2,
					["settings"] = {
						["GUI_fuze_type"] = 1,
						["arm_delay_ctrl_NP27MkII"] = 0.6,
						["arm_delay_ctrl_NP44"] = 2.6,
						["arm_delay_ctrl_TP30MkIII"] = 1.2,
						["function_delay_ctrl_NP27MkII"] = 0,
						["function_delay_ctrl_NP44"] = 0,
						["function_delay_ctrl_TP30MkIII"] = 0,
					},
				},
				[5] = {
					["CLSID"] = "{British_MC_250LB_Bomb_Mk2_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 3,
					["settings"] = {
						["GUI_fuze_type"] = 1,
						["arm_delay_ctrl_NP27MkII"] = 0.6,
						["arm_delay_ctrl_NP44"] = 2.6,
						["arm_delay_ctrl_TP30MkIII"] = 1.2,
						["function_delay_ctrl_NP27MkII"] = 0,
						["function_delay_ctrl_NP44"] = 0,
						["function_delay_ctrl_TP30MkIII"] = 0,
					},
				},
				[6] = {
					["CLSID"] = "{British_MC_250LB_Bomb_Mk2_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 4,
					["settings"] = {
						["GUI_fuze_type"] = 1,
						["arm_delay_ctrl_NP27MkII"] = 0.6,
						["arm_delay_ctrl_NP44"] = 2.6,
						["arm_delay_ctrl_TP30MkIII"] = 1.2,
						["function_delay_ctrl_NP27MkII"] = 0,
						["function_delay_ctrl_NP44"] = 0,
						["function_delay_ctrl_TP30MkIII"] = 0,
					},
				},
			},
			["tasks"] = {
				[1] = 11,
				[2] = 30,
				[3] = 31,
				[4] = 32,
			},
		},
		[6] = {
			["displayName"] = "500 lb GP Short tail*4",
			["name"] = "500 lb GP Short tail*4",
			["pylons"] = {
				[1] = {
					["CLSID"] = "{British_GP_500LB_Bomb_Mk4_Short}",
					["num"] = 2,
					["settings"] = {
						["GUI_fuze_type"] = 1,
						["function_delay_ctrl_NP27MkII"] = 0,
						["vane_rev_threshold_ctrl_NP27MkII"] = 7,
					},
				},
				[2] = {
					["CLSID"] = "{British_GP_500LB_Bomb_Mk4_Short}",
					["num"] = 1,
					["settings"] = {
						["GUI_fuze_type"] = 1,
						["function_delay_ctrl_NP27MkII"] = 0,
						["vane_rev_threshold_ctrl_NP27MkII"] = 7,
					},
				},
				[3] = {
					["CLSID"] = "{British_GP_500LB_Bomb_Mk4_Short_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 4,
					["settings"] = {
						["GUI_fuze_type"] = 1,
						["function_delay_ctrl_NP27MkII"] = 0,
						["vane_rev_threshold_ctrl_NP27MkII"] = 7,
					},
				},
				[4] = {
					["CLSID"] = "{British_GP_500LB_Bomb_Mk4_Short_on_Handley_Page_Type_B_Cut_Bar}",
					["num"] = 3,
					["settings"] = {
						["GUI_fuze_type"] = 1,
						["function_delay_ctrl_NP27MkII"] = 0,
						["vane_rev_threshold_ctrl_NP27MkII"] = 7,
					},
				},
			},
			["tasks"] = {
				[1] = 11,
				[2] = 32,
				[3] = 31,
				[4] = 34,
			},
		},		
	},
	["tasks"] = {
	},
	["unitType"] = "MosquitoFBMkVI",
}
return unitPayloads
