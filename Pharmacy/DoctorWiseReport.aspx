<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="DoctorWiseReport.aspx.cs" Inherits="Pharmacy_DocotrWiseReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">
        function ClientItemSelected(sender, e) {
            $get("<%=hfDoctorID.ClientID %>").value = e.get_value();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
        <h2><span>Doctor Wise Report</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="50%">Doctor :</td>
                <td align="left" width="50%">
                    <asp:TextBox ID="txtDocotrName" runat="server"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="aceDoctor" runat="server" ServiceMethod="SearchDoctors"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtDocotrName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected"
                        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList" 
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfDoctorID" runat="server" Value="-1" />
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">From Date :</td>
                <td align="left" width="50%">
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" width="50%">To Date :</td>
                <td align="left" width="50%">
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
            <td style="width:25%;text-align:right;padding-bottom:5px;">
                    OPD/IPD:</td>
                <td style="padding-bottom:5px;">
                <asp:DropDownList ID="DropDownTypeWise" runat="server" >
                <asp:ListItem Selected="True" Value="All">ALL</asp:ListItem>
                    <asp:ListItem Value="OPD">OPD</asp:ListItem>
                    <asp:ListItem Value="IPD">IPD</asp:ListItem>
                </asp:DropDownList>
                </td>
             </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </td>
            </tr>
        </table>
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="100%">
    </rsweb:ReportViewer>
</asp:Content>

