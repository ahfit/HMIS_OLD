<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Annual_tests_Data.aspx.vb" Inherits="Pathology_Reports_Annual_tests_Data" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:spry="http://ns.adobe.com/spry">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<link href="../../images/sheet_blue.css" rel="stylesheet" type="text/css" />
<link href="../../images/sheet_form.css" rel="stylesheet" type="text/css" />


<script src="../../images/highlight.js" type="text/javascript"></script>

<style type="text/css">
body{background-image:none; margin-top:0px; }
html{background-image:none;}
</style>
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>

<body><form id="form1" runat = "server">

<div id="forms_items" class="forms_items">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
  
  <tr>
    <td>&nbsp;&nbsp;&nbsp;&nbsp;<strong>Choose Year : </strong>&nbsp; <asp:DropDownList ID="DropDownListYear" runat="server" Width="224px" AutoPostBack="True" DataSourceID="SqlDataSourceYear" DataTextField="years" DataValueField="years">
                        <asp:ListItem>2006</asp:ListItem>
                        <asp:ListItem>2007</asp:ListItem>
                        <asp:ListItem>2008</asp:ListItem>
                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        SelectCommand="SELECT [years] FROM [Years]" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>"></asp:SqlDataSource>
                    <asp:Button ID="Button1" runat="server" Text="Show" CssClass="btn1" /></td>
  </tr>
</table>
<br />
<asp:HiddenField ID="HiddenFieldYear" runat="server" />
        <CR:CrystalReportViewer ID="CrystalReportViewerReport" runat="server" AutoDataBind="true" ToolPanelView="None" EnableDatabaseLogonPrompt="False" />
        <CR:CrystalReportSource ID="CrystalReportSourceForReport" runat="server">
        </CR:CrystalReportSource>

</div>

</form>
</body>
</html>