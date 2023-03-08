dofile(LockOn_Options.common_script_path.."elements_defs.lua")
local mask_material_glass = MakeMaterial(nil,{255,51,204,30}) -- magenta
local GLASS_LEVEL  	  = 8 


glass 				  = CreateElement "ceMeshPoly" -- untextured shape
glass.name 			  = "glass"
glass.material		  = mask_material_glass
glass.controllers     = {{"set_origin_to_cockpit_shape"}}  -- as geometry exported from max is better to render with same origin as cockpit shape
glass.h_clip_relation = h_clip_relations.REWRITE_LEVEL  -- this will clear stencil on rendered area with GLASS LEVEL  
glass.level			  = GLASS_LEVEL
glass.collimated	  = false  -- glass is hardware part of indicator
glass.isvisible		  = true  -- by default glass is not visible and rendered only to stencil buffer

--vertices and indices exported from 3d max 
glass.vertices		=  {{-0.0775,   0.0554    , 0.6274,	};
						{-0.0523,   0.0662    , 0.6179,	};
						{-0.0266,   0.0726    , 0.6123,	};
						{-0.0007,   0.0746    , 0.6102,	};
						{0.0253 ,   0.0724    , 0.6125,	} ;
						{0.0512 ,   0.0660    , 0.6181,	} ;
						{0.0768 ,   0.0554    , 0.6274,	} ;
						{0.0799 ,   -0.0343   , 0.7054,	} ;
						{-0.0806,   -0.0343   , 0.7054,	};
						{0.0641 ,   0.0614    , 0.6220,	} ;
						{0.0386 ,   0.0698    , 0.6146,	} ;
						{0.0134 ,   0.0741    , 0.6108,	} ;
						{-0.0143,   0.0742    , 0.6107,	};
						{-0.0396,   0.0700    , 0.6143,	};
						{-0.0667,   0.0608    , 0.6225,	};
						{-0.0737,   0.0575    , 0.5347,	};
						{-0.0499,   0.0683    , 0.5252,	};
						{-0.0256,   0.0747    , 0.5196,	};
						{-0.0011,   0.0767    , 0.5177,	};
						{0.0235 ,   0.0745    , 0.5197,	} ;
						{0.0479 ,   0.0681    , 0.5254,	} ;
						{0.0721 ,   0.0575    , 0.5347,	} ;
						{0.0779 ,   -0.1313   , 0.6971,	} ;
						{-0.0795,   -0.1313   , 0.6971,	};
						{0.0601 ,   0.0631    , 0.5294,	} ;
						{0.0357 ,   0.0717    , 0.5219,	} ;
						{0.0108 ,   0.0760    , 0.5181,	} ;
						{-0.0138,   0.0761    , 0.5180,	};
						{-0.0387,   0.0717    , 0.5219,	};
						{-0.0633,   0.0626    , 0.5299,	}}				
glass.indices	= 	{	 7 , 8 ,  0 ;
						 6 , 7 ,  0 ;
						 9 , 6 ,  0 ;
						13 , 0 ,  1 ;
						13 , 5 ,  0 ;
						 4 ,13 ,  2 ;
						11 , 4 ,  2 ;
						 5 , 9 ,  0 ;
						 4 ,10 ,  5 ;
						 3 ,11 , 12 ;
						12 ,11 ,  2 ;
						 4 , 5 , 13 ;
						 1 , 0 , 14 ;
						22 ,23 , 15 ;
						21 ,22 , 15 ;
						24 ,21 , 15 ;
						25 ,20 , 16 ;
						16 ,20 , 15 ;
						19 ,28 , 17 ;
						26 ,19 , 17 ;
						20 ,24 , 15 ;
						28 ,25 , 16 ;
						18 ,26 , 27 ;
						27 ,26 , 17 ;
						19 ,25 , 28 ;
						16 ,15 , 29 }
--Add(glass)
