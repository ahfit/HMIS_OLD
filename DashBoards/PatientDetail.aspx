<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpagePatient.master" inherits="Patient_Billing_PatientDetail, App_Web_csihqmfb" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span>Patient Visits Detail </span>
        </h2>
        <table width="100%" style="margin-top=20px">
            <tr >
                <td align="right" width="40%" >
                   MR # :
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtMRno"></asp:TextBox>
                    
                </td>
            </tr>
            <tr >
                <td align="right" width="40%" >
                    From Date : 
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtStartDate" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
             <tr >
                <td align="right" width="40%" >
                    To Date : 
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtEndDate" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
             <tr >
                <td align="right" width="40%" >
                   &nbsp;
                </td>
                <td align="left">
                    <asp:Button Text="Search" runat="server" ID="btnSearch" OnClick="btnReport_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
        </rsweb:ReportViewer>
    </div>
</asp:Content>
