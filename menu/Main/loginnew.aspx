<%@ page language="VB" autoeventwireup="false" inherits="loginnew, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>HACIMS + { Sheikh Zayed Medical Complex,Lahore } &gt;&gt; Main Administration Area</title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />

<style type="text/css">
<!--
#loginholder {
	position:absolute;
	left:306px;
	top:214px;
	width:394px;
	height:133px;
	z-index:5;
	background-color: #FFFFFF;
}
-->
</style>
</head>
<body dir="ltr">

<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="4" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" rowspan="3" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td height="40" colspan="2" valign="top">
        <img height="100" src="images1/top_header.jpg" width="957" /></td>
    <td width="23" rowspan="3" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td width="30" height="25" valign="top" bgcolor="#FFFFFF"><div id="loginholder" runat ="server">
  <table width="394" border="0" cellpadding="0" cellspacing="0" class="tablelogin">
    <!--DWLayoutTable-->
    <tr>
      <td height="14" colspan="2" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
    <tr>
      <td width="125" height="25" align="right" valign="middle" >UserName :&nbsp;</td>
      <td width="269" valign="middle"><asp:TextBox ID="TextBoxUserName" runat="server"  Width="146px"  ></asp:TextBox></td>
    </tr>
    <tr>
      <td height="25" align="right" valign="middle" >Password :&nbsp;</td>
      <td valign="middle"><asp:TextBox ID="TextBoxUserPassword" runat="server" TextMode="Password"  Width="146px"   ></asp:TextBox></td>
    </tr>
    <tr>
      <td height="30">&nbsp;</td>
      <td valign="middle">
          &nbsp;<asp:Button CssClass="bt1upnew"
                  ID="Button1" runat="server" Text="Login"  /></td>
    </tr>
    <tr>
      <td height="32" colspan="2" align="center" valign="middle"><asp:Label ID="LabelMessage" runat="server" Width="350" ></asp:Label>
        &nbsp;</td>
    </tr>
  </table>
</div> &nbsp;&nbsp;&nbsp;&nbsp;</td>
    <td width="927" align="right" valign="middle" class="lnks_bg"><span class="lnks_bg"><span class="link_spliter"><a href="hacims.aspx" class="login_link">About Hacims</a>&nbsp;|&nbsp;<a href="helphacims.aspx" class="login_link">Help</a>&nbsp;|&nbsp;</span><a href="login.aspx" class="login_link2">Logout</a>&nbsp;&nbsp;</span></td>
    </tr>
  <tr>
    <td height="486" colspan="2" valign="top" bgcolor="#FFFFFF" dir="ltr"><%--<script language="JavaScript" type="text/javascript">
document.write ('<OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" '
+'codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" '
+'WIDTH=957px HEIGHT=486px> <PARAM NAME=movie VALUE="images1/mainarea_administration.swf'+document.location.search+'">'
+'<PARAM NAME=quality VALUE=high><param name="wmode" value="transparent"/>'
+'<EMBED src="images1/mainarea_administration.swf' +document.location.search+'" ' 
+'quality=high bgcolor=#669966 WIDTH=957px HEIGHT=486px'
+'TYPE="application/x-shockwave-flash"></EMBED></OBJECT>')
            </script>--%>
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp;
        <asp:Label ID="Label_message" runat="server" ></asp:Label></td>
  </tr>
  
  
  
  <tr>
    <td height="24" colspan="4" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>

    <asp:ImageButton ID="ImageButtonWard_Shift" runat="server" Visible="false" />
</form>
</body>
</html>