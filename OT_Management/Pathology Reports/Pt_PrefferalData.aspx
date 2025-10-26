<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_PrefferalData.aspx.vb" Inherits="Pathology_Reports_Pt_PrefferalData" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>LAHORE GENERAL HOSPITAL LAHORE</title>
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
<body>
    <form id="form1" runat="server">
    <div>
        <table align=center>
            <tr>
                <td style="width: 100px">
                    <strong>Choose</strong> <strong>Year</strong> :</td>
                <td style="width: 100px">
                    <asp:DropDownList ID="DropDownListYear" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceYear"
                        DataTextField="years" DataValueField="years">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <asp:Button ID="Button1" runat="server" Text="Show" Width="61px" /></td>
            </tr>
        </table>
        <br />
        <CR:CrystalReportViewer ID="CrystalReportViewerReport" runat="server" AutoDataBind="True"
            ToolPanelView="None" EnableParameterPrompt="False" Height="777px"
            Width="1260px" />
        <CR:CrystalReportSource ID="CrystalReportSourceForReport" runat="server">
        </CR:CrystalReportSource>
        <asp:HiddenField ID="HiddenFieldYear" runat="server" />
        <asp:SqlDataSource ID="SqlDataSourceYear" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
            SelectCommand="SELECT [years] FROM [Years]" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
