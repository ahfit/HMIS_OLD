<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="~/Patient Billing/RefundDetailsReport.aspx.cs" Inherits="Patient_Billing_RefundDetailsReport" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Patient Refund Detail Report</span></h2>
    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
          
             <tr>
                <td align="right" width="50%">
                    Start Date :
                </td>
                <td>
                    <igsch:webdatechooser Width="180px" ID="startDateChooser" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:webdatechooser>
                    <asp:HiddenField ID="HiddenField_StartDate" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right">
                    End Date :
                </td>
                <td>
                    <igsch:webdatechooser Width="180px" ID="endDateChooser" runat="server">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:webdatechooser>
                    <asp:HiddenField ID="HiddenField_EndDate" runat="server" />
                </td>
            </tr>
           
            <tr>
            <td align="right">Reg #:</td>
            <td><asp:TextBox ID="txtRegNo" runat="server" style="width:177px;"></asp:TextBox> </td>

            </tr>
            <tr>
            <td align="right">Yearly No:</td>
            <td><asp:TextBox ID="txtYearlyNo" runat="server" style="width:177px;"></asp:TextBox> </td>

            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="Btn_Search" runat="server" Text="View Report" OnClick="Btn_Search_Click" />
                </td>
            </tr>
        </table>
             </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
</rsweb:ReportViewer>
</asp:Content>

