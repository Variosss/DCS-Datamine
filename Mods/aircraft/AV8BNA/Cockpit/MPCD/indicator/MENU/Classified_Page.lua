-----------------------------
-- CLASSIFIED PAGE WARNING --
-----------------------------

local	Warning_Line			= CreateElement "ceStringSLine"
		Warning_Line.name		= "Warning_Line_1"
		Warning_Line.material	= stroke_font
		Warning_Line.init_pos	= {0.0, PosY(0.04), 0}
		Warning_Line.value		= "CLASSIFIED DATA"
		Warning_Line.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		Warning_Line.alignment	= "CenterCenter"
Add_MPCD_Element(Warning_Line)

local	Warning_Line			= CreateElement "ceStringSLine"
		Warning_Line.name		= "Warning_Line_2"
		Warning_Line.material	= stroke_font
		Warning_Line.init_pos	= {0.0, PosY(-0.04), 0}
		Warning_Line.value		= "AMU"
		Warning_Line.stringdefs	= stringdefs[STROKE_FNT_DFLT_150]
		Warning_Line.alignment	= "CenterCenter"
Add_MPCD_Element(Warning_Line)

