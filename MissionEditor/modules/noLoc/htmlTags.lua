htmlTags =
{
	["&nbsp;"] 		= 	{0xc2, 0xa0},   --&#160; 	  	неразрывный пробел
	["&iexcl;"] 	= 	{0xc2, 0xa1},	--&#161; 	? 	перевернутый восклицательный знак
	["&cent;"] 		= 	{0xc2, 0xa2},	--&#162; 	? 	цент
	["&pound;"] 	= 	{0xc2, 0xa3}, 	--&#163; 	? 	фунт стерлингов
--	&#8364; 	€ 	валюта евро
	["&curren;"] 	= 	{0xc2, 0xa4}, 	--&#164; 	¤ 	денежная единица
	["&yen;"] 		= 	{0xc2, 0xa5}, 	--&#165; 	? 	иена или юань
	["&brvbar;"] 	=	{0xc2, 0xa6},	--&#166; 	¦ 	разорванная вертикальная черта
	["&sect;"] 		= 	{0xc2, 0xa7},	 	--&#167; 	§ 	параграф
	["&uml;"] 		= 	{0xc2, 0xa8},	 	--&#168; 	? 	трема (знак над гласной для произнесения ее отдельно от предшествующей гласной
	["&copy;"] 		= 	{0xc2, 0xa9}, 	--&#169; 	© 	знак copyright
	["&ordf;"] 		= 	{0xc2, 0xaa}, 	--&#170; 	? 	feminine ordinal indicator
	["&not;"] 		= 	{0xc2, 0xac}, 	--&#172; 	¬ 	знак отрицания
	["&shy;"] 		= 	{0xc2, 0xad}, 	--&#173; 	­ 	место возможного переноса
	["&trade;"] 	= 	{0xc2, 0x99},	--&#153; 	™ 	торговая марка
	["&reg;"] 		= 	{0xc2, 0xae}, 	-- 	&#174; 	® 	знак зарегистрированной торговой марки
	["&macr;"] 		= 	{0xc2, 0xaf}, 	-- 	&#175; 	? 	знак долготы над гласным
	["&deg;"] 		= 	{0xc2, 0xb0}, 	-- 	&#176; 	° 	градус
	["&plusmn;"] 	= 	{0xc2, 0xb1}, 	-- 	&#177; 	± 	плюс-минус
	["&sup2;"] 		= 	{0xc2, 0xb2}, 	-- 	&#178; 	? 	верхний индекс "два" - "квадрат"
	["&sup3;"] 		= 	{0xc2, 0xb3}, 	-- 	&#179; 	? 	верхний индекс "три" - "куб"
	["&acute;"] 	= 	{0xc2, 0xb4}, 	-- 	&#180; 	? 	знак ударения
	["&micro;"] 	= 	{0xc2, 0xb5}, 	-- 	&#181; 	µ 	микро
	["&para;"] 		= 	{0xc2, 0xb6}, 	-- 	&#182; 	¶ 	символ параграфа
	["&middot;"] 	= 	{0xc2, 0xb7}, 	-- 	&#183; 	· 	точка
	["&cedil;"] 	= 	{0xc2, 0xb8}, 	-- 	&#184; 	? 	седиль (орфографический знак)
	["&sup1;"] 		= 	{0xc2, 0xb9}, 	-- 	&#185; 	? 	верхний индекс "один"
	["&ordm;"] 		= 	{0xc2, 0xba}, 	-- 	&#186; 	? 	masculine ordinal indicator
	["&laquo;"] 	= 	{0xc2, 0xab}, 	-- 	&#171; 	« 	левая двойная угловая скобка
	["&raquo;"] 	= 	{0xc2, 0xbb}, 	-- 	&#187; 	» 	правая двойная угловая скобка
	["&frac14;"] 	= 	{0xc2, 0xbc}, 	-- 	&#188; 	? 	дробь - одна четверть
	["&frac12;"] 	= 	{0xc2, 0xbd}, 	-- 	&#189; 	? 	дробь - одна вторая
	["&frac34;"] 	= 	{0xc2, 0xbe}, 	-- 	&#190; 	? 	дробь - три четверти
	["&iquest;"] 	= 	{0xc2, 0xbf}, 	-- 	&#191; 	? 	перевернутый вопросительный знак
--Латинский алфавит
	["&Agrave;"] 	= 	{0xc3, 0x80}, 	-- 	&#192; 	A 	латинская заглавная буква А с тупым ударением
	["&Aacute;"] 	= 	{0xc3, 0x81}, 	-- 	&#193; 	A 	латинская заглавная буква А с острым ударением
	["&Acirc;"] 	= 	{0xc3, 0x82}, 	-- 	&#194; 	A 	латинская заглавная буква А с циркумфлексом (диакритический знак над гласной)
	["&Atilde;"] 	= 	{0xc3, 0x83}, 	-- 	&#195; 	A 	латинская заглавная буква А с тильдой
	["&Auml;"] 		= 	{0xc3, 0x84}, 	-- 	&#196; 	A 	латинская заглавная буква А с тремой (знак над гласной для произнесения ее отдельно от предшествующей гласной)
	["&Aring;"] 	= 	{0xc3, 0x85}, 	-- 	&#197; 	A 	латинская заглавная буква А с верхним кружком
	["&AElig;"] 	= 	{0xc3, 0x86}, 	-- 	&#198; 	? 	латинские заглавные символы AE
	["&Ccedil;"] 	= 	{0xc3, 0x87}, 	-- 	&#199; 	C 	латинская заглавная буква C с седилем
	["&Egrave;"] 	= 	{0xc3, 0x88}, 	-- 	&#200; 	E 	латинская заглавная буква E с тупым ударением
	["&Eacute;"] 	= 	{0xc3, 0x89}, 	-- 	&#201; 	E 	латинская заглавная буква E с острым ударением
	["&Ecirc;"] 	= 	{0xc3, 0x8a}, 	-- 	&#202; 	E 	латинская заглавная буква E с циркумфлексом (диакритический знак над гласной)
	["&Euml;"] 		= 	{0xc3, 0x8b}, 	-- 	&#203; 	E 	латинская заглавная буква E с тремой
	["&Igrave;"] 	= 	{0xc3, 0x8c}, 	-- 	&#204; 	I 	латинская заглавная буква I с тупым ударением
	["&Iacute;"] 	= 	{0xc3, 0x8d}, 	-- 	&#205; 	I 	латинская заглавная буква I с острым ударением
	["&Icirc;"] 	= 	{0xc3, 0x8e}, 	-- 	&#206; 	I 	латинская заглавная буква I с циркумфлексом
	["&Iuml;"] 		= 	{0xc3, 0x8f},	-- 	&#207; 	I 	латинская заглавная буква I с тремой
	["&ETH;"] 		= 	{0xc3, 0x90}, 	-- 	&#208; 	? 	латинские заглавные символы ETH
	["&Ntilde;"] 	= 	{0xc3, 0x91}, 	-- 	&#209; 	N 	латинская заглавная буква N с тильдой
	["&Ograve;"] 	= 	{0xc3, 0x92}, 	-- 	&#210; 	O 	латинская заглавная буква O с тупым ударением
	["&Oacute;"] 	= 	{0xc3, 0x93}, 	-- 	&#211; 	O 	латинская заглавная буква O с острым ударением
	["&Ocirc;"] 	= 	{0xc3, 0x94}, 	-- 	&#212; 	O 	латинская заглавная буква O с циркумфлексом
	["&Otilde;"] 	= 	{0xc3, 0x95}, 	-- 	&#213; 	O 	латинская заглавная буква O с тильдой
	["&Ouml;"] 		= 	{0xc3, 0x96}, 	-- 	&#214; 	O 	латинская заглавная буква O с тремой
	["&Oslash;"] 	= 	{0xc3, 0x98}, 	-- 	&#216; 	O 	латинская заглавная буква O со штрихом
	["&Ugrave;"] 	= 	{0xc3, 0x99}, 	-- 	&#217; 	U 	латинская заглавная буква U с тупым ударением
	["&Uacute;"] 	= 	{0xc3, 0x9a}, 	-- 	&#218; 	U 	латинская заглавная буква U с острым ударением
	["&Ucirc;"] 	= 	{0xc3, 0x9b}, 	-- 	&#219; 	U 	латинская заглавная буква U с циркумфлексом
	["&Uuml;"] 		= 	{0xc3, 0x9c}, 	-- 	&#220; 	U 	латинская заглавная буква U с тремой
	["&Yacute;"] 	= 	{0xc3, 0x9d}, 	-- 	&#221; 	Y 	латинская заглавная буква Y с острым ударением
	["&THORN;"] 	= 	{0xc3, 0x9e}, 	-- 	&#222; 	? 	латинская заглавная буква THORN
	--&#223; 	? 	latin small letter sharp s = ess-zed
	["&agrave;"] 	= 	{0xc3, 0xa0}, 	-- 	&#224; 	a 	латинская строчная буква А с тупым ударением
	["&aacute;"] 	= 	{0xc3, 0xa1},  	-- 	&#225; 	a 	латинская строчная буква a с острым ударением
	["&acirc;"] 	= 	{0xc3, 0xa2},  	-- 	&#226; 	a 	латинская строчная буква a с циркумфлексом
	["&atilde;"] 	= 	{0xc3, 0xa3},  	-- 	&#227; 	a 	латинская строчная буква a с тильдой
	["&auml;"] 		= 	{0xc3, 0xa4},  	-- 	&#228; 	a 	латинская строчная буква a с тремой
	["&aring;"] 	= 	{0xc3, 0xa5},  	-- 	&#229; 	a 	латинская строчная буква a с верхним кружком
	["&aelig;"] 	= 	{0xc3, 0xa6},  	-- 	&#230; 	? 	латинская строчные буквы ae
	["&ccedil;"] 	= 	{0xc3, 0xa7},  	-- 	&#231; 	c 	латинская строчная буква a с седилем
	["&egrave;"] 	= 	{0xc3, 0xa8},  	-- 	&#232; 	e 	латинская строчная буква e с тупым ударением
	["&eacute;"] 	= 	{0xc3, 0xa9},  	-- 	&#233; 	e 	латинская строчная буква e с острым ударением
	["&ecirc;"] 	= 	{0xc3, 0xaa},  	-- 	&#234; 	e 	латинская строчная буква e с циркумфлексом
	["&euml;"] 		= 	{0xc3, 0xab},  	-- 	&#235; 	e 	латинская строчная буква e с тремой
	["&igrave;"] 	= 	{0xc3, 0xac},  	-- 	&#236; 	i 	латинская строчная буква i с тупым ударением
	["&iacute;"] 	= 	{0xc3, 0xad},  	-- 	&#237; 	i 	латинская строчная буква i с острым ударением
	["&icirc;"] 	= 	{0xc3, 0xae},  	-- 	&#238; 	i 	латинская строчная буква i с циркумфлексом
	["&iuml;"] 		= 	{0xc3, 0xaf},  	-- 	&#239; 	i 	латинская строчная буква i с тремой
	["&eth;"] 		= 	{0xc3, 0xb0},  	-- 	&#240; 	? 	латинская строчные символы eth
	["&ntilde;"] 	= 	{0xc3, 0xb1}, 	-- 	&#241; 	n 	латинская строчная буква n с тильдой
	["&ograve;"] 	= 	{0xc3, 0xb2}, 	-- 	&#242; 	o 	латинская строчная буква o с тупым ударением
	["&oacute;"] 	= 	{0xc3, 0xb3}, 	-- 	&#243; 	o 	латинская строчная буква o с острым ударением
	["&ocirc;"] 	= 	{0xc3, 0xb4}, 	-- 	&#244; 	o 	латинская строчная буква o с циркумфлексом
	["&otilde;"] 	= 	{0xc3, 0xb5}, 	-- 	&#245; 	o 	латинская строчная буква 0 с тильдой
	["&ouml;"] 		= 	{0xc3, 0xb6}, 	-- 	&#246; 	o 	латинская строчная буква o с тремой
	["&oslash;"] 	= 	{0xc3, 0xb8}, 	-- 	&#248; 	o 	латинская строчная буква o со штрихом
	["&ugrave;"] 	= 	{0xc3, 0xb9}, 	-- 	&#249; 	u 	латинская строчная буква u с тупым ударением
	["&uacute;"] 	= 	{0xc3, 0xba}, 	-- 	&#250; 	u 	латинская строчная буква u с острым ударением
	["&ucirc;"] 	= 	{0xc3, 0xbb}, 	-- 	&#251; 	u 	латинская строчная буква u с циркумфлексом
	["&uuml;"] 		= 	{0xc3, 0xbc}, 	-- 	&#252; 	u 	латинская строчная буква u с тремой
	["&yacute;"] 	= 	{0xc3, 0xbd}, 	-- 	&#253; 	y 	латинская строчная буква y с острымударением
	["&thorn;"] 	= 	{0xc3, 0xbe}, 	-- 	&#254; 	? 	латинская строчная буква thorn
	["&yuml;"] 		= 	{0xc3, 0xbf}, 	-- 	&#255; 	y 	латинская строчная буква y с тремой
--	&#338; 	? 	латинская заглавная лигатура OE
--	&#339; 	? 	латинская строчная лигатура oe
--	&#352; 	S 	latin capital letter S with caron
--	&#353; 	s 	latin small letter s with caron
--	&#376; 	Y 	latin capital letter Y with diaeresis
--Греческий алфавит
	["&Alpha;"] 	= 	{0xce, 0x91},	-- 	&#913; 	? 	греческая заглавная буква альфа
	["&Beta;"] 		= 	{0xce, 0x92}, 	-- 	&#914; 	? 	греческая заглавная буква бета
	["&Gamma;"] 	= 	{0xce, 0x93}, 	-- 	&#915; 	? 	греческая заглавная буква гамма
	["&Delta;"] 	= 	{0xce, 0x94}, 	-- 	&#916; 	? 	греческая заглавная буква дельта
	["&Epsilon;"] 	= 	{0xce, 0x95},	-- 	&#917; 	? 	греческая заглавная буква эпсилон
	["&Zeta;"] 		= 	{0xce, 0x96}, 	-- 	&#918; 	? 	греческая заглавная буква дзета
	["&Eta;"] 		= 	{0xce, 0x97}, 	-- 	&#919; 	? 	греческая заглавная буква эта
	["&Theta;"] 	= 	{0xce, 0x98}, 	-- 	&#920; 	? 	греческая заглавная буква тета
	["&Iota;"] 		= 	{0xce, 0x99}, 	-- 	&#921; 	? 	греческая заглавная буква иота
	["&Kappa;"] 	= 	{0xce, 0x9a}, 	-- 	&#922; 	? 	греческая заглавная буква каппа
	["&Lambda;"] 	= 	{0xce, 0x9b}, 	-- 	&#923; 	? 	греческая заглавная буква лямбда
	["&Mu;"] 		= 	{0xce, 0x9c}, 	-- 	&#924; 	? 	греческая заглавная буква мю
	["&Nu;"] 		= 	{0xce, 0x9d}, 	-- 	&#925; 	? 	греческая заглавная буква ню
	["&Xi;"] 		= 	{0xce, 0x9e}, 	-- 	&#926; 	? 	греческая заглавная буква кси
	["&Omicron;"] 	= 	{0xce, 0x9f}, 	-- 	&#927; 	? 	греческая заглавная буква омикрон
	["&Pi;"] 		= 	{0xce, 0xa0}, 	-- 	&#928; 	? 	греческая заглавная буква пи
	["&Rho;"] 		= 	{0xce, 0xa1}, 	-- 	&#929; 	? 	греческая заглавная буква ро
	["&Sigma;"] 	= 	{0xce, 0xa3}, 	-- 	&#931; 	? 	греческая заглавная буква сигма
	["&Tau;"] 		= 	{0xce, 0xa4}, 	-- 	&#932; 	? 	греческая заглавная буква тау
	["&Upsilon;"] 	= 	{0xce, 0xa5}, 	-- 	&#933; 	? 	греческая заглавная буква ипсилон
	["&Phi;"] 		= 	{0xce, 0xa6}, 	-- 	&#934; 	? 	греческая заглавная буква фи
	["&Chi;"] 		= 	{0xce, 0xa7}, 	-- 	&#935; 	? 	греческая заглавная буква хи
	["&Psi;"] 		= 	{0xce, 0xa8}, 	-- 	&#936; 	? 	греческая заглавная буква пси
	["&Omega;"] 	= 	{0xce, 0xa9}, 	-- 	&#937; 	? 	греческая заглавная буква омега
	["&alpha;"] 	= 	{0xce, 0xb1}, 	-- 	&#945; 	? 	греческая строчная буква альфа
	["&beta;"] 		= 	{0xce, 0xb2}, 	-- 	&#946; 	? 	греческая строчная буква бета
	["&gamma;"] 	= 	{0xce, 0xb3}, 	-- 	&#947; 	? 	греческая строчная буква гамма
	["&delta;"] 	= 	{0xce, 0xb4}, 	-- 	&#948; 	? 	греческая строчная буква дельта
	["&epsilon;"] 	= 	{0xce, 0xb5}, 	-- 	&#949; 	? 	греческая строчная буква эпсилон
	["&zeta;"] 		= 	{0xce, 0xb6}, 	-- 	&#950; 	? 	греческая строчная буква дзета
	["&eta;"] 		= 	{0xce, 0xb7}, 	--	&#951; 	? 	греческая строчная буква эта
	["&theta;"] 	= 	{0xce, 0xb8}, 	-- 	&#952; 	? 	греческая строчная буква тета
	["&iota;"] 		= 	{0xce, 0xb9}, 	-- 	&#953; 	? 	греческая строчная буква иота
	["&kappa;"] 	= 	{0xce, 0xba}, 	-- 	&#954; 	? 	греческая строчная буква каппа
	["&lambda;"] 	= 	{0xce, 0xbb}, 	-- 	&#955; 	? 	греческая строчная буква лямбда
	["&mu;"] 		= 	{0xce, 0xbc}, 	-- 	&#956; 	? 	греческая строчная буква мю
	["&nu;"] 		= 	{0xce, 0xbd}, 	-- 	&#957; 	? 	греческая строчная буква ню
	["&xi;"] 		= 	{0xce, 0xbe}, 	-- 	&#958; 	? 	греческая строчная буква кси
	["&omicron;"] 	= 	{0xce, 0xbf}, 	-- 	&#959; 	? 	греческая строчная буква омикрон
	["&pi;"] 		= 	{0xcf, 0x80}, 	-- 	&#960; 	? 	греческая строчная буква пи
	["&rho;"] 		= 	{0xcf, 0x81}, 	-- 	&#961; 	? 	греческая строчная буква ро
	["&sigmaf;"] 	= 	{0xcf, 0x82}, 	-- 	&#962; 	? 	греческая строчная буква сигма (final)
	["&sigma;"] 	= 	{0xcf, 0x83}, 	-- 	&#963; 	? 	греческая строчная буква сигма
	["&tau;"] 		= 	{0xcf, 0x84}, 	-- 	&#964; 	? 	греческая строчная буква тау
	["&upsilon;"] 	= 	{0xcf, 0x85}, 	-- 	&#965; 	? 	греческая строчная буква ипсилон
--	&#966; 	? 	греческая строчная буква фи
	["&chi;"] 		= 	{0xcf, 0x87}, 	-- 	&#967; 	? 	греческая строчная буква хи
	["&psi;"] 		= 	{0xcf, 0x88}, 	-- 	&#968; 	? 	греческая строчная буква пси
	["&omega;"] 	= 	{0xcf, 0x89}, 	-- 	&#969; 	? 	греческая строчная буква омега
--Знаки пунктуации
	["&bull;"] 		= 	{0xe2, 0x80, 0xa2}, 	 -- 	&#8226; 	• 	bullet - маленький черный кружок
	["&hellip;"] 	= 	{0xe2, 0x80, 0xa6},  	-- 	&#8230; 	… 	многоточие ...
	["&prime;"] 	= 	{0xe2, 0x80, 0xb2}, 	-- 	&#8242; 	? 	одиночный штрих - минуты и футы
	["&Prime;"] 	= 	{0xe2, 0x80, 0xb3}, 	-- 	&#8243; 	? 	двойной штрих - секунды и дюймы
	["&oline;"] 	= 	{0xe2, 0x80, 0xbe}, 	-- 	&#8254; 	? 	надчеркивание
	["&frasl;"] 	= 	{0xe2, 0x81, 0x84}, 	-- 	&#8260; 	? 	косая дробная черта
	["&quot;"] 		= 	{0x22},	-- 	&#34; 	" 	двойная кавычка - APL quote
	["&ndash;"] 	= 	{0xe2, 0x80, 0x93}, 	-- 	&#8211; 	– 	тире
	["&mdash;"] 	= 	{0xe2, 0x80, 0x94}, 	-- 	&#8212; 	— 	длинное тире
	["&lsquo;"] 	= 	{0xe2, 0x80, 0x98}, 	-- 	&#8216; 	‘ 	левая одиночная кавычка
	["&rsquo;"] 	= 	{0xe2, 0x80, 0x99}, 	-- 	&#8217; 	’ 	правая одиночная кавычка
	["&sbquo;"] 	= 	{0xe2, 0x80, 0x9a}, 	-- 	&#8218; 	‚ 	нижняя одиночная кавычка
	["&ldquo;"] 	= 	{0xe2, 0x80, 0x9c}, 	-- 	&#8220; 	“ 	левая двойная кавычка
	["&rdquo;"] 	= 	{0xe2, 0x80, 0x9d}, 	-- 	&#8221; 	” 	правая двойная кавычка
	["&bdquo;"] 	= 	{0xe2, 0x80, 0x9e}, 	-- 	&#8222; 	„ 	нижняя двойная кавычка
--Стрелки
	["&larr;"] 		= 	{0xe2, 0x86, 0x90}, 	-- 	&#8592; 	< 	стрелка влево
	["&uarr;"] 		= 	{0xe2, 0x86, 0x91}, 	-- 	&#8593; 	^ 	стрелка вверх
	["&rarr;"] 		= 	{0xe2, 0x86, 0x92}, 	-- 	&#8594; 	> 	стрелка вправо
	["&darr;"] 		= 	{0xe2, 0x86, 0x93}, 	-- 	&#8595; 	v 	стрелка вниз
	["&harr;"] 		= 	{0xe2, 0x86, 0x94}, 	-- 	&#8596; 	- 	стрелка влево-вправо
--Математические операторы
	["&times;"] 	= 	{0xc3, 0x97}, 	-- 	&#215; 	? 	знак умножения
	["&divide;"] 	= 	{0xc3, 0xb7}, 	-- 	&#247; 	? 	знак деления
	["&fnof;"] 		= 	{0xc6, 0x92}, 	-- 	&#402; 	? 	знак функции
--	&#8706; 	? 	частный дифференциал
--	&#8719; 	? 	произведение последовательности - знак произведения
--	&#8721; 	? 	сумма последовательности
--	&#8722; 	? 	минус
--	&#8730; 	v 	квадратный корень
--	&#8734; 	? 	бесконечность
--	&#8745; 	? 	пересечение - cap
--	&#8747; 	? 	интеграл
--	&#8776; 	? 	почти равно - асимптотически стремится
--	&#8800; 	? 	не равно
--	&#8801; 	? 	тождественно
--	&#8804; 	? 	меньше либо равно
--	&#8805; 	? 	больше либо равно
	["&lt;"] 		= 	{0x3c},	 	-- 	&#60; 	< 	знак "меньше"
	["&gt;"] 		= 	{0x3e},	 	-- 	&#62; 	> 	знак "больше"
    ["&szlig;"] 	= 	{0xc3,0x9f},--  &#df    ß   
--Прочие символы
--	&#9674; 	? 	lozenge
	["&spades;"] 	= 	{0xe2, 0x99, 0xa0},  	-- 	&#9824; 	¦ 	черный знак масти "пики"
	["&clubs;"] 	= 	{0xe2, 0x99, 0xa3}, 	-- 	&#9827; 	¦ 	черный знак масти "трефы" - shamrock
	["&hearts;"] 	= 	{0xe2, 0x99, 0xa5},  	-- 	&#9829; 	¦ 	черный знак масти "червы" - valentine
	["&diams;"] 	= 	{0xe2, 0x99, 0xa6}, 	-- 	&#9830; 	¦ 	черный знак масти "бубны"
	["&amp;"] 		= 	{0x26},	 	-- 	&#38; 	& 	ampersand
	["&circ;"] 		= 	{0xcb, 0x86},	 	-- 	&#710; 	? 	символ циркумфлекса (диакритический знак над гласной)
	["&tilde;"] 	= 	{0xcb, 0x9c},	 	-- 	&#732; 	? 	small tilde
--	&#8204; 	? 	zero width non-joiner
--	&#8205; 	? 	zero width joiner
--	&#8224; 	† 	кинжал (крест)
--	&#8225; 	‡ 	двойной кинжал (крест)
--	&#8240; 	‰ 	промилле
--	&#8249; 	‹ 	левая угловая одиночная кавычка
--	&#8250; 	› 	правая угловая одиночная кавычка
}