<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SummaryReport.aspx.vb" Inherits="Pathology_Reports_SummaryReport" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Pathology Report</title>
    <link href="images1/st_sheet_01.css" rel="stylesheet" type="text/css" />
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
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        <iframe id="holder" frameborder="0" height="97" marginheight="0" marginwidth="0"
            name="holder" scrolling="no" src="../tabs.aspx" width="957"></iframe>
        &nbsp;
        <table>
            <tr>
                <td  style="width: 100px">
        Select Date :&nbsp; &nbsp;
                </td>
                <td style="width: 100px">
                    <igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False" Value="">
                        <CalendarLayout NextMonthImageUrl="ig_cal_grayN0.gif" PrevMonthImageUrl="ig_cal_grayP0.gif"
                            ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
                            <TodayDayStyle BackColor="#E8E8E8" ForeColor="Black" />
                            <FooterStyle BackgroundImage="ig_cal_light1.gif" Font-Size="8pt" ForeColor="#707070"
                                Height="16pt">
                                <BorderDetails ColorTop="176, 176, 176" StyleTop="Solid" WidthTop="1px" />
                            </FooterStyle>
                            <SelectedDayStyle BackColor="#909090" ForeColor="White" />
                            <NextPrevStyle BackgroundImage="ig_cal_light2.gif" />
                            <OtherMonthDayStyle ForeColor="#909090" />
                            <DayHeaderStyle BackColor="#F7F7F7" Font-Bold="True" Font-Size="8pt" ForeColor="Gray"
                                Height="1pt">
                                <BorderDetails ColorBottom="176, 176, 176" StyleBottom="Solid" WidthBottom="1px" />
                            </DayHeaderStyle>
                            <TitleStyle BackColor="#E0E0E0" BackgroundImage="ig_cal_light2.gif" Font-Bold="True"
                                Font-Size="10pt" ForeColor="Gray" Height="18pt" />
                            <CalendarStyle BackColor="#FBFBFB" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px"
                                Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" ForeColor="#505050">
                            </CalendarStyle>
                        </CalendarLayout>
                        <AutoPostBack ValueChanged="True" />
                    </igsch:WebDateChooser>
                </td>
                <td style="width: 100px" >
                    Select
                    Shift :</td>
                <td style="width: 100px">
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" RepeatColumns="3"
                        RepeatDirection="Horizontal">
                        <asp:ListItem Value="1">Morning</asp:ListItem>
                        <asp:ListItem Value="2">Evening</asp:ListItem>
                        <asp:ListItem Value="0">All</asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
            <tr>
                <td  style="width: 100px">
                    </td>
                <td style="width: 100px">
                    <asp:DropDownList ID="DropDownList1" runat="server">
                        <asp:ListItem>2009</asp:ListItem>
                        <asp:ListItem>2008</asp:ListItem>
                        <asp:ListItem>2007</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="width: 100px">
                    <asp:Button ID="ButtonSearch" runat="server" Text="Show Report" /></td>
                <td style="width: 100px">
                </td>
            </tr>
        </table>
        &nbsp;
        <br />
        <CR:CrystalReportViewer ID="CrystalReportViewerSummary" runat="server" AutoDataBind="true" ToolPanelView="None" PrintMode="ActiveX" />
    
    </div>
    </form>
</body>
</html>
