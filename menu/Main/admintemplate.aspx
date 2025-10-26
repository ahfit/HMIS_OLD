<%@ page language="VB" autoeventwireup="false" inherits="admintemplate, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />

<style type="text/css">
#Layer1 {
	position:absolute;
	left:683px;
	top:223px;
	width:142px;
	height:18px;
	z-index:1;
	background-color: #FFFFFF;
}
#Layer2 {
	position:absolute;
	left:56px;
	top:395px;
	width:142px;
	height:26px;
	z-index:2;
	background-color: #FFFFFF;
}
#Layer3 {
	position:absolute;
	left:56px;
	top:225px;
	width:166px;
	height:26;
	z-index:3;
	background-color: #FFFFFF;
}
#Layer4 {
	position:absolute;
	left:687px;
	top:394px;
	width:55px;
	height:29px;
	z-index:4;
	background-color: #FFFFFF;
}

.name {
	font-family: "Trebuchet MS";
	font-size: 16px;
	font-weight: bolder;
	color: #0033CC;
	
}
.vv{color:#000000 ; padding-bottom:15px;  }
</style>


</head>
<body dir="ltr">
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="mainframe_bg16">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="5" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" rowspan="4" valign="top" class="left_border">                <img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td height="125" colspan="3" valign="top" bgcolor="#FFFFFF"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
    <td width="23" rowspan="4" valign="top" class="right_border" >                <img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="25" colspan="3" valign="middle" class="text_lables3">&nbsp;&nbsp;&nbsp;Template Management </td>
    </tr>
  <tr>
    <td width="11" height="10"></td>
    <td width="932" style="text-align: center"><asp:Label ID="Label_message" runat="server" ></asp:Label></td>
    <td width="14"></td>
  </tr>
  <tr>
    <td height="494"></td>
    <td valign="top"><fieldset class="field"  >
    <p>
      <legend class="text_heading_01">&nbsp;&nbsp;Template&nbsp;&nbsp;</legend>
    </p>
    <asp:Button ID="ButtonTemplateCreate" runat="server" Text="New Templates" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="86px"/>    
</fieldset><br />

	<fieldset class="field"  >
    <p>
      <legend class="text_heading_01">&nbsp;&nbsp;Add Template Elements&nbsp;&nbsp;</legend>
    </p>
    <span style="width: 103px; height: 88px">    </span><span style="width: 103px; height: 88px">
    <asp:Button ID="ButtonTemplateelements" runat="server" Text="History" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="72px"/>    
    </span><span style="width: 103px; height: 88px">
    <asp:Button ID="Button28" runat="server" Text="Examination" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="77px"/>    
    </span><span style="width: 103px; height: 88px">
    <asp:Button ID="ButtonVitalTemplate" runat="server" Text="Vitals" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="77px"/>    
    </span><span style="width: 103px; height: 88px">
    <asp:Button ID="ButtonTestTemplate" runat="server" Text="Pathology" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="77px"/>    
    </span><span style="width: 103px; height: 88px">
    <asp:Button ID="ButtonMedicine" runat="server" Text="Medicine" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="77px"/>&nbsp;
        <asp:Button ID="Button6" runat="server" Text="Presenting Complaints" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="77px"/></span></fieldset><br />


	<fieldset class="field"  >
    <p>
      <legend class="text_heading_01">&nbsp;&nbsp;Assign Template&nbsp;&nbsp;</legend>
    </p>
	<span style="width: 103px; height: 88px">
	<asp:Button ID="ButtonAssignTemplate" runat="server" Text="Assign" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="73px"/>	</span>
	</fieldset><br />


	<fieldset class="field"  >
    <p>
      <legend class="text_heading_01">&nbsp;&nbsp;View Template&nbsp;&nbsp;</legend>
    </p>
    <span style="width: 134px; height: 88px">
    <asp:Button ID="ButtonHistoryTemplate" runat="server" Text="History" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="71px"/>        </span><span style="width: 103px; height: 88px">
    <asp:Button ID="ButtonPhysicalTemplate" runat="server" Text="Examination" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="79px"/>    
    </span><span style="width: 104px; height: 88px">
    <asp:Button ID="ButtonViewVitalTemplate" runat="server" Text="Vitals" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="79px"/>    
    </span><span style="width: 104px; height: 88px">
    <asp:Button ID="ButtonViewTest" runat="server" Text="Test" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="79px"/>    
    </span><span style="width: 104px; height: 88px">
    <asp:Button ID="ButtonViewMedicine" runat="server" Text="Medicine" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="79px"/>    
    </span>
	</fieldset><br />

	
	<fieldset class="field" style="visibility: hidden"  >
    <p>
      <legend class="text_heading_01">&nbsp;&nbsp;Edit & Delete Template Elements&nbsp;&nbsp;</legend>
    </p><asp:Button ID="Button1" runat="server" Text="History" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="72px"/><asp:Button ID="Button2" runat="server" Text="Examination" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="77px"/><asp:Button ID="Button3" runat="server" Text="Vitals" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="77px"/><asp:Button ID="Button4" runat="server" Text="Pathology" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="77px"/><asp:Button ID="Button5" runat="server" Text="Medicine" CssClass="main_bt1up" onmousedown="this.className='main_bt1down'" onmouseover="this.className='main_bt1over'" onmouseout="this.className='main_bt1up'" Width="77px"/></fieldset>&nbsp;</td>
    <td></td>
  </tr>
  
  
  <tr>
    <td height="24" colspan="5" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>