<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="AllEmployeeOpeningBalance.aspx.cs" Inherits="Leave_Management_AllEmployeeOpeningBalance" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="bxmain inner_content" style="width:100%">
        <h2><span>All Employees Opening Balance</span></h2>
        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="40%">Campus :
                </td>
                <td>
                    <asp:DropDownList ID="DDL_Campus" runat="server" DataSourceID="SqlDataSourceCampus"
                        DataTextField="Hospital_Name" DataValueField="Hospital_id" CssClass="drop_down"
                        AutoPostBack="True"
                        OnSelectedIndexChanged="DDL_Campus_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceCampus" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="select Hospital_id,Hospital_Name from Hospital"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">Department Name :
                </td>
                <td>
                    <asp:DropDownList ID="Dropdownlistdepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" TabIndex="5" CssClass="drop_down"
                         AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
                        SelectCommand="SELECT [Dept_Name], [Dept_ID] FROM [Department]  where Hospital_Id=@Hospital_Id ORDER BY [Dept_Name]">
                        <SelectParameters>
                            <asp:ControlParameter Name="Hospital_Id" ControlID="DDL_Campus" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">Sub Department Name :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_SubDepartment" runat="server" CssClass="drop_down"
                        DataSourceID="SqlDataSource_SubDept" DataTextField="SubDept_Name" DataValueField="SubDept_Id"
                        TabIndex="5"  AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_SubDept" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT SubDept_Id, SubDept_Name FROM SubDepartment WHERE (Dept_Id = @deptid)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="deptid" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">Employee Name :
                </td>
                <td>
                    <div style="border-style: solid; border-width: 0px; height: auto; width: auto; overflow-x: hidden; overflow-y: auto;">
                        <asp:CheckBoxList ID="CheckBoxList_Employee" runat="server" DataSourceID="SqlDataSource_Employee"
                            DataTextField="Employee Name" DataValueField="EmpID" RepeatColumns="3">
                        </asp:CheckBoxList>
                        <asp:Button ID="btnSelectAllEmployee" runat="server" OnClick="btnSelectAllEmployee_Click"
                            Text="Select All" />
                        <br />
                        <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            SelectCommand="SELECT EmpID, ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS [Employee Name], Is_Deleted FROM Employee WHERE (DeptID = @DeptID) AND (SubDeptId = @SubDeptId) AND (Is_Deleted = 0) ORDER BY [Employee Name]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="DropDownList_SubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">Leave Type :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_LeaveType" runat="server" AutoPostBack="True"
                        DataSourceID="SqlDataSource_LeaveType" DataTextField="Leave_Name" DataValueField="Type_Detail_id"
                        CssClass="drop_down">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_LeaveType" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
                        SelectCommand="SELECT Type_Detail_id, Leave_Name FROM Leave_Type_Detail WHERE isnull(Has_Opening,0) = 1 ORDER BY Leave_Name"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">Opening Date :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WDC_OpeningDate" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_OpeningDate" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right">Balance year :
                </td>
                <td>
                    <asp:DropDownList CssClass="drop_down" ID="DDLyearBalance" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Leave Balance :
                </td>
                <td>
                    <asp:TextBox ID="txtLeaveBalance" CssClass="input_txt" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr  style="display:none;">
                <td align="right">Without cash leaves :
                </td>
                <td>
                    <asp:TextBox ID="txtWithoutCashLeaves" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn_hacims" />
                    <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
    <asp:GridView ID="grdOpeningBalanace" runat="server" AutoGenerateColumns="False" AllowSorting="true"
        DataKeyNames="ID" DataSourceID="SqlDataSource_OpeningBalance" CssClass="Grid_1"
        Width="100%" EnableModelValidation="True">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="ID" Visible="False" />
            <asp:BoundField DataField="Employee Name" HeaderText="Employee Name" SortExpression="Employee Name"
                ReadOnly="True" />
            <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
            <asp:BoundField DataField="SubDept_Name" HeaderText="SubDept_Name" SortExpression="SubDept_Name" />
            <asp:BoundField DataField="Leave_Name" HeaderText="Leave_Name" SortExpression="Leave_Name" />
            <asp:BoundField DataField="On Date" HeaderText="On Date" SortExpression="On Date"
                ReadOnly="True" />
<asp:BoundField DataField="Balance_Year" HeaderText="Balance Year" SortExpression="Balance_Year" />
            <asp:BoundField DataField="Remaning Leaves" HeaderText="Opening Leaves" SortExpression="Remaning Leaves" />
            <%--<asp:BoundField DataField="Without Cash Leaves" HeaderText="Without Cash Leaves"  SortExpression="Without Cash Leaves" />--%>
            <asp:TemplateField HeaderText="Update Record" Visible="False">
                <ItemTemplate>
                    <asp:LinkButton ID="UpdateRecord" runat="server" CommandArgument='<%# Eval("ID") %>' OnClick="UpdateRecord_Click">Update Record</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
        </EmptyDataTemplate>
    </asp:GridView>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                        <ProgressTemplate>
                            <div style="position: fixed; text-align: center; height: 100%; width: 100%; top: 0; right: 0; left: 0; z-index: 9999999; background-color: #ffffff; opacity: 0.7;">
                                <span style="border-width: 0px; position: fixed; padding: 50px; background-color: #ffffff; font-size: 36px; left: 40%; top: 40%;">
                                    <img src="../images/progressbarimg.png" width="120px" height="120px" style="background: #ffffff" />
                                </span>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
    </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="SqlDataSource_OpeningBalance" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        SelectCommand="sp_LeaveOpeningBalance" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE Employee_Leave_Balance SET Emp_id = @Emp_id, Leave_Balance_Date = @Leave_Balance_Date, Leaves = @Leaves, Without_Cash_Leave = @Without_Cash_Leave, Dept_id = @Dept_id, Designation_id = @Designation_id WHERE (ID = @ID)"
        DeleteCommand="DELETE FROM Employee_Leave_Balance WHERE (ID = @id)">
        <DeleteParameters>
            <asp:Parameter Name="id" />
        </DeleteParameters>
        <SelectParameters>
            <asp:Parameter DefaultValue="-1" Name="emp_id" Type="Int32" />
            <asp:ControlParameter Name="Subdept_Id" ControlID="DropDownList_SubDepartment" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Emp_id" />
            <asp:Parameter Name="Leave_Balance_Date" />
            <asp:Parameter Name="Leaves" />
            <asp:Parameter Name="Without_Cash_Leave" />
            <asp:Parameter Name="Dept_id" />
            <asp:Parameter Name="Designation_id" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_ID" runat="server" />
</asp:Content>
