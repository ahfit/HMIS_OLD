<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>

<link rel="stylesheet" href="css/page.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="css/reset.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="css/print.css" type="text/css" media="print">
 
<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
<link rel="icon" href="images/favicon.ico" type="image/x-icon">

<script language="JavaScript">

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

function changeIframeSrc(id, url) { 
    if (!document.getElementById) return;
    var el = document.getElementById(id);
    if (el && el.src) {
        el.src = url;
        return false;
    }
    return true;
}
// ]]>
</script>


</head>

<body>

<div id="allcontent" class="container">

<div id="name"   class="span-18 info_h">Welcome ! &nbsp;<span class="txt_black">Mr. Qammar Pervaiz Ch.</span></div>
<div id="date" 	 class="span-6 last date">Friday, May 23, 2008</div>
<div id="header" class="span-24 header_bg"></div>

<div id="toolbar" 	class="span-24 toolbar">
<ul>
<li><a href="#">Home</a></li>
<li><a href="#">About Us</a></li>
<li><a href="#">Gray Theme</a></li>
<li><a href="#">White Theme</a></li>
<li><a href="#">Contact Us</a></li>
</ul>
</div><!--toolbar End-->


<div id="column_1" class="span-5">

<div id="navigation" class="navigation">
<ul>
<li><a href="#">Home</a></li>
<li><a href="administrator/form_assigntemplate.aspx" onclick="return changeIframeSrc('holder1', this.href)">Assign Template</a></li>
<li><a href="administrator/form_mainpage.aspx" onclick="return changeIframeSrc('holder1', this.href)">Main Page</a></li>
<li><a href="administrator/form_maingroup.aspx" onclick="return changeIframeSrc('holder1', this.href)">Main Group</a></li>
<li><a href="administrator/form_addelement.aspx" onclick="return changeIframeSrc('holder1', this.href)">Add Elements</a></li>
<li><a href="administrator/form_addelementvalue.aspx" onclick="return changeIframeSrc('holder1', this.href)">Add Elements Value</a></li>
<li><a href="administrator/form_addelementtooltip.aspx" onclick="return changeIframeSrc('holder1', this.href)">Add Element Tooltip</a></li>
<li><a href="administrator/form_assignelement.aspx" onclick="return changeIframeSrc('holder1', this.href)">Assign Element</a></li>
<li><a href="administrator/form_mainheading.aspx" onclick="return changeIframeSrc('holder1', this.href)">Assign Element</a></li>
<li><a href="Hr/Leave_management/form_applyforleave.aspx" onclick="return changeIframeSrc('holder1', this.href)">Apply for Leave</a></li>
<li><a href="Pt_EMR/form_Pt_History_New.aspx" onclick="return changeIframeSrc('holder1', this.href)">History</a></li>
<li><a href="form_calendar.aspx" onclick="return changeIframeSrc('holder1', this.href)">Calendar</a></li>




</ul>
</div>


</div><!--column_1 End-->



<div id="column_2" class="span-19 last">

<div id="block_info_4" class="block_1">
<h1 class="h1_1">Physical Examination</h1>

<iframe src="main.html" name="holdit" width="748" marginwidth="0" height="100" marginheight="0" 
scrolling="No" frameborder="0" id="holder1" onload="calcHeight1();" allowtransparency="true"></iframe>





</div>

</div><!--column_2 End-->




<div id="footer" class="footer">Copyright 2008 - . All rights reserved.</div>

</div><!--allcontent End-->
</body>
</html>
