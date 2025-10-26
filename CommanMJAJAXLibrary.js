/* IN THE NAME OF ALLAH */

/* 	This is common MJ AJAX Library it support DOM Level 1,2,3
	
	Creation Date:	15 December , 2006
	Modify Date:	19 December , 2006
	
	Created By:		Muhammad Jahangir(Software Engineer) 
					Oratier Technologies (PVT.) LTD.
					0333-4383202
					
	Description:    Its free for reuse but i hope u not spread it with different lable.
	                for more detail or advise mail me pakistan_4u@hotmail.com
	                 
*/

/* This is a function which create xml http resquest object */

function createXmlObject()
{
    if(window.XMLHttpRequest)
	{
		
		xmlObject = new XMLHttpRequest();
		
	}
	else
		{
			try
			{
				xmlObject = new ActiveXObject("Microsoft.XMLHTTP");
			} catch(e)
			{
				xmlObject = new ActiveXObject("Msxml12.XMLHTTP");
			}
		
        }
        return xmlObject;
}
/* These are 4 states of xml request object */

var UNINITIALIZED = 0;
var LOADING = 1;
var LOADED = 2;
var INTRACTIVE = 3;
var COMPLETE = 4;

/* This is for http OK status */

var OK = 200;

/* This is for web services */

var WSCT = "Content-Type";
var WSA = "application/x-www-form-urlencoded";