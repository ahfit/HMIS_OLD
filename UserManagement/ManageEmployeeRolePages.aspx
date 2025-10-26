<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="UserManagement_ManageEmployeeRolePages, App_Web_gtm21hdb" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:Label ID="Label_message" runat="server" CssClass="err"></asp:Label>
 <div class="bxmain" style="margin-left: 10px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr>
                            <td width="40%" align="right">
                                Role :</td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Role" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceRole"
                                    DataTextField="Role" DataValueField="Role_Id">
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td align="right">
                                Module Name :</td>
                            <td>
                                <asp:DropDownList ID="DropDownListModuleName" runat="server" AutoPostBack="True"
                                    DataSourceID="SqlDataSourceModuleName" DataTextField="Module_Name" DataValueField="Module_ID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" visible="false" align="right">
                                Search Page:
                            </td>
                            <td>
                                <asp:TextBox ID="txtSeaarchPage" Visible="false" runat ="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <br />
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="50%" valign="top">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceForGridView"
                                Width="98%" Style="margin-left: 10px;" EmptyDataText="No Record Found" 
                                EnableModelValidation="True">
                                <FooterStyle CssClass="GridPager" />
                                <Columns>
                                    <%--<asp:TemplateField>
                                        <EditItemTemplate>
                                            <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images_hacims/icon_ok.gif"
                                                ToolTip="Update" /><asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel"
                                                    ImageUrl="~/images_hacims/icon_err.gif" ToolTip="Cancel" />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images_hacims/icon_edit.gif"
                                                OnClientClick="return confirmation_edit(this)" ToolTip="Edit" /><asp:ImageButton
                                                    ID="ImageButton2" runat="server" CommandName="Delete" ImageUrl="~/images_hacims/icon_delete.gif"
                                                    OnClientClick="return confirmation(this)" ToolTip="Delete" />
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField HeaderText="Module Name" SortExpression="Module_Name">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("Module_Name") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Module_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Page Name" SortExpression="Page_Name">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("Page_Name") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Page_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Priority" SortExpression="Priority">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBoxPriority" runat="server" Text='<%# Bind("Priority") %>'></asp:TextBox><br />
                                            <asp:HiddenField ID="HiddenFieldPage_ID" runat="server" Value='<%# Bind("Page_ID") %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Priority") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="URL" SortExpression="Page_URL">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label8" runat="server" Text='<%# Bind("Page_URL") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("Page_URL") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBoxSave" runat="server" Style="margin-left: 42px;" />
                                            <asp:HiddenField ID="HiddenField_Page_ID" runat="server" Value='<%# Bind("Page_ID", "{0}") %>' />
                                        </ItemTemplate>
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged"
                                                Style="margin-left: -5px;" />
                                        </HeaderTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="GridItem" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                            </asp:GridView>

                            <br />

                            <asp:Button ID="ButtonSave" runat="server" Text="Save" />
                            <asp:Button ID="ButtonCheckall" runat="server" Text="CheckAll" />
                            <asp:Button ID="ButtonUnCheck" runat="server" Text="UnCheckAll" />
                             <asp:Label ID="lblsaveInformation" runat="server" Text=""></asp:Label>
                        </td>
                        <td width="50%" valign="top">
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sqlDs_RolePages" width="100%"
                                DataKeyNames="User_Role_Pages_ID">
                                <Columns>
                                    <asp:CommandField ShowDeleteButton="True" />
                                    <asp:BoundField DataField="User_Role_ID" Visible="false" HeaderText="User_Role_ID" 
                                        SortExpression="User_Role_ID" />
                                    <asp:BoundField DataField="Module_ID" Visible="false" HeaderText="Module_ID" 
                                        SortExpression="Module_ID" />
                                    <asp:BoundField DataField="Page_ID" Visible="false" HeaderText="Page_ID" 
                                        SortExpression="Page_ID" />
                                    <asp:BoundField DataField="Module_Name" HeaderText="Module_Name" 
                                        SortExpression="Module_Name" />
                                    <asp:BoundField DataField="Page_Name" HeaderText="Page_Name" 
                                        SortExpression="Page_Name" />
                                    <asp:BoundField DataField="Page_URL" HeaderText="Page_URL" 
                                        SortExpression="Page_URL" />
                                    <%--<asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role" />
                                    <asp:BoundField DataField="Dept_Id" HeaderText="Dept_Id" 
                                        SortExpression="Dept_Id" />
                                    <asp:BoundField DataField="Dept_Name" HeaderText="Dept_Name" 
                                        SortExpression="Dept_Name" />--%>
                                </Columns>
                            </asp:GridView>   
                            <asp:SqlDataSource ID="sqlDs_RolePages" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>" 
                                SelectCommand="SELECT     User_Role_Pages.User_Role_Pages_ID, User_Role_Pages.User_Role_ID, User_Role_Pages.Module_ID, User_Role_Pages.Page_ID, 
                      Admin_User_Module_Pages.Page_Name, Admin_User_Module_Pages.Page_URL, Admin_User_Module.Module_Name, User_Roles.Role, User_Roles.Dept_Id, 
                      Department.Dept_Name
FROM         Department RIGHT OUTER JOIN
                      Admin_User_Module_Pages INNER JOIN
                      Admin_User_Module INNER JOIN
                      User_Role_Pages ON Admin_User_Module.Module_ID = User_Role_Pages.Module_ID INNER JOIN
                      User_Roles ON User_Role_Pages.User_Role_ID = User_Roles.Role_Id ON Admin_User_Module_Pages.Page_ID = User_Role_Pages.Page_ID AND 
                      Admin_User_Module_Pages.Module_ID = User_Role_Pages.Module_ID ON Department.Dept_ID = User_Roles.Dept_Id
Where User_Role_Pages.User_Role_ID = @RoleId Order By Admin_User_Module.Module_Name,Admin_User_Module_Pages.Page_Name" 
                                DeleteCommand="DELETE FROM User_Role_Pages WHERE (User_Role_Pages_ID = @User_Role_Pages_ID)" 
                                >
                                <DeleteParameters>
                                    <asp:ControlParameter ControlID="GridView2" Name="User_Role_Pages_ID" 
                                        PropertyName="SelectedValue" />
                                </DeleteParameters>
                                <SelectParameters>
                                    <asp:ControlParameter Name="RoleId" ControlID="DropDownList_Role" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>                     
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" valign="top" align="left">
                            <br />
                            
                            
                            <br />
                            <br />
                        </td>
                        <td>
                           
                        </td>
                        <td></td>
                    </tr>
                </table>


                <asp:HiddenField ID="HiddenFieldPageID" runat="server" />
                <asp:SqlDataSource ID="SqlDataSourceDeletePage" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
        DeleteCommand="DELETE FROM User_Role_Pages WHERE (User_Role_ID = @User_Role_ID) AND (Page_ID = @Page_ID)"
        ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenFieldPageID" Name="Page_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_Role" Name="User_Role_ID" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
        InsertCommand="[Insert_User_Role_Pages]" ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>"
        InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="DropDownList_Role" Name="User_Role_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownListModuleName" Name="Module_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenFieldPageID" Name="Page_ID" PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRole" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
        ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>" SelectCommand="SELECT Role_Id, Role FROM User_Roles">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceModuleName" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>" SelectCommand="SELECT Admin_User_Module.Module_Name + ' ( ' + ISNULL(Department.Dept_Name, '') + ' ) ' AS Module_Name, Admin_User_Module.Module_ID FROM Admin_User_Module LEFT OUTER JOIN Department ON Admin_User_Module.Dept_ID = Department.Dept_ID ORDER BY Module_Name">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
        DeleteCommand="DELETE FROM Admin_Employee_Module_Pages WHERE (ID = @DeleteID)"
        ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>" 
        SelectCommand="SELECT Admin_User_Module.Module_Name, Admin_User_Module_Pages.Page_Name, Admin_User_Module_Pages.Page_URL, &#13;&#10; Admin_User_Module_Pages.Priority, Admin_User_Module_Pages.Page_ID, Admin_User_Module_Pages.Module_ID&#13;&#10;FROM         Admin_User_Module INNER JOIN&#13;&#10;                      Admin_User_Module_Pages ON Admin_User_Module.Module_ID = Admin_User_Module_Pages.Module_ID&#13;&#10;WHERE     (Admin_User_Module_Pages.Module_ID = @Module_ID)"
        UpdateCommand="UPDATE Admin_User_Module_Pages SET Priority = @Priority WHERE (Page_ID = @Page_ID)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenFieldID" Name="DeleteID" PropertyName="Value" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListModuleName" Name="Module_ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldPriority" Name="Priority" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldPage_ID" Name="Page_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

