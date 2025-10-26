<%@ Page Language="VB" AutoEventWireup="false" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="pt_DischargeBillNew.aspx.vb" Inherits="Patient_Registration_pt_DischargeBill" %>

   <%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
      
        <style type="text/css">
            #forms_items
            {
                width: 100%;
            }
        </style>
    </asp:Content>
 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="forms_items" class="forms_items">
        <asp:Button ID="btnDuplicate" runat="server" Text="Duplicate" Visible="False" />

 <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" ShowToolBar="true" Height="650px">
</rsweb:ReportViewer>
</div>
</asp:Content>
