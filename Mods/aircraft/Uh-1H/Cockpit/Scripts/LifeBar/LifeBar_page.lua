dofile(LockOn_Options.common_script_path.."elements_defs.lua")

SetCustomScale(1.0)

function AddElement(object)
	object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end

-- life bar size: (relative coordinates, -1..1 for vertical axis: full vertical window dimension)
local lifebar_height	= 0.1
local lifebar_widht		= 0.4

-- life bar position:
-- (position of the left top corner)
local lifebar_pos_ver	= -1.0+lifebar_height*1.5
local lifebar_pos_hor	= -lifebar_widht/2.0

-- widht of the border line:
local lifebarborderline_widht = lifebar_height/10.0;

-- color of bar and border:
local bar_mat		= MakeMaterial("",{0,255,0,200})
local border_mat		= MakeMaterial("",{255,255,255,200})


-- рисуем ободок
-- верхн€€ лини€
lifebarbox_up				= CreateElement "ceMeshPoly"
lifebarbox_up.name			= "lifebarbox_up"
lifebarbox_up.primitivetype	= "triangles"
lifebarbox_up.material		= border_mat
lifebarbox_up.vertices		= {	{-lifebarborderline_widht/2.0	, -lifebarborderline_widht/2.0 },
								{-lifebarborderline_widht/2.0	,  lifebarborderline_widht/2.0 }, 
								{ lifebar_widht+lifebarborderline_widht/2.0		,  lifebarborderline_widht/2.0 },
								{ lifebar_widht+lifebarborderline_widht/2.0		, -lifebarborderline_widht/2.0 }}        
lifebarbox_up.indices			= default_box_indices
lifebarbox_up.init_pos		= {lifebar_pos_hor, lifebar_pos_ver}
AddElement(lifebarbox_up)

-- нижн€€ лини€
lifebarbox_down					= CreateElement "ceMeshPoly"
lifebarbox_down.name			= "lifebarbox_down"
lifebarbox_down.primitivetype	= "triangles"
lifebarbox_down.material		= border_mat
lifebarbox_down.vertices		= {	{-lifebarborderline_widht/2.0	, -lifebarborderline_widht/2.0 },
									{-lifebarborderline_widht/2.0	,  lifebarborderline_widht/2.0 }, 
									{ lifebar_widht+lifebarborderline_widht/2.0		,  lifebarborderline_widht/2.0 },
									{ lifebar_widht+lifebarborderline_widht/2.0		, -lifebarborderline_widht/2.0 }} 
lifebarbox_down.indices			= default_box_indices
lifebarbox_down.init_pos		= {lifebar_pos_hor, lifebar_pos_ver-lifebar_height}
AddElement(lifebarbox_down)

-- лева€ лини€
lifebarbox_lh					= CreateElement "ceMeshPoly"
lifebarbox_lh.name			= "lifebarbox_lh"
lifebarbox_lh.primitivetype	= "triangles"
lifebarbox_lh.material		= border_mat
lifebarbox_lh.vertices		= {	{-lifebarborderline_widht/2.0	, -lifebar_height+lifebarborderline_widht/2.0 },
								{-lifebarborderline_widht/2.0	, -lifebarborderline_widht/2.0 }, 
								{ lifebarborderline_widht/2.0	, -lifebarborderline_widht/2.0 },
								{ lifebarborderline_widht/2.0	, -lifebar_height+lifebarborderline_widht/2.0 }}        
lifebarbox_lh.indices			= default_box_indices
lifebarbox_lh.init_pos		= {lifebar_pos_hor, lifebar_pos_ver}
AddElement(lifebarbox_lh)

-- права€ лини€
lifebarbox_rh					= CreateElement "ceMeshPoly"
lifebarbox_rh.name			= "lifebarbox_rh"
lifebarbox_rh.primitivetype	= "triangles"
lifebarbox_rh.material		= border_mat
lifebarbox_rh.vertices		= {	{-lifebarborderline_widht/2.0	, -lifebar_height+lifebarborderline_widht/2.0 },
								{-lifebarborderline_widht/2.0	, -lifebarborderline_widht/2.0 }, 
								{ lifebarborderline_widht/2.0	, -lifebarborderline_widht/2.0 },
								{ lifebarborderline_widht/2.0	, -lifebar_height+lifebarborderline_widht/2.0 }} 
lifebarbox_rh.indices			= default_box_indices
lifebarbox_rh.init_pos		= {lifebar_pos_hor+lifebar_widht, lifebar_pos_ver}
AddElement(lifebarbox_rh)




-- рисуем полоску ’ѕ
lifebar					= CreateElement "ceMeshPoly"
lifebar.name			= "lifebar"
lifebar.primitivetype	= "triangles"
lifebar.material		= bar_mat -- "GREEN_TRANSPARENT"
lifebar.vertices		= {	{ 0.0				, -lifebar_height },
							{ 0.0				,  0.0 }, 
							{ lifebar_widht		,  0.0 },
							{ lifebar_widht		, -lifebar_height }}        
lifebar.indices			= default_box_indices
lifebar.init_pos		= { lifebar_pos_hor	,	lifebar_pos_ver}
local aspect = 1.5
lifebar.controllers	= {	{"show"},
						{"life_bar", lifebar_widht}	}
AddElement(lifebar)

