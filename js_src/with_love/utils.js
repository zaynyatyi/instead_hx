var kUseHTMLConsole = false; // if false, output is still visible in firefox javascript console

var gNotImplementedAlreadyPrinted = {};
var gMaxHTMLConsoleLines = 10;

/// output in html, for fatal error messages etc, also users that don't have webdev console open can see them
function MainPrintToHTMLConsole () {
	if (gMaxHTMLConsoleLines == 0) return;
	--gMaxHTMLConsoleLines;
	try {
		console.log.apply(console, arguments); // javascript console, e.g. firefox
	} catch (e) {
		// do nothing
	}
	var element = document.getElementById('output');
	if (!element) return; // perhaps during startup
	element.innerHTML += "<br/>\n";
	for (var i = 0; i < arguments.length; ++i) element.innerHTML += String(arguments[i]) + " ";
	element.innerHTML += "<hr/>\n";
	if (gMaxHTMLConsoleLines == 0) element.innerHTML += "<br/>\n...";
}

/// debug output (usually just on webdev console)
function MainPrint () {
	if (kUseHTMLConsole) {
		var element = document.getElementById('output');
		if (!element) return; // perhaps during startup
		element.innerHTML += "<br/>\n";
		for (var i = 0; i < arguments.length; ++i) element.innerHTML += String(arguments[i]) + " ";
	} else {
		try {
			console.log.apply(console, arguments); // javascript console, e.g. firefox
		} catch (e) {
			// do nothing
		}
	}
}

/// dummy/stub for love api functions that haven't been implemented yet
function NotImplemented (name) { 
	if (!gNotImplementedAlreadyPrinted[name]) {
		gNotImplementedAlreadyPrinted[name] = true;
		MainPrint("NotImplemented:"+String(name)); 
	}
	return LuaNil;
}

// ***** ***** ***** ***** ***** ajax

// see http://www.w3.org/TR/XMLHttpRequest			sQuery = "bla.php?x="+escape(x)
function UtilAjaxGet (sQuery,callback,bSynchronous) {
	var bAsync = true;
	if (bSynchronous) bAsync = false;
	var client;
	if (window.XMLHttpRequest) 
			client = new XMLHttpRequest(); // code for IE7+, Firefox, Chrome, Opera, Safari
	else	client = new ActiveXObject("Microsoft.XMLHTTP");	// code for IE6, IE5
	client.onreadystatechange = function() {
		if (this.readyState == this.DONE) {
			//~ document.getElementById("output").innerHTML += "<br>"+"MyAjaxGet status="+String(this.status)+" statusText="+escape(String(this.statusText));
			if (this.status==200) {
				callback(this.responseText);
			} else {
				callback(null,this.status);
			}
		}
	}
	client.open("GET",sQuery,bAsync);
	//~ client.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");
	client.send();
}

function encode_utf8( s ) {
	return unescape( encodeURIComponent( s ) );
}

function decode_utf8( s ) {
	return decodeURIComponent( escape( s ) );
}