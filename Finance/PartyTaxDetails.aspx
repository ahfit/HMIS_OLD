<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="PartyTaxDetails.aspx.cs" Inherits="Finance_PartyTaxDetails" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function ClientItemSelected(sender, e) {
            $get("<%=hfPartyId.ClientID %>").value = e.get_value();
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>Party Tax Detail</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="50%">Party : </td>
                <td align="left" width="50%">
                    <asp:TextBox ID="txtParty" runat="server"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="Auto_Parties_Extender" runat="server" ServiceMethod="SearchCustomers"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtParty" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfPartyId" runat="server" Value="-1" />
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">Date From : </td>
                <td align="left" width="50%">
                    <igsch:WebDateChooser ID="wdcStartDate" runat="server" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">Date To : </td>
                <td align="left" width="50%">
                    <igsch:WebDateChooser ID="wdcEndDate" runat="server" Width="202px">
                        <CalendarLayout Culture="English (United Kingdom)">
                        </CalendarLayout>
                    </igsch:WebDateChooser>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2" width="50%">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%"></rsweb:ReportViewer>
</asp:Content>

