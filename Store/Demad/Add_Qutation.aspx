<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true" CodeFile="Add_Qutation.aspx.cs" Inherits="Store_Add_Qutation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .bxmain2 {
            background: url("../images_mega/bxbg4.png") repeat-y scroll right bottom #E7E5F4;
            border: 1px solid #D2BFEA;
            border-radius: 4px;
            margin: 0;
            padding-bottom: 15px;
            padding-top: 10px;
            height: 530px;
        }

        .margin_right10 {
            margin-right: 10px;
        }

        .txtright span {
            text-align: right;
            display: block;
            margin-right: 5px;
        }

        .boldt {
            font-weight: bold;
            text-align: right;
            display: block;
            margin-right: 5px;
        }

        .sel_pos {
            position: relative;
            margin-top: -36px;
            float: right;
            margin-right: 10px;
        }

        .splt {
            padding-left: 5px;
            padding-right: 5px;
        }


        .bxmain {
            min-height: 175px;
        }

        .bxmain2 {
            min-height: 175px;
        }

        .bxmain3 {
            min-height: 175px;
        }

        .bxmain4 {
            min-height: 175px;
        }

        .data_scroll {
            height: 650px;
            overflow-x: hidden;
            overflow-y: auto;
            width: 99%;
            padding-left: 5px;
        }


        .color_b {
            color: #000000;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function (e) {

            $.fn.commas = function () {
                return this.each(function () {
                    $(this).text($(this).text().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,"));
                })
            }


            $(".total_payable").html($("#ctl00_ContentPlaceHolder1_GridviewPayable .boldt").text());
            $(".total_receiveable").html($("#ctl00_ContentPlaceHolder1_GridviewReceiveable .boldt").text());

            $("span").commas();

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 99%;">
        <h2><span>Add Qutation</span></h2>
        <table width="90%" border="0" cellpadding="0" cellspacing="0" class="tbl_form" style="text-align: center;">
            <tr align="center">
                <td align="right" width="5%">Vendor : 
                </td>
                <td align="left" width="5%">
                    <asp:DropDownList ID="ddlVendor" runat="server" DataSourceID="SDS_Vendor"
                        DataTextField="Party_Name" DataValueField="Party_Id" Width="30%">
                    </asp:DropDownList>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Store/Add_New_Company.aspx" Target="_blank">Add Vender</asp:HyperLink>

                </td>
                <%--                 <td align="center" width="10%">
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Store/Add_New_Company.aspx" Target="_blank">Add Vender</asp:HyperLink>
                    </td>--%>


                <td align="right" width="5%">Date : 
                </td>
                <td align="left" width="10%">
                    <asp:TextBox ID="txtDate" runat="server" TextMode="Date" Width="60%"></asp:TextBox>
                </td>
            </tr>
            <tr align="center">
                <td align="right" width="10%">Contact Person : 
                </td>
                <td align="left" width="10%">
                    <asp:TextBox ID="txtPerson" runat="server" Width="30%"></asp:TextBox>
                </td>
                <%--<td></td>--%>
                <td align="right" width="20%">Person Contact # : 
                </td>
                <td align="left" width="20%">
                    <asp:TextBox ID="txtContactNo" runat="server" Width="60%" MaxLength="11"></asp:TextBox>
                </td>
            </tr>
            <tr align="center">
                <td align="right" width="20%">With Effect Date : 
                </td>
                <td align="left" width="20%">
                    <asp:TextBox ID="txtWEDate" runat="server" Width="30%" TextMode="Date"></asp:TextBox>
                </td>
                <%--<td></td>--%>
                <td align="right" width="25%">Attach Quotation : 
                </td>
                <td align="left" width="25%">
                    <asp:FileUpload ID="fuQuotationUpload" runat="server" />
                </td>
            </tr>
            <tr>
                <td align="right">Type :
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList_potype" OnSelectedIndexChanged="DropDownList_potype_SelectedIndexChanged"
                        AutoPostBack="true" runat="server" Width="30%">
                        <asp:ListItem Value="Local Purcahses">Local Purchases</asp:ListItem>
                        <asp:ListItem Value="Import">Import</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <%--<td></td>--%>
                <td align="right">Other Currency :
                </td>
                <td>
                    <asp:DropDownList ID="DDL_Other_Currency" runat="server" Width="60%" AutoPostBack="True"
                        DataSourceID="SDS_Currency" DataTextField="Currency_Name" DataValueField="Currency_Abbrivation" Enabled="false"
                        OnSelectedIndexChanged="DDL_Other_Currency_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SDS_Currency" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                        SelectCommand="SELECT [Currency_Name], [Currency_Abbrivation] FROM [Currency]"></asp:SqlDataSource>
                </td>


            </tr>
            <tr>
                <td align="right">Distributor :
                </td>
                <td>
                    <asp:DropDownList ID="ddlDistributor" DataSourceID="DataSourceDistributor" runat="server" Width="30%" OnSelectedIndexChanged="ddlDistributor_SelectedIndexChanged" AutoPostBack="true" DataTextField="Distributor" DataValueField="Distributor">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="DataSourceDistributor" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                        SelectCommand="select '---- All ----'  as Distributor from Store_Items union select Distinct Distributor from Store_Items where Distributor is not null"></asp:SqlDataSource>
                </td>
                <%--<td></td>--%>
                <td align="right">Current Rate:
                </td>
                <td>
                    <asp:TextBox ID="txtCurrencyRate" runat="server" Enabled="false" Style="width: 60%; height: 1.7em; margin-bottom: -1em;"
                        OnTextChanged="txtCurrencyRate_TextChanged" SkinID="number"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Warranty:
                </td>
                <td>
                    <asp:TextBox ID="txtWarranty" runat="server" Style="width: 30%;" Enabled="false"></asp:TextBox>
                </td>
                <%--                <td></td>--%>
                <td align="right">Manufacturer and Origin:
                </td>
                <td>
                    <asp:TextBox ID="txtOrigin" runat="server" Style="width: 60%;" Enabled="false"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Installation In Pakistan:
                </td>
                <td>
                    <asp:TextBox ID="txtInstallInPak" runat="server" Style="width: 30%;" Enabled="false"></asp:TextBox>
                </td>
                <%--<td></td>--%>
                <td align="right" width="25%">Stock Availability:
                </td>
                <td>
                    <asp:DropDownList ID="ddlStockAvailability" runat="server" Enabled="false" Style="width: 60%;">
                        <asp:ListItem Value=""></asp:ListItem>
                        <asp:ListItem Value="Yes">Yes</asp:ListItem>
                        <asp:ListItem Value="No">No</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="5" style="padding-bottom: 30px; padding-top: 30px;">
                        <asp:GridView ID="GridView1" runat="server" DataSourceID="SDS_GV" Width="97%"
                            AutoGenerateColumns="false" ShowFooter="True"
                            OnPreRender="GridView1_PreRender">
                            <Columns>
                                <asp:BoundField DataField="Item_Name" HeaderText="Item Name" />

                                <asp:TemplateField HeaderText="Item Code" Visible="false">
                                    <ItemTemplate>

                                        <asp:Label ID="lblItemCode" runat="server" Text='<%# Eval("Item_Code") %>'></asp:Label>

                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Qty Demanded">
                                    <ItemTemplate>
                                        <asp:Label ID="lblQty" runat="server" Text='<%# Eval("Item_Qty") %>'></asp:Label>


                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Unit Price">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtUnitPrice" runat="server" Width="100px"
                                            OnTextChanged="txtUnitPrice_TextChanged" Text='<%# Eval("UnitRate") %>' AutoPostBack="true"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtTotal" runat="server" Width="100px" Enabled="false" Text='<%# Eval("TotalAmount") %>'></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Discount">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDiscount" runat="server" Width="100px"
                                            OnTextChanged="txtDiscount_TextChanged" Text="0" AutoPostBack="true"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <strong>Grand Total = </strong>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Final">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtFinal" runat="server" Width="100px" Enabled="false" Text="0"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <strong>
                                            <asp:Label ID="lblGrandTotal" runat="server" Text="0"></asp:Label>
                                        </strong>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemarks" runat="server" Width="100px"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkHead" runat="server" OnCheckedChanged="chkHead_CheckedChanged" AutoPostBack="true" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkInner" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    <asp:Label ID="lblQtyMsg" runat="server" Text="Please Enter Valid Quantity" Visible="false"></asp:Label>

                    <asp:GridView ID="GridView2" runat="server" DataSourceID="sds_Sub" Width="97%"
                        AutoGenerateColumns="False" ShowFooter="true">
                        <Columns>
                            <asp:BoundField DataField="Item_Name" HeaderText="Item Name"
                                SortExpression="Item_Name" />
                            <asp:TemplateField HeaderText="Qty Demanded">
                                <ItemTemplate>
                                    <asp:Label ID="lblQty" runat="server" Text='<%# Eval("Required_Quantity") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Item Code" Visible="false">
                                <ItemTemplate>
                                    <asp:Label ID="lblItemCode" runat="server" Text='<%# Eval("Item_Code") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Quantity Offered">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtQtyOffer" runat="server" Width="100px"
                                        Text='<%# Eval("Qty_Offered") %>' AutoPostBack="True"
                                        OnTextChanged="txtQtyOffer_TextChanged"></asp:TextBox>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:Button ID="btnQtyOffer" runat="server" Text="Save Quantity"
                                        OnClick="btnQtyOffer_Click" />
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Unit Price">
                                <ItemTemplate>
                                    <asp:Label ID="lblUnitPrice" runat="server" Text='<%# Eval("Unit_Price") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total">
                                <ItemTemplate>
                                    <asp:Label ID="lblTotal" runat="server" Text='<%# Eval("Total") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Discount">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtDiscountApp" runat="server" Width="100px"
                                        Text='<%# Eval("Discount") %>'
                                        OnTextChanged="txtDiscountApp_TextChanged" AutoPostBack="true"></asp:TextBox>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <strong>Grand Total = </strong>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Final">
                                <ItemTemplate>
                                    <asp:Label ID="lblFinal" runat="server" Text='<%# Eval("Final") %>'></asp:Label>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <strong>
                                        <asp:Label ID="lblGrandTotal" runat="server" Text='<%# Eval("Grand_Total") %>'></asp:Label>
                                    </strong>
                                </FooterTemplate>
                            </asp:TemplateField>


                        </Columns>
                    </asp:GridView>

                </td>
            </tr>

            <tr align="center" valign="top">
                <td align="right">Accumulated Discount :
                    <asp:TextBox ID="txtAccDiscount" runat="server" Width="50px"
                        OnTextChanged="txtAccDiscount_TextChanged" Text="0" AutoPostBack="true"></asp:TextBox>
                </td>
                <td align="left">&nbsp;Final Price :
                    <asp:TextBox ID="txtFinalPrice" runat="server" Width="192px" Text="0" Enabled="false"></asp:TextBox>
                </td>
                <td align="right" valign="top">Payment : 
                </td>
                <td align="left" valign="top">
                    <asp:TextBox ID="txtPayment" runat="server" Width="70%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top">Delivery Day(s) :
                    <asp:TextBox ID="txtDDays" runat="server" Width="50px" Text="0" OnTextChanged="txtDDays_TextChanged" AutoPostBack="true"></asp:TextBox>
                    <asp:TextBox ID="txtDeliveryDays" runat="server" TextMode="Date" Enabled="false"></asp:TextBox>

                </td>
                <td align="left" valign="top">&nbsp;Other Tax :
                    <asp:TextBox ID="txtTax" runat="server" Width="228px"></asp:TextBox>
                </td>

                <td align="right" valign="top">Terms And Conditions :
                </td>
                <td>
                    <asp:TextBox ID="txtTerms" runat="server" Width="70%" Height="50px" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top">
                    <asp:Label ID="lblApproveReject" runat="server" Text=" Approval/Reject Remarks :"></asp:Label>
                </td>
                <td colspan="1">
                    <asp:TextBox ID="txtApprovalRemarks" runat="server" Width="450px" Height="60px" TextMode="MultiLine"></asp:TextBox>

                </td>
                <td align="center" valign="top" colspan="4" style="padding-right: 35px;">
                    <asp:Label ID="lblMsg" runat="server" Text="Label" Font-Bold="True"
                        ForeColor="#CC0000" Visible="False"></asp:Label>
                    <asp:Button ID="btn_purchase_order" runat="server"
                        OnClick="btn_purchase_order_Click" Text="Generate PO " Visible="False" />
                    <asp:Button ID="btnSave" runat="server" Text="Save" Width="100px"
                        OnClick="btnSave_Click" Height="26px" />
                    <asp:Button ID="btnReject" runat="server" OnClick="btnReject_Click" Text="Reject" />
                    <asp:Button ID="btnCancel" runat="server" Text="Return"
                        OnClick="btnCancel_Click" />

                </td>

            </tr>

        </table>
    </div>
    <asp:SqlDataSource ID="SDS_Update_Currency" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" UpdateCommand="Update_Currency"
        UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="DDL_Other_Currency" Name="Other_Currency" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtCurrencyRate" Name="Other_Currency_Rate" PropertyName="Text" />
            <asp:Parameter DefaultValue="" Name="PO_ID" Type="String" />

        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_Vendor" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
        SelectCommand="SELECT [Party_Id], [Party_Name] FROM [Parties] WHERE ([Party_Id] not in (SELECT ISNULL([Account_No],'0') as Account_No FROM [Finance].[dbo].[Group_Company_Branches])) "></asp:SqlDataSource>
    <asp:SqlDataSource ID="SDS_GV" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="uspGetQutationItems" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="Demand_RQ_ID" Type="String" />
            <asp:ControlParameter Name="Distributor" ControlID="ddlDistributor" DefaultValue="---- All ----" Type="String" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Sql_Qutation_Main" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="usp_Add_Qutation_Main" InsertCommandType="StoredProcedure" OnInserted="Sql_Qutation_Main_Inserted">
        <InsertParameters>

            <asp:ControlParameter ControlID="ddlVendor" Name="Vendor_ID" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="txtDate" Name="Qutation_Date" PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="txtPerson" Name="Contact_Person" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtContactNo" Name="Contact_No" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtAccDiscount" Name="Accumulated_Discount" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtFinalPrice" Name="Final_Price" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="txtDDays" Name="Delivery_Days" PropertyName="Text" Type="Int32" />
            <asp:ControlParameter ControlID="txtTax" Name="Tax" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtPayment" Name="Payment" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtTerms" Name="Terms_Conditions" PropertyName="Text" Type="String" />
            <asp:QueryStringParameter Name="Demand_RQ_ID" QueryStringField="RQ_ID" Type="String" />
            <asp:ControlParameter ControlID="hf_Qutation_Main_Id" Direction="InputOutput"
                Name="Qutation_Main_ID" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="txtDeliveryDays" Name="Delivery_Date" PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="txtWEDate" Name="WithEffectDate" PropertyName="Text" Type="DateTime" />


            <asp:ControlParameter ControlID="DropDownList_potype" Name="QutationType" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="DDL_Other_Currency" Name="OtherCurrency" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtCurrencyRate" Name="CurrencyRate" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="ddlDistributor" Name="Distributor" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="txtWarranty" Name="Warranty" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtOrigin" Name="ManufacturerOrgin" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtInstallInPak" Name="InstallationInPak" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="ddlStockAvailability" Name="StockAvailability" PropertyName="SelectedValue" Type="String" />

        </InsertParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="Sql_Qutation_Sub" runat="server"
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="usp_Add_Qutation_Sub" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:Parameter Name="Qutation_Main_ID" Type="String" />
            <asp:Parameter Name="Item_Code" Type="String" />
            <asp:Parameter Name="Qty_Offered" Type="Int32" />
            <asp:Parameter Name="Unit_Price" Type="Double" />
            <asp:Parameter Name="Discount" Type="Double" />
            <asp:Parameter Name="Total_Amount" Type="Double" />
            <asp:Parameter Name="Remarks" Type="String" />
        </InsertParameters>

    </asp:SqlDataSource>
    <asp:HiddenField ID="hfID" runat="server" />
    <asp:HiddenField ID="HF_PO_No" runat="server" />
    <asp:HiddenField ID="hf_Qutation_Main_Id" runat="server" />
    <asp:SqlDataSource ID="sds_Sub" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT     Store_Items.Item_Name, Demand_Requisition_Sub.Item_Qty AS Required_Quantity, Qutation_Sub.Item_Code, Qutation_Sub.Qty_Offered, Qutation_Sub.Unit_Price, 
                      Demand_Requisition_Sub.Item_Qty * Qutation_Sub.Unit_Price AS Total, Qutation_Sub.Discount, Qutation_Sub.Total_Amount AS Final, 
                      SUM(Qutation_Sub.Total_Amount) AS Grand_Total
FROM         Qutation_Main INNER JOIN
                      Qutation_Sub ON Qutation_Main.Qutation_Main_ID = Qutation_Sub.Qutation_Main_ID INNER JOIN
                      Demand_Requisition_Sub ON Qutation_Sub.Item_Code = Demand_Requisition_Sub.Item_Code INNER JOIN
                      Store_Items ON Demand_Requisition_Sub.Item_Code = Store_Items.Item_Code INNER JOIN
                      Demand_Requisition_Main ON Qutation_Main.Demand_RQ_ID = Demand_Requisition_Main.Demand_RQ_ID AND 
                      Demand_Requisition_Sub.Demand_RQ_ID= Demand_Requisition_Main.Demand_RQ_ID
WHERE     (Qutation_Main.Qutation_Main_ID = @Qutation_Main_ID) AND (Demand_Requisition_Main.Demand_RQ_ID = @Demand_RQ_ID)
GROUP BY Store_Items.Item_Name, Demand_Requisition_Sub.Item_Qty, Qutation_Sub.Item_Code, Qutation_Sub.Qty_Offered, Qutation_Sub.Unit_Price, Qutation_Sub.Discount, 
                      Qutation_Sub.Total_Amount">

        <SelectParameters>
            <asp:QueryStringParameter Name="Qutation_Main_ID" QueryStringField="Main_ID" />
            <asp:QueryStringParameter Name="Demand_RQ_ID" QueryStringField="RQ_ID" />
        </SelectParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_UpdateOffer" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        UpdateCommand="UPDATE    Qutation_Sub
SET              Qty_Offered = @Qty_Offered, Discount =@Discount, Total_Amount =@Total_Amount
WHERE     (Qutation_Main_ID = @Qutation_Main_ID) AND (Item_Code = @Item_Code)">
        <UpdateParameters>
            <asp:QueryStringParameter Name="Qutation_Main_ID" QueryStringField="Main_ID" />
            <asp:Parameter Name="Item_Code" Type="String" />
            <asp:Parameter Name="Qty_Offered" Type="Int32" />
            <asp:Parameter Name="Discount" Type="Double" />
            <asp:Parameter Name="Total_Amount" Type="Double" />
            <asp:Parameter Name="Status" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_UpdateMain" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        UpdateCommand="usp_UpdateQutationMain" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:QueryStringParameter Name="Qutation_Main_ID" QueryStringField="Main_ID" Type="Int32" />
            <asp:QueryStringParameter Name="Demand_RQ_ID" QueryStringField="RQ_ID" Type="String" />
            <asp:QueryStringParameter Name="Approval_Request_Id" QueryStringField="AR_ID" Type="Int32" />
            <asp:ControlParameter Name="Approval_Remarks" ControlID="txtApprovalRemarks" Type="String" />
            <asp:Parameter Name="Status" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sds_Approve" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        UpdateCommand="Update Qutation_Main Set Is_Approved=1 Where Qutation_Main_ID=@Qutation_Main_ID"
        InsertCommand="Insert_PO_from_Demand_REQ" InsertCommandType="StoredProcedure" OnInserted="sds_Approve_Inserted">

        <InsertParameters>
            <asp:QueryStringParameter Name="RQ_ID" QueryStringField="rq_id" Type="String" />
            <asp:QueryStringParameter Name="Main_ID" QueryStringField="main_id"
                Type="Int32" />
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Int32" />
            <asp:Parameter Direction="InputOutput" Name="PO_NO" Type="Int32"
                DefaultValue="0" />
            <asp:SessionParameter Name="DeptID" SessionField="Dept_ID" Type="Int32" />
            <asp:SessionParameter Name="SubDeptID" SessionField="SubDeptID" Type="Int32" />
        </InsertParameters>

        <UpdateParameters>
            <asp:QueryStringParameter DefaultValue="" Name="Qutation_Main_ID" QueryStringField="Main_ID"
                Type="String" />
        </UpdateParameters>

    </asp:SqlDataSource>
</asp:Content>


