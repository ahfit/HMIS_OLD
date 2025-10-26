<%@ page title="" language="VB" autoeventwireup="true" masterpagefile="~/hacims_masterpage.master" inherits="BloodBag_List, App_Web_lv2mnwrp" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>




<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

   <%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
       
       Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb"
        %>

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
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" >
              <!--DWLayoutTable-->
             
              <tr>
                <td height="25" align="right" valign="middle" width="40%" > Blood Bags : </td>
                  <td valign="middle"> 
                    <asp:DropDownList  ID="DropDownList1" runat="server" Width="150px">
                      <asp:ListItem>ALL</asp:ListItem>
                      <asp:ListItem>Available</asp:ListItem>
                      <asp:ListItem>Issued</asp:ListItem>
                    </asp:DropDownList>
                </td>
                
              </tr>
              <tr>
                <td height="25" align="right" valign="middle"  >Blood Group : </td>
                  <td valign="middle"><asp:DropDownList  ID="DropDownList2" runat="server" Width="150px">
                      <asp:ListItem>All</asp:ListItem>
                      <asp:ListItem>A+</asp:ListItem>
                      <asp:ListItem>A-</asp:ListItem>
                      <asp:ListItem>B+</asp:ListItem>
                      <asp:ListItem>B-</asp:ListItem>
                      <asp:ListItem>O+</asp:ListItem>
                      <asp:ListItem>O-</asp:ListItem>
                      <asp:ListItem>AB+</asp:ListItem>
                      <asp:ListItem>AB-</asp:ListItem>
                    </asp:DropDownList>
                 </td>
      </tr>
                <tr>
                    <td align="right"  height="25" valign="middle">
                        Status :
                    </td>
                    <td valign="middle">
                        <asp:DropDownList ID="DropDownList_Status" runat="server" Width="150px">
                            <asp:ListItem Selected="True">other</asp:ListItem>
                            <asp:ListItem>issued</asp:ListItem>
                            <asp:ListItem>available</asp:ListItem>
                        </asp:DropDownList></td>
                    
                </tr>
              <tr>
                <td height="25" align="right" valign="middle" > From Date :</td>
                  <td valign="middle"> 
                    <asp:TextBox CssClass="d-active" ID="TextBox1" runat="server" Width="144px"></asp:TextBox>
                  
                    <asp:LinkButton CssClass="login_link2" ID="LinkButton1" runat="server">Select Date</asp:LinkButton>
                  <div id="Layer1" style="position:absolute;">
                  <asp:Calendar BackColor="White" BorderColor="#999999"
            CellPadding="4"  DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
            ForeColor="Black" Height="180px" ID="Calendar1" runat="server" Visible="False" Width="200px" >
                    <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                    <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <SelectorStyle BackColor="#CCCCCC" />
                    <WeekendDayStyle BackColor="#FFFFCC" />
                    <OtherMonthDayStyle ForeColor="#808080" />
                    <NextPrevStyle VerticalAlign="Bottom" />
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                    <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                  </asp:Calendar>
                </div></td>
                 
              </tr>
              <tr>
                <td height="25" align="right" valign="middle" > To Date :</td>
                  <td valign="middle"> 
                    <asp:TextBox CssClass="d-active" ID="TextBox2" runat="server" Width="144px"></asp:TextBox>
                  
                    <asp:LinkButton CssClass="login_link2" ID="LinkButton2" runat="server">Select Date</asp:LinkButton>
                   <div id="Layer2" style="position:absolute;">
                  <asp:Calendar BackColor="White" BorderColor="#999999"
            CellPadding="4"  DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
            ForeColor="Black" Height="180px" ID="Calendar2" runat="server" Visible="False" Width="200px">
                    <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                    <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <SelectorStyle BackColor="#CCCCCC" />
                    <WeekendDayStyle BackColor="#FFFFCC" />
                    <OtherMonthDayStyle ForeColor="#808080" />
                    <NextPrevStyle VerticalAlign="Bottom" />
                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                    <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                  </asp:Calendar>
                </div> </td>
                 
              </tr>
              
              
              
              
              
              
              
              
              
</table></div><br />
<div align="center"><asp:Button CssClass="bt2up" ID="cmdReport" runat="server" Text="Show Report"  /></div>
            <br/>
 
       
     
    <div style="width:100%; align-items:center">
        <asp:ScriptManager ID="ScriptManager2" runat="server">
            </asp:ScriptManager>
 
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px"  >
    </rsweb:ReportViewer>
   
    
    </div>
<%-- <div class="rpt_pos">
                <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"
              Visible="False" Width="100%" HasCrystalLogo="False" HasDrillUpButton="False" HasToggleGroupTreeButton="False" HasViewList="False" DisplayGroupTree="False" EnableDatabaseLogonPrompt="False" EnableParameterPrompt="False" />
        <CR:CrystalReportSource ID="BloodBagsReportSource" runat="server">
            <Report FileName="BloodBagsList.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="DropDownList1" ConvertEmptyStringToNull="False" DefaultValue="all"
                        Name="@status" PropertyName="SelectedValue" ReportName="" />
                    <CR:ControlParameter ControlID="TextBox1" ConvertEmptyStringToNull="False" DefaultValue="today"
                        Name="@fromDate" PropertyName="Text" ReportName="" />
                    <CR:ControlParameter ControlID="TextBox2" ConvertEmptyStringToNull="False" DefaultValue="today"
                        Name="@toDate" PropertyName="Text" ReportName="" />
                    <CR:ControlParameter ControlID="DropDownList2" ConvertEmptyStringToNull="False" DefaultValue="all"
                        Name="@group" PropertyName="SelectedValue" ReportName="" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        
        </div>--%>
 
</asp:Content>