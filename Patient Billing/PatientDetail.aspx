<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpagePatient.master" inherits="Patient_Billing_PatientDetail, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

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
                    From Date :</td>
                <td align="left">
                    <asp:textbox id="txtDateFrom" runat="server" textmode="Date"></asp:textbox>
                </td>
            </tr>
            <tr >
                <td align="right" width="40%" >
                    To Date :</td>
                <td align="left">

                    <asp:textbox id="txtDateTo" runat="server" textmode="Date"></asp:textbox>
                </td>
            </tr>
            <tr >
                <td align="right" width="40%" >
                    <asp:Label runat="server" Text="MR#"></asp:Label>
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtMRno"></asp:TextBox>
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
