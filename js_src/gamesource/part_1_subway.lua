-- ’
-- – 
-- «»
-- «Сайямура медикалз» => «Sayamura Medicals»
-- «Кэитаро Кредит» => «Keitaro Credit»
-- «Фуджитсу Электроник» => «Fujitsu Electronic»

-- «Масао Инкорпорэйтед» 3     => Киба Девайсез
-- «Кавасаки Нанотехнолоджи» 2 => Кавасаки Нано ХайТех? Пока оставлю Kawasaki Nanotechnology
-- «Такемия Индастриалз» 1     => Хоу Диан Бу Инкорпорейтед => готовность к сильному толчку

-- Junkies stuff -- против азиатов
-- Такамори инжинириг -- в честь сацумского повстания

-- gamefile(путь, true); true -- загрузить как новую игру вообще

-- ----------------------------------------------------------------------

subway = obj
{
    nam = 'метро',
    _sunrise = false,
    _to_moles = true,
    _clear_water = false,
    _renascence = false,
--    _snake_know = false,
    dsc = nil,
};


subway_station_chooser = dlg
{
    nam = 'Подземка',
    hideinv = true,
    pic = 'images/subway_map.png',
    enter = function (s)
        if subway._clear_water then
            pon ('clear_water');
        end
        if subway._renascence then
            pon ('renascence');
        end
    end,
    dsc = function (s)
        p 'Мне необходимо было выбрать, куда я хотел бы отправиться.';
        return;
    end,
    phr =
    {

        {
            -- 1,
            always = true,
            'Станция «Доблесть и Слава»',
            nil,
            [[
            walk (subway_valor_platform);
            return;
            ]]
        };
        {
            -- 2,
            always = true,
            'Станция «Рассвет»',
            nil,
            [[
            if subway._to_moles then
                subway._to_moles = false;
                walk (subway_dream_1);
            else
                walk (subway_sunrise_platform);
            end
            return;
            ]]
        };
        {
            -- 3,
            tag = 'clear_water',
            false,
            always = true,
            'Станция «Чистая Вода» (Кроты)',
            nil,
            [[
            walk (subway_clear_water_platform);
            return;
            ]]
        };
        {
            -- 4,
            tag = 'renascence',
            false,
            always = true,
            'Станция «Возрождение»',
            nil,
            [[
            walk (subway_renascence_platform);
            return;
            ]]
        };
        {
            -- 20,
            always = true,
            'Отмена',
            nil,
            [[ back ();]]
        };
    }
};
