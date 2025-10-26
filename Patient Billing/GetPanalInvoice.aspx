<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="GetPanalInvoice.aspx.cs" Inherits="Patient_Billing_GetPanalInvoice" %>
 <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
           
          <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" 
        Height="500px">
    </rsweb:ReportViewer>

</asp:Content>

