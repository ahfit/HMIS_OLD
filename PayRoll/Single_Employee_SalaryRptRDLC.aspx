<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="false" CodeFile="Single_Employee_SalaryRptRDLC.aspx.vb" Inherits="PayRoll_Single_Employee_SalaryRptRDLC" %>

<%--<%@ Register Assembly="CrystalDecisions.Web,Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692FBEA5521E1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%--<%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>--%>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="rpt_pos">
          <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"></rsweb:ReportViewer>


<%--        <CR:CrystalReportViewer ID="CrystalReportViewer3" runat="server" AutoDataBind="true"  EnableDatabaseLogonPrompt="False" 
        EnableParameterPrompt="False"/>--%>

        <%--<CR:CrystalReportViewer ID="CrystalReportViewer3" runat="server" 
        AutoDataBind="true" DisplayGroupTree="False" EnableDatabaseLogonPrompt="False" 
        EnableParameterPrompt="False" /> --%>

    </div>
    
</asp:Content>

