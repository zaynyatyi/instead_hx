(function () { "use strict";
var EReg = function(r,opt) {
	opt = opt.split("u").join("");
	this.r = new RegExp(r,opt);
};
EReg.__name__ = true;
EReg.prototype = {
	replace: function(s,by) {
		return s.replace(this.r,by);
	}
}
var HxOverrides = function() { }
HxOverrides.__name__ = true;
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
}
var Main = function() {
	this.stead_dispatcher = new stead.SteadDispatcher();
};
Main.__name__ = true;
Main.main = function() {
	var object = new Main();
}
var Std = function() { }
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
}
var js = {}
js.Boot = function() { }
js.Boot.__name__ = true;
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2, _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i;
			var str = "[";
			s += "\t";
			var _g = 0;
			while(_g < l) {
				var i1 = _g++;
				str += (i1 > 0?",":"") + js.Boot.__string_rec(o[i1],s);
			}
			str += "]";
			return str;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) { ;
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
}
js.Browser = function() { }
js.Browser.__name__ = true;
js.Lib = function() { }
js.Lib.__name__ = true;
js.Lib.alert = function(v) {
	alert(js.Boot.__string_rec(v,""));
}
var stead = {}
stead.SteadDispatcher = function() {
	stead.SteadDispatcher.interpreter.load("web.lua");
	stead.SteadDispatcher.interpreter.load("stead.lua");
	stead.SteadDispatcher.interpreter.load("gui.lua");
	stead.SteadDispatcher._dofile_path = "./gamesource/";
	stead.SteadDispatcher.interpreter.load(stead.SteadDispatcher._dofile_path + "main.lua");
	stead.SteadDispatcher.interpreter.call("game.ini(game)");
	stead.SteadDispatcher.look();
};
stead.SteadDispatcher.__name__ = true;
stead.SteadDispatcher.look = function() {
	stead.SteadDispatcher.setContent("text",Std.string(stead.SteadDispatcher.interpreter.call("iface.cmd(iface, \"look\")")[0]));
}
stead.SteadDispatcher.click = function(ref) {
	stead.SteadDispatcher.interpreter.call("iface.cmd(iface, \"" + HxOverrides.substr(ref,1,null) + "\")");
	stead.SteadDispatcher.look();
}
$hxExpose(stead.SteadDispatcher.click, "stead.SteadDispatcher.click");
stead.SteadDispatcher.get_dofile = function() {
	return stead.SteadDispatcher._dofile_path;
}
$hxExpose(stead.SteadDispatcher.get_dofile, "stead.SteadDispatcher.get_dofile");
stead.SteadDispatcher.setContent = function(id,content) {
	var d = js.Browser.document.getElementById(id);
	if(d == null) js.Lib.alert("Unknown element : " + id);
	d.innerHTML = "<pre>" + stead.SteadDispatcher.normalizeLinks(content) + "</pre>";
}
stead.SteadDispatcher.normalizeLinks = function(input) {
	var r = new EReg("<a(:)(\\d+)","g");
	return r.replace(input,"<a href=\"javascript:stead.SteadDispatcher.click('#$2')\"");
}
String.__name__ = true;
Array.__name__ = true;
var q = window.jQuery;
js.JQuery = q;
js.Browser.document = typeof window != "undefined" ? window.document : null;
stead.SteadDispatcher._dofile_path = "";
stead.SteadDispatcher.interpreter = new Interpreter();
Main.main();
function $hxExpose(src, path) {
	var o = typeof window != "undefined" ? window : exports;
	var parts = path.split(".");
	for(var ii = 0; ii < parts.length-1; ++ii) {
		var p = parts[ii];
		if(typeof o[p] == "undefined") o[p] = {};
		o = o[p];
	}
	o[parts[parts.length-1]] = src;
}
})();
