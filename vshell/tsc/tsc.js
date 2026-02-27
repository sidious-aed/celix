//alert("i sim.");
let nodes = [];
let naof_nodes = 0;
let tsc_pad = [];
let update_dom = function() {
	nodes = simnodes(all_nodes());
	naof_nodes = nodes.length;
	//alert("naof-nodes | " + naof_nodes);Gjs-Message
}
let update_tsc_pad = function() {
	//alert("i sim.");
	//alert("" + tsc_pad);
	let tsc_node = filter_nodes(nodes, [{name: "id", value: "tsc-0shell"}])[0];
	//alert("tsc-node | " + tsc_node);
	let paras_html = ""
	let naof_types = tsc_pad.length;
	//alert("naof-types | " + naof_types);
	let psite = 0;
	while(true) {
		if(psite == naof_types) {
			break;
		}
		//alert("psite | " + psite);
		let para = "<p class=\"tsc-type\" id=\"type-" + psite + "\">"
		para += psite;
		para += " | ";
		para += tsc_pad[psite];
		para += "</p>"
		//alert("para | " + para);
		paras_html += para;
		//alert("para-html | " + para_html);
		psite += 1;
	}
	//alert("para-html | " + para_html);
	tsc_node.innerHTML = paras_html;
	//alert("i sim.");
	update_dom();
	let type_nodes = filter_nodes(nodes, [{name: "class", value: "tsc-type"}]);
	let naof_type_nodes = type_nodes.length;
	//alert("naof-type-nodes | " + naof_type_nodes);
	let tsite = 0;
	while(true) {
		if(tsite == naof_type_nodes) {
			break;
		}
		let typen = type_nodes[tsite];
		//alert("typen | " + typen);
		typen.onclick = function() {
			//alert("i sim.");
			//alert("clicked | " + this.innerHTML);
			let id = get_attribute(this, "id");
			let click_com = filter_nodes(nodes, [{name: "id", value: "clerk-com"}])[0];
			let out_text = this.innerText;
			let naof_out_secs = out_text.length;
			let osite = 0;
			while(true) {
				if(osite == naof_out_secs) {
					break;
				}
				if(out_text[osite] == "|") {
					osite += 2;
					break;
				}
				osite += 1;
			}
			click_com.innerText = "" + this.innerText.slice(osite, naof_out_secs);
		}
		tsite += 1;
	}
}
let reset_click_com = function() {
	let click_com = filter_nodes(nodes, [{name: "id", value: "clerk-com"}])[0];
	click_com.innerHTML = "";
}
update_dom();
