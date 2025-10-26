<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master"
    CodeFile="Assign_Duty_To_Employee.aspx.vb" Inherits="Assign_Duty_To_Employee" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .empList {
            overflow-x: auto;
            height: 150px;
            border:1px solid black;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain">
        <div><h2><span>Assign Duty to Employee</span></h2></div>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" id="TABLE1">
            <tr>
                <td align="right" width="40%">
                    Start From :
                </td>
                <td width="60%">
                    <igsch:WebDateChooser ID="WebDateChooser1" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right">
                    End Date :
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser2" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Employees of
                    Department :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListDepartment" OnSelectedIndexChanged="DropDownListDepartment_SelectedIndexChanged" runat="server" Width="200px" AutoPostBack="True"
                          DataSourceID="SqlDataSourceDepartmentName" DataTextField="Dept_Name" DataValueField="Dept_ID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Employee of
                    Sub Department :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownListSubDepartment" OnSelectedIndexChanged="DropDownListSubDepartment_SelectedIndexChanged" runat="server" Width="200px" AutoPostBack="True"
                        Css DataSourceID="SqlDataSourceSubDepartment" DataTextField="SubDept_Name" DataValueField="SubDept_Id">
                    </asp:DropDownList>
                </td>
            </tr>
            
            
            
            
            <tr>
                <td align="right">
                    Duty Roster For Department :
                </td>
                <td>
                    <asp:DropDownList ID="DDlDutyRosterForDept" runat="server" Width="200px" AutoPostBack="True"
                          DataSourceID="SqlDataSourceDepartmentName" DataTextField="Dept_Name" DataValueField="Dept_ID">
                    </asp:DropDownList>
                </td>
            </tr>
            
            
            <tr>
                <td align="right">
                    Duty Roster For Sub Department :
                </td>
                <td>
                    <asp:DropDownList ID="DDLDutyRosterForSubDept" runat="server" 
                        DataSourceID="SqlDataSource_DutyRosterSubDept" DataTextField="SubDept_Name" 
                        DataValueField="SubDept_Id" Width="200px" AutoPostBack="True">
                    </asp:DropDownList>
                </td>
            </tr>
            
            <tr style="visibility:hidden">
                <td align="right">
                    Ward :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Ward" runat="server" 
                        DataSourceID="SqlDataSource_Ward" DataTextField="Ward_Name" 
                        DataValueField="Ward_id" Width="200px" AutoPostBack="True" Visible="false">
                    </asp:DropDownList>
                </td>
            </tr>
            
            
            
            <tr>
                <td align="right" style="width: 375px; height: 24px;">
                    Shift Name :&nbsp; <%--</strong>--%>
                </td>
                <td style="height: 24px">
                    <asp:DropDownList ID="DropDownListShiftName" runat="server" Width="200px" DataSourceID="SqlDataSourceShiftName"
                        DataTextField="ShiftName" DataValueField="Duty_Roster_ID" AutoPostBack="True">
                    </asp:DropDownList> Double Duty :
                    <asp:CheckBox ID="ckdobleduty" runat="server" />
                </td>
            </tr>

             <%--<%--<tr>
                <td align="right" style="width: 375px; height: 24px;">
                    Time Relaxation :&nbsp; <%--</strong>--%>
<%--                </td>
                <td style="height: 24px">
                    <asp:DropDownList ID="DDLRelaxationTime" runat="server" Width="200px" Css  AutoPostBack="True">
                        <asp:ListItem Value="0">0</asp:ListItem>
                        <asp:ListItem Value="1">1</asp:ListItem>
                        <asp:ListItem Value="2">2</asp:ListItem>
                        <asp:ListItem Value="3">3</asp:ListItem>
                        <asp:ListItem Value="4">4</asp:ListItem>
                        <asp:ListItem Value="5">5</asp:ListItem>
                        <asp:ListItem Value="6">6</asp:ListItem>
                        <asp:ListItem Value="7">7</asp:ListItem>
                        <asp:ListItem Value="8">8</asp:ListItem>
                        <asp:ListItem Value="9">9</asp:ListItem>
                        <asp:ListItem Value="10">10</asp:ListItem>
                        <asp:ListItem Value="11">11</asp:ListItem>
                        <asp:ListItem Value="12">12</asp:ListItem>
                        <asp:ListItem Value="13">13</asp:ListItem>
                        <asp:ListItem Value="14">14</asp:ListItem>
                        <asp:ListItem Value="15">15</asp:ListItem>
                        <asp:ListItem Value="16">16</asp:ListItem>
                        <asp:ListItem Value="17">17</asp:ListItem>
                        <asp:ListItem Value="18">18</asp:ListItem>
                        <asp:ListItem Value="19">19</asp:ListItem>
                        <asp:ListItem Value="20">20</asp:ListItem>
                        <asp:ListItem Value="21">21</asp:ListItem>
                        <asp:ListItem Value="22">22</asp:ListItem>
                        <asp:ListItem Value="23">23</asp:ListItem>
                        <asp:ListItem Value="24">24</asp:ListItem>
                        <asp:ListItem Value="25">25</asp:ListItem>
                        <asp:ListItem Value="26">26</asp:ListItem>
                        <asp:ListItem Value="27">27</asp:ListItem>
                        <asp:ListItem Value="28">28</asp:ListItem>
                        <asp:ListItem Value="29">29</asp:ListItem>
                        <asp:ListItem Value="30">30</asp:ListItem>

                    </asp:DropDownList>
                </td>
            </tr>--%>
              
           <%-- <tr>
                <td align="right">
                    Employee Name :
                </td>
                <td valign="top">
                    <asp:CheckBoxList ID="CheckBoxList_Emp" runat="server"  DataSourceID="SqlDataSourceEmployeeName"
                        DataTextField="empolyeeName" DataValueField="EmpID" RepeatColumns="1" RepeatDirection="Vertical"
                        Width="100%">
                    </asp:CheckBoxList>
                </td>
            </tr>--%>
                 <tr>
                <td align="right">Employee Name :
                </td>
                <td valign="top">
                    <div class="empList">
                        <asp:CheckBoxList ID="CheckBoxList_Emp" runat="server" DataSourceID="SqlDataSourceEmployeeName"
                            DataTextField="empolyeeName" DataValueField="EmpID" RepeatColumns="1" RepeatDirection="Vertical"
                            Width="100%" RepeatLayout="UnorderedList">
                        </asp:CheckBoxList>
                    </div>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Alternative :
                </td>
                <td valign="top">
                    <asp:RadioButtonList ID="ckAlternative" runat="server" AutoPostBack="true" RepeatColumns="3" RepeatDirection="Horizontal" OnSelectedIndexChanged="ckAlternative_SelectedIndexChanged"
                        Width="100%">
                        <asp:ListItem Value="0">Alternative</asp:ListItem>
                        <asp:ListItem Value="1" Selected="True">Week Days</asp:ListItem>
                        <%--<asp:ListItem Value="2" >Off Dates</asp:ListItem>--%>
                    </asp:RadioButtonList>
                    
                </td>
            </tr>
            
            <tr>
                <asp:Panel ID="Panel1" runat="server" Visible="false">
                <td align="right">
                    Month Days :
                </td>
                
                <td valign="top">
                      
                    <igsch:WebDateChooser ID="WebDateChooser3" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                  
                    <igsch:WebDateChooser ID="WebDateChooser4" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
               
                    <igsch:WebDateChooser ID="WebDateChooser5" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                
                    <igsch:WebDateChooser ID="WebDateChooser6" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
              
                    <igsch:WebDateChooser ID="WebDateChooser7" runat="server" CssClass="drop_date" Width="202px">
                        <AutoPostBack ValueChanged="True" />
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                
                </td>
                </asp:Panel>
            </tr>
            <tr>
                <td align="right">
                    Day of Week :
                </td>
                <td valign="top">
                    <asp:CheckBoxList ID="CheckBoxList_Day" runat="server" DataSourceID="SqlDataSourceDayofWeek"
                        DataTextField="Day_Name" DataValueField="Day_ID" RepeatColumns="3" RepeatDirection="Horizontal"
                        Width="100%">
                    </asp:CheckBoxList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    &nbsp;
                </td>
                <td>
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
        SelectCommand="SELECT ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') AS EMPLOYEE_NAME, Department.Dept_Name, SubDepartment.SubDept_Name, Admin_Shift.ShiftName, CONVERT (varchar, Admin_DutyRoster.StartTime, 108) AS start_Time, CONVERT (varchar, Admin_DutyRoster.EndTime, 108) AS end_time, Week_Day.Day_Name, Admin_Employee_Duty_Roster.Emp_Duty_Roster, CONVERT (varchar, Admin_Employee_Duty_Roster.Duty_Start_Date, 107) AS StartDuty_Date, CONVERT (varchar, Admin_Employee_Duty_Roster.Duty_End_Date, 107) AS ENDDuty_Date, Admin_DutyRoster.Duty_Roster_ID FROM Admin_Employee_Duty_Roster INNER JOIN Admin_DutyRoster ON Admin_Employee_Duty_Roster.Duty_Roster_ID = Admin_DutyRoster.Duty_Roster_ID INNER JOIN Employee ON Admin_Employee_Duty_Roster.Emp_ID = Employee.EmpID INNER JOIN Week_Day ON Admin_Employee_Duty_Roster.Week_Day = Week_Day.Day_ID INNER JOIN Department ON Admin_DutyRoster.DeptID = Department.Dept_ID INNER JOIN SubDepartment ON Admin_DutyRoster.SubDeptId = SubDepartment.SubDept_Id INNER JOIN Admin_Shift ON Admin_DutyRoster.Shift_ID = Admin_Shift.ShiftID WHERE (Admin_DutyRoster.DeptID = @DeptID) AND (Admin_DutyRoster.SubDeptId = @SubDeptId) AND (Admin_DutyRoster.Duty_Roster_ID = @Duty_Roster_ID) and Employee.ActiveStatus = 1 ORDER BY EMPLOYEE_NAME"
        DeleteCommand="DELETE FROM Admin_Employee_Duty_Roster WHERE (Emp_Duty_Roster = @Emp_Duty_Roster)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDlDutyRosterForDept" Name="DeptID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDLDutyRosterForSubDept" Name="SubDeptId" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DropDownListShiftName" Name="Duty_Roster_ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridViewEmployeeShift" Name="Emp_Duty_Roster" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDepartmentName" runat="server" ConnectionString="<%$ ConnectionStrings:DutyRoaster %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="select [Dept_Name], [Dept_ID] from Department where
 Dept_ID in ( select Dept_Id from subdepartment sub inner join EmployeeReportingAuthority e
                   on e.SubDeptID=sub.SubDept_Id where e.EmpID=@empid
   )">
        <SelectParameters>
            <asp:SessionParameter Name="empid" SessionField="emp_id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:DutyRoaster %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT SubDept_Name, SubDept_Id FROM SubDepartment WHERE (Dept_Id = @Deptid)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListDepartment" Name="Deptid" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEmployeeName" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>"
        SelectCommand="SELECT     Employee.EmpID, ISNULL(Employee.Prefix, ' ') + ' ' + ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') + ' (' + Designation.Designation_Name + ') ' AS empolyeeName, Employee.DeptID, Employee.SubDeptId FROM       Employee inner join  Designation ON Employee.DesignationID = Designation.Designation_ID WHERE  (Employee.DeptID = @DeptID) AND (Employee.SubDeptId = @SubDeptID) And Employee.ActiveStatus='true' ">
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
       InsertCommand="CreateShiftFinal" InsertCommandType="StoredProcedure"
           ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="DropDownListShiftName" Name="Duty_Roster_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HiddenField_MyDate" Name="Start_Duty_Date" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Date_End" Name="Duty_End_Date" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_WeekDay" Name="Week_Day" PropertyName="Value" />
             <asp:ControlParameter ControlID="HiddenField_DoubleDuty" Name="DoubleDuty" PropertyName="Value" />
           
            <asp:ControlParameter ControlID="HiddenFieldOff_Day" Name="Off_Day" PropertyName="Value" />
            <%--<asp:ControlParameter ControlID="DDLRelaxationTime" Name="Rel_time" PropertyName="SelectedValue" />--%>
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Emp_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList_Ward" DefaultValue="0" Name="Ward_Id"
                PropertyName="SelectedValue" />
            <asp:SessionParameter Name ="PreparedBy" SessionField="Emp_ID" Type="int32" />
            <asp:ControlParameter ControlID="DDlDutyRosterForDept" Name="ForDeptId" PropertyName="SelectedValue"/>
            <asp:ControlParameter ControlID="DDLDutyRosterForSubDept" Name="ForSubDeptId" PropertyName="SelectedValue"/>
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
     <asp:HiddenField ID="HiddenFieldIsComplicated" runat="server" />
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
    <asp:HiddenField ID="HiddenField_DoubleDuty" runat="server" />
    <asp:HiddenField ID="HiddenFieldOff_Day" runat="server" />
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
