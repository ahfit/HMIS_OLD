<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Qutation_Report.aspx.cs" Inherits="Store_Qutation_Report" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="rview1" runat="server"></asp:ScriptManager>
    <div>
        <div class="inner_content" style="width: 100%;">
            <h2><span>Qutation Report</span></h2>
        </div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px" HyperlinkTarget="_blank"
             InteractivityPostBackMode="AlwaysAsynchronous">
        </rsweb:ReportViewer>


    </div>
</asp:Content>

