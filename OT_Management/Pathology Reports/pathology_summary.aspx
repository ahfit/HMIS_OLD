<%@ Page Language="VB" AutoEventWireup="false" CodeFile="pathology_summary.aspx.vb"  MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Pathology_Pathology_Reports_pathology_summary" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

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
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
   
        
 </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

  <asp:SqlDataSource ID="SqlDataSource_TestGroup" runat="server" ConnectionString="<%$ ConnectionStrings:Radiology_ConnectionString %>"
            SelectCommand="SELECT [TGID], [TGName] FROM [TestGroup] order by  [TGName] asc ">
    </asp:SqlDataSource>
        <div class="bxmain">
         <table cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="40%" >
                    Department :</td>
                <td colspan="2" >
                    <asp:DropDownList ID="DropDownList_Department" runat="server" DataSourceID="SqlDataSource_Department"
                        DataTextField="Dept_Name" DataValueField="Dept_ID" Width="222px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Department" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                        SelectCommand="Select_Dept" SelectCommandType="StoredProcedure"></asp:SqlDataSource>                </td>
</tr>
            <tr>
                <td align="right" >
                    Group :</td>
          <td colspan="2" >
                    <asp:DropDownList ID="DropDownList_TestGroup" runat="server" DataSourceID="SqlDataSource_TestGroup"
                        DataTextField="TGName" DataValueField="TGID" Width="222px">
                    </asp:DropDownList>            </td>
            </tr>
            <tr>
                <td align="right" >
                    From Date :</td>
          <td colspan="2" align="left"  >
                   
                    <igsch:WebDateChooser ID="WebDateChooser_fromdate" runat="server" Value="2009-03-30" CssClass="drop_date">
                    </igsch:WebDateChooser>
              <asp:HiddenField ID="HiddenField_from" runat="server" />
            </td>
            </tr>
            <tr>
                <td align="right" >
                    To Date :</td>
          <td colspan="2" >
                    <igsch:WebDateChooser ID="WebDateChooser_todate" runat="server" Value="2009-03-30" CssClass="drop_date">
                    </igsch:WebDateChooser>
              <asp:HiddenField ID="HiddenField_to" runat="server" />
            </td>
            </tr>
            <tr>
                <td >
                </td>
                <td width="60%" >
                    <asp:Button ID="Buttonshow" runat="server" Text="Line wise Report"   />
                    <asp:Button ID="Button2" runat="server" Text="Test Booking Summary"  />
                    <asp:Button ID="Button3" runat="server" Text="Bar Wise Report"   /></td>
            </tr>
        </table></div>
    <br />

<div  class="rpt_pos">

<CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
        ToolPanelView="None" EnableDatabaseLogonPrompt="False" EnableParameterPrompt="False" />
</div>

  </asp:Content>