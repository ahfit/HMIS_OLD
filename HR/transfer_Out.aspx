<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="transfer_Out, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="cr" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 

    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
 
 
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
 
         <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"
            Height="1055px" ReportSourceID="CrystalReportSource1" Width="100%" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="Transfer_Out.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenField_dateFrom" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@dateFrom" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenField_dateTo" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@dateTo" PropertyName="Value" ReportName="" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <asp:HiddenField ID="HiddenField_dateFrom" runat="server" />
        <asp:HiddenField ID="HiddenField_dateTo" runat="server" />
    </asp:Content>