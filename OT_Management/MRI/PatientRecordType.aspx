<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PatientRecordType.aspx.vb" Inherits="PatientRecordTypeaspx" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

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
        <style type="text/css">
<!--
#Layer1 {
	position:absolute;
	left:49px;
	top:198px;
	width:793px;
	height:68px;
	z-index:1;
	visibility: hidden;
}
-->
</style>
    <link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
    <link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
    <link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
    <link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
    <link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
    <link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
    <link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" style="width: 422px">
            <tr>
                <td  style="width: 100px; height: 21px">
                    <strong><span style="font-size: 8pt; font-family: Verdana">Start Date :</span></strong></td>
                <td style="width: 102px; height: 21px">
                    <igsch:webdatechooser id="WebDateChooserStartDate" runat="server"  Value=""></igsch:webdatechooser>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <strong><span style="font-size: 8pt; font-family: Verdana">End Date :</span></strong></td>
                <td style="width: 102px">
                    <igsch:webdatechooser id="WebDateChooserEndDate" runat="server" ></igsch:webdatechooser>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <strong><span style="font-size: 8pt; font-family: Verdana">Patient Type :&nbsp;</span></strong></td>
                <td style="width: 102px">
                    <asp:RadioButtonList ID="RadioButtonListPatientType" runat="server" RepeatDirection="Horizontal"
                        Width="309px"  RepeatColumns="2">
                        <asp:ListItem>Normal</asp:ListItem>
                        <asp:ListItem>Entitled</asp:ListItem>
                        <asp:ListItem>Zakat</asp:ListItem>
                        <asp:ListItem>Ward Patient</asp:ListItem>
                        <asp:ListItem>All</asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 102px">
                    <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" CssClass="bt2up"  /></td>
            </tr>
        </table>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"
            EnableParameterPrompt="False" Height="1039px" ReportSourceID="CrystalReportSource1"
            Width="901px" ToolPanelView="None" Visible="False" />
        <br />
        <asp:HiddenField ID="HiddenFieldStartDate" runat="server" />
        <asp:HiddenField ID="HiddenFieldEndDate" runat="server" />
        <asp:HiddenField ID="HiddenFieldPatientType" runat="server" />
        &nbsp;
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="\\Server\MRI Software\MriReports\Pt_RecordTypeWise.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldStartDate" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@StartDate" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldEndDate" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@EndDate" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="RadioButtonListPatientType" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Patient_Type" PropertyName="SelectedValue" ReportName="" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
    
    </div>
    </form>
</body>
</html>
