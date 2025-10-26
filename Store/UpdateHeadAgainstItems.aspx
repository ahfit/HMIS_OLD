<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="UpdateHeadAgainstItems.aspx.cs" Inherits="Store_UpdateHeadAgainstItems" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 440px;
        }
    </style>

    <script type="text/javascript">
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width:100%;"><span><h2>Update Head Against Items</h2></span>
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div>
        <table class="diagnosis_list">

            <tr>
                <td align="right" class="auto-style1"><strong>Hospital :</strong></td>
                <td>
                    <asp:DropDownList ID="ddl_Hospital" runat="server"
                        Width="250px" AutoPostBack="false">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td align="right" class="auto-style1"><strong>Category :</strong></td>
                <td>
                    <asp:DropDownList ID="DropDownList_Category" runat="server" Width="202px" DataSourceID="SqlDataSource_Item_Category"
                        DataTextField="Item_Type" DataValueField="Item_Type_Id" AutoPostBack="True">
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
                <td align="right" class="auto-style1"><strong>SubCategory :</strong></td>
                <td>
                    <asp:DropDownList ID="DropDownList_Generic_ItemName" runat="server" DataSourceID="SqlDataSource_Generic_Item_Name"
                        DataTextField="Generic_Name" DataValueField="G_N_Id" Width="202px" AutoPostBack="True">
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
                <td align="right" class="auto-style1"><strong>Item Name :</strong></td>
                <td>
                    <asp:TextBox ID="txtItemName" runat="server" Width="203px"></asp:TextBox>
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
                <td align="right" class="auto-style1">&nbsp;</td>
                <td>
                    <asp:Button ID="btn_Search" runat="server" Text="Search" OnClick="btn_Search_Click" />
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>

                </td>
            </tr>
        </table>
        <br />
        <br />
    </div>


    <div class="bxmain inner_content " style="width: 100%;">
        <h2>
            <span></span></h2>
        <asp:GridView ID="GridViewMin" runat="server" AutoGenerateColumns="false" Width="100%" OnPreRender="GridViewMin_PreRender" AllowPaging="true" PageSize="1000" OnPageIndexChanging="GridViewMin_PageIndexChanging">
            <RowStyle CssClass="GridItem" />
            <Columns>
                <asp:TemplateField HeaderText="Sr. #">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Item Code">
                    <ItemTemplate>
                        <asp:Label ID="lblItemCode" runat="server" Text='<%# Bind("Item_Code") %>'/>
                        <asp:HiddenField ID="hf_item_code" Value='<%# Eval("Item_Code") %>' runat="server"></asp:HiddenField>
                    </ItemTemplate>

                </asp:TemplateField>


                <asp:TemplateField HeaderText="Item Name">
                    <ItemTemplate>
                        <asp:Label ID="lbitemNameR" Text='<%# Bind("Item_Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Generic">
                    <ItemTemplate>
                        <asp:Label ID="lblGenericName" Text='<%# Bind("GenericName") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Manufacturer">
                    <ItemTemplate>
                        <asp:Label ID="lblManufacturer" Text='<%# Bind("ManufacturerName") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Stock Head">
                    <ItemTemplate>
                        <asp:Label ID="lblStockHead" Text='<%# Bind("StockHead") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Stock Head">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddl_StockHead" runat="server">
                            <asp:ListItem Value="0">NA</asp:ListItem>
                            <asp:ListItem Value="3301001">Store and Spares</asp:ListItem>
                            <asp:ListItem Value="3301002">Pharmacy Stock</asp:ListItem>
                            <asp:ListItem Value="3301003">Fix Asset Stock</asp:ListItem>
                            <asp:ListItem Value="3101001">Land</asp:ListItem>
                            <asp:ListItem Value="3101002">Building</asp:ListItem>
                            <asp:ListItem Value="3101003">Furniture & Fixture</asp:ListItem>
                            <asp:ListItem Value="3101004">Office Equipment</asp:ListItem>
                            <asp:ListItem Value="3101005">Electrical Equipment</asp:ListItem>
                            <asp:ListItem Value="3101006">Medical Equipment</asp:ListItem>
                            <asp:ListItem Value="3101007">Generator</asp:ListItem>
                            <asp:ListItem Value="3101008">IT Equipment</asp:ListItem>
                            <asp:ListItem Value="3101009">Vehicle</asp:ListItem>
                            <asp:ListItem Value="3101010">Elevator</asp:ListItem>
                        </asp:DropDownList>
                         <asp:HiddenField ID="hf_SH" Value='<%# Eval("E_Code") %>' runat="server"></asp:HiddenField>
                    </ItemTemplate>

                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Con. Head">
                    <ItemTemplate>
                        <asp:Label ID="lblCConsumHead" Text='<%# Bind("ConsumHead") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Consumable Head">

                    <ItemTemplate>
                        <asp:DropDownList ID="ddl_ConsumableHead" runat="server">
                            <asp:ListItem Value="0">NA</asp:ListItem>
                            <asp:ListItem Value="5110001">Consumables</asp:ListItem>
                            <asp:ListItem Value="5110002">Medicine</asp:ListItem>
                            <asp:ListItem Value="5110003">External Lab</asp:ListItem>
                            <asp:ListItem Value="5110004">Medical Camps</asp:ListItem>
                            <asp:ListItem Value="5110005">Expired Stock</asp:ListItem>
                        </asp:DropDownList>
                         <asp:HiddenField ID="hf_CH" Value='<%# Eval("Consumption_Head") %>' runat="server"></asp:HiddenField>
                    </ItemTemplate>
                    
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Select">
                    <HeaderTemplate>
                        <asp:CheckBox ID="chkselectAll" runat="server" OnCheckedChanged="chkselectAll_CheckedChanged" AutoPostBack="true" />
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkSelect" runat="server" />
                    </ItemTemplate>

                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </div>
    <div class="bxmain inner_content "
        style="display: none;">
        <h2>
            <span>Expiry </span></h2>
        <asp:GridView ID="GridviewExp" runat="server" AutoGenerateColumns="false">
            <RowStyle CssClass="GridItem" />
            <Columns>

                <asp:TemplateField HeaderText="Sr. #">
                    <ItemTemplate>
                        <%# Container.DataItemIndex+1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Item Name">
                    <ItemTemplate>
                        <asp:Label ID="lbitemName" Text='<%# Bind("E_Code") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Qty">
                    <ItemTemplate>
                        <asp:Label ID="lblQty" Text='<%# Bind("Consumption_Head") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:HiddenField ID="IsFirstTime" runat="server" Value="1" />
    </div>
</asp:Content>

