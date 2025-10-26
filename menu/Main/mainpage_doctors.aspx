<%@ page language="VB" autoeventwireup="false" inherits="mainpage_doctors, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HACIMS - +</title>

<link href="images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="images/sheet_form.css" rel="stylesheet" type="text/css" />


<script src="images/highlight.js" type="text/javascript"></script>

<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;}

body{ line-height:15px;

SCROLLBAR-FACE-COLOR: #e3e3e3; 

SCROLLBAR-HIGHLIGHT-COLOR: #fff; 
SCROLLBAR-SHADOW-COLOR: #ccc; 
SCROLLBAR-3DLIGHT-COLOR: #ccc; 
SCROLLBAR-ARROW-COLOR: #333; 
SCROLLBAR-TRACK-COLOR: #f2f2f2; 
SCROLLBAR-DARKSHADOW-COLOR: #9ea1a3; 
BACKGROUND-COLOR: #f3f3f3;

 }


* html legend { margin:0px 0px 0px 0; padding:0; }
#searchbox {width:100%; height:35px; background-color:#e4e4e4; border:#d7d7d7 solid 1px; margin-bottom:8px; margin-top:8px;}

#upper_portion {width:936px; height:300px; display:block; }

#col_1 { display:block; width:306px; height:300px; float:left; clear:right;   }
#col_2 { display:block; width:306px; height:300px; float:left; clear:right; margin-left:7px; }
#col_3 { display:block; width:306px; height:300px; float:left; clear:right; margin-left:7px;}

#col_1b { display:block; width:306px; height:300px; float:left; clear:right;     }
#col_2b { display:block; width:306px; height:300px; float:left; clear:right; margin-left:7px;     }
#col_3b { display:block; width:306px; height:300px; float:left; clear:right; margin-left:7px;     }

#lower_portion {width:100%; height:250px; display:block; margin-top:10px; }



#scroll_bar { height:200px; width:285px; overflow:scroll; overflow-x:hidden;}




#main{width:306px; height:auto; margin:0 auto 0 auto; margin-top:0px; background-image:url(images/mid.gif); background-position:top; background-repeat:repeat-y;    }

a {outline:none;}

UL.blue {

CLEAR: left; 
PADDING-RIGHT: 0px; 
MARGIN-TOP: 3px; 
PADDING-LEFT: 0px; 
FLOAT: left;  /*disign prob*/
PADDING-BOTTOM: 0px; 
MARGIN-LEFT: 5px; 
COLOR: #333; 
PADDING-TOP: 0px; 
FONT-FAMILY: tahoma; 
LIST-STYLE-TYPE: none; 
HEIGHT: 25px;    

}

UL.blue LI { 

PADDING-RIGHT: 0px;  
PADDING-LEFT: 0px; 
PADDING-BOTTOM: 0px; 
MARGIN: 0px; 
PADDING-TOP: 0px; 
color:#999999; 
border-bottom:#999 solid 1px; 
display:block;
height:25px; 
line-height:22px;  

}

UL.blue LI span { PADDING-RIGHT: 10px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px;    }



UL.blue LI A {

PADDING-RIGHT: 15px; 
PADDING-LEFT: 0px; 
FONT-WEIGHT: bold; 
FONT-SIZE: 11px; 
BACKGROUND: url(images/bar.gif) no-repeat right top; 
FLOAT: left; /* disign prob style="height:400px; overflow:scroll; overflow-x:hidden; width:99%; overflow:hidden; "*/
PADDING-BOTTOM: 0px; 
COLOR: #333; 
LINE-HEIGHT: 14px; 
MARGIN-RIGHT: 2px; 
PADDING-TOP: 4px; 
FONT-FAMILY: tahoma; 
HEIGHT: 22px; 
TEXT-DECORATION: none; 
outline: none;   
}

UL.blue LI A SPAN { PADDING-RIGHT: 15px; MARGIN-TOP: -4px; DISPLAY: block; BACKGROUND: url(images/bar.gif) no-repeat left top; FLOAT: left; HEIGHT: 23px; }
UL.blue LI A:hover { BACKGROUND: url(images/bar2.gif) no-repeat right top; COLOR: #fff; }
UL.blue LI A:hover SPAN { BACKGROUND: url(images/bar2.gif) no-repeat left top; }
UL.blue LI.current A { 	BACKGROUND: url(images/bar.gif) no-repeat right top; COLOR: #333; }
UL.blue LI.current A SPAN { BACKGROUND: url(images/bar.gif) no-repeat left top; }
UL.blue LI.confirm A { 	BACKGROUND: url(images/bar_c.gif) no-repeat right top; COLOR: #fff; }
UL.blue LI.confirm A SPAN { BACKGROUND: url(images/bar_c.gif) no-repeat left top; }



UL.blue2 {

CLEAR: left; 
PADDING-RIGHT: 0px; 
MARGIN-TOP: 3px; 
PADDING-LEFT: 0px; 
FLOAT: left;  /*disign prob*/
PADDING-BOTTOM: 0px; 
MARGIN-LEFT: 5px; 
COLOR: #333; 
PADDING-TOP: 0px; 
FONT-FAMILY: tahoma; 
LIST-STYLE-TYPE: none; 
HEIGHT: 25px;   

}

UL.blue2 LI { 

PADDING-RIGHT: 0px;  
PADDING-LEFT: 0px; 
PADDING-BOTTOM: 0px; 
MARGIN: 0px; 
PADDING-TOP: 0px; 
color:#999999; 
border-bottom:#999 solid 1px; 
display:inline;
height:25px; 
line-height:22px;  

}

UL.blue2 LI span { PADDING-RIGHT: 10px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px;   }



UL.blue2 LI A {

PADDING-RIGHT: 15px; 
PADDING-LEFT: 0px; 
FONT-WEIGHT: bold; 
FONT-SIZE: 11px; 
BACKGROUND: url(images/bar.gif) no-repeat right top; 
FLOAT: left; /* disign prob style="height:400px; overflow:scroll; overflow-x:hidden; width:99%; overflow:hidden; "*/
PADDING-BOTTOM: 0px; 
COLOR: #fff; 
LINE-HEIGHT: 14px; 
MARGIN-RIGHT: 2px; 
PADDING-TOP: 4px; 
FONT-FAMILY: tahoma; 
HEIGHT: 22px; 
TEXT-DECORATION: none; 
outline: none;  
}

UL.blue2 LI A SPAN { PADDING-RIGHT: 15px; MARGIN-TOP: -4px; DISPLAY: inline; BACKGROUND: url(images/bar.gif) no-repeat left top; FLOAT: left; HEIGHT: 23px; }
UL.blue2 LI A:hover { BACKGROUND: url(images/bar2.gif) no-repeat right top; COLOR: #fff; }
UL.blue2 LI A:hover SPAN { BACKGROUND: url(images/bar2.gif) no-repeat left top; }
UL.blue2 LI.current A { 	BACKGROUND: url(images/bar2.gif) no-repeat right top; COLOR: #333; }
UL.blue2 LI.current A SPAN { BACKGROUND: url(images/bar2.gif) no-repeat left top; }



h1{font-family:tahoma; font-weight:bold; color:#0033CC; font-size:11px; padding:0px; margin:0px; float:left; clear:right; } 
h2{font-family:tahoma; font-weight:normal; color:#999999; font-size:11px;  padding:0px; margin:0px; margin-top:5px; 
padding-bottom:15px; float:left; clear:both; } 

h3{padding:0px; margin:0px; float:right;  }  

.plus1{ outline:none; position:absolute; float:right; margin-top:75px; margin-left:168px; background-image:url(images/plus.gif); background-position:right; background-repeat:no-repeat; display:block; width:8px; height:8px; cursor:pointer;   }  

.minus1{ outline:none; position:absolute; float:right; margin-top:75px; margin-left:155px; background-image:url(images/minus.gif); background-position:right; background-repeat:no-repeat; display:block; width:8px; height:8px; cursor:pointer; }  



.plus{ outline:none; float:right;  background-image:url(images/plus.gif); background-position:right; background-repeat:no-repeat; display:block; width:8px; height:8px; cursor:pointer; margin-right:5px; margin-top:-10px;   }  

.minus{ outline:none; float:right;    background-image:url(images/minus.gif); background-position:right; background-repeat:no-repeat; display:block; width:8px; height:8px; cursor:pointer;  margin-top:-10px;}  



.plus1{ outline:none; position:absolute; float:right; margin-top:75px; margin-left:168px; background-image:url(images/plus.gif); background-position:right; background-repeat:no-repeat; display:block; width:8px; height:8px; cursor:pointer;   }  

.minus1{ outline:none; position:absolute; float:right; margin-top:75px; margin-left:155px; background-image:url(images/minus.gif); background-position:right; background-repeat:no-repeat; display:block; width:8px; height:8px; cursor:pointer; }  





.line{border-bottom:#d1d1d1  solid 1px;  display:block; width:100%; margin-bottom:10px; margin-top:-7px; }
.line2{border-bottom:#999999 solid 2px; display:block; width:100%; margin-bottom:0px;  margin-top:-16px; padding:0px; }

image {border:none;}




#main_box{width:306px; margin:0 auto 0 auto; margin-top:0px; background-image:url(images/mid.gif); background-position:top; background-repeat:repeat-y; }

.mytab_1 {margin:0px; padding:0px; padding:12px; }
.mytab_1 ul  { margin:0px; padding:0px; margin-left:-25px; }
.mytab_1 li { list-style:none; font-weight:normal; color:#333333; display:block; text-align:justify; margin-top:5px; border-bottom:#CCCCCC solid 1px; padding-bottom:7px; }
.mytab_1 li span { color:#1d96f3; font-weight:bold; }
.mytab_1 li .txt { color:#333; display:block; font-weight:normal; text-align:justify; margin-top:5px;    }
.mytab_1 li .txt_b { color:#333; display:block; font-weight:bold; text-align:justify; margin-top:5px;    }
.mytab_1 li .date { color:#999999; font-weight:normal; text-align:left; float:right; margin-top:-13px;     }



UL.blue1 {
	CLEAR: left; PADDING-RIGHT: 0px; MARGIN-TOP: 0px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; MARGIN-LEFT: 10px; COLOR: #333; PADDING-TOP: 0px; FONT-FAMILY: tahoma; LIST-STYLE-TYPE: none; HEIGHT: 22px;  
}
UL.blue1 LI {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; FLOAT: left; PADDING-BOTTOM: 0px; MARGIN: 0px; PADDING-TOP: 0px;
}
UL.blue1 LI A {
	PADDING-RIGHT: 15px; PADDING-LEFT: 0px; FONT-WEIGHT: bold; FONT-SIZE: 11px; BACKGROUND: url(images/tb_normal.gif) no-repeat right top; FLOAT: left; PADDING-BOTTOM: 0px; COLOR: #fff; LINE-HEIGHT: 14px; MARGIN-RIGHT: 2px; PADDING-TOP: 4px; FONT-FAMILY: tahoma; HEIGHT: 22px; TEXT-DECORATION: none; outline: none; 
}
UL.blue1 LI A SPAN {
	PADDING-RIGHT: 15px; MARGIN-TOP: -4px; DISPLAY: block; BACKGROUND: url(images/tb_normal.gif) no-repeat left top; FLOAT: left; HEIGHT: 22px;
}
UL.blue1 LI A:hover {
	BACKGROUND: url(images/tb_hover.gif) no-repeat right top; COLOR: #333;
}
UL.blue1 LI A:hover SPAN {
	BACKGROUND: url(images/tb_hover.gif) no-repeat left top;
}
UL.blue1 LI.current A {
	BACKGROUND: url(images/tb_hover.gif) no-repeat right top; COLOR: #333;
}
UL.blue1 LI.current A SPAN {
	BACKGROUND: url(images/tb_hover.gif) no-repeat left top;
}

.hd{font-family:arial; font-size:13px; color:#4838e2; font-weight:bold; padding-left:15px; border-bottom:#CCCCCC solid 1px; display:block; padding-bottom:5px;   }


</style>

<script src="SpryAssets/new_spry/SpryCollapsiblePanel.js" type="text/javascript"></script>
<link href="SpryAssets/new_spry/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />

<script src="SpryAssets/new_spry/SpryTabbedPanels.js" type="text/javascript"></script>
<link href="SpryAssets/new_spry/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />


</head>

<body><form id="form1" runat = "server">

<div id="inner_content">				

<div id="main_col"> 	

<div class="mainbox">
<span class="mainboxtop"></span>
<span class="mid_data"  >

<h1 style="display:none;" class="heading_1">Administration &raquo; <span>Doctor Main Area</span></h1>
<br class="break"  />

<div id="searchbox" style="display:none;"></div><!--searchbox end-->

<div id="upper_portion">

<div id="col_1"> <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></div><!--col_1 end-->
<div id="col_2"><asp:Label ID="Label2" runat="server" Text="Label" ></asp:Label></div><!--col_2 end-->
<div id="col_3"><asp:Label ID="Label3" runat="server" Text="Label" ></asp:Label></div><!--col_3 end-->

</div><!--end upper_portion-->


<div id="lower_portion">

<div id="col_1b">

<iframe src="news_bbc.html" name="news" marginwidth="0"  marginheight="0" 
scrolling="no" frameborder="0" id="news_1" allowtransparency="true" style="width:306px; height:300px;" ></iframe>



</div><!--col_1b end-->

<div id="col_2b">

<div id="main_box">

<span style="display:block; margin-top:0px;"><img src="images/top.gif" /></span>

<div id="TabbedPanels1" class="TabbedPanels blue1">
<ul class="TabbedPanelsTabGroup blue1">
    <li class="TabbedPanelsTab" tabindex="0" ><a href="#"><span></span>Messages</a></li>
    <li class="TabbedPanelsTab" tabindex="0"><a href="#"><span></span>Meetings</a></li>
    <li class="TabbedPanelsTab" tabindex="0"><a href="#"><span></span>Reports</a></li>
   
</ul>

<div class="TabbedPanelsContentGroup" style="margin-top:-4px; height:259px; overflow:scroll; overflow-x:hidden;  ">
<div class="TabbedPanelsContent" >
<asp:Label ID="Label_Message" runat="server" Text="Label"></asp:Label>
</div>
<div class="TabbedPanelsContent">
<asp:Label ID="LabelMeeting" runat="server" Text="Label"></asp:Label>
</div>
<div class="TabbedPanelsContent">
<asp:Label ID="LabelReport" runat="server" Text="Label"></asp:Label>
</div>


</div>
</div>

<span style=" display:block; margin-bottom:0px;"><img src="images/bot.gif" /></span>
</div><!--main end-->





</div><!--col_2b end-->


<div id="col_3b">

<div id="main">
<div id="main_box">

<span style="display:block; margin-top:0px;"><img src="images/top.gif" /></span>

<span class="hd">Patient Appointment&nbsp;+&nbsp;</span>

<iframe src="patient registration/patientappointmant_box.aspx" name="news" marginwidth="0"  marginheight="0" 
scrolling="no" frameborder="0" id="news_1" allowtransparency="true" style="width:306px; height:262px;" ></iframe>

<span style="display:block; margin-bottom:0px;"><img src="images/bot.gif" /></span>

</div>
</div><!--main end-->





</div><!--col_3b end-->









</div><!--end lower_portion-->





<br />
<br class="break"/>

</span>
<span class="mainboxbottom"></span>

<!--mainbox end--></div>
<!--main_col end--></div>

<!--inner_content end--></div>



</form>

    <asp:Label ID="LabelEnd" runat="server" ></asp:Label>
<script type="text/javascript">
<!--
var TabbedPanels1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
//-->
</script>

</body>
</html>