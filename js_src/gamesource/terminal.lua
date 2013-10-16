require "sprites"
require "theme"
require "kbd"
require "hideinv"
require "xact"

TERMINAL_W = 44
TERMINAL_H = 20
TERMINAL_BG = nil

fxd_font = obj {
	nam = 'font';
	fg = 'cyan';
	alpha = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 
		'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 
		'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 
		'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
		'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
		'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
		'а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и',
		'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т',
		'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ь', 'ы', 'э', 'ъ', 'ю', 'я',

		'А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ё', 'Ж', 'З', 'И',
		'Й', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т',
		'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ', 'Ь', 'Ы', 'Э', 'Ъ', 'Ю', 'Я',

		'_', '-', '/', '.', '=', "(", ")", "@",  "{", "}",
		'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ',', ':', '>', '<', '!', '?',
		'"', " " };
	glyphs = {};
	init = function(s, path, size)
		s.fnt = sprite.font(path, size)
		if not s.fnt then
			error("Can't load font.", 2)
		end
		s.fh = sprite.font_height(s.fnt) + 4;
		local k,v
		for k,v in ipairs(s.alpha) do
			s.glyphs[v] = sprite.text(s.fnt, v, s.fg);
		end
		local ww, hh =sprite.size(s.glyphs['A'])
		s.fw = ww + 1
	end;
}

terminal = function(v)
	if not v.fg then
		v.fg = 'cyan';
	end

	if not v.bg then
		v.bg = 'black';
	end

	v.noinv = true

	if not v.w then
		v.w = TERMINAL_W
	end

	if not v.h then
		v.h = TERMINAL_H
	end

	v.kbd = function(s, press, sym)
		if not press then
			return
		end
		s:cursor(false)
		if sym == 'return' then
			s:cr(true)
			if s.input ~= '' then
				local r,v = stead.call(s, 'shell', s.input)
				if here() == s then
					s:draw()
					s:cursor(true)
				end
				return r, true
			end
			s:prompt('>', true)
		elseif sym == 'backspace' then
			s:bs(true)
		else
			if sym == 'space' then sym = ' ' end
			s:char(sym, true)
		end
		s:cursor(true)
		return nil, true
	end

	stead.table.insert(v, var { 
		scr = {}; 
		x = 1;
		y = 1;
		px = 0;
		py = 0;
		plen = 0;
		input = '';});
	v.glyphs = {};
	v.cls = function(s)
		local xx, yy
		s.x = 1
		s.y = 1
		s.px = 0
		s.py = 0
		s.scr = {}
		for yy = 1, s.h do
			stead.table.insert(s.scr, {});
		end
	end

	v.entered = function(s)
		if TERMINAL_BG then
			theme.gfx.bg(TERMINAL_BG)
			theme.inv.color(s.fg, s.fg, 'white')
		end
		hook_keys('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
			'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'space', 'return', 'backspace',
			'-', '/', '.', '=',
			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ',');
		s:alloc();
		s:start();
		s:draw()
		s:cursor(true)
		place(keyboard, me())
	end;

	v.left = function(s)
		remove(keyboard, me())
		unhook_keys('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
			'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'space', 'return', 'backspace',
			'-', '/', '.', '=',
			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ',');
		s:free();
		theme.gfx.reset()
		theme.inv.reset()
	end;

	v.alloc = function(s)
		if not s.pic then
			s.pic = sprite.box(s.w * s.fw, s.h * s.fh, s.bg)
		else
			sprite.fill(s.pic, s.bg)
		end
		s.output = s.pic
	end

	v.free = function(s)
		sprite.free(s.pic)
	end

	v.ini = function(s, load)
		s.glyphs = fxd_font.glyphs
		s.alpha = fxd_font.alpha
		s.fw = fxd_font.fw
		s.fh = fxd_font.fh

		if #s.scr == 0 then
			s:cls() -- create new screen
		end
		if here() == s then
			s:alloc()
			s:draw()
			s:cursor(true)
		end
	end;

	v.prompt = function(s, c, draw)
		s.px = s.x
		s.py = s.y
		if c then
			s:char(c, draw)
			s.plen = 1
		else
			s.plen = 0
		end
		s.input = ''
	end;

	v.scroll = function(s, draw)
		stead.table.remove(s.scr, 1)
		stead.table.insert(s.scr, {})
		if draw then
			sprite.copy(s.output, 0, s.fh, -1, -1, s.output, 0, 0);
			sprite.fill(s.output, 0, s.fh * (s.y - 1), s.w * s.fw, s.fh, s.bg);
		end
		s.py = s.py - 1
	end;
	v.echo = function(s, ...)
		local k,v,a,c
		a = {...}
		for k,v in ipairs(a) do
			v = tostring(v)
			while v:len() >0 do
				if v:byte(1) >= 128 then
					c = v:sub(1, 2);
					v = v:sub(3, v:len());
				else
					c = v:sub(1, 1);
					v = v:sub(2, v:len());
				end
				if c == '\n' then
					s:cr()
				elseif c == '\b' then
					s:bs()
				else
					s:char(c)
				end
			end
		end
	end;
	v.draw = function(s)
		local xx, yy
		sprite.fill(s.output, s.bg);
		for yy=1, s.h do
			for xx=1, s.w do
				local sym = s.scr[yy][xx]
				if sym then
					sprite.draw(s.glyphs[sym], s.output, 
						(xx - 1) * s.fw, 
						(yy - 1) * s.fh);
				end
			end
		end
		s:cursor(true)
	end;

	v.cr = function(s, draw)
		s.x = 1
		s.y = s.y + 1
		if s.y > s.h then
			s.y = s.h
			s:scroll(draw)
		end
	end;

	v.cursor = function(s, on)
		if on then
			sprite.fill(s.output, (s.x - 1) * s.fw, s.fh * (s.y - 1), s.fw, s.fh, s.fg);
		else
			sprite.fill(s.output, (s.x - 1) * s.fw, s.fh * (s.y - 1), s.fw, s.fh, s.bg);
		end
	end;

	v.bs = function(s, c, draw)
		if s.x == 1 and s.y == 1  then
			return
		end
		if s.y == s.py and s.x == s.px + s.plen then
			return
		end

		s.input = s.input:sub(1, s.input:len() - 1)

		if s.x == 1 then
			s.x = s.w
			s.y = s.y - 1
		else
			s.x = s.x - 1
		end
		s.scr[s.y][s.x] = nil
		if draw then
			sprite.fill(s.output, (s.x - 1) * s.fw, s.fh * (s.y - 1), s.fw, s.fh, s.bg);
		end
	end;

	v.char = function(s, c, draw)
		s.input = s.input .. c;
		s.scr[s.y][s.x] = c
		if draw then
			sprite.fill(s.output, (s.x - 1) * s.fw, (s.y - 1) * s.fh, s.fw, s.fh, s.bg);
			sprite.draw(s.glyphs[c], s.output, (s.x - 1) * s.fw, (s.y - 1) * s.fh);
		end
		s.x = s.x + 1
		if s.x > s.w then
			s.x = 1
			s.y = s.y + 1
			if s.y > s.h then
				s.y = s.h
				s:scroll(draw)
			end
		end
	end;
	return room(v)
end

term_key = xact('key',  function(s, w)
	return stead.call(here(), "kbd", true, w:lower())
end)

keyboard = stat {
	nam = 'клавиатура',
	disp = function(s)
		p [[{term_key(A)|A} {term_key(B)|B} {term_key(C)|C} {term_key(D)|D} {term_key(E)|E} {term_key(F)|F}]];
		p [[{term_key(G)|G} {term_key(H)|H} {term_key(I)|I} {term_key(J)|J} {term_key(K)|K} {term_key(L)|L} {term_key(M)|M} ]];
		p [[{term_key(N)|N} {term_key(O)|O} {term_key(P)|P} {term_key(Q)|Q} {term_key(R)|R}]];
		p [[{term_key(S)|S} {term_key(T)|T} {term_key(U)|U} {term_key(V)|V} {term_key(W)|W} {term_key(X)|X}]];
		pn [[{term_key(Y)|Y} {term_key(Z)|Z}]]
		pn [[ {term_key(-)|-} {term_key(/)|/} {term_key(.)|.} {term_key(=)|=} {term_key(,)|,}]]
		pn [[{term_key(0)|0} {term_key(1)|1} {term_key(2)|2} {term_key(3)|3} {term_key(4)|4} {term_key(5)|5} {term_key(6)|6} {term_key(7)|7} {term_key(8)|8} {term_key(9)|9}]]
		pn [[{term_key(space)|«Пробел»}  {term_key(backspace)|«Забой»}   {term_key(return)|«Ввод»}]]
	end,
};


function get_cmd(str)
        local a = {}
        str:gsub("[^ \t]+", function(s)
                table.insert(a, s)
                return s
        end)
        local c = a[1]
        table.remove(a, 1)
        return c, a
end
