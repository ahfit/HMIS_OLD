<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Assign_Duty_To_SingleEmployee, App_Web_eqmkimbh" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style=" width:100%;">
    <h2><span>Assign Duty</span></h2>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" class="tbl_form" id="TABLE1">
            <tr>
                <td align="left" width="20%">
                    Start From :
                </td>
                <td width="30%">
                    <igsch:WebDateChooser ID="WebDateChooser1" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
                 <td align="left">
                    End Date :
                </td>
                <td width="30%">
                    <igsch:WebDateChooser ID="WebDateChooser2" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
           
            <tr>
                <td align="left">
                    Employees of
                    Department :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListDepartment" runat="server" Width="200px" AutoPostBack="True"
                        Css DataSourceID="SqlDataSourceDepartmentName" DataTextField="Dept_Name" DataValueField="Dept_ID">
                    </asp:DropDownList>
                </td>
                <td align="left">
                    Employee of
                    Sub Department :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListSubDepartment" runat="server" Width="200px" AutoPostBack="True"
                        Css DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name" DataValueField="SubDept_Id">
                    </asp:DropDownList>
                </td>
            </tr>
            
            <tr>
                <td align="left">
                    Duty Roster For Department :
                </td>
                <td>
                    <asp:DropDownList ID="DDlDutyRosterForDept" runat="server" Width="200px" AutoPostBack="True"
                        Css DataSourceID="SqlDataSourceDepartmentName" DataTextField="Dept_Name" DataValueField="Dept_ID">
                    </asp:DropDownList>
                </td>
                 <td align="left">
                   Duty Roster For Sub Department:
                </td>
                <td>
                    <asp:DropDownList ID="DDLDutyRosterForSubDept" runat="server" 
                        DataSourceID="SqlDataSource_DutyRosterSubDept" DataTextField="SubDept_Name" 
                        DataValueField="SubDept_Id" Width="200px" AutoPostBack="True">
                    </asp:DropDownList>
                </td>
            </tr>
          
            <tr>
                <td align="left">
                    Ward :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Ward" runat="server" 
                        DataSourceID="SqlDataSource_Ward" DataTextField="Ward_Name" 
                        DataValueField="Ward_id" Width="200px" AutoPostBack="True">
                    </asp:DropDownList>
                </td>
                <td align="left" style="width: 375px; height: 24px;">
                    Shift Name :&nbsp; <%--</strong>--%>
                </td>
                <td style="height: 24px">
                    <asp:DropDownList ID="DropDownListShiftName" runat="server" Width="200px" Css DataSourceID="SqlDataSourceShiftName"
                        DataTextField="ShiftName" DataValueField="Duty_Roster_ID" AutoPostBack="True">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="left">
                    Employee Name :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="SqlDataSourceEmployeeName" DataTextField="empolyeeName" 
                        DataValueField="EmpID" AutoPostBack="True">
                    </asp:DropDownList>
                </td>
                </tr>
                <tr>
                <td align="left">
                    Day of Week :
                </td>
                <td valign="top">
                    <asp:CheckBoxList ID="CheckBoxList_Day" runat="server" DataSourceID="SqlDataSourceDayofWeek"
                        DataTextField="Day_Name" DataValueField="Day_ID" RepeatColumns="3" RepeatDirection="Horizontal"
                        Width="100%" >
                    </asp:CheckBoxList>
                </td>
            </tr>

            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="ButtonSave" runat="server" Text="Save" />
                    <asp:LinkButton CssClass="login_link" ID="LinkButton1" runat="server" Visible="False">Show All Shift</asp:LinkButton>
                    <asp:Label ID="lblMsg" runat="server" Font-Bold="False" ForeColor="Red"></asp:Label></td>
            </tr>
        </table>
    </div>
    <br />
    <asp:GridView ID="GridViewEmployeeShift" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        AutoGenerateDeleteButton="True" CssClass="Grid_1" DataKeyNames="Emp_Duty_Roster"
        DataSourceID="SqlDataSourceEmployeeShift" Width="100%">
        <Columns>
            <asp:BoundField DataField="EMPLOYEE_NAME" HeaderText="Employee Name" ReadOnly="True"
                SortExpression="EMPLOYEE_NAME" />
            <asp:BoundField DataField="Dept_Name" HeaderText="Dept Name" SortExpression="Dept_Name" />
            <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Dept Name" SortExpression="SubDept_Name" />
            <asp:BoundField DataField="ShiftName" HeaderText="Shift Name" SortExpression="ShiftName" />
            <asp:BoundField DataField="start_Time" HeaderText="Start Time" ReadOnly="True" SortExpression="start_Time" />
            <asp:BoundField DataField="end_time" HeaderText="End Time" ReadOnly="True" SortExpression="end_time" />
            <asp:BoundField DataField="Day_Name" HeaderText="Day Name" SortExpression="Day_Name" />
            <asp:BoundField DataField="StartDuty_Date" HeaderText="StartDuty_Date" SortExpression="StartDuty_Date" />
            <asp:BoundField DataField="ENDDuty_Date" HeaderText="ENDDuty_Date" SortExpression="ENDDuty_Date" />
            <asp:BoundField DataField="Emp_Duty_Roster" HeaderText="Emp_Duty_Roster" InsertVisible="False"
                ReadOnly="True" SortExpression="Emp_Duty_Roster" />
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceEmployeeShift" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS EMPLOYEE_NAME, Department.Dept_Name, SubDepartment.SubDept_Name, Admin_Shift.ShiftName, CONVERT (varchar, Admin_DutyRoster.StartTime, 108) AS start_Time, CONVERT (varchar, Admin_DutyRoster.EndTime, 108) AS end_time, Week_Day.Day_Name, Admin_Employee_Duty_Roster.Emp_Duty_Roster, CONVERT (varchar, Admin_Employee_Duty_Roster.Duty_Start_Date, 107) AS StartDuty_Date, CONVERT (varchar, Admin_Employee_Duty_Roster.Duty_End_Date, 107) AS ENDDuty_Date, Admin_DutyRoster.Duty_Roster_ID FROM Admin_Employee_Duty_Roster INNER JOIN Admin_DutyRoster ON Admin_Employee_Duty_Roster.Duty_Roster_ID = Admin_DutyRoster.Duty_Roster_ID INNER JOIN Employee ON Admin_Employee_Duty_Roster.Emp_ID = Employee.EmpID INNER JOIN Week_Day ON Admin_Employee_Duty_Roster.Week_Day = Week_Day.Day_ID INNER JOIN Department ON Admin_DutyRoster.DeptID = Department.Dept_ID INNER JOIN SubDepartment ON Admin_DutyRoster.SubDeptId = SubDepartment.SubDept_Id INNER JOIN Admin_Shift ON Admin_DutyRoster.Shift_ID = Admin_Shift.ShiftID 
WHERE (Admin_DutyRoster.DeptID = @DeptID) AND (Admin_DutyRoster.SubDeptId = @SubDeptId) ANd CONVERT(datetime, convert(varchar,Admin_Employee_Duty_Roster.Duty_Start_Date,107))  >= @Duty_Start_Date  ORDER BY EMPLOYEE_NAME"
        
        DeleteCommand="DELETE FROM Admin_Employee_Duty_Roster WHERE (Emp_Duty_Roster = @Emp_Duty_Roster)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDlDutyRosterForDept" Name="DeptID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDLDutyRosterForSubDept" Name="SubDeptId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_Date_Start" Name="Duty_Start_Date" 
                PropertyName="Value" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridViewEmployeeShift" Name="Emp_Duty_Roster" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Department.Dept_Name + ' ( ' + Hospital.Hospital_Abb + ' )' AS Dept_Name, Department.Dept_ID FROM Department INNER JOIN Hospital ON Department.Hospital_ID = Hospital.Hospital_ID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Deptid)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDepartment" Name="Deptid" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        
        SelectCommand="SELECT     Employee.EmpID, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') 
                      + ' ' + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name + ') ' AS empolyeeName, Employee.DeptID, Employee.SubDeptId
FROM         Employee INNER JOIN
                      Designation ON Employee.DesignationID = Designation.Designation_ID
WHERE     (Employee.EmpID NOT IN
                          (SELECT Emp_ID FROM Admin_Employee_Duty_Roster
WHERE     (Duty_Start_Date = @Date_Start) AND (Duty_End_Date = @Date_End))) AND (Employee.DeptID = @DeptID) AND (Employee.SubDeptId = @SubDeptID)AND (Employee.ActiveStatus=1)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_Date_Start" Name="Date_Start" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Date_End" Name="Date_End" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceShiftName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Admin_Shift.ShiftName, Admin_DutyRoster.Duty_Roster_ID FROM Admin_DutyRoster INNER JOIN Admin_Shift ON Admin_DutyRoster.Shift_ID = Admin_Shift.ShiftID WHERE (Admin_DutyRoster.DeptID = @DeptID) AND (Admin_DutyRoster.SubDeptId = @SubDeptID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDlDutyRosterForDept" Name="DeptID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDLDutyRosterForSubDept" Name="SubDeptID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="INSERT INTO Admin_Employee_Duty_Roster(Duty_Roster_ID, Emp_ID, Duty_Start_Date, Duty_End_Date, Week_Day, Ward_Id) VALUES (@Duty_Roster_ID, @Emp_ID, @Start_Duty_Date, @Duty_End_Date, @Week_Day, @Ward_Id)"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="DropDownListShiftName" Name="Duty_Roster_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_Date_Start" Name="Start_Duty_Date" 
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Date_Start" Name="Duty_End_Date" 
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_WeekDay" Name="Week_Day" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Emp_ID" 
                PropertyName="SelectedValue" DefaultValue="" />
            <asp:ControlParameter ControlID="DropDownList_Ward" DefaultValue="0" Name="Ward_Id"
                PropertyName="SelectedValue" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDayofWeek" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        InsertCommand="INSERT INTO emp_DutyShift(ShiftName, StartTime, EndTime, DeptID, SubDeptId) VALUES (@ShiftName, @StartTime, @EndTime, @DeptID, @SubDeptId)"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Day_Name, Day_ID FROM Week_Day">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBoxShiftName" Name="ShiftName" PropertyName="Text" />
            <asp:ControlParameter ControlID="HiddenFieldStartTime" Name="StartTime" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldToTime" Name="EndTime" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptId" PropertyName="SelectedValue" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldFlag" runat="server" />
    <asp:HiddenField ID="HiddenField_MyDate" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Emp" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + &#13;&#10;ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name + ') ' AS &#13;&#10;empolyeeName, Employee.DeptID, Employee.SubDeptId &#13;&#10;FROM Employee INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID &#13;&#10;order by  Designation.Designation_ID &#13;&#10;WHERE (Employee.DeptID = @DeptID) AND (Employee.SubDeptId = @SubDeptID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDepartment" Name="DeptID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownListSubDepartment" Name="SubDeptID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_DutyRosterSubDept" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Deptid)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDlDutyRosterForDept" Name="Deptid" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_WeekDay" runat="server" />
    <asp:HiddenField ID="HiddenField_Date_End" runat="server" />
    <asp:HiddenField ID="HiddenField_Date_Start" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Ward" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        SelectCommand="Select_Hospital_Wards" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="Hospital_id" SessionField="HospitalID" Type="Int32" />
            <asp:ControlParameter ControlID="DDlDutyRosterForDept" Name="dept_id" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
