<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TestFeeReport.aspx.vb" Inherits="TestFeeReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Lahore General Hospital {Payment Report}</title>
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
<script language="javascript" type="text/javascript" >
//function Print_Report()
//{
//window.print();
//}
</script>

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
<body onload ="Print_Report()">
    <form id="form1" runat="server">
    <div>
                    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
            ToolPanelView="None" EnableDatabaseLogonPrompt="False"
            EnableParameterPrompt="False" Height="500px" ReportSourceID="CrystalReportSource2"
            Width="800px" EnableDrillDown="False" HasCrystalLogo="False" HasGotoPageButton="False" HasPageNavigationButtons="False" PrintMode="ActiveX" HasDrillUpButton="False" HasExportButton="False" HasSearchButton="False" HasToggleGroupTreeButton="False"  HasZoomFactorList="False" DisplayToolbar="False" />
        <asp:HiddenField ID="HiddenFieldPatientName" runat="server" />
        <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
        <asp:HiddenField ID="HiddenFieldRegNo" runat="server" />
        <CR:CrystalReportSource ID="CrystalReportSource2" runat="server">
            <Report FileName="Pathology_Package_Fees_Report.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldRegNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@reg_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearlyNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearlyNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@YearlyNO" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldRegNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldPatientName" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="PatientName" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearlyNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Yearly_No_Discount" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldRegNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Reg_No_Discount" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldYearlyNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@YearlyNo" PropertyName="Value" ReportName="Package_Tests_Payment.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldYearlyNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@YearlyNo" PropertyName="Value" ReportName="Test_Payment.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldRegNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Package_Tests_Payment.rpt" />
                    <CR:ControlParameter ControlID="HiddenFieldRegNo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@RegNo" PropertyName="Value" ReportName="Test_Payment.rpt" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
    
    </div>
    </form>
</body>
</html>
