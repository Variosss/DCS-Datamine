dofile(LockOn_Options.script_path.."CDU/indicator/CDU_definitions.lua")

AddStaticText("PageNameFROM",      2, 1, LFT, "FROM")
AddStaticText("FROM_CF_RTRY",     24, 3, LFT, ROTARY)

AddText		 ("FROM_CoordFormat0",23, 3, RGHT, {{"FROM_CoordFormat", 0}}, "L/L")
AddText		 ("FROM_CoordFormat1",23, 3, RGHT, {{"FROM_CoordFormat", 1}}, "UTM")

AddText      ("FROM_DataEntry0",   1, 3, LFT,  {{"FROM_ToToMode", 2}}, DATA_ENTRY);
AddText      ("FROM_DataEntry1",   1, 5, LFT,  {{"FROM_ToToMode", 2}}, DATA_ENTRY);

AddText      ("FROM_WptNumber",    2, 3, LFT, {{"FROM_ToToMode", 2}, {"FROM_WaypointNumber"}});
AddText      ("FROM_WptNumber1",    2, 3, LFT, {{"FROM_ToToMode", 0}}, "******");
AddText      ("FROM_WptIdent",     2, 5, LFT, {{"FROM_ToToMode", 2}, {"FROM_WaypointID"}});
AddText      ("FROM_WptIdent1",     2, 5, LFT, {{"FROM_ToToMode", 0}}, "************");

AddText      ("FROM_Lat",          2, 7, LFT, {{"FROM_CoordFormat", 0}, {"FROM_ToToMode", 0}}, "**********");
AddText      ("FROM_Long",         2, 9, LFT, {{"FROM_CoordFormat", 0}, {"FROM_ToToMode", 0}}, "***********");
AddText      ("FROM_Lat1",          2, 7, LFT, {{"FROM_CoordFormat", 0}, {"FROM_ToToMode", 2}, {"FROM_Latitude"}});
AddText      ("FROM_Long1",         2, 9, LFT, {{"FROM_CoordFormat", 0}, {"FROM_ToToMode", 2}, {"FROM_Longitude"}});

AddText      ("FROM_PointGrid",    2, 7, LFT, {{"FROM_CoordFormat", 1}, {"FROM_ToToMode", 0}}, "*******");
AddText      ("FROM_PointArea",    2, 9, LFT, {{"FROM_CoordFormat", 1}, {"FROM_ToToMode", 0}}, "**************");
AddText      ("FROM_PointGrid1",          2, 7, LFT, {{"FROM_CoordFormat", 1}, {"FROM_ToToMode", 2}, {"FROM_PointGrid"}});
AddText      ("FROM_PointArea1",         2, 9, LFT, {{"FROM_CoordFormat", 1}, {"FROM_ToToMode", 2}, {"FROM_PointArea"}});

add_static_hint_CDU("L1", _("Enter a new FROM point number/markpoint letter from the scratchpad"))
add_static_hint_CDU("L2", _("Enter a new FROM point identifier from the scratchpad"))

add_static_hint_CDU("R1", _("Rotary between Lat/Long and UTM"))




