<%@ Page Title="" Language="VB" MasterPageFile="~/Hacims_MasterPage_Admin_New.master" AutoEventWireup="false" CodeFile="BudgetDistributionReport.aspx.vb" Inherits="Finance_BudgetDistributionReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"></rsweb:ReportViewer>
    <asp:SqlDataSource ID="SDS_Report"  ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
         ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>" SelectCommandType ="StoredProcedure" SelectCommand ="Budget_Distribution_report" runat="server">
             <SelectParameters>
                 <asp:QueryStringParameter Type="String" QueryStringField="b_id" Name="b_id" />
            </SelectParameters>


    </asp:SqlDataSource>
</asp:Content>

