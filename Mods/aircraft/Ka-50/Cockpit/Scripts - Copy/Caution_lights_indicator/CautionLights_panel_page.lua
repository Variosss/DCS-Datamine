dofile(LockOn_Options.common_script_path.."elements_defs.lua")
dofile(LockOn_Options.script_path.."Caution_lights_indicator/CautionLights_panel_localizer.lua")

SetScale(FOV)
function AddElement(object)
	--object.screenspace = ScreenType.SCREENSPACE_TRUE
    object.use_mipfilter = true
    Add(object)
end

function box(x,y)  
    local y = y or x
    return {{-x,y},{x,y},{x,-y},{-x,-y}}
end

local grid_size_x   =  2.0 / 10
local grid_size_y   =  0.3 * grid_size_x
local zero          = {x = -1 + grid_size_x * 0.5,
                       y =  1 - grid_size_y * 0.5}

dummy_base               = CreateElement "ceSimple"
AddElement(dummy_base)

--[[
box_center               = CreateElement "ceMeshPoly"
box_center.primitivetype = "lines"
box_center.vertices      = box(1)
box_center.indices       = {0,1,1,2,2,3,3,0}
box_center.material      = "YELLOW_TRANSPARENT"
box_center.parent_element = dummy_base.name
AddElement(box_center)

box_center2               = CreateElement "ceMeshPoly"
box_center2.primitivetype = "triangles"
box_center2.vertices      = box(1,0.5)
box_center2.indices       = default_box_indices
box_center2.material      = "RED_TRANSPARENT"
box_center2.parent_element = dummy_base.name
AddElement(box_center2)
--]]

function add_caution_lamp(text,color,arg,grid_pos_x,grid_pos_y)     

    local base               = CreateElement "ceTexPoly"
          base.primitivetype = "triangles"
          base.vertices      = box(0.5 * (grid_size_x),0.5 * (grid_size_y))
          base.indices       = default_box_indices
          base.material      = "CAUTION_"..color
          base.init_pos      = {zero.x + (grid_pos_x - 1)* grid_size_x,
                                zero.y - (grid_pos_y - 1)* grid_size_y}							
          base.tex_coords    = {{0,0}, 
								{1,0},
								{1,1},
								{0,1}}                              
          base.controllers   = {{"draw_argument_in_range",arg,0,1.01}}
          base.parent_element = dummy_base.name
          AddElement(base)
	
    local fontk				  = 0.11 * grid_size_x 
    local txt                 = CreateElement "ceStringPoly"
          txt.material        = "font_CAUTION_"..color
          txt.alignment       = "CenterCenter"
          txt.stringdefs      = {fontk,fontk,0,0}
          txt.value           = text
          txt.parent_element  = base.name
          txt.additive_alpha  = true;
          AddElement(txt)                            
end




lamps = {
--=================================================
-- upper panel left group
{170,"НРВ\nСТАБ","GREEN"         ,{1,2}},
{175,"ВИСЕНИЕ","GREEN"           ,{1,3}},
{172,"СНИЖЕНИЕ","GREEN"          ,{1,4}},
{165,"МАРШРУТ\nЗК","GREEN"       ,{2,1}},
{171,"МАРШРУТ\nЛЗП","GREEN"      ,{2,2}},
{176,"ППМ\nРАЗВОРОТ","GREEN"     ,{2,3}},
{166,"КОНЕЦ\nМАРШРУТА","GREEN"   ,{2,4}},
{164,"СЧИСЛЕН\nГРУБОЕ","GREEN"   ,{3,1}},
{178,"ВЗРЫВ","RED"               ,{3,2}},
{173,"ППУ","GREEN"               ,{3,3}},
{177,"<ППУ>","GREEN"             ,{3,4}},
{211,"КОЛЬЦЕВ\nОТКРЫТО","GREEN"  ,{4,1}},
{187,"МУФТ\nОТКЛ","GREEN"        ,{4,2}},
{204,"Р МАСЛА\nПРИВОДОВ","GREEN" ,{4,3}},
{213,"ЗАМОК\nОТКРЫТ","GREEN"     ,{4,4}},
--=================================================
-- upper panel right group
{167,"БОЕВАЯ\nСЕТЬ ВКЛ","GREEN"  ,{5,1}},
{180,"ТРЕНАЖ","GREEN"            ,{5,2}},
{179,"ОБЗОР","YELLOW"            ,{5,3}},
{188,"РАНЕТ","YELLOW"            ,{5,4}},
{189,"К-ЦВМ","YELLOW"            ,{6,1}},
{206,"ЦВС","YELLOW"              ,{6,2}},
{212,"ПРЕОБРАЗ","GREEN"          ,{6,3}},
{205,"И-251В","YELLOW"           ,{6,4}},
{181,"ПОС ЛЕВ\nДВИГ","GREEN"     ,{7,1}},
{190,"ПЗУ ЛЕВ\nДВИГ","GREEN"     ,{7,2}},
{207,"ОГРАН РЕЖ\nЛЕВ","YELLOW"   ,{7,3}},
{183,"ПОС\nВИНТ","GREEN"         ,{7,4}},
{182,"ПОС ПРАВ\nДВИГ","GREEN"    ,{8,1}},
{191,"ПЗУ ПРАВ\nДВИГ","GREEN"    ,{8,2}},
{208,"ОГРАН РЕЖ\nПРАВ","YELLOW"  ,{8,3}},
{184,"ОБОГРЕВ\nВУО","GREEN"      ,{8,4}},
{200,"БАК\nПЕРЕДНИЙ","GREEN"     ,{9,1}},
{209,"КРАН ЛЕВ\nЗАКРЫТ","YELLOW" ,{9,2}},
{185,"БАК ЛЕВ\nВНЕШН","GREEN"    ,{9,3}},
{202,"БАК ЛЕВ\nВНУТР","GREEN"    ,{9,4}},
{201,"БАК\nЗАДНИЙ","GREEN"       ,{10,1}},
{210,"КРАН ПРАВ\nЗАКРЫТ","YELLOW",{10,2}},
{186,"БАК ПРАВ\nВНЕШН","GREEN"   ,{10,3}},
{203,"БАК ПРАВ\nВНУТР","GREEN"   ,{10,4}},
}


for i=1,#lamps do   
    local lmp = lamps[i]
    add_caution_lamp(LOCALIZE(lmp[2]),lmp[3],lmp[1],lmp[4][1],lmp[4][2]) 
end
