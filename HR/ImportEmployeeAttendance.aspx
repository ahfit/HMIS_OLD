<%@ page title="" language="VB" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="false" inherits="HR_ImportEmployeeAttendance, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <table style="width:100%;">
        <tr>
            <td align="right">
                Hospital:</td>
            <td style="width:10px;">
                &nbsp;</td>
            <td>
                    <asp:DropDownList ID="DropdownlistHospital" runat="server" DataSourceID="SqlDataSourceHospital"
                        DataTextField="Hospital_Name" DataValueField="Hospital_ID" TabIndex="5"
                        Width="202px" AutoPostBack="True">
                    </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSourceHospital" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            SelectCommand="SELECT     Hospital_ID, Hospital_Name
FROM         Hospital"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                Department:</td>
            <td style="width:10px;">
                &nbsp;</td>
            <td>
                    <asp:DropDownList ID="Dropdownlistdepartment" runat="server" DataSourceID="SqlDataSourceDepartment"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" TabIndex="5"
                        Width="202px" AutoPostBack="True">
                    </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSourceDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
            
                        SelectCommand="SELECT '--All--' as Dept_Name, 0 as Dept_ID union SELECT Dept_Name, Dept_ID FROM Department where Department.Hospital_ID = @HospitalId ORDER BY Dept_Name">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropdownlistHospital" Name="HospitalId" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
                    </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                    Employee :
                </td>
            <td style="width:10px;">
                &nbsp;</td>
            <td>
                    <asp:DropDownList ID="DropDownList_Employee" runat="server" 
                        DataSourceID="SqlDataSource_Employee" DataTextField="Name" 
                        DataValueField="EmpID" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Employee" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>" 
                        SelectCommand="SELECT     0 AS EmpID, '---ALL---' AS Name
UNION
SELECT     Employee.EmpID, ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name
FROM         Employee INNER JOIN
                      Department ON Employee.DeptID = Department.Dept_ID
WHERE     (Employee.DeptID = @DeptID) AND (Department.Hospital_ID = @Hospital_ID)
ORDER BY EmpID">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="DeptID" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="DropdownlistHospital" Name="Hospital_ID" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td align="right">
                From Date
            </td>
            <td style="width:10px;">
                :
            </td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_date_from" runat="server">
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td align="right">
                To Date
            </td>
            <td style="width:10px;">
                :
            </td>
            <td>
                <igsch:WebDateChooser ID="WebDateChooser_date_to" runat="server">
                </igsch:WebDateChooser>
            </td>
        </tr>
        <tr>
            <td>
                
            </td>
            <td style="width:10px;">
                
            </td>
            <td>
                
            </td>
        </tr>
        <tr>
            <td>
            
            </td>
            <td style="width:10px;">
                
            </td>
            <td>
                <asp:Button ID="btnSearchAttendance" runat="server" Text="Search" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button1" runat="server" Text="Import Machine Attendance" />
            </td>
        </tr>
        <tr>
            <td>
            
                &nbsp;</td>
            <td style="width:10px;">
                
                &nbsp;</td>
            <td>
                <asp:Label ID="lblMsg" runat="server"></asp:Label>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="sqlDs_AttendanceData" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>" 
        SelectCommand="uspEmployeeShiftAttendance" 
        SelectCommandType="StoredProcedure" 
        InsertCommand="uspImportMachineManualAttendance" 
        InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="StartDate" Type="DateTime" />
            <asp:Parameter Name="EndDate" Type="DateTime" />
            <asp:ControlParameter ControlID="Dropdownlistdepartment" Name="Dept_ID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropdownlistHospital" Name="Hospital_ID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Employee" Name="EmpID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:GridView ID="gvEmployeeAttendance" Width="100%" runat="server" 
        AutoGenerateColumns="False" DataSourceID="sqlDs_AttendanceData">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="chkMarkAttendance" runat="server" />
                    <asp:HiddenField ID="hfldFPK_ID" runat="server" Value='<%#Eval("FPK_ID")%>' />
                    <asp:HiddenField ID="hfld_EmpNo" runat="server" Value='<%#Eval("Emp_No") %>' />
                </ItemTemplate>
                <HeaderTemplate>
                    <asp:CheckBox ID="chkMarkAllAttendance" 
                        AutoPostBack="true" 
                        OnCheckedChanged="chkMarkAllAttendance_CheckedChanged" 
                        runat="server" />
                </HeaderTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Emp_No" HeaderText="Emp #" />
            <asp:BoundField DataField="Employee_Name" HeaderText="Employee" />
            <asp:BoundField DataField="Designation_Name" HeaderText="Designation" />
            <asp:BoundField DataField="Dept_Name" HeaderText="Department"  />
            <asp:BoundField DataField="SubDept_Name" HeaderText="Sub Department" />
            <asp:BoundField DataField="ATT_EMP_CODE" HeaderText="Att. Emp #" />
            <asp:BoundField DataField="ATT_DATE" HeaderText="Date" />
            <asp:BoundField DataField="ATT_TIME_IN" HeaderText="Time In" />
            <asp:BoundField DataField="ATT_TIME_OUT" HeaderText="Time Out" />
            <asp:BoundField DataField="ATT_STATUS" HeaderText="Att. Status" />
            <asp:BoundField DataField="ATT_DAY_STATUS" HeaderText="Att. Day Status"  />
        </Columns>
    </asp:GridView>

    <div style="width:100%;text-align:right;padding-right:15px;margin-top:15px;">
        <asp:SqlDataSource ID="sqlDs_MarkEmpAttendance" runat="server" 
            ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>" 
            InsertCommand="uspImportEmployeeAttendance" InsertCommandType="StoredProcedure" 
            ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
            <InsertParameters>
                <asp:Parameter Name="FPK_ID" Type="Decimal" />
                <asp:Parameter Name="Emp_ID" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:Button ID="btnImportAttendance" runat="server" Text="Import" />
    </div>

</asp:Content>

