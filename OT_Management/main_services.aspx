<%@ Page Language="VB" AutoEventWireup="false" CodeFile="main_services.aspx.vb" Inherits="main_services" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />

</head>

<body >
<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="551" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" background="images1/main_userarea.jpg"  style="background-repeat:no-repeat; background-position:bottom;">
      <!--DWLayoutTable-->
      <tr>
        <td height="1" colspan="6" valign="top"><img src="images1/space.png" width="957" height="1" /></td>
          </tr>
      <tr>
        <td height="40" colspan="6" valign="top"><img src="images1/img_services.jpg" width="957" height="40" /></td>
          </tr>
      <tr>
        <td height="25" colspan="6" align="right" valign="middle" bgcolor="#FFFFFF" class="lngks_bg"><span class="link_spliter"><a href="../hacims.aspx" class="login_link">About Hacims</a>&nbsp;|&nbsp;<a href="../helphacims.aspx" class="login_link">Help</a>&nbsp;|&nbsp;</span><a href="../login.aspx" class="login_link2">Logout</a>&nbsp;&nbsp;</td>
          </tr>
      <tr>
        <td width="64" height="71"></td>
        <td width="75"></td>
        <td width="154"></td>
        <td width="75">&nbsp;</td>
        <td width="287"></td>
        <td width="302"></td>
      </tr>
      
      
      <tr>
        <td height="25"></td>
        <td rowspan="3" align="center" valign="middle"><asp:ImageButton ID="ImageButtonPatientRegistration" ImageUrl="images1/img_bt_main2.gif" runat="server" /></td>
        <td></td>
        <td rowspan="3" align="center" valign="middle"><asp:ImageButton ID="ImageButton2" ImageUrl="Images1/img_bt_mlc1.gif"  runat="server" /></td>
        <td></td>
        <td></td>
      </tr>
      
      
      <tr>
        <td height="24"></td>
        <td valign="middle"><span >New Registration </span></td>
          <td valign="middle"><span >Hospital Reports</span></td>
          <td>&nbsp;</td>
      </tr>
      
      
      <tr>
        <td height="26"></td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      
      
        
        
        <tr>
          <td height="28"></td>
          <td rowspan="3" align="center" valign="middle"><asp:ImageButton ID="ImageButtonPatientSearch" ImageUrl="Images1/img_bt_main3.gif"  runat="server" /></td>
          <td></td>
          <td rowspan="3" align="center" valign="middle"><asp:ImageButton ID="ImageButton3" ImageUrl="Images1/img_bt_mlc1.gif"  runat="server" /></td>
          <td></td>
          <td></td>
        </tr>
        
        
        <tr>
          <td height="24"></td>
          <td valign="middle"><span class="text_titles_01new"><span >Patient Search </span> </span></td>
          <td valign="top" ><!--DWLayoutEmptyCell-->&nbsp;Search Deliver Reports</td>
          <td></td>
        </tr>
        
        
        <tr>
          <td height="23"></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        
        
        
        
        <tr>
          <td height="23"></td>
          <td rowspan="3" align="center" valign="middle"><asp:ImageButton ID="ImageButton4" ImageUrl="Images1/img_bt_mlc1.gif"  runat="server" /></td>
          <td></td>
          <td rowspan="3" valign="middle" align="center"><!--DWLayoutEmptyCell-->
              &nbsp;<asp:ImageButton ID="ImageButton7" ImageUrl="Images1/img_bt_mlc1.gif"  runat="server" /></td>
          <td></td>
          <td></td>
        </tr>
        
        
        <tr>
          <td height="25"></td>
          <td valign="middle"><span >Delivery Reports</span></td>
          <td valign="top" ><!--DWLayoutEmptyCell-->&nbsp;Hospital Patient</td>
          <td></td>
        </tr>
        
        
        <tr>
          <td height="27"></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        
        
        
        
        <tr>
          <td height="23">&nbsp;</td>
          <td rowspan="3" align="center" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;<asp:ImageButton ID="ImageButton5" ImageUrl="Images1/img_bt_mlc1.gif"  runat="server" /></td>
          <td></td>
          <td rowspan="3" valign="top" style="text-align: center"><!--DWLayoutEmptyCell--><asp:ImageButton ID="ImageButton6" ImageUrl="Images1/img_bt_mlc1.gif"  runat="server" /></td>
          <td></td>
          <td></td>
        </tr>
        
        
        <tr>
          <td height="21"></td>
          <td valign="middle"><!--DWLayoutEmptyCell-->
              <strong><span style="font-size: 8pt; font-family: Verdana">Test Results</span></strong></td>
          <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;<strong><span style="font-size: 8pt; font-family: Verdana">Search </span></strong>
          </td>
          <td></td>
        </tr>
        
        
        <tr>
          <td height="31"></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
            <td height="31" style="visibility: hidden">
            </td>
            <td align="center" rowspan="1" valign="middle" style="visibility: hidden">
                <asp:ImageButton ID="ImageButton1" ImageUrl="Images1/img_cmo_4.gif"  runat="server" /></td>
            <td style="visibility: hidden">
                <strong><span style="font-size: 8pt; font-family: Verdana">Hospital Patient</span></strong></td>
            <td rowspan="1" style="visibility: hidden;" valign="top">
            </td>
            <td style="visibility: hidden">
            </td>
            <td style="visibility: hidden">
            </td>
        </tr>
        
        
        <tr>
          <td style="height: 72px"></td>
          <td style="height: 72px">&nbsp;<asp:ImageButton ID="ImageButtonLogOut" ImageUrl="images/image_logout_up.gif" runat="server" Visible="false" /></td>
          <td style="height: 72px"></td>
          <td style="height: 72px"></td>
          <td style="height: 72px"></td>
          <td style="height: 72px"></td>
        </tr>
        
        
        
        
        
        
        
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    </table></td>
    <td width="33" valign="top" class="right_border" style="width: 33px"><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="images1/flash_01.js"></script>
</form>
</body>
</html>