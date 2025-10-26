<%@ page language="VB" autoeventwireup="false" inherits="Administrator_Admin_Exam_Report_Language, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


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
        <td height="40" colspan="2" valign="top"><img src="../images1/img_services.jpg" width="957" height="40" /></td>
      </tr>
      <tr>
        <td height="25" colspan="2" align="right" valign="middle" class="lnks_bg"><a href="../admindmc.aspx" class="login_link">Back</a><span class="link_spliter">&nbsp;|&nbsp;</span><span class="link_spliter"><a href="../hacims.aspx" class="login_link">About Hacims</a>&nbsp;|&nbsp;<a href="../helphacims.aspx" class="login_link">Help</a>&nbsp;|&nbsp;</span><a href="../login.aspx" class="login_link2">Logout</a>&nbsp;&nbsp;</td>
          </tr>
      <tr>
        <td width="20" height="32" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            <td width="937" valign="middle" class="text_heading_02">History &gt;&gt; <span class="text_lables3">Element</span></td>
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
                        <td width="917" height="69" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0"  >
                          <!--DWLayoutTable-->
                          <tr>
                            <td width="179" height="37" align="right" valign="middle" ><strong>&nbsp;History Complaints :&nbsp; </strong></td>
                              <td colspan="2" valign="middle">
                                  <asp:DropDownList ID="DropDownListComplaint" runat="server" DataSourceID="SqlDataSourcePresentingComplaint"
                                      DataTextField="MG_Name" DataValueField="MG_Code" Width="226px" AutoPostBack="True">
                                  </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourcePresentingComplaint" runat="server"
                                      ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" SelectCommand="SELECT [MG_Code], [MG_Name] FROM [admin_dmc_phy_MainGroup]">
                                  </asp:SqlDataSource>
                              </td>
                              <td width="151" align="right" valign="middle"><strong >&nbsp;</strong></td>
                              <td width="306" valign="middle"></td>
                            </tr>
                          <tr>
                            <td height="30" align="right" valign="middle" ></td>
                              <td width="209" valign="middle"></td>
                              <td colspan="3" valign="middle"><asp:Button ID="ButtonSave" runat="server" CssClass="bt1up" Text="Save"     />                                                                                                                        
                                <asp:Button
                    ID="Buttonrefresh" runat="server" Text="Refresh" CssClass="bt1up"    />                                
                                <asp:Label  ForeColor="Red" ID="Label1" runat="server" ></asp:Label></td>
                            </tr>
                          <tr>
                            <td height="0"></td>
                              <td></td>
                              <td width="70"></td>
                              <td></td>
                              <td></td>
                            </tr>
                          
                          
                          
                          
                          
                          
                          
                        </table></td>
                      </tr>
                      <tr>
                        <td height="13" align="right" valign="top"><img src="../images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td height="367" valign="top"><span style="text-align: center">&nbsp;<span style="height: 507px">
                              <asp:SqlDataSource ID="SqlDataSourceSubTypeLanguage" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                  ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Sub_Type, Sub_Type_ID FROM Pt_Sub_Type_Complaint WHERE (Complaint_ID = @complaint_id)" UpdateCommand="UPDATE Pt_Sub_Type_Complaint SET Complaint_B_Language = @Complaint_B_Language, Complaint_A_Language = @Complaint_A_Language WHERE (Sub_Type_ID = @Sub_Type_ID)">
                                  <SelectParameters>
                                      <asp:ControlParameter ControlID="DropDownListComplaint" Name="complaint_id" PropertyName="SelectedValue" />
                                  </SelectParameters>
                                  <UpdateParameters>
                                      <asp:ControlParameter Name="Complaint_B_Language" ControlID="HiddenFieldBefore" PropertyName="Value" />
                                      <asp:ControlParameter Name="Complaint_A_Language" ControlID="HiddenFieldAfter" PropertyName="Value" />
                                      <asp:ControlParameter Name="Sub_Type_ID" ControlID="GridView1" PropertyName="SelectedValue" />
                                  </UpdateParameters>
                              </asp:SqlDataSource>
                              &nbsp; &nbsp;
                          <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />                                                    
                          <asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" Visible="false" />                                                    
                          <asp:ImageButton ID="ImageButtonlogout" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server" Visible="false" />                          
                              <asp:HiddenField ID="HiddenField2" runat="server" />
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                                    DataKeyNames="e_Code" DataSourceID="SqlDataSource_ComplaintLanguages" Width="844px">
                                    <Columns>
                                        <asp:CommandField ShowEditButton="True" />
                                        <asp:BoundField DataField="e_Code" HeaderText="e_Code" InsertVisible="False" ReadOnly="True"
                                            SortExpression="e_Code" Visible="False" />
                                        <asp:TemplateField HeaderText="B_Lanaguage" SortExpression="B_Lanaguage">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("B_Lanaguage") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("B_Lanaguage") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="e_Name" HeaderText="Elements" ReadOnly="True" SortExpression="e_Name" />
                                        <asp:TemplateField HeaderText="A_Language" SortExpression="A_Language">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("A_Language") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("A_Language") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="report_Sub_Group" SortExpression="report_Sub_Group">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("report_Sub_Group") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ele_Value_Required" SortExpression="ele_Value_Required">
                                            <EditItemTemplate>
                                                &nbsp;<asp:CheckBox ID="CheckBox1" runat="server" />
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("ele_Value_Required") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <HeaderStyle CssClass="GridHeader" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource_ComplaintLanguages" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                    SelectCommand="SELECT [e_Code]      &#13;&#10;      ,[e_Name]   &#13;&#10;       ,[BeforeLanguage] as B_Lanaguage&#13;&#10;      ,[AfterLanguage]    as A_Language&#13;&#10;      ,[ele_Value_Required]&#13;&#10;      ,[report_Sub_Group]&#13;&#10;  FROM [LGH].[dbo].[admin_dmc_phy_Elements]  WHERE (MG_Code = @mg_code)"
                                    UpdateCommand="UPDATE [admin_dmc_phy_Elements] SET BeforeLanguage = @B_Lanaguage, afterLanguage = @A_Language ,&#9;&#9;&#13;&#10;report_Sub_Group=@report_Sub_Group,ele_Value_Required=@ele_Value_Required&#13;&#10;&#13;&#10;WHERE (e_Code = @e_code)">
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="HiddenFieldBefore" Name="B_Lanaguage" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldAfter" Name="A_Lanaguage" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="GridView1" Name="e_code" PropertyName="SelectedValue" />
                                        <asp:ControlParameter ControlID="HiddenField_ElementValueReq" Name="ele_Value_Required"
                                            PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenField_ReportSubGroup" Name="report_Sub_Group"
                                            PropertyName="Value" />
                                    </UpdateParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownListComplaint" Name="mg_code" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                              <asp:HiddenField ID="HiddenFieldAfter" runat="server" />
                        </span></span>
                            <asp:HiddenField ID="HiddenFieldBefore" runat="server" /><asp:HiddenField ID="HiddenField_ReportSubGroup" runat="server" />
                            <asp:HiddenField ID="HiddenField_ElementValueReq" runat="server" />
                        </td>
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

