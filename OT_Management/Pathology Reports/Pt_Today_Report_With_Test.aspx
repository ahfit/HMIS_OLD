<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pt_Today_Report_With_Test.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Pathology_Reports_Pt_Today_Report_With_Test" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



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


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="bxmain">
<table cellpadding="0" cellspacing="0" class="tbl_form" width="100%"  >
      <tr>
          <td width="40%" align="right" >
        Select Date :          </td>
        <td >
          <igsch:WebDateChooser ID="WebDateChooser1" runat="server" AllowNull="False" Value=""  Width="202px" CssClass="drop_date">
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
        </igsch:WebDateChooser>        </td>
      </tr>
      <tr>
        <td align="right" > Select Shift : </td>
        <td ><asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" RepeatColumns="10"
                        RepeatDirection="Horizontal" RepeatLayout="Flow">
          <asp:ListItem Value="1">Morning</asp:ListItem>
          <asp:ListItem Value="2">Evening</asp:ListItem>
          <asp:ListItem Value="3">Night</asp:ListItem>
          <asp:ListItem Value="0">All</asp:ListItem>
        </asp:RadioButtonList></td>
      </tr>
            
    </table>
 </div>
<br />
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" ToolPanelView="None" PrintMode="ActiveX" />
 
<br />
  </asp:Content>