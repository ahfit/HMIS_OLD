<%@ page language="VB" autoeventwireup="false" inherits="CreateLogin1, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Lahore General Hospital</title>
<link href="../images1/st_sheet_01.css" rel="stylesheet" type="text/css" />


</head>

<body >

<form id="form1" runat = "server">

<table width="1003" border="0" cellpadding="0" cellspacing="0">
  <!--DWLayoutTable-->
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../images1/img_border_top.gif" width="1003" height="24" /></td>
  </tr>
  <tr>
    <td width="23" height="550" valign="top" class="left_border"><img src="../images1/img_border_left.gif" width="23" height="15" /></td>
    <td width="957" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
      <!--DWLayoutTable-->
      <tr>
        <td height="40" colspan="2" valign="top"><img src="../images1/top_header.jpg" width="957" height="100" /></td>
      </tr>
      <tr>
        <td height="25" colspan="2" align="right" valign="middle" class="lnks_bg"><a href="../admindmc.aspx" class="login_link">Back</a><span class="link_spliter">&nbsp;|&nbsp;</span><span class="link_spliter"><a href="../hacims.aspx" class="login_link">About Hacims</a>&nbsp;|&nbsp;<a href="../helphacims.aspx" class="login_link">Help</a>&nbsp;|&nbsp;</span><a href="../login.aspx" class="login_link2">Logout</a>&nbsp;&nbsp;</td>
          </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02"><span class="text_lables3">Create Login </span></td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="../images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="2" valign="top"><img src="../images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td height="449" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <!--DWLayoutTable-->
                      <tr>
                        <td width="917" height="62" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="234" height="5"></td>
                              <td width="681"></td>
                            </tr>
                          <tr>
                            <td height="25" align="right" valign="middle" ><div align="right">Employee Department &nbsp;:&nbsp;</div></td>
                              <td valign="middle"><span style="width: 148px">
                                <asp:DropDownList ID="DropDownListEDepartment" runat="server" DataSourceID="SqlDataSourceEDepartment"
                            DataTextField="Dept_Name" DataValueField="Dept_ID" Width="250px" AutoPostBack="True" Css> </asp:DropDownList>
                              </span></td>
                            </tr>
                          <tr>
                            <td height="25" valign="middle" ><div align="right">Employee Designation&nbsp; :&nbsp;</div></td>
                            <td valign="middle"><span style="width: 148px">
                              <asp:DropDownList ID="DropDownListDesignation" runat="server" AutoPostBack="True"
                            DataSourceID="SqlDataSourceEDesignation" DataTextField="Designation_Name" DataValueField="Designation_ID"
                            Width="250px" Css> </asp:DropDownList>
                              <span style="vertical-align: top; width: 283px; text-align: left">
                              <asp:CompareValidator ID="CompareValidatorCheckPassword" runat="server" ControlToCompare="TextBoxPassword"
                            ControlToValidate="TextBoxRePassword" Display="Dynamic" ErrorMessage="Password And Re-Enter Feild are Not Same"
                            Width="280px" ></asp:CompareValidator>
                              </span></span></td>
                          </tr>
                          <tr>
                            <td height="25" valign="middle" ><div align="right">Employee Name :&nbsp;</div></td>
                            <td valign="middle"><span style="width: 148px">
                              <asp:DropDownList ID="DropDownListEName" runat="server" DataSourceID="SqlDataSourceEName"
                            DataTextField="EName" DataValueField="EmpID" Width="250px" AutoPostBack="True" Css> </asp:DropDownList>
                            </span></td>
                          </tr>
                          <tr>
                            <td height="25" valign="middle" ><div align="right">User Name :&nbsp;</div></td>
                            <td valign="middle"><span style="width: 148px">
                              <asp:TextBox ID="TextBoxUserName" runat="server" Css Width="142px"></asp:TextBox>
                              <span style="vertical-align: top; width: 283px; text-align: left">
                              <asp:RequiredFieldValidator ID="RequiredFieldValidatorUsername" runat="server" ControlToValidate="TextBoxUserName"
                            Display="Dynamic" ErrorMessage="Enter User Name" ></asp:RequiredFieldValidator>
                              </span></span></td>
                          </tr>
                          <tr>
                            <td height="25" valign="middle" ><div align="right">Password :&nbsp;</div></td>
                            <td valign="middle"><span style="width: 148px; height: 21px">
                              <asp:TextBox ID="TextBoxPassword" runat="server" TextMode="Password" Css Width="143px"></asp:TextBox>
                              <span style="vertical-align: top; width: 283px; text-align: left">
                              <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword" runat="server" ControlToValidate="TextBoxPassword"
                            Display="Dynamic" ErrorMessage="Enter Password" ></asp:RequiredFieldValidator>
                              </span></span></td>
                          </tr>
                          <tr>
                            <td height="25" valign="middle" ><div align="right">Re-Enter Password :&nbsp;</div></td>
                            <td valign="middle"><span style="width: 148px; height: 21px">
                              <asp:TextBox ID="TextBoxRePassword" runat="server" TextMode="Password" Css Width="143px"></asp:TextBox>
                              <span style="vertical-align: top; width: 283px; text-align: left">
                              <asp:RequiredFieldValidator ID="RequiredFieldValidatorRePassword" runat="server"
                            ControlToValidate="TextBoxRePassword" Display="Dynamic" ErrorMessage="Enter Re- Password" ></asp:RequiredFieldValidator>
                              </span></span></td>
                          </tr>
                          <tr>
                            <td height="25" valign="middle" ><div align="right">Main Page :&nbsp;</div></td>
                            <td valign="middle"><span style="width: 148px; height: 19px">
                              <asp:TextBox ID="TextBoxMainPage" runat="server" Css Width="143px"></asp:TextBox>
                              <span style="vertical-align: top; width: 283px; text-align: left">
                              <asp:RequiredFieldValidator ID="RequiredFieldValidatorMainPage" runat="server" ControlToValidate="TextBoxMainPage"
                            ErrorMessage="Enter Main Page" ></asp:RequiredFieldValidator>
                              </span></span></td>
                          </tr>
                          <tr>
                            <td height="25" valign="middle" ><div align="right">Employee Type :&nbsp;</div></td>
                              <td valign="middle"><span style="width: 148px; height: 11px">
                                <asp:TextBox ID="TextBoxEType" runat="server" Css Width="143px"></asp:TextBox>
                                <span style="vertical-align: top; width: 283px; text-align: left">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorEType" runat="server" ControlToValidate="TextBoxEType"
                            ErrorMessage="Enter Employee Type" ></asp:RequiredFieldValidator>
                                </span></span></td>
                            </tr>
                          <tr>
                            <td height="5"></td>
                              <td></td>
                            </tr>
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                        </table></td>
                      </tr>
                      <tr>
                        <td height="0"></td>
                      </tr>
                      
                      <tr>
                        <td height="13" align="right" valign="top"><img src="../images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td height="22" valign="middle"><asp:Label ID="Label1" runat="server"  ></asp:Label></td>
                      </tr>
                      <tr>
                        <td height="33" align="center" valign="top"><span style="height: 25px">
                          <asp:Button ID="ButtonSave" runat="server" CssClass="bt2up" Text="Save"  onmousedown="this.className='bt2down'" onmouseover="this.className='bt2over'" onmouseout="this.className='bt2up'" />                          
                                                                                                                                                                                                </span></td>
                      </tr>
                      
                      <tr>
                        <td height="199" valign="top"><span style="vertical-align: top; width: 922px; height: 523px; text-align: left">
                          <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" SelectCommand="Emp_SelectEmployeeInfo" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListEDepartment" Name="DeptID" PropertyName="SelectedValue"
                        Type="Int32" />
                            </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceEDesignation" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT Designation_Name, Designation_ID FROM Designation"> </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceEName" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT EmpID, ISNULL(Prefix, ' ') + ' ' + ISNULL(EFName, ' ') + ' ' + ISNULL(EMName, ' ') + ' ' + ISNULL(ELName, ' ') AS EName FROM Employee WHERE (DesignationID = @DesignationID) AND (DeptID = @DepID)">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListDesignation" Name="DesignationID" PropertyName="SelectedValue" />
                              <asp:ControlParameter ControlID="DropDownListEDepartment" Name="DepID" PropertyName="SelectedValue" />
                            </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceEDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                SelectCommand="SELECT [Dept_ID], [Dept_Name] FROM [Department]"></asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenFieldDesignation" runat="server" />
                          <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" InsertCommand="Insert_CreateLogin" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                            <InsertParameters>
                              <asp:ControlParameter ControlID="TextBoxUserName" Name="UserName" PropertyName="Text"
                        Type="String" />
                              <asp:ControlParameter ControlID="TextBoxPassword" Name="Password" PropertyName="Text"
                        Type="String" />
                              <asp:ControlParameter ControlID="DropDownListEName" Name="EmpId" PropertyName="SelectedValue"
                        Type="Int32" />
                              <asp:ControlParameter ControlID="TextBoxMainPage" Name="Mainpage" PropertyName="Text"
                        Type="String" />
                              <asp:ControlParameter ControlID="TextBoxEType" Name="EmpType" PropertyName="Text"
                        Type="String" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                                                </span><span style="height: 30px">
                                                <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />                                                                                                                                                
                                                <asp:ImageButton ID="ImageButtonlogout" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server" Visible="false" />                                                
                                                </span></td>
                      </tr>
                      <tr>
                        <td height="1"></td>
                      </tr>
                      
                      
                      
                      
                      
                      
                      

                      
                      
                      

                      

                      
                      
                      
                      
                      
                      
                      

                      
                      
                      

                  </table></td>
                </tr>
                
                
                
                

                
                
                
                
                
                
                
                

          
          
          
          
          
          
            </table></td>
          </tr>
      
      
      
      
      
      
      
      
      
      
            
    </table></td>
    <td width="32" valign="top" class="right_border" ><img src="../images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="24" colspan="3" valign="top"><img src="../images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>
<script type="text/javascript" src="../images1/flash_01.js"></script>
</form>
</body>
</html>

