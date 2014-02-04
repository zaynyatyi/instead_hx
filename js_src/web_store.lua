-- JS<-->Lua glue
--
-- Horribly hackish, this is not the right way to do it

js.number = 1
js.string = 2
js.object = 3
js.func = 4

js.lua_table = {}
js.lua_index = 1

virtualfile = {}
virtualfile.__index = virtualfile

function virtualfile.create(name)
   local vf = {}             -- our new object
   setmetatable(vf,virtualfile)  -- make Account handle lookup
   vf.name = name
   vf.data = ""
   return vf
end
virtualfile.create = virtualfile.create

function virtualfile:write(...)
    local a = { ... }
	for i,v in ipairs(a) do
		self.data = self.data .. tostring(v);
	end
end

function virtualfile:flush()
	js.run("localStorage." .. self.name .. " = " .. string.gsub(string.format("%q", self.data), "\n", "\\n") .. ";")
end

function virtualfile:close()
end

function virtualfile:read()
   local str
   str = string.gsub(js.run_string("localStorage." .. self.name .. ";"), "\\n", "\n")
   return str
end

function game_save(self, name, file)
	local h;
	if file ~= nil then
		file:write(name..".pl = '"..deref(self.pl).."'\n");
		stead.savemembers(file, self, name, false);
		return nil, true
	end
	if name == nil then
		return nil, false
	end
	h = virtualfile.create(name)
	stead.do_savegame(self, h);
	h:flush()
	h:close()
	game.autosave = false; -- we have only one try for autosave
	return nil;
end
game.save = game_save

function game_load(self, name)
    local h;
	if name == nil then
		return nil, false
	end
    h = virtualfile.create(name)
	local f, err = loadstring(h:read());
	if f then
        print('loaded')
		local i,r = f();
		if r then
			return nil, false
		end
		i, r = stead.do_ini(self, true);
		if not stead.started then
			game:start()
			stead.started = true
		end
		return i, r
	end
    print('error')
	return nil, false
end
game.load = game_load

function clearvar (v)
	local k,o
	for k,o in pairs(v) do
		if type(o) == 'table' and o.__visited__ ~= nil and string.find(o.__visited__, "package") == nil then
			o.__visited__ = nil
			o.auto_saved = nil
			clearvar(o)
		end
	end
end
stead.clearvar = clearvar
