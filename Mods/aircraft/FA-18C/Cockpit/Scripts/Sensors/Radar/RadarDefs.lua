dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_units.lua")

RDR_screenSizeDI 					= InToDI(5) 								-- 5 in or 1024 DI
RDR_tacticalAreaSizeDI 				= roundDI(InToDI(4)) 						-- 4 in or 819 DI
RDR_AOT_zoneSizeDI 					= roundDI(RDR_tacticalAreaSizeDI / 100 * 6) -- 49 DI or 6% of the tactical display area

RDR_TDC_HeightDI					= 52
RDR_TDC_WidthDI						= 62

-- relative to screen size
RDR_TAC_AreaSizeRelative			= RDR_tacticalAreaSizeDI / RDR_screenSizeDI
RDR_TDC_HeightRelative				= RDR_TDC_HeightDI / RDR_screenSizeDI
RDR_TDC_WidthRelative				= RDR_TDC_WidthDI / RDR_screenSizeDI

-- relative to tactical area size
RDR_TDC_HeightRelative_TAC			= RDR_TDC_HeightDI / RDR_tacticalAreaSizeDI
RDR_TDC_WidthRelative_TAC			= RDR_TDC_WidthDI / RDR_tacticalAreaSizeDI
RDR_AOT_zoneSizeRelative			= RDR_AOT_zoneSizeDI / RDR_tacticalAreaSizeDI

-- AG parameters
AG_Param_BlurMult                   = 1.0
AG_Param_Gain                       = 0.5
AG_MaxFootprintIntensity			= 0.5

AG_TacticalAreaWidth                = 840
AG_TacticalAreaHeight               = 840
AG_TacticalAreaOffsetY              = -AG_TacticalAreaHeight / 2