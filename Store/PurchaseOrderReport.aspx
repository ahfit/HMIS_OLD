<%@ page language="VB" autoeventwireup="false" inherits="Store_PurchaseOrderReport" CodeFile="PurchaseOrderReport.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
        <asp:HiddenField ID="HiddenField_Discount" runat="server" />
        <asp:HiddenField ID="HiddenField_Tax" runat="server" />
    
</asp:Content>
