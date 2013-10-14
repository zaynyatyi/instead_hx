mlook = obj_menu ('ОСМОТРЕТЬ', 'exam', true);
minv  = obj_menu ('С СОБОЙ', 'exam', false, true);
mtake = obj_menu ('ВЗЯТЬ', 'take', true);
mdrop = obj_menu ('БРОСИТЬ', 'drop', false, true);
muse  = use_menu ('ИСПОЛЬЗОВАТЬ', 'use', 'used', 'useit', true, true);
mtalk = obj_menu ('ГОВОРИТЬ', 'talk', true);
mgive = use_menu ('ОТДАТЬ', 'give', 'accept', false, true, true, true);
mwait = act_menu ('ЖДАТЬ', 'wait', false);
mwalk = obj_menu ('ИДТИ', 'walk', false, false, true);


game.take = 'Это нельзя взять.';


game.after_take = function (s, w)
    take (w);
end


game.after_drop = function (s, w)
    drop (w);
end


game.before_give = function(s, w, ww)
    if not have (w) then
        p 'У меня этого нет.';
        return false;
    end
end


game.after_give = function (s, w)
    remove ( w, inv() );
end


game.useit = 'Не получается...';
game.use = 'Не получается использовать это...';
game.give = 'Не получается отдать это...';
game.talk = 'Нет ответа...';
game.wait = 'Прошло немного времени...';


function actions_init()
    put (mlook, me());
    put (minv, me());
    put (mtake, me());
    put (mdrop, me());
    put (muse, me());
    put (mtalk, me());
    put (mgive, me());
    put (mwait, me());
--    put (mwalk, me());
end
