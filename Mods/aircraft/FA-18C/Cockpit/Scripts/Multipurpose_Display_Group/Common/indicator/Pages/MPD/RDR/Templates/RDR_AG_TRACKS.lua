dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/Pages/MPD/RDR/RDR_defs.lua")
dofile(LockOn_Options.script_path.."Multipurpose_Display_Group/Common/indicator/MDG_strokesDefs.lua")

local AG_Targets_PH = addPlaceholder("RDR_AG_tracks", nil, nil, {{"MPD_RDR_AG_TracksSymbols", AG_TacticalAreaHeight}})
local TrackedTargetSymLen = 30
for i = 1, 4 do
	clippedObject = addStrokeLine("AG_Targets_ShapePiece_"..i, TrackedTargetSymLen, {-TrackedTargetSymLen * 0.5, 2 * (i - 2.5)}, -90, AG_Targets_PH.name)
	setClipLevel(clippedObject, 1)
end