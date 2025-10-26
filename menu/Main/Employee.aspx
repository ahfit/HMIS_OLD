<%@ page language="VB" autoeventwireup="false" inherits="Employee, App_Web_ppbttiod" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="Paragma" content="no-cache"/>

<link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />



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
            <td width="937" valign="middle" class="text_lables3"><span class="text_lables3" style="height: 32px">Employee Record</span></td>
          </tr>
      
      
      
      
      
          <tr>
            <td height="453" colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <!--DWLayoutTable-->
                <tr>
                  <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                  <td width="917" height="10" valign="top"><img src="images1/img_spacer2.gif" width="2" height="10" /></td>
                  <td width="20" rowspan="3" valign="top"><img src="images1/img_spacer.gif" width="20" height="2" /></td>
                </tr>
                <tr>
                  <td height="412" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <!--DWLayoutTable-->
                    <tr>
                      <td height="22" colspan="3" valign="middle"><span><span style="vertical-align: top; text-align: left">
                        <asp:Label ID="LblInvalidDate" runat="server" ForeColor="Red" Width="167px"></asp:Label>
                        <asp:Label CssClass="text_labels" ID="Label1" runat="server"></asp:Label>
                        <asp:Label ID="Label_message" runat="server" Width="642px"></asp:Label>
                      </span></span></td>
                    </tr>
                    <tr>
                      <td width="50" style="height: 145px">&nbsp;</td>
                      <td width="824" valign="top" style="height: 145px"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="139" height="37" align="right" valign="middle" ><span  style="width: 164px">Title :&nbsp;</span></td>
                            <td colspan="4" valign="middle"><span style="width: 329px">
                              <asp:RadioButtonList CssClass="text_titles_bold" ID="prefix" runat="server" RepeatDirection="Horizontal" Width="253px">
                                <asp:ListItem Selected="True">Mr.</asp:ListItem>
                                <asp:ListItem>Miss</asp:ListItem>
                                <asp:ListItem>Mrs.</asp:ListItem>
                                <asp:ListItem>Dr.</asp:ListItem>
                              </asp:RadioButtonList>
                            </span></td>
                          </tr>
                          <tr>
                            <td align="right" valign="middle" style="height: 30px"><span  style="width: 164px">First Name :&nbsp;</span></td>
                            <td width="175" valign="middle" style="height: 30px"><span style="width: 329px">
                              <asp:TextBox ID="txtEFName" runat="server"  Width="146px"  ></asp:TextBox>
                            </span></td>
                            <td width="139" align="right" valign="middle" style="height: 30px"><span  style="width: 164px; height: 11px">Middle Name  :&nbsp;</span></td>
                            <td width="175" valign="middle" style="height: 30px"><span style="height: 25px; width: 329px;">
                              <asp:TextBox ID="txtEMName" runat="server"  Width="146px"  ></asp:TextBox>
                            </span></td>
                            <td width="194" valign="middle" style="height: 30px"><span style="vertical-align: top; text-align: left">
                              <asp:RequiredFieldValidator ControlToValidate="txtEFName" 
                Display="Dynamic" ErrorMessage="Please Enter First Name" ID="RequiredFieldValidatorPFName" runat="server"></asp:RequiredFieldValidator>
                            </span></td>
                          </tr>
                          <tr>
                            <td height="30" align="right" valign="middle"><span  style="width: 164px">Last Name :&nbsp;</span></td>
                            <td valign="middle"><span style="width: 329px">
                              <asp:TextBox ID="TxtELName" runat="server"  Width="146px"  ></asp:TextBox>
                            </span></td>
                            <td align="right" valign="middle"><span  style="width: 164px">Gender :&nbsp;</span></td>
                            <td valign="middle"><span style="width: 329px">
                              <asp:DropDownList  DataTextField="Gender"
                        DataValueField="Gender_ID" ID="Dropdownlistsex" runat="server" Width="100px" DataSourceID="SqlDataSourceGender"> </asp:DropDownList>
                            </span></td>
                            <td valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                          </tr>
                          <tr>
                            <td height="0"></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                          </tr>
                      </table></td>
                      <td width="43" style="height: 145px">&nbsp;</td>
                    </tr>
                    <tr>
                      <td style="height: 19px"></td>
                      <td align="right" valign="top" style="height: 19px"><img src="images1/img_shedow.gif" width="249" height="13" /></td>
                      <td style="height: 19px"></td>
                    </tr>
                    <tr>
                      <td height="10"></td>
                      <td></td>
                      <td></td>
                    </tr>
                    <tr>
                      <td height="128"></td>
                      <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="139" height="37" align="right" valign="middle"><span  style="width: 164px">CNIC No.  :&nbsp;</span></td>
                            <td width="175" valign="middle"><span class="text_labels_two" style="width: 329px">
                              <asp:TextBox ID="txtnic1" runat="server"  Width="35px"   MaxLength="5"></asp:TextBox>
                              -
                              <asp:TextBox ID="txtnic2"
                        runat="server"  Width="55px"   MaxLength="7"></asp:TextBox>
                              -
                              <asp:TextBox ID="txtnic3" runat="server"
                            Width="17px"   MaxLength="1"></asp:TextBox>
                            </span></td>
                            <td width="139" align="right" valign="middle"><span  style="width: 164px">Pay Scale  :&nbsp;</span></td>
                            <td width="175" valign="middle"><asp:DropDownList  ID="Dropdownlistpayscale" runat="server" Width="100px">
                                <asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                                <asp:ListItem>3</asp:ListItem>
                                <asp:ListItem>4</asp:ListItem>
                                <asp:ListItem>5</asp:ListItem>
                                <asp:ListItem>6</asp:ListItem>
                                <asp:ListItem>7</asp:ListItem>
                                <asp:ListItem>8</asp:ListItem>
                                <asp:ListItem>9</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>11</asp:ListItem>
                                <asp:ListItem>12</asp:ListItem>
                                <asp:ListItem>13</asp:ListItem>
                                <asp:ListItem>14</asp:ListItem>
                                <asp:ListItem>15</asp:ListItem>
                                <asp:ListItem>16</asp:ListItem>
                                <asp:ListItem>17</asp:ListItem>
                                <asp:ListItem>18</asp:ListItem>
                                <asp:ListItem>19</asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>21</asp:ListItem>
                            </asp:DropDownList></td>
                            <td width="194" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                          </tr>
                          <tr>
                            <td height="30" align="right" valign="middle"><span  style="width: 164px">Home Phone  :&nbsp;</span></td>
                            <td valign="middle"><span style="width: 329px">
                              <asp:TextBox ID="txthp1" runat="server"  Width="35px"  >0092</asp:TextBox>
                              -
                              <asp:TextBox
                        ID="txthp2" runat="server"  Width="25px"  >42</asp:TextBox>
                              -
                              <asp:TextBox ID="txthp3" runat="server"
                             Width="47px"  ></asp:TextBox>
                            </span></td>
                            <td align="right" valign="middle"><span  style="width: 164px">Home Address  :&nbsp;</span></td>
                            <td colspan="2" valign="middle"><span style="width: 329px">
                              <asp:TextBox ID="homeadd" runat="server"  Width="300px"  ></asp:TextBox>
                            </span></td>
                          </tr>
                          <tr>
                            <td height="30" align="right" valign="middle"><span  style="width: 164px">Office Phone :&nbsp;</span></td>
                            <td valign="middle"><span style="width: 329px">
                              <asp:TextBox ID="txtop1" runat="server"  Width="35px"  >0092</asp:TextBox>
                              -
                              <asp:TextBox
                        ID="txtop2" runat="server"  Width="25px"  >42</asp:TextBox>
                              -
                              <asp:TextBox ID="txtop3" runat="server"
                             Width="47px"  ></asp:TextBox>
                            </span></td>
                            <td align="right" valign="middle"><span  style="width: 164px">Office Address  :&nbsp;</span></td>
                            <td colspan="2" valign="middle"><span style="width: 329px">
                              <asp:TextBox ID="officeadd" runat="server"  Width="300px"  ></asp:TextBox>
                            </span></td>
                          </tr>
                          <tr>
                            <td height="30" align="right" valign="middle"><span  style="width: 164px">Join Date  :&nbsp;</span></td>
                            <td valign="top"><span style="width: 329px">
                              <asp:TextBox ID="txtday" runat="server"  Width="35px"  ></asp:TextBox>
                              -
                              <asp:TextBox ID="txtmonth"
                        runat="server"  Width="25px"  ></asp:TextBox>
                              -
                              <asp:TextBox ID="txtyear" runat="server"
                            Width="47px"  ></asp:TextBox>
                            </span></td>
                            <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                            <td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                            <td valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
                          </tr>
                      </table></td>
                      <td></td>
                    </tr>
                    <tr>
                      <td style="height: 19px"></td>
                      <td align="right" valign="top" style="height: 19px"><img src="images1/img_shedow.gif" width="249" height="13" /></td>
                      <td style="height: 19px"></td>
                    </tr>
                    <tr>
                      <td style="height: 19px"></td>
                      <td style="height: 19px"></td>
                      <td style="height: 19px"></td>
                    </tr>
                    <tr>
                      <td height="64"></td>
                      <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="139" height="33" align="right" valign="middle"><span  style="width: 164px">Designation  :&nbsp;</span></td>
                            <td width="175" valign="middle"><span style="width: 329px">
                              <asp:DropDownList 
                        DataTextField="Designation_Name" DataValueField="Designation_ID" ID="DropDownListdesignation" runat="server" Width="175px" DataSourceID="SqlDataSourceDesignation" TabIndex="4" AutoPostBack="True"> </asp:DropDownList>
                            </span></td>
                            <td width="139" align="right" valign="middle"><span  style="width: 164px">Department  :&nbsp;</span></td>
                            <td colspan="2" valign="middle"><span style="width: 329px">
                              <asp:DropDownList  DataTextField="Dept_Name"
                        DataValueField="Dept_ID" ID="Dropdownlistdepartment" runat="server" Width="305px" DataSourceID="SqlDataSourceDepartment" AutoPostBack="True" TabIndex="5"> </asp:DropDownList>
                            </span></td>
                          </tr>
                          <tr>
                            <td height="30" align="right" valign="middle"><span  style="width: 164px">Sub Department   :&nbsp;</span></td>
                            <td valign="middle"><span style="width: 329px">
                              <asp:DropDownList ID="DropDownListSubDepartment" runat="server" 
                        DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name" DataValueField="SubDept_Id"
                        Width="175px" TabIndex="6"> </asp:DropDownList>
                            </span></td>
                            <td align="right" valign="middle"><span  style="width: 164px">Profession  :&nbsp;</span></td>
                            <td width="175" valign="middle"><span style="width: 329px">
                              <asp:DropDownList ID="DropDownListProfession" runat="server"  DataSourceID="SqlDataSourceProfession"
                        DataTextField="Profession_Name" DataValueField="Profession_Code" Width="175px" TabIndex="7"> </asp:DropDownList>
                            </span></td>
                            <td width="194" valign="middle"><span style="width: 329px"> &nbsp;&nbsp;&nbsp;
                                  <asp:Button CssClass="bt2up" ID="ButtonSave" runat="server" Text="Save" onmousedown="this.className='bt2down'" onmouseover="this.className='bt2over'" onmouseout="this.className='bt2up'"/>                      
                            </span></td>
                          </tr>
                      </table></td>
                      <td></td>
                    </tr>
                    <tr>
                      <td height="13"></td>
                      <td align="right" valign="top"><img src="images1/img_shedow.gif" width="249" height="13" /></td>
                      <td></td>
                    </tr>
                    <tr>
                      <td height="29"></td>
                      <td valign="top"><span style="vertical-align: top; text-align: left">
                        <asp:RequiredFieldValidator ControlToValidate="homeadd" 
                Display="Dynamic" ErrorMessage="Please Enter Home Address" ID="RequiredFieldValidatorHomeAdd" runat="server"></asp:RequiredFieldValidator>
                        </span><span style="vertical-align: top; text-align: left">
                        <asp:RequiredFieldValidator ControlToValidate="txtnic2" 
                Display="Dynamic" ErrorMessage="Enter Correct CNIC No." ID="RequiredFieldValidatorNic2" runat="server"></asp:RequiredFieldValidator>
                        </span><span style="vertical-align: top; text-align: left">
                        <asp:RequiredFieldValidator ControlToValidate="txtnic3" 
                Display="Dynamic" ErrorMessage="Enter Correct CNIC No." ID="RequiredFieldValidatorNIC3" runat="server"></asp:RequiredFieldValidator>
                        </span><span style="vertical-align: top; text-align: left">
                        <asp:RegularExpressionValidator
                ControlToValidate="txtnic1"  Display="Dynamic" ErrorMessage="Enter Correct NIC" ID="RegularExpressionValidatorNIC1" runat="server"
                ValidationExpression="\d{5}"></asp:RegularExpressionValidator>
                        </span><span style="vertical-align: top; text-align: left">
                        <asp:RegularExpressionValidator
                ControlToValidate="txtnic2"  ErrorMessage="Enter Correct NIC" ID="RegularExpressionValidatorNIC2" runat="server"
                ValidationExpression="\d{7}" SetFocusOnError="True"></asp:RegularExpressionValidator>
                      </span></td>
                      <td></td>
                    </tr>
                    <tr>
                      <td height="72">&nbsp;</td>
                      <td colspan="2" valign="top"><asp:SqlDataSource ID="SqlDataSourceDesignation" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT [Designation_Name], [Designation_ID] FROM [Designation]"> </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceGender" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT Gender_ID, Gender FROM Gender" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department]" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        InsertCommand="Insert_Employee_Info"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" InsertCommandType="StoredProcedure">
                            <InsertParameters>
                              <asp:FormParameter FormField="prefix" Name="Prefix" />
                              <asp:FormParameter DefaultValue="" FormField="TxtEFName" Name="EFName" />
                              <asp:FormParameter DefaultValue="" FormField="TxtEMName" Name="EMName" />
                              <asp:FormParameter FormField="TxtELName" Name="ELName" />
                              <asp:SessionParameter Name="JoinDate" SessionField="EJDate" />
                              <asp:ControlParameter ControlID="HiddenFieldCNIC" Name="CNIC" PropertyName="Value" />
                              <asp:FormParameter FormField="DropdownlistDesignation" Name="DesignationID" />
                              <asp:FormParameter FormField="dropdownlistpayscale" Name="PayScale" />
                              <asp:ControlParameter ControlID="HiddenFieldHomePhone" Name="HPhoneNo" PropertyName="Value" />
                              <asp:ControlParameter ControlID="HiddenFieldOfficePhone" Name="OphoneNo" PropertyName="Value" />
                              <asp:FormParameter FormField="officeadd" Name="OfficeAdd" />
                              <asp:FormParameter FormField="homeadd" Name="HomeAdd" />
                              <asp:FormParameter FormField="DropdownlistSex" Name="SexID" />
                              <asp:FormParameter FormField="DropdownlistDepartment" Name="DeptID" />
                              <asp:FormParameter FormField="Dropdownlistsubdepartment" Name="SubDeptId" />
                              <asp:ControlParameter ControlID="DropDownListProfession" Name="Profession_Code" PropertyName="SelectedValue"
                          Type="Int32" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                          <asp:HiddenField ID="HiddenFieldCNIC" runat="server" />
                          <asp:HiddenField ID="HiddenFieldHomePhone" runat="server" />
                          <asp:HiddenField ID="HiddenFieldOfficePhone" runat="server" />
                          <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    SelectCommand="SELECT [SubDept_Id], [SubDept_Name] FROM [SubDepartment] WHERE ([Dept_Id] = @DeptId)" ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                            <SelectParameters>
                              <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptId" PropertyName="SelectedValue"
                            Type="Int32" />
                            </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceProfession" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                    ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" SelectCommand="SELECT Profession_Name, Profession_Code FROM Admin_Employee_Profession"> </asp:SqlDataSource>
                          <span style="height: 30px">
                          <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />                    
                          </span><span style="height: 30px">
                              <asp:ImageButton ID="ImageButtonlogout" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server" Visible="false" />
                          <span style="vertical-align: top; text-align: left">
                                <asp:RegularExpressionValidator
                ControlToValidate="txthp3"  Display="Dynamic" ErrorMessage="Enter Valid Home Phone No." ID="RegularExpressionValidatorHPhoneNO" runat="server"
                ValidationExpression="\d{7}"></asp:RegularExpressionValidator>
                                <asp:RegularExpressionValidator
                ControlToValidate="txtnic3"  Display="Dynamic" ErrorMessage="Enter Correct NIC" ID="RegularExpressionValidatorNIC3" runat="server"
                ValidationExpression="\d{1}"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ControlToValidate="txtnic1" 
                Display="Dynamic" ErrorMessage="Enter Correct CNIC No." ID="RequiredFieldValidatorCNIC" runat="server"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator
                ControlToValidate="txtop3"  ErrorMessage="Enter Valid Phone No." ID="RegularExpressionValidatorHphone" runat="server" ValidationExpression="\d{7}"></asp:RegularExpressionValidator>
                                <asp:RangeValidator ControlToValidate="txtday" 
                Display="Dynamic" ErrorMessage="Enter Valid Day" ID="RangeValidatorDay" MaximumValue="31" MinimumValue="01" runat="server"
                Type="Integer"></asp:RangeValidator>
                                <asp:RangeValidator ControlToValidate="txtmonth" 
                Display="Dynamic" ErrorMessage="Enter Valid Month" ID="RangeValidatorMonth" MaximumValue="12" MinimumValue="01" runat="server" Type="Integer"></asp:RangeValidator>
                                <asp:RangeValidator ControlToValidate="txtyear" 
                ErrorMessage="Enter Valid Year" ID="RangeValidatorYear" MinimumValue="1950" runat="server"></asp:RangeValidator>
                          </span></span>
                          <%--</td>
    <td width="32" valign="top" class="right_border" ><img src="images1/img_border_right.gif" width="23" height="15" /></td>
  </tr>
  
  <tr>
    <td height="24" colspan="3" valign="top"><img src="images1/img_border_bottom.gif" width="1003" height="24" /></td>
  </tr>
</table>--%></td>
                    </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="37" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
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

