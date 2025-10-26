<%@ page language="VB" autoeventwireup="false" inherits="Administrator_Admin_Set_Global_Values, App_Web_42zygch0" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
<link href="../../images/st_sheet_01.css" rel="stylesheet" type="text/css" />



</head>

<body onload="MM_preloadImages('../../images/img_bthover2.gif','../../images/img_btup2.gif')">

<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../../images/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="../../images/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="40" colspan="2" valign="top"><img src="../../images/top_header.jpg" width="957" height="100" /></td>
      </tr>
      <tr>
        <td height="25" colspan="2" align="right" valign="middle" class="lnks_bg"><a href="../admindmc.aspx" class="login_link">Back</a><span class="link_spliter">&nbsp;|&nbsp;</span><span class="link_spliter"><a href="../hacims.aspx" class="login_link">About Hacims</a>&nbsp;|&nbsp;<a href="../helphacims.aspx" class="login_link">Help</a>&nbsp;|&nbsp;</span><a href="../login.aspx" class="login_link2">Logout</a>&nbsp;&nbsp;</td>
          </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02">
                Set Global Values</td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="2" valign="top"><img src="../../images/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="../../images/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="2" valign="top"><img src="../../images/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td height="449" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="917" height="69" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          <!--DWLayoutTable-->
                            <tr>
                                <td align="right"  colspan="4" style="height: 37px; text-align: left"
                                    valign="middle">
                                    <asp:Label ID="LabelRegistration" runat="server"  Font-Bold="True"
                                        Font-Size="Medium" ForeColor="Red" Width="328px">Patient Registration</asp:Label></td>
                            </tr>
                          <tr>
                            <td width="180" height="37" align="right" valign="middle" ><strong>&nbsp;Department :&nbsp; </strong></td>
                              <td width="229" valign="middle"><asp:DropDownList AutoPostBack="True"  DataTextField="Dept_Name" DataValueField="Dept_ID" ID="DropDownListDepartment" runat="server" Width="180px" DataSourceID="SqlDataSourceDepartment"> </asp:DropDownList></td>
                              <td width="143" align="right" valign="middle"><strong >&nbsp;Sub Department :&nbsp;</strong></td>
                              <td width="363" valign="middle"><asp:DropDownList  DataTextField="SubDept_Name" DataValueField="SubDept_Id" ID="DropDownListSubDept" runat="server" Width="180px" DataSourceID="SqlDataSourceSubdpartment"> </asp:DropDownList></td>
                            </tr>
                          <tr>
                            <td height="30" align="right" valign="middle" >&nbsp;</td>
                              <td valign="middle"></td>
                              <td colspan="2" valign="middle"><span style="height: 34px">
                                <asp:Button ID="ButtonSave" runat="server" CssClass="bt1up" Text="Save"     />                                
                                <asp:Button ID="ButtonRefresh" runat="server" Text="Refresh"  CssClass="bt1up"    />                                                                
                                &nbsp;
                                <asp:Label  ForeColor="Red" ID="Label1" runat="server" Width="328px"></asp:Label>
                              </span></td>
                            </tr>
                          <tr>
                            <td height="0"></td>
                              <td></td>
                              <td></td>
                              <td></td>
                            </tr>
                          
                          
                          
                          
                          
                          
                          
                        </table></td>
                      </tr>
                      <tr>
                        <td height="13" align="right" valign="top"><img src="../../images/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td height="367" valign="top"><span style="text-align: center">&nbsp; &nbsp; &nbsp;</span>&nbsp;
                            <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Dept_Name, Dept_ID FROM Department">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlDataSourceSubdpartment" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Dept_ID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownListDepartment" Name="Dept_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                      </tr>
                      
                      
                      
                      
                      
                      
                      
                      

                      
                      
                      

                      
                      
                      
                      
                      
                      
                      

                      
                  </table></td>
                </tr>
                
                
                
                

                
                
                
                
                
                
                
                

          
          
          
          
          
          
            </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
            
    </table></td>
    <td width="32" valign="top" class="right_border" ><img src="../../images/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../../images/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="../../images/flash_01.js"></script>
</form>
</body>
</html>

