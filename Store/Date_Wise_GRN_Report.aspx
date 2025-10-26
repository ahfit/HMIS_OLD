<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Date_Wise_GRN_Report.aspx.cs" Inherits="Date_Wise_GRN_Report" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Date Wise GRN Report</span></h2>
        <table width="100%">
             <tr>
                <td align="right" style="width:50%">Department</td>
                <td>
                    <asp:DropDownList ID="ddlSubDepartment" runat="server" ></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" style="width:50%">Start Date</td>
                <td>
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">End Date :
                </td>
                <td>
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right"></td>
                <td>
                    <asp:Button ID="btnReport" Text="View Report" runat="server" OnClick="btnReport_Click" />
                    
                </td>
            </tr>
        </table>
    </div>
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="90%">
        </rsweb:ReportViewer>
    </div>
</asp:Content>

