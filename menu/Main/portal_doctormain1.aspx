<%@ page language="VB" autoeventwireup="false" inherits="Portal_Doctormain1, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link rel="stylesheet" href="css/page.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="css/reset.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="css/print.css" type="text/css" media="print">

<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
<link rel="icon" href="images/favicon.ico" type="image/x-icon">

<style type="text/css">

.blocdk_1{height:50px;}
 
</style>

<script src="SpryAssets/xpath.js" type="text/javascript"></script>
<script src="SpryAssets/SpryData.js" type="text/javascript"></script>
<script type="text/javascript">
<!--
var news = new Spry.Data.XMLDataSet("XMLFile/news_updates.xml", "newsupdates/news",{useCache:false,distinctOnLoad:true});
var duty_roster = new Spry.Data.XMLDataSet("XMLFile/DutyRoster.xml", "DutyRoster/emp_DutyShift",{useCache:false,distinctOnLoad:true});
var doctor_call = new Spry.Data.XMLDataSet("XMLFile/DoctorCall.xml", "DoctorCall/Call_To_Doctor",{useCache:false,distinctOnLoad:true});
var orders = new Spry.Data.XMLDataSet("XMLFile/RadiologyOrder.xml", "RadiologyOrder/SubDepartment",{useCache:false,distinctOnLoad:true});
//-->
</script>
</head>

<body><form id="form1" runat="server">

<div id="allcontent" class="container ">

<div id="name"   class="span-18 info_h">Welcome ! &nbsp;&nbsp;<span class="txt_black"><asp:Label ID="LabelDoctorName" runat="server"
        ></asp:Label>&nbsp;&nbsp;[ <asp:Label ID="Label_SubDepartment" runat="server"></asp:Label> ]</span></div>
<div id="date" 	 class="span-6 last date"><asp:Label
            ID="LabelDate" runat="server"></asp:Label></div>
<div id="header" class="span-24 header_bg"></div>

<div id="toolbar" 	class="span-24 toolbar">
<ul>
<li><a href="#">Home</a></li>
<li><a href="#">Doctors Main Area</a></li>
<li><a href="#">Employee Services</a></li>
<li ><a href="login.aspx" style="color:#dd1e1e">Logout</a></li>
</ul>
</div><!--toolbar End-->


<div id="column_1" class="span-12">

<div id="introduction" class="block_1">
<h1  class="h1_1">Department</h1>

<span class="txt_block">Welcome to  a progressive, full service hospital offering advanced medical and surgical care as well as specialty support and outpatient services. Located in a Lahore, we are licensed for 272 beds, and admitted over 9,500 people for care and provided more than 111,000 visits for outpatient....
</span>

<!--introduction end--></div>

<div id="doctorcall" class="block_1">
<h1  class="h1_1">Doctor Call</h1>

<div class="table" spry:region="doctor_call">
<ul>
<li class="title" style="width:160px;" >Call By</li>
<li class="even" spry:repeat="doctor_call">{CallBY}</li>
</ul>
<ul>
<li class="title" style="width:180px;">Department</li>
<li class="even" spry:repeat="doctor_call">{CallByDepartment}</li>
</ul>
<ul>
<li class="title">Date&nbsp;&nbsp;&nbsp;</li>
<li class="even" spry:repeat="doctor_call">{CallDate}</li>
</ul>
<ul>
<li class="title">Time&nbsp;&nbsp;&nbsp;</li>
<li class="even" spry:repeat="doctor_call">{CallTime}</li>
</ul>

</div><br />
<br />



<!--docotor call end--></div>

<div id="dutyroster" class="block_1">
<h1  class="h1_1">Duty Roster</h1>

<div class="table" spry:region="duty_roster">
<ul>
<li class="title" >Date</li>
<li class="even" spry:repeat="duty_roster">{Duty_Date}</li>
</ul>
<ul>
<li class="title" style="width:300px;">Name</li>
<li class="even" spry:repeat="duty_roster">{Employee}</li>
</ul>
<ul>
<li class="title" style="width:60px;">Shift</li>
<li class="even" spry:repeat="duty_roster">{ShiftName}</li>
</ul>

</div
<br />
<br />
<br />


<!--dutyroster end--></div>

<div id="calendar" class="block_1">
<h1  class="h1_1">Calendar</h1>
<iframe src="calendar_main.aspx" name="calendar" width="466" marginwidth="0" height="225" marginheight="0" 
scrolling="yes" frameborder="0" id="calendar_1" allowtransparency="true" ></iframe>


<!--calendar end--></div>

<div id="block_1" class="block_1">
<h1  class="h1_1">Messages</h1>

<ul class="block_ul" style="margin-top:7px;">
<li class="block_li">
</li> 
<li><a href="#">Message from Dr. Shahid</a></li>
<li><a href="#">Message from Dr. Qadir</a></li>
<li><a href="#">Message from Dr. Tanvir</a></li>
<li><a href="#">Message from Dr. Munir</a></li>
</ul>
<!--messages end--></div>

<!--column 1 end--></div>



<div id="column_2" class="span-6">
<div id="department" class="block_1">
<h1  class="h1_1">Calendar</h1>

<div align="center">
<asp:Calendar ID="Calendar1" runat="server"><TodayDayStyle BackColor="LightSkyBlue" /></asp:Calendar><br style="line-height:5px;" />

</div>
<!--introduction end-->
</div>

<div id="newmedicine" class="block_1">
<h1  class="h1_1">New Medicine</h1>

<ul class="block_ul" style="margin-top:7px;">
<li class="block_li"></li> 
<li><a href="#">Adrucil (fluorouracil-injection)</a></li>
<li><a href="#">Altretamine </a></li>
<li><a href="#">Almotriptan-oral </a></li>
<li><a href="#">Fexofenadine </a></li>
</ul>

<!--newmedicine end--></div>

<div id="department" class="block_1">
<h1  class="h1_1">Departments</h1>
<asp:Panel ID="Panel1" runat="server" CssClass="block_ul" Visible="False" ></asp:Panel>
<asp:TreeView ID="TreeView1" runat="server" ExpandDepth="0" cssclass="tree_1" >
<ParentNodeStyle CssClass="tree_1parent"></ParentNodeStyle>
<SelectedNodeStyle CssClass="tree_1selected"></SelectedNodeStyle>
<RootNodeStyle CssClass="tree_1root"></RootNodeStyle>
<LeafNodeStyle CssClass="tree_1leafnode"></LeafNodeStyle>
<NodeStyle CssClass="tree_1node"></NodeStyle></asp:TreeView>

<!--department end--></div>


<div id="orders" class="block_1">
<h1  class="h1_1">Orders</h1>


<div class="table" spry:region="orders">
<ul>
<li class="title" style="width:100px;" >Departments</li>
<li class="even" spry:repeat="orders">{SubDept_Name}</li>
</ul>
<ul>
<li class="title" >Send</li>
<li class="even" spry:repeat="orders">{orderSend}</li>
</ul>
<ul>
<li class="title" >Complete</li>
<li class="even" spry:repeat="orders">{OrderComplete}</li>
</ul>

</div>
<br />
<br />

<!--orders end--></div>

<!--column_2 end--></div>


<div id="column_3" class="span-6 last">

<div id="picture" class="block_1">
<h1  class="h1_1"></h1>
<div align="center"><img src="images/picture.jpg" class="img_2" /></div>

<!--picture end--></div>

<div id="news" class="block_1">
<h1 class="h1_1">News & Events</h1>


<!--news end--></div>

<div id="weather" class="block_1">
<h1  class="h1_1">Weather</h1>

<!-- <div align="center"><img src="images/weather.jpg" class="img_2" /></div>--->
         
  <iframe id="WeatherBugSticker_180x150_v2" src="http://weather.weatherbug.com/desktop-weather/web-widgets/getSticker.html?CityCode=71533&ZCode=z5545&Size=180x150&units=1&Version=2&StationID=OPLH" width="174" height="96" frameborder="0" scrolling="no" allowtransparency="yes"></iframe>

<!--weather end--></div>

<!--column 3 end--></div>

<div id="footer" class="footer">Copyright 2008 - . All rights reserved.</div>

</div><!--allcontent End--></form>
</body>
</html>
