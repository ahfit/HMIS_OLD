<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Patient_Sample_Lab_Report.vb"  MasterPageFile="~/hacims_masterpagePatientLab.master" Inherits="Pathology_Patient_Sample_Lab_Report" %>
 <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain">
         <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Visible="false">
    </rsweb:ReportViewer>
 
        </div>  
  </asp:Content>