<%@ page language="VB" autoeventwireup="false" inherits="Administrator_Admin_DMC_Template_Sub, App_Web_plqsd34j" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
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
            <td width="937" valign="middle" class="text_heading_02">
                Template &gt;&gt; <span class="text_lables3">Select Elements For Template</span></td>
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
                            <td width="179" align="right" valign="middle"  style="height: 37px"><strong>&nbsp;Category Name :&nbsp; </strong></td>
                              <td colspan="2" valign="middle" style="height: 37px"><asp:DropDownList AutoPostBack="True"  DataTextField="Category_Name" DataValueField="Category_ID" ID="DropDownListCategory_Name" runat="server" Width="202px" DataSourceID="SqlDataSourceCategory"> </asp:DropDownList></td>
                              <td width="151" align="right" valign="middle" style="height: 37px"><strong >Template Name : &nbsp;</strong></td>
                              <td width="306" valign="middle" style="height: 37px"><asp:DropDownList  DataTextField="Template_Name" DataValueField="Template_ID" ID="DropDownListTemplate" runat="server" Width="203px" DataSourceID="SqlDataSourceTemplate">
                              </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td align="right"  height="37" valign="middle" width="179">
                                    <strong>Main Group :&nbsp;</strong>
                                </td>
                                <td colspan="2" valign="middle">
                                    <asp:DropDownList AutoPostBack="True"  ID="DropDownListMainGroup" runat="server" Width="202px">
                                    </asp:DropDownList></td>
                                <td align="right" valign="middle" width="151">
                                    <strong><span style="font-size: 8pt; font-family: Verdana">Element Name :&nbsp;</span></strong></td>
                                <td valign="middle" width="306">
                                    <asp:DropDownList  ID="DropDownListElement" runat="server" Width="204px">
                                    </asp:DropDownList></td>
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
                        <td align="right" valign="top" style="height: 13px"><img src="../images1/img_shedow.gif" width="249" height="13" /></td>
                      </tr>
                      <tr>
                        <td height="355" valign="top"><span style="text-align: center">
                          <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%"  DataKeyNames="ID" DataSourceID="SqlDataSourceForGridView">
                            <FooterStyle CssClass="GridPager" />                          
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                              <Columns>
                                  <asp:CommandField ShowDeleteButton="True" />
                                  <asp:BoundField DataField="Category_Name" HeaderText="Category Name" SortExpression="Category_Name" />
                                  <asp:BoundField DataField="Template_Name" HeaderText="Template Name" SortExpression="Template_Name" />
                                  <asp:BoundField DataField="MG_Name" HeaderText="Main Group Name" SortExpression="MG_Name" />
                                  <asp:BoundField DataField="e_Name" HeaderText="Element Name" SortExpression="e_Name" />
                                  <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                      SortExpression="ID" Visible="False" />
                              </Columns>
                          </asp:GridView>
                          <span style="height: 507px">
                          <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>"
                DeleteCommand="DELETE FROM DMC_Template_Sub WHERE (ID = @ID)"
                ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="DMC_Insert_Doctor_Template_Sub" SelectCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue" />
                            </DeleteParameters>
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="DropDownListCategory_Name" Name="CID" PropertyName="SelectedValue"
                                      Type="Int32" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceCategory" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" SelectCommand="SELECT Category_Name, Category_ID FROM DMC_Category_For_Doctors"></asp:SqlDataSource><asp:SqlDataSource ID="SqlDataSourceMainGroup" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" SelectCommand="SELECT Category_Name, Category_ID FROM DMC_Category_For_Doctors">
                          </asp:SqlDataSource>
                              <asp:SqlDataSource ID="SqlDataSourceTemplate" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT Template_Name, Template_ID FROM DMC_Doctor_Template">
                              </asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceElement" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>" SelectCommand="SELECT DataTye FROM Admin_ASP_Controls"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:LGHConnectionString %>" InsertCommand="INSERT INTO DMC_Template_Sub(Category_ID, Element_ID, Temp_ID, Main_Group_ID) VALUES (@Category_ID, @ElementID, @Temp_ID, @Main_Group_ID)" ProviderName="<%$ ConnectionStrings:LGHConnectionString.ProviderName %>">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="DropDownListCategory_Name" Name="Category_ID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownListElement" Name="ElementID" PropertyName="SelectedValue" />
                                <asp:ControlParameter Name="Temp_ID" ControlID="DropDownListTemplate" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownListMainGroup" Name="Main_Group_ID" PropertyName="SelectedValue" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                          <asp:ImageButton ID="ImageButtonhome" ImageUrl="images/image_bt_home.gif" Width="64" Height="30" runat="server" Visible="false" />                                                    
                          <asp:ImageButton ID="ImageButtonback" ImageUrl="images/image_bt_back.gif" Width="66" Height="30" runat="server" Visible="false" />                                                    
                          <asp:ImageButton ID="ImageButtonlogout" ImageUrl="images/image_logout_up.gif" Width="71" Height="30" runat="server" Visible="false" />                          
                        </span></span></td>
                      </tr>
                      <tr>
                        <td height="12"></td>
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

