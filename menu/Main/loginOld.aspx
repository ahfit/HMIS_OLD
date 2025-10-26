<%@ page language="VB" autoeventwireup="false" inherits="login, App_Web_rbfdm1yf" enableeventvalidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
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
</script>
<style type="text/css">
<!--
#Layer1 {
	position:absolute;
	left:28px;
	top:222px;
	width:295px;
	height:29px;
	z-index:1;
}
#Layer2 {
	position:absolute;
	left:47px;
	top:341px;
	width:124px;
	height:18px;
	z-index:5;
}
-->
</style>
</head>

<body >


<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" alt=""/></td>
  </tr>
  <tr>
    <td width="23" height="548" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15"  alt="" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td width="957" height="548" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:url(images1/img_login_services.jpg);background-repeat:no-repeat;">
          <!--DWLayoutTable-->
          <tr>
            <td height="13" colspan="7" valign="top"><img src="images1/space.png" width="957" height="1" alt="" /></td>
                </tr>
          <tr>
            <td width="15" style="height: 239px">&nbsp;</td>
                  <td style="width: 15px; height: 239px">&nbsp;</td>
                  <td width="95" style="height: 239px">&nbsp;</td>
                  <td width="149" style="height: 239px">&nbsp;<br />
                      <br />
                      <br />
                      <br />
                      <br />
                      <br />
                      <br />
                      <br />
                      <br />
                      <asp:TextBox ID="txtusername" runat="server"   Width="165px"   ></asp:TextBox>
                      <asp:TextBox ID="txtPassword" runat="server" MaxLength="40"
                            TextMode="Password"  Width="165px"  ></asp:TextBox></td>
                  <td width="39" style="height: 239px">&nbsp;</td>
                  <td width="368" style="height: 239px"></td>
                  <td width="276" style="height: 239px"></td>
          </tr>
          <tr>
            <td style="height: 23px">&nbsp;</td>
            <td style="width: 15px; height: 23px">&nbsp;</td>
            <td align="right" valign="middle"  style="height: 23px">&nbsp;</td>
            <td colspan="2" valign="top" style="height: 23px">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Button ID="btnLogin" runat="server" CssClass="bt1upnew" Text="Login"  onmousedown="this.className='bt1downnew'" onmouseover="this.className='bt1overnew'" onmouseout="this.className='bt1upnew'"/></td>
                  <td style="height: 23px"></td>
            <td style="height: 23px"></td>
          </tr>
          
          
          <tr>
            <td height="22">&nbsp;</td>
            <td style="width: 15px">&nbsp;</td>
            <td align="right" valign="middle" ><div id="Layer2" style="left: 62px; top: 280px"><a href="Administrator/ChangePassword.aspx" class="changepass_link">Change Password</a></div>&nbsp;</td>
            <td colspan="2" valign="top"></td>
                  <td></td>
            <td></td>
          </tr>
          
          <tr>
            <td height="47" colspan="3" align="right" valign="middle"></td>
                  <td align="center" valign="middle">
                      &nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource></td>
                  <td></td>
            <td></td>
            <td></td>
          </tr>
          
          <tr>
            <td height="33">&nbsp;</td>
            <td style="width: 15px">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
          </tr>
          
          
          <tr>
            <td height="70">&nbsp;</td>
                  <td colspan="5" align="center" valign="middle"><div id="Layer1" style="left: 67px; top: 321px">
                    <asp:Label ID="lblMessage" runat="server" CssClass="text_lables_login" ></asp:Label>
                  </div></td>
                <td>&nbsp;</td>
          </tr>
          <tr>
            <td height="102">&nbsp;</td>
            <td style="width: 15px">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="23" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" alt="" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" alt="" /></td>
  </tr>
  <tr>
    <td height="10"></td>
    <td></td>
    <td></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>