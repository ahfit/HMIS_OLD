<%@ Page Title="" Language="VB" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="false" CodeFile="IssueItemsExternal.aspx.vb" Inherits="Store_IssueItemsExternal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>

    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" media="screen, projection" />
    <script src="../css_hacims/SpryAssets/SpryTabbedPanels.js" type="text/javascript"></script>
    <link href="css_hacims/SpryAssets/SpryTabbedPanels.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .input_txt
        {
            margin-top:3px;
        }
        
    </style>
    <script type="text/javascript">
        function CheckQuantityLimit(valueCmp, txtBox,txtDemandQty) {
            try {
                var textBox = document.getElementById(txtBox);
                var maxAllow = parseInt(valueCmp);
                var demandQtyCtrl = document.getElementById(txtDemandQty);
                var max2Allow = parseInt(demandQtyCtrl.value);
                if (max2Allow < maxAllow)
                    maxAllow = max2Allow;
                var enteredValue = parseInt(textBox.value);
                if (enteredValue > maxAllow) {
                    alert('Maximum allowed items : ' + maxAllow);
                    textBox.value = "";
                    textBox.focus();
                }
            }
            catch (e) {
                alert(e);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
   
   <div style="padding: 10px; border: #CCCCCC solid 1px; border-radius: 4px;">
        <asp:DataList ID="dlist_info" runat="server" DataSourceID="SqlDataSource_demand_Info"
            Width="100%" Visible="false">
            <ItemTemplate>
            <span width = "100%"> <strong><h1>  Customer Requisition Info  </h1>   </strong></span>
                <strong>Demand Detail : </strong><asp:Label ID="Label1" runat="server" Text="Demanded By Departement : " Font-Bold="true"></asp:Label>
                <asp:Label ID="Label2" runat="server" CssClass="err" Text='<%# Eval("[Demanded By Department]", "{0}") %>'></asp:Label><span
                    class="splt">|</span>
                <asp:Label ID="Label3" runat="server" Text="Demanded By : " Font-Bold="true"></asp:Label>
                <asp:Label ID="Label4" runat="server" CssClass="err blue" Text='<%# Eval("[Demanded By]", "{0}") %>'></asp:Label><span
                    class="splt">|</span>
                
                <asp:Label ID="Label5" runat="server" Text="Demand Date : " Font-Bold="true"></asp:Label>
                <asp:Label ID="Label6" runat="server" CssClass="txt_gray" Style="color: #06F;" Text='<%# Eval("Date", "{0}") %>'></asp:Label>
                  <span class="splt">|</span>&nbsp;<strong> For Customer : <strong>
                    <asp:Label ID="LabelCompany" runat="server" Text='<%# Eval("Party_Name") %>'></asp:Label></strong>
                <span class="splt">|</span> <strong style="font-weight:bold;">Address : <strong>
                    <asp:Label ID="LabelAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label></strong>
                &nbsp;( ph# <strong>
                    <asp:Label ID="LabelPhone" runat="server" Text='<%# Eval("Party_Phone") %>'></asp:Label></strong>
                -Fax # <strong>
                    <asp:Label ID="LabelFax" runat="server" Text='<%# Eval("Party_Fax") %>'></asp:Label></strong>
                &nbsp;) &nbsp;<asp:Label ID="lbl_site" runat="server" Text="To be deliver at  "  Font-Bold="true"></asp:Label>
                &nbsp;<strong><asp:Label ID="SiteLabel" runat="server" Text='<%# Eval("Delivery_Site") %>'
                   ></asp:Label></strong> <span class="splt">|</span>
                    <br />
                <asp:Label ID="Label12" runat="server" Text=" ( "></asp:Label>
                <asp:Label ID="Lbl_D_Add" runat="server" Text='<%# Eval("Delivery_Address") %>' ></asp:Label>
                <asp:Label ID="Label13" runat="server" Text=" ) " ></asp:Label>
                <asp:Label ID="Label14" runat="server" Text=" Recieved by " Font-Bold="true"></asp:Label>
                <strong>
                    <asp:Label ID="lbl_C_Per" runat="server" Text='<%# Eval("Contact_Person") %>' ></asp:Label></strong>
                <asp:Label ID="Label16" runat="server" Text=" Contact at " ></asp:Label>
                <strong>
                    <asp:Label ID="lbl_phone" runat="server" Text='<%# Eval("Phone_No") %>'></asp:Label></strong>
                <asp:HiddenField ID="HF_by_dept_id" runat="server" Value='<%# Eval("By_Dept_ID") %>' />
                <asp:Label ID="Label9" runat="server" CssClass="errblue" Text='<%# Eval("Reg_No", "{0}") %>'></asp:Label>
                <asp:HiddenField ID="HF_Company_ID" runat="server" Value='<%# Eval("Company_ID") %>' />
            </ItemTemplate>
        </asp:DataList>
        <br />
        <span width = "100%" style="display:none;"> <strong><h1> Official Information  </h1>   </strong></span>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%" style="display:none;">
            <tr>
                <td>Delivery Method : <asp:TextBox ID="txt_delivery_method" runat="server"></asp:TextBox>
                                   </td>
                <td>Delivery No : <asp:TextBox ID="txt_delivery_m_No" runat="server"></asp:TextBox></td>
                <td>Delivery Person : <asp:TextBox ID="txt_delivery_p_info" runat="server"></asp:TextBox></td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource_demand_Info" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="Store_Demand_Info"
            SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="HiddenField_RequisitionID" Name="IB_ID" PropertyName="Value"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <br />
    <div style="width:100%;">
        <asp:Label ID="lblMsgs" runat="server" Text=""></asp:Label>
    </div>
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td valign="top" width="33%">
                <div class="bxmain inner_content" style="width: 98%;">
                    <h2>
                        <span >Requested Items</span></h2>
                    <br />
                    <div style="width: 100%; height: 505px; overflow: auto; overflow-x: hidden;">
                        <asp:DataList ID="DataList_DataList" runat="server" DataKeyField="Item_Code" DataSourceID="SqlDataSource_Issue_Item_Main"
                            RepeatLayout="Flow" SelectedItemStyle-BackColor="#666666" Style="margin-left: 10px;"
                            Width="95%">
                            <ItemTemplate>
                                <div class="bxmain3" style="padding-left: 10px;">
                                    <strong>
                                        <asp:LinkButton ID="LinkButton_Subject" runat="server" CommandArgument='<%# Eval("Item_Code") %>'
                                            CssClass="link_item" OnClick="LinkButton_Subject_Click" Text='<%# Eval("Item") %>'></asp:LinkButton></strong>
                                    <asp:HiddenField ID="HiddenField_Item_Code" runat="server" Value='<%# Eval("Item_Code") %>' />
                                    <asp:HiddenField ID="HiddenField_Item_Name" runat="server" Value='<%# Eval("Item") %>' />
                                    <br />
                                    Stock :<strong style="color: #009900;"><asp:Label ID="StockLabel" runat="server"
                                        Text='<%# Eval("Stock") %>'></asp:Label>
                                    </strong>&nbsp;<span class="splt">|</span> Item Code : <strong style="color: #0066CC;">
                                        <asp:Label ID="Item_CodeLabel" runat="server" Text='<%# Eval("Item_Code") %>'></asp:Label>
                                    </strong>
                                    <asp:Label ID="Dept_IDLabel" runat="server" Text='<%# Eval("Dept_ID") %>' Visible="false">
                                    </asp:Label>
                                    <span class="splt">|</span>
                                    <asp:Label ID="Dept_NameLabel" runat="server" Text='<%# Eval("Dept_Name") %>' Visible="false">
                                    </asp:Label>
                                    <asp:Label ID="From_Dept_IDLabel" runat="server" Text='<%# Eval("From_Dept_ID") %>'
                                        Visible="false"></asp:Label>
                                    <asp:Label ID="From_Sub_Dept_IDLabel" runat="server" Text='<%# Eval("From_Sub_Dept_ID") %>'
                                        Visible="false"></asp:Label>
                                    Demand Qty : <strong style="color: #009900;"><strong style="color: #CC0000;">
                                        <asp:Label ID="Demand_QtyLabel" runat="server" Text='<%# Eval("[Demand Qty]") %>'>
                                        </asp:Label>
                                    </strong>&nbsp;</strong><asp:Label ID="lbl_t_issue" runat="server" Text='<%# Eval("Total_Tobe_Issued") %>'
                                        Visible="False"></asp:Label>
                                    &nbsp; Allow serial :
                                    <asp:CheckBox ID="CB_Serial" runat="server" Enabled="false" Checked='<%# Eval("Allow_Serial") %>' />
                                    <asp:Label ID="Company_IDLabel" runat="server" Text='<%# Eval("Company_ID") %>' Visible="false">
                                    </asp:Label>
                                </div>
                            </ItemTemplate>
                            <SelectedItemStyle BackColor="#666666" />
                        </asp:DataList>
                    </div>
                </div>
                <!--End_bxmain-->
            </td>
            <td valign="top" width="45%">
                <div class="bxmain inner_content" style="width: 95%; float: left;">
                    
                        <h2><span>Available Stock</span></h2>
                        <asp:Label ID="lblSelectedItem" runat="server" Text=""></asp:Label>
                        <asp:TextBox ID="txtDemandQty" runat="server"  style="display:none;" Text=""></asp:TextBox>
                    
                    <br />
                    <asp:GridView ID="gvItemDetail" runat="server" Style="margin: auto;" AutoGenerateColumns="False"
                        Width="100%" DataSourceID="sqlDs_ItemStockData"  
                        BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                        EnableModelValidation="True" GridLines="Vertical">
                        <AlternatingRowStyle BackColor="#DCDCDC" />
                        <Columns>
                            <asp:BoundField DataField="Item_Code" Visible="false" HeaderText="Item Code" />
                            <asp:BoundField DataField="Item_Name" Visible="false" HeaderText="Item Name" />
                            <asp:BoundField DataField="PO_ID" HeaderText="PO #" />
                            <asp:BoundField DataField="BatchNo" HeaderText="Batch #" />
                            <asp:BoundField DataField="Receive_Date" HeaderText="Rec. Date" DataFormatString="{0:dd/MM/yy}" />
                            <asp:BoundField DataField="Exp" HeaderText="Expiry Date" DataFormatString="{0:dd/MM/yy}" />
                            <asp:BoundField DataField="Item_Qty" HeaderText="Total Qty." ItemStyle-HorizontalAlign="Right"
                                ReadOnly="True" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Issued_Qty" HeaderText="Issued Qty." ItemStyle-HorizontalAlign="Right"
                                ReadOnly="True" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Consumed_Qty" HeaderText="Consumed Qty." ItemStyle-HorizontalAlign="Right"
                                ReadOnly="True" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="Saved_Qty" HeaderText="Resvd. Qty" ItemStyle-HorizontalAlign="Right"
                                ReadOnly="true" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Remaining Bal.">
                                <ItemTemplate>
                                    <asp:Label ID="lblRemainingBalance" runat="server" Text='<%# Eval("Remaining_Balance") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Issue Qty.">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hfld_Receive_Date" runat="server" Value='<%# Eval("Receive_Date","{0:yyyy-MM-dd}") %>' />
                                    <asp:HiddenField ID="hfld_Exp" runat="server" Value='<%# Eval("Exp","{0:yyyy-MM-dd}") %>' />
                                    <asp:HiddenField ID="hfld_SubId" runat="server" Value='<%# Eval("Sub_Id") %>' />
                                    <asp:HiddenField ID="hfld_Item_Code" runat="server" Value='<%# Eval("Item_Code") %>' />
                                    <asp:HiddenField ID="hfld_BatchNo" runat="server" Value='<%# Eval("PO_ID") %>' />
                                    <asp:HiddenField ID="hfld_PK_ID" runat="server" Value='<%# Eval("PK_ID") %>' />
                                    <asp:TextBox ID="txtIssueQty" Width="98%" runat="server" Text=""></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                        <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                </div>
                <br />
                 <div style="text-align:center; width: 98%; margin-top:20px;">
                    <asp:Button ID="btnSaveTemp" runat="server" Text="Save Stock" />&nbsp;&nbsp;
                    <asp:Button ID="btnSave" runat="server" Text="Issue Stock" Visible="false" />
                    
                                    <asp:Button ID="btnIssuetoCustomer" runat="server" Text="Issue Stock" />
                </div>

                
            </td>
            <td width="20%" style="vertical-align:top;">

                <div class="bxmain inner_content" style="width: 100%;">
                    
                        <h2><span>Reserved Stock</span></h2>
                    <br />
                    <asp:GridView ID="gvReservedItems" runat="server" Style="margin: auto;" AutoGenerateColumns="False"
                        Width="100%" DataSourceID="sqlDs_ReservedStockData">
                        <Columns>
                           
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:HiddenField ID="hfld_Sub_Id" runat="server" Value='<%# Eval("Sub_Id") %>' />
                                    <asp:HiddenField ID="hfld_Item_Code" runat="server" Value='<%# Eval("Item_Code") %>' />
                                    <asp:HiddenField ID="hfld_Item_Qty" runat="server" Value='<%# Eval("Qty") %>' />
                                    <asp:HiddenField ID="hfld_BatchNo" runat="server" Value='<%# Eval("PO_ID") %>' />
                                    <asp:HiddenField ID="hfld_PK_ID" runat="server" Value='<%# Eval("PK_ID") %>' />
                                    <asp:ImageButton ID="imgBtnDelete" runat="server" OnClick="imgBtnDelete_Click" ImageUrl="~/images_hacims/icon_delete.gif"
                                        CommandArgument='<%#Eval("PK_ID")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="SrNo."> 
<ItemTemplate> <%#Container.DataItemIndex+1%> 
</ItemTemplate>
<ItemStyle Width="3%" /> 
</asp:TemplateField>
                            <asp:BoundField DataField="Item_Code" HeaderText="Item Code" />
                            <asp:BoundField DataField="PO_ID" HeaderText="PO #" />
                            <asp:BoundField DataField="Qty" HeaderText="Qty." ItemStyle-HorizontalAlign="Right"
                                ReadOnly="True" />
                                 <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgBtnDetail" runat="server" ImageUrl="~/images_hacims/icon_detail.png"
                                                CommandArgument='<%# Eval("PK_ID") %>' Visible='<%# Eval("Detail") %>' OnClick="imgBtnDetail_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <br />
                        <div class="bxmain inner_content" style="width: 100%; display:none;">
                            <h2>
                                <span>Serials Detail</span></h2>
                            <asp:GridView ID="gvSerialsDetail" runat="server" Width="100%" Visible="False" DataSourceID="sdsSerialsDetail"
                                EnableModelValidation="True" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="PO_ID" HeaderText="PO #" SortExpression="PO_ID" />
                                    <asp:BoundField DataField="Serial_No" HeaderText="Serial #" SortExpression="Serial_No" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsSerialsDetail" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                SelectCommand="usp_ViewSerial_Saved_Detail" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:Parameter Name="PK_ID" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                           </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:GridView ID="gvStockSerialData" DataSourceID="sqlDs_ItemStockSerialData" Width="100%" AutoGenerateColumns="false" runat="server">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr. #" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <%#Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Receive_Date" HeaderText="Received Date" />
                        <asp:BoundField DataField="Item_Code" HeaderText="Item Code" />
                        <asp:TemplateField HeaderText="PO #">
                            <ItemTemplate>
                                <asp:HiddenField ID="hfld_SubId" runat="server" Value='<%# Eval("Sub_ID") %>' />
                                <asp:HiddenField ID="hfld_Serial_No_ID" runat="server" Value='<%# Eval("Serial_NO_ID") %>' />
                                <asp:HiddenField ID="hfld_Tag_ID" runat="server" Value='<%# Eval("ID") %>' />
                                <asp:TextBox ID="txtBatchNo" runat="server" Text='<%# Eval("PO_ID") %>' Enabled="false"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Serial # / Tag #">
                            <ItemTemplate>
                                <asp:TextBox ID="txtSerialNo" runat="server" Text='<%# Eval("Serial_No") %>' Enabled="false"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkSerialSelect" runat="server" />
                            </ItemTemplate>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkSerialSelectAll" AutoPostBack="true" OnCheckedChanged="chkSerialSelectAll_CheckedChanged" runat="server" />
                            </HeaderTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="text-align:right;">
                <asp:Button ID="btnSaveSerial" runat="server" Text="Save Serials" Visible="false"/>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="HiddenField_RequisitionID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_Issue_Item_Main" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="Select_Invoice_Item"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter PropertyName="Value" Type="String" Name="IB_Id" ControlID="HiddenField_RequisitionID">
            </asp:ControlParameter>
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" Type="Int32" />
            <asp:SessionParameter Name="Dept_Id" SessionField="Dept_ID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDs_ItemStockData" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT Store_Item_Received_Sub.Sub_Id,Store_Item_Received_Sub.Item_Code, Store_Items.Item_Name, Store_Item_Received_Sub.BatchNo,
Store_Item_Received_Sub.PO_ID,Sum(Store_Item_Received_Sub.Item_Qty) Item_Qty, Sum(ISNULL(Issue.ConQty,0)) Issued_Qty, 
Sum(ISNULL(Con.ConQty,0)) Consumed_Qty, IsNull(Sum(Item_Qty),0) - Sum(ISNULL(Issue.ConQty,0))
- IsNull(Max(Store_Item_Received_Sub_Saved.Qty),0) Remaining_Balance,Store_Item_Received_Sub.Mfg,Store_Item_Received_Sub.Exp,
Store_Item_Received_Main.Receive_Date ,IsNull(Max(Store_Item_Received_Sub_Saved.PK_ID),0) PK_ID,
IsNull(Max(Store_Item_Received_Sub_Saved.Qty),0) Saved_Qty
FROM Store_Item_Received_Sub 
Inner Join Store_Item_Received_Main ON Store_Item_Received_Sub.Store_Receive_Main_ID = Store_Item_Received_Main.Store_Receive_Main_ID
Inner Join Store_Items On Store_Item_Received_Sub.Item_Code = Store_Items.Item_Code
Left Outer Join Store_Item_Received_Sub_Saved 
	On Store_Item_Received_Sub.Sub_Id = Store_Item_Received_Sub_Saved.Sub_Id
	And Store_Item_Received_Sub.Item_Code = Store_Item_Received_Sub_Saved.Item_Code 
	And Store_Item_Received_Sub.PO_ID= Store_Item_Received_Sub_Saved.PO_ID Left Outer Join
(
	Select Item_Code,Sum(Consumed_QTY) ConQty,Received_Sub_ID 
	From StoreItems_Consumption_Detail CD Inner Join 
		 StoreItem_Consumption_Main CM On CD.Consumption_Id=CM.Consumption_Id
	Where Received_Sub_ID is not null and Is_Intrernal<>1
	Group By Item_Code,Received_Sub_ID
) Con On Store_Item_Received_Sub.Item_Code=Con.Item_Code and Store_Item_Received_Sub.Sub_Id=Con.Received_Sub_ID Left Outer Join
(
	Select Item_Code,Sum(Consumed_QTY) ConQty,Received_Sub_ID 
	From StoreItems_Consumption_Detail CD Inner Join 
		 StoreItem_Consumption_Main CM On CD.Consumption_Id=CM.Consumption_Id
	Where Received_Sub_ID is not null and Is_Intrernal=1
	Group By Item_Code,Received_Sub_ID
) Issue On Store_Item_Received_Sub.Item_Code=Issue.Item_Code and Store_Item_Received_Sub.Sub_Id=Issue.Received_Sub_ID
Where Store_Item_Received_Main.Receive_Sub_dept_Id = @Receive_Sub_dept_Id 
And Store_Item_Received_Sub.Item_Code = @Item_Code
Group By Store_Item_Received_Sub.Sub_Id ,Store_Item_Received_Sub.Item_Code, Store_Items.Item_Name, 
Store_Item_Received_Sub.PO_ID,Store_Item_Received_Sub.Mfg,Store_Item_Received_Sub.Exp,
Store_Item_Received_Main.Receive_Date,Store_Item_Received_Sub.BatchNo">
        <SelectParameters>
            <asp:SessionParameter Name="Receive_Sub_dept_Id" SessionField="SubDeptID" />
            <asp:Parameter Name="Item_Code" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDs_ItemStockSerialData" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="usp_Select_ItemsForIssue" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="Receive_Sub_dept_Id" SessionField="SubDeptID" />
            <asp:Parameter Name="Item_Code" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDs_ReservedStockData" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT     A.PK_ID, B.Item_Code, A.Sub_Id, A.PO_ID, A.Qty, Convert(bit,B.Allow_Serial) As Detail
FROM         Store_Item_Received_Sub_Saved AS A INNER JOIN
                      Store_Items AS B ON A.Item_Code = B.Item_Code
WHERE     (A.Requisition_ID = @Requisition_ID) AND (A.ReservedBy = @ReservedBy)"
        DeleteCommand="uspDeleteReservedItem" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="PK_ID" />
            <asp:Parameter Name="UnmarkSerial" Type="Boolean" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="Requisition_ID" QueryStringField="RequisitionID" />
            <asp:SessionParameter Name="ReservedBy" SessionField="emp_id" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDs_SaveStockData" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="uspCreateUpdateStoreItemReceivedSubSaved" InsertCommandType="StoredProcedure"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:Parameter Direction="InputOutput" Name="PK_ID" Type="Decimal" />
            <asp:Parameter Name="Sub_Id" Type="Int32" />
            <asp:Parameter Name="Item_Code" Type="String" />
            <asp:Parameter Name="BatchNo" Type="String" />
            <asp:Parameter Name="Qty" Type="Int32" />
            <asp:Parameter Name="Requisition_ID" Type="String" />
            <asp:Parameter Name="Receive_Date" Type="DateTime" />
            <asp:Parameter Name="Exp" Type="DateTime" />
            <asp:Parameter Name="ReservedBy" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>



    <asp:SqlDataSource ID="sqlDs_Store_Item_Issue_Main" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
        InsertCommand="uspCreateStore_Item_Issue_Main" 
        InsertCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:Parameter Direction="InputOutput" Name="Store_Item_Issue_Id" 
                 Type="String" Size="100" />
            <asp:Parameter Name="IB_ID" Type="String" />
            <asp:Parameter Name="Issue_By" Type="Int32" />
            <asp:Parameter Name="Issue_By_Dept_ID" Type="Int32" />
            <asp:Parameter Name="Issue_By_Sub_Dept_ID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDs_Store_Item_Issue_Sub" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
        InsertCommand="uspCreateStore_Item_Issue_Sub" 
        InsertCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:Parameter Name="Store_Item_Issue_Id" Type="Decimal" />
            <asp:Parameter Name="Item_Code" Type="String" />
            <asp:Parameter Name="Item_Qty" Type="Int32" />
            <asp:Parameter Name="BatchNo" Type="String" />
            <asp:Parameter Name="Sub_Id" Type="Int32" />
            <asp:Parameter Name="Requisition_ID" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:HiddenField ID="hfld_Store_Item_Issue_MainID" runat="server" Value="" />
    <asp:HiddenField ID="hfld_StoreItem_Consumption_Main" runat="server" Value="" />
    <asp:SqlDataSource ID="sqlDs_StoreItemReceivedSerialNo" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" 
        UpdateCommand="uspMarkStore_Item_Received_Serial_No" 
        UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="SubId" Type="Int32" />
            <asp:Parameter Name="Serial_No_ID" Type="Int32" />
            <asp:Parameter Name="RQ_ID" Type="String" />
            <asp:Parameter Name="By_Emp_ID" Type="Int32" />
            <asp:Parameter Name="Tag_ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlDs_ReservedItemCount" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="select Sum(Qty) Qty from store_item_received_sub_saved Where Sub_Id=@Sub_Id and Requisition_ID=@Requisition_ID
">
        <SelectParameters>
            <asp:Parameter Name="Sub_Id" />
            <asp:Parameter Name="Requisition_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlDs_StoreItem_Consumption_Main" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
        InsertCommand="uspCreateStoreItem_Consumption_Main" 
        InsertCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:Parameter Direction="InputOutput" Name="Consumption_Id" Type="String" Size="30" />
            <asp:Parameter Name="Consumed_By" Type="Int32" />
            <asp:Parameter Name="Dept_iD" Type="Int32" />
            <asp:Parameter Name="SubDept_Id" Type="Int32" />
            <asp:Parameter Name="Requisition_Id" Type="String" />
            <asp:Parameter Name="SO_Id" Type="String" />
            <asp:Parameter Name="Company_Id" Type="Int32" />
            <asp:Parameter Name="Delivery_Method" Type="String" />
            <asp:Parameter Name="Delivery_No" Type="String" />
            <asp:Parameter Name="Delivery_Person_Info" Type="String" />
            <asp:Parameter Name="DC_NO" Type="String" />
            <asp:Parameter Name="Delivery_Site" Type="String" />
            <asp:Parameter Name="Delivery_Address" Type="String" />
            <asp:Parameter Name="Contact_Person" Type="String" />
            <asp:Parameter Name="Phone_No" Type="String" />
            <asp:Parameter Name="Received_By" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDs_StoreItems_Consumption_Detail" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
        InsertCommand="uspStoreItems_Consumption_Detail" 
        InsertCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:Parameter Name="Consumption_Id" Type="Decimal" />
            <asp:Parameter Name="Item_Code" Type="String" />
            <asp:Parameter Name="BatchNo" Type="String" />
            <asp:Parameter Name="Consumed_QTY" Type="Double" />
            <asp:Parameter Name="Consume_Amount" Type="Double" />
            <asp:Parameter Name="Sub_Id" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDs_Storeitem_Consumption_Serial" runat="server" 
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" 
        InsertCommand="uspCreateStoreitem_Consumption_Serial" 
        InsertCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <InsertParameters>
            <asp:Parameter Name="Consumption_ID" Type="Decimal" />
            <asp:Parameter Name="Serial_No_ID" Type="Int32" />
            <asp:Parameter Name="Item_Code" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>
