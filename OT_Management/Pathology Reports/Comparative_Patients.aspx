<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Comparative_Patients.aspx.vb" Inherits="Pathology_Reports_Comparative_Patients" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Lahore Genral Hospital Lahore</title>
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
        <table align="center">
            <tr>
                <td style="width: 100px">
                    From Year :</td>
                <td style="width: 100px">
                    <asp:DropDownList ID="DropDownListFromYear" runat="server" Width="68px" DataSourceID="SqlDataSourceFromYear" DataTextField="years" DataValueField="years">
                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceFromYear" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        SelectCommand="SELECT [years] FROM [Years]" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>"></asp:SqlDataSource>
                </td>
                <td style="width: 100px">
                    To Year :</td>
                <td style="width: 100px">
                    <asp:DropDownList ID="DropDownListToYear" runat="server" Width="72px" DataSourceID="SqlDataSourceToYear" DataTextField="years" DataValueField="years">
                    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSourceToYear" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Radiology_ConnStr %>"
                        SelectCommand="SELECT [years] FROM [Years]" ProviderName="<%$ ConnectionStrings:Admin_Radiology_ConnStr.ProviderName %>"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" /></td>
            </tr>
        </table>
        <br />
        <CR:CrystalReportViewer ID="CrystalReportViewerReport" runat="server" AutoDataBind="True"
            EnableParameterPrompt="False" Height="799px"
            Width="1517px" ToolPanelView="None" />
        <CR:CrystalReportSource ID="CrystalReportSourceForReport" runat="server">
        </CR:CrystalReportSource>
        &nbsp;
        <asp:HiddenField ID="HiddenFieldFromYear" runat="server" />
        <asp:HiddenField ID="HiddenFieldToYear" runat="server" />
    
    </div>
    </form>
</body>
</html>
