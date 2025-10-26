<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_History_Elements, App_Web_lwhdjlgh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


 

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 
 <asp:Label ID="Label_message" runat="server" CssClass="err"></asp:Label>
 <div class="bxmain">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                         
                          <tr>
                            <td width="25%" align="right"  >Main Group Part  : </td>
                              <td width="25%" ><asp:DropDownList AutoPostBack="True"  DataTextField="MG_Name" DataValueField="MG_Code" ID="DropDownListMGroup" runat="server" Width="250px" DataSourceID="SqlDataSourceMGroup"> </asp:DropDownList></td>
                              <td width="25%"  align="right" >Element Name   :</td>
                              <td width="25%" ><asp:TextBox ID="TextBoxElementName" runat="server"   Width="146px" ></asp:TextBox></td>
                            </tr>
    <tr>
        <td align="right"   >
            Element Datatype : 
        </td>
        <td   >
            <asp:DropDownList  DataTextField="DataTye" DataValueField="DataTye" ID="DropDownListDataType" runat="server" Width="250px" DataSourceID="SqlDataSourceDatatype"> </asp:DropDownList></td>
        <td align="right"   >
            Before Language : 
        </td>
        <td  >
            <asp:TextBox ID="TextBoxBefore" runat="server"  Width="145px"></asp:TextBox></td>
    </tr>
    <tr>
        <td align="right"    >
            After Language : 
        </td>
        <td   >
            <asp:TextBox ID="TextBoxAfter" runat="server"  Width="245px"></asp:TextBox></td>
        <td align="right"   >
            Group Para Start :
        </td>
        <td   >
            <asp:TextBox ID="TextBoxParaStart" runat="server"  Width="145px"></asp:TextBox></td>
    </tr>
                          
                         
                            <tr>
                            <td  align="right"  ></td>
                            <td colspan="3" ><asp:Button ID="ButtonSave" runat="server"  Text="Save"   />                                                                                                                                                        
                                <asp:Button
                    ID="Buttonrefresh" runat="server" Text="Refresh"   />                                                                
                              <asp:Label CssClass="err"  ID="Label1" runat="server" ></asp:Label></td>
                          </tr>
                            
                        </table></div>
<br />
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="e_Code" DataSourceID="SqlDataSourceForGridView" Width="100%"  >
                            <FooterStyle CssClass="GridPager" />                          
                            <Columns>
                                <asp:TemplateField>
                                    <EditItemTemplate>
                                        
                                        <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images_hacims/icon_ok.gif"  ToolTip="Update" /><asp:ImageButton
                                            ID="ImageButton4" runat="server" CommandName="Cancel" ImageUrl="~/images_hacims/icon_err.gif"  ToolTip="Cancel" />
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        
                                        <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif"   ToolTip="Edit"
                                            OnClientClick="return confirmation_edit(this)" /><asp:ImageButton ID="ImageButton2"
                                                runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"   ToolTip="Delete" OnClientClick="return confirmation(this)" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Main Group Name" SortExpression="MG_Name">
                                    <EditItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("MG_Name") %>'></asp:Label>
                                        
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("MG_Name") %>'></asp:Label>
                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="e_Name" HeaderText="Element Name" SortExpression="e_Name" />
                                <asp:TemplateField HeaderText="Field Type" SortExpression="e_Field_Type">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceDatatype1"
                                            DataTextField="DataTye" DataValueField="DataTye" SelectedValue='<%# Bind("e_Field_Type") %>'
                                            Width="177px">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSourceDatatype1" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="SELECT DataTye FROM Admin_ASP_Controls">
                                        </asp:SqlDataSource>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("e_Field_Type") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority" />
                                <asp:BoundField DataField="e_Code" HeaderText="Element Code" InsertVisible="False" ReadOnly="True"
                                    SortExpression="e_Code" />
                            </Columns>
                            <RowStyle CssClass="GridItem" />
                            <HeaderStyle CssClass="GridHeader" />                          
                            <AlternatingRowStyle CssClass="GridAltItem" />
                          </asp:GridView>
    
                           
                          <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                DeleteCommand="DELETE FROM admin_history_Elements WHERE (e_Code = @e_Code)"
                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="SELECT admin_History_MainGroup.MG_Name, admin_History_Elements.e_Name, admin_History_Elements.e_Field_Type, admin_History_Elements.e_Code, admin_History_Elements.Priority FROM admin_History_Elements INNER JOIN Admin_History_Elememt_Assign_To_Group ON admin_History_Elements.e_Code = Admin_History_Elememt_Assign_To_Group.e_Code INNER JOIN admin_History_MainGroup ON Admin_History_Elememt_Assign_To_Group.MG_Code = admin_History_MainGroup.MG_Code WHERE (Admin_History_Elememt_Assign_To_Group.MG_Code = @MG_Code)" UpdateCommand="UPDATE admin_History_Elements SET e_Name = @e_Name, e_Field_Type = @e_Field_Type, Priority = @Priority WHERE (e_Code = @e_Code)">
                            <DeleteParameters>
                              <asp:ControlParameter ControlID="GridView1" Name="e_Code" PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <SelectParameters>
                              <asp:ControlParameter ControlID="DropDownListMGroup" Name="MG_Code" PropertyName="SelectedValue" />
                            </SelectParameters>
                              <UpdateParameters>
                                  <asp:ControlParameter ControlID="HiddenFieldEName" Name="e_Name" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="HiddenFieldEType" Name="e_Field_Type" PropertyName="Value" />
                                  <asp:ControlParameter ControlID="GridView1" Name="e_Code" PropertyName="SelectedValue" />
                                  <asp:ControlParameter ControlID="HiddenFieldPriority" Name="Priority" PropertyName="Value" />
                              </UpdateParameters>
                          </asp:SqlDataSource>
                              
                          <asp:SqlDataSource ID="SqlDataSourceMGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" SelectCommand="SELECT MG_Code, MG_Name FROM admin_History_MainGroup&#13;&#10;order by MG_Name" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceDatatype" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>" SelectCommand="SELECT DataTye FROM Admin_ASP_Controls"></asp:SqlDataSource>
                          <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>" InsertCommand="[Admin_Insert_History_Element]" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                            <InsertParameters>
                              <asp:ControlParameter ControlID="DropDownListMGroup" Name="MG_Code" PropertyName="SelectedValue"
                        Type="Int32" />
                              <asp:ControlParameter ControlID="TextBoxElementName" Name="e_Name" PropertyName="Text"
                        Type="String" />
                              <asp:ControlParameter ControlID="DropDownListDataType" Name="e_Field_Type" PropertyName="SelectedValue"
                        Type="String" />
                            </InsertParameters>
                          </asp:SqlDataSource>
                              <asp:HiddenField ID="HiddenFieldEName" runat="server" />
                              <asp:HiddenField ID="HiddenFieldEType" runat="server" />
                        </span>
                            <asp:HiddenField ID="HiddenFieldEle_Code" runat="server" />
                            <asp:SqlDataSource ID="SqlDataSourceSaveInfo1" runat="server" ConnectionString="<%$ ConnectionStrings:Treatment_AdminConnectionString %>"
                                InsertCommand="INSERT INTO Admin_History_Elememt_Assign_To_Group(MG_Code, e_Code, Alias, e_id) VALUES (@MG_Code, @e_Code, @Alias, @e_id)"
                                ProviderName="<%$ ConnectionStrings:Treatment_AdminConnectionString.ProviderName %>">
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="DropDownListMGroup" Name="MG_Code" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="HiddenFieldEle_Code" Name="e_Code" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="TextBoxElementName" Name="Alias" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="HiddenFieldE_Id" Name="e_id" PropertyName="Value" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenFieldE_Id" runat="server" />
                            <asp:HiddenField ID="HiddenFieldPriority" runat="server" />
                        <br />
<br />
  </asp:Content>