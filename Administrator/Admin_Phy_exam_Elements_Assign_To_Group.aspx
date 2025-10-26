<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_Phy_exam_Elements_Assign_To_Group, App_Web_lwhdjlgh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>



 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



 <asp:Label ID="Label_message" runat="server" CssClass="err" ></asp:Label> 
<div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" >
                           
                          <tr>
                            <td  align="right" width="40%"  >Main Group Part  :&nbsp; </td>
                              <td colspan="3" width="60%"  ><asp:DropDownList AutoPostBack="True"  DataTextField="MG_Name" DataValueField="MG_Code" ID="DropDownListMGroup" runat="server" Width="250px" DataSourceID="SqlDataSourceMGroup"> </asp:DropDownList>                                </td>
      </tr>
                          <tr>
                            <td align="right"  >Element Name   :&nbsp;                            </td>
                            <td colspan="3"  ><asp:TextBox ID="TextBoxElementName" runat="server"  Width="244px" ></asp:TextBox></td>
                          </tr>
                          <tr>
                            <td height="30" align="right"  >&nbsp;</td>
                              <td colspan="3" ><asp:Button ID="ButtonSearch" runat="server"  Text="Search" />

                                <asp:Button
                    ID="ButtonSave" runat="server" Text="Save"   />                                                                
                                <asp:Label CssClass="err" ID="Label1" runat="server" ></asp:Label>
</td>
                          </tr>
                           
    </table></div><br />


<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="SqlDataSourceForGridView" Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="MG_Code" HeaderText="Group Code" InsertVisible="False"
                                        SortExpression="MG_Code" Visible="False" />
                                    <asp:BoundField DataField="MG_Name" HeaderText="Group Name" SortExpression="MG_Name" />
                                    <asp:BoundField DataField="e_Code" HeaderText="Element Code" InsertVisible="False"
                                        ReadOnly="True" SortExpression="e_Code" Visible="False" />
                                    <asp:BoundField DataField="e_Name" HeaderText="Element Name" SortExpression="e_Name" />
                                    <asp:BoundField DataField="e_Field_Type" HeaderText="Field Type" SortExpression="e_Field_Type" />
                                    <asp:TemplateField HeaderText="Alias">
                                        <ItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                            <asp:HiddenField ID="HiddenField_Ele_Code" runat="server" Value='<%# Bind("e_Code") %>' />
                                            <asp:HiddenField ID="HiddenField_Grp_Code" runat="server" Value='<%# Bind("MG_Code") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="GridItem" />
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
                        
                          <asp:SqlDataSource ID="SqlDataSourceMGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" SelectCommand="SELECT MG_Code, MG_Name FROM admin_Phy_Exam_MainGroup ORDER BY MG_Name" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" SelectCommand="SELECT admin_Phy_Exam_Elements.e_Code, admin_Phy_Exam_Elements.e_Name, admin_Phy_Exam_MainGroup.MG_Name, admin_Phy_Exam_Elements.e_Field_Type, admin_Phy_Exam_MainGroup.MG_Code FROM admin_Phy_Exam_Elements INNER JOIN admin_Phy_Exam_MainGroup ON admin_Phy_Exam_Elements.MG_Code = admin_Phy_Exam_MainGroup.MG_Code WHERE (admin_Phy_Exam_Elements.e_Name LIKE '%' + @e_Name + '%')" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
<SelectParameters>
    <asp:ControlParameter ControlID="TextBoxElementName" Name="e_Name" PropertyName="Text" />
</SelectParameters>
</asp:SqlDataSource>
                              <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                  InsertCommand="INSERT INTO Admin_Phy_Exam_Elememt_Assign_To_Group (MG_Code, e_Code, Alias, e_id) VALUES (@MG_Code, @e_Code, @Alias, @e_id)"
                                  ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                                  <InsertParameters>
                                      <asp:ControlParameter ControlID="DropDownListMGroup" Name="MG_Code" PropertyName="SelectedValue" />
                                      <asp:ControlParameter ControlID="HiddenFieldEle_Code" Name="e_Code" PropertyName="Value" />
                                      <asp:ControlParameter ControlID="HiddenFieldAlias" Name="Alias" PropertyName="Value" />
                                      <asp:ControlParameter ControlID="HiddenFieldE_Id" Name="e_id" PropertyName="Value" />
                                  </InsertParameters>
                              </asp:SqlDataSource>
                              <asp:HiddenField ID="HiddenFieldEle_Code" runat="server" />
                              <asp:HiddenField ID="HiddenFieldGroup_Code" runat="server" />
                              <asp:HiddenField ID="HiddenFieldAlias" runat="server" />
                              <asp:HiddenField ID="HiddenFieldE_Id" runat="server" /><br />
<br />

  </asp:Content>