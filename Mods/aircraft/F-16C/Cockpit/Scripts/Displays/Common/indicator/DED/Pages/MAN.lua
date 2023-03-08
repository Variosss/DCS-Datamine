
addText("MAN Label",		    "MAN",					{10, 0})
addText("MAN STPT Num",		    "XX",					{20, 0}, nil, nil, {{"DED_CNI_WPT_Num"}})
addText("MAN IncDecSymbol",     "a",					{23, 0})

addText("WSPAN Label",	        "WSPAN",	            {6, 1})
addText("WSPAN DATA",	        "",	                    {13, 1}, nil, nil, {{"DED_MAN_Wingspan"}})
addAsteriscs("WSPAN Asteriscs",                         {12, 1}, 5)

addText("MBAL Label",		    "MBAL",					{10, 2})

addText("RNG Label",		    "RNG",					{8, 3})
addText("RNG Data",		        "",		        		{11, 3}, nil, nil, {{"DED_MAN_Range"}})
addText("RNG FT",		        "FT",				    {18, 3})

addText("TOF Label",		    "TOF",					{8, 4})
addText("TOF Data",		        "",			        	{11, 4}, nil, nil, {{"DED_MAN_TOF"}})
addText("TOF SEC",		        "SEC",				    {17, 4})