<%@ page language="VB" autoeventwireup="false" inherits="MainPage, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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

<div id="bar" align="left"> 	

<asp:Label ID="LabelJavaMenu" runat="server"></asp:Label>

<!--bar end--></div>


<div id="inner_content" style="height:86%; display:block;" >				

<div id="main_col" style="height:100%; display:block;" > 	

<div class="mainbox" style="height:100%; display:block;">
<span class="mainboxtop"></span>
<span class="mid_data" style="height:100%; display:block;">

<h1 class="heading_1">Administration Area &raquo; <span><input type="text" name="textfield" id="Text1" class="heading_1b" size="30" style="border:0px; background-color:#eeeeee;"/></span></h1>
<br class="break"   />

<div style=" float:left; display:block; height:100%; width:100%;  ">

<iframe src="empty.html" name="holdit2" width="100%" marginwidth="0" marginheight="0" 
scrolling="No" frameborder="0" id="holder1" onload="calcHeight1();" allowtransparency="true" height="auto"  ></iframe>

</div>

<br />
<br class="break"/>

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
