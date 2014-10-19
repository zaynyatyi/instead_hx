(function ($hx_exports) { "use strict";
$hx_exports.stead = $hx_exports.stead || {};
$hx_exports.stead.SteadDispatcher = $hx_exports.stead.SteadDispatcher || {};
var EReg = function(r,opt) {
	opt = opt.split("u").join("");
	this.r = new RegExp(r,opt);
};
EReg.__name__ = true;
EReg.prototype = {
	replace: function(s,by) {
		return s.replace(this.r,by);
	}
	,__class__: EReg
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
	,__class__: List
};
var Main = function() {
	if(js.Browser.getLocalStorage().getItem("mute") == "true") stead.MenuDispatcher.Instance().muted = true; else stead.MenuDispatcher.Instance().muted = false;
	this.stead_dispatcher = new stead.SteadDispatcher();
	stead.UseIndicator.Instance().PowerOff();
	this.ApplyTheme();
};
Main.__name__ = true;
Main.main = function() {
	var object = new Main();
};
Main.prototype = {
	ApplyTheme: function() {
		stead.ThemeParser.Instance().Parse();
		var stead_div = window.document.getElementById("stead");
		var win_div = window.document.getElementById("win");
		var inv_div = window.document.getElementById("inventory");
		var cog_div = window.document.getElementById("cog");
		var menu_button = window.document.getElementById("menu_button");
		var menu_image = window.document.getElementById("menu_image");
		if(stead.ThemeParser.Instance().theme.exists("scr.gfx.bg")) stead_div.style.backgroundImage = "url(gamesource/" + stead.ThemeParser.Instance().theme.get("scr.gfx.bg") + ")";
		if(stead.ThemeParser.Instance().theme.exists("scr.w") && stead.ThemeParser.Instance().theme.exists("scr.h")) {
			stead_div.style.width = stead.ThemeParser.Instance().theme.get("scr.w") + "px";
			stead_div.style.height = stead.ThemeParser.Instance().theme.get("scr.h") + "px";
			stead_div.style.left = stead.ThemeParser.Instance().theme.get("scr.x") + "px";
			stead_div.style.top = stead.ThemeParser.Instance().theme.get("scr.y") + "px";
		}
		if(stead.ThemeParser.Instance().theme.exists("win.w") && stead.ThemeParser.Instance().theme.exists("win.h")) {
			win_div.style.width = stead.ThemeParser.Instance().theme.get("win.w") + "px";
			win_div.style.height = stead.ThemeParser.Instance().theme.get("win.h") + "px";
			win_div.style.left = stead.ThemeParser.Instance().theme.get("win.x") + "px";
			win_div.style.top = stead.ThemeParser.Instance().theme.get("win.y") + "px";
		}
		if(stead.ThemeParser.Instance().theme.exists("inv.w") && stead.ThemeParser.Instance().theme.exists("inv.h")) {
			inv_div.style.width = stead.ThemeParser.Instance().theme.get("inv.w") + "px";
			inv_div.style.height = stead.ThemeParser.Instance().theme.get("inv.h") + "px";
			inv_div.style.left = stead.ThemeParser.Instance().theme.get("inv.x") + "px";
			inv_div.style.top = stead.ThemeParser.Instance().theme.get("inv.y") + "px";
		}
		if(stead.ThemeParser.Instance().theme.exists("cog.x") && stead.ThemeParser.Instance().theme.exists("cog.y")) {
			cog_div.style.width = stead.ThemeParser.Instance().theme.get("cog.w") + "px";
			cog_div.style.height = stead.ThemeParser.Instance().theme.get("cog.h") + "px";
			cog_div.style.left = stead.ThemeParser.Instance().theme.get("cog.x") + "px";
			cog_div.style.top = stead.ThemeParser.Instance().theme.get("cog.y") + "px";
		}
		if(stead.ThemeParser.Instance().theme.exists("cog.gfx")) cog_div.style.backgroundImage = "url(gamesource/" + stead.ThemeParser.Instance().theme.get("cog.gfx") + ")";
		menu_button.style.left = stead.ThemeParser.Instance().theme.get("menu.button.x") + "px";
		menu_button.style.top = stead.ThemeParser.Instance().theme.get("menu.button.y") + "px";
		if(stead.ThemeParser.Instance().theme.exists("menu.gfx.button")) menu_image.src = "gamesource/" + stead.ThemeParser.Instance().theme.get("menu.gfx.button"); else menu_image.src = "gamesource/theme/menu.png";
		var styleSheet;
		styleSheet = js.Boot.__cast(window.document.styleSheets[0] , CSSStyleSheet);
		styleSheet.insertRule("#win a { color: " + stead.ThemeParser.Instance().theme.get("win.col.link") + "; }",0);
		styleSheet.insertRule("#win { color: " + stead.ThemeParser.Instance().theme.get("win.col.fg") + "; }",0);
		styleSheet.insertRule("#win a:hover { color: " + stead.ThemeParser.Instance().theme.get("win.col.alink") + "; }",0);
		styleSheet.insertRule("#inventory a { color: " + stead.ThemeParser.Instance().theme.get("inv.col.link") + "; }",0);
		styleSheet.insertRule("#inventory { color: " + stead.ThemeParser.Instance().theme.get("inv.col.fg") + "; }",0);
		styleSheet.insertRule("#inventory a:hover { color: " + stead.ThemeParser.Instance().theme.get("inv.col.alink") + "; }",0);
		menu_button.onclick = function(e) {
			stead.MenuDispatcher.Instance().ShowUp();
		};
	}
	,__class__: Main
};
var IMap = function() { };
IMap.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
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
		var r = this.req = js.Browser.createXMLHttpRequest();
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
			if(s != null && s >= 200 && s < 400) {
				me.req = null;
				me.onData(me.responseData = r.responseText);
			} else if(s == null) {
				me.req = null;
				me.onError("Failed to connect or resolve host");
			} else switch(s) {
			case 12029:
				me.req = null;
				me.onError("Failed to connect to host");
				break;
			case 12007:
				me.req = null;
				me.onError("Unknown host");
				break;
			default:
				me.req = null;
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
				uri += encodeURIComponent(p.param) + "=" + encodeURIComponent(p.value);
			}
		}
		try {
			if(post) r.open("POST",this.url,this.async); else if(uri != null) {
				var question = this.url.split("?").length <= 1;
				r.open("GET",this.url + (question?"?":"&") + uri,this.async);
				uri = null;
			} else r.open("GET",this.url,this.async);
		} catch( e1 ) {
			me.req = null;
			this.onError(e1.toString());
			return;
		}
		if(!Lambda.exists(this.headers,function(h) {
			return h.header == "Content-Type";
		}) && post && this.postData == null) r.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		var $it1 = this.headers.iterator();
		while( $it1.hasNext() ) {
			var h1 = $it1.next();
			r.setRequestHeader(h1.header,h1.value);
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
	,__class__: haxe.Http
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
	,__class__: haxe.ds.StringMap
};
var js = {};
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else return o.__class__;
};
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
			var i1;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
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
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) str2 += ", \n";
		str2 += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
};
js.Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js.Boot.__interfLoop(js.Boot.getClass(o),cl)) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
js.Boot.__cast = function(o,t) {
	if(js.Boot.__instanceof(o,t)) return o; else throw "Cannot cast " + Std.string(o) + " to " + Std.string(t);
};
js.Browser = function() { };
js.Browser.__name__ = true;
js.Browser.getLocalStorage = function() {
	try {
		var s = window.localStorage;
		s.getItem("");
		return s;
	} catch( e ) {
		return null;
	}
};
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
stead.MenuDispatcher = function() {
	var _g = this;
	this.visible = false;
	this.muted = false;
	this.save = window.document.getElementById("save");
	this.load = window.document.getElementById("load");
	this.reset = window.document.getElementById("reset");
	this.mute = window.document.getElementById("mute");
	this.back = window.document.getElementById("back");
	this.self = window.document.getElementById("menu");
	this.back.onclick = function(e) {
		_g.self.style.visibility = "hidden";
		_g.visible = false;
	};
	this.mute.onclick = function(e1) {
		js.Browser.getLocalStorage().setItem("mute",Std.string(!_g.muted));
		_g.muted = !_g.muted;
		stead.SteadDispatcher.track.muted = _g.muted;
	};
};
stead.MenuDispatcher.__name__ = true;
stead.MenuDispatcher.Instance = function() {
	if(stead.MenuDispatcher.instance == null) stead.MenuDispatcher.instance = new stead.MenuDispatcher();
	return stead.MenuDispatcher.instance;
};
stead.MenuDispatcher.prototype = {
	ShowUp: function() {
		this.self.style.visibility = "visible";
		this.visible = true;
	}
	,HideUp: function() {
		this.self.style.visibility = "hidden";
		this.visible = false;
	}
	,__class__: stead.MenuDispatcher
};
stead.EField = { __ename__ : true, __constructs__ : ["Text","Ways","Title","Inv"] };
stead.EField.Text = ["Text",0];
stead.EField.Text.__enum__ = stead.EField;
stead.EField.Ways = ["Ways",1];
stead.EField.Ways.__enum__ = stead.EField;
stead.EField.Title = ["Title",2];
stead.EField.Title.__enum__ = stead.EField;
stead.EField.Inv = ["Inv",3];
stead.EField.Inv.__enum__ = stead.EField;
stead.SteadDispatcher = function() {
	var _g = this;
	stead.SteadDispatcher.track.autoplay = true;
	stead.SteadDispatcher.track.loop = true;
	stead.SteadDispatcher.track.muted = stead.MenuDispatcher.Instance().muted;
	stead.SteadDispatcher.canvas = window.document.getElementById("canvas");
	stead.SteadDispatcher.win = window.document.getElementById("win");
	var stead_div = window.document.getElementById("stead");
	stead_div.onclick = $bind(this,this.OnSteadClick);
	stead.MenuDispatcher.Instance().save.onclick = $bind(this,this.OnSaveClick);
	stead.MenuDispatcher.Instance().load.onclick = $bind(this,this.OnLoadClick);
	stead.MenuDispatcher.Instance().reset.onclick = function(e) {
		stead.SteadDispatcher.interpreter.clear();
		_g.InitGame();
		stead.SteadDispatcher.look();
		stead.MenuDispatcher.Instance().HideUp();
	};
	this.InitGame();
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
	stead.SteadDispatcher.win.scrollTop = 0;
	$('#win').perfectScrollbar('update');;
	$('#inventory').perfectScrollbar('update');;
};
stead.SteadDispatcher.click = $hx_exports.stead.SteadDispatcher.click = function(ref,field,onstead) {
	if(onstead == null) onstead = false;
	if(stead.MenuDispatcher.Instance().visible) return;
	if(!onstead && (stead.SteadDispatcher.act || field == stead.EField.Inv[1])) {
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
				stead.UseIndicator.Instance().PowerOff();
				stead.SteadDispatcher.thing = "";
				stead.SteadDispatcher.refreshInterface();
			}
		} else {
			stead.SteadDispatcher.act = true;
			stead.SteadDispatcher.thing = ref;
			stead.UseIndicator.Instance().PowerOn();
		}
	} else {
		if(stead.SteadDispatcher.act = true) {
			stead.SteadDispatcher.act = false;
			stead.UseIndicator.Instance().PowerOff();
			stead.SteadDispatcher.thing = "";
		}
		stead.SteadDispatcher.ifaceCmd("\"" + ref + "\"");
		stead.SteadDispatcher.refreshInterface();
	}
};
stead.SteadDispatcher.get_dofile = $hx_exports.stead.SteadDispatcher.get_dofile = function() {
	return stead.SteadDispatcher._dofile_path;
};
stead.SteadDispatcher.getInv = function() {
	var retVal = stead.SteadDispatcher.interpreter.call("instead.get_inv(" + Std.string(stead.ThemeParser.horizontal_inventory) + ")");
	if(retVal[0] != null) {
		var invAnswer = Std.string(retVal[0]);
		stead.SteadDispatcher.setContent("inventory",invAnswer,stead.EField.Inv);
	} else stead.SteadDispatcher.setContent("inventory","",stead.EField.Inv);
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
	if(stead.SteadDispatcher.track.src.indexOf(path) == -1) {
		stead.SteadDispatcher.track.src = stead.SteadDispatcher._dofile_path + path;
		var i = 1;
	}
};
stead.SteadDispatcher.ifaceCmd = function(command) {
	var retVal = stead.SteadDispatcher.interpreter.call("iface.cmd(iface, " + command + ")");
	if(retVal != null && retVal[0] != null) {
		var cmdAnswer = Std.string(retVal[0]);
		var rc = retVal[1];
		if(cmdAnswer != "") stead.SteadDispatcher.setContent("text",cmdAnswer,stead.EField.Text);
	}
};
stead.SteadDispatcher.setContent = function(id,content,field) {
	var d = window.document.getElementById(id);
	if(d == null) js.Lib.alert("Unknown element : " + id);
	d.innerHTML = "<pre>" + stead.SteadDispatcher.normalizeContent(content,field) + "</pre>";
};
stead.SteadDispatcher.normalizeContent = function(input,field) {
	var output = "";
	var r = new EReg("<a(:)([\\w+\\d+ ]+)>(<i>|)((&#160;)+)","g");
	output = r.replace(input,"$4<a href=\"javascript:stead.SteadDispatcher.click('#$2', " + field[1] + ")\">$3");
	r = new EReg("<a(:)([\\w+\\d+ ]+)","g");
	output = r.replace(output,"<a href=\"javascript:stead.SteadDispatcher.click('#$2', " + field[1] + ")\"");
	r = new EReg("<w:([^>]+)>","g");
	output = r.replace(output,"<span class=\"nowrap\">$1</span>");
	return output;
};
stead.SteadDispatcher.prototype = {
	InitGame: function() {
		stead.SteadDispatcher.interpreter.load("web.lua");
		stead.SteadDispatcher.interpreter.load("stead.lua");
		stead.SteadDispatcher.interpreter.load("gui.lua");
		stead.SteadDispatcher.interpreter.load("web_store.lua");
		stead.SteadDispatcher._dofile_path = "./" + stead.ThemeParser.game_folder + "/";
		stead.SteadDispatcher.interpreter.load(stead.SteadDispatcher._dofile_path + "main.lua");
		stead.SteadDispatcher.interpreter.call("game.ini(game)");
	}
	,OnSaveClick: function(e) {
		stead.SteadDispatcher.ifaceCmd("\"save " + "backup_01" + "\"");
		stead.MenuDispatcher.Instance().HideUp();
	}
	,OnLoadClick: function(e) {
		stead.SteadDispatcher.interpreter.clear();
		this.InitGame();
		stead.SteadDispatcher.ifaceCmd("\"load " + "backup_01" + "\"");
		stead.SteadDispatcher.refreshInterface();
		stead.MenuDispatcher.Instance().HideUp();
	}
	,OnSteadClick: function(e) {
		if(!js.Boot.__instanceof(e.target,HTMLAnchorElement) && !js.Boot.__instanceof(e.target,HTMLSpanElement) && stead.SteadDispatcher.act) stead.SteadDispatcher.click("",0,true);
	}
	,__class__: stead.SteadDispatcher
};
stead.ThemeParser = function() {
	this.theme = new haxe.ds.StringMap();
};
stead.ThemeParser.__name__ = true;
stead.ThemeParser.Instance = function() {
	if(stead.ThemeParser.instance == null) stead.ThemeParser.instance = new stead.ThemeParser();
	return stead.ThemeParser.instance;
};
stead.ThemeParser.prototype = {
	Parse: function() {
		var theme_file = haxe.Http.requestUrl("gamesource/theme.ini").split("\n");
		var _g = 0;
		while(_g < theme_file.length) {
			var line = theme_file[_g];
			++_g;
			var pair = line.split(" = ");
			if(pair.length == 2) this.theme.set(pair[0],pair[1]);
		}
		if(this.theme.exists("inv.mode") && this.theme.get("inv.mode").indexOf("vertical") != -1) stead.ThemeParser.horizontal_inventory = false;
	}
	,__class__: stead.ThemeParser
};
stead.UseIndicator = function() {
	this.cog = window.document.getElementById("cog");
};
stead.UseIndicator.__name__ = true;
stead.UseIndicator.Instance = function() {
	if(stead.UseIndicator.instance == null) stead.UseIndicator.instance = new stead.UseIndicator();
	return stead.UseIndicator.instance;
};
stead.UseIndicator.prototype = {
	PowerOn: function() {
		this.cog.style.visibility = "visible";
	}
	,PowerOff: function() {
		this.cog.style.visibility = "hidden";
	}
	,__class__: stead.UseIndicator
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
Main.SlotName = "backup_01";
Main.DEFAULT_MENU_BTN = "gamesource/theme/menu.png";
stead.SteadDispatcher._dofile_path = "";
stead.SteadDispatcher.interpreter = new Interpreter();
stead.SteadDispatcher.act = false;
stead.SteadDispatcher.thing = "";
stead.SteadDispatcher.track = new Audio();
stead.ThemeParser.game_folder = "gamesource";
stead.ThemeParser.horizontal_inventory = true;
stead.ThemeParser.left_inventory = false;
Main.main();
})(typeof window != "undefined" ? window : exports);
