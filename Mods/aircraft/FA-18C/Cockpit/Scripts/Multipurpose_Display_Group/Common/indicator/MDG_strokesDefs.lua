dofile(LockOn_Options.script_path.."config.lua")

stroke_thickness  = 0.8
stroke_fuzziness  = 0.5

if bakeIndicators == true then
	DMC_stroke_thickness  = stroke_thickness
	DMC_stroke_fuzziness  = stroke_fuzziness
	
	-- Currently is used for DMC generated fonts black outline
	--DMC_outline_thickness = stroke_thickness * 3
	--DMC_outline_fuzziness = stroke_fuzziness * 1.1

	-- valid for cockpit view, but looks overdone at HUD only view
	DMC_outline_thickness = stroke_thickness * 4
	DMC_outline_fuzziness = stroke_fuzziness * 1.4
else
	DMC_stroke_thickness  = 0.65
	DMC_stroke_fuzziness  = 0.42
	
	-- Currently is used for DMC generated fonts black outline
	DMC_outline_thickness = stroke_thickness * 3
	DMC_outline_fuzziness = stroke_fuzziness * 1.1
end
