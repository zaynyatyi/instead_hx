

function Glue_init()
{
	Lua.requires = {}
	Lua.inject(function (path) {
		// path transformations
		if (path.substr(-4) == ".lua") 
			path = path.slice(0, -4); // require automatically appends .lua to the filepath later, remove it here
		path = path.replace(/\./g, "/");
		if (Lua.requires[path])
			return;
		Lua.requires[path] = true;
		return RunLuaFromPath(path + ".lua"); // require("bla") -> bla.lua
		//~ NOTE: replaces parser lib lua_require(G, path);
	}, 'require');
	Lua.inject(function (path) {
		return RunLuaFromPath(stead.SteadDispatcher.get_dofile() + path);
	}, 'dofile');
}

/// synchronous ajax to get file, so code executed before function returns
function RunLuaFromPath (path) {
	//if (gLoveExecutionHalted) return;
	//~ MainPrint("RunLuaFromPath "+path);
	try {
		// download code via synchronous ajax... sjax? ;)
		gLastLoadedLuaCode = false;
		UtilAjaxGet(path,function (luacode) { gLastLoadedLuaCode = luacode; },true);
		var luacode = gLastLoadedLuaCode;

		// check if download worked
		if ((typeof luacode) != "string") { throw String("RunLuaFromPath failed '"+path+"' : type="+(typeof luacode)+" val="+String(luacode)); }

		// construct temporary function name containing filepath for more useful error messages
		// var temp_function_name = "luatmp_"+path.replace(/[^a-zA-Z0-9]/g,"_");
		luacode = Utf8.encode(luacode);
		Lua.cache.items = {}; // Clear cache;
		var res = Lua.exec(luacode, path);
		return res;
	} catch (e) {
		// error during run, display infos as good as possible, lua-stacktrace would be cool here, but hard without line numbers
		//if (!safe)
		MainPrint("error during "+path+" : "+String(e)+" :\n"+PrepareExceptionStacktraceForOutput(e)); 
	}
}

// convert non latin symbols
var Utf8 = {
	// public method for url encoding
	encode : function (string) {
		string = string.replace(/\r\n/g,"\n");
		var utftext = "";
		for (var n = 0; n < string.length; n++) {
			var c = string.charCodeAt(n);
			if (c < 128) {
				utftext += String.fromCharCode(c);
			} else if(c > 127) {
				utftext += '&#';
				utftext += c;
				utftext += ';';
			}
		}
		return utftext;
	},
}
