<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Employee_Leaves_Detail, App_Web_gxw3jji3" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function backto() {
            history.go(-1);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="Panel_diary" runat="server" Width="100%">
    </asp:Panel>
    <asp:GridView ID="GridView6" runat="server">
    </asp:GridView>
    <br />
    <div class="bxmain">
        <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
            <tr>
                <td align="right" width="40%">
                    Year :
                </td>
                <td width="60%">
                    <asp:TextBox ID="TextBox_Year" runat="server" MaxLength="4"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox_Year"
                        ErrorMessage="Enter Valid Year" ValidationExpression="\d*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Month :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_month" runat="server" DataSourceID="SqlDataSource_month"
                        DataTextField="Month_Name" DataValueField="Month_No" Width="156px">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Leave Day :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Leave_Day" runat="server" MaxLength="3"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox_Leave_Day"
                        ErrorMessage="Enter Leave Day" ValidationExpression="\d*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td align="right" style="height: 18px">
                    Salary Day :
                </td>
                <td style="height: 18px">
                    <asp:TextBox ID="TextBox_Salary_Day" runat="server" MaxLength="3"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TextBox_Salary_Day"
                        ErrorMessage="Enter Valid Salary Day" ValidationExpression="\d*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Description :
                </td>
                <td>
                    <asp:TextBox ID="TextBox_Description" runat="server" Height="63px" TextMode="MultiLine"
                        Width="300px" MaxLength="1000"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                </td>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Save" />
                </td>
            </tr>
        </table>
    </div>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Leave_Type_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:Leave_ManagementConnectionString %>"
        SelectCommand="SELECT Employee_Leaves_Detail.Emp_Leave_Detail_Id, Employee_Leaves_Detail.Emp_Leave_Id, Employee_Leaves_Detail.Leave_Days, Employee_Leaves_Detail.Year, Employee_Leaves_Detail.Month, Employee_Leaves_Detail.Salary_Day, Employee_Leaves_Detail.Description, Employee_Leaves_Detail.emp_ID, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS [Employee Name], Year_Months.Month_Name, Leave_Type_Detail.Leave_Name FROM Employee_Leaves_Detail INNER JOIN Employee ON Employee_Leaves_Detail.emp_ID = Employee.EmpID INNER JOIN Year_Months ON Employee_Leaves_Detail.Month = Year_Months.Month_No INNER JOIN Employee_Leaves ON Employee_Leaves_Detail.Emp_Leave_Id = Employee_Leaves.Emp_Leave_Id INNER JOIN Leave_Type_Detail ON Employee_Leaves.Type_Detail_Id = Leave_Type_Detail.Type_Detail_id WHERE (Employee_Leaves_Detail.Emp_Leave_Id = @Emp_Leave_Id)"
        DeleteCommand="DELETE FROM [Employee_Leaves_Detail] WHERE [Emp_Leave_Detail_Id] = @Emp_Leave_Detail_Id"
        InsertCommand="INSERT INTO [Employee_Leaves_Detail] ([Emp_Leave_Id], [Leave_Days], [Year], [Month], [Salary_Day], [Description], [emp_ID]) VALUES (@Emp_Leave_Id, @Leave_Days, @Year, @Month, @Salary_Day, @Description, @emp_ID)"
        UpdateCommand="UPDATE [Employee_Leaves_Detail] SET [Emp_Leave_Id] = @Emp_Leave_Id, [Leave_Days] = @Leave_Days, [Year] = @Year, [Month] = @Month, [Salary_Day] = @Salary_Day, [Description] = @Description, [emp_ID] = @emp_ID WHERE [Emp_Leave_Detail_Id] = @Emp_Leave_Detail_Id">
        <SelectParameters>
            <asp:QueryStringParameter Name="Emp_Leave_Id" QueryStringField="Emp_Leave_Id" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Emp_Leave_Detail_Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Emp_Leave_Id" Type="Int32" />
            <asp:Parameter Name="Leave_Days" Type="Double" />
            <asp:Parameter Name="Year" Type="Int32" />
            <asp:Parameter Name="Month" Type="Int32" />
            <asp:Parameter Name="Salary_Day" Type="Double" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="emp_ID" Type="Int32" />
            <asp:Parameter Name="Emp_Leave_Detail_Id" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="Emp_Leave_Id" QueryStringField="Emp_Leave_Id" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_Leave_Day" Name="Leave_Days" PropertyName="Text"
                Type="Double" />
            <asp:ControlParameter ControlID="TextBox_Year" Name="Year" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_month" Name="Month" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_Salary_Day" Name="Salary_Day" PropertyName="Text"
                Type="Double" />
            <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text"
                Type="String" />
            <asp:QueryStringParameter Name="emp_ID" QueryStringField="Emp_Id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataKeyNames="Emp_Leave_Detail_Id"
        DataSourceID="SqlDataSource_Leave_Type_Detail" Width="100%" AllowPaging="True">
        <Columns>
            <asp:BoundField DataField="Leave_Name" HeaderText="Leave Name" SortExpression="Leave_Name" />
            <asp:BoundField DataField="Employee Name" HeaderText="Employee Name" SortExpression="Employee Name" />
            <asp:BoundField DataField="Month_Name" HeaderText="Month Name" SortExpression="Month_Name" />
            <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
            <asp:BoundField DataField="Leave_Days" HeaderText="Leave Days" SortExpression="Leave_Days" />
            <asp:BoundField DataField="Salary_Day" HeaderText="Salary Day" SortExpression="Salary_Day" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <FooterStyle CssClass="GridPager" />
        <SelectedRowStyle CssClass="gridselect" />
        <HeaderStyle CssClass="GridHeader" />
        <EditRowStyle CssClass="gridedit" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_month" runat="server" ConnectionString="<%$ ConnectionStrings:UVAS_HRConnectionString %>"
        SelectCommand="SELECT [Month_No], [Month_Name] FROM [Year_Months]"></asp:SqlDataSource>
</asp:Content>
