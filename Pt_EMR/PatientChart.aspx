<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage.master" AutoEventWireup="true" CodeFile="PatientChart.aspx.cs" Inherits="Pt_EMR_PatientChart" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <asp:ScriptManager id="scriptManager1" runat="server">
    </asp:ScriptManager>
     <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server"
  
            ShowPrintButton="true" ShowRefreshButton="False">
    </rsweb:ReportViewer>
                
</asp:Content>

