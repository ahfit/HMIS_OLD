<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="UserManagement_ManageUserRoles, App_Web_gtm21hdb" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <div style="width:100%" class="main_Wrapper bxmain inner_content">
        <h2>
            <span>Manage User Role </span></h2>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr style="height:28px;">
                            <td style="width:30%;text-align:right;" >
                                Role Name :
                            </td>
                            <td style="width:45%;text-align:left;">
                                <asp:TextBox ID="txtRoleName" runat="server" Width="250px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="height:28px;">
                            <td style="width:30%;text-align:right;">Department:</td>
                            <td style="width:45%;text-align:left;">
                                <asp:DropDownList ID="ddldept" runat="server" AutoPostBack="True" Width="250px" AppendDataBoundItems="true" 
                                    DataSourceID="sdsDept" DataTextField="Dept_Name" DataValueField="Dept_ID">
                                    <asp:ListItem Text="" Value="0"></asp:ListItem>    
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="sdsDept" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>" 
                                    SelectCommand="SELECT [Dept_ID], [Dept_Name] FROM [Department] Order By [Dept_Name]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr style="height:28px;">
                            <td>
                                &nbsp;
                            </td>
                            <td style="padding-left:15px;">
                                <asp:HiddenField ID="hfldSelectedRoleId" runat="server" Value="0" />
                                <asp:Button ID="Button_Save_Role" runat="server" Text="Save" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br />
                            <div style="margin-left:10px;padding-bottom:10px;">    <asp:GridView ID="gvUserRoles" runat="server" AutoGenerateColumns="False"
                                    DataKeyNames="Role_Id" DataSourceID="SqlDataSource_SaveUserRole" Width="95%"
                                     >
                                    <Columns>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <%--<asp:LinkButton ID="lnkEdit" runat="server" OnClick="lnkEdit_Click" Text="Edit" CommandArgument='<%# Eval("Role_Id") %>'></asp:LinkButton>
                                                &nbsp;&nbsp;--%>
                                                <asp:LinkButton ID="lnkDelete" runat="server" OnClick="lnkDelete_Click" Text="Delete" CommandArgument='<%# Eval("Role_Id") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                        <asp:BoundField DataField="Role" HeaderText="Role Name" SortExpression="Role" />
                                        <asp:TemplateField HeaderText="Department">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDept" runat="server" Text='<%# Eval("Dept_Name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <AlternatingRowStyle CssClass="GridAltItem" />
                                </asp:GridView>
                                </div>
                            </td>
                        </tr>
                    </table>
                    </div>
                    <asp:HiddenField ID="HiddenField_roleId" runat="server" />
    <asp:HiddenField ID="HiddenField1" runat="server" />

     <asp:SqlDataSource ID="SqlDataSource_SaveUserRole" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
        DeleteCommand="usp_DeleteUserRole" ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>"
        SelectCommand="SELECT  Role_Id, Role,Dept_Name,Department.Dept_Id &#13;&#10;FROM User_Roles Left Outer Join Department ON User_Roles.Dept_Id = Department.Dept_Id" 
        UpdateCommand="UPDATE User_Roles SET Role = @Role,Dept_Id = @Dept_Id WHERE (Role_Id = @Role_Id)"
        InsertCommand="INSERT INTO User_Roles(Role,Dept_Id) VALUES (@Role,@Dept_Id)" 
        DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_roleId" Name="RoleId" 
                PropertyName="Value" Type="Int32" />
            
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Role" Type="String" />
            <asp:Parameter Name="Role_Id" Type="Int32" />
            <asp:Parameter Name="Dept_Id" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="txtRoleName" Name="Role" PropertyName="Text" />
            <asp:Parameter Name="Dept_Id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>

