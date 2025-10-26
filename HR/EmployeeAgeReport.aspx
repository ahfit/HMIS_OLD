<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="EmployeeAgeReport.aspx.cs" Inherits="HR_EmployeeAgeReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span>Over Age Employee
            </span>
        </h2>
        <table>
            <tr>
                <td style="width: 74% !important; text-align: right"><strong>From :</strong></td>
                <td>
                    <asp:TextBox ID="txtStart" TextMode="Number" runat="server" min="0" max="100" step="1"/>
                </td>
            </tr>
            <tr>
                <td style="width: 74% !important; text-align: right"><strong>To :</strong></td>
                <td>
                     <asp:TextBox ID="txtEnd" TextMode="Number" runat="server" min="0" max="100" step="1"/>
                </td>
            </tr>
        </table>
        <div style="text-align: center; margin-top: .5%">
            <asp:Button ID="btnSearch" Text="Search" runat="server" OnClick="btnSearch_Click" />
        </div>
    </div>
    <div style="width: 100%">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
        </rsweb:ReportViewer>
    </div>

</asp:Content>