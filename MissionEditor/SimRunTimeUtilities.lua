if not me_db then
	OptionsData = require('Options.Data')
	OptionsData.load({})

	me_db = require('me_db_api')
	me_db.create() -- чтение и обработка БД редактора

	-- база данных по плагинам загружается в me_db_api
	-- после ее загрузки можно загрузить настройки для плагинов
	OptionsData.loadPluginsDb()
end

local map_classifier = require('me_map_classifier')


map_classifier_data  = map_classifier.get()
getFromClassifier 	 = map_classifier.getFromClassifier
getUnitIconByType 	 = map_classifier.getUnitIconByType
