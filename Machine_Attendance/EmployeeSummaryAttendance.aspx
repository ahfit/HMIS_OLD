<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="EmployeeSummaryAttendance.aspx.vb" Inherits="HR_EmployeeSummaryAttendance" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">


    </script>
    <style type="text/css">
        .style1 {
            width: 410px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:ScriptManager ID="scriptManager1" runat="server"></asp:ScriptManager>

    <div class="bxmain inner_content" style="width: 100%">
        <h2><span>Employee Attendance Summary</span></h2>

        <table class="tbl_form">
            <tr>
                <td align="right" class="style1">
                    <strong>Hospital :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Company" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Company" DataTextField="Hospital_Name"
                        DataValueField="Hospital_ID"
                        AutoPostBack="True" Style="margin-left: 0px">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Company" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]"></asp:SqlDataSource>




                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Branch" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Branch" DataTextField="Dept_Name"
                        DataValueField="Dept_ID" AutoPostBack="True">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                       ConnectionString="<%$ ConnectionStrings:DutyRoaster %>"
                        SelectCommand="select [Dept_Name], [Dept_ID] from Department where (Hospital_ID = @HospitalID)
and Dept_ID in ( select Dept_Id from subdepartment sub inner join EmployeeReportingAuthority e
                   on e.SubDeptID=sub.SubDept_Id where e.EmpID=@empid) ORDER BY Dept_Name">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Company" Name="HospitalID"
                                PropertyName="SelectedValue" />
                             <asp:SessionParameter Name="empid" SessionField="emp_id" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>




                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>Employee :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Sold_By" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Employee" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT 0 AS EmpID, ' ---ALL---' AS Name UNION 
SELECT     EmpID, ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee
WHERE     (@DeptID =0 or DeptID = @DeptID)  and (Employee.ActiveStatus=1)"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="DeptID"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>




                </td>
            </tr>

            <tr>
                <td align="right" class="style1">
                    <strong>Start Date :</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_Start_Date" runat="server" CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" class="style1">
                    <strong>End Date :</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_end_Date" runat="server" CssClass="drop_down">
                       
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_end_Date" runat="server" />
                </td>
            </tr>

            <tr style="visibility: hidden">
                <td align="right" class="style1">
                    <strong>Emp No :</strong></td>
                <td colspan="2"></b>
               <%-- <asp:TextBox ID="TextBox_Emp" runat="server"></asp:TextBox>
                <asp:HiddenField ID="HiddenField_empNo" runat="server" />--%>




                    <asp:TextBox ID="txtbox_EmpNo" runat="server"></asp:TextBox>




                </td>
            </tr>

            <tr >
                <td align="right" class="style1">
                    <strong>Employee Attendance :</strong></td>
                <td colspan="2">
                   <%-- <asp:RadioButtonList ID="RBL_Emp_stat" runat="server"
                        RepeatDirection="Horizontal">
                        <asp:ListItem Value="3">All</asp:ListItem>
                        <asp:ListItem Selected="True" Value="1">Active</asp:ListItem>
                        <asp:ListItem Value="0">Deactive</asp:ListItem>
                        <asp:ListItem Value="2">Ex-employee</asp:ListItem>
                    </asp:RadioButtonList>--%>
                     <asp:RadioButtonList ID="RBL_Emp_stat" runat="server"
                        RepeatDirection="Horizontal">
                        <%--<asp:ListItem Value="0" Selected="True">Over All Attendance</asp:ListItem>--%>
                        <%--<asp:ListItem  Value="1">Short Attendance</asp:ListItem>--%>
                        <%--<asp:ListItem Value="2">Half Day Attendance</asp:ListItem>--%>
                        <asp:ListItem Selected="True" Value="3">Over Time</asp:ListItem>
                         <asp:ListItem  Value="4">Early Out</asp:ListItem>
                        <asp:ListItem Value="5">Late Attendance</asp:ListItem>
                    </asp:RadioButtonList>




                </td>
            </tr>
            <tr>
            <td align="right" class="style1">
                <strong>Salary Month :</strong></td>
            <td>
                <asp:DropDownList ID="DDLForMonth" runat="server"  Width="100px">


                    <asp:ListItem Value="1">January</asp:ListItem>
                            <asp:ListItem Value="2">February</asp:ListItem>
                            <asp:ListItem Value="3">March</asp:ListItem>
                            <asp:ListItem Value="4">April</asp:ListItem>
                            <asp:ListItem Value="5">May</asp:ListItem>
                            <asp:ListItem Value="6">June</asp:ListItem>
                            <asp:ListItem Value="7">July</asp:ListItem>
                            <asp:ListItem Value="8">August</asp:ListItem>
                            <asp:ListItem Value="9">September</asp:ListItem>
                            <asp:ListItem Value="10">October</asp:ListItem>
                            <asp:ListItem Value="11">November</asp:ListItem>
                            <asp:ListItem Value="12">December</asp:ListItem>


                </asp:DropDownList>
                  <%-- <igsch:webdatechooser id="WebDateChooser_Start_Date" runat="server" CssClass="drop_down">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:webdatechooser>
        <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />--%>
           
                        <asp:DropDownList ID="DDLForYear" runat="server"  Width="60px">
                            <asp:ListItem Value="2021">2021</asp:ListItem>
                            <asp:ListItem Value="2022">2022</asp:ListItem>
                            <asp:ListItem Value="2023">2023</asp:ListItem>
                            <asp:ListItem Value="2024">2024</asp:ListItem>
                            <%--<asp:ListItem Value="2025">2025</asp:ListItem>
                            <asp:ListItem Value="2026">2026</asp:ListItem>
                            <asp:ListItem Value="2027">2027</asp:ListItem>
                            <asp:ListItem Value="2028">2028</asp:ListItem>
                            <asp:ListItem Value="2029">2029</asp:ListItem>
                            <asp:ListItem Value="2030">2030</asp:ListItem>
                            <asp:ListItem Value="2031">2031</asp:ListItem>
                            <asp:ListItem Value="2032">2032</asp:ListItem>--%>

                        </asp:DropDownList>
                    </td>
        </tr>
            <tr>
                <td align="right" class="style1">&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    
                    <asp:Button ID="btn_Report" runat="server" Text="View Attendance" CssClass="btn_hacims"
                        OnClick="btn_Report_Click" />
                    <asp:Button ID="btn_Approve" runat="server" Text="Forward" CssClass="btn_hacims" Visible="false"
                        OnClick="btn_Approve_Click"/>
                    <asp:Button ID="btnShortAttendance" runat="server" Text="Short Attendance" CssClass="btn_hacims" OnClick="btnShortAttendance_Click" Visible="false" />
                    <asp:Button ID="btnHalfDayAttendnace" runat="server" Text="Half Day Attendance" CssClass="btn_hacims" OnClick="btnHalfDayAttendnace_Click" Visible="false" />
                    <asp:Button ID="btnOverTime" runat="server" Text="Over Time" CssClass="btn_hacims" OnClick="btnOverTime_Click" Visible="false" />
                     <asp:Button ID="BtnDoubleOvertime" runat="server" Text="Double Over Time" CssClass="btn_hacims" OnClick="BtnDoubleOvertime_Click" Visible="false" />
                </td>
            </tr>
        </table>
    </div>

    <asp:GridView ID="GrdviewForEmployeeAttendanceSummary" runat="server" AutoGenerateColumns="false" OnRowDataBound="GrdviewForEmployeeAttendanceSummary_RowDataBound">
         <Columns>
                <asp:TemplateField HeaderText="Sr#">
                    <ItemTemplate>
                        <%#Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Department Name">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("Dept_Name")%>' ID="lblDeptID" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Employee Name">
                    <ItemTemplate>
                        <asp:Label Text='<%#Bind("EmpName")%>' ID="lblEmpName" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="For Date">
                    <ItemTemplate>
                       <asp:Label Text='<%#Bind("For_Date")%>' ID="lblForDate" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Shift Name">
                    <ItemTemplate>
                         <asp:Label Text='<%#Bind("Shift")%>' ID="lblShiftName" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
              <asp:TemplateField HeaderText="Shift Start Time">
                    <ItemTemplate>
                         <asp:Label Text='<%#Bind("TimeFrom")%>' ID="lblShifTimeIn" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>               
              <asp:TemplateField HeaderText="Shift End Time">
                    <ItemTemplate>
                         <asp:Label Text='<%#Bind("Timeto")%>' ID="lblShiftTimeOut" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

              <asp:TemplateField HeaderText="Time In">
                    <ItemTemplate>
                       <asp:Label Text='<%#Bind("Time_In")%>' ID="lblTimeIn" runat="server" />

                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Time Out">
                    <ItemTemplate>
                         <asp:Label Text='<%#Bind("Time_out")%>' ID="lblTImeOut" runat="server" />

                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Duty Hours">
                    <ItemTemplate>
                         <asp:Label Text='<%#Bind("Total_Hours")%>' ID="lblHours" runat="server" />

                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Attendance Status" Visible="false">
                    <ItemTemplate>
                         <asp:Label Text='<%#Bind("E_status")%>' ID="lblName" runat="server" />

                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="OverTime(Hours)">
                    <ItemTemplate>
                         <asp:Label Text='<%#Bind("TotalOverTime")%>' ID="lblTotalOverTime" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
             
             <asp:TemplateField HeaderText="OverTime(Minutes)">
                    <ItemTemplate>
                         <asp:Label Text='<%#Bind("RoutineOverTime")%>' ID="lblOverTime" runat="server" />
                        <asp:HiddenField ID="hfAttendanceID" runat="server" Value='<%#Bind("Attendance_Id")%>' />
                        <asp:HiddenField ID="HfDutyTime" runat="server" Value='<%#Bind("DutyTime")%>' />
                        <asp:HiddenField ID="HfOverTimeHours" runat="server" Value='<%#Bind("OverTimeHours")%>' />
                        <asp:HiddenField ID="HfOverTimeMinutes" runat="server" Value='<%#Bind("OverTimeMinutes")%>' />
                        <asp:HiddenField ID="HfOverTimeType" runat="server" Value='<%#Bind("OverTimeType")%>' />
                    </ItemTemplate>
                </asp:TemplateField>

             <asp:TemplateField HeaderText="Type">
                    <ItemTemplate>
                         <asp:Label Text='<%#Bind("OverTimeType")%>' ID="lblOverTimeType" runat="server" />

                    </ItemTemplate>
                </asp:TemplateField>
              
               
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox runat="server" ID="chkBoxSelect" ToolTip='<%#Bind("Emp_ID") %>' />
                    </ItemTemplate>
                    <HeaderTemplate>
                        <asp:CheckBox runat="server" AutoPostBack="true" OnCheckedChanged="chkBoxSelectAll_CheckedChanged" ID="chkBoxSelectAll" ToolTip='<%#Bind("Emp_ID") %>'  />
                    </HeaderTemplate>
                </asp:TemplateField>
            </Columns>
    </asp:GridView>
    <input style="visibility: hidden" type="button" value="print" onclick="printSpecial()" id="btn_print" autofocus="autofocus" onload="Set_focus()"  />
    <br />
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
    </rsweb:ReportViewer>

</asp:Content>

