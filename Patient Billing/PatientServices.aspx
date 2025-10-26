<%@ page language="VB" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" CodeFile="~/Patient Billing/PatientServices.aspx.vb" inherits="Patient_Billing_PatientServices" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

 <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

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
   <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
</div>
</asp:Content>
