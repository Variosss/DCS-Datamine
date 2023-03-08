local default_diff = "missing_texture"

livery = {
	{"mi_8_tex1", DIFFUSE		,default_diff			,FROM_PATHS};
	{"mi_8_tex1",  ROUGHNESS_METALLIC		,"mi_8_tex_1_RoughMet"		,FROM_PATHS};
	
	{"mi_8_tex2", DIFFUSE		,default_diff			,FROM_PATHS};
	{"mi_8_tex2",  ROUGHNESS_METALLIC		,"mi_8_tex_2_RoughMet"		,FROM_PATHS};
	
	{"mi_8_tex3", DIFFUSE		,default_diff			,FROM_PATHS};
	{"mi_8_tex3",  ROUGHNESS_METALLIC		,"mi_8_tex_3_RoughMet"		,FROM_PATHS};
	
	{"mi_8_tex4", DIFFUSE		,default_diff			,FROM_PATHS};
	{"mi_8_tex4",  ROUGHNESS_METALLIC		,"mi_8_tex_4_RoughMet"		,FROM_PATHS};
	{"EVU", DIFFUSE				,default_diff			,FROM_PATHS};

	---- БОРТОВЫЕ НОМЕРА

	{"mi_8_ENGINE_NUMBER_001", DIFFUSE		,default_diff			,FROM_PATHS};			 -- трехзначный бортовой номер. расположение - в районе воздухозаборников двигателей
	{"mi_8_ENGINE_NUMBER_001",  ROUGHNESS_METALLIC		,"mi_8_tex_1_RoughMet"		,FROM_PATHS};		--	   
	{"mi_8_ENGINE_NUMBER_001", DECAL		,"empty"				,FROM_PATHS};			  --

	{"mi_8_ENGINE_NUMBER_010", DIFFUSE		,default_diff			,FROM_PATHS};		  --	
	{"mi_8_ENGINE_NUMBER_010",  ROUGHNESS_METALLIC		,"mi_8_tex_1_RoughMet"		,FROM_PATHS};		--	   
	{"mi_8_ENGINE_NUMBER_010", DECAL		,"empty"				,FROM_PATHS};			  --

	{"mi_8_ENGINE_NUMBER_100", DIFFUSE		,default_diff			,FROM_PATHS};			--	
	{"mi_8_ENGINE_NUMBER_100",  ROUGHNESS_METALLIC		,"mi_8_tex_1_RoughMet"		,FROM_PATHS};		--	   
	{"mi_8_ENGINE_NUMBER_100", DECAL		,"empty"				,FROM_PATHS};			  --

	
	{"mi_8_SMALL_NUMBER_001", DIFFUSE		,default_diff			,FROM_PATHS};			-- трехзначный бортовой номер. расположение - на борту под воздухозаборниками двигателей
	{"mi_8_SMALL_NUMBER_001",  ROUGHNESS_METALLIC		,"mi_8_tex_1_RoughMet"		,FROM_PATHS};		--	   
	{"mi_8_SMALL_NUMBER_001", DECAL			,"empty"				,FROM_PATHS};			  --

	{"mi_8_SMALL_NUMBER_010", DIFFUSE		,default_diff			,FROM_PATHS};		  --	
	{"mi_8_SMALL_NUMBER_010",  ROUGHNESS_METALLIC		,"mi_8_tex_1_RoughMet"		,FROM_PATHS};		--	   
	{"mi_8_SMALL_NUMBER_010", DECAL			,"empty"				,FROM_PATHS};			  --

	{"mi_8_SMALL_NUMBER_100", DIFFUSE		,default_diff			,FROM_PATHS};			--	
	{"mi_8_SMALL_NUMBER_100",  ROUGHNESS_METALLIC		,"mi_8_tex_1_RoughMet"		,FROM_PATHS};		--	   
	{"mi_8_SMALL_NUMBER_100", DECAL			,"empty"				,FROM_PATHS};			  --

	{"mi_8_BORT_NUMBER_001", DIFFUSE		,default_diff			,FROM_PATHS};			  -- трехзначный бортовой номер. расположение - в центре корпуса на борту 
	{"mi_8_BORT_NUMBER_001",  ROUGHNESS_METALLIC		,"mi_8_tex_1_RoughMet"		,FROM_PATHS};		  --	 
	{"mi_8_BORT_NUMBER_001", DECAL			,"empty"				,FROM_PATHS};	 --

	{"mi_8_BORT_NUMBER_010", DIFFUSE		,default_diff			,FROM_PATHS};			 --  
	{"mi_8_BORT_NUMBER_010",  ROUGHNESS_METALLIC		,"mi_8_tex_1_RoughMet"		,FROM_PATHS};		  --	 
	{"mi_8_BORT_NUMBER_010", DECAL			,"mi_8_bort_number yel"	,false};	 --

	{"mi_8_BORT_NUMBER_100", DIFFUSE		,default_diff			,FROM_PATHS};			  --  
	{"mi_8_BORT_NUMBER_100",  ROUGHNESS_METALLIC		,"mi_8_tex_1_RoughMet"		,FROM_PATHS};		  --	 
	{"mi_8_BORT_NUMBER_100", DECAL			,"mi_8_bort_number yel"	,false};	 --					 

	{"mi_8_BALKA_2_1_NUMBER_001", DIFFUSE	,default_diff			,FROM_PATHS};		 -- трехзначный бортовой номер. расположение - у корня хвостовой балки	  
	{"mi_8_BALKA_2_1_NUMBER_001",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"		,FROM_PATHS};	 --		  
	{"mi_8_BALKA_2_1_NUMBER_001", DECAL		,"empty"				,FROM_PATHS};		   --

	{"mi_8_BALKA_2_1_NUMBER_010", DIFFUSE	,default_diff			,FROM_PATHS};		 --	   
	{"mi_8_BALKA_2_1_NUMBER_010",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"		,FROM_PATHS};	 --		  
	{"mi_8_BALKA_2_1_NUMBER_010", DECAL		,"empty"				,FROM_PATHS};		   --

	{"mi_8_BALKA_2_1_NUMBER_100", DIFFUSE	,default_diff			,FROM_PATHS};	  --	   
	{"mi_8_BALKA_2_1_NUMBER_100",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"		,FROM_PATHS};	 --		  
	{"mi_8_BALKA_2_1_NUMBER_100", DECAL		,"empty"				,FROM_PATHS};		   --

	{"mi_8_BALKA_1_1_NUMBER_001", DIFFUSE	,default_diff			,FROM_PATHS};		  -- трехзначный бортовой номер. расположение - на хвостовой балке с левой стороны		
	{"mi_8_BALKA_1_1_NUMBER_001",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"		,FROM_PATHS};	 --		  
	{"mi_8_BALKA_1_1_NUMBER_001", DECAL		,"empty"				,FROM_PATHS};		   --

	{"mi_8_BALKA_1_1_NUMBER_010", DIFFUSE	,default_diff			,FROM_PATHS};		 --	   
	{"mi_8_BALKA_1_1_NUMBER_010",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"		,FROM_PATHS};	 --		  
	{"mi_8_BALKA_1_1_NUMBER_010", DECAL		,"empty"				,FROM_PATHS};		   --

	{"mi_8_BALKA_1_1_NUMBER_100", DIFFUSE	,default_diff			,FROM_PATHS};		 --	   
	{"mi_8_BALKA_1_1_NUMBER_100",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"		,FROM_PATHS};	 --		  
	{"mi_8_BALKA_1_1_NUMBER_100", DECAL		,"empty"				,FROM_PATHS};		   --

	{"mi_8_BALKA_1_2_NUMBER_001", DIFFUSE	,default_diff			,FROM_PATHS};		-- трехзначный бортовой номер. расположение - на хвостовой балке с правой стороны			  
	{"mi_8_BALKA_1_2_NUMBER_001",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"		,FROM_PATHS};	 --		  
	{"mi_8_BALKA_1_2_NUMBER_001", DECAL		,"empty"				,FROM_PATHS};		   --

	{"mi_8_BALKA_1_2_NUMBER_010", DIFFUSE	,default_diff			,FROM_PATHS};	   --	  
	{"mi_8_BALKA_1_2_NUMBER_010",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"		,FROM_PATHS};	 --		  
	{"mi_8_BALKA_1_2_NUMBER_010", DECAL		,"empty"				,FROM_PATHS};		   --

	{"mi_8_BALKA_1_2_NUMBER_100", DIFFUSE	,default_diff			,FROM_PATHS};		  --	  
	{"mi_8_BALKA_1_2_NUMBER_100",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"		,FROM_PATHS};	 --		  
	{"mi_8_BALKA_1_2_NUMBER_100", DECAL		,"empty"				,FROM_PATHS};		   --

	{"mi_8_BALKA_1_3_NUMBER_001", DIFFUSE		,default_diff		,FROM_PATHS};		  -- дополнительный трехзначный бортовой номер. расположение - по середине хвостовой балке с правой стороны			  
	{"mi_8_BALKA_1_3_NUMBER_001",  ROUGHNESS_METALLIC		,"mi_8_tex_2_RoughMet"	,FROM_PATHS};	 --		  
	{"mi_8_BALKA_1_3_NUMBER_001", DECAL			,"empty"			,FROM_PATHS};		   --

	{"mi_8_BALKA_1_3_NUMBER_010", DIFFUSE		,default_diff		,FROM_PATHS};	--	   
	{"mi_8_BALKA_1_3_NUMBER_010",  ROUGHNESS_METALLIC		,"mi_8_tex_2_RoughMet"	,FROM_PATHS};	 --		  
	{"mi_8_BALKA_1_3_NUMBER_010", DECAL			,"empty"			,FROM_PATHS};		   --

	{"mi_8_BALKA_1_3_NUMBER_100", DIFFUSE		,default_diff		,FROM_PATHS};		 --	   
	{"mi_8_BALKA_1_3_NUMBER_100",  ROUGHNESS_METALLIC		,"mi_8_tex_2_RoughMet"	,FROM_PATHS};	 --		  
	{"mi_8_BALKA_1_3_NUMBER_100", DECAL			,"empty"			,FROM_PATHS};		   -- 

	{"mi_8_SMALL_BALKA_NUMBER_001", DIFFUSE		,default_diff		,FROM_PATHS};		--  место под трехзначный регистрационный номер. расположение - на хвостовой балке перед горизонтальным оперением			  
	{"mi_8_SMALL_BALKA_NUMBER_001",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"	,FROM_PATHS};	 --		  
	{"mi_8_SMALL_BALKA_NUMBER_001", DECAL		,"number black reg"	,false};		   --

	{"mi_8_SMALL_BALKA_NUMBER_010", DIFFUSE		,default_diff		,FROM_PATHS};	  --	  
	{"mi_8_SMALL_BALKA_NUMBER_010",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"	,FROM_PATHS};	 --		  
	{"mi_8_SMALL_BALKA_NUMBER_010", DECAL		,"number black reg"	,false};		   --

	{"mi_8_SMALL_BALKA_NUMBER_100", DIFFUSE		,default_diff		,FROM_PATHS};		  --	  
	{"mi_8_SMALL_BALKA_NUMBER_100",  ROUGHNESS_METALLIC	,"mi_8_tex_2_RoughMet"	,FROM_PATHS};	 --		  
	{"mi_8_SMALL_BALKA_NUMBER_100", DECAL		,"number black reg"	,false};		   --
}

name 		= "placeholder"
name_ru		= "placeholder"
countries	= {"XXX"}

-- custom_args = 
-- {
-- [457] = DIFFUSE.DIFFUSE, -- EVU on
-- }

