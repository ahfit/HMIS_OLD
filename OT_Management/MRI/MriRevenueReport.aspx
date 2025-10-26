<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MriRevenueReport.aspx.vb" Inherits="MriRevenueReport" %>

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
        &nbsp;<table align ="center">
            <tr>
                <td style="width: 100px; height: 21px" >
                    <strong><span style="font-size: 8pt; font-family: Verdana">
                    Start Date :</span></strong></td>
                <td style="width: 100px; height: 21px">
                    <igsch:WebDateChooser ID="WebDateChooserStartDate" runat="server"  Value="">
                    </igsch:WebDateChooser>
                </td>
                <td style="width: 100px; height: 21px">
                    <strong><span style="font-size: 8pt; font-family: Verdana">
                    End Date :</span></strong></td>
                <td style="width: 100px; height: 21px">
                    <igsch:WebDateChooser ID="WebDateChooserEndDate" runat="server" >
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    <strong><span style="font-size: 8pt; font-family: Verdana">
                    Scan Type :</span></strong></td>
                <td style="width: 100px">
                    <asp:RadioButtonList ID="RadioButtonListCategory" runat="server" RepeatDirection="Horizontal" >
                        <asp:ListItem>Plain</asp:ListItem>
                        <asp:ListItem>Contrast</asp:ListItem>
                        <asp:ListItem>All</asp:ListItem>
                    </asp:RadioButtonList></td>
                <td style="width: 100px">
                    <asp:Button ID="ButtonSubmit" runat="server" Text="Submit" CssClass="bt2up" /></td>
                <td style="width: 100px">
                </td>
            </tr>
        </table>
        &nbsp;
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"
            EnableParameterPrompt="False" ReportSourceID="CrystalReportSourceBetweenDate_TestReport" ToolPanelView="None" Height="1106px" Visible="False" Width="876px" />
        <CR:CrystalReportSource ID="CrystalReportSourceBetweenDate_TestReport" runat="server">
            <Report FileName="\\Server\MRI Software\MriReports\TestBetweenDate.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenFieldStartDate" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@StartDate" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldEndDate" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@EndDate" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenFieldScanType" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@Category" PropertyName="Value" ReportName="" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <asp:HiddenField ID="HiddenFieldStartDate" runat="server" />
        <asp:HiddenField ID="HiddenFieldEndDate" runat="server" />
        <asp:HiddenField ID="HiddenFieldScanType" runat="server" />
    
    </div>
    </form>
   </body>
</html>
