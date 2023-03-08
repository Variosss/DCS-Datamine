impostors = 
{
	presets = 
	{
		small = {
			maxSize = 16, -- the size of model when imposter will be appear. Размер диагонали баундинг бокса модели в пикселях, на котором включается импостер.
			minSize = 4.0, -- the minimum size of imposter. Then it remains constant but decreasing in transparency. Минимальный размер импостера до которого он уменьшается. Далее остается постоянным, но уменьшается в прозрачности.
			alphaExp = 0.20, -- Alpha channel (transparency) factor. Smaller digits - less transparency by range. Корректировка альфа канала (прозрачности). Экспонента. Чем меньше тем дальше видно.
		},	
		medium = {
			maxSize = 16,
			minSize = 8.0, 
			alphaExp = 0.15,
		},	
		large = {
			maxSize = 16,
			minSize = 10.0, 
			alphaExp = 0.10,
		},	
	}
};
