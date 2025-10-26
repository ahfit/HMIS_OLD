//<![CDATA[
var Spry; if (!Spry) Spry = {}; if (!Spry.Utils) Spry.Utils = {};

 

// We need an unload listener so we can store the data when the user leaves the page
// SpryDOMUtils.js only provides us with a load listener so we create this function

 

Spry.Utils.addUnLoadListener = function(handler /* function */)
{
    if (typeof window.addEventListener != 'undefined')
        window.addEventListener('unload', handler, false);
    else if (typeof document.addEventListener != 'undefined')
        document.addEventListener('unload', handler, false);
    else if (typeof window.attachEvent != 'undefined')
        window.attachEvent('onunload', handler);
};


Spry.Utils.Cookie = function(type /* String*/, name /* String */, value /* String or number */, options /* object */){
    var name = name + '=';
       
    if(type == 'create'){
        // start cookie String creation
        var str = name + value;
       
        // check if we have options to add
        if(options){
            // convert days and create an expire setting
            if(options.days){
                var date = new Date();
                str += '; expires=' + (date.setTime(date.getTime() + (options.days * 86400000 /* one day 24 hours x 60 min x 60 seconds x 1000 milliseconds */))).toGMTString();
            }
            // possible path settings
            if(options.path){
                str += '; path=' + options.path               
            }
            // allow cookies to be set per domain
            if(options.domain){
                str += '; domain=' + options.domain;
            }
        } else {
            // always set the path to /
            str += '; path=/';
        }
        // set the cookie
        document.cookie = str;
    } else if(type == 'read'){
        var c = document.cookie.split(';'),
            str = name,
            i = 0,
            length = c.length;
       
        // loop through our cookies
        for(; i < length; i++){
            while(c[i].charAt(0) == ' ')
                c[i] = c[i].substring(1,c[i].length);
                if(c[i].indexOf(str) == 0){
                    return c[i].substring(str.length,c[i].length);
                }
        }
        return false;
    } else {
        // remove the cookie, this is done by settings an empty cookie with a negative date
        Spry.Utils.Cookie('create',name,null,{days:-1});
    }
};


//]]>