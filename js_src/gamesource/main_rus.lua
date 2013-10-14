require 'object'
require 'para'
require 'xact'
require 'dash'
--require 'parser'
require 'theme'
require 'proxymenu'
require 'hideinv'
--require 'dbg'

dofile ('menu_actions.lua');
dofile ('part_1_chapter_1.lua');
--dofile ('part_1_chapter_2.lua');
--dofile ('part_1_chapter_3.lua');
--dofile ('part_1_chapter_4.lua');
dofile ('part_1_subway.lua');
dofile ('part_1_mplayer.lua');
dofile ('terminal.lua');
dofile ('part_1_terminals.lua');
dofile ('utils.lua');

--dofile ('part_z.lua');

game.codepage="UTF-8"

--game.dsc = [[Команды:^
--    look(или просто ввод), act <на что> (или просто на что), use <что> [на что], go <куда>,^
--    back, inv, way, obj, quit, save <fname>, load <fname>. Работает автодополнение по табуляции.^^]];


temp_END = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/title.png',
    enter = function (s)
--        set_music ('music/vvb_-_runaway_from_troubles.ogg');
    end,
    dsc = function (s)
        p [[Поздравляю!^^
        Вы прошли первую главу игры.
        Какие приключения ждут главного героя и чем закончится
        история — всё это в следующих частях игры.^^
        Следите за обновлениями!
        ]];
    end,
};




main = room
{
    nam = '«Резервная копия»',
    pic = 'images/title.png',
--    enter = function (s)
--        set_music('music/vvb_-_careless_childhood.ogg');
--    end,
    dsc = function (s)
        p [[Сюжет, музыка, графика: Вадим В. Балашов^
        Рисунки сделаны на основе фотографий из открытых источников.^
        Версия 0.3 alpha (06.09.2012).^
        Отзывы направляйте по адресу vvb.backup@rambler.ru^^
        Специально для флэш-версии игры музыка перекодирована с
        низким битрейтом. Для более качественного звучания необходимо
        играть в INSTEAD-версию игры.
        ]];
        return;
    end,
    obj =
    {
        --vway('1', '{Об авторах}^', 'about'),
        vway('2', '{Инструкция}^', 'ins01'),
        vway('3', '{Благодарности}^^', 'gratitudes'),
        vway('4', '{НАЧАТЬ ИГРУ}', 'intro_1')
    },
};


ins01 = room
{
    nam = 'Инструкция',
--    pic = 'images/instructions.png',
--    enter = function (s)
--        set_music('music/instructions.ogg');
--    end,
    dsc = function (s)
        local v = txtc(txtu(txtb('Действия игрока:')))..txtb('^ОСМОТРЕТЬ')..[[ — позволяет осмотреть предметы вокруг (кроме тех, что с собой).]]..txtb('^С СОБОЙ')..[[ — позволяет осмотреть предметы, которые у Вас с собой.]]..txtb('^ВЗЯТЬ')..[[ — если это возможно, герой возьмёт указанный предмет.]]..txtb('^БРОСИТЬ')..[[ — лишние предметы можно оставить.]]..txtb('^ИСПОЛЬЗОВАТЬ')..[[ — для достижения цели игры герою придётся работать с окружающими его объектами. Для этого Вы должны указать КАКИМ (первый клик) предметом нужно действовать на КАКОЙ (второй клик) предмет. Чтобы использовать объект сам по себе, его нужно выбрать ДВАЖДЫ.]]..txtb('^ГОВОРИТЬ')..[[ — с некоторыми персонажами герой может разговаривать.]]..txtb('^ОТДАТЬ')..[[ — здесь Вы должны выбрать КАКОЙ (первый клик) предмет, из имеющихся у Вас, надо отдать КОМУ (второй клик).]]..txtb('^ЖДАТЬ')..[[ — если Вы хотите подождать наступления какого-либо события.]]..txtb('^^Примечание^')..[[В меню ИСПОЛЬЗОВАТЬ и ОТДАТЬ курсивом отмечаются те предметы, которые у Вас с собой.]];
        return v;
    end,
    obj = { vway('1', '{Вернуться в главное меню}', 'main') },
};


gratitudes = room
{
    nam = 'Благодарности',
    pic = 'images/gun.png',
    enter = function (s)
--        set_music('music/vvb_-_whammy4.ogg');
    end,
    dsc = function (s)
        p [[Хочется выразить признательность:^
        – Риддли Скотту за фильм «Бегущий по лезвию бритвы». С него началось
        знакомство с киберпанком. По сей день он остаётся любимейшим из всех
        когда либо просмотренных фильмов.^
        – Уильяму Гибсону за книгу «Нейромант». Без этой книги этой игры бы
        не было.^
        – Группе «Golden Earring» за трек «Twilight Zone». Почитайте текст и
        всё поймёте.^
        – Жану Беро за картину «В кафе».^
        – Петру Косых за INSTEAD, помощь в программировании и графическую
        тему «cyberpunk», специально разработанную им для этой игры.^
        – ...
        ]];
        return;
    end,
    obj = { vway('1', '{Вернуться в главное меню}', 'main') },
};


status = stat
{
    nam = 'stat',
--    _where = 'r_111',
    _quay_felchi_address = false,
};

