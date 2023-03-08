dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("ScratchBorders", 1 + ScratchPadHorOffset, 10, LFT, "[               ]")

if RepeaterMode then
	BlinkTime = 1.0
else
	BlinkTime = 0.5
end

AddText("ScratchString", 2 + ScratchPadHorOffset, 10, LFT, {{"ScratchString", BlinkTime}})
AddCursor(1 + ScratchPadHorOffset, {{"CursorBlink", BlinkTime}, {"CursorPos", HorizontalK_TextPos}})

if RepeaterMode then
	AddText("LetterUnderCursor", 1 + ScratchPadHorOffset, 10, LFT, {{"LetterUnderCursor", HorizontalK_TextPos, BlinkTime}}, nil, true)
end
