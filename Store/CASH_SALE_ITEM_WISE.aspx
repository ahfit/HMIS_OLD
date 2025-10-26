<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Store_CASH_SALE_ITEM_WISE, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1 {
            width: 100%;
            text-align: center;
        }

        .style2 {
            width: 50%;
            text-align: right;
        }

        .style3 {
            width: 50%;
            text-align: left;
        }

        .auto-style1 {
            width: 50%;
            text-align: right;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>


    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Item Wise Consumption and Stock</span></h2>
        <table class="style1">
            <tr>
                <td class="auto-style1">Start Date :</td>
                <td class="style3">
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" Text=""  ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">End Date :
                </td>
                <td class="style3">
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" Text="" ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Item Name :
                </td>
                <td class="style3">
                    <asp:TextBox ID="txtItemName" runat="server" OnTextChanged="txtItemName_TextChanged"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfItemCode" runat="server" />

                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="Button_report" runat="server" Text="View Report"
                        OnClick="Button_Report_Click" CssClass="btn_1" />
                </td>
            </tr>

        </table>
    </div>
    <div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="90%">
        </rsweb:ReportViewer>
    </div>
</asp:Content>

