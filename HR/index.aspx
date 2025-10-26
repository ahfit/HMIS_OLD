<%@ page language="VB" autoeventwireup="false" inherits="index, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>HACIMS + { Sheikh Zayed Medical Complex,Lahore } &gt;&gt; User Login</title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
</head>
<body onload="document.form1.txtusername.focus();">
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="551" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="images1/img_login_bg.jpg" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="32" colspan="2" valign="top">&nbsp;</td>
      </tr>
      <tr>
        <td width="787" height="162">&nbsp;</td>
        <td width="170">&nbsp;</td>
      </tr>
      <tr>
        <td height="115" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <!--DWLayoutTable-->
          <tr>
            <td width="132" height="25" align="right" valign="middle" ><strong>&nbsp; </strong></td>
                  <td colspan="2" valign="middle"><asp:TextBox ID="txtusername" runat="server"  Width="175px"   ></asp:TextBox></td>
                </tr>
          <tr>
            <td height="25" align="right" valign="middle" ><strong>&nbsp;</strong></td>
                  <td colspan="2" valign="middle"><asp:TextBox ID="txtPassword" runat="server" MaxLength="40"
                            TextMode="Password" Width="175px"   ></asp:TextBox></td>
                </tr>
          <tr>
            <td rowspan="2" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="179" height="37" align="center" valign="middle"><asp:Button CssClass="bt1up" ID="btnLogin" runat="server" Text="Login"   /></td>
                  <td width="476" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            </tr>
          
          <tr>
            <td height="28" colspan="2" align="left" valign="middle"><asp:Label ID="lblMessage" runat="server" CssClass="text_lables" Width="319px"></asp:Label></td>
              </tr>
          
          
          
        </table></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td height="242">&nbsp;<br />
            <br />
            <br />
            <br />
        </td>
        <td>&nbsp;</td>
      </tr>
      
      
      
      
      
      

      

		  

      
      
      
    </table></td>
    <td width="23" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script></form>
</body>
</html>