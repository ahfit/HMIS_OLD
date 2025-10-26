<%@ page language="VB" autoeventwireup="false" inherits="AdminMain, App_Web_ppbttiod" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link href="css/class_reset.css" rel="stylesheet" 	 type="text/css" />
<link href="css/class_elements.css" rel="stylesheet" type="text/css" />
<!--[if IE]><link rel="stylesheet" href="css/class_ie.css" type="text/css" media="screen, projection"><![endif]-->
<!--[if lte IE 6]><script type="text/javascript" src="css/js/fixn.js"></script><![endif]-->



<link rel="icon" href="favicon.ico" type="image/x-icon">

<link href="menu/style-office-1.css" rel="stylesheet" type="text/css"/>

<script language="JavaScript">
function Page_Name()
{
     var page_url=document.getElementById("HiddenFieldPage_Name").value;
     var page=document.getElementById("HiddenFieldPage").value;
     changeIframeSrc('holder1',page_url,page);
     //Focus();
}
function calcHeight1()
{ 
    var the_height1=
    document.getElementById('holder1').contentWindow.
    document.body.scrollHeight;
    document.getElementById('holder1').height=
    the_height1;
}

</script>

<script type="text/javascript">
// <![CDATA[

function changeIframeSrc(id, url, text)
 { //alert(url);
     document.getElementById("Text1").value=text; 
    if (!document.getElementById) return;
    var el = document.getElementById(id);
    if (el && el.src) {
        el.src = url;
        return false;
    }
    return true;
}
// ]]>

//function Focus()
//{
//document.getElementById("holder1").focus();onload="Page_Name()"

//}
</script>




<style type="text/css"> 

.nav_toolbar_1    { float:left; font:normal 11px tahoma ; margin-top:3px; border:#c9beac solid 1px; width:100%; height:20px;   }
.nav_toolbar_1 ul { background-image:url(back.gif); background-repeat:repeat-x; float:left; line-height:29px; height:32px; list-style:none; margin-right:10px; display:inline; }
.nav_toolbar_1 li { display:inline;  }
.nav_toolbar_1 a  { color:#006fff; float:left; padding:0 7px 0 7px;  text-decoration:none; border-right:#c9beac solid 1px; font-weight:bold; line-height:20px;  }
.nav_toolbar_1 a:hover { color:#333; background-color:#fff;  }

.nav_toolbar_1 .selected {color:#333; background-color:#fff; }

.nav_dates    { float:right; font:normal 11px tahoma ; margin-top:0px; border:#c9beac solid 0px;  height:20px;   }
.nav_dates ul { float:right; line-height:29px; height:32px; list-style:none; margin-right:10px; display:inline; }
.nav_dates li { display:inline;  }
.nav_dates a  { color:#f41b39; float:right; padding:0 7px 0 7px;  text-decoration:none; border-right:#c9beac solid 1px; font-weight:bold; line-height:20px;  }
.nav_dates a:hover { color:#333; font-weight:bold;  text-decoration:underline;  }

.nav_dates .selected {color:#333; font-weight:bold;  text-decoration:underline; }
.nav_dates .selectedf {color:#d27c28; font-weight:bold;  text-decoration:none; border:0px; padding:0 0px 0 7px; }


.heading_1b {font-size:13px;}


</style>



</head>

<body ><form id="form1" runat="server">

<div id="bottom">
<div id="container">					

<div id="header">

<div id="logo_title"><a href="index.aspx"><img src="images/szmc_title_logo_app.gif" alt="HACIMS + { Sheikh Zayed Medical Complex, Lahore }" /></a><!--logo_title end--></div>
<div id="efct"><img src="images/szmc_eft.jpg" /><asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" /></div>





<div id="nav_btns" >
<ul class="nav_btns">
<li><span><img src="images/szmc_key1.png" class="loginicon" width="15" height="14"    /></span><a href="login.aspx" class="link_login">Logout</a></li>
<li class="welcome"><span><img src="images/szmc_welcome.png" class="welcomeicon" width="13" height="16" /></span>Welcome ! <span class="name"><asp:Label ID="LabelDoctorName" runat="server" ></asp:Label><span style="color:#ccc;">&nbsp;-&nbsp; </span>
<asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment"></asp:Label></span></li>
<li class="date"><span ><img src="images/szmc_date.png" class="dateicon" width="9" height="11" /></span><asp:Label ID="LabelDate" runat="server" ></asp:Label></li>
</ul>
<!--nav_btns end--></div>


<!--header end--></div>

<div id="page_border">

<div id="p_info" style="width:952px; margin:0 auto 0 auto; margin-top:5px; height:51px;  display:block; background-color:none;">

<iframe src="PatientBasicInfo_Iframe.aspx" scrolling="no" frameborder="0" allowtransparency="true"  style="height:51px; padding:0px; margin:0px; width:952px;"  ></iframe>


</div>


<div id="bar" align="left"> 	

<asp:Label ID="LabelJavaMenu" runat="server"></asp:Label>

<!--bar end--></div>


<div id="inner_content" style="height:81.5%; display:block;">				

<div id="main_col" style="height:100%; display:block;"> 	

<div class="mainbox" style="height:100%; display:block;">
<span class="mainboxtop"></span>
<span class="mid_data" style="height:100%; display:block;">

<ul class="nav_toolbar_1"  style="display:none;" >
<li><a href="#">Presenting Complaints </a></li>
<li><a href="#">History</a></li>
<li><a href="#" class="selected">Physical Examination</a> </li>
<li><a href="#">Provisional Diagnosis </a></li>
<li><a href="#">Treatment </a></li>
<li><a href="#">Disposal </a></li>
<li><a href="#" class="selected">Patient Chart </a></li>
<li><a href="#">Doctor Call </a></li>
<li><a href="#">Report </a></li>
</ul>


<h1 class="heading_1"><span><input type="text" name="textfield" id="Text1" size="30"  class="heading_1b" style="border:0px; background-color:#eeeeee;"/></span></h1>


<div style="display:none; width:68%; float:right; clear:both;" >
<ul class="nav_dates"  >
<li><a href="#">2/2/2009</a></li>
<li><a href="#">3/2/2009</a></li>
<li><a href="#" class="selected">4/2/2009</a> </li>
<li><a href="#" class="selectedf">Follow Up :</a> </li>
</ul>
</div>





<iframe src="empty.html" name="holdit2" width="100%" marginwidth="0" marginheight="0" style="margin-top:-5px; " 
scrolling="No" frameborder="0" id="holder1" onload="calcHeight1();"  allowtransparency="true"   ></iframe>


<br />
<br />


</span>
<span class="mainboxbottom"></span>

<!--mainbox end--></div>
<!--main_col end--></div>





<!--inner_content end--></div>

<!--page_border end--></div>

<div id="footer"> 

<span>Powered by <a href="http://www.e-government.gov.pk/" target="_blank" class="copyright">Electronic Government Directorate (EGD)</a> </span> 
<span class="ri"> &copy; Oratier Technologies (Pvt.) Ltd - All Rights Reserved.</span>

<!--footer end--></div>

<!--container end--></div>

<!--bottom end--></div>

</form>
</body>
</html>
