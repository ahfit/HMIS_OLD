<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MriReport.aspx.vb" Inherits="MriReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>HACIMS + { Sheikh Zayed Medical Complex,Lahore },Lahore</title>
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
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"
            EnableParameterPrompt="False" Height="1121px" ReportSourceID="CrystalReportSourceMriReport"
            Width="894px" />
        <CR:CrystalReportSource ID="CrystalReportSourceMriReport" runat="server">
<Report FileName="PT_MRI_Report.rpt"><Parameters>
<CR:ControlParameter PropertyName="Value" ReportName="" Name="@reg_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldRegistrationNo"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="" Name="@Yearly_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldYearlyNo"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="pt_Mri_Discription" Name="@reg_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldRegistrationNo"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="pt_Mri_Discription" Name="@Yearly_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldYearlyNo"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="pt_Mri_Discription" Name="@PRadiologyID" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldRadiologyId"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="pt_Mri_Discription" Name="@Pt_test_id" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldTestId"></CR:ControlParameter>
</Parameters>
</Report>
</CR:CrystalReportSource>
        <asp:HiddenField ID="HiddenFieldRegistrationNo" runat="server" />
        <asp:HiddenField ID="HiddenFieldYearlyNo" runat="server" />
        <br />
        <asp:HiddenField ID="HiddenFieldTestId" runat="server" />
        <asp:HiddenField ID="HiddenFieldRadiologyId" runat="server" />
    
    </div>
    </form>
</body>
</html>
