<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="UserManagement_ManageDepEmpRolePages, App_Web_gtm21hdb" enableeventvalidation="false" theme="theme_hacims" viewstateencryptionmode="Never" maintainscrollpositiononpostback="true" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .Grid_1 input
        {
            width: 15%;
        }
        .toMargin
        {
         margin-top:10px;   
         }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label CssClass="err" ID="Label_message" runat="server"></asp:Label>
    
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <cc1:ListSearchExtender ID="ListSearchExtender1" runat="server" TargetControlID="DropDownListEmployee">
    </cc1:ListSearchExtender>
    <div class="bxmain" style="width:100%;">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
            <tr>
                <td align="right" width="40%">
                    &nbsp;
                </td>
                <td>
                    <asp:SqlDataSource ID="SqlDataSource_Hospital" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Department Name :
                </td>
                <td>
                    <asp:DropDownList AutoPostBack="True" DataTextField="Dept_Name" DataValueField="Dept_ID"
                        ID="DropDownListDepartmentName" runat="server" DataSourceID="SqlDataSourceDepartmentName">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Sub Department Name :
                </td>
                <td>
                    <asp:DropDownList AutoPostBack="True" DataTextField="SubDept_Name" DataValueField="SubDept_Id"
                        ID="DropDownListSubDepartment" runat="server" DataSourceID="SqlDataSourceSubDepartmentName">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Employee Name :
                </td>
                <td>
                    <asp:DropDownList AutoPostBack="True" DataTextField="Employee Name" DataValueField="EmpID"
                        ID="DropDownListEmployee" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceEMployeeName">
                        <asp:ListItem Text=" --- Select ---" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                    Login Name :
                    <asp:Label ID="Label_LoginName" runat="server" Text="" CssClass="red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Role :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Role" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceRole"
                        DataTextField="Role" DataValueField="Role_Id">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                </td>
                <td align="left">
                    <asp:Button ID="ButtonCheckall" runat="server" Text="CheckAll" 
                        Visible="False" />
                    <asp:Button ID="ButtonUnCheck" runat="server" Text="UnCheckAll" 
                        Visible="False" />
                    <asp:Button ID="ButtonSave" runat="server" Text="Save" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div class="bxmain" style="width:100%;">
    <table  width="100%" cellspacing="0" cellpadding="0">   
        <tr>
            <td valign="top" width="25%" ><%--width="35%"--%>
            <div class="bxmain" style="width:95%;"">
                <h1 class="h1">
                    <span>Employee Roles</span></h1>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceForGridView"
                    Width="98%" EmptyDataText="No record found" DataKeyNames="Emp_ID,Role_ID">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role" />
                        <asp:BoundField DataField="Emp_ID" HeaderText="Emp_ID" SortExpression="Emp_ID" 
                            Visible="False" />
                        <asp:BoundField DataField="Role_ID" HeaderText="Role_ID" 
                            SortExpression="Role_ID" Visible="False" />
                    </Columns>
                    <RowStyle CssClass="GridItem" HorizontalAlign="Center" />
                    <FooterStyle CssClass="GridPager" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                </div>



                
              
            </td>
            <td valign="top" width="35%" ><%--"width="65% rowspan="2"--%>
                 <div class="bxmain" style="width:95%;">
            <h1 class="h1">
                    <span>Role Pages</span></h1>
                    
            
                <asp:GridView ID="gvRolePages" runat="server" Width="98%"
                    DataSourceID="SqlDataSourceRolePages" EnableModelValidation="True" 
                    AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="Module_ID,Page_ID" 
                    EmptyDataText="No record found">
                    <Columns>
                        <asp:BoundField DataField="Module_Name" HeaderText="Module Name" SortExpression="Module_Name" />
                        <asp:BoundField DataField="Page_Name" HeaderText="Page Name" SortExpression="Page_Name" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox  ID="chkAssignPage" runat="server" Width="104px" Checked="true" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            
                <asp:SqlDataSource ID = "SqlDataSourceRolePages" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
                    SelectCommand="SELECT DISTINCT Admin_User_Module_Pages.Page_Name, Admin_User_Module.Module_Name,
                                Admin_User_Module_Pages.Module_ID,Admin_User_Module_Pages.Page_ID
                                FROM User_Role_Pages INNER JOIN
                                Admin_User_Module ON User_Role_Pages.Module_ID = Admin_User_Module.Module_ID INNER JOIN
                                Admin_User_Module_Pages ON User_Role_Pages.Module_ID = Admin_User_Module_Pages.Module_ID
                                    And User_Role_Pages.Page_ID = Admin_User_Module_Pages.Page_ID 
                                   WHERE     (User_Role_Pages.User_Role_ID = @User_Role_ID)
                               ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList_Role" Name="User_Role_ID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>

                </div>
            </td>
            <td valign="top" width="40%">
                       
             <div class="bxmain" style="width:95%;"">
            
                <h1 class="h1" style="margin-left: 10px; width: 98%;">
                    <span>Employee Pages</span></h1>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" Width="98%"
                    Style="margin-left: 10px;" DataKeyNames="ID" 
                    DataSourceID="SqlDataSource_EmployeePages" AllowPaging="True" 
                    EnableModelValidation="True" EmptyDataText="No record found">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="Page #" InsertVisible="False" ReadOnly="True"
                            SortExpression="ID" />
                        <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role" />
                        <asp:BoundField DataField="Module_Name" HeaderText="Module Name" SortExpression="Module_Name" />
                        <asp:BoundField DataField="Page_Name" HeaderText="Page Name" SortExpression="Page_Name" />
                        <asp:BoundField DataField="Page_URL" HeaderText="Page URL" SortExpression="Page_URL" />
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                    <RowStyle CssClass="GridItem" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <PagerStyle CssClass="GridPager" />
                </asp:GridView>
                </div>
            </td>
       
        </tr>
       <%-- <tr>
            <td >
           
            </td>
            
            
        </tr>--%>
    </table>
    </div> <!--end bxmaim-->
    <br />
    <asp:SqlDataSource ID="SqlDataSourceForGridView" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
        DeleteCommand="Delete_Employee_Role" ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     User_Roles.Role, Admin_Employee_Role.Emp_ID, Admin_Employee_Role.Role_ID&#13;&#10;FROM         Admin_Employee_Role INNER JOIN&#13;&#10;                      User_Roles ON Admin_Employee_Role.Role_ID = User_Roles.Role_Id&#13;&#10;WHERE     (Admin_Employee_Role.Emp_ID = @Emp_ID)"
        UpdateCommand="UPDATE Admin_User_Module_Pages SET Priority = @Priority WHERE (Page_ID = @Page_ID)"
        DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="Emp_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="GridView2" Name="Role_ID" PropertyName="SelectedValue"
                Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListEmployee" Name="Emp_ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldPriority" Name="Priority" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldPage_ID" Name="Page_ID" PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDeletePage" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
        DeleteCommand="DELETE FROM Admin_Employee_Module_Pages WHERE (Page_ID = @Page_ID) AND (Emp_ID = @Emp_ID)"
        ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:ControlParameter ControlID="DropDownListEmployee" Name="Emp_ID" PropertyName="SelectedValue" />
            <asp:Parameter Name="Page_ID" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePageName" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>" SelectCommand="SELECT Page_Name, Page_ID FROM Admin_User_Module_Pages WHERE (Module_ID = @Module_ID)"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="Module_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_DeletePages" runat="server" />
    <asp:HiddenField ID="HiddenFieldPageID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        SelectCommand="SELECT distinct [Dept_Name], [Dept_ID] FROM [Department] 
ORDER BY [Dept_Name]">
        
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_EmployeePages" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
        DeleteCommand="DELETE FROM Admin_Employee_Module_Pages WHERE (ID = @ID)" ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>"
        
        
        SelectCommand="SELECT User_Roles.Role, Admin_User_Module.Module_Name, Admin_User_Module_Pages.Page_Name, 
  Admin_User_Module_Pages.Page_URL, Admin_Employee_Module_Pages.ID ,Admin_User_Module_Pages.Page_ID
  ,Admin_Employee_Module_Pages.Module_ID
  FROM User_Role_Pages INNER JOIN User_Roles ON User_Role_Pages.User_Role_ID = User_Roles.Role_Id 
  INNER JOIN Admin_Employee_Role On Admin_Employee_Role.Role_ID = User_Roles.Role_Id
  RIGHT OUTER JOIN Admin_Employee_Module_Pages INNER JOIN Admin_User_Module_Pages ON 
  Admin_Employee_Module_Pages.Page_ID = Admin_User_Module_Pages.Page_ID INNER JOIN Admin_User_Module 
  ON Admin_User_Module_Pages.Module_ID = Admin_User_Module.Module_ID ON 
  User_Role_Pages.Module_ID = Admin_Employee_Module_Pages.Module_ID AND 
  User_Role_Pages.Page_ID = Admin_Employee_Module_Pages.Page_ID And
  Admin_Employee_Role.Emp_ID = Admin_Employee_Module_Pages.Emp_ID
  WHERE (Admin_Employee_Module_Pages.Emp_ID = @Emp_ID) 
  ORDER BY Admin_User_Module.Module_Name">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListEmployee" Name="Emp_ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter Name="RoleId" ControlID="GridView2" 
                PropertyName="SelectedValue" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSubDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select_SubDept" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDepartmentName" Name="Dept_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEMployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="Select_Employee" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDepartmentName" Name="dept_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="sub_dept_ID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSaveINfo" runat="server" ConnectionString="<%$ ConnectionStrings:Users_ConnectionString %>"
        InsertCommand="Insert_Employee_Admin_Role" ProviderName="<%$ ConnectionStrings:Users_ConnectionString.ProviderName %>"
        InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="DropDownListEmployee" Name="Emp_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Role" Name="Role_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Role_ID" runat="server" />
    <asp:HiddenField ID="HiddenFieldPage_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceRole" runat="server" ConnectionString="<%$ ConnectionStrings:UsersConnectionString %>"
        ProviderName="<%$ ConnectionStrings:UsersConnectionString.ProviderName %>" 
        SelectCommand="SELECT Role_Id, Role FROM User_Roles">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDepartmentName" Name="Dept_Id" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldPriority" runat="server" />
    <br />
</asp:Content>


