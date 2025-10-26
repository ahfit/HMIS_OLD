<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="HR_IDCard, App_Web_2qu1gl2y" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="cr" %>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>

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
            Height="287px" ReportSourceID="CrystalReportSource1" />
        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="IDCard.rpt">
                <Parameters>
                    <CR:ControlParameter ControlID="HiddenField_emp_ID" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@emp_ID" PropertyName="Value" ReportName="" />
                    <CR:ControlParameter ControlID="HiddenField_employee_name" ConvertEmptyStringToNull="False"
                        DefaultValue="" Name="@emp_Name" PropertyName="Value" ReportName="" />
                </Parameters>
            </Report>
        </CR:CrystalReportSource>
        <br />
        <asp:HiddenField ID="HiddenField_emp_ID" runat="server" />
        <asp:HiddenField ID="HiddenField_employee_name" runat="server" />
    
      </asp:Content>