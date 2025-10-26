<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage.master" inherits="DoctorShare_DoctorShareFinalPayment, App_Web_qkccn2na" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .left
        {
            display: inline-block;
            width: 49%;
            float: left;
            text-align: right;
        }
        .right
        {
            display: inline-block;
            text-align: right;
            padding-left: 4px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2>
            <span>Patient Services</span></h2>
        <div style="line-height: 1.5; padding-bottom: 4px;">
            <div class="left">
                <asp:Label ID="lblDepartment" runat="server">Department :</asp:Label>
            </div>
            <div class="right">
                <asp:DropDownList  ID="ddlDepartment" runat="server"   DataValueField="Dept_ID" 
                    DataTextField="Dept_Name" AutoPostBack="true" 
                    onselectedindexchanged="ddlDepartment_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
        </div>
        <div style="line-height: 1.5; padding-bottom: 4px;">
            <div class="left">
                <asp:Label ID="Label1" runat="server">Doctor :</asp:Label>
            </div>
            <div class="right">
                <asp:DropDownList ID="ddldoctor" runat="server" AutoPostBack="true">
                </asp:DropDownList>
            </div>
        </div>
        <div style="line-height: 1.5; padding-bottom: 4px;">
            <div class="left">
                <asp:Label ID="Label2" runat="server">Date From :</asp:Label>
            </div>
            <div class="right">
                <igsch:WebDateChooser Width="202px" runat="server" ID="wdcDateFrom">
                </igsch:WebDateChooser>
            </div>
        </div>
        <div style="line-height: 1.5; padding-bottom: 4px;">
            <div class="left">
                <asp:Label ID="Label3" runat="server">Date To :</asp:Label>
            </div>
            <div class="right">
                <igsch:WebDateChooser Width="202px" runat="server" ID="WebDateDateTo">
                </igsch:WebDateChooser>
            </div>
        </div>
        <div style="text-align:center;"><asp:Button ID="btnSearch" runat="server" 
                Text="Search" onclick="btnSearch_Click" /></div>
    </div>
     <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
           
          <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" 
        Height="500px">
    </rsweb:ReportViewer>
</asp:Content>
