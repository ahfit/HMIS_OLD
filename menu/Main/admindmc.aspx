<%@ page language="VB" autoeventwireup="false" inherits="admindmc, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>
<%--

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<link href="images1/st_sheet_02.css" rel="stylesheet" type="text/css" />

<link href="menu/css/class_reset.css" rel="stylesheet" 	 type="text/css" />
<link href="menu/css/class_elements.css" rel="stylesheet" type="text/css" />

<link href="css1/dropdown/dropdown.css" media="all" rel="stylesheet" type="text/css" />
<link href="css1/dropdown/default.advanced.css" media="all" rel="stylesheet" type="text/css" />

<link href="css/dropdown/dropdown.css" media="all" rel="stylesheet" type="text/css" />
<link href="css/dropdown/default.advanced.css" media="all" rel="stylesheet" type="text/css" />

<!--[if lt IE 7]>
<script type="text/javascript" src="css/js/jquery/jquery.js"></script>
<script type="text/javascript" src="css/js/jquery/jquery.dropdown.js"></script>
<![endif]-->

<!--[if lt IE 7]>
<script type="text/javascript" src="css1/js/jquery/jquery.js"></script>
<script type="text/javascript" src="css1/js/jquery/jquery.dropdown.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="menu/css/js/ddsmoothmenu.css" />
<script type="text/javascript" src="menu/css/js/jquery.js"></script>
<script type="text/javascript" src="menu/css/js/ddsmoothmenu.js"></script>--%>



</head>

<body onload="MM_preloadImages('images1/img_bthover2.gif','images1/img_btup2.gif')">

<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
       <td height="73" colspan="2" valign="bottom" bgcolor="#F4F4F4" >
      <iframe 
      src="Tabs_Menu.aspx" name="holder" width="957" marginwidth="0" height="58" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe>
      </td>
      </tr>
        <tr>
            <td height="32" valign="top" width="20">
            </td>
            <td class="text_lables3" valign="middle" width="937">
            <div id="my_m">
                  <asp:Panel ID="PanelMenu" runat="server" >
                      <asp:Label ID="LabelMenu" runat="server"></asp:Label></asp:Panel>
                      </div>
            </td>
        </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_lables3"><span class="text_lables3" style="height: 32px">Administration</span></td>
          </tr>
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="loginnewbg">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="10" valign="top" style="width: 920px"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td height="395" valign="top" style="width: 920px"><table width="100%" border="0" cellpadding="0" cellspacing="0" >
                    <!--DWLayoutTable-->
                    <tr>
                      <td height="395" valign="top" style="width: 967px" >
                      <asp:Label ID="Label_message" runat="server"></asp:Label><br />
                      
                      
                              <fieldset class="field" style="visibility: visible">
            <legend class="text_heading_01">&nbsp; Template&nbsp;</legend>
            <asp:Button ID="Buttona" runat="server" Text="New Template" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Height="94px" Width="98px"/>
                                  <asp:Button ID="Buttonb" runat="server" Text="Assign Template" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="102px"/>&nbsp;
            <span style="height: 90px">
</span></fieldset>


<br />
                      
                      
                              <fieldset class="field" style="visibility: visible">
            <legend class="text_heading_01">&nbsp; Presenting Complaint&nbsp;</legend>
            <asp:Button ID="Button60" runat="server" Text="Add to Template" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Height="94px" Width="98px"/>
                                  <asp:Button ID="Button59" runat="server" Text="Main Page" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
                                  <asp:Button ID="Button17" runat="server" Text="Main Group" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
            <span style="height: 90px">
                <asp:Button ID="Button28" runat="server" Text="Element" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="74px"/></span><span style="height: 90px">
                        <asp:Button ID="Button29" runat="server" Text="Element Values" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="86px"/>&nbsp;&nbsp;
                    &nbsp;
                    <asp:Button ID="Button55" runat="server" Text="Assign Element" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="88px"/>
                    <asp:Button ID="Button41" runat="server" Text="All Value Report" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="88px"/>
                    <asp:Button ID="Button_Hist_Temp" runat="server" Text="Template Report" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="105px"/></span></fieldset>

<br/>
<fieldset class="field">
<legend class="text_heading_01">&nbsp;&nbsp;History &nbsp;&nbsp;</legend>
<asp:Button ID="Button61" runat="server" Text="Add to Template" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="97px"/>
    <asp:Button ID="Button58" runat="server" Text="Main Page" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
    <asp:Button ID="Button4" runat="server" Text="Main Group" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
<span style="width: 448px">
<asp:Button ID="Button5" runat="server" Text="Element" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/></span><span style="width: 448px">
<asp:Button ID="Button6" runat="server" Text="Element Values" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/>
</span><span style="width: 448px">
<asp:Button ID="Buttontooltip2" runat="server" Text="Tooltip" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
    &nbsp;
    <asp:Button ID="Button54" runat="server" Text="Assign Element" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="92px"/>&nbsp;
    <asp:Button ID="Button56" runat="server" Text="Transfer Value" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="107px"/>
    <asp:Button ID="Button40" runat="server" Text="All Value Report" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="88px"/>
    <asp:Button ID="Button_TempRep" runat="server" Text="Template Report" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="103px"/></span></fieldset>
<br />

<fieldset class="field">
<legend class="text_heading_01">&nbsp;&nbsp;Physical Examination&nbsp;&nbsp;</legend>
<asp:Button ID="Button62" runat="server" Text="Add to Template" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="97px"/>
    <asp:Button ID="Button57" runat="server" Text="Main Page" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
                          <asp:Button ID="Button1" runat="server" Text="Main Group" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>

<asp:Button ID="Button2" runat="server" Text="Element" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>

<asp:Button ID="Button3" runat="server" Text="Element Values" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/>

<asp:Button ID="Buttontooltip" runat="server" Text="Tooltip" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
    &nbsp;
                          <asp:Button ID="Button53" runat="server" Text="Assign Element" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="88px"/>&nbsp;
    <asp:Button ID="Button65" runat="server" Text="Transfer Values" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="105px"/>
    <asp:Button ID="Button39" runat="server" Text="All Value Report" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="88px"/>
    <asp:Button ID="Button66" runat="server" Text="Template Report" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="103px"/></fieldset>
                          
<br/><fieldset class="field" style="visibility: visible">
    <legend class="text_heading_01">&nbsp; Vitals &nbsp;</legend>
    <asp:Button ID="Button11" runat="server" Text="Main Group" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
    <span style="height: 90px">
        <asp:Button ID="Button12" runat="server" Text="Element" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="75px"/></span><span style="height: 90px">
                <asp:Button ID="Button16" runat="server" Text="Element Values" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/>
            </span>
</fieldset>
                          <fieldset class="field">
                              <legend class="text_heading_01">&nbsp; OT Administration &nbsp;</legend>
                              <asp:Button ID="Button70" runat="server" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'"
                                  onmouseout="this.className='main_bt1up'" onmouseover="this.className='main_bt1over'"
                                  Text="Add to Template" Width="87px" />
                              <asp:Button ID="Button67" runat="server" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'"
                                  onmouseout="this.className='main_bt1up'" onmouseover="this.className='main_bt1over'"
                                  Text="Main Group" />
                              <asp:Button ID="Button68" runat="server" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'"
                                  onmouseout="this.className='main_bt1up'" onmouseover="this.className='main_bt1over'"
                                  Text="Element" />
                              <asp:Button ID="Button69" runat="server" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'"
                                  onmouseout="this.className='main_bt1up'" onmouseover="this.className='main_bt1over'"
                                  Text="Element Values" Width="87px" />
                              &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;
                              &nbsp; &nbsp;&nbsp;<br />
                              &nbsp;</fieldset>


        <br />
<fieldset class="field">
<legend class="text_heading_01">&nbsp;&nbsp;Medicine&nbsp;&nbsp;</legend>
<asp:Button ID="Button24" runat="server" Text="Medicines" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
<span style="width: 117px; height: 90px">
<asp:Button ID="Button23" runat="server" Text="Frequency" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Visible="False"/></span><span style="width: 114px; height: 90px">
<asp:Button ID="Button22" runat="server" Text="Med. Instr." CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Visible="False"/>
</span><span style="width: 108px; height: 90px">
<asp:Button ID="Button21" runat="server" Text="Dosage" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Visible="False"/>
    &nbsp;<asp:Button ID="Button50" runat="server" Text="Medicine Role" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>&nbsp;
    <asp:Button ID="Button49" runat="server" Text="Role Assign" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>&nbsp;<asp:Button ID="Button52" runat="server" Text="Assign Medicine" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/></span></fieldset>


        <br />
        <fieldset class="field">
            <legend class="text_heading_01">&nbsp;Pathology Lab. Tests &nbsp;</legend>
            <asp:Button ID="Button18" runat="server" Text="Test Group" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
            <asp:Button ID="Button19" runat="server" Text="Sub Group" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
            <asp:Button ID="Button20" runat="server" Text="Test Name" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
            <asp:Button ID="Button42" runat="server" Text="Test Templates" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/>&nbsp;
            <asp:Button ID="Button43" runat="server" Text="Add Test" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/></fieldset>

        <br />
        <fieldset class="field">
            <legend class="text_heading_01">Radiology Lab. Tests&nbsp;&nbsp;</legend>
<asp:Button ID="Button44" runat="server" Text="Test Group" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
<asp:Button ID="Button45" runat="server" Text="Sub Group" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>

<asp:Button ID="Button46" runat="server" Text="Test Name" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
    <asp:Button ID="Button51" runat="server" Text="Range Value" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="92px"/>&nbsp;
            <asp:Button ID="Button47" runat="server" Text="Test Templates" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/>&nbsp;
    <asp:Button ID="Button48" runat="server" Text="Add Test" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/>
            <asp:Button ID="Button63" runat="server" Text="Xray Template" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/></fieldset>


<br/>
<fieldset class="field">
<legend class="text_heading_01">&nbsp;&nbsp;User Authentication&nbsp;&nbsp;</legend>
<asp:Button ID="Button7" runat="server" Text="Module Name" CssClass="bt_admin21up" onmousedown="this.className='bt_admin21up'" onmouseover="this.className='bt_admin21over'" onmouseout="this.className='bt_admin21up'"/>

<asp:Button ID="Button8" runat="server" Text="Page Name" CssClass="bt_admin15up" onmousedown="this.className='bt_admin15up'" onmouseover="this.className='bt_admin15over'" onmouseout="this.className='bt_admin15up'"/>

<asp:Button ID="Button9" runat="server" Text="Assign Pages" CssClass="bt_admin26up" onmousedown="this.className='bt_admin26up'" onmouseover="this.className='bt_admin26over'" onmouseout="this.className='bt_admin26up'"/>
    <asp:Button ID="Button78" runat="server" Text="Assign Role" CssClass="bt_admin26up" onmousedown="this.className='bt_admin26up'" onmouseover="this.className='bt_admin26over'" onmouseout="this.className='bt_admin26up'"/>
</fieldset>
<br/>

<fieldset class="field" >

<legend class="text_heading_01">&nbsp;&nbsp;Basic Data Managment &nbsp;</legend>

<asp:Button ID="Button_Employee" runat="server" Text="Employee" CssClass="bt_admin16up" onmousedown="this.className='bt_admin16up'" onmouseover="this.className='bt_admin16over'" onmouseout="this.className='bt_admin16up'" Height="92px" Width="69px"/>


<asp:Button ID="Button10" runat="server" Text="Create Login" CssClass="bt_admin13up" onmousedown="this.className='bt_admin13up'" onmouseover="this.className='bt_admin13over'" onmouseout="this.className='bt_admin13up'" Width="76px"/>
    <asp:Button ID="Button71" runat="server" Text="Add Main Page" CssClass="bt_admin16up" onmousedown="this.className='bt_admin16up'" onmouseover="this.className='bt_admin16over'" onmouseout="this.className='bt_admin16up'" Height="92px" Width="82px"/>&nbsp;
<asp:Button ID="Button_Change_Dept" runat="server" Text="Employee Posting" CssClass="bt_admin18up" onmousedown="this.className='bt_admin18up'" onmouseover="this.className='bt_admin18over'" onmouseout="this.className='bt_admin18up'" Width="92px"/>
<asp:Button ID="Button_Emp_Info" runat="server" Text="Employee Info" CssClass="bt_admin27up" onmousedown="this.className='bt_admin27up'" onmouseover="this.className='bt_admin27over'" onmouseout="this.className='bt_admin27up'" Width="78px"/>


<asp:Button ID="Button25" runat="server" Text="Department" CssClass="bt_admin37up" onmousedown="this.className='bt_admin37up'" onmouseover="this.className='bt_admin37over'" onmouseout="this.className='bt_admin37up'" Width="84px"/>



<asp:Button ID="Button26" runat="server" Text="Sub Dept." CssClass="bt_admin36up" onmousedown="this.className='bt_admin36up'" onmouseover="this.className='bt_admin36over'" onmouseout="this.className='bt_admin36up'" Width="86px"/>


<asp:Button ID="Button27" runat="server" Text="Designation" CssClass="bt_admin28up" onmousedown="this.className='bt_admin28up'" onmouseover="this.className='bt_admin28over'" onmouseout="this.className='bt_admin28up'" Width="78px"/>
    <asp:Button ID="Button72" runat="server" Text="Profession" CssClass="bt_admin28up" onmousedown="this.className='bt_admin28up'" onmouseover="this.className='bt_admin28over'" onmouseout="this.className='bt_admin28up'" Width="78px"/>


  <asp:Button ID="Button30" runat="server" Text="Country" CssClass="bt_admin29up" onmousedown="this.className='bt_admin29up'" onmouseover="this.className='bt_admin29over'" onmouseout="this.className='bt_admin29up'" Width="78px"/>
    <asp:Button ID="Button73" runat="server" CssClass="rpt_1up" Text="Report" Width="74px" />

  <asp:Button ID="Button31" runat="server" Text="Province" CssClass="bt_admin33up" onmousedown="this.className='bt_admin33up'" onmouseover="this.className='bt_admin33over'" onmouseout="this.className='bt_admin33up'" Width="68px"/>
    <asp:Button ID="Button32" runat="server" Text="District" CssClass="bt_admin34up" onmousedown="this.className='bt_admin34up'" onmouseover="this.className='bt_admin34over'" onmouseout="this.className='bt_admin34up'" Width="78px"/>
    <asp:Button ID="Button33" runat="server" Text="Tehsil" CssClass="bt_admin35up" onmousedown="this.className='bt_admin35up'" onmouseover="this.className='bt_admin35over'" onmouseout="this.className='bt_admin35up'" Width="83px"/>

    <asp:Button ID="Button34" runat="server" Text="Ethnic Group" CssClass="bt_admin32up" onmousedown="this.className='bt_admin32up'" onmouseover="this.className='bt_admin32over'" onmouseout="this.className='bt_admin32up'" Width="78px"/>
    
    <asp:Button ID="Button35" runat="server" Text="Race" CssClass="bt_admin30up" onmousedown="this.className='bt_admin30up'" onmouseover="this.className='bt_admin30over'" onmouseout="this.className='bt_admin30up'" Width="83px"/>
    
    <asp:Button ID="Button36" runat="server" Text="Language" CssClass="bt_admin31up" onmousedown="this.className='bt_admin31up'" onmouseover="this.className='bt_admin31over'" onmouseout="this.className='bt_admin31up'" Width="77px"/>
    
    <asp:Button ID="Button37" runat="server" Text="Ward" CssClass="bt_admin19up" onmousedown="this.className='bt_admin19up'" onmouseover="this.className='bt_admin19over'" onmouseout="this.className='bt_admin19up'" Width="94px"/>
    <asp:Button ID="Button38" runat="server" Text="Martial Status" CssClass="bt_admin20up" onmousedown="this.className='bt_admin20up'" onmouseover="this.className='bt_admin20over'" onmouseout="this.className='bt_admin20up'" Width="70px"/>
    <asp:Button ID="ButtonTemplate" runat="server" Text="Templates" CssClass="bt_admin12up" onmousedown="this.className='bt_admin12over'" onmouseover="this.className='bt_admin12over'" onmouseout="this.className='bt_admin12up'" Width="82px"/>
    <asp:Button ID="Button64" runat="server" Text="Physician Order" CssClass="bt_admin7up" onmousedown="this.className='bt_admin7up'" onmouseover="this.className='bt_admin7over'" onmouseout="this.className='bt_admin7up'" Height="92px" Width="78px"/>
    <asp:Button ID="Button74" runat="server" CssClass="rpt_1up" Text="Printer" Width="68px" />&nbsp;
    <asp:Button ID="Button75" runat="server" CssClass="rpt_1up" Text="Computer" Width="70px" />&nbsp;&nbsp;&nbsp;
    <asp:Button ID="Button_Shifts" runat="server" CssClass="rpt_1up" Text="Shifts" Width="68px" />
    &nbsp;
    <asp:Button ID="Button_Assign_Shifts" runat="server" CssClass="rpt_1up" Text="Assign Shifts" Width="68px" />
    &nbsp;&nbsp;
    <asp:Button ID="Button76" runat="server" Text="Employee Portal " CssClass="bt_admin30up" onmousedown="this.className='bt_admin30up'" onmouseover="this.className='bt_admin30over'" onmouseout="this.className='bt_admin30up'" Width="83px"/>
    <asp:Button ID="Button77" runat="server" Text="Diagnosis For Department" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="128px"/></fieldset>

      <br />
<fieldset class="field" style="visibility: hidden">
<legend class="text_heading_01">&nbsp;&nbsp;Disease Diagnosis&nbsp;&nbsp;</legend>
<asp:Button ID="Button13" runat="server" Text="Name" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
<span style="height: 90px">
<asp:Button ID="Button14" runat="server" Text="Value" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="87px"/></span><span style="height: 90px">
<asp:Button ID="Button15" runat="server" Text="Query" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'"/>
</span>
</fieldset>
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      </td>
                      </tr>
                      <tr>
                          <td  valign="top" style="width: 967px">
                          </td>
                      </tr>
                  </table></td>
                </tr>
                
                
                <tr>
                  <td height="19" valign="top" style="width: 920px"><!--DWLayoutEmptyCell-->&nbsp;</td>
                </tr>
                
                
                
                
                

                
                
                
                
                
                
                
                

          
          
          
          
          
          
            </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
            
    </table></td>
    <td width="32" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>