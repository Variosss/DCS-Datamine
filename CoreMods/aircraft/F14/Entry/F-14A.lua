function f14a_settings(unit_name, display_name, countries)
	local f14a_local_setting =
	{
		Name =	unit_name,
		DisplayName = display_name or _(unit_name),
        Countries = countries,
        Shape = "F-14A-135-GR"
	}
	return f14a_local_setting
end

make_f14(f14a_settings('F-14A-135-GR',_('F-14A-135-GR'),{"USA", "Iran"}))
--make_f14(f14a_settings('F-14A-95-GR',_('F-14A-95-GR'),{"Iran"}))