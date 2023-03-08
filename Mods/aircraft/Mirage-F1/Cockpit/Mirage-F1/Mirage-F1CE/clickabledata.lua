-- F1CE clickable data description

dofile(LockOn_Options.script_path.."../../Common/clickabledata_common.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/clickabledata_common_F1C.lua")
dofile(LockOn_Options.script_path.."../../Mirage-F1/Mirage-F1_Common/clickabledata_common_F1CE_BE.lua")

local gettext = require("i_18n")
_ = gettext.translate



for i,o in pairs(elements) do
	if  o.class[1] == class_type.TUMB or 
	   (o.class[2]  and o.class[2] == class_type.TUMB) or
	   (o.class[3]  and o.class[3] == class_type.TUMB)  then
	   o.updatable = true
	   o.use_OBB   = true
	end
end
