<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage.master" inherits="Blood_Bank_ExpiredBloodBagReport, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:content id="Content1" contentplaceholderid="head" runat="Server">
    <style type="text/css">
        .auto-style1 {
            color: #3399FF;
        }
    </style>
</asp:content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1" />
    <div class="bxmain inner_content" style="width:100%">
        <h2>
            <span  style="font-size:medium; ! important " class="auto-style1">Expired Blood Bags Report</span>
        </h2>
        <table align="center" width="100%">
            <tr>
                <td align="right" style="width:42%">
                    Start Date: 
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtStartDate" TextMode="Date" />
                </td>
            </tr>
             <tr>
                <td align="right">
                    End Date: 
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtEndDate" TextMode="Date" />
                </td>
            </tr>
             <tr>
                <td colspan="2" align="center">
                    <asp:Button Text="Get Expired Blood Report" ID="btnGetExpiredBags" OnClick="btnGetExpiredBags_Click" runat="server" />
                </td>
            </tr>
        </table>
    </div>

<rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px" >
    </rsweb:ReportViewer>
    </asp:content>
