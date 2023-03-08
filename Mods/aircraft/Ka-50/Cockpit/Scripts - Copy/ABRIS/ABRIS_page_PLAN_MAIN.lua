dofile(LockOn_Options.script_path.."ABRIS\\ABRIS_usefull_definitions.lua")
AddButtons("ВЫБОР","РИСОВ","","АКТ","МЕНЮ")




RewriteDefaultLevel()
AddContextBlock(LOCALIZE("ЗАГР").."\n"..LOCALIZE("ЗАПИСЬ").."\n"..LOCALIZE("ОЧИСТ").."\n"..LOCALIZE("ВОЗВРАТ").."\n"..LOCALIZE("УДАЛИТЬ").."\n"..LOCALIZE("ИНВЕРТ").."\n"..LOCALIZE("СЛМ").."\n"..LOCALIZE("ДОП.ИНФ"))
	 --[[   plan.menu   << ABRIS_PLAN_LOAD
				<< ABRIS_PLAN_SAVE
				<< ABRIS_PLAN_CLEAN
				<< ABRIS_PLAN_RETURN
				<< ABRIS_PLAN_REMOVE
				<< ABRIS_PLAN_INVERT
				<< ABRIS_PLAN_AUTO
				<< ABRIS_PLAN_ADDITIONALINFO;--]]