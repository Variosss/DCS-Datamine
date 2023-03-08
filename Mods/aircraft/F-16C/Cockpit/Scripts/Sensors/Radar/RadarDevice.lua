renderDebugInfo = false

RDR_screenSizePx 					= 480
RDR_tacticalAreaSizePx 				= 480		-- TODO

RDR_TAC_AreaSize					= RDR_tacticalAreaSizePx / 2
RDR_TDC_HeightPx					= 52
RDR_TDC_WidthPx						= 62

-- relative to screen size
RDR_TAC_AreaSizeRelative			= RDR_tacticalAreaSizePx / RDR_screenSizePx
RDR_TDC_HeightRelative				= RDR_TDC_HeightPx / RDR_screenSizePx
RDR_TDC_WidthRelative				= RDR_TDC_WidthPx / RDR_screenSizePx

-- relative to tactical area size
RDR_TDC_HeightRelative_TAC			= RDR_TDC_HeightPx / RDR_tacticalAreaSizePx
RDR_TDC_WidthRelative_TAC			= RDR_TDC_WidthPx / RDR_tacticalAreaSizePx
--RDR_AOT_zoneSizeRelative			= RDR_AOT_zoneSizePx / RDR_tacticalAreaSizePx

need_to_be_closed = true -- close lua state after initialization
