(function () { "use strict";
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
stead.EField = { __ename__ : true, __constructs__ : ["Text","Ways","Title","Inv"] }
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
	stead.SteadDispatcher._dofile_path = "./gamesource/";
	stead.SteadDispatcher.interpreter.load(stead.SteadDispatcher._dofile_path + "main.lua");
	stead.SteadDispatcher.interpreter.call("game.ini(game)");
	stead.SteadDispatcher.canvas = js.Browser.document.getElementById("canvas");
	stead.SteadDispatcher.look();
};
stead.SteadDispatcher.__name__ = true;
stead.SteadDispatcher.look = function() {
	stead.SteadDispatcher.ifaceCmd("\"look\"");
	stead.SteadDispatcher.refreshInterface();
}
stead.SteadDispatcher.refreshInterface = function() {
	stead.SteadDispatcher.getTitle();
	stead.SteadDispatcher.getWays();
	stead.SteadDispatcher.getInv();
	stead.SteadDispatcher.getPicture();
	stead.SteadDispatcher.getMusic();
}
stead.SteadDispatcher.click = function(ref,field) {
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
}
$hxExpose(stead.SteadDispatcher.click, "stead.SteadDispatcher.click");
stead.SteadDispatcher.get_dofile = function() {
	return stead.SteadDispatcher._dofile_path;
}
$hxExpose(stead.SteadDispatcher.get_dofile, "stead.SteadDispatcher.get_dofile");
stead.SteadDispatcher.getInv = function() {
	var retVal = stead.SteadDispatcher.interpreter.call("instead.get_inv(true)");
	if(retVal[0] != null) {
		var invAnswer = Std.string(retVal[0]);
		stead.SteadDispatcher.setContent("inventory",invAnswer,stead.EField.Inv);
	}
}
stead.SteadDispatcher.getWays = function() {
	var waysAnswer = Std.string(stead.SteadDispatcher.interpreter.call("instead.get_ways()")[0]);
	stead.SteadDispatcher.setContent("ways",waysAnswer,stead.EField.Ways);
}
stead.SteadDispatcher.getTitle = function() {
	var waysAnswer = Std.string(stead.SteadDispatcher.interpreter.call("instead.get_title()")[0]);
	stead.SteadDispatcher.setContent("title","<a href=\"javascript:stead.SteadDispatcher.click('#look', " + stead.EField.Title[1] + ")\">" + waysAnswer + "</a>",stead.EField.Title);
}
stead.SteadDispatcher.getPicture = function() {
	var retVal = stead.SteadDispatcher.interpreter.call("instead.get_picture()");
	if(retVal[0] != null) {
		var picture_path = Std.string(retVal[0]);
		stead.SteadDispatcher.showPicture(picture_path);
	}
}
stead.SteadDispatcher.getMusic = function() {
	var retVal = stead.SteadDispatcher.interpreter.call("instead.get_music()");
	if(retVal[0] != null) {
		var music_path = Std.string(retVal[0]);
		stead.SteadDispatcher.playMusic(music_path);
	}
}
stead.SteadDispatcher.showPicture = function(path) {
	console.log(path);
	var image = new Image();
	image.style.left = "0px";
	image.style.top = "0px";
	image.onload = stead.SteadDispatcher.copyAccross;
	image.style.position = "absolute";
	image.src = stead.SteadDispatcher._dofile_path + path;
}
stead.SteadDispatcher.copyAccross = function(e) {
	var image = e.currentTarget;
	stead.SteadDispatcher.canvas.getContext("2d").clearRect(0,0,stead.SteadDispatcher.canvas.width,stead.SteadDispatcher.canvas.height);
	stead.SteadDispatcher.canvas.width = image.width;
	stead.SteadDispatcher.canvas.height = image.height;
	stead.SteadDispatcher.canvas.getContext("2d").drawImage(image,0,0,image.width,image.height);
}
stead.SteadDispatcher.playMusic = function(path) {
	console.log(path);
}
stead.SteadDispatcher.ifaceCmd = function(command) {
	var retVal = stead.SteadDispatcher.interpreter.call("iface.cmd(iface, " + command + ")");
	if(retVal[0] != null) {
		var cmdAnswer = Std.string(retVal[0]);
		var rc = retVal[1];
		if(cmdAnswer != "" && rc) stead.SteadDispatcher.setContent("text",cmdAnswer,stead.EField.Text);
	}
}
stead.SteadDispatcher.setContent = function(id,content,field) {
	var d = js.Browser.document.getElementById(id);
	if(d == null) js.Lib.alert("Unknown element : " + id);
	d.innerHTML = "<pre>" + stead.SteadDispatcher.normalizeContent(content,field) + "</pre>";
}
stead.SteadDispatcher.normalizeContent = function(input,field) {
	var output = "";
	var r = new EReg("<a(:)([\\w+\\d+ ]+)","g");
	output = r.replace(input,"<a href=\"javascript:stead.SteadDispatcher.click('#$2', " + field[1] + ")\"");
	r = new EReg("<w:([^>]+)>","g");
	output = r.replace(output,"<span class=\"nowrap\">$1</span>");
	return output;
}
String.__name__ = true;
Array.__name__ = true;
var q = window.jQuery;
js.JQuery = q;
js.Browser.document = typeof window != "undefined" ? window.document : null;
stead.SteadDispatcher._dofile_path = "";
stead.SteadDispatcher.interpreter = new Interpreter();
stead.SteadDispatcher.act = false;
stead.SteadDispatcher.thing = "";
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
