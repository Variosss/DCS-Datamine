viewConsumer = "cigiServer.dll";

-- Options
Cameras =
{
	LeftCamera = {0.7, 0.0, 0.0},
	CenterCamera = {0.0, 0.0, 0.0},
	RightCamera = {-0.7, 0.0, 0.0},
}

InitialRotationZ = 0.0

-- Log File Name
-- log="cigi.log";

-- Server session setup
cigiServer =
{
	{
		RenderIP = "172.16.1.255";
		PortH2IG = 8011;
		PortIG2H = 8010;
		ModelID = 0;
		DatabaseID=2;--2-Nevada
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
		ModelName="OPB_Camera";
		EtityType=103;
	},
	-- летательные аппараты
	{
		ModelName="MI-8MT";
		EtityType=201;
	},
	{
		ModelName="mi-8mt_hum";
		EtityType=251;
	},
	{
		ModelName="ka-50_hum";
		EtityType=252;
	},
	{
		ModelName="MI-24W";
		EtityType=202;
	},
	{
		ModelName="KA-50";
		EtityType=203;
	},
	{
		ModelName="SU-25";
		EtityType=204;
	},
	{
		ModelName="C-130";
		EtityType=205;
	},
	{
		ModelName="F-15";
		EtityType=206;
	},
	{
		ModelName="MIG-23";
		EtityType=207;
	},
	{
		ModelName="MIG-29";
		EtityType=208;
	},
	{
		ModelName="SU-27";
		EtityType=209;
	},
	{
		ModelName="SU-30";
		EtityType=210;
	},
	
	-- наземная техника
	{
		ModelName="bmp-2";
		EtityType=301;
	},
	{
		ModelName="BTR-80";
		EtityType=302;
	},
	{
		ModelName="M48";
		EtityType=303;
	},
	{
		ModelName="hawk-rls";
		EtityType=304;
	},
	{
		ModelName="hawk-pu";
		EtityType=305;
	},
	{
		ModelName="VULCAN";
		EtityType=306;
	},
	{
		ModelName="hawk-upr";
		EtityType=307;
	},
	{
		ModelName="m-1";
		EtityType=308;
	},
	{
		ModelName="t-72";
		EtityType=309;
	},
	{
		ModelName="mt-lb";
		EtityType=310;
	},
	{
		ModelName="bm-21-40";
		EtityType=311;
	},
	{
		ModelName="HMMWV_M1025";
		EtityType=312;
	},
	{
		ModelName="ZIL_KUNG";
		EtityType=313;
	},
	{
		ModelName="t-80ud";
		EtityType=314;
	},
	{
		ModelName="Sborka";
		EtityType=315;
	},

	--подвески
	-- Бомбы
	{--411 FAB-250-N1
		ModelName="FAB-250-N1";
		EtityType=411;
	},
	{--412 FAB-500-N3
		ModelName="FAB-500-N3";
		EtityType=412;
	},
	{--413 KMGU-2
		ModelName="KMGU-2";
		EtityType=413;
	},
	
	--пулеметы
	{
		ModelName="UB-32M1";
		EtityType=451;
	},
	{
		ModelName="UPK-23-250";
		EtityType=452;
	},
	{
		ModelName="B-8V20A";
		EtityType=453;
	},
	{
		ModelName="B-20";
		EtityType=454;
	},
	{
		ModelName="UB-13";
		EtityType=455;
	},
	
	-- Чистокровные статики
	{
		ModelName="GENERATORF";
		EtityType=501;
	},
	{
		ModelName="TR_BUDKA";
		EtityType=502;
	},
	{
		ModelName="A50-OBLOMOK-WING-R";
		EtityType=503;
	},
	
	
--Объекты для которых не требуется высокая точность позиционирования
-- эффекты
	{
		EffectName="MissleTrail";
		EtityType=10108;
	},
	{
		EffectName="MissleExplosion";
		EtityType=10109;
	},
	{
		EffectName="HeliDust";
		EtityType=10110;
	},
	
	-- оружие
	-- НУРСы
	{--10401 c-5
		ModelName="c-5";
		EtityType=10401;
	},
	{--10402 c-8
		ModelName="c-8";
		EtityType=10402;
	},
	{--10403 S-8_OFP2
		ModelName="S-8_OFP2";
		EtityType=10403;
	},
	{--10404 9M114
		ModelName="9M114";
		EtityType=10404;
	},
	
	-- Пули
	{--10421 tracer_bullet_red
		ModelName="tracer_bullet_red";
		EtityType=10421;
	},
	{--10422 tracer_bullet_yellow
		ModelName="tracer_bullet_yellow";
		EtityType=10422;
	},
	{--10423 tracer_bullet_green
		ModelName="tracer_bullet_green";
		EtityType=10423;
	},
	{--10424 tracer_bullet_white
		ModelName="tracer_bullet_white";
		EtityType=10424;
	}
}