(function ($hx_exports) { "use strict";
$hx_exports.stead = {SteadDispatcher:{}};
var $estr = function() { return js.Boot.__string_rec(this,''); };
var EReg = function(r,opt) {
	opt = opt.split("u").join("");
	this.r = new RegExp(r,opt);
};
EReg.__name__ = true;
EReg.prototype = {
	replace: function(s,by) {
		return s.replace(this.r,by);
	}
};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
var Lambda = function() { };
Lambda.__name__ = true;
Lambda.exists = function(it,f) {
	var $it0 = it.iterator();
	while( $it0.hasNext() ) {
		var x = $it0.next();
		if(f(x)) return true;
	}
	return false;
};
var List = function() {
	this.length = 0;
};
List.__name__ = true;
List.prototype = {
	iterator: function() {
		return { h : this.h, hasNext : function() {
			return this.h != null;
		}, next : function() {
			if(this.h == null) return null;
			var x = this.h[0];
			this.h = this.h[1];
			return x;
		}};
	}
};
var Main = function() {
	this.stead_dispatcher = new stead.SteadDispatcher();
	this.theme_parser = new ThemeParser();
	this.theme_parser.Parse();
	var stead_div = window.document.getElementById("stead");
	if(this.theme_parser.theme.exists("scr.gfx.bg")) stead_div.style.backgroundImage = "url(gamesource/" + this.theme_parser.theme.get("scr.gfx.bg") + ")";
	if(this.theme_parser.theme.exists("scr.h") && this.theme_parser.theme.exists("scr.w")) {
		stead_div.style.width = this.theme_parser.theme.get("scr.w") + "px";
		stead_div.style.height = this.theme_parser.theme.get("scr.h") + "px";
	}
};
Main.__name__ = true;
Main.main = function() {
	var object = new Main();
};
var IMap = function() { };
IMap.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
var StringTools = function() { };
StringTools.__name__ = true;
StringTools.urlEncode = function(s) {
	return encodeURIComponent(s);
};
var ThemeParser = function() {
	this.theme = new haxe.ds.StringMap();
};
ThemeParser.__name__ = true;
ThemeParser.prototype = {
	Parse: function() {
		var theme_file = haxe.Http.requestUrl("gamesource/theme.ini").split("\n");
		var _g = 0;
		while(_g < theme_file.length) {
			var line = theme_file[_g];
			++_g;
			var pair = line.split(" = ");
			if(pair.length == 2) this.theme.set(pair[0],pair[1]);
		}
	}
};
var haxe = {};
haxe.Http = function(url) {
	this.url = url;
	this.headers = new List();
	this.params = new List();
	this.async = true;
};
haxe.Http.__name__ = true;
haxe.Http.requestUrl = function(url) {
	var h = new haxe.Http(url);
	h.async = false;
	var r = null;
	h.onData = function(d) {
		r = d;
	};
	h.onError = function(e) {
		throw e;
	};
	h.request(false);
	return r;
};
haxe.Http.prototype = {
	request: function(post) {
		var me = this;
		me.responseData = null;
		var r = js.Browser.createXMLHttpRequest();
		var onreadystatechange = function(_) {
			if(r.readyState != 4) return;
			var s;
			try {
				s = r.status;
			} catch( e ) {
				s = null;
			}
			if(s == undefined) s = null;
			if(s != null) me.onStatus(s);
			if(s != null && s >= 200 && s < 400) me.onData(me.responseData = r.responseText); else if(s == null) me.onError("Failed to connect or resolve host"); else switch(s) {
			case 12029:
				me.onError("Failed to connect to host");
				break;
			case 12007:
				me.onError("Unknown host");
				break;
			default:
				me.responseData = r.responseText;
				me.onError("Http Error #" + r.status);
			}
		};
		if(this.async) r.onreadystatechange = onreadystatechange;
		var uri = this.postData;
		if(uri != null) post = true; else {
			var $it0 = this.params.iterator();
			while( $it0.hasNext() ) {
				var p = $it0.next();
				if(uri == null) uri = ""; else uri += "&";
				uri += StringTools.urlEncode(p.param) + "=" + StringTools.urlEncode(p.value);
			}
		}
		try {
			if(post) r.open("POST",this.url,this.async); else if(uri != null) {
				var question = this.url.split("?").length <= 1;
				r.open("GET",this.url + (question?"?":"&") + uri,this.async);
				uri = null;
			} else r.open("GET",this.url,this.async);
		} catch( e ) {
			this.onError(e.toString());
			return;
		}
		if(!Lambda.exists(this.headers,function(h) {
			return h.header == "Content-Type";
		}) && post && this.postData == null) r.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		var $it1 = this.headers.iterator();
		while( $it1.hasNext() ) {
			var h = $it1.next();
			r.setRequestHeader(h.header,h.value);
		}
		r.send(uri);
		if(!this.async) onreadystatechange(null);
	}
	,onData: function(data) {
	}
	,onError: function(msg) {
	}
	,onStatus: function(status) {
	}
};
haxe.ds = {};
haxe.ds.StringMap = function() {
	this.h = { };
};
haxe.ds.StringMap.__name__ = true;
haxe.ds.StringMap.__interfaces__ = [IMap];
haxe.ds.StringMap.prototype = {
	set: function(key,value) {
		this.h["$" + key] = value;
	}
	,get: function(key) {
		return this.h["$" + key];
	}
	,exists: function(key) {
		return this.h.hasOwnProperty("$" + key);
	}
};
var js = {};
js.Boot = function() { };
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
				var _g1 = 2;
				var _g = o.length;
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
		for( var k in o ) {
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
};
js.Browser = function() { };
js.Browser.__name__ = true;
js.Browser.createXMLHttpRequest = function() {
	if(typeof XMLHttpRequest != "undefined") return new XMLHttpRequest();
	if(typeof ActiveXObject != "undefined") return new ActiveXObject("Microsoft.XMLHTTP");
	throw "Unable to create XMLHttpRequest object.";
};
js.Lib = function() { };
js.Lib.__name__ = true;
js.Lib.alert = function(v) {
	alert(js.Boot.__string_rec(v,""));
};
var stead = {};
stead.EField = { __ename__ : true, __constructs__ : ["Text","Ways","Title","Inv"] };
stead.EField.Text = ["Text",0];
stead.EField.Text.toString = $estr;
stead.EField.Text.__enum__ = stead.EField;
stead.EField.Ways = ["Ways",1];
stead.EField.Ways.toString = $estr;
stead.EField.Ways.__enum__ = stead.EField;
stead.EField.Title = ["Title",2];
stead.EField.Title.toString = $estr;
stead.EField.Title.__enum__ = stead.EField;
stead.EField.Inv = ["Inv",3];
stead.EField.Inv.toString = $estr;
stead.EField.Inv.__enum__ = stead.EField;
stead.SteadDispatcher = function() {
	stead.SteadDispatcher.interpreter.load("web.lua");
	stead.SteadDispatcher.interpreter.load("stead.lua");
	stead.SteadDispatcher.interpreter.load("gui.lua");
	stead.SteadDispatcher._dofile_path = "./" + ThemeParser.game_folder + "/";
	stead.SteadDispatcher.interpreter.load(stead.SteadDispatcher._dofile_path + "main.lua");
	stead.SteadDispatcher.interpreter.call("game.ini(game)");
	stead.SteadDispatcher.canvas = window.document.getElementById("canvas");
	stead.SteadDispatcher.look();
};
stead.SteadDispatcher.__name__ = true;
stead.SteadDispatcher.look = function() {
	stead.SteadDispatcher.ifaceCmd("\"look\"");
	stead.SteadDispatcher.refreshInterface();
};
stead.SteadDispatcher.refreshInterface = function() {
	stead.SteadDispatcher.getTitle();
	stead.SteadDispatcher.getWays();
	stead.SteadDispatcher.getInv();
	stead.SteadDispatcher.getPicture();
	stead.SteadDispatcher.getMusic();
};
stead.SteadDispatcher.click = $hx_exports.stead.SteadDispatcher.click = function(ref,field) {
	if(stead.SteadDispatcher.act || field == stead.EField.Inv[1]) {
		ref = HxOverrides.substr(ref,1,null);
		if(HxOverrides.substr(ref,0,3) == "act") {
			ref = "use " + HxOverrides.substr(ref,4,null);
			stead.SteadDispatcher.ifaceCmd("\"" + ref + "\"");
			stead.SteadDispatcher.refreshInterface();
			return;
		}
		if(stead.SteadDispatcher.act) {
			if(field != stead.EField.Ways[1] && field != stead.EField.Title[1]) {
				if(ref == stead.SteadDispatcher.thing) stead.SteadDispatcher.ifaceCmd("\"use " + ref + "\""); else stead.SteadDispatcher.ifaceCmd("\"use " + stead.SteadDispatcher.thing + "," + ref + "\"");
				stead.SteadDispatcher.act = false;
				stead.SteadDispatcher.thing = "";
				stead.SteadDispatcher.refreshInterface();
			}
		} else {
			stead.SteadDispatcher.act = true;
			stead.SteadDispatcher.thing = ref;
		}
	} else {
		stead.SteadDispatcher.ifaceCmd("\"" + ref + "\"");
		stead.SteadDispatcher.refreshInterface();
	}
};
stead.SteadDispatcher.get_dofile = $hx_exports.stead.SteadDispatcher.get_dofile = function() {
	return stead.SteadDispatcher._dofile_path;
};
stead.SteadDispatcher.getInv = function() {
	var retVal = stead.SteadDispatcher.interpreter.call("instead.get_inv(true)");
	if(retVal[0] != null) {
		var invAnswer = Std.string(retVal[0]);
		stead.SteadDispatcher.setContent("inventory",invAnswer,stead.EField.Inv);
	}
};
stead.SteadDispatcher.getWays = function() {
	var waysAnswer = Std.string(stead.SteadDispatcher.interpreter.call("instead.get_ways()")[0]);
	stead.SteadDispatcher.setContent("ways",waysAnswer,stead.EField.Ways);
};
stead.SteadDispatcher.getTitle = function() {
	var waysAnswer = Std.string(stead.SteadDispatcher.interpreter.call("instead.get_title()")[0]);
	stead.SteadDispatcher.setContent("title","<a href=\"javascript:stead.SteadDispatcher.click('#look', " + stead.EField.Title[1] + ")\">" + waysAnswer + "</a>",stead.EField.Title);
};
stead.SteadDispatcher.getPicture = function() {
	var retVal = stead.SteadDispatcher.interpreter.call("instead.get_picture()");
	if(retVal[0] != null) {
		var picture_path = Std.string(retVal[0]);
		stead.SteadDispatcher.showPicture(picture_path);
	}
};
stead.SteadDispatcher.getMusic = function() {
	var retVal = stead.SteadDispatcher.interpreter.call("instead.get_music()");
	if(retVal[0] != null) {
		var music_path = Std.string(retVal[0]);
		stead.SteadDispatcher.playMusic(music_path);
	}
};
stead.SteadDispatcher.showPicture = function(path) {
	console.log(path);
	var image = new Image();
	image.style.left = "0px";
	image.style.top = "0px";
	image.onload = stead.SteadDispatcher.copyAccross;
	image.style.position = "absolute";
	image.src = stead.SteadDispatcher._dofile_path + path;
};
stead.SteadDispatcher.copyAccross = function(e) {
	var image = e.currentTarget;
	stead.SteadDispatcher.canvas.getContext("2d").clearRect(0,0,stead.SteadDispatcher.canvas.width,stead.SteadDispatcher.canvas.height);
	stead.SteadDispatcher.canvas.width = image.width;
	stead.SteadDispatcher.canvas.height = image.height;
	stead.SteadDispatcher.canvas.getContext("2d").drawImage(image,0,0,image.width,image.height);
};
stead.SteadDispatcher.playMusic = function(path) {
	console.log(path);
};
stead.SteadDispatcher.ifaceCmd = function(command) {
	var retVal = stead.SteadDispatcher.interpreter.call("iface.cmd(iface, " + command + ")");
	if(retVal[0] != null) {
		var cmdAnswer = Std.string(retVal[0]);
		var rc = retVal[1];
		if(cmdAnswer != "" && rc) stead.SteadDispatcher.setContent("text",cmdAnswer,stead.EField.Text);
	}
};
stead.SteadDispatcher.setContent = function(id,content,field) {
	var d = window.document.getElementById(id);
	if(d == null) js.Lib.alert("Unknown element : " + id);
	d.innerHTML = "<pre>" + stead.SteadDispatcher.normalizeContent(content,field) + "</pre>";
};
stead.SteadDispatcher.normalizeContent = function(input,field) {
	var output = "";
	var r = new EReg("<a(:)([\\w+\\d+ ]+)","g");
	output = r.replace(input,"<a href=\"javascript:stead.SteadDispatcher.click('#$2', " + field[1] + ")\"");
	r = new EReg("<w:([^>]+)>","g");
	output = r.replace(output,"<span class=\"nowrap\">$1</span>");
	return output;
};
String.__name__ = true;
Array.__name__ = true;
var q = window.jQuery;
js.JQuery = q;
ThemeParser.game_folder = "gamesource";
stead.SteadDispatcher._dofile_path = "";
stead.SteadDispatcher.interpreter = new Interpreter();
stead.SteadDispatcher.act = false;
stead.SteadDispatcher.thing = "";
Main.main();
})(typeof window != "undefined" ? window : exports);
