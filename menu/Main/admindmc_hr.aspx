<%@ page language="VB" autoeventwireup="false" inherits="admindmc_hr, App_Web_ppbttiod" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>HACIMS + </title>

<link rel="stylesheet" href="css/page.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="css/reset.css" type="text/css"  media="screen, projection">
<link rel="stylesheet" href="images/sheet_form.css" type="text/css"  media="screen, projection">
<link href="images1/st_sheet_02.css" rel="stylesheet" type="text/css" />

<!--[if IE]><link rel="stylesheet" href="css/ie.css" type="text/css" media="screen, projection"><![endif]-->
<link rel="icon" href="images/favicon.ico" type="image/x-icon">

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
<asp:Panel ID="Panel6" runat="server" ></asp:Panel>
</ul>
</div><!--toolbar End-->


<div id="column_3" class="span-24 last">

<div id="block_info_4" class="block_1">
<h1 class="h1_1">Basic Data Managment </h1>


<div id="forms_items" class="forms_items">
<asp:Label ID="Label_message" CssClass="err" runat="server"></asp:Label>
                                                  
<fieldset class="field" >

<asp:Button ID="Button_Employee" runat="server" Text="Employee" CssClass="bt_admin16up" onmousedown="this.className='bt_admin16up'" onmouseover="this.className='bt_admin16over'" onmouseout="this.className='bt_admin16up'" Height="92px" Width="69px"/>
    &nbsp;<asp:Button ID="Button25" runat="server" Text="Department" CssClass="bt_admin37up" onmousedown="this.className='bt_admin37up'" onmouseover="this.className='bt_admin37over'" onmouseout="this.className='bt_admin37up'" Width="84px"/>



<asp:Button ID="Button26" runat="server" Text="Sub Dept." CssClass="bt_admin36up" onmousedown="this.className='bt_admin36up'" onmouseover="this.className='bt_admin36over'" onmouseout="this.className='bt_admin36up'" Width="86px"/>


<asp:Button ID="Button27" runat="server" Text="Designation" CssClass="bt_admin28up" onmousedown="this.className='bt_admin28up'" onmouseover="this.className='bt_admin28over'" onmouseout="this.className='bt_admin28up'" Width="78px"/>
    <asp:Button ID="Button72" runat="server" Text="Profession" CssClass="bt_admin28up" onmousedown="this.className='bt_admin28up'" onmouseover="this.className='bt_admin28over'" onmouseout="this.className='bt_admin28up'" Width="78px"/>


  <asp:Button ID="Button30" runat="server" Text="Country" CssClass="bt_admin29up" onmousedown="this.className='bt_admin29up'" onmouseover="this.className='bt_admin29over'" onmouseout="this.className='bt_admin29up'" Width="78px"/>&nbsp;

  <asp:Button ID="Button31" runat="server" Text="Province" CssClass="bt_admin33up" onmousedown="this.className='bt_admin33up'" onmouseover="this.className='bt_admin33over'" onmouseout="this.className='bt_admin33up'" Width="68px"/>
    <asp:Button ID="Button32" runat="server" Text="District" CssClass="bt_admin34up" onmousedown="this.className='bt_admin34up'" onmouseover="this.className='bt_admin34over'" onmouseout="this.className='bt_admin34up'" Width="78px"/>
    <asp:Button ID="Button33" runat="server" Text="Tehsil" CssClass="bt_admin35up" onmousedown="this.className='bt_admin35up'" onmouseover="this.className='bt_admin35over'" onmouseout="this.className='bt_admin35up'" Width="83px"/>&nbsp;
    
    &nbsp;
    <asp:Button ID="Button38" runat="server" Text="Martial Status" CssClass="bt_admin20up" onmousedown="this.className='bt_admin20up'" onmouseover="this.className='bt_admin20over'" onmouseout="this.className='bt_admin20up'" Width="70px"/>
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="Button77" runat="server" Text="Employee View" CssClass="bt_admin16up" onmousedown="this.className='bt_admin16up'" onmouseover="this.className='bt_admin16over'" onmouseout="this.className='bt_admin16up'" Height="92px" Width="74px"/>&nbsp;
    <asp:Button ID="Button1" runat="server" Text="Module " CssClass="bt_admin16up" onmousedown="this.className='bt_admin16up'" onmouseover="this.className='bt_admin16over'" onmouseout="this.className='bt_admin16up'" Height="92px" Width="74px"/>
    &nbsp;&nbsp;
    <asp:Button ID="Button2" runat="server" Text="Pages" CssClass="bt_admin16up" onmousedown="this.className='bt_admin16up'" onmouseover="this.className='bt_admin16over'" onmouseout="this.className='bt_admin16up'" Height="92px" Width="74px"/>&nbsp;
    <asp:Button ID="Button3" runat="server" Text="Assign Page" CssClass="bt_admin16up" onmousedown="this.className='bt_admin16up'" onmouseover="this.className='bt_admin16over'" onmouseout="this.className='bt_admin16up'" Height="92px" Width="74px"/>&nbsp;<asp:Button ID="Button4" runat="server" Text="Employee View" CssClass="bt_admin16up" onmousedown="this.className='bt_admin16up'" onmouseover="this.className='bt_admin16over'" onmouseout="this.className='bt_admin16up'" Height="92px" Width="74px"/>
    </fieldset>

      <br />



</div>



</div>

</div><!--column_3 End-->




<div id="footer" class="footer">Copyright &copy; 2008  All rights reserved.</div>

</div><!--allcontent End-->



</form>
</body>
</html>
