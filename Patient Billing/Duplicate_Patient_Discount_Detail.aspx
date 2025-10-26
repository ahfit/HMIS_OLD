<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Duplicate_Patient_Discount_Detail.aspx.vb" Inherits="Patient_Billing_Duplicate_Patient_Discount_Detail" %>
    
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
</head>
<body>
   
    <form id="form1" runat="server">
    <asp:ScriptManager id="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
     <rsweb:ReportViewer ID="ReportViewer1" Width="100%" runat="server"
  
            ShowPrintButton="true" ShowRefreshButton="False">
    </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
