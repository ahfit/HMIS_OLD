<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="DeptWiseItemDetailReport2.aspx.cs" Inherits="Store_DeptWiseItemDetailReport2" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
        <h2><span>Item Ledger Report</span></h2>
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" >Sub Department :</td>
                <td align="left" >
                    <asp:DropDownList ID="ddlSubDepartment" runat="server"></asp:DropDownList></td>
           
                <td align="right" >Item Name :</td>
                <td align="left" >
                    <asp:TextBox ID="txtItemName" runat="server"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                        TargetControlID="txtItemName" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                        CompletionListCssClass="AutoExtender" CompletionListItemCssClass="AutoExtenderList" 
                        CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                    </asp:AutoCompleteExtender>
                    <asp:HiddenField ID="hfItemCode" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right" >From Date :</td>
                <td align="left" >

                      <igsch:WebDateChooser ID="txtStartDate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>

                    
                </td>
         
                <td align="right" >To Date :</td>
                <td align="left" >
                         <igsch:WebDateChooser ID="txtEndDate" runat="server" 
                    Width="202px">
                    <CalendarLayout Culture="English (United Kingdom)">
                    </CalendarLayout>
                </igsch:WebDateChooser>

                    
                </td>
            </tr>
         
            <tr>
                <td align="center" colspan="4">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </td>

            </tr>
        </table>
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="90%">
    </rsweb:ReportViewer>
</asp:Content>

