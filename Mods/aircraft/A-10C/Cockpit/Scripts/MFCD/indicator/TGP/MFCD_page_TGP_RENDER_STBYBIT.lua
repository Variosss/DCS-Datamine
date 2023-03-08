dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")

local InfoStrings = {}
InfoStrings["TGP"] = "LITENING AT"
InfoStrings["VER"] = "0604 02"
InfoStrings["FLR"] = {"****", "H0 8A"}
InfoStrings["A_C"] = "A10 PE"
InfoStrings["SIP"] = "BFA7"
InfoStrings["MSK"] = "A6"


AddRender()

CameraNoSignal    				= CreateElement "ceMeshPoly"
CameraNoSignal.name				= "CameraNoSignal"
CameraNoSignal.primitivetype	= "triangles"
CameraNoSignal.material			= "TGP_STBY_DARK_GREY"
CameraNoSignal.vertices			=  {{-1, 1},
									{ 1, 1},
									{ 1,-1},
									{-1,-1}}
CameraNoSignal.indices			= box_ind
SetScreenSpace(CameraNoSignal)
Add(CameraNoSignal)

local Xpos = -0.36
local Ypos = 0.28
local dY   = 0.133

TGP_INFO_TGP						= CreateElement "ceStringPoly"
TGP_INFO_TGP.name					= "TGP_INFO_TGP"
TGP_INFO_TGP.material				= font_TGP
TGP_INFO_TGP.alignment				= "LeftCenter"
TGP_INFO_TGP.stringdefs				= {0.0057, 0.0057, 0, 0}
TGP_INFO_TGP.value					= "TGP: " .. InfoStrings["TGP"]
TGP_INFO_TGP.init_pos           	= {Xpos, Ypos, 0}
SetScreenSpace(TGP_INFO_TGP)
Add(TGP_INFO_TGP)
use_mipfilter(TGP_INFO_TGP)	

Ypos = Ypos - dY

TGP_INFO_VER						= CreateElement "ceStringPoly"
TGP_INFO_VER.name					= "TGP_INFO_VER"
TGP_INFO_VER.material				= font_TGP
TGP_INFO_VER.alignment				= "LeftCenter"
TGP_INFO_VER.stringdefs				= {0.0057, 0.0057, 0, 0}
TGP_INFO_VER.value					= "VER: " .. InfoStrings["VER"]
TGP_INFO_VER.init_pos           	= {Xpos, Ypos, 0}
SetScreenSpace(TGP_INFO_VER)
Add(TGP_INFO_VER)
use_mipfilter(TGP_INFO_VER)	

Ypos = Ypos - dY

TGP_INFO_FLR_TXT					= CreateElement "ceStringPoly"
TGP_INFO_FLR_TXT.name				= "TGP_INFO_FLR_TXT"
TGP_INFO_FLR_TXT.material			= font_TGP
TGP_INFO_FLR_TXT.alignment			= "LeftCenter"
TGP_INFO_FLR_TXT.stringdefs			= {0.0057, 0.0057, 0, 0}
TGP_INFO_FLR_TXT.value				= "FLR:"
TGP_INFO_FLR_TXT.init_pos          	= {Xpos, Ypos, 0}
SetScreenSpace(TGP_INFO_FLR_TXT)
Add(TGP_INFO_FLR_TXT)
use_mipfilter(TGP_INFO_FLR_TXT)

TGP_INFO_FLR_VAL					= CreateElement "ceStringPoly"
TGP_INFO_FLR_VAL.name				= "TGP_INFO_FLR_VAL"
TGP_INFO_FLR_VAL.formats			= {"     " .. InfoStrings["FLR"][1],
                                       "     " .. InfoStrings["FLR"][2]}
TGP_INFO_FLR_VAL.material			= font_TGP
TGP_INFO_FLR_VAL.alignment			= "LeftCenter"
TGP_INFO_FLR_VAL.stringdefs			= {0.0057, 0.0057, 0, 0}
TGP_INFO_FLR_VAL.init_pos          	= {Xpos, Ypos, 0}
TGP_INFO_FLR_VAL.controllers		= {{"tgp_stby_bit_flr"}}
SetScreenSpace(TGP_INFO_FLR_VAL)
Add(TGP_INFO_FLR_VAL)
use_mipfilter(TGP_INFO_FLR_VAL)

Ypos = Ypos - dY

TGP_INFO_A_C						= CreateElement "ceStringPoly"
TGP_INFO_A_C.name					= "TGP_INFO_A_C"
TGP_INFO_A_C.material				= font_TGP
TGP_INFO_A_C.alignment				= "LeftCenter"
TGP_INFO_A_C.stringdefs				= {0.0057, 0.0057, 0, 0}
TGP_INFO_A_C.value					= "A/C: " .. InfoStrings["A_C"]
TGP_INFO_A_C.init_pos           	= {Xpos, Ypos, 0}
SetScreenSpace(TGP_INFO_A_C)
Add(TGP_INFO_A_C)
use_mipfilter(TGP_INFO_A_C)	

Ypos = Ypos - dY

TGP_INFO_SIP						= CreateElement "ceStringPoly"
TGP_INFO_SIP.name					= "TGP_INFO_SIP"
TGP_INFO_SIP.material				= font_TGP
TGP_INFO_SIP.alignment				= "LeftCenter"
TGP_INFO_SIP.stringdefs				= {0.0057, 0.0057, 0, 0}
TGP_INFO_SIP.value					= "SIP: " .. InfoStrings["SIP"]
TGP_INFO_SIP.init_pos           	= {Xpos, Ypos, 0}
SetScreenSpace(TGP_INFO_SIP)
Add(TGP_INFO_SIP)
use_mipfilter(TGP_INFO_SIP)	

Ypos = Ypos - dY

TGP_INFO_MSK_TXT					= CreateElement "ceStringPoly"
TGP_INFO_MSK_TXT.name				= "TGP_INFO_MSK_TXT"
TGP_INFO_MSK_TXT.material			= font_TGP
TGP_INFO_MSK_TXT.alignment			= "LeftCenter"
TGP_INFO_MSK_TXT.stringdefs			= {0.0057, 0.0057, 0, 0}
TGP_INFO_MSK_TXT.value				= "MSK:"
TGP_INFO_MSK_TXT.init_pos          	= {Xpos, Ypos, 0}
SetScreenSpace(TGP_INFO_MSK_TXT)
Add(TGP_INFO_MSK_TXT)
use_mipfilter(TGP_INFO_MSK_TXT)

TGP_INFO_MSK_VAL					= CreateElement "ceStringPoly"
TGP_INFO_MSK_VAL.name				= "TGP_INFO_MSK_VAL"
TGP_INFO_MSK_VAL.material			= font_TGP
TGP_INFO_MSK_VAL.alignment			= "LeftCenter"
TGP_INFO_MSK_VAL.stringdefs			= {0.0057, 0.0057, 0, 0}
TGP_INFO_MSK_VAL.value				= "     " .. InfoStrings["MSK"]
TGP_INFO_MSK_VAL.init_pos          	= {Xpos, Ypos, 0}
TGP_INFO_MSK_VAL.controllers				= {{"tgp_stby_bit_msk"}}
SetScreenSpace(TGP_INFO_MSK_VAL)
Add(TGP_INFO_MSK_VAL)
use_mipfilter(TGP_INFO_MSK_VAL)
