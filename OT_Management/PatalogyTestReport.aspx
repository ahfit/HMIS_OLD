<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatalogyTestReport.aspx.vb" Inherits="PatalogyTestReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Lahore General Hospital Lahore</title>
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
        &nbsp;<CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
            EnableParameterPrompt="False" ReportSourceID="CrystalReportSourceTest" ToolPanelView="None" />
        <asp:HiddenField ID="HiddenFieldRegistrationNo" runat="server" />
    
    </div>
        <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
        <br />
        <CR:CrystalReportSource ID="CrystalReportSourceTest" runat="server">
            <Report FileName="PathologyFeesReport.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldRegistrationNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearlyNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldRegistrationNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@regno" PropertyName="Value" ReportName="Test" />
                    <CR:ControlParameter ControlID="HiddenFieldYearlyNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@yearlyno" PropertyName="Value" ReportName="Test" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
    </form>
</body>
</html>
