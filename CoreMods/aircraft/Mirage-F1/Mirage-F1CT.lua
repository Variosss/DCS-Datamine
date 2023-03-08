
make_MirageF1({
	Name						= 'Mirage-F1CT',
	DisplayName					= _('Mirage F1CT'),
	WorldID 					= WSTYPE_PLACEHOLDER,
	Countries 					= {"USA", "France"},
	attribute 					= makeAttribute(WSTYPE_PLACEHOLDER, true),
	tanker_type 				= 2, -- Tanker type if the plane is airrefuel capable
	air_refuel_receptacle_pos 	= air_refuel_receptacle_pos_short,
	
	Pylons = {
        pylon(1, 0, -3.215, -0.035, -4.329,{ use_full_connector_position=true,connector = "Pylon1",  arg = 308, arg_value = 0.0},
			{	
				pylon_loadout(id_MAGIC_I, 0.15, nil, {-0.1,  -0.09,  0.0},		{ 7 }), -- R550 Magic I
				pylon_loadout(id_MAGIC_II, 0.15, nil, {-0.1,  -0.09,  0.0},		{ 7 }), -- R550 Magic II
				
							
			}
        ),
        pylon(2, 0, -1.982, -0.207, -2.867,{ use_full_connector_position=true,connector = "Pylon2", arg = 309, arg_value = 0.0 },
            {
				--pylon_loadout(id_MK82, 0.25, nil,	nil, 		{ 6 }),		-- MK82
				--pylon_loadout(id_MK83, 0.25, nil,	nil,		{ 6 }), 	-- MK83
				--pylon_loadout(id_BR_250, 0.25, nil, nil,		{ 6 }),	-- BR_250
				--pylon_loadout(id_BR_500, 0.25, nil, nil,		{ 6 }), -- BR_500
				pylon_loadout(id_SAMP125LD, 0.25, nil,	nil, 	{ 6 }),		-- SAMP 125 Low Drag
				pylon_loadout(id_SAMP250LD, 0.25, nil,	nil,	{ 6 }), 	-- SAMP 250 Low Drag
				pylon_loadout(id_SAMP250HD, 0.25, nil, nil,	{ 6 }),	-- SAMP 250 High Drag
				pylon_loadout(id_SAMP400LD, 0.25, nil, nil,	{ 6 }), -- SAMP 400 Low Drag
				pylon_loadout(id_SAMP400HD, 0.25, nil,	nil,	{ 6 }), 	-- SAMP 400 High Drag
				pylon_loadout(id_BLU107B_DURANDAL, 0.25, nil, nil,		{ 6 }),	-- Durandal
				pylon_loadout(id_BLG66_BELOUGA, 0.25, nil, {0.04,  0.00,  0.0},		{ 6 }), -- BELOUGA
				pylon_loadout(id_MF1_250, 0.35, nil,	nil, 	{ 6 }),		-- MATRA F1
				pylon_loadout(id_MF1_251, 0.35, nil,	nil,	{ 6 }), 	-- MATRA F1 AA HE
				pylon_loadout(id_MF1_252, 0.35, nil, nil,		{ 6 }),	-- MATRA F1	
				pylon_loadout(id_MF1_253, 0.35, nil, nil,		{ 6 }), -- MATRA F1 Shaped charge
				pylon_loadout(id_MF1_254_R, 0.35, nil,	nil, 	{ 6 }),		-- MATRA F1 smoke
				pylon_loadout(id_MF1_254_Y, 0.35, nil,	nil,	{ 6 }), 	-- MATRA F1 smoke
				pylon_loadout(id_MF1_254_G, 0.35, nil, nil,	{ 6 }),	-- MATRA F1 smoke
				pylon_loadout(id_MF1_256, 0.35, nil, nil,		{ 6 }), -- MATRA F1 AP
				pylon_loadout(id_MF1_257, 0.35, nil,	nil,	{ 6 }), 	-- MATRA F1
				pylon_loadout(id_MF1_259E, 0.35, nil, nil,		{ 6 }),	-- MATRA F1
				pylon_loadout(id_MF4_250, 0.25, nil,	nil, 	{ 6 }),		-- MATRA F4
				pylon_loadout(id_MF4_251, 0.25, nil,	nil,	{ 6 }), 	-- MATRA F4 AA HE
				pylon_loadout(id_MF4_252, 0.25, nil, nil,		{ 6 }),	-- MATRA F4	
				pylon_loadout(id_MF4_253, 0.25, nil, nil,		{ 6 }), -- MATRA F4 Shaped charge
				pylon_loadout(id_MF4_254_R, 0.25, nil,	nil, 	{ 6 }),		-- MATRA F4 smoke
				pylon_loadout(id_MF4_254_Y, 0.25, nil,	nil,	{ 6 }), 	-- MATRA F4 smoke
				pylon_loadout(id_MF4_254_G, 0.25, nil, nil,	{ 6 }),	-- MATRA F4 smoke
				pylon_loadout(id_MF4_256, 0.25, nil, nil,		{ 6 }), -- MATRA F4 AP
				pylon_loadout(id_MF4_257, 0.25, nil,	nil,	{ 6 }), 	-- MATRA F4
				pylon_loadout(id_MF4_259E, 0.25, nil, nil,		{ 6 }),	-- MATRA F4
								

            }
        ),
        pylon(3, 0, -1.647, -0.328,  -2.048,
            { use_full_connector_position=true, arg = 310,connector = "Pylon3", arg_value = 0.0 },
            {
				--pylon_loadout(id_MK82, 0.15, nil,	nil, 		{ 5 }),		-- MK82
				--pylon_loadout(id_MK83, 0.15, nil,	nil,		{ 5 }), 	-- MK83
				--pylon_loadout(id_BR_250, 0.15, nil, nil,		{ 5 }),	-- BR_250
				--pylon_loadout(id_BR_500, 0.15, nil, nil,		{ 5 }), -- BR_500
				pylon_loadout(id_SAMP125LD, 0.15, nil,	nil, 	{ 5 }),		-- SAMP 125 Low Drag
				pylon_loadout(id_SAMP250LD, 0.15, nil,	nil,	{ 5 }), 	-- SAMP 250 Low Drag
				pylon_loadout(id_SAMP250HD, 0.15, nil, nil,	{ 5 }),	-- SAMP 250 High Drag
				pylon_loadout(id_SAMP400LD, 0.15, nil, nil,	{ 5 }), -- SAMP 400 Low Drag
				pylon_loadout(id_SAMP400HD, 0.15, nil,	nil,	{ 5 }), 	-- SAMP 400 High Drag
				pylon_loadout(id_BLU107B_DURANDAL, 0.15, nil, nil,		{ 5 }),	-- Durandal
				pylon_loadout(id_BLG66_BELOUGA, 0.15, nil, {0.04,  0.00,  0.0},		{ 5 }), -- BELOUGA
				pylon_loadout(id_MF1_250, 0.15, nil,	nil, 	{ 5 }),		-- MATRA F1
				pylon_loadout(id_MF1_251, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F1 AA HE
				pylon_loadout(id_MF1_252, 0.15, nil, nil,		{ 5 }),	-- MATRA F1	
				pylon_loadout(id_MF1_253, 0.15, nil, nil,		{ 5 }), -- MATRA F1 Shaped charge
				pylon_loadout(id_MF1_254_R, 0.15, nil,	nil, 	{ 5 }),		-- MATRA F1 smoke
				pylon_loadout(id_MF1_254_Y, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F1 smoke
				pylon_loadout(id_MF1_254_G, 0.15, nil, nil,	{ 5 }),	-- MATRA F1 smoke
				pylon_loadout(id_MF1_256, 0.15, nil, nil,		{ 5 }), -- MATRA F1 AP
				pylon_loadout(id_MF1_257, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F1
				pylon_loadout(id_MF1_259E, 0.15, nil, nil,		{ 5 }),	-- MATRA F1
				pylon_loadout(id_MF4_250, 0.15, nil,	nil, 	{ 5 }),		-- MATRA F4
				pylon_loadout(id_MF4_251, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F4 AA HE
				pylon_loadout(id_MF4_252, 0.15, nil, nil,		{ 5 }),	-- MATRA F4	
				pylon_loadout(id_MF4_253, 0.15, nil, nil,		{ 5 }), -- MATRA F4 Shaped charge
				pylon_loadout(id_MF4_254_R, 0.15, nil,	nil, 	{ 5 }),		-- MATRA F4 smoke
				pylon_loadout(id_MF4_254_Y, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F4 smoke
				pylon_loadout(id_MF4_254_G, 0.15, nil, nil,	{ 5 }),	-- MATRA F4 smoke
				pylon_loadout(id_MF4_256, 0.15, nil, nil,		{ 5 }), -- MATRA F4 AP
				pylon_loadout(id_MF4_257, 0.15, nil,	nil,	{ 5 }), 	-- MATRA F4
				pylon_loadout(id_MF4_259E, 0.15, nil, nil,		{ 5 }),	-- MATRA F4
				pylon_loadout(id_SUPER_530F, 0.25, nil, {0.0, -0.1, 0.00},	{ 5 }, {{station = 4, loadout = {id_R530F_EM}}, {station = 4, loadout = {id_R530F_IR}}}),-- MATRA S530F	
				--pylon_loadout(id_GBU_10, 0.15, nil, nil,		{ 5 }), -- GBU_10
				--pylon_loadout(id_GBU_12, 0.15, nil,	nil,		{ 5 }), 	-- GBU_12
				pylon_loadout(id_PTB_1200_F1, 0.15, nil, nil,	{ 5 }),	-- FUEL TANK	
				pylon_loadout(id_PTB_1200_F1_EMPTY, 0.15, nil, nil,	{ 5 }),	-- FUEL TANK
		
				
            }
        ),
		------------ 
        pylon(4, 0, -1.06, -1.283, 0.0,{ use_full_connector_position=true,connector = "Pylon4", arg = 311, arg_value = 0.0 },
            {
				--pylon_loadout(id_MK82, 0.15, nil,	nil),		-- MK82
				--pylon_loadout(id_MK83, 0.15, nil,	nil), 	-- MK83
				--pylon_loadout(id_GBU_10, 0.15, nil,	nil), -- GBU_10
				--pylon_loadout(id_GBU_12, 0.15, nil,	nil), 	-- GBU_12
				pylon_loadout(id_BLG66_BELOUGA, 0.15, nil,	nil), -- BELOUGA
				--pylon_loadout(id_BR_250, 0.15, nil,	nil),	-- BR_250
				--pylon_loadout(id_BR_500, 0.15, nil,	nil), -- BR_500	
				pylon_loadout(id_SAMP250LD, 0.15, nil,	nil), 	-- SAMP 250 Low Drag
				pylon_loadout(id_SAMP250HD, 0.15, nil,	nil),	-- SAMP 250 High Drag
				pylon_loadout(id_SAMP400LD, 0.15, nil,	nil), -- SAMP 400 Low Drag
				pylon_loadout(id_SAMP400HD, 0.15, nil,	nil), 	-- SAMP 400 High Drag				
				pylon_loadout(id_SUPER_530F, 0.15, nil, nil,	{ 5 }),	--SUPER 530F			
				--pylon_loadout(id_CLB4_MK82, 0.35, nil,	nil),
				pylon_loadout(id_CLB4_DURANDAL, 0.35, nil,	nil),
				pylon_loadout(id_CLB4_125LD, 0.35, nil,	nil),
				pylon_loadout(id_CLB4_250LD, 0.35, nil,	nil),
				pylon_loadout(id_CLB4_250HD, 0.35, nil,	nil),
				pylon_loadout(id_CLB4_400LD, 0.35, nil,	nil),
				pylon_loadout(id_CLB4_400HD, 0.35, nil,	nil),
				pylon_loadout(id_PTB_1200_F1, 0.15, nil, nil),	-- FUEL TANK
				pylon_loadout(id_PTB_1200_F1_EMPTY, 0.15, nil, nil),	-- FUEL TANK
				pylon_loadout(id_PTB_580G_F1, 0.35, nil, nil),	-- FUEL TANK
				pylon_loadout(id_PTB_580G_F1_EMPTY, 0.35, nil, nil),	-- FUEL TANK				
								
            }
		),
		------------		
        pylon(5, 0, -1.647, -0.328,  2.048,{ use_full_connector_position=true,connector = "Pylon5", arg = 312, arg_value = 0.0 },
            {
				--pylon_loadout(id_MK82, 0.15, nil,	nil, 		{ 3 }),		-- MK82
				--pylon_loadout(id_MK83, 0.15, nil,	nil,		{ 3 }), 	-- MK83
				--pylon_loadout(id_BR_250, 0.15, nil, nil,		{ 3 }),	-- BR_250
				--pylon_loadout(id_BR_500, 0.15, nil, nil,		{ 3 }), -- BR_500
				pylon_loadout(id_SAMP125LD, 0.15, nil,	nil, 	{ 3 }),		-- SAMP 125 Low Drag
				pylon_loadout(id_SAMP250LD, 0.15, nil,	nil,	{ 3 }), 	-- SAMP 250 Low Drag
				pylon_loadout(id_SAMP250HD, 0.15, nil, nil,	{ 3 }),	-- SAMP 250 High Drag
				pylon_loadout(id_SAMP400LD, 0.15, nil, nil,	{ 3 }), -- SAMP 400 Low Drag
				pylon_loadout(id_SAMP400HD, 0.15, nil,	nil,	{ 3 }), 	-- SAMP 400 High Drag
				pylon_loadout(id_BLU107B_DURANDAL, 0.15, nil, nil,		{ 3 }),	-- Durandal
				pylon_loadout(id_BLG66_BELOUGA, 0.15, nil, {0.04,  0.00,  0.0},		{ 3 }), -- BELOUGA
				pylon_loadout(id_MF1_250, 0.15, nil,	nil, 	{ 3 }),		-- MATRA F1
				pylon_loadout(id_MF1_251, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F1 AA HE
				pylon_loadout(id_MF1_252, 0.15, nil, nil,		{ 3 }),	-- MATRA F1	
				pylon_loadout(id_MF1_253, 0.15, nil, nil,		{ 3 }), -- MATRA F1 Shaped charge
				pylon_loadout(id_MF1_254_R, 0.15, nil,	nil, 	{ 3 }),		-- MATRA F1 smoke
				pylon_loadout(id_MF1_254_Y, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F1 smoke
				pylon_loadout(id_MF1_254_G, 0.15, nil, nil,	{ 3 }),	-- MATRA F1 smoke
				pylon_loadout(id_MF1_256, 0.15, nil, nil,		{ 3 }), -- MATRA F1 AP
				pylon_loadout(id_MF1_257, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F1
				pylon_loadout(id_MF1_259E, 0.15, nil, nil,		{ 3 }),	-- MATRA F1
				pylon_loadout(id_MF4_250, 0.15, nil,	nil, 	{ 3 }),		-- MATRA F4
				pylon_loadout(id_MF4_251, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F4 AA HE
				pylon_loadout(id_MF4_252, 0.15, nil, nil,		{ 3 }),	-- MATRA F4	
				pylon_loadout(id_MF4_253, 0.15, nil, nil,		{ 3 }), -- MATRA F4 Shaped charge
				pylon_loadout(id_MF4_254_R, 0.15, nil,	nil, 	{ 3 }),		-- MATRA F4 smoke
				pylon_loadout(id_MF4_254_Y, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F4 smoke
				pylon_loadout(id_MF4_254_G, 0.15, nil, nil,	{ 3 }),	-- MATRA F4 smoke
				pylon_loadout(id_MF4_256, 0.15, nil, nil,		{ 3 }), -- MATRA F4 AP
				pylon_loadout(id_MF4_257, 0.15, nil,	nil,	{ 3 }), 	-- MATRA F4
				pylon_loadout(id_MF4_259E, 0.15, nil, nil,		{ 3 }),	-- MATRA F4
				pylon_loadout(id_SUPER_530F, 0.25, nil, {0.0, -0.1, 0.00},	{ 3 }, {{station = 4, loadout = {id_R530F_EM}}, {station = 4, loadout = {id_R530F_IR}}}),-- MATRA S530F				
				--pylon_loadout(id_GBU_10, 0.15, nil, nil,		{ 3 }), -- GBU_10
				--pylon_loadout(id_GBU_12, 0.15, nil,	nil,		{ 3 }), 	-- GBU_12
				pylon_loadout(id_PTB_1200_F1, 0.15, nil, nil,	{ 3 }),	-- FUEL TANK							
				pylon_loadout(id_PTB_1200_F1_EMPTY, 0.15, nil, nil,	{ 3 }),	-- FUEL TANK

            }
		),
        pylon(6, 0, -1.982, -0.207, 2.867,{ use_full_connector_position=true,connector = "Pylon6", arg = 313, arg_value = 0.0 },
            {
	
				--pylon_loadout(id_MK82, 0.25, nil,	nil, 		{ 2 }),		-- MK82
				--pylon_loadout(id_MK83, 0.25, nil,	nil,		{ 2 }), 	-- MK83
				--pylon_loadout(id_BR_250, 0.25, nil, nil,		{ 2 }),	-- BR_250
				--pylon_loadout(id_BR_500, 0.25, nil, nil,		{ 2 }), -- BR_500
				pylon_loadout(id_SAMP125LD, 0.25, nil,	nil, 	{ 2 }),		-- SAMP 125 Low Drag
				pylon_loadout(id_SAMP250LD, 0.25, nil,	nil,	{ 2 }), 	-- SAMP 250 Low Drag
				pylon_loadout(id_SAMP250HD, 0.25, nil, nil,	{ 2 }),	-- SAMP 250 High Drag
				pylon_loadout(id_SAMP400LD, 0.25, nil, nil,	{ 2 }), -- SAMP 400 Low Drag
				pylon_loadout(id_SAMP400HD, 0.25, nil,	nil,	{ 2 }), 	-- SAMP 400 High Drag
				pylon_loadout(id_BLU107B_DURANDAL, 0.25, nil, nil,		{ 2 }),	-- Durandal
				pylon_loadout(id_BLG66_BELOUGA, 0.25, nil, {0.04,  0.00,  0.0},		{ 2 }), -- BELOUGA
				pylon_loadout(id_MF1_250, 0.35, nil,	nil, 	{ 2 }),		-- MATRA F1
				pylon_loadout(id_MF1_251, 0.35, nil,	nil,	{ 2 }), 	-- MATRA F1 AA HE
				pylon_loadout(id_MF1_252, 0.35, nil, nil,		{ 2 }),	-- MATRA F1	
				pylon_loadout(id_MF1_253, 0.35, nil, nil,		{ 2 }), -- MATRA F1 Shaped charge
				pylon_loadout(id_MF1_254_R, 0.35, nil,	nil, 	{ 2 }),		-- MATRA F1 smoke
				pylon_loadout(id_MF1_254_Y, 0.35, nil,	nil,	{ 2 }), 	-- MATRA F1 smoke
				pylon_loadout(id_MF1_254_G, 0.35, nil, nil,	{ 2 }),	-- MATRA F1 smoke
				pylon_loadout(id_MF1_256, 0.35, nil, nil,		{ 2 }), -- MATRA F1 AP
				pylon_loadout(id_MF1_257, 0.35, nil,	nil,	{ 2 }), 	-- MATRA F1
				pylon_loadout(id_MF1_259E, 0.35, nil, nil,		{ 2 }),	-- MATRA F1
				pylon_loadout(id_MF4_250, 0.25, nil,	nil, 	{ 2 }),		-- MATRA F4
				pylon_loadout(id_MF4_251, 0.25, nil,	nil,	{ 2 }), 	-- MATRA F4 AA HE
				pylon_loadout(id_MF4_252, 0.25, nil, nil,		{ 2 }),	-- MATRA F4	
				pylon_loadout(id_MF4_253, 0.25, nil, nil,		{ 2 }), -- MATRA F4 Shaped charge
				pylon_loadout(id_MF4_254_R, 0.25, nil,	nil, 	{ 2 }),		-- MATRA F4 smoke
				pylon_loadout(id_MF4_254_Y, 0.25, nil,	nil,	{ 2 }), 	-- MATRA F4 smoke
				pylon_loadout(id_MF4_254_G, 0.25, nil, nil,	{ 2 }),	-- MATRA F4 smoke
				pylon_loadout(id_MF4_256, 0.25, nil, nil,		{ 2 }), -- MATRA F4 AP
				pylon_loadout(id_MF4_257, 0.25, nil,	nil,	{ 2 }), 	-- MATRA F4
				pylon_loadout(id_MF4_259E, 0.25, nil, nil,		{ 2 }),	-- MATRA F4					
            }
		),

        pylon(7, 0, -3.215, -0.035, 4.329,{ use_full_connector_position=true,connector = "Pylon7", arg = 314, arg_value = 0.0 },
            {
				pylon_loadout(id_MAGIC_I, 0.15, nil, {-0.1,  -0.09,  0.0},		{ 1 }), -- R550 Magic I
				pylon_loadout(id_MAGIC_II, 0.15, nil, {-0.1,  -0.09,  0.0},		{ 1 }), -- R550 Magic II
            }
        ),
    },
})
