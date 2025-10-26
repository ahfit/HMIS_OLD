<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master"
    AutoEventWireup="true" CodeFile="PatientCountSummaryReport.aspx.cs" Inherits="Pathology_PatientCountSummaryReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
    <div class="bxmain inner_content" style="width:100%; margin-bottom:5px;">
        <h2>
            <span>Patient Count Summary</span>
        </h2>
        <table>
            
            
            <tr>
                <td style="width:25%;text-align:right;padding-bottom:5px;">
                    Date From:
                </td>
                <td style="padding-bottom:5px;width:25%;">
                    <igsch:WebDateChooser Width="200px" ID="startDateChooser" runat="server">
                     <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
                <td style="width:25%;text-align:right;padding-bottom:5px;">
                    Date To:
                </td>
                <td style="padding-bottom:5px;width:25%;">
                    <igsch:WebDateChooser Width="200px" ID="endDateChooser" runat="server">
                     <CalendarLayout Culture="English (United Kingdom)">
                            </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
                <td align="center">
                    &nbsp;</td>
            </tr>
           
            
                <tr>
        <td width = "50%" align = "right">
            <strong>OPD/IPD :</strong></td>
        <td width = "50%" >
            <asp:DropDownList ID="DropDownListOPDIPD" runat="server">
                <asp:ListItem Selected="True" Value="All">All</asp:ListItem>
                <asp:ListItem Value="OPD">OPD</asp:ListItem>
                <asp:ListItem Value="IPD">IPD</asp:ListItem>
            </asp:DropDownList>
            
                    <asp:Button ID="btnReport" Text="Report" runat="server" OnClick="btnReport_Click"/>
            
        </td>
    </tr>
           
            <tr>
                 <td align="center" colspan="4">
                     &nbsp;</td>
            </tr>
        </table>
    </div>
    <div style="padding-top:9px;">
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
