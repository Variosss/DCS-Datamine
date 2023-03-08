local TAD_chart_map_set_file = get_terrain_related_data("TAD_chart_map_set_file")
-- execute file
if TAD_chart_map_set_file then
	set_render_to_texture(false)
	dofile(LockOn_Options.script_path.."MFCD/indicator/TAD/MFCD_page_TAD_CHART.lua")
	dofile(TAD_chart_map_set_file)
else
	dofile(LockOn_Options.script_path.."MFCD/indicator/MFCD_useful_definitions.lua")
	AddRender()
end


