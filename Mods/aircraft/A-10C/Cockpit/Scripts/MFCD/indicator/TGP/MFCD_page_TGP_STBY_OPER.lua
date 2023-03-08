dofile(LockOn_Options.script_path.."MFCD/indicator/TGP/MFCD_TGP_tools.lua")

-- Not sure what for it is
Label_OSB3   = add_OSB_label(3, "STBY", false, true)
addOSB_Box(3, {Label_OSB3})
add_osb_static_hint(3, _("Standby Mode is Active"))

add_dummy_boxes({5})
add_dummy_boxes({6, 8, 9, 10})
add_dummy_boxes({16, 17, 19, 20})
