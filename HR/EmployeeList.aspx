<%@ Page Title="" Language="C#" MasterPageFile="~/Hacims_MasterPage_Admin_New.master"
    AutoEventWireup="true" CodeFile="EmployeeList.aspx.cs" Inherits="HR_EmployeeList" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .bxmain
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain" width="100%" align="center">
        <table>
            <tr>
                <td>
                    Start Date:
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebCalendar_Date_of_Birth" runat="server" Width="200px" ></igsch:WebDateChooser>
                    <asp:HiddenField ID="HFStartDate" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    End Date:
                </td>
                <td>
                    <igsch:WebDateChooser ID="WebDateChooser1" runat="server" Width="200px" ></igsch:WebDateChooser>
                    <asp:HiddenField ID="HFEndDate" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btnCurrentEmployee" Text="Current Employee" runat="server" 
                        OnClick="btnCurrentEmployee_Click" style="text-align: right" />
                    <asp:Button ID="btnExEmployee" Text="Ex Employee" runat="server" OnClick="btnExEmployee_Click" />
                   
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                <asp:HiddenField ID="hdfCurrentEmployee" runat="server" Value="1" />
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    </div>
    <div class="bxmain"  align="center">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"  align="center" >
        </rsweb:ReportViewer>
    </div>
</asp:Content>
