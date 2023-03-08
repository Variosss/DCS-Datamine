declare_loadout({
	category 		= CAT_PODS,
	CLSID			= "{AAQ-28_LEFT}",
	attribute		= {4, 15,	44, WSTYPE_PLACEHOLDER},
	Count 			= 1,
	Weight			= 208,
	Cx_pil			= 0.0005949,
	Picture			= "AAQ-28.png",
	displayName		= _("AN/AAQ-28 LITENING - Targeting Pod"),
	
	shape_table_data =
	{
		{
			file = "aaq-28LEFT litening",
			life = 1,
			fire = { 0, 1},
			username = "aaq-28LEFT litening",
			index = WSTYPE_PLACEHOLDER,
		},
	},
	
	Elements		=	
	{
		{
			ShapeName	=	"aaq-28LEFT litening",
		}
	},	

	Sensors	 = 
	{
		OPTIC  = {"Litening AN/AAQ-28 FLIR", "Litening AN/AAQ-28 CCD TV"}
	}
})

declare_sensor({
	category = SENSOR_OPTICAL,
	Name = "ATFLIR AN/ASQ-228 FLIR",
	type = OPTIC_SENSOR_IR,
	scan_volume =
	{
		azimuth = {-150.0, 150.0},
		elevation = {-150.0, 45.0}
	},
	view_volume_max = 
	{
		azimuth_sector = 18.4,
		elevation_sector = 24.1
	},
	magnifications = {3, 25, 90},
	resolution = 0.07, 
	laserRanger = true,
})

declare_sensor({
	category = SENSOR_OPTICAL,
	Name = "ATFLIR AN/ASQ-228 CCD TV",
	type = OPTIC_SENSOR_TV,
	scan_volume =
	{
		azimuth = {-150.0, 150.0},
		elevation = {-150.0, 45.0}
	},
	view_volume_max = 
	{
		azimuth_sector = 3.5,
		elevation_sector = 3.5
	},
	magnifications = {20.0, 100.0, 280.0},
	resolution = 0.085,
})

declare_loadout({
	category 		= CAT_PODS,
	CLSID			= "{AN_ASQ_228}",
	attribute		= {4, 15,	44, WSTYPE_PLACEHOLDER},
	Count 			= 1,
	Weight			= 195,
	Cx_pil			= 0.0005946,
	Picture			= "ASQ-228.png",
	displayName		= _("AN/ASQ-228 ATFLIR - Targeting Pod"),
	
	shape_table_data =
	{
		{
			file = "AN_ASQ_228",
			life = 1,
			fire = { 0, 1},
			username = "AN_ASQ_228",
			index = WSTYPE_PLACEHOLDER,
		},
	},
	
	Elements		=	
	{
		{
			ShapeName	=	"AN_ASQ_228",
		}
	},	

	Sensors	 = 
	{
		OPTIC  = {"ATFLIR AN/ASQ-228 FLIR", "ATFLIR AN/ASQ-228 CCD TV"}
	}	
})

declare_loadout({
	category 		= CAT_PODS,
	CLSID			= "{AN_ASQ_213}",
	Picture			= "lantirn.png",
	attribute		= {4, 15,	44,	WSTYPE_PLACEHOLDER},
	Count 			= 1,
	Weight			= 57.2,
	Cx_pil			= 0.0002,
	displayName		= _("AN/ASQ-213 HTS - HARM Targeting System"),
	
	shape_table_data =
	{
		{
			file = "f-16c_hts_pod",
			life = 1,
			fire = { 0, 1},
			username = "f-16c_hts_pod",
			index = WSTYPE_PLACEHOLDER,
		},
	},

	Elements		= 
	{
		{
			ShapeName = "16c_hts_pod",
		}
	},
})
