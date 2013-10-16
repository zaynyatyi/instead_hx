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
        p [[Well done!^^
        You have finished next part of the game.
        What adventures await you and how all the story ends —
        all of it it nexts parts of the game.^^
        Look after the new versions!
        ]];
    end,
};
