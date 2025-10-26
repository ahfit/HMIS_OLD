<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="~/Store/Gatepass/CategoryWiseGatePass.cs" Inherits="Store_CategoryWiseGatePass" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
         }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 10px;">
        <h2><span>Category Wise Gate Pass</span></h2>
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
              <tr>
                        <td align="right" width="40%">
                            Category :
                        </td>
                      <td align="left" width="60%">
                            <asp:DropDownList ID="ddl_Category" runat="server" 
                                DataTextField="Financial_Company_Name" DataValueField="Financial_Company_Id"   OnSelectedIndexChanged="ddl_Category_SelectedIndexChanged"
                                Width="200px" AutoPostBack="true">
                            </asp:DropDownList>
                        </td>
                    </tr>
            <tr>
                <td align="right" width="40%">Sub Category : </td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlGenericNames" runat="server"
                        DataTextField="Generic_Name" DataValueField="G_N_Id"
                        Width="200px">
                    </asp:DropDownList>
                </td>
                 
            </tr>
            <tr>
                <td align="right" width="40%">From Date :</td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">To Date :</td>
                <td align="left" width="60%">
                    <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">Item Name :</td>
                <td align="left" width="60%">
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
                <td align="center" colspan="2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                </td>

            </tr>
        </table>
    </div>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Width="90%">
    </rsweb:ReportViewer>
</asp:Content>

