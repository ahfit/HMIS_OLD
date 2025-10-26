<%@ Page Language="VB" AutoEventWireup="false" CodeFile="testpagepathology.aspx.vb" Inherits="testpagepathology" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
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
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>
<body dir="ltr">
    <form id="form1" runat="server">
    <div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
            ReportSourceID="CrystalReportSource1" ToolPanelView="None" EnableDatabaseLogonPrompt="False" PrintMode="ActiveX" HasCrystalLogo="False" HasDrillUpButton="False" HasExportButton="False" HasGotoPageButton="False" HasSearchButton="False" HasToggleGroupTreeButton="False"  HasZoomFactorList="False" />
        <asp:HiddenField ID="HiddenField_RegNo" runat="server" />
        <asp:HiddenField ID="HiddenField_YearlyNo" runat="server" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="PatientTestResults.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenField_RegNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenField_YearlyNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldTGID" ConvertEmptyStringToNull="False"
                        DefaultValue="10" Name="@TGroup" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenField_RegNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@regno" PropertyName="Value" ReportName="PatientBasicInfo.rpt" />
                    <CR:ControlParameter ControlID="HiddenField_YearlyNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@payid" PropertyName="Value" ReportName="PatientBasicInfo.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldRegisrationNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="RegistrationNo" PropertyName="Value" ReportName="PatientBasicInfo.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldPatientName" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="PatientName" PropertyName="Value" ReportName="PatientBasicInfo.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <asp:HiddenField ID="HiddenFieldTGID" runat="server" />
        <asp:HiddenField ID="HiddenFieldPatientName" runat="server" />
        <asp:HiddenField ID="HiddenFieldRegisrationNo" runat="server" />
    
    </div>
    </form>
</body>
</html>
