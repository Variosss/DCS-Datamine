-- All arguments animation

local period = 10;

local z = 0.05 * period  -- stick to border at this time 
local t =   {  
        {0, 	  					 -1},
		{z, 	     				 -1},
        {period/4 - 0.5 * z, 		  0},
        {period/4 + 0.5 * z, 		  0},
		{period/2 - 0.5 * z, 		  1}, 
		{period/2 + 0.5 * z, 		  1}, 
		{3 * period/4 - 0.5 * z, 	  0},
        {3 * period/4 + 0.5 * z, 	  0},
		{period - z			   , 	 -1},
        {period,     				 -1},
};

animation = {};
for i = 0, 10000 do
    animation[i] = t;
end;
