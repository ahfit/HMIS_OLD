<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage.master" CodeFile="~/Pt_EMR/Doctor_PrescriptionFinal.aspx.cs" Inherits="Pt_EMR_Doctor_Prescription1" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
     <style type="text/css" media="screen">
.medication {margin-left:0px; }
.medication li span {color:#333; padding-left:0px; padding-right:0px;}
.medication li .span {color:#cccccc; padding-left:10px; padding-right:10px;}
fieldset {display:none;}
 </style>
 <style type="text/css" media="print">
 body {font-size:11px; }
 ul li {list-style:none; font-family:Calibri;   }
 .h1 {font-size:12px; font-family:Calibri; background-color:#ccc; height:22px; display:block; line-height:20px; padding-left:10px; }
 #footer {display:none;}
 #navigation {display:none;}
 #header {display:none;}
 .leftnav {display:none; }
 #p_info {display:none;}
 .Grid_1 { font-family:Calibri; font-size:10px; }
  .Grid_1 td { font-family:Calibri; font-size:10px; height:16px; padding-right:3px; }
 .fieldset {display:block;}
 #mprint {display:none;}
 
 .medication { margin-left:-40px; margin-top:5px; margin-bottom:5px; }
.liness { min-height:50px;  }
 </style>
 <script src="../css_hacims/ck.js" type="text/javascript"></script>

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager id="scriptManager1" runat="server">
    </asp:ScriptManager>

    <div style="height:30px;">
        <asp:HyperLink ID="hlnkPrintReceipt" runat="server" Visible="False" 
            Text="Print Receipt" />
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </div>
    
    <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server"
  
            ShowPrintButton="true" ShowRefreshButton="False">
    </rsweb:ReportViewer>
                
  </asp:Content>
