<%@ page language="VB" autoeventwireup="false" inherits="login, App_Web_ppbttiod" enableeventvalidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


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
<script type="text/javascript" src="css/js/highlight.js"></script>



<style type="text/css"> 
#nav_btns{margin-top:28px;}
.label_1{width:90px;}
.input_txt{width:210px;}
body{height:auto;}
#container{height:auto;}
</style>



<script src="css/js/Scripts/AC_RunActiveContent.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
function checkValue(a)
{
    var userName=document.getElementById("txtusername").value;
    var password=document.getElementById("txtPassword").value;
    if(userName=="")
    {
        alert("UserName is blank");
        document.getElementById("txtusername").focus();
        return false;
    }
    if(password=="")
    {
        alert("Password is blank");
        document.getElementById("txtPassword").focus();
        return false;
    }
}

function  setfocus1 {  document.getElementById("txtusername").focus();

} 
</script>



</head>

<body onload="setfocus1();, highlight();">
<form id="form1" runat = "server">
<div id="bottom">
<div id="container">					

<div id="header">

<div id="logo_title"><img src="images/szmc_title_logo_app.gif" alt="HACIMS + { Sheikh Zayed Medical Complex, Lahore }" /><!--logo_title end--></div>
<div id="efct"><img src="images/szmc_eft.jpg" /></div>





<div id="nav_btns" >
<ul class="nav_btns">
<li class="welcome"><span><img src="images/szmc_welcome.png" class="welcomeicon" width="13" height="16" /></span>Welcome ! <span class="name">Guest</span></li>
<li class="date"><span ><img src="images/szmc_date.png" class="dateicon" width="9" height="11" /></span> <asp:Label ID="LabelDate" runat="server"></asp:Label></li>
</ul>
<!--nav_btns end--></div>


<!--header end--></div>

<div id="page_border">

<div id="bar" align="left"> 	

<script type="text/javascript" language="JavaScript1.2" src="menu/dmenu.js"></script>
<script type="text/javascript" language="JavaScript1.2" src="menu/data-office-1.js"></script>

<!--bar end--></div>


<div id="inner_content">				

<div id="main_col"> 	

<div class="mainbox">
<span class="mainboxtop"></span>
<span class="mid_data" style="height:428px;">

<h1 class="heading_1">Administration &raquo; <span>User Login</span></h1>
<br class="break"  />

<div id="login_left" >


<div class="form_login ">
<span>
<ul class="form_ul ">
<li class="form_li"><label class="label_1">&nbsp;</label><label class="err" ><asp:Label ID="lblMessage" runat="server"  ></asp:Label></label></li>
<li class="form_li"><label class="label_1">User Name : </label><asp:TextBox ID="txtusername" runat="server" class="input_txt" ></asp:TextBox></li>
<li class="form_li"><label class="label_1">Password : </label><asp:TextBox ID="txtPassword"  runat="server" MaxLength="40" TabIndex="0"  TextMode="Password" class="input_txt"  ></asp:TextBox></li>
<li class="form_li"> <label class="label_1" >&nbsp;</label><asp:Button ID="btnLogin" runat="server" CssClass="btn_1" Text="Login" />&nbsp;&nbsp;<a href="Administrator/ChangePassword.aspx" class="link_forgot" >Forgot your  Password?</a><asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource></li>
</ul>
</span>
</div><!--end form_login-->


<ul class="form_ul introtxt" >
<li><img src="images/szmc_q1.gif" width="14" height="8" /></li>
<li class="introtxt_litxt">Shaikh Zayed Medical Complex is an autonomous body attached with Cabinet Division. It has four components, Federal Postgraduate Medical Institute, Shaikh Zayed Hospital, National Health Research Complex and Shaikha Fatima Institute of Nursing and Health Sciences. This website is updated on Januray 31, 2009. <a href="#" class="readmore">Read More &raquo; </a>&nbsp;<img src="images/szmc_q2.gif" class="q2" width="14" height="8" /></li>

<li class="introtxt_link"  ><img src="images/szmc_aro2.gif" width="11" height="7" />&nbsp;&nbsp;<a href="#" class="link_web" >szmc.com.pk</a> <span style="color:#7e7f7f;">[ Shaikh Zayed Medical Complex, Lahore ]</span> </li>


<li><img src="images/logos.jpg" border="0" usemap="#Map" style="margin-top:18px; margin-left:5px;"  />
<map name="Map" id="Map"><area shape="rect" coords="2,-4,84,66" href="http://www.e-government.gov.pk/" target="_blank" alt="Electronic Government Directorate (EGD)" />
<area shape="rect" coords="99,3,169,64" href="#" alt="Hospital Automation &amp; Clinical Information Management System (HACIMS)" />
<area shape="rect" coords="190,5,309,62" href="#" alt="Oratier Technologies (Pvt.) Ltd." />
</map></li>



</ul>

</div>

<div id="login_right" class="flash_login"  >

  <script type="text/javascript">
AC_FL_RunContent( 'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0','width','675','height','436','tabindex','20','src','images/login_imgs','quality','high','pluginspage','http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash','wmode','transparent','movie','images/login_imgs' ); //end AC code
</script><noscript><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="675" height="436" tabindex="20">
    <param name="movie" value="images/login_imgs.swf" />
    <param name="quality" value="high" />
    <param name="wmode" value="transparent" />
    <embed src="images/login_imgs.swf" width="675" height="436" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" wmode="transparent"></embed>
  </object>
</noscript></div>




<br />
<br class="break"/>

</span>
<span class="mainboxbottom"></span>

<!--mainbox end--></div>
<!--main_col end--></div>





<!--inner_content end--></div>

<!--page_border end--></div>

<div id="footer"> 

<span>Powered by <a href="http://www.e-government.gov.pk/" target="_blank" class="copyright" >Electronic Government Directorate (EGD)</a> </span> 
<span class="ri"> &copy; Oratier Technologies (Pvt.) Ltd - All Rights Reserved.</span>

<!--footer end--></div>

<!--container end--></div>

<!--bottom end--></div>

</form>
</body>
</html>
