dofile(LockOn_Options.script_path.."EWS/CMDS/indicator/CMDS_ALE47_definitions.lua")

addText("CMDS_O1_Amount", "", 0,  {{"CMDS_CM_Amount", ALE47_CM_Type.OTHER1}})
addText("CMDS_O2_Amount", "", 4,  {{"CMDS_CM_Amount", ALE47_CM_Type.OTHER2}})
addText("CMDS_CH_Amount", "", 8,  {{"CMDS_CM_Amount", ALE47_CM_Type.CHAFF}})
addText("CMDS_FL_Amount", "", 12, {{"CMDS_CM_Amount", ALE47_CM_Type.FLARE}})