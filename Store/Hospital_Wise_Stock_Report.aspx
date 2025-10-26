<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/hacims_masterpage_admin.master" CodeFile="Hospital_Wise_Stock_Report.aspx.cs" Inherits="Hospital_Wise_Stock_Report" %>

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
        <h2><span>Item Department Wise Stock</span></h2>

        <table class="style1">
            <tr>
                <td class="style2">Hospital :</td>
                <td class="style3">
                    <asp:DropDownList ID="ddlHospital" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td class="style2">Category:
                </td>
                <td class="style3">
                    <asp:DropDownList ID="DropDownList_Category" runat="server"
                        DataTextField="Item_Type" DataValueField="Item_Type_Id"
                        Width="200px" AutoPostBack="True" DataSourceID="SqlDataSource_Item_Category">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Item_Category" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="category" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="%" Name="Item_Category" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>

            <tr>
                <td class="style2">SubCategory:
                </td>
                <td class="style3">
                    <asp:DropDownList ID="DropDownList_Generic_ItemName" runat="server"
                        DataTextField="Generic_Name" DataValueField="G_N_Id"
                        Width="200px" DataSourceID="SqlDataSource_Generic_Item_Name">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Generic_Item_Name" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
                        ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>" SelectCommand="Select 0 as G_N_Id,'---ALL---' as Generic_Name union SELECT G_N_Id, Generic_Name FROM [Generic_Names] WHERE ([Cat_Id] = @Cat_Id)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DropDownList_Category" Name="Cat_Id" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>

            <tr>
                <td class="style2">Manufacturer:
                </td>
                <td class="style3">
                    <asp:DropDownList ID="DropDownList_Manufacturer" runat="server"
                        DataTextField="Manufacturer_Name" DataValueField="ID"
                        Width="200px" AutoPostBack="false">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td class="style2">Item Name:
                </td>
                <td class="style3">
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
                <td class="style2">Part #<strong> :</strong></td>
                <td class="style3">
                    <asp:TextBox ID="txtPartno" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">Order No<strong> :</strong></td>
                <td class="style3">
                    <asp:TextBox ID="txtOrderNo" runat="server"></asp:TextBox>

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

