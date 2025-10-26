<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="PayRoll_HeadPermission, App_Web_tchaehmk" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 8%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td align="right" class="style1">
                    Hospital :
                </td>
                <td width="25%">
                    <asp:DropDownList ID="dropdownlist_Hospital" runat="server" DataSourceID="SqlDataSource_Company"
                        DataTextField="Hospital_Name" DataValueField="Hospital_ID" Width="202px" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Company" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    Department :
                </td>
                <td width="25%">
                    <asp:DropDownList ID="Dropdownlistdepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" Width="202px" 
                        AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="SELECT Dept_Name, Dept_ID FROM Department where Hospital_ID = @Hospital ORDER BY Dept_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="dropdownlist_Hospital" Name="Hospital" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    Employee :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Employee" runat="server" 
                        DataSourceID="SqlDataSource_Employee" DataTextField="Name" 
                        DataValueField="EmpID" AutoPostBack="True" 
                        onselectedindexchanged="DropDownList_Employee_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>" 
                        SelectCommand="SELECT     EmpID, Name
FROM         Employee
WHERE     (DeptID = @DeptID) and (Is_Deleted = 0 or Is_Deleted is null) 
And EmpID Not In ( Select EmpId From Employee_Exclude_Salary ) ">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    SalaryHead:
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_SalaryHeads" runat="server" DataSourceID="SqlDataSource_SalaryHead"
                        DataTextField="Head_Name" DataValueField="E_ID">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_SalaryHead" runat="server" ConnectionString="<%$ ConnectionStrings:PayRollConnectionString %>"
                        SelectCommand="SELECT      E_ID, Sort_Order, Allowance_Deduction, Head_Name, BI_Report_Head FROM         Salary_Allowance_Deduction_Setup">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="style1">
                </td>
                <td>
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:GridView ID="GridView_Employee_Permission" runat="server" 
            AutoGenerateColumns="False" CssClass="Grid_1" DataKeyNames="id" 
            DataSourceID="SqlDataSource_HeadPermission" Width="100%">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id" Visible="False" />
                <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="True" 
                    SortExpression="Name" />
                <asp:BoundField DataField="Department" HeaderText="Department" 
                    SortExpression="Department" />
                <asp:BoundField DataField="Hospital_Name" HeaderText="Hospital_Name" 
                    SortExpression="Hospital_Name" />
                <asp:BoundField DataField="Head_Name" HeaderText="Head_Name" 
                    SortExpression="Head_Name" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDelete" runat="server" 
                            CommandArgument='<%# Eval("id") %>' onclick="lnkDelete_Click">Delete</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource_HeadPermission" runat="server" 
            ConnectionString="<%$ ConnectionStrings:PayRoll_ConnectionString %>" 
            DeleteCommand="Delete from HeadPermission where id = @id" 
            SelectCommand="usp_HeadAllowedPermission" SelectCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:ControlParameter ControlID="HiddenField_PermissionId" Name="id" 
                    PropertyName="Value" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList_Employee" DefaultValue="0" 
                    Name="empid" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="HiddenField_PermissionId" runat="server" />
    </div>
</asp:Content>
