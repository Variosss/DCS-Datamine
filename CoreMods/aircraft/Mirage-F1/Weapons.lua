local PTB1200_empty_w = 251.0
local PTG580_empty_w = 350.0



declare_loadout(
 {
  category   = CAT_FUEL_TANKS,
  CLSID    = "PTB-1200-F1",
  attribute  =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
  Picture   = "ftm1.png",
  displayName  = _("Mirage F1 Fuel Tank 1200 liters"),
  Cx_pil	=	0.001,
  Weight_Empty  = PTB1200_empty_w,
  Weight     = PTB1200_empty_w + 898.0,
  Capacity    = 898.0,
  shape_table_data = 
  {
   {
   file    = "PTB_1200_F1";
   life    = 1;
   fire    = { 0, 1};
   username = "Mirage F1 Fuel Tank 1200 l";
   index = WSTYPE_PLACEHOLDER;
   },
  },
  Elements  = 
  {
   {
    Position = {0, 0, 0},
	Rotation =  {0,0,0},
    ShapeName = "PTB_1200_F1",
   }, 
  }, 
 }
)

declare_loadout(
 {
  category   = CAT_FUEL_TANKS,
  CLSID    = "PTB-1200-F1-EMPTY",
  attribute  =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
  Picture   = "ftm1.png",
  displayName  = _("Mirage F1 Fuel Tank 1200 liters (Empty)"),
  Cx_pil	=	0.001,
  Weight_Empty  = PTB1200_empty_w,
  Weight     = PTB1200_empty_w,
  Capacity    = 898.0,
  shape_table_data = 
  {
   {
   file    = "PTB_1200_F1";
   life    = 1;
   fire    = { 0, 1};
   username = "Mirage F1 Fuel Tank 1200 l";
   index = WSTYPE_PLACEHOLDER;
   },
  },
  Elements  = 
  {
   {
    Position = {0, 0, 0},
	Rotation =  {0,0,0},
    ShapeName = "PTB_1200_F1",
   }, 
  }, 
 }
)

declare_loadout(
 {
  category   = CAT_FUEL_TANKS,
  CLSID    = "PTB-580G-F1",
  attribute  =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
  Picture   = "ftm1.png",
  displayName  = _("Mirage F1 Fuel Tank 580 gal"),
  Cx_pil	=	0.001,
  Weight_Empty  = PTG580_empty_w,
  Weight     = PTG580_empty_w + 1734.0,
  Capacity    = 1734.0,
  shape_table_data = 
  {
   {
   file    = "PTB_580G_F1";
   life    = 1;
   fire    = { 0, 1};
   username = "Mirage F1 Fuel Tank 580 gal";
   index = WSTYPE_PLACEHOLDER;
   },
  },
  Elements  = 
  {
   {
    Position = {0, 0, 0},
	Rotation =  {0,0,0},
    ShapeName = "PTB_580G_F1",
   }, 
  }, 
 }
)

declare_loadout(
 {
  category   = CAT_FUEL_TANKS,
  CLSID    = "PTB-580G-F1-EMPTY",
  attribute  =  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
  Picture   = "ftm1.png",
  displayName  = _("Mirage F1 Fuel Tank 580 gal (Empty)"),
  Cx_pil	=	0.001,
  Weight_Empty  = PTG580_empty_w,
  Weight     = PTG580_empty_w,
  Capacity    = 1734.0,
  shape_table_data = 
  {
   {
   file    = "PTB_580G_F1";
   life    = 1;
   fire    = { 0, 1};
   username = "Mirage F1 Fuel Tank 580 gal";
   index = WSTYPE_PLACEHOLDER;
   },
  },
  Elements  = 
  {
   {
    Position = {0, 0, 0},
	Rotation =  {0,0,0},
    ShapeName = "PTB_580G_F1",
   }, 
  }, 
 }
)