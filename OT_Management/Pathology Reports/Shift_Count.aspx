<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Shift_Count.aspx.vb" Inherits="Pathology_Reports_Shift_Count" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital Lahore</title>
<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />


</head>

<body onload="MM_preloadImages('images1/img_bthover2.gif','images1/img_btup2.gif')">

<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_top.gif" alt="" width="1003" height="24" /></td>
  </tr>
  
  
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" alt="" width="23" height="15" /></td>
    <td width="957" valign="top">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td colspan="2" valign="bottom" ><iframe 
      src="tabs.aspx" name="holder" width="957" marginwidth="0" height="97" marginheight="0" 
      scrolling="No" frameborder="0" id="holder"></iframe></td>
      </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02">Pathology &gt;&gt; <span class="text_lables3">
                Shift Wise Report</span>&nbsp;</td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td height="10" colspan="2" valign="top" style="text-align: center"><img src="images1/img_spacer2.gif" width="2" height="10" />
                      <asp:Label ID="Label_message" runat="server" ></asp:Label></td>
                  <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                <td width="17" align="left" valign="middle" class="tabledottedleft"><!--DWLayoutEmptyCell-->&nbsp;</td>
                  <td width="715" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="715" height="39" valign="top"><table border="0" cellpadding="0" cellspacing="0"   style="width: 128%">
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="124" align="right" valign="middle"  style="height: 42px"><strong>&nbsp;&nbsp;Month :&nbsp; </strong></td>
                            <td width="175" valign="middle" style="height: 42px"><span style="height: 25px">
                                <asp:DropDownList ID="DropDownList_Month" runat="server" AutoPostBack="True" Width="224px">
                                    <asp:ListItem Value="1">January </asp:ListItem>
                                    <asp:ListItem Value="2">February  </asp:ListItem>
                                    <asp:ListItem Value="3">March</asp:ListItem>
                                    <asp:ListItem Value="4">April</asp:ListItem>
                                    <asp:ListItem Value="5">May</asp:ListItem>
                                    <asp:ListItem Value="6">June</asp:ListItem>
                                    <asp:ListItem Value="7">July</asp:ListItem>
                                    <asp:ListItem Value="8">Augest</asp:ListItem>
                                    <asp:ListItem Value="9">September</asp:ListItem>
                                    <asp:ListItem Value="10">October</asp:ListItem>
                                    <asp:ListItem Value="11">November</asp:ListItem>
                                    <asp:ListItem Value="12">December</asp:ListItem>
                                </asp:DropDownList></span></td>
                            <td width="53" align="right" valign="middle"  style="height: 42px">
                                &nbsp;Year :&nbsp;</td>
                            <td valign="middle" style="height: 42px; width: 159px;">
                                <asp:DropDownList ID="DropDownList_Year" runat="server" AutoPostBack="True" Width="224px">
                                </asp:DropDownList></td>
                            <td align="left" valign="middle" style="height: 42px" ><span style="vertical-align: top; text-align: left">
                              &nbsp;
                                                        </span></td>
                          </tr>
                            <tr>
                                <td align="right"  style="height: 22px" valign="middle" width="124">
                                    &nbsp;
                                </td>
                                <td style="height: 22px" valign="middle" width="175">
                                    </td>
                                <td align="right"  style="height: 22px" valign="middle" width="53">
                                </td>
                                <td style="width: 159px; height: 22px" valign="middle">
                                </td>
                                <td align="left" style="height: 22px" valign="middle">
                              </td>
                            </tr>
                        </table></td>
                      </tr>
                      <tr>
                        <td height="20" align="right" valign="top">
                            &nbsp;<img src="images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td height="386" valign="top" style="text-align: center">
                            <asp:GridView ID="GridView2" runat="server" >
                                <RowStyle CssClass="GridItem" />
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>
                                                        </td>
                      </tr> 
                                        
                  </table></td>
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
