<%@ page language="VB" autoeventwireup="false" inherits="Administrator_Admin_General_Examination_Languages, App_Web_42zygch0" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

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
                                  <asp:DropDownList ID="DropDownListMainGroup" runat="server" DataSourceID="SqlDataSourceGeneralExam"
                                      DataTextField="MG_Name" DataValueField="MG_Code" Width="226px" AutoPostBack="True">
                                  </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceGeneralExam" runat="server"
                                      ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" SelectCommand="SELECT MG_Code, MG_Name FROM admin_dmc_phy_MainGroup">
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
                              &nbsp; &nbsp;
                          <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />                                                    
                          <asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" Visible="false" />                                                    
                          <asp:ImageButton ID="ImageButtonlogout" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server" Visible="false" />                          
                              <asp:HiddenField ID="HiddenField2" runat="server" />
                                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                                    DataKeyNames="e_Code" DataSourceID="SqlDataSource_ComplaintLanguages" Width="844px">
                                    <Columns>
                                        <asp:CommandField ShowEditButton="True" />
                                        <asp:TemplateField HeaderText="Before Language" SortExpression="BeforeLanguage">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("BeforeLanguage") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("BeforeLanguage") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="e_Name" HeaderText="Element Name" ReadOnly="True" SortExpression="e_Name" />
                                        <asp:BoundField DataField="e_Code" HeaderText="e_Code" InsertVisible="False" ReadOnly="True"
                                            SortExpression="e_Code" Visible="False" />
                                        <asp:TemplateField HeaderText="After Language" SortExpression="AfterLanguage">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("AfterLanguage") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("AfterLanguage") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle CssClass="GridItem" />
                                    <HeaderStyle CssClass="GridHeader" />
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource_ComplaintLanguages" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                                    SelectCommand="SELECT e_Name, e_Code, BeforeLanguage, AfterLanguage FROM admin_dmc_Phy_Elements&#13;&#10; WHERE (MG_Code = @MG_Code)"
                                    UpdateCommand="UPDATE admin_dmc_Phy_Elements SET BeforeLanguage = @BeforeLanguage, AfterLanguage = @AfterLanguage WHERE (e_Code = @e_Code)">
                                    <UpdateParameters>
                                        <asp:ControlParameter ControlID="HiddenFieldBefore" Name="BeforeLanguage" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="HiddenFieldAfter" Name="AfterLanguage" PropertyName="Value" />
                                        <asp:ControlParameter ControlID="GridView1" Name="e_Code" PropertyName="SelectedValue" />
                                    </UpdateParameters>
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DropDownListMainGroup" Name="MG_Code" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                              <asp:HiddenField ID="HiddenFieldAfter" runat="server" />
                        </span></span>
                            <asp:HiddenField ID="HiddenFieldBefore" runat="server" />
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

