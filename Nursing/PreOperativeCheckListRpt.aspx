<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PreOperativeCheckListRpt.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master"
    Inherits="Patient_RegistrationPreOperativeCheckListRpt" %>

<%@ Register Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 
     <style type="text/css" media="screen">
 body {font-family:"Segoe UI"; }
.medication {margin-left:0px; }
.medication li span {color:#333; padding-left:0px; padding-right:0px;}
.medication li .span {color:#cccccc; padding-left:10px; padding-right:10px;} 
 </style>
  
  
   <link href="../css_hacims/print_report.css"   rel="stylesheet"   type="text/css" media="print" />
 <script src="../css_hacims/ck.js" type="text/javascript"></script>

<script src="../SpryAssets_ptemr/SpryCollapsiblePanel.js" type="text/javascript"></script>

 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



                 <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
                    </rsweb:ReportViewer>
                
  </asp:Content>
