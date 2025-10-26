<%@ page title="" language="C#" masterpagefile="~/Hacims_MasterPage_Admin_New.master" autoeventwireup="true" inherits="HR_Employee_Confirmation, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style2
        {
            text-align:right;
           
        }
        .style3
        {
            width: 272px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 style="color: Maroon; font-size: medium"> Employee Confirmation</h1>
    <br />
    <br />
    <div class="bxmain">
        <table>
            <tr>
                <td>
                    Employee ID:
                </td>
                <td colspan="3">
                    <asp:TextBox ID="tbxEmpid" runat="server" Enabled="False"></asp:TextBox>
                </td>
                <td rowspan="5">
                    <asp:Image ID="Image" runat="server" Height="113px" Width="97px" />
                </td>
            </tr>
            <tr>
                <td>
                    Name:
                </td>
                <td colspan="3">
                    <asp:TextBox ID="tbxEmpname" runat="server" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Job Tittle
                </td>
                <td colspan="3">
                    <asp:TextBox ID="tbxJobtittle" runat="server" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Department:
                </td>
                <td colspan="3">
                    <asp:TextBox ID="tbxDepartment" runat="server" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Working Status:
                </td>
                <td>
                    <asp:TextBox ID="tbxStatus" runat="server" Enabled="False"></asp:TextBox>
                </td>
                <td>
                   
                </td>
                <td>
                   
                </td>
            </tr>
            <tr>
                <td> DOJ:</td>
                <td> <asp:TextBox ID="tbxDOJ" runat="server" Enabled="False"></asp:TextBox></td>
            </tr>
        </table>
        <br />
        <br />
        <fieldset>
            <table >
                <tr>
                    <td class="style2">
                        Confirmation Recomended By:
                    </td>
                    <td class="style3">
                        <asp:DropDownList ID="ddRecBy" runat="server" DataSourceID="sdsRecBy" DataTextField="Name"
                            DataValueField="EmpID">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="style2">
                        Approval Date:
                    </td>
                    <td class="style3">
                        <igsch:WebDateChooser ID="WDCapproval" Width="250px" runat="server" CssClass="drop_date"
                            Visible="true">
                            <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                        </igsch:WebDateChooser>
                        [dd/mm/yyyy]
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td class="style2">
                        Remarks/Reason:
                    </td>
                    <td class="style3">
                        <asp:TextBox ID="tbxRemarks" runat="server" Height="40px" TextMode="MultiLine" Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblmessage" runat="server"></asp:Label>
                    </td>
                    <td class="style3">
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                        <asp:SqlDataSource ID="sdsemployeerec" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                            SelectCommand="usp_employeerecord" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                <asp:QueryStringParameter Name="empid" QueryStringField="empid" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsconfirminfo" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                            InsertCommand="INSERT INTO Employee_Confirmed_info(Emp_Id, Remarks, Is_Confirmed, Confirmation_Rec_By, Approval_Date) VALUES (@empid, @remarks, 1, @ddRecBy, @wdcApprov)"
                            SelectCommand="SELECT Emp_Id, Is_Confirmed, Remarks, Confirmation_Rec_By, Approval_Date FROM Employee_Confirmed_info">
                            <InsertParameters>
                                <asp:QueryStringParameter Name="empid" QueryStringField="empid" />
                                <asp:Parameter Name="remarks" />
                                <asp:Parameter Name="ddRecBy" />
                                <asp:Parameter Name="wdcApprov" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsRecBy" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                            SelectCommand="SELECT Employee.EmpID, ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name, Employee.DeptID, Department.Dept_Name FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID WHERE (Department.Dept_Name LIKE '%Admin%')">
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>
</asp:Content>
