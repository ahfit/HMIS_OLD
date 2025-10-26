<%@ page language="VB" autoeventwireup="false" inherits="admindmc_hr1, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
<link href="images1/st_sheet_02.css" rel="stylesheet" type="text/css" />



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
       <td height="73" colspan="2" valign="bottom" bgcolor="#F4F4F4" ><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>          </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_lables3"><span class="text_lables3" style="height: 32px">Administration</span></td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="loginnewbg">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td valign="top" style="width: 920px; height: 10px;"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td height="395" valign="top" style="width: 920px"><table width="100%" border="0" cellpadding="0" cellspacing="0" >
                    <!--DWLayoutTable-->
                    <tr>
                      <td width="917" height="395" valign="top" >
                      <asp:Label ID="Label_message" runat="server"></asp:Label><br />
                          &nbsp;
<br/>

<fieldset class="field" >

<legend class="text_heading_01">&nbsp;&nbsp;Basic Data Managment &nbsp;</legend>

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
<fieldset class="field" style="visibility: hidden">
    &nbsp;<span style="height: 90px"></span><span style="height: 90px">&nbsp;
</span>
</fieldset>
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      </td>
                      </tr>
                      <tr>
                          <td  valign="top" width="917">
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