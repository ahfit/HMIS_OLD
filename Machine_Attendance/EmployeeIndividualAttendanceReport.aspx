<%@ page language="C#" autoeventwireup="true" inherits="Machine_Attendance_EmployeeIndividualAttendanceReport, App_Web_aiw43tag" masterpagefile="~/hacims_masterpage_admin.master" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
        <h2><span>Employee Individual Attendance Report</span></h2>

        <table class="tbl_form">
            <tr>
                <td align="right" class="style1">
                    <strong>Select Campus :</strong> </td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Company" runat="server" CssClass="drop_down"
                       DataSourceID="SDS_Company" DataTextField="Hospital_Name"
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
                    <strong>Select Department :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Branch" runat="server"
                        DataSourceID="SDS_Branch" DataTextField="Dept_Name"  CssClass="drop_down"
                        DataValueField="Dept_ID" AutoPostBack="True">
                    </asp:DropDownList>




                    <asp:SqlDataSource ID="SDS_Branch" runat="server"
                        ConnectionString="<%$ ConnectionStrings:DutyRoaster %>"
                        SelectCommand="  select [Dept_Name], [Dept_ID] from Department where (Hospital_ID = @HospitalID)
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
                    <strong>Select Employee :</strong></td>
                <td colspan="2">
                    <asp:DropDownList ID="DDL_Sold_By" runat="server"
                        CssClass="drop_down" DataSourceID="SDS_Employee" DataTextField="Name"
                        DataValueField="EmpID">
                    </asp:DropDownList>

                    <asp:SqlDataSource ID="SDS_Employee" runat="server"
                        ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT     EmpID, ISNULL(Prefix, '') + ' ' + ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name
FROM         Employee
WHERE     (@DeptID =0 or DeptID = @DeptID) and (Employee.activestatus=1)"
                        ProviderName="<%$ ConnectionStrings:Basic_Data_ConnectionString.ProviderName %>">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDL_Branch" Name="DeptID"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>




                </td>
            </tr>

            <tr>
                <td align="right" class="style1"><strong>Start Date:</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_SDate" runat="server"  CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_Start_Date" runat="server" />
                </td>
            </tr>
             <tr>
                <td align="right" class="style1"><strong>End Date:</strong></td>
                <td colspan="2">
                    <igsch:WebDateChooser ID="WebDateChooser_EDate" runat="server"  CssClass="drop_down">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                </td>
            </tr>
       
            <tr style="visibility: hidden">
                <td align="right" class="style1">
                    <strong>Emp No :</strong></td>
                <td colspan="2"></b>
                <asp:TextBox ID="txtbox_EmpNo" runat="server"></asp:TextBox>
                </td>
            </tr>

            <tr style="visibility: hidden">
                <td align="right" class="style1">
                    <strong>Employee Status :</strong></td>
                <td colspan="2">
                    <asp:RadioButtonList ID="RBL_Emp_stat" runat="server"
                        RepeatDirection="Horizontal">
                        <asp:ListItem Value="3">All</asp:ListItem>
                        <asp:ListItem Selected="True" Value="1">Active</asp:ListItem>
                        <asp:ListItem Value="0">Deactive</asp:ListItem>
                        <asp:ListItem Value="2">Ex-employee</asp:ListItem>
                    </asp:RadioButtonList>




                </td>
            </tr>
            <tr>
                <td align="right" class="style1">&nbsp;</td>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="btn_Report" runat="server" CssClass="btn_hacims" Text="View Report" OnClick="btn_Report_Click" />
                </td>
            </tr>
        </table>
    </div>


    <input style="visibility: hidden" type="button" value="print" onclick="printSpecial()" id="btn_print" autofocus="autofocus" onload="Set_focus()"><br />
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server">
    </rsweb:ReportViewer>

</asp:Content>

