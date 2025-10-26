<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Stock.aspx.cs" Inherits="Store_Stock" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
        <h2><span>Stock</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                <td align="right" width="40%">Category : </td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlCategory" runat="server"
                        DataTextField="Item_Type" DataValueField="Item_Type_Id"
                        Width="200px" AutoPostBack="True">
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
                <td align="right" width="40%">Manufacturer : </td>
                <td align="left" width="60%">
                    <asp:DropDownList ID="ddlManufacturer" runat="server"
                        DataTextField="Manufacturer_Name" DataValueField="ID"
                        Width="200px" AutoPostBack="false">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right" width="40%">Item Name : </td>
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
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top: 10px;">
        <tr>
            <td align="left" width="33%" valign="top">
                <div class="bxmain inner_content" style="width:98%; background-color:white !Important;">
                    <h2><span style="text-align:left;">General Store Stock</span></h2>
                    <asp:GridView ID="gvGStore" runat="server" Width="100%" AutoGenerateColumns="false" AllowPaging="true" PageSize="50" CssClass="Grid_1">
                        <PagerStyle CssClass="GridPager" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                        <Columns>
                            <asp:TemplateField HeaderText="Sr. #" HeaderStyle-Width="23px">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Item Code" DataField="Item_Code" HeaderStyle-Width="55px" />
                            <asp:BoundField HeaderText="Item Name" DataField="Item_Name" />
                            <asp:BoundField HeaderText="Stock" DataField="Stock" />
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
            <td align="center" width="33%"  style="margin-left:3px;" valign="top">
                <div class="bxmain inner_content" style="width:98%;text-align:left; background-color:white !Important;">
                    <h2><span>Pharmacy Store Stock</span></h2>
                    <asp:GridView ID="gvPStore" runat="server" Width="100%" AutoGenerateColumns="false" AllowPaging="true" PageSize="50" CssClass="Grid_1">
                        <PagerStyle CssClass="GridPager" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                        <Columns>
                          <asp:TemplateField HeaderText="Sr. #" HeaderStyle-Width="23px">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Item Code" DataField="Item_Code" HeaderStyle-Width="55px" />
                            <asp:BoundField HeaderText="Item Name" DataField="Item_Name" />
                            <asp:BoundField HeaderText="Stock" DataField="Stock" />
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
            <td align="right" width="33%" style="margin-left:3px;" valign="top">
                <div class="bxmain inner_content" style="width: 98%; text-align:left; background-color:white !Important;" >
                    <h2><span>Pharmacy Stock</span></h2>
                    <asp:GridView ID="gvPharmacy" runat="server" Width="100%" AutoGenerateColumns="false" AllowPaging="true" PageSize="50" CssClass="Grid_1">
                        <PagerStyle CssClass="GridPager" />
                        <AlternatingRowStyle CssClass="GridAltItem" />
                        <Columns>

                         <asp:TemplateField HeaderText="Sr. #" HeaderStyle-Width="23px">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex+1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Item Code" DataField="Item_Code" HeaderStyle-Width="55px" />
                            <asp:BoundField HeaderText="Item Name" DataField="Item_Name" />
                            <asp:BoundField HeaderText="Stock" DataField="Stock" />
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
        </tr>
    </table>



</asp:Content>

