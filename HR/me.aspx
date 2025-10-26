
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HACIMS + </title>

<link rel="stylesheet" href="../css/page.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="../css/reset.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="../images/sheet_form.css" type="text/css"  media="screen, projection">

<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="blue" href="css/page.css"/>
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="gray" href="css/themes/c_2.css" />
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="white" href="css/themes/c_3.css" />
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="orange" href="css/themes/c_4.css" />
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="purple" href="css/themes/c_5.css" />
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="greenish" href="css/themes/c_6.css" />
<link rel="alternate stylesheet" type="text/css" media="screen, projection" title="green" href="css/themes/c_7.css" />
 
<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
<link rel="icon" href="images/favicon.ico" type="image/x-icon">
<script src="SpryAssets/SpryCollapsiblePanel.js" type="text/javascript"></script>
<link href="SpryAssets/SpryCollapsiblePanel.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="images/styleswitch.js"></script>
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

<script type="text/javascript" src="mootools.js"></script>
<script type="text/javascript" src="demo.js"></script>

</head>

<body >    
<form id="form1" runat="server">

<div id="allcontent" class="container">
    <asp:HiddenField ID="HiddenFieldPage_Name" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage" runat="server" />
    &nbsp;

<div id="name"   class="span-18 info_h">Welcome ! &nbsp;<span class="txt_black"> <asp:Label ID="LabelDoctorName" runat="server" ></asp:Label> <asp:Label ID="Label_SubDepartment" runat="server"  Text="Label_SubDepartment"></asp:Label></span></div>
<div id="date" 	 class="span-6 last date"><asp:Label ID="LabelDate" runat="server" ></asp:Label></div>
<div id="header" class="span-24 header_bg"></div>

<div id="toolbar" 	class="span-24 toolbar">
<ul>

<li><a href="Reception_Main.aspx">Home</a></li>
<li style="float:right; position:relative; margin-right:-50px;"><a href="login.aspx" style="color:#990000;">Logout</a></li>

</ul>
</div><!--toolbar End-->

<div >

<div id="horizontal_slide"  style="background-color:#666666; height:300px; width:250px;"></div><!--column_1 End-->


<div id="column_3" style="width:90%;">

<div id="block_info_4" class="block_1">
<h1 class="h1_1">Doctor Main Area&nbsp;<img src="images/ar_1.gif" width="6" height="9" style="margin-top:9px;" />&nbsp;&nbsp;

  <input type="text" name="textfield" class="t1" id="Text1" value="Patient Registration" size="30" />

</h1>

<h3 class="section">Horizontal</h3>
	<div class="marginbottom">
		<a id="h_slideout" href="#">slide out</a>
		|
		<a id="h_slidein" href="#">slide in</a>
		|
		<a id="h_toggle" href="#">toggle</a>
		|
		<a id="h_hide" href="#">hide</a>
		|
		<a id="h_show" href="#">show</a>
		| <strong>status</strong>: <span id="horizontal_status">open</span>
	</div>

</div>

</div><!--column_3 End-->

</div>


<div id="footer" class="footer">Copyright &copy; 2008  All rights reserved.</div>

</div><!--allcontent End-->




</form>
</body>
</html>
