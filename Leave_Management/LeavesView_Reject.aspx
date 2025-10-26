<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LeavesView_Reject.aspx.vb"
    MasterPageFile="~/hacims_masterpage_admin.master" Inherits="LeavesView_Reject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span>Employees Approved / Rejected Leaves</span>
        </h2>

        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">

            <tr>
                <td align="right" width="40%">Department Name :</td>
                <td>
                    <asp:DropDownList ID="Dropdownlistdepartment" runat="server" CssClass="drop_down"
                        AutoPostBack="True" DataSourceID="SqlDataSourceDepartment"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" TabIndex="5">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Leave_ManagementConnectionString.ProviderName %>"
                        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department] ORDER BY [Dept_Name]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">Sub Department Name :</td>
                <td>
                    <asp:DropDownList ID="DropDownList_SubDepartment" runat="server" AutoPostBack="True" CssClass="drop_down"
                        DataSourceID="SqlDataSource_desg"
                        DataTextField="SubDept_Name" DataValueField="SubDept_Id" TabIndex="5">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_desg" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                        SelectCommand="SELECT SubDept_Id, SubDept_Name FROM SubDepartment WHERE (Dept_Id = @deptId)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="deptId"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                        SelectCommand="SELECT EmpID, ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name], Is_Deleted FROM Employee WHERE (DeptID = @deptId) AND (SubDeptId = @SubDeptId) AND (Is_Deleted = 0) ORDER BY [Employee Name]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID"
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="SubDeptId"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">Select Type:
                </td>
                <td align="left">
                    <asp:DropDownList ID="DDL_Type" runat="server" CssClass="drop_down">
                        <asp:ListItem Value="1" Text="Approved" />
                        <asp:ListItem Value="0" Text="Rejected" />
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" style="height: 18px">Employee Name :</td>
                <td style="height: 18px">
                    <asp:TextBox ID="txtEmployeeName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                

                <td colspan="2" align="center">
                    <asp:Button ID="btnSearch" CssClass="btn_hacims" runat="server" Text="Search" />
                </td>
            </tr>
        </table>
    </div>



    <br />




    <asp:GridView ID="GridView1" CssClass="Grid_1" ShowHeaderWhenEmpty="true" runat="server" AutoGenerateColumns="false" DataSourceID="SqlDataSource1"
        Width="100%">
        <Columns>
            <asp:BoundField DataField="EmployeeName" HeaderText="EmployeeName" SortExpression="EmployeeName" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation_Name" SortExpression="Designation_Name" />
            <asp:BoundField DataField="Dept_Name" HeaderText="Dept_Name" SortExpression="Dept_Name" />
            <asp:BoundField DataField="Requested_days" HeaderText="Requested Days" SortExpression="Requested_days" />
            <asp:BoundField DataField="salary_day" HeaderText="Salary Days" SortExpression="salary_day" />
            <asp:BoundField DataField="Start_Date" HeaderText="From Date" SortExpression="Start_Date" />
            <asp:BoundField DataField="End_Date" HeaderText="End Date" SortExpression="End_Date" />
            <asp:BoundField DataField="Leave_Type_Name" HeaderText="Leave Type" SortExpression="Leave_Type_Name" />
            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <asp:Label ID="lblStatus" Text='<%#Bind("CBExpression") %>' Font-Bold="true" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="GridItem" />
        <FooterStyle CssClass="GridPager" />
        <SelectedRowStyle CssClass="gridselect" />
        <HeaderStyle CssClass="GridHeader" />
        <EditRowStyle CssClass="gridedit" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        SelectCommand="SELECT distinct Employee_Leaves.Emp_Leave_Id,Leave_Types.Leave_Type_Name,Case when Employee_Leaves.is_approved is NULL then 1 else 0 end  HStatus,case when Employee_Leaves.is_approved is null then 'Approve/Reject' when Employee_Leaves.is_approved=0 then 'Rejected' else 'Approved' end CBExpression,
                            Employee_Leaves.Start_Date,Employee_Leaves.End_Date,Employee_Leaves.Requested_Days,Employee_Leaves.Salary_Day,Employee.EmpID, Employee.Prefix + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS EmployeeName, Designation.Designation_Name, Department.Dept_Name FROM  Employee INNER JOIN  Designation ON Employee.DesignationID = Designation.Designation_ID 
                            INNER JOIN  Department ON Employee.DeptID = Department.Dept_ID  INNER JOIN  Employee_Leaves ON Employee.EmpID = Employee_Leaves.Emp_Id  inner join Leave_Types on Employee_Leaves.Type_Detail_Id=Leave_Types.Leave_Type_Id
        WHERE (Employee_Leaves.is_Approved=@Status) and ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') like '%'+@Name+'%' and Employee.DeptID= @deptId and Employee.SubDeptId=@subDeptId">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtEmployeeName" Name="Name"
                PropertyName="Text" DefaultValue="%" />
            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="deptId"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="subDeptId"
                PropertyName="SelectedValue" />
             <asp:ControlParameter ControlID="DDL_Type" Name="Status"
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_Substitute" Name="Substitute" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_LeaveManagementId" Name="LeaveManagementId"
                PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
