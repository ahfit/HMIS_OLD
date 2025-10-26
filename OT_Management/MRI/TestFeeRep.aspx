<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TestFeeRep.aspx.vb" Inherits="TestFeeRep" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    
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
            EnableParameterPrompt="False" Height="626px" ReportSourceID="CrystalReportSource1"
            Width="490px" HasGotoPageButton="False" HasToggleGroupTreeButton="False" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
<Report FileName="TestName.rpt"><Parameters>
<CR:ControlParameter PropertyName="Value" ReportName="" Name="@reg_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenField_Reg"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="" Name="@Yearly_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenField_Yearly"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="testNameReport.rpt" Name="@regno" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenField_Reg"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="testNameReport.rpt" Name="@yearlyno" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenField_Yearly"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="Medicine.rpt" Name="@Registration_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenField_Reg"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="Medicine.rpt" Name="@Yearly_No" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenField_Yearly"></CR:ControlParameter>
<CR:ControlParameter PropertyName="Value" ReportName="Discount.rpt" Name="@Main_Id" DefaultValue="" ConvertEmptyStringToNull="False" ControlID="HiddenFieldMainId"></CR:ControlParameter>
</Parameters>
</Report>
</CR:CrystalReportSource>
        <asp:HiddenField ID="HiddenField_Reg" runat="server" />
        <asp:HiddenField ID="HiddenField_Yearly" runat="server" />
        <asp:HiddenField ID="HiddenFieldMainId" runat="server" />
        <br />
    
    </div>
    </form>
</body>
</html>
