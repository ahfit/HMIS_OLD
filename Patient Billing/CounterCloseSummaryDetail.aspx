<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Patient_Billing_CounterCloseSummaryDetail, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <div class="bxmain inner_content" style="width: 100%">
        <h2>
            <span>Counter Close Summary Detail</span>
        </h2>
        <table width="100%" style="margin-top=20px">
            <tr >
                <td align="right" width="40%" >
                    <b>From Date : </b></td>
                <td align="left">
                    <asp:textbox id="txtDateFrom" runat="server" textmode="Date"></asp:textbox>
                </td>
            </tr>
            <tr >
                <td align="right" width="40%" >
                    <b>To Date : </b></td>
                <td align="left">

                    <asp:textbox id="txtDateTo" runat="server" textmode="Date"></asp:textbox>
                </td>
            </tr>
            <tr >
                <td align="right" width="40%" >
                    <b>Select Employee: </b>
                </td>
                <td align="left">
                    <asp:DropDownList ID="DDL_Employee" runat="server" >
                    </asp:DropDownList>
                    <asp:Label ID="lblName" runat="server" Text="" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button Text="Search" runat="server" ID="btnSearch" OnClick="btnSearch_Click"/>
                    <asp:Button Text="Report" runat="server" ID="btnReport" OnClick="btnReport_Click"/>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:GridView ID="gvdSearch" runat="server">
            
        </asp:GridView>
    </div>
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="500px">
        </rsweb:ReportViewer>
    </div>
</asp:Content>

