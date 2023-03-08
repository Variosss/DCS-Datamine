dofile(LockOn_Options.common_script_path.."elements_defs.lua")

TextFont		= "font_MFCD_RED"
TextSizeX		= 0.02
TextSizeY		= 0.02
TextAlignment	= "LeftUp"

LeftCorner		= -0.2
UpCorner		= 0.2
VerticalStep	= 0.02

function AddText(Name, HorP, VertP, format, controllers)
	local txt			= CreateElement "ceStringPoly"
	txt.name			= Name
	txt.material		= TextFont
	txt.init_pos		= {HorP, VertP, 0.0}
	txt.alignment		= TextAlignment
	txt.formats			= format
	txt.controllers		= controllers
	txt.stringdefs		= {TextSizeX, TextSizeY, 0.0, 0.0}
	Add(txt)
end

function VertPosStep(PosIn)
	return PosIn - VerticalStep
end

VertPos = UpCorner
AddText("txtVertAccel", LeftCorner, VertPos, {"%2.2f"}, {{"txtVertAccel", 0}})

VertPos = VertPosStep(VertPos)
AddText("txtKIAS", LeftCorner, VertPos, {"%3.2f"}, {{"txtKIAS", 0}})

VertPos = VertPosStep(VertPos)
AddText("txtVVI", LeftCorner, VertPos, {"%4.2f"}, {{"txtVVI", 0}})

VertPos = VertPosStep(VertPos)
AddText("txtAOA_Units", LeftCorner, VertPos, {"%2.2f"}, {{"txtAOA_Units", 0}})

VertPos = VertPosStep(VertPos)
AddText("txtBALT", LeftCorner, VertPos, {"%5.2f"}, {{"txtBALT", 0}})

VertPos = VertPosStep(VertPos)
AddText("txtPitch", LeftCorner, VertPos, {"%5.2f"}, {{"txtPitch", 0}})
