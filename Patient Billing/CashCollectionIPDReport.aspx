<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Patient_Billing_CashCollectionIPDReport, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%">
    <h2><span>Over all Cash Book Detail</span></h2>
        <table class="style1" width="100%">
            <tr>
                <td align="right" width="40%">
                    <strong>Employee :</strong>
                </td>
                <td width="60%" align="left">
                    <asp:DropDownList ID="DDL_Employee" runat="server" DataSourceID="SDS_Employee" DataTextField="NAME"
                        DataValueField="EmpID" AutoPostBack="True">
                    </asp:DropDownList>
                    <br />
                    <asp:SqlDataSource ID="SDS_Employee" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataConnectionString %>"
                        SelectCommand="select 'All' as Name,0 as EmpID, 0 as Receptionist_id union SELECT ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS NAME, Employee.EmpID, Receptionist.Receptionist_id 
FROM Employee INNER JOIN Receptionist 
ON Employee.EmpID = Receptionist.Receptionist_id 
WHERE (Employee.ActiveStatus = 1) 
ORDER BY  Name asc"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <strong>Shift : </strong>
                </td>
                <td>
                    <asp:DropDownList ID="DDL_Shift" runat="server" Width="202px">
                        <asp:ListItem Value="0">All</asp:ListItem>
                        <asp:ListItem Value="1">Morning</asp:ListItem>
                        <asp:ListItem Value="2">Evening</asp:ListItem>
                        <asp:ListItem Value="3">Night</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <strong>Type :</strong>
                </td>
                <td>
                    <asp:DropDownList ID="DDL_OPDIPD" runat="server" Width="202px">
                        <asp:ListItem Value="0">All</asp:ListItem>
                        <asp:ListItem>IPD</asp:ListItem>
                        <asp:ListItem>OPD</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <strong>Start Date :</strong>
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser_SDate" runat="server" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_SDAte" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    <strong>End Date :</strong>
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser_EDate" runat="server" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                    <asp:HiddenField ID="HiddenField_EndDate" runat="server" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="Button1" runat="server" Text="View Report" OnClick="Button1_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                </td>
            </tr>
        </table>
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
</asp:Content>
