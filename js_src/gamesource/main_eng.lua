require 'object'
require 'para'
require 'xact'
require 'dash'
--require 'parser'
require 'theme'
require 'proxymenu'
require 'hideinv'
--require 'dbg'

dofile ('menu_actions_eng.lua');
dofile ('part_1_chapter_1_eng.lua');
--dofile ('part_1_chapter_2.lua');
--dofile ('part_1_chapter_3.lua');
--dofile ('part_1_chapter_4.lua');
--dofile ('part_1_terminals.lua');
dofile ('part_1_subway.lua');
dofile ('part_1_mplayer.lua');
dofile ('terminal.lua');
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
--    enter = function (s)
--        set_music ('music/vvb_-_runaway_from_troubles.ogg');
--    end,
    dsc = function (s)
        p [[Well done!^^
        You have finished first chapter of the game.
        What adventures await you and how all the story ends —
        all of it it next parts of the game.^^
        Look after the new versions!
        ]];
    end,
};




main = room
{
    nam = '«Backup»',
    pic = 'images/title.png',
--    enter = function (s)
--        set_music('music/vvb_-_careless_childhood.ogg');
--    end,
    dsc = function (s)
        p [[Story, music, graphics: Vadim V. Balashoff (Вадим В. Балашов)^
        Drawings are made based on photos from open sources.^
        Version 0.3 alpha (06.09.2012).^
        Please send your opinions to vvb.backup@rambler.ru^^
        Specially for a flash version music is encoded with low rate.
        For a better quality you should play INSTEAD version of game.
        ]];
        return;
    end,
    obj =
    {
        --vway('1', '{Об авторах}^', 'about'),
        vway('2', '{Instruction}^', 'ins01'),
        vway('3', '{Gratitudes}^^', 'gratitudes'),
        vway('4', '{Start game}', 'intro_1')
    },
};


ins01 = room
{
    nam = 'Instructions',
--    pic = 'images/instructions.png',
--    enter = function (s)
--        set_music('music/instructions.ogg');
--    end,
    dsc = function (s)
        local v = txtc(txtu(txtb('Действия игрока:')))..txtb('^ОСМОТРЕТЬ')..[[ — позволяет осмотреть предметы вокруг (кроме тех, что с собой).]]..txtb('^С СОБОЙ')..[[ — позволяет осмотреть предметы, которые у Вас с собой.]]..txtb('^ВЗЯТЬ')..[[ — если это возможно, герой возьмёт указанный предмет.]]..txtb('^БРОСИТЬ')..[[ — лишние предметы можно оставить.]]..txtb('^ИСПОЛЬЗОВАТЬ')..[[ — для достижения цели игры герою придётся работать с окружающими его объектами. Для этого Вы должны указать КАКИМ (первый клик) предметом нужно действовать на КАКОЙ (второй клик) предмет. Чтобы использовать объект сам по себе, его нужно выбрать ДВАЖДЫ.]]..txtb('^ГОВОРИТЬ')..[[ — с некоторыми персонажами герой может разговаривать.]]..txtb('^ОТДАТЬ')..[[ — здесь Вы должны выбрать КАКОЙ (первый клик) предмет, из имеющихся у Вас, надо отдать КОМУ (второй клик).]]..txtb('^ЖДАТЬ')..[[ — если Вы хотите подождать наступления какого-либо события.]]..txtb('^^Примечание^')..[[В меню ИСПОЛЬЗОВАТЬ и ОТДАТЬ курсивом отмечаются те предметы, которые у Вас с собой.]];
        return v;
    end,
    obj = { vway('1', '{Back to main menu}', 'main') },
};


gratitudes = room
{
    nam = 'Gratitudes',
    pic = 'images/gun.png',
    enter = function (s)
--        set_music('music/vvb_-_whammy4.ogg');
    end,
    dsc = function (s)
        p [[Author want to express thanks to:^
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
    obj = { vway('1', '{Back to main menu}', 'main') },
};


status = stat
{
    nam = 'stat',
--    _where = 'r_111',
    _quay_felchi_address = false,
};

