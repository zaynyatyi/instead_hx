mlook = obj_menu ('EXAMINE', 'exam', true);
minv  = obj_menu ('INVENTORY', 'exam', false, true);
mtake = obj_menu ('TAKE', 'take', true);
mdrop = obj_menu ('DROP', 'drop', false, true);
muse  = use_menu ('USE', 'use', 'used', 'useit', true, true);
mtalk = obj_menu ('TALK', 'talk', true);
mgive = use_menu ('GIVE', 'give', 'accept', false, true, true, true);
mwait = act_menu ('WAIT', 'wait', false);
mwalk = obj_menu ('WALK', 'walk', false, false, true);


game.take = 'I can’t take this.';


game.after_take = function (s, w)
    take (w);
end


game.after_drop = function (s, w)
    drop (w);
end


game.before_give = function(s, w, ww)
    if not have (w) then
        p 'I don’ have it.';
        return false;
    end
end


game.after_give = function (s, w)
    remove ( w, inv() );
end


game.useit = 'I can’t use it...';
game.use = 'I can’t use it...';
game.give = 'I can’t give it...';
game.talk = 'There is no answer...';
game.wait = 'I wait for a while...';


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
