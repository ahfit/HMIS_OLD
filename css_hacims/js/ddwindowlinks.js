
var ddwindowlinks={

excludedomains: ["dynamicdrive.com", "google.com"],


linktarget: "_blank",


mode: "auto",


toggleHTML: '<form><input type="checkbox" id="targetcheckbox" checked="checked" /><label for="targetcheckbox">Open off-site links in new window?</label></form>',

persist: true,

assigntarget:function(){
	var rexcludedomains=new RegExp(this.excludedomains.join("|"), "i")
	var all_links=document.getElementsByTagName("a")
	if (this.mode=="auto" || (this.mode=="manual" && this.togglebox.checked)){
		for (var i=0; i<=(all_links.length-1); i++){
			if (all_links[i].hostname.search(rexcludedomains)==-1 && all_links[i].href.indexOf("http:")!=-1)
				all_links[i].target=ddwindowlinks.linktarget
		}
	}
	else{
		for (var i=0; i<=(all_links.length-1); i++)
			all_links[i].target=""
	}
	if (this.mode=="manual" && this.persist)
		this.setCookie("dlinktarget", (this.togglebox.checked)? "yes" : "no", 30)
},

init:function(){
	if (document.getElementById && this.mode=="manual"){
		document.write(this.toggleHTML)
		this.togglebox=document.getElementById("targetcheckbox")
		this.togglebox.onclick=function(){ddwindowlinks.assigntarget()}
		if (this.persist && this.getCookie("dlinktarget")!="")
			this.togglebox.checked=(this.getCookie("dlinktarget")=="yes")? true : false
	}
	if (window.addEventListener)
		window.addEventListener("load", function(){ddwindowlinks.assigntarget()}, false)
	else if (window.attachEvent)
		window.attachEvent("onload", function(){ddwindowlinks.assigntarget()})
},

getCookie:function(Name){
	var re=new RegExp(Name+"=[^;]+", "i");
	if (document.cookie.match(re)) 
		return document.cookie.match(re)[0].split("=")[1] 
	return ""
},

setCookie:function(name, value, days){
	var expireDate = new Date()

		var expstring=expireDate.setDate(expireDate.getDate()+parseInt(days))
		document.cookie = name+"="+value+"; expires="+expireDate.toGMTString()+"; path=/"
}

}

ddwindowlinks.init()