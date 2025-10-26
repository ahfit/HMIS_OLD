<%@ page language="VB" autoeventwireup="false" inherits="EmergencyMain, App_Web_rbfdm1yf" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <%--<meta http-equiv="Refresh" content=2 />--%>

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
</head>

<body>
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="459" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="97" colspan="2" valign="top"><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="157" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
          </tr>
      
      
      <tr>
        <td width="19" height="25" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="938" valign="middle" class="text_lables3"><p class="text_lables3">
                Emergency</p></td>
          </tr>
      <tr>
        <td height="277" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg1">
          <!--DWLayoutTable-->
          <tr>
            <td width="20" rowspan="6" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="10" style="width: 915px"></td>
                  <td width="22" rowspan="6" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
          <tr>
            <td height="104" valign="top" style="width: 915px"><div align="justify" class="text_titles_normal">
                &nbsp;&nbsp;
                <asp:Button ID="ButtonRegistration" runat="server" Text="Registration" OnClientClick="Patient Registration/main1.aspx" />
                <asp:Button ID="ButtonTreatment" runat="server" Text="Treatment" UseSubmitBehavior="False" />
                <asp:Button ID="ButtonPharmacy" runat="server" Text="Pharmacy" /></div></td>
                </tr>
          <tr>
            <td height="10" style="width: 915px"></td>
                </tr>
          <tr>
            <td height="25" valign="top" class="text_lables3" style="width: 915px"></td>
                </tr>
          <tr>
            <td height="10" style="width: 915px"></td>
                </tr>
          <tr>
            <td height="118" valign="top" style="width: 915px"></td>
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

