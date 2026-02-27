#!/usr/bin/env gjs
imports.gi.versions.Gtk = "3.0";
const {Gtk, WebKit2} = imports.gi;
const Gio = imports.gi.Gio;
const GLib = imports.gi.GLib;
const Gdk = imports.gi.Gdk;
let read_file = function(name) {
	let file = Gio.File.new_for_path(name);
	let [ok, contents] = file.load_contents(null);
	if(ok) {
		//return "";
		return ("" + contents);
	}
	return false;
}

let type_staved_clerkesses = {
	init: function(naof_pad_entrees, window, webv) {
		let tsc = {
			init: function() {
				let display = Gdk.Display.get_default();
				this.clipboard = Gtk.Clipboard.get_default(display);
				this.is_update_mode = true;
				this.clipboard.connect("owner-change", this.on_type_staved_update);
				this.clipboard.tsc = this;
				this.pad = [];
				this.com_pad_site = naof_pad_entrees;
				this.window = window;
				this.webv = webv;
			},
			set_clipboard_text: function(text) {
					this.clipboard.set_text(text, -1);
					this.clipboard.store();
			},
			get_clipboard_text: function() {
				return this.clipboard.wait_for_text();
			},
			on_type_staved_update: function(clipboard, event) {
				let tsc = clipboard.tsc
				if(tsc.is_update_mode == false) {
					return;
				}
				let new_entree = tsc.get_clipboard_text();
				log("new-entree | " + new_entree);
				let pad_site = tsc.pad.length;
				if(pad_site >= tsc.com_pad_site) {
					let naof_lets = pad_site - tsc.com_pad_site + 1;
					tsc.pad = tsc.pad.slice(naof_lets, pad_site)
				}
				if(new_entree == "") {
					return;
				}
				let is_new = true;
				let psite = 0;
				while(true) {
					if(psite == pad_site) {
						break;
					}
					if(new_entree == tsc.pad[psite]) {
						is_new = false;
						break;
					}
					psite += 1;
				}
				if(is_new == false) {
					return;
				}
				tsc.pad.push(new_entree);
				log("tsc.pad | " + tsc.pad);
				pad_site = tsc.pad.length;
				log("pad-site | " + pad_site);
				let sjs = "";
				sjs += "update_dom();";
				log("sjs | " + sjs);
				webv.run_javascript(sjs, null, (view, result) => {});
				sjs = "tsc_pad = [];"
				psite = 0;
				while(true) {
					if(psite == pad_site) {
						break;
					}
					sjs += "tsc_pad.push(\"";
					sjs += tsc.pad[psite];
					sjs += "\");"
					psite += 1;
				}
				sjs += "update_tsc_pad();"
				webv.run_javascript(sjs, null, (view, result) => {});
			}
			/*
			*/
		}
		tsc.init();
		return tsc;
	},
}

Gtk.init(null);
let provider = new Gtk.CssProvider();
provider.load_from_data(".generalp {background-color: #000000;}");
Gtk.StyleContext.add_provider_for_screen(
	Gdk.Screen.get_default(),
	provider,
	Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
);

let window = new Gtk.Window({title: "I Sim."});
window.get_style_context().add_class("generalp");
window.set_default_size(800, 600);
window.connect("destroy", Gtk.main_quit);

let webView = new WebKit2.WebView();
let css = read_file("tsc.css");
let userStyleSheet = new WebKit2.UserStyleSheet(
    css,
    WebKit2.UserContentInjectedFrames.ALL_FRAMES,
    WebKit2.UserStyleLevel.USER,
    null,
    null
);
let manager = webView.get_user_content_manager();
manager.add_style_sheet(userStyleSheet);
window.add(webView);
let html = read_file("tsc.html");
webView.load_html(html, null);
let tsc = type_staved_clerkesses.init(100, window, webView);

let js = read_file("jypsy.js");
js += read_file("tsc.js");
//log("js | " + js);
let sjs = function() {
	webView.run_javascript(js, null, (view, result) => {
		//log("in trys shell.");
		//log("view | " + view);
		//log("result | " + result);
	});
}
GLib.timeout_add(GLib.PRIORITY_DEFAULT, 111, sjs);

let get_text_attribute = function(html, name) {
	if((html == undefined) || (html == " ")) {
		return undefined;
	}
	//alert("html | " + html);
	let mode = 0;
	let symbol = "";
	let site = 0;
	while(true) {
		let add_to_symbol = true;
		let sec = html[site];
		//alert("site | " + site);
		//alert("sec | " + sec);
		if(sec == undefined) {
			return undefined;
		}
		if(sec == "<") {
			symbol = "";
			add_to_symbol = false;
		}
		if(sec == " ") {
			//alert("symbol-at-space | " + symbol);
			add_to_symbol = false;
			if(name == "node-type") {
				return symbol;
			}
			symbol = "";
		}
		if(sec == "=") {
			//alert("symbol | " + symbol);
			add_to_symbol = false;
			if(symbol == name) {
				mode = 1;
				symbol = "";
				site += 1;
			}
		}
		if(sec == "\"") {
			if(mode == 0) {
				symbol = "";
			} else {
				add_to_symbol = false;
			}
		}
		if(sec == ">") {
			if(name == "node-type") {
				return symbol;
			}
			return undefined;
		}
		if(add_to_symbol) {
			symbol += sec;
		} else if(mode == 1) {
			mode = 2;
		} else if(mode == 2) {
			return symbol;
		}
		site += 1;
	}
}

let read_com = function(html, attributes) {
	let naof_secs = html.length;
	//log("naof-secs | " + naof_secs);
	let naof_attrs = attributes.length;
	let mode = 0;
	let comh = "";
	let site = 0;
	while(true) {
		if(site == naof_secs) {
			break;
		}
		let sec = html[site];
		//log("sec | " + sec);
		if(mode == 0) {
			if(sec == "<") {
				let is_in = true;
				let asite = 0;
				while(true) {
					if(asite == naof_attrs) {
						break;
					}
					let cattr = attributes[asite];
					if(cattr.value != get_text_attribute(html.slice(site, naof_secs), cattr.name)) {
						is_in = false;
						break;
					}
					asite += 1;
				}
				if(is_in) {
					mode = 1;
				}
			}
		} else if(mode == 1) {
			if(sec == ">") {
				mode = 2;
			}
		} else if(mode == 2) {
			if(sec == "<") {
				break;
			} else {
				comh += sec;
			}
		}
		site += 1;
	}
	return comh;
}

let click_com_html = ""
let click_com = function() {
	webView.run_javascript('document.documentElement.outerHTML;', null, (view, result) => {
		let jsResult = view.run_javascript_finish(result);
		let jsValue = jsResult.get_js_value();
		click_com_html = jsValue.to_string();
	});
	//log("click-com-html | " + click_com_html);
	let click_comh = read_com(click_com_html, [{name: "id", value: "clerk-com"}]);
	//log("click-comh | " + click_comh);
	if(click_comh != "") {
		tsc.set_clipboard_text(click_comh);
		webView.run_javascript("reset_click_com();", null, (view, result) => {});
	}
	GLib.timeout_add(GLib.PRIORITY_DEFAULT, 111, click_com);
	/*
	*/
}
GLib.timeout_add(GLib.PRIORITY_DEFAULT, 111, click_com);

window.connect("key-press-event", (widget, event) => {
    let [, keyval] = event.get_keyval();
    if (keyval == Gdk.KEY_Escape) {
        log("thank you for engaging my type-\"staving\".");
        window.close();
        return true;
    }
    return false;
});
window.show_all();
Gtk.main();
