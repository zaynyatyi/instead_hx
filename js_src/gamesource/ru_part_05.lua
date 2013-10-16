instead_version '1.7.1'

require 'para'

main = room
{
    nam = '...',
    hideinv = true,
    pic = 'images/title.png',
    enter = function (s)
        set_music ('music/vvb_-_runaway_from_troubles.ogg');
    end,
    dsc = function (s)
        p [[Поздравляю!^^
        Вы прошли очередную часть игры.
        Какие приключения ждут главного героя и чем закончится
        история — всё это в следующих частях игры.^^
        Следите за обновлениями!
        ]];
    end,
};
