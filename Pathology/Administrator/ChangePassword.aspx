<%@ page language="VB" autoeventwireup="false" inherits="ChangePassword, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

                      
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
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
    <td width="23" height="550" valign="top" class="left_border"><img src="images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="40" colspan="2" valign="top"><img src="../images1/img_services.jpg" width="957" style="height: 40px" /></td>
      </tr>
      <tr>
        <td height="25" colspan="2" align="right" valign="middle" class="lnks_bg"><a href="../login.aspx" class="login_link">Home</a><span class="link_spliter">&nbsp;|&nbsp;</span><span class="link_spliter"><a href="hacims.aspx" class="login_link">About Hacims</a>&nbsp;|&nbsp;<a href="helphacims.aspx" class="login_link">Help</a>&nbsp;|&nbsp;</span><a href="../login.aspx" class="login_link2">Logout</a>&nbsp;&nbsp;</td>
          </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02">
                Change Password</td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="mainframe_bg16">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="2" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td height="448" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="917" height="22" valign="middle"><asp:Label  ID="Label1" runat="server"></asp:Label></td>
                      </tr>
                      <tr>
                        <td height="2"></td>
                      </tr>
                      <tr>
                        <td height="115" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="296" height="5"></td>
                              <td width="619"></td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle" ><span  style="width: 164px">User Name :&nbsp;</span></td>
                              <td valign="middle" >
                                <asp:TextBox ID="TextBoxUserName" runat="server"  Width="146px"  ></asp:TextBox>
                                <strong><span  style="width: 164px">
                                <asp:RequiredFieldValidator ControlToValidate="TextBoxUserName" 
                            Display="Dynamic" ErrorMessage="Enter User Name" ID="RequiredFieldValidatorUsername" runat="server"></asp:RequiredFieldValidator>
                              </span></strong>                           </td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle"><span  style="width: 164px">Password :&nbsp;</span></td>
                              <td valign="middle"><span style="width: 148px">
                                <asp:TextBox CssClass="d-active" ID="TextBoxOldPass" runat="server" TextMode="Password" Width="146px"></asp:TextBox>
                                <span style="vertical-align: top; width: 283px; text-align: left">
                                <asp:RequiredFieldValidator ControlToValidate="TextBoxPassword" CssClass="text_titles_bold"
                            Display="Dynamic" ErrorMessage="Enter Password" ID="RequiredFieldValidatorPassword" runat="server"></asp:RequiredFieldValidator>
                              </span></span></td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle"><span  style="width: 164px">&nbsp;New Password :&nbsp;</span></td>
                              <td valign="middle"><span style="width: 148px">
                                <asp:TextBox ID="TextBoxPassword" runat="server" TextMode="Password"  Width="146px"  ></asp:TextBox>
                                <span style="vertical-align: top; width: 283px; text-align: left">
                                <asp:CompareValidator ControlToCompare="TextBoxPassword"
                            ControlToValidate="TextBoxRePassword" CssClass="text_titles_bold" Display="Dynamic" ErrorMessage="Password And Re-Enter Feild are Not Same" ID="CompareValidatorCheckPassword" runat="server"
                            Width="280px"></asp:CompareValidator>
                              </span></span></td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle"><span  style="width: 164px; height: 21px">Re_Enter Password :&nbsp;</span></td>
                              <td valign="middle"><span style="width: 148px; height: 21px">
                                <asp:TextBox ID="TextBoxRePassword" runat="server" TextMode="Password"  Width="146px"  ></asp:TextBox>
                                <span style="vertical-align: top; width: 283px; text-align: left">
                                <asp:RequiredFieldValidator
                            ControlToValidate="TextBoxRePassword" CssClass="text_titles_bold" Display="Dynamic" ErrorMessage="Enter Re- Password" ID="RequiredFieldValidatorRePassword" runat="server"></asp:RequiredFieldValidator>
                              </span></span></td>
                            </tr>
                          <tr>
                            <td height="8"></td>
                              <td></td>
                            </tr>
                          
                          
                          
                          
                          
                          
                          

                        </table></td>
                      </tr>
                      <tr>
                        <td height="34" align="center" valign="middle"><span style="width: 148px; height: 21px">
                          <asp:Button ID="ButtonSave" runat="server" CssClass="bt2up" Text="Save"  onmousedown="this.className='bt2down'" onmouseover="this.className='bt2over'" onmouseout="this.className='bt2up'" />                          
                        </span></td>
                      </tr>
                      <tr>
                        <td height="274" valign="top"><span style="height: 19px">&nbsp;
                            <asp:HiddenField ID="HiddenFieldIP" runat="server" />
                                                </span><span style="vertical-align: top; width: 922px; height: 523px; text-align: left">
                        <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" SelectCommand="Select_Emp_Info" SelectCommandType="StoredProcedure"> 
                            <SelectParameters>
                                <asp:SessionParameter Name="DeptID" SessionField="Dept_ID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
&nbsp; &nbsp;&nbsp;
<asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString1 %>" InsertCommand="Update_Emp_Password" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:LGHConnectionString1.ProviderName %>">
  <InsertParameters>
    <asp:ControlParameter ControlID="TextBoxUserName" Name="UserName" PropertyName="Text"
                        Type="String" />
    <asp:ControlParameter ControlID="TextBoxOldPass" Name="OldPassword" PropertyName="Text"
                                  Type="String" />
    <asp:ControlParameter ControlID="TextBoxPassword" Name="NewPassword" PropertyName="Text"
                                  Type="String" />
    <asp:ControlParameter ControlID="HiddenFieldIP" Name="IPAddress" PropertyName="Value"
                                  Type="String" />
  </InsertParameters>
</asp:SqlDataSource>
&nbsp;&nbsp; </span></td>
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
