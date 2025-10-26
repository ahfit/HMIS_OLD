<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="Administrator_Admin_Item, App_Web_btearpvw" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript">
 </script>
    <style type="text/css">
        .lightbox
        {
            left: 35%;
            top: 53%;
          /*display:none;*/
         
        }
        /*.lightbox_bg
        {
            left: 35%;
            top: 53%;
          display:none;
         
        }*/ 
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="pnlMsg" runat="server">
        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
    </asp:Panel>
    <div class="bxmain inner_content" runat="server" style="width:100%;">
       <h2><span>Add Medicine / Item</span></h2>
        <asp:Label CssClass="err" ID="Label_message" runat="server"></asp:Label>
       
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" id="TABLE1"
            onclick="return TABLE1_onclick()">
            <tr>
                <td align="right">
                    Item Name :
                </td>
                <td align="left">
                    <asp:TextBox ID="TextBox_Item" runat="server" CssClass="input_txt" Width="300px"></asp:TextBox>
                    <asp:TextBox ID="TextBox_ItemCode" runat="server" CssClass="input_txt" Width="150px"
                        ToolTip="Item Code" Style="color: red;"></asp:TextBox>
                </td>
                <td>
                </td>
                <td align="right">
                    Item Category :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Category" runat="server" Width="202px" DataSourceID="SqlDataSource_Item_Category"
                        DataTextField="Item_Type" DataValueField="Item_Type_Id" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:LinkButton ID="LinkButton_Category" runat="server" CssClass="add_link" Visible="False">Add Category</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Manufacture :
                </td>
                <td align="left">
                <asp:DropDownList ID="ddlManufacturer" runat="server" 
                        DataSourceID="sdsManufacturer" DataTextField="Manufacturer_Name" 
                        DataValueField="Manufacturer_Id" ></asp:DropDownList>
                <asp:SqlDataSource ID="sdsManufacturer" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
                        SelectCommand="SELECT Manufacturer_Id, Manufacturer_Name FROM Items_Manufacturer where Manufacturer_Id=156"></asp:SqlDataSource>

                    
                    <asp:LinkButton ID="lnkAddManufacturer" runat="server" CssClass="add_link">Add</asp:LinkButton>



                    <asp:CheckBox ID="CheckBox1" runat="server" Text="Allow Serial" Visible="false" />
                    <asp:HiddenField ID="HF_Allow_Serial" runat="server" />
                </td>
                <td>
                </td>
                <td align="right">
                    Item Sub-Category :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_Generic_ItemName" runat="server" DataSourceID="SqlDataSource_Generic_Item_Name"
                        DataTextField="Generic_Name" DataValueField="G_N_Id" Width="202px" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:LinkButton ID="LinkButton_GName" runat="server" CssClass="add_link" Visible="False">Add Sub-Category</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Expiry Item :
                </td>
                <td align="left">
                    <asp:RadioButtonList ID="RadioButtonList_Expiry" runat="server" RepeatDirection="Horizontal"
                        RepeatLayout="Flow">
                        <asp:ListItem Value="True">Yes</asp:ListItem>
                        <asp:ListItem Value="False" Selected="True">No</asp:ListItem>
                    </asp:RadioButtonList>
                    <div style="float: right; margin-right: 135px;">
                        Part #:
                        <asp:TextBox ID="txtPartNumber" runat="server" Text="" Width="150px"></asp:TextBox>
                    </div>
                </td>
                <td>
                </td>
                <td align="right">
                    General Category :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_General_Category" runat="server" Width="202px"
                        DataSourceID="SqlDataSourceGeneral_Category" DataTextField="Item_Category" DataValueField="Item_Category_ID"
                        AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:LinkButton ID="LinkButtonCategor" runat="server" CssClass="add_link" Visible="False">Add General Category</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Unit :
                </td>
                <td align="left">
                    <asp:DropDownList ID="DropDownListUnit" runat="server" DataSourceID="SqlDataSourceUnit" DataTextField="unit" DataValueField="unit" Width="202px">
                    </asp:DropDownList>
                    <asp:LinkButton ID="lnkUnit" runat="server" CssClass="add_link">Add Unit</asp:LinkButton>
                </td>
                <td>
                    &nbsp;</td>
                <td align="right">
                    Re-Order :
                </td>
                <td>

                    <asp:TextBox ID="txtReorder" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Min Level :
                </td>
                <td align="left">

                    <asp:TextBox ID="txtmin" runat="server"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
                <td align="right">
                    Max Level :
                </td>
                <td>

                    <asp:TextBox ID="txtMax" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Description :
                </td>
                <td colspan="4" align="left">
                    <asp:TextBox ID="txt_Description" runat="server" Height="100px" CssClass="input_txt"
                        TextMode="MultiLine" Width="98%"></asp:TextBox>
                </td>
                
            </tr>
        </table>
    </div>
    <br />
    <div align="center">
        <asp:SqlDataSource ID="SqlDataSource_Item_Category" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            SelectCommand="Store_Items_category" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter DefaultValue="%" Name="Item_Category" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="Button_Search" runat="server" Text="Search" />
        <asp:Button ID="ButtonSave" runat="server" Text="Save" />
        <asp:Button ID="Button_update" runat="server" Text="Update" Visible="False" />
        <asp:Button ID="Button_Cancel" runat="server" Text="Cancel" Visible="False" /></div>
    <br />
    <asp:HiddenField ID="HiddenFieldPrevious_Item_Code" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceForGrid" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT ISNULL(Store_Items.Drug_Category + ' ', ' ') AS DrugCategory, ISNULL(Store_Items.Item_Name, '') AS Item_Name, ISNULL(Store_Items.Potency, '') AS Potency, ISNULL(Store_Items.Unit, '') AS Unit, Store_Item_Category.Item_Category AS Category, ISNULL(Items_Manufacturer.Manufacturer_Name, '') AS Manufacturer, Store_Item_Category.Item_Category_ID, Store_Items.Item_Code, ISNULL(Store_Items.Expiry_Item, 0) AS Expiry_Item, Store_Item_Types.Item_Type, Generic_Names.Generic_Name, Store_Items.Unit AS Expr1, Store_Items.MinLevel, Store_Items.MaxLevel, Store_Items.ReOrder FROM Store_Items INNER JOIN Store_Item_Types ON Store_Items.Item_Type_Id = Store_Item_Types.Item_Type_Id INNER JOIN Generic_Names ON Store_Items.G_N_Id = Generic_Names.G_N_Id INNER JOIN Items_Manufacturer ON Store_Items.Manufacturer = Items_Manufacturer.Manufacturer_Id LEFT OUTER JOIN Store_Item_Category ON Store_Items.Category = Store_Item_Category.Item_Category_ID WHERE (Store_Items.Item_Name LIKE '%' + @Item_Name + '%') AND (ISNULL(Store_Items.PharmacyOther, '') = '') ORDER BY Store_Items.ID DESC"
        UpdateCommand="[usp_Update_Store_Items]" UpdateCommandType="StoredProcedure"
        DeleteCommand="
DELETE FROM Store_Items WHERE (Item_Code = @Item_Code)
">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox_Item" DefaultValue="%" Name="Item_Name"
                PropertyName="Text" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridViewElementValues" Name="Item_Code" PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ItemCode" Type="String" />
            <asp:Parameter Name="ItemName" Type="String" />
            <asp:Parameter Name="Manufacturer" Type="String" />
            <asp:Parameter Name="Is_Serial" Type="Boolean" />
            <asp:Parameter Name="Is_Expiry" Type="Boolean" />
            <asp:Parameter Name="Part_No" Type="String" />
            <asp:Parameter Name="Long_Description" Type="String" /> 
            <asp:ControlParameter ControlID="DropDownList_General_Category" Name="Category" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="DropDownList_Category" Name="Item_Type_Id" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Generic_ItemName" Name="G_N_Id" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownListUnit" Name="Unit" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtmin" Name="Min" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtMax" Name="max" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtReorder" Name="reorder" PropertyName="Text" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridViewElementValues" runat="server" AutoGenerateColumns="False"
        Width="100%" DataSourceID="SqlDataSourceForGrid" AllowPaging="True" PageSize="50"
        DataKeyNames="Item_Code" EmptyDataText="No Record(s) Found.">
        <FooterStyle CssClass="GridPager" />
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
        <Columns>
            <asp:CommandField ShowDeleteButton="False" />
            <asp:TemplateField Visible="False">
                <EditItemTemplate>
                    <asp:ImageButton ID="ImageButton3" runat="server" CommandName="Update" ImageUrl="~/images/icon_ok.png"
                        ToolTip="Update" /><asp:ImageButton ID="ImageButton4" runat="server" CommandName="Cancel"
                            ImageUrl="~/images/icon_err.gif" ToolTip="Cancel" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:ImageButton ID="ImageButton1" runat="server" CommandName="Edit" ImageUrl="~/images/icon_edit.png"
                        OnClientClick="return confirmation_edit(this)" ToolTip="Edit" Visible="False" /><asp:ImageButton
                            ID="ImageButton2" runat="server" CommandName="Delete" Width="10px" Height="11px"
                            ImageUrl="~/images/icon_delete.png" OnClientClick="return confirmation(this)"
                            ToolTip="Delete" Visible="False" />
                    <asp:HiddenField ID="HiddenField_IC" runat="server" Value='<%# Bind("Item_Code") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:ButtonField CommandName="ChangeCode" DataTextField="Item_Code" SortExpression="Item_Code" />
            <asp:BoundField DataField="Item_Name" HeaderText="Item Name" SortExpression="Item_Name" />
            <asp:BoundField DataField="Item_Type" HeaderText="Category" />
            <asp:BoundField DataField="Unit" HeaderText="Unit" SortExpression="Unit" />
            <asp:BoundField DataField="Generic_Name" HeaderText="Sub Category" />
            <asp:TemplateField HeaderText="Item Category" SortExpression="DrugCategory" Visible="False">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DrugCategory") %>' ReadOnly="True"></asp:TextBox>
                    <asp:DropDownList ID="DropDownList_Category_Grid" runat="server" Width="159px" DataSourceID="SqlDataSource_Item_Category"
                        DataTextField="Item_Category" DataValueField="Item_Category">
                        <asp:ListItem Selected="True">Tabs</asp:ListItem>
                        <asp:ListItem>Caps</asp:ListItem>
                        <asp:ListItem>Dry Susp</asp:ListItem>
                        <asp:ListItem>INJ</asp:ListItem>
                        <asp:ListItem>Cotton Wool</asp:ListItem>
                        <asp:ListItem>Susp</asp:ListItem>
                        <asp:ListItem>Cream</asp:ListItem>
                        <asp:ListItem>Infusion</asp:ListItem>
                        <asp:ListItem>Drops</asp:ListItem>
                        <asp:ListItem>Oral Soln</asp:ListItem>
                        <asp:ListItem>Paper</asp:ListItem>
                        <asp:ListItem>Set</asp:ListItem>
                        <asp:ListItem>CatGut</asp:ListItem>
                        <asp:ListItem>Syringe</asp:ListItem>
                        <asp:ListItem>Surgical items</asp:ListItem>
                        <asp:ListItem>Syrp</asp:ListItem>
                        <asp:ListItem>Inhaler</asp:ListItem>
                        <asp:ListItem>Sol</asp:ListItem>
                        <asp:ListItem>Lotion</asp:ListItem>
                        <asp:ListItem>Tincture</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("DrugCategory") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="General Category" SortExpression="Category">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList_Cat" runat="server" DataSourceID="SqlDataSourceGeneral_Category"
                        DataTextField="Item_Category" DataValueField="Item_Category_ID" SelectedValue='<%# Bind("Item_Category_ID", "{0}") %>'
                        Width="156px" Visible="False">
                    </asp:DropDownList>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Category") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Category") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Potency" HeaderText="Potency" SortExpression="Potency"
                Visible="False" />
            <asp:TemplateField HeaderText="Unit" SortExpression="Unit" Visible="False">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList_Unit" runat="server" DataSourceID="SqlDataSourceUnit"
                        DataTextField="unit" DataValueField="unit" SelectedValue='<%# Bind("Unit") %>'
                        Width="155px">
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Unit") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Manufacturer" HeaderText="Manufacture Name" SortExpression="Manufacturer" />
            <asp:TemplateField HeaderText="Expiry" SortExpression="Expiry_Item">
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox_Edit_Expiry" runat="server" Checked='<%# Bind("Expiry_Item") %>' />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox_Expiry" runat="server" Checked='<%# Bind("Expiry_Item") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ITemcode" SortExpression="Item_Code" Visible="False">
                <EditItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Item_Code") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="MinLevel" HeaderText="MinLevel" SortExpression="MinLevel" />
            <asp:BoundField DataField="MaxLevel" HeaderText="MaxLevel" SortExpression="MaxLevel" />
            <asp:BoundField DataField="ReOrder" HeaderText="ReOrder" SortExpression="ReOrder" />
        </Columns>
        <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceSaveInfo" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="Insert_Store_Item" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
        InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="DropDownListUnit" Name="Unit" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList_General_Category" Name="Category" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_Item" Name="Item_Name" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBoxPotency" Name="Potency" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_Drug_Category_Item" Name="Drug_Category"
                PropertyName="Value" Type="String" />
            <asp:Parameter DefaultValue="true" Name="Store_Category" Type="Boolean" />
            <asp:ControlParameter ControlID="RadioButtonList_Expiry" Name="Expiry_Item" PropertyName="SelectedValue"
                Type="Boolean" />
            <asp:ControlParameter ControlID="TextBox_ItemCode" Name="Item_Code" PropertyName="Text"
                Type="String" DefaultValue="0" />
            <asp:ControlParameter ControlID="DropDownList_Generic_ItemName" Name="G_N_Id" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:SessionParameter Name="EMP_ID" SessionField="emp_id" Type="Int32" />
            <asp:ControlParameter ControlID="DropDownList_Category" Name="Drug_Category_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter Name="Allow_Serial" Type="Boolean" DefaultValue="False" />
           <%-- <asp:ControlParameter ControlID="HF_Allow_Serial" Name="Allow_Serial" PropertyName="Value"
                Type="Boolean" />--%>
            <asp:ControlParameter ControlID="txt_Description" Name="Item_Description" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="txtPartNumber" Name="Part_No" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="ddlManufacturer" Name="Manufacturer" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="txtReorder" Name="reOrder" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtmin" Name="MinLevel" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtMax" Name="MaxLevel" PropertyName="Text" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
    <asp:HiddenField ID="HiddenField_Manufacturer" runat="server" />
    <asp:HiddenField ID="HiddenField_Drug_Category" runat="server" />
    <asp:HiddenField ID="HiddenFieldItemCatagory" runat="server" />
    <br />
    <br />
    <asp:Panel runat="server" ID="ItemCatagory" Visible="False">
        <div class="lightbox">
            <div style="float: right; margin-right: 10px; margin-top: 5px;">
                <asp:ImageButton ID="btn_cls_medcat" runat="server" ImageUrl="~/images/icon_delete.png" />
            </div>
            <div class="bxmain">
                <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                    <tr>
                        <td align="right" width="40%">
                            Category Name :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_Item_Category" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="40%">
                            Category Abbrivation :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_Cat_Abb" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" width="40%">
                        </td>
                        <td>
                            &nbsp;
                            <asp:Button ID="ButtonSearchItemCategory" runat="server" Text="Search" />
                            <asp:Button ID="Button_SaveItemCategory" runat="server" Text="Save" />
                        </td>
                    </tr>
                </table>
                <asp:GridView ID="GridView_Category" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    AutoGenerateDeleteButton="True" DataKeyNames="Item_Category_ID" DataSourceID="SqlDataSourceForMedCat"
                    PageSize="20" Width="100%" Visible="False">
                    <RowStyle CssClass="GridItem" />
                    <Columns>
                        <asp:BoundField DataField="Item_Category" HeaderText="Item Category Name" SortExpression="Item_Category" />
                        <asp:BoundField DataField="Cat_Abbr" HeaderText="Category Abbrivation" SortExpression="Cat_Abbr" />
                        <asp:BoundField DataField="Item_Category_ID" HeaderText="Med_Cat_ID" InsertVisible="False"
                            ReadOnly="True" SortExpression="Item_Category_ID" Visible="False" />
                    </Columns>
                    <FooterStyle CssClass="GridPager" />
                    <PagerStyle CssClass="GridPager" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
            </div>
            <br />
            <div style="height: 300px; overflow: auto; overflow-x: hidden;">
            </div>
            <asp:SqlDataSource ID="SqlDataSourceForMedCat" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                DeleteCommand="DELETE FROM Store_Item_Category WHERE (Item_Category_ID = @Item_Category_ID)"
                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT Item_Category_ID, Item_Category, Cat_Abbr, Current_ID FROM Store_Item_Category WHERE (Item_Category LIKE '%'+@Item_Category + '%')">
                <SelectParameters>
                <asp:Parameter Name="Item_Category" DbType="String" />
                   <%-- <asp:ControlParameter ControlID="TextBox_Item_Category" DefaultValue="%" Name="Item_Category"
                        PropertyName="Text" />--%>
                </SelectParameters>
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridViewElementValues" Name="Item_Category_ID" PropertyName="SelectedValue" />
                </DeleteParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceSaveMedCat" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
                InsertCommand="[Insert_Store_Item_Category]" ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>"
                InsertCommandType="StoredProcedure">
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBox_Item_Category" Name="Item_Category" PropertyName="Text" />
                    <asp:ControlParameter ControlID="TextBox_Cat_Abb" Name="Cat_Abbr" PropertyName="Text" />
                    <asp:Parameter DefaultValue="1" Name="Current_ID" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>
    </asp:Panel>
    <br />
    <asp:Panel runat="server" ID="ItemType" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox" style="display: block;">
            <div style="float: right; margin-right: 10px; margin-top: 5px;">
                <asp:ImageButton ID="btn_cls_medtype" runat="server" ImageUrl="~/images/icon_delete.png" />
            </div>
            <div class="bxmain">
                <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                    <tr>
                        <td align="right" width="40%">
                            Item Type :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_ItemType" runat="server" CssClass="input_txt" Width="200px"></asp:TextBox>&nbsp;
                            <asp:Button ID="Button_SearchMedType" runat="server" Text="Search" />&nbsp;
                            <asp:Button ID="Button_SaveMedType" runat="server" CssClass="btn1" Text="Save" />
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <div style="height: 300px; overflow: auto; overflow-x: hidden;">
                <asp:GridView ID="GridView_ItemType" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="Item_Type_Id" DataSourceID="SqlDataSourceForItemTypeGrid" PageSize="20"
                    Width="100%" HorizontalAlign="Left" EnableModelValidation="True">
                    <FooterStyle CssClass="GridPager" />
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="Item_Type" HeaderText="Item Category" SortExpression="Item_Type" />
                        <asp:BoundField DataField="Item_Type_Id" HeaderText="Id" InsertVisible="False" ReadOnly="True"
                            SortExpression="Item_Type_Id" Visible="False" />
                    </Columns>
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                    <EmptyDataTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Item_Type", "{0}") %>'></asp:Label>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
            <asp:HiddenField ID="HiddenField_itemType" runat="server" Value="%" />
            <asp:SqlDataSource ID="SqlDataSourceForItemTypeGrid" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                DeleteCommand="DELETE FROM Store_Item_Types WHERE (Item_Type_Id = @Item_Type_Id)"
                InsertCommand="INSERT INTO Store_Item_Types(Item_Type) VALUES (@cat)" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                SelectCommand="Store_Items_category" SelectCommandType="StoredProcedure" UpdateCommand="UPDATE Store_Item_Types SET Item_Type = @Item_Type  WHERE (Item_Type_Id = @Item_Type_Id)">
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridView_ItemType" Name="Item_Type_Id" PropertyName="SelectedValue" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Item_Type" />
                    <asp:Parameter Name="Item_Type_Id" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBox_ItemType" Name="cat" PropertyName="Text" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField_itemType" DefaultValue="%" Name="Item_Category"
                        PropertyName="Value" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <asp:HiddenField ID="HiddenField1" runat="server" />
        </div>
    </asp:Panel>
    <br />
    <br />
    <%--</div>--%>
    <asp:Panel runat="server" ID="medUnit" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="float: right; margin-right: 10px; margin-top: 5px;">
                <asp:ImageButton ID="btn_cls_unit" runat="server" ImageUrl="~/images/icon_delete.png" />
            </div>
            <div class="bxmain">
                <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                    <tr>
                        <td align="right" width="40%">
                            Unit Name :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_Unit" runat="server" CssClass="input_txt" Width="200px"></asp:TextBox>&nbsp;
                            <asp:Button ID="Button_SearchUnit" runat="server" Text="Search" />&nbsp;
                            <asp:Button ID="Button_SaveUnit" runat="server" CssClass="btn1" Text="Save" />
                        </td>
                    </tr>
                </table>
            </div>
            <asp:HiddenField ID="HiddenField_ItemUnit" runat="server" Value="%" />
            <br />
            <div style="height: 300px; overflow: auto; overflow-x: hidden;">
                <asp:GridView ID="GridView_Unit" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    AutoGenerateDeleteButton="True" DataKeyNames="unit" DataSourceID="SqlDataSource_Unit"
                    PageSize="20" Width="100%">
                    <RowStyle CssClass="GridItem" />
                    <Columns>
                        <asp:BoundField DataField="unit" HeaderText="Item Unit" SortExpression="unit" />
                    </Columns>
                    <FooterStyle CssClass="GridPager" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
            </div>
            <asp:SqlDataSource ID="SqlDataSource_Unit" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                DeleteCommand="DELETE FROM Item_Unit WHERE (unit = @unit)" InsertCommand="INSERT INTO Item_Unit(unit) VALUES (@unit)"
                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT unit FROM Item_Unit where unit like @unit+'%' ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox_Item_Category" DefaultValue="%" Name="unit"
                        PropertyName="Text" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridViewElementValues" Name="unit" PropertyName="SelectedValue" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBox_Unit" Name="unit" PropertyName="Text" />
                </InsertParameters>
            </asp:SqlDataSource>
            <br />
        </div>
        <%--</div>--%></asp:Panel>
    <br />
    <asp:Panel runat="server" ID="GenericName" Visible="false" CssClass="lightbox_bg">
        <div class="lightbox">
            <div style="float: right; margin-right: 10px; margin-top: 5px;">
                <asp:ImageButton ID="btn_cls_gname" runat="server" ImageUrl="~/images/icon_delete.png" />
            </div>
            <div class="bxmain">
                <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                    <tr>
                        <td align="right" width="40%">
                            Item Name :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_Generic_Name" runat="server" CssClass="input_txt" Width="200px"></asp:TextBox>&nbsp;
                            <asp:Button ID="Button_SearchGeneric" runat="server" CssClass="btn1" Text="Search" />
                            &nbsp;
                            <asp:Button ID="Button_Generic" runat="server" CssClass="btn1" Text="Save" />
                        </td>
                    </tr>
                </table>
            </div>
            <br />
            <div style="height: 300px; overflow: auto; overflow-x: hidden;">
                <asp:GridView ID="GridView_GenericName" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="G_N_Id" DataSourceID="SqlDataSource_GenericName" PageSize="20"
                    Width="100%" EnableModelValidation="True">
                    <RowStyle CssClass="GridItem" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="Generic_Name" HeaderText="Item" SortExpression="Generic_Name" />
                        <asp:BoundField DataField="G_N_Id" HeaderText="G_N_Id" InsertVisible="False" SortExpression="G_N_Id"
                            Visible="False" />
                    </Columns>
                    <FooterStyle CssClass="GridPager" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                    <EmptyDataTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Item_Category", "{0}") %>'></asp:Label>
                    </EmptyDataTemplate>
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                </asp:GridView>
                <asp:HiddenField ID="HiddenField2" runat="server" />
            </div>
            <asp:HiddenField ID="HiddenField_item_GenericName" runat="server" Value="%" />
            <asp:SqlDataSource ID="SqlDataSource_GenericName" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                DeleteCommand="DELETE FROM Generic_Names&#13;&#10;WHERE     (G_N_Id = @G_N_Id)&#13;&#10;"
                InsertCommand="INSERT INTO Generic_Names (Generic_Name, Cat_Id) VALUES (@Generic_Name,@Cat_Id)"
                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT G_N_Id, Generic_Name FROM Generic_Names WHERE (Generic_Name like @Generic_Name + '%')"
                UpdateCommand="UPDATE    Generic_Names&#13;&#10;SET              Generic_Name = @Generic_Name&#13;&#10;WHERE     (G_N_Id = @G_N_Id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HiddenField_item_GenericName" DefaultValue="" Name="Generic_Name"
                        PropertyName="Value" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:ControlParameter ControlID="GridViewElementValues" Name="G_N_Id" PropertyName="SelectedValue" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Generic_Name" />
                    <asp:Parameter Name="G_N_Id" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="TextBox_Generic_Name" Name="Generic_Name" PropertyName="Text" />
                    <asp:ControlParameter ControlID="HiddenFieldItemCatagory" Name="Cat_Id" PropertyName="Value" />
                </InsertParameters>
            </asp:SqlDataSource>
            <br />
        </div>
    </asp:Panel>
    <%-- </div> --%>
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Generic_Item_Name" runat="server" ConnectionString="<%$ ConnectionStrings:StoreConnectionString2 %>"
        ProviderName="<%$ ConnectionStrings:StoreConnectionString2.ProviderName %>" SelectCommand="SELECT [Generic_Name], [G_N_Id] FROM [Generic_Names] WHERE ([Cat_Id] = @Cat_Id)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Category" Name="Cat_Id" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceUnit" runat="server" ConnectionString="<%$ ConnectionStrings:Pharmacy_ConnectionString %>" SelectCommand="SELECT DISTINCT unit FROM Medicine_Unit">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceGeneral_Category" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT Item_Category_ID, Item_Category FROM Store_Item_Category WHere Current_ID=1 ORDER BY Item_Category">
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldItem_Name" runat="server" />
    <asp:HiddenField ID="HiddenField_Unit" runat="server" />
    <asp:HiddenField ID="HiddenField_Drug_Category_Item" runat="server" />
    <asp:HiddenField ID="HiddenField_Potency" runat="server" />
    <asp:HiddenField ID="HiddenFieldCategory" runat="server" />
    <asp:HiddenField ID="HiddenFieldItem_code" runat="server" />
    <asp:HiddenField ID="HiddenField_Expiry" runat="server" />
    <asp:HiddenField ID="HiddenFieldDrugCategory" runat="server" />
    <br />
    <br />
    
    
    <asp:LinkButton ID="LinkButton_Unit" runat="server" Visible="false">Add New Unit</asp:LinkButton>
    <asp:TextBox ID="TextBoxPotency" runat="server" CssClass="input_txt" Visible="false"></asp:TextBox>
</asp:Content>
