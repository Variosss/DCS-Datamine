-- viewConsumer = "cigiServer.dll";

-- Coord math mode (utm,geo)
coord="utm";

-- Log File Name
-- log="cigi.log";

-- Server session setup
cigiServer =
{
	{
		RenderIP = "172.16.1.59";
		PortH2IG = 7011;
		PortIG2H = 7010;
	}
}

-- Entity map
EntityMap =
{
	{
		ModelName="Camera";
		EtityType=102;
	},
	{
		ModelName="A-10C";
		EtityType=103;
	},
	{
		ModelName="MI-24W";
		EtityType=104;
	},
	{
		ModelName="C-130";
		EtityType=105;
	},
	{
		ModelName="MK-84";
		EtityType=106;
	},
	{
		ModelName="hydra_m151he";
		EtityType=107;
	},
	{
		EffectName="MissleTrail";
		EtityType=108;
	},
	{
		EffectName="MissleExplosion";
		EtityType=109;
	}
}
