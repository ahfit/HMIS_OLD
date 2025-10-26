<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PurchaseOrder.aspx.cs" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="MasterPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   <!-- <script type="text/javascript" src="../css/bootstrap.min.js"></script>
    <script type="text/javascript" src="SpryAssets/mycollaps.js"></script>
    <link href="SpryAssets/mycollaps.css" rel="stylesheet" />
    <script type="text/javascript" src="../css_mega/jquery.cookie.js"></script>
    <script type="text/javascript" src="../css_mega/m_showhide.js"></script>
    <script type="text/javascript" src="../css/ck.js"></script>-->
    <script type="text/javascript">
        $(document).ready(function (e) {
            lblQuotationNo

        });



    </script>
    <script type="text/javascript">

 
        function ClientItemSelected(sender, e) {
            $get("<%=hfPaymentToId.ClientID %>").value = e.get_value();
        }
        function ClientItemSelected1(sender, e) {
            $get("<%=hfOrderTo.ClientID %>").value = e.get_value();
        }
        function ClientItemSelected2(sender, e) {
            $get("<%=hfItemCode.ClientID %>").value = e.get_value();
        } function ClientItemSelected3(sender, e) {
            $get("<%=hdfItemVendor.ClientID %>").value = e.get_value();
        }
    </script>

    <script type="text/javascript">
        function ConfirmAddAllItems() {
             if (confirm('Are you sure you want to add all items?')) {
                 return true;
             } else {
                 return false;
             }
         }
    </script>
    <style type="text/css">
        .item-detail1 {
            position: absolute;
            font-size: 11px;
            font-weight: bold;
            color: #000;
            font-family: arial;
            border: #d7d477 solid 1px;
            border-radius: 5px;
            width: 100px;
            height: auto;
            background: #fffdc5;
            padding: 8px;
            box-shadow: #999 1px 1px 2px;
        }

        .item-details {
            text-indent: -99999px;
            display: inline-block;
        }

        .info {
            background: url(../images_mega/info.png) top center no-repeat;
            min-width: 16px;
            min-height: 16px;
            display: inline-block;
        }
        .auto-style1 {
            height: 18px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:Panel ID="panel" Visible="false" runat="server" CssClass="lightbox">
       
        <div>
             
            <div style="display: inline; float: left; width: 98%;" class="bxmain inner_content">

                <h2><span>Stock Detail</span></h2>

            </div>
            
            <div style="margin-top: 10px">

                <asp:GridView ID="Gridview2" AutoGenerateColumns="false" runat="server" Width="100%">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.#">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Item Name">
                            <ItemTemplate>
                                <asp:Label ID="lbEName" Text='<%# Bind("Item_Name") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Unit">
                            <ItemTemplate>
                                <asp:Label ID="lbEnaa" Text='<%# Bind("Unit") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Item Code">
                            <ItemTemplate>
                                <asp:Label ID="Item_Code" Text='<%# Bind("Item_Code") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Stock">
                            <ItemTemplate>
                                <asp:Label ID="Stock" Text='<%# Bind("Stock") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Department">
                            <ItemTemplate>
                                <asp:Label ID="SubDept_Name" Text='<%# Bind("SubDept_Name") %>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>


            </div>
            <div style="width: 800px; margin: 0 auto;">
                <asp:Button ID="Button_Close" runat="server" Text="Close" OnClick="Button_Close_Click" CausesValidation="False" />
            </div>
        </div>

    </asp:Panel>
 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
            <td width="35%" style="vertical-align: top;"><div class="bxmain  inner_content" style="margin-right: 10px; width: 98%;">
                        <h2><span>Basic Details</span></h2>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                            <tr>
                                <td align="right" width="35%">
                                    <b>Quotation # :</b>
                                </td>
                                <td>
                                      <asp:TextBox ID="lblQuotationNo" AutoPostBack="true" OnTextChanged="lblQuotationNo_TextChanged" runat="server"  Width="185px"></asp:TextBox>
                                  
                                </td>
                            </tr>
                            <tr>
                                <td align="right" width="35%">
                                    <b>Purchase Order # :</b>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_PONo" runat="server" AutoPostBack="True" Style="color: red; font-weight: bold;"
                                        OnTextChanged="TextBox_PONo_TextChanged" Width="185px" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>PO. Date :</b>
                                </td>
                                <td>

                                    <asp:TextBox ID="txtPODate" runat="server" TextMode="Date" Width="185px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Order To :</b>
                                </td>
                                <td>
                                    <asp:TextBox ID="ddlPaymentTo" runat="server" Width="185px" Required="True" OnTextChanged="ddlPaymentTo_TextChanged" AutoPostBack="true" TabIndex="1"></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="Auto_Parties_Extender" runat="server" ServiceMethod="SearchCustomers"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="ddlPaymentTo" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected" CompletionListCssClass="AutoExtender"
                                        CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                    </asp:AutoCompleteExtender>
                                    <asp:HiddenField ID="hfPaymentToId" runat="server" Value="-1" />

                                    <asp:Button ID="Button_Company" runat="server" Visible="false" Text="Add" />
                                    <a id="addlink" class="add_link box" runat="server" href="~/Finance/Add_New_Company.aspx">Add</a>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" >
                                    <b>Supplier :</b>
                                </td>
                                <td>
                                    <asp:TextBox ID="ddlOrderTo" runat="server" Width="185px"  Required="True"></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="Auto_Parties_Extender1" runat="server" ServiceMethod="SearchCustomers"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="ddlOrderTo" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected1" CompletionListCssClass="AutoExtender"
                                        CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                    </asp:AutoCompleteExtender>
                                    <asp:HiddenField ID="hfOrderTo" runat="server" Value="-2" />

                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Delivery Date :</b>
                                </td>
                                <td >
                                    <asp:TextBox ID="txtDDate" TextMode="Date" runat="server"></asp:TextBox>
                                    <asp:TextBox ID="TextBox_DeliveryDays" TextMode="Number" runat="server" Visible="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Receiving Department :</b>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlforstore" runat="server" Width="184px" AutoPostBack="true" OnSelectedIndexChanged="ddlforstore_SelectedIndexChanged" ></asp:DropDownList>
                                   </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Other Currency :</b>
                                </td>
                                <td>
                                    <asp:DropDownList ID="DDL_Other_Currency" runat="server" Width="184px" AutoPostBack="True"
                                        DataSourceID="SDS_Currency" DataTextField="Currency_Name" DataValueField="Currency_Abbrivation"
                                        OnSelectedIndexChanged="DDL_Other_Currency_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SDS_Currency" runat="server" ConnectionString="<%$ ConnectionStrings:Basic_Data_ConnectionString %>"
                                        SelectCommand="SELECT upper([Currency_Name]) [Currency_Name], [Currency_Abbrivation] FROM [Currency]"></asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Current Rate :</b>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCurrencyRate" runat="server" Style="width: 184px; height: 1.7em; margin-bottom: -1em;"
                                        OnTextChanged="txtCurrencyRate_TextChanged" SkinID="number" ></asp:TextBox>
                                </td>
                            </tr>
                            <tr style="visibility: hidden;">
                                <td align="right">
                                    <b>LC # :</b>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_LC" runat="server" Width="185px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>PO Type :</b>
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_potype"  runat="server" Width="184px" Style="margin-top: -1em;">
                                        <asp:ListItem Value="Vendor" Text="Vendor"></asp:ListItem>
                                        <asp:ListItem Value="Urgent Purchase" Text="Urgent Purchase"></asp:ListItem>
                                        <asp:ListItem Value="Emergency Purchase" Text="Emergency Purchase"></asp:ListItem>
                                        <asp:ListItem Value="Loan" Text="Loan"></asp:ListItem>
                                        <asp:ListItem Value="FOC" Text="FOC"></asp:ListItem>
                                        <asp:ListItem Value="Donation" Text="Donation"></asp:ListItem>
                                        <asp:ListItem Value="Import" Text="Import"></asp:ListItem>
                                        
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Mode of Payment :</b>
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_modeof_payment" runat="server" Width="184px" OnSelectedIndexChanged="DropDownList_modeof_payment_SelectedIndexChanged">
                                        <asp:ListItem>CASH</asp:ListItem>
                                        <asp:ListItem Selected="True">CHEQUE</asp:ListItem>
                                        <asp:ListItem>PAY ORDER</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Payment Terms :</b>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlPayTerms" runat="server" Width="184px" OnSelectedIndexChanged="DropDownList_modeof_payment_SelectedIndexChanged">
                                        <asp:ListItem Text="Immediate at Delivery" Value="Immediate at Delivery"></asp:ListItem>
                                        <asp:ListItem Text="Advance" Value="Advance"></asp:ListItem>
                                        <asp:ListItem Text="Donation" Value="Donation"></asp:ListItem>
                                        <asp:ListItem Text="7 Days" Value="7 Days"></asp:ListItem>
                                        <asp:ListItem Text="15 Days" Value="15 Days"></asp:ListItem>
                                        <asp:ListItem Text="30 Days" Value="30 Days"></asp:ListItem>
                                        <asp:ListItem Text="45 Days" Value="45 Days"></asp:ListItem>
                                        <asp:ListItem Text="60 Days" Value="60 Days"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Budget Head :</b></td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_Budget" runat="server"
                                        Width="184px" DataSourceID="SDS_Budget" DataTextField="E_Name"
                                        DataValueField="E_Code" AutoPostBack="true"
                                        OnSelectedIndexChanged="DropDownList_Budget_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:Label ID="lblBalance" runat="server" ForeColor="#0066FF"></asp:Label>
                                    <asp:SqlDataSource ID="SDS_Budget" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
                                        SelectCommand="SELECT        E.E_Code, E.E_Code + ' (' + E.E_Name + ')' AS E_Name
                                                        FROM            Expenditure E
                                                        Where --E_Name like '%Store%' or E_Name like '%Stock%'
														E_Code in (3301001,3301002)
                                                        Order BY E.E_Code + ' (' + E.E_Name + ')' desc">
                                        
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </div>
                   <asp:HiddenField ID="Hf_for_branch" runat="server" />
                <br>
                <table width="100%" style="margin-top: -2.6em;" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top">
                    
                            
                            <asp:Panel ID="Panel_TaxDiscount" runat="server" Width="100%" Visible="False">
                                <div class="bx_rad inner_content">
                                    <ul id="tp3">
                                        <li>
                                            <h2>
                                                <span>Discount</span></h2>
                                        </li>
                                        <li>
                                            <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tbl_form">
                                                <tr>
                                                    <td align="right" width="40%">
                                                        <strong>Select Tax/Discount :</strong>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="DropDownList_SelectTaxDiscount" runat="server" DataSourceID="SqlDataSource_DDL_TAX"
                                                            DataTextField="Tax_Name" DataValueField="Tax_Id" Width="150px" Enabled="false">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" class="auto-style1">
                                                        <strong>Amount (%) :</strong>
                                                    </td>
                                                    <td class="auto-style1">
                                                        <asp:TextBox ID="TextBox_TaxDiscountAmount" SkinID="number" runat="server" Width="150px"></asp:TextBox>
                                                        <asp:RangeValidator ID="rvPercentage" runat="server" ControlToValidate="TextBox_TaxDiscountAmount"
                                                            MinimumValue="0" MaximumValue="100" ErrorMessage="Enter Correct Value" ForeColor="Red"></asp:RangeValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td>
                                                        <asp:Button ID="Button_SaveTaxDis" runat="server" Text="Save" OnClick="Button_SaveTaxDis_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:DataList ID="DataList_TAXDiscount" runat="server" DataSourceID="SqlDataSource_TAX_Discount_Insert"
                                                Width="100%" OnPreRender="DataList_TAXDiscount_PreRender">
                                                <ItemTemplate>
                                                    <table cellpadding="0" cellspacing="0" width="100%" class="tbl_form">
                                                        <tr>
                                                            <td align="right" width="40%">
                                                                <strong>
                                                                    <asp:Label ID="Tax_NameLabel" runat="server" Text='<%# Eval("Tax_Name") %>'></asp:Label>
                                                                </strong>
                                                            </td>
                                                            <td>
                                                                <strong>
                                                                    <asp:Label ID="AmountLabel" runat="server" Style="color: #CC0000;" Text='<%# Eval("Amount") %>'></asp:Label></strong>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </li>
                                    </ul>
                                </div>
                            </asp:Panel>

                        </td>
                        </tr>
                        <tr>
                        <td valign="top">
                            <div style="margin-left: 10px;">
                                <asp:GridView ID="gvExpenseView" runat="server" AutoGenerateColumns="False" Width="98%"
                                    DataSourceID="SQL_Expense_GV" EnableModelValidation="True" Visible="false">
                                    <Columns>
                                        <asp:BoundField DataField="PO_ID" HeaderText="PO_ID" SortExpression="PO_ID" />
                                        <asp:BoundField DataField="Expense_Description" HeaderText="Expense_Description"
                                            SortExpression="Expense_Description" />
                                        <asp:BoundField DataField="Expense_Cost" HeaderText="Expense_Cost" SortExpression="Expense_Cost" />
                                        <asp:BoundField DataField="Account_Title" HeaderText="Account_Title" SortExpression="Account_Title" />
                                        <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                        <asp:TemplateField HeaderText="View Voucher">
                                            <ItemTemplate>
                                                <asp:Button ID="BTN_Voucher" runat="server" Height="18px" OnClick="BTN_Voucher_Click"
                                                    Text="Add" />
                                                <asp:HiddenField ID="HD_PO_ID" runat="server" Value='<%# Eval("PO_ID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </td>
                    </tr>
                   
                
                </table>
                
                
                     </td>
            <td style="vertical-align: top;">
                
                <table style="width: 100%;">
                
                <tr>
                    
                    <td style="width: 50%; vertical-align: top;">
                    
                    <div class="bx_rad  inner_content" style="width: 100%;">
                                 
                                        <h2>
                                            <span>Term and Conditions</span></h2>
                                    
                                        <asp:TextBox ID="txtTermsAndConditions" runat="server" TextMode="MultiLine"  Height="75px" Style=" width: 96%; margin-left: 10px;"></asp:TextBox> 
                            </div>
                    
                    </td>
                       <td><div class="bx_rad  inner_content" style="width: 98%; margin-left: 10px;">
                                 
                                        <h2>
                                            <span>Payment Process</span></h2>
                                    
                                        <asp:TextBox ID="TextBox_payment_Process" runat="server" Height="75px" TextMode="MultiLine"
                                            Width="96%" style="margin-left: 10px;"></asp:TextBox>
                                    
                            </div>
                </td>
                    
                    </tr>
                
                </table>
                
                    
                            <br />
                    
                <div class="bxmain inner_content" style="width: 100%;">
                        <h2><span>Items Detail</span></h2>
                        <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                            <tr>
                                <td width="35%" align="right">
                                    <b>Item Name :</b>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input_txt" ID="TextBox_specificItem" runat="server" Width="185px"
                                        OnTextChanged="TextBox_specificMedicine_TextChanged" TabIndex="2"></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="TextBox_specificItem" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                                        CompletionListCssClass="AutoExtender"
                                        CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                    </asp:AutoCompleteExtender>
                                    <asp:HiddenField ID="hfItemCode" runat="server" />
                                    <asp:TextBox ID="TextBoxItemName" runat="server" AutoPostBack="True" CssClass="input_txt"
                                        OnTextChanged="TextBox3_TextChanged" Width="150px" Visible="False"></asp:TextBox>
                                    <asp:Button ID="Button_Company0" runat="server" Visible="false" Text="Add" />
                                    <a id="addlink0" class="add_link box" runat="server" href="Admin_Medicine.aspx" target="_blank">Add</a>
                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td align="right">Item Code :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_ItemCode" runat="server" Width="185px" OnTextChanged="TextBox_ItemCode_TextChanged"></asp:TextBox>
                                    <asp:Button ID="Button6" runat="server" OnClick="Button6_Click" Width="85px" Text="Report To"
                                        Visible="False" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>Manufacturer :</b>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlManufacturer" runat="server"
                                        DataSourceID="sdsManufacturer" DataTextField="Manufacturer_Name"
                                        DataValueField="Manufacturer_Id" Width="184px">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="sdsManufacturer" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                        SelectCommand="Select 0 as Manufacturer_Id,'---ALL---' as Manufacturer_Name union select Manufacturer_Id, Manufacturer_Name From Items_Manufacturer Order By Manufacturer_Name"></asp:SqlDataSource>

                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <b>PR # :</b>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDemandReqNo" runat="server" Width="184px"></asp:TextBox>
                                    <asp:LinkButton id="btnAddDemandItems" runat="server" onclick="btnAddDemandItems_Click" causesvalidation="False">Add</asp:LinkButton>


                                </td>
                            </tr>
                            <tr style="display: none;">
                                <td align="right">
                                    <b>Vendor :</b>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtItemVendor" runat="server" Width="185px"></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" ServiceMethod="SearchCustomers"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="txtItemVendor" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected3" CompletionListCssClass="AutoExtender"
                                        CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                    </asp:AutoCompleteExtender>
                                    <asp:HiddenField ID="hdfItemVendor" runat="server" Value="0" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right"></td>
                                <td>
                                    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Search"
                                        CausesValidation="False" formnovalidate/>
                                    <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="ALL" Visible="false" /> 
                                </td>
                            </tr>
                            <tr style="display:none;">
                                <td align="right">Rate Type : 
                                </td>
                                <td>
                                    <asp:RadioButtonList ID="rblRateType" runat="server"
                                        RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Text="PKR" Value="False"></asp:ListItem>
                                        <asp:ListItem Text="Other Currency" Value="True"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>
                        <br />
                       </div> <br />
                <div style="text-align: right;">
                     <asp:Button ID="btnAddAllItems" Text="Add All Items" runat="server" 
                                 OnClientClick="return ConfirmAddAllItems();" OnClick="btnAddAllItems_Click" Visible="false"/>
                    </div>
                    <br />
                        
                        <asp:GridView ID="gvItems" runat="server" AutoGenerateColumns="False"
                            DataKeyNames="Item_Code"   Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="Item">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnItem" runat="server" Text='<%# Eval("Item") %>'
                                            CommandArgument='<%# Eval("Item_Code") %>' OnClick="btnItemName_Click"
                                            CausesValidation="False"></asp:LinkButton>
                                        <asp:HiddenField ID="HfPackQty" runat="server" Value='<%# Eval("PackQty") %>'/>
                                        <br />
                                        <asp:Label ID="lblItemDescription" runat="server"
                                            Text='<%# Eval("Item_Description") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:BoundField DataField="Generic" HeaderText="Generic" SortExpression="Generic"/>
                                <asp:BoundField DataField="Manufacturer_Name" HeaderText="Manufacturer" SortExpression="Manufacturer_Name"/>
                                <%--<asp:BoundField DataField="PackQty" HeaderText="Pack Size" SortExpression="PackQty"/>--%>
                                <asp:TemplateField HeaderText="Pack Size">
                                    <ItemTemplate>
                                        <asp:Label id="lblPackSize" runat="server" Text='<%# Bind("PackQty") %>'></asp:Label>
                                         
                                         
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Pack Qty">
                                    <ItemTemplate>
                                        
                                         <asp:TextBox ID="txtPackQty" runat="server" Text="0" Width="40px" AutoPostBack="true" OnTextChanged="txtPackQty_TextChanged" ></asp:TextBox>
                                         
                                    </ItemTemplate>
                                </asp:TemplateField>
                               
                                <asp:BoundField DataField="Unit" HeaderText="UOM" SortExpression="Unit" Visible="false"/>
                               
                                <asp:TemplateField Visible="false" HeaderText="View Stock">
                                    <HeaderStyle Width="45px" />
                                    <ItemStyle Width="45px" />
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDetail" runat="server" Text="Stock" CausesValidation="false" OnClick="lnkDetail_Click"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Qty">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtQty" runat="server" Text="0" Width="80px"></asp:TextBox>
                                         <%--<asp:TextBox ID="txtPackQty" runat="server" Text="" Width="40px" ></asp:TextBox>--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Pack Rate">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRate" runat="server" Text='<%# Bind("OrgRate") %>' Width="80px" AutoPostBack="true" OnTextChanged="txtRate_TextChanged" ></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Unit Rate">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtUnitRate" runat="server" Text="0" Width="80px"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField  HeaderText="Bonus (FOC)" >
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFOC" runat="server" Width="50px" Text="0"
                                                          AutoPostBack="true" OnTextChanged="txtFOC_TextChanged1" Enabled="True" ></asp:TextBox>
                                                </ItemTemplate>
                         </asp:TemplateField>
                                <asp:TemplateField  HeaderText="Sales Tax (PKR)"  >
                            <ItemTemplate>
                                 <asp:TextBox ID="txtVat" runat="server" Width="60px" Text="0"  ></asp:TextBox>
                            </ItemTemplate>
                          </asp:TemplateField>
                                <asp:TemplateField HeaderText="Select" Visible="false">
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkSelectAll" runat="server" AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" Visible="false" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" Visible='<%# Eval("IsShow") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
 
                            
                     <asp:HiddenField ID="hfItemName" runat="server" />
                        <asp:SqlDataSource ID="sdsItems" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                            SelectCommand="usp_Items_For_Purchase_Order" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlManufacturer" Name="Manufacturer"
                                    PropertyName="SelectedValue" Type="String" />
                                <asp:Parameter Name="Item_Name" Type="String" />
                                <asp:ControlParameter ControlID="hdfItemVendor" Name="vendorID" PropertyName="Value" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                   
                <br>
                         
         <div align="right">
                    <asp:Button ID="Button1" runat="server" CssClass="btn1" OnClick="Button1_Click"
                        Text="Update" CausesValidation="False" />
                    <asp:Button ID="Button4" runat="server" CssClass="btn1" Text="Report" OnClick="Button4_Click"
                        Visible="True" CausesValidation="False" />
                    <asp:Button ID="btn_OCurrency" runat="server" CssClass="btn1" OnClick="btm_OCurrency_Click"
                        Text="Report in Curr" Visible="False" />
                          <asp:Button ID="btnForward" runat="server" Text="Forward for Approval"
                        OnClick="btnForward_Click" />
                    <asp:Button ID="btnReturn" runat="server" Text="Return" OnClick="btnReturn_Click" CausesValidation="false" />
                          <br />
                    <asp:Label ID="lblMsg" runat="server" Visible="false" Font-Bold="true" ForeColor="Green"></asp:Label>
                     <asp:Button ID="btnRollback" runat="server" Visible="false" Text="Roll Back"  OnClick="btnRollback_Click" CausesValidation="false" />
                    
                    
                    <asp:Label ID="label_Budget" runat="server" Text="" ForeColor="#FF0066" Font-Bold="True"></asp:Label>
                </div>
        
                
                </td>
            </tr>
            
        </table>   
   
        
         <asp:HiddenField ID="HiddenField_changed" runat="server" />
        
        <div class="inner_content" style="display:none; margin-top: 8px; width: 98%;">
                        <ul id="tp2">
                            <li>
                                <h2>
                                    <span>Detail</span></h2>
                            </li>
                            <li>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                                    <tr>
                                        <td align="right">For Branches :
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox_branches" runat="server" SkinID="txt_height" TextMode="MultiLine"
                                                Width="165px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">Mode of Delivery :
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox_modeof_delivery" runat="server" SkinID="txt_height" TextMode="MultiLine"
                                                Width="165px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">Ship to :
                                        </td>
                                        <td>
                                            <asp:TextBox ID="TextBox_shipto" runat="server" SkinID="txt_height" TextMode="MultiLine"
                                                Width="165px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" colspan="2">
                                            <asp:Label ID="LabelQu" runat="server" Text="Quotation # :" Visible="False"></asp:Label>
                                            <asp:TextBox ID="TextBox_quotation" runat="server" CssClass="input_txt" Width="63px"
                                                Visible="False"></asp:TextBox>
                                            <asp:Label ID="Label_cus" runat="server" Text="For Customer :" Visible="False"></asp:Label>
                                            <asp:TextBox ID="TextBox_customer" runat="server" SkinID="txt_height" TextMode="MultiLine"
                                                Width="89px" Visible="False"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </li>
                        </ul>
                    </div>
        
        
       
       <br>      <br>         
              <asp:Label ID="Label_Msg" runat="server" CssClass="err" ForeColor="Red" Visible="False"></asp:Label>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%"
                    DataSourceID="SqlDataSource2" DataKeyNames="PO_ID_Sub" OnPreRender="GridView1_PreRender"
                    ShowFooter="True" EnableModelValidation="True">
                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <Columns>
                        <asp:TemplateField HeaderText="Sr #">
                            <ItemTemplate>
                                <%#Container.DataItemIndex+1%>
                            </ItemTemplate>
                            <ItemStyle Width="3%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Item &amp; Specification" SortExpression="Item">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Item") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label_Item" runat="server" Style="font-size: 10px;" Text='<%# Bind("Item") %>'></asp:Label>
                                <asp:TextBox ID="TextBox_Specification" runat="server" SkinID="txt_height" TextMode="MultiLine"
                                    Width="95%" Text='<%# Bind("Item_Description") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pack" Visible="false">
                            <ItemTemplate>
                                <asp:TextBox ID="txtPack" runat="server" Width="90px" SkinID="input_grid_num"
                                    Text='<%# Eval("Pack", "{0}") %>' AutoPostBack="false"
                                    OnTextChanged="txtPack_TextChanged" Style="height: 22px"></asp:TextBox>
                                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox_Qty"
                                    ErrorMessage="RegularExpressionValidator" ValidationExpression="\d{1,8}">*</asp:RegularExpressionValidator>--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Units / Pack">
                            <ItemTemplate>
                                <asp:TextBox ID="txtUnitsPack" runat="server" Width="90px" SkinID="input_grid_num"
                                    Text='<%# Eval("Unit_Pack", "{0}") %>' AutoPostBack="false"
                                    OnTextChanged="txtUnitPack_TextChanged"></asp:TextBox>
                                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox_Qty"
                                    ErrorMessage="RegularExpressionValidator" ValidationExpression="\d{1,8}">*</asp:RegularExpressionValidator>--%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox_Qty" runat="server" Width="90px" SkinID="input_grid_num"
                                    Text='<%# Eval("Qty", "{0}") %>' AutoPostBack="true"></asp:TextBox>
                                <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox_Qty"
                                    ErrorMessage="RegularExpressionValidator" ValidationExpression="\d{1,8}">*</asp:RegularExpressionValidator>--%>
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Item_Code", "{0}") %>' />
                                <asp:HiddenField ID="HiddenField_PO_Sub_ID" runat="server" Value='<%# Eval("PO_ID_Sub") %>' />
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate / Pack" Visible="false">
                            <ItemTemplate>
                                <asp:TextBox ID="txtPackRate" runat="server" Width="90px" SkinID="input_grid_num"
                                    Text='<%# Eval("PackRate", "{0}") %>' AutoPostBack="false"></asp:TextBox>

                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Other Currency Rate" Visible="false">
                            <HeaderTemplate>
                                <asp:Label ID="label_OCurrency_Head" runat="server" Text="Other Currency Rate"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox_Other_Currency_Rate" runat="server" Width="60px" SkinID="input_grid_num"
                                    OnTextChanged="TextBox_Other_Currency_Rate_TextChanged" CausesValidation="True"
                                    AutoPostBack="false" Text='<%# Bind("Other_Currency_Rate") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="With Currency Rate" Visible="false">
                            <FooterTemplate>
                                <asp:Label ID="lblCurrencyRateFooter" runat="server"></asp:Label>
                            </FooterTemplate>
                            <HeaderTemplate>
                                <asp:Label ID="lbl_hCAmount" runat="server" Text="Other Currency Amount Head "></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="TXT_Currency_Rate" runat="server" SkinID="input_grid_num" Width="70px"
                                    Enabled="False"></asp:TextBox>

                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Unit Price in PKR" SortExpression="Rate">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" Width="100px" runat="server" Text='<%# Bind("OrgRate") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("OrgRate") %>' Visible="False"></asp:Label>
                                <asp:TextBox ID="TextBox_Rate" SkinID="input_grid_num" runat="server" Text='<%# Eval("OrgRate") %>'
                                    Width="60px" AutoPostBack="True" OnTextChanged="TextBox_Rate_TextChanged"></asp:TextBox>

                            </ItemTemplate>
                            <FooterTemplate>
                                <strong>Total</strong>
                            </FooterTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" Visible="False" />
                        <asp:TemplateField HeaderText="Actual Amount in PKR">
                            <FooterTemplate>
                                <asp:Label ID="Label_GTotalAmount" runat="server"></asp:Label>
                               
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label_Amount" runat="server" Text='<%# Eval("AmountWithOutTax") %>'></asp:Label>
                               
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        
                         
                        <asp:TemplateField HeaderText="Discount (%)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtDiscount" runat="server" Text='<%# Eval("Discount") %>' Width="90px" SkinID="input_grid_num"
                                    TextMode="Number" MaxValue="100" OnTextChanged="txtDiscount_TextChanged" AutoPostBack="true"></asp:TextBox>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField  HeaderText="Bonus (FOC)" Visible="true">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBonusQty" runat="server" Width="50px" Enabled="false" Text='<%# Eval("BonusQty") %>'
                                                        ></asp:TextBox>
                                                </ItemTemplate>
                         </asp:TemplateField>
                                <asp:TemplateField  HeaderText="Sales Tax (PKR)">
                            <ItemTemplate>
                                 <asp:TextBox ID="txtVat" runat="server" Width="90px" Text='<%# Eval("SaleTax") %>' AutoPostBack="true"  OnTextChanged="txtVat_TextChanged1"  ></asp:TextBox>
                            </ItemTemplate>
                          </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:TextBox ID="lblDiscountRate" runat="server" Text='<%# Eval("Rate") %>' OnTextChanged="lblDiscountRate_TextChanged" AutoPostBack="true" Visible="false"></asp:TextBox>
                                <%--<asp:Label ID="lblDiscountRate" runat="server" Text='<%# Eval("Rate") %>'></asp:Label>--%>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Amount (After Tax & Discount)">
                            <ItemTemplate>
                                <asp:Label ID="lblTotalDisAmount" runat="server" Text='<%# Eval("TotalDisAmount") %>'></asp:Label>
                                <asp:HiddenField ID="HfTotalDisAmount" runat="server"  Value='<%# Eval("TotalDisAmount") %>'/>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="LblDisTotalAmount" runat="server"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                       
                        <asp:TemplateField HeaderText="Item Wise Expense" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblItemWiseExpense" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cost Wise Expense" Visible="False">
                            <ItemTemplate>
                                <asp:Label ID="lblCostWiseExpense" runat="server"></asp:Label>
                                <asp:Label ID="lblExpenseAmountWise" runat="server" Text='<%# Eval("ExpenseAmountWise") %>'
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblExpenseQtyWise" runat="server" Visible="False" Text='<%# Eval("ExpenseQtyWise") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnExcludeExpense" runat="server" CommandArgument='<%# Eval("PO_ID_Sub") %>'
                                    OnClick="lbtnExcludeExpense_Click" CommandName='<%# Eval("PO_ID") %>'>Expense Exclude</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="DTL_Sample" HeaderText="DTL Sample" SortExpression="DTL_Sample"
                            Visible="False" />
                        <asp:TemplateField HeaderText="DTL Sample" Visible="False">
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DTL_Sample", "{0}") %>'
                                    Width="50px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quotation #" Visible="False">
                            <ItemTemplate>
                                <asp:TextBox ID="Txt_QO_No" runat="server" Text='<%# Bind("QO_No") %>' TextMode="MultiLine"
                                    Width="95%"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Order #" Visible="False">
                            <ItemTemplate>
                                <asp:TextBox ID="Txt_Order_No" runat="server" Text='<%# Bind("Order_No") %>' TextMode="MultiLine"
                                    Width="95%"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="For Customer" Visible="False">
                            <ItemTemplate>
                                <asp:TextBox ID="Txt_For_Customer" runat="server" Text='<%# Bind("For_Customer") %>'
                                    TextMode="MultiLine" Width="95%"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="For Branch" Visible="False">
                            <ItemTemplate>
                                <asp:TextBox ID="Txt_For_Branch" runat="server" Text='<%# Bind("For_Branch") %>'
                                    TextMode="MultiLine" Width="95%"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" />
                      
                    </Columns>
                </asp:GridView>

                <br />
          
                <table width="100%" cellspacing="0" cellpadding="0" class="tbl_form">
                    <tr>
                        <td align="right" width="30%">&nbsp;
                        </td>
                        <td>
                            <div style="float: right; margin-right: 10px; margin-top: 4px;">
                                <asp:Button ID="btnAddExpenses" runat="server" OnClick="btnAddExpenses_Click" Text="Add Expenses"
                                    Visible="False" />
                            </div>
                        </td>
                    </tr>
                </table>
              
    <asp:SqlDataSource ID="SDS_Update_Currency" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" UpdateCommand="Update_Currency"
        UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="DDL_Other_Currency" Name="Other_Currency" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txtCurrencyRate" Name="Other_Currency_Rate" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_PONo" Name="PO_ID" PropertyName="Text" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="Hf_OR_No" runat="server" />
    <asp:HiddenField ID="Hf_QO_No" runat="server" />
    <asp:HiddenField ID="Hf_For_Customer" runat="server" />
    <br />
    <asp:SqlDataSource ID="SQL_Expense_GV" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT Purchase_Order_Item_Expenses.PO_ID, Admin_Item_Expense.Expense_Description, Purchase_Order_Item_Expenses.Expense_Cost, Account_Titles.Account_Title, Purchase_Order_Item_Expenses.Description FROM Purchase_Order_Item_Expenses INNER JOIN Admin_Item_Expense ON Purchase_Order_Item_Expenses.Expenses_ID = Admin_Item_Expense.Expenses_ID INNER JOIN Account_Titles ON Purchase_Order_Item_Expenses.Company_ID = Account_Titles.Account_No WHERE (Purchase_Order_Item_Expenses.PO_ID = @PO_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox_PONo" Name="PO_ID" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_DDL_TAX" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Tax_Id, Tax_Name FROM Tax_Discount_HeadDetail ORDER BY Tax_Name"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_TAX_Discount_Insert" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="Insert_PO_Tax_Discount" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
        SelectCommand="SELECT     Tax_Discount_HeadDetail.Tax_Name +' : ' as Tax_Name , PO_Tax_Discount.Amount FROM         PO_Tax_Discount INNER JOIN 
        Tax_Discount_HeadDetail ON PO_Tax_Discount.Tax_ID = Tax_Discount_HeadDetail.Tax_Id WHERE     (PO_Tax_Discount.PO_ID = @PO_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox_PONo" Name="PO_ID" PropertyName="Text" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBox_PONo" Name="PO_ID" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="DropDownList_SelectTaxDiscount" Name="Tax_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Amount" Type="Decimal" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Store_Item" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT [G_N_Id], [Generic_Name] FROM [Generic_Names]  order by  [Generic_Name] "></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Store_Category" runat="server"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Min_Alert" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="Store_Purchase_Item_Shortage_Alert"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
            <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />
            <asp:SessionParameter Name="ShiftID" SessionField="ShiftID" />
            <asp:ControlParameter ControlID="hfPaymentToId" Name="Company_ID"
                PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_CompanyID" runat="server" />
    <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Specification" runat="server" />
    <asp:HiddenField ID="HiddenField_Company_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Count" runat="server" />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" InsertCommand="Insert_Purchase_Order_Main_New"
        DeleteCommand="DELETE FROM Purchase_Order_Sub WHERE (PO_ID = @PO_ID)" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID"
                PropertyName="Value" DefaultValue="" />
            <asp:ControlParameter ControlID="hfPaymentToId" Name="Company_ID" PropertyName="Value"
                DefaultValue="" />
            <asp:ControlParameter ControlID="HiddenField_Count" Name="Count"
                PropertyName="Value" />
            <asp:Parameter DefaultValue="letter No" Name="Letter_NO" />
            <asp:Parameter DefaultValue="" Name="Subject" />
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" DefaultValue="" Name="Emp_ID"
                PropertyName="Value" />
            <asp:SessionParameter Name="Dept_ID" SessionField="dept_id" />
            <asp:Parameter DefaultValue="false" Name="Status" />
            <asp:ControlParameter ControlID="HiddenField_Dept_ID" DefaultValue="" Name="SubDept_ID"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldTender_ID" Name="Tender_Id" PropertyName="Value"
                DefaultValue="T12357" />
            <asp:ControlParameter ControlID="HiddenField_PODate" Name="Date_Time" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PR_ID" DefaultValue="0" Name="PR_ID"
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="hfOrderTo" Name="Order_To" DefaultValue="0"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="txtCurrencyRate" DefaultValue="0.0"
                Name="Other_Currency_Rate" PropertyName="Text" Type="Double" />
            <asp:ControlParameter ControlID="DDL_Other_Currency" Name="Other_Currency"
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="DropDownList_Budget" Name="BUDGET_HEAD"
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="TextBox_payment_Process" Name="Payment_Process" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="DropDownList_modeof_payment" Name="Mode_Of_Payment" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="DropDownList_potype" Name="PO_Type" PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="ddlforstore" Name="Receiving_Dept" PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_DeliveryDays" Name="Deliverydays" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="txtDDate" Name="DDate" PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlPayTerms" Name="PaymentTerms" PropertyName="SelectedValue" Type="String" />
            <asp:Parameter DbType="String" Name="typ" DefaultValue="" />
        </InsertParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Rate" runat="server" />
    <asp:HiddenField ID="HiddenField_PO_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_DTL_Sample" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceDeleteMain" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="DELETE FROM Purchase_Order_Main WHERE (PO_ID = @PO_ID)" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="Delete_Purchase_Order" DeleteCommandType="StoredProcedure" InsertCommand="Insert_Purchase_Order_Sub_new"
        InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
        SelectCommand="usp_Select_Purchase_Order_Items" SelectCommandType="StoredProcedure" UpdateCommand="Update_Purchase_Order1" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="hfPaymentToId" Name="Company_ID"
                PropertyName="Value" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="GridView1" Name="PO_ID_Sub" PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_QTY" Name="Qty" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_DTL_Sample" Name="DTL_Sample" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Item_Code" Name="Item_Code" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:Parameter Name="Subject" Type="String" />
            <asp:ControlParameter ControlID="TextBox_Temp_TermsAndCondition" Name="Term_and_Conditions"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_payment_Process" Name="Payment_Process"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="hfPaymentToId" Name="Company_ID" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter DefaultValue="T12357" Name="Tender_ID" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_ItemRate" Name="Rate" PropertyName="Value"
                Type="Double" />
            <asp:ControlParameter ControlID="HiddenField_ItemOrgRate" Name="OrgRate" PropertyName="Value"
                Type="Double" />
            <asp:ControlParameter ControlID="HiddenField_Specification" Name="Specification"
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="hf_ItemWiseExpense" Name="Item_Wise_Expense" PropertyName="Value"
                Type="Double" DefaultValue="0" />
            <asp:ControlParameter ControlID="hf_CostWiseExpense" Name="Cost_Wise_Expense" PropertyName="Value"
                Type="Double" DefaultValue="0" />
            <asp:ControlParameter ControlID="TextBox_LC" Name="LC_No" PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="DropDownList_potype" Name="PO_Type" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList_modeof_payment" Name="Mode_Of_Payment"
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="TextBox_customer" Name="For_Customer" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_branches" Name="For_Branches" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_shipto" Name="Ship_To" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_modeof_delivery" Name="Mode_Of_Delivery"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_quotation" Name="QO_No" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="Hf_For_Customer" Name="For_Customer_sub" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="Hf_OR_No" Name="Order_No" PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="hfOrderTo" Name="Order_To_Vandor"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="Hf_QO_No" Name="QO_No_sub" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="Hf_for_branch" Name="For_Branch" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="hdfPack" Name="Pack" PropertyName="Value"
                Type="Int32" />
            <asp:ControlParameter ControlID="hdfUnitPack" Name="UnitPack"
                PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="hdfPackRate" Name="PackRate"
                PropertyName="Value" Type="Double" />
            <asp:Parameter Name="Discount" Type="Decimal" />
            <asp:Parameter Name="BonusQty" Type="Int32" />
            <asp:Parameter Name="PO_ID_Sub" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:Parameter Name="Item_Code" Type="String" />
            <asp:Parameter Name="PackQty" Type="Double" />
            <asp:Parameter Name="Qty" Type="Double" />
            <asp:Parameter Name="Rate" Type="Double" />
            <asp:Parameter Name="OrgRate" Type="Double" />
            <asp:Parameter Name="Pack" Type="Int32" />
            <asp:Parameter Name="Bonus" Type="Double" />
            <asp:Parameter Name="SaleTax" Type="Double" />
            <asp:ControlParameter ControlID="rblRateType" Name="Is_Other_Rate"
                PropertyName="SelectedValue" Type="Boolean" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_UpdateSub" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT Purchase_Order_Sub.Item_Code, ISNULL(Purchase_Order_Sub.Rate, '') AS Rate, Purchase_Order_Sub.Qty, ISNULL(Store_Items.Drug_Category, '') + ' ' + ISNULL(Store_Items.Item_Name, '') + ' ' + ISNULL(Store_Items.Potency, '') + ' ' + ISNULL(Store_Items.Unit, '') AS Item, Purchase_Order_Sub.DTL_Sample FROM Purchase_Order_Sub INNER JOIN Store_Items ON Purchase_Order_Sub.Item_Code = Store_Items.Item_Code INNER JOIN Purchase_Order_Main ON Purchase_Order_Sub.PO_ID = Purchase_Order_Main.PO_ID LEFT OUTER JOIN Store_Tender_Sub ON Purchase_Order_Main.Company_ID = Store_Tender_Sub.Company_ID AND Store_Items.Item_Code = Store_Tender_Sub.Med_Code WHERE (Purchase_Order_Sub.PO_ID = @PO_ID) AND (Purchase_Order_Main.Company_ID = @Company_ID) ORDER BY Purchase_Order_Sub.Entry_Date"
        UpdateCommand="UPDATE Purchase_Order_Sub SET Rate = @Rate, Qty = @Qty, Amount = @Amount, Specification = @Specification, QO_No = @QO_No, For_Customer = @Customer, Order_No = @Order_No,Pack=@Pack,Unit_Pack=@Unit_Pack,PackRate=@PackRate WHERE (PO_ID = @PO_ID) AND (Item_Code = @Item_Code)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="hfPaymentToId" Name="Company_ID"
                PropertyName="Value" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_ItemRate" DefaultValue="" Name="Rate"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Item_Qty" Name="Qty" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Item_Code" Name="Item_Code" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_TotalAmt" Name="Amount" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Specification" Name="Specification"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="Hf_QO_No" Name="QO_No" PropertyName="Value" />
            <asp:ControlParameter ControlID="Hf_For_Customer" Name="Customer" PropertyName="Value" />
            <asp:ControlParameter ControlID="Hf_OR_No" Name="Order_No" PropertyName="Value" />
            <asp:Parameter Name="Pack" />
            <asp:Parameter Name="Unit_Pack" />
            <asp:Parameter Name="PackRate" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_PR_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_For_POPR" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="Delete_Purchase_Order" InsertCommand="INSERT INTO [STORE].[dbo].[Purchase_Order_Sub] ([PO_ID],[Item_Code],[Rate],[Qty],[DTL_Sample])    VALUES (@PO_ID&#13;&#10;           ,@Item_Code&#13;&#10;           ,@Rate&#13;&#10;           ,@Qty&#13;&#10;           ,@DTL_Sample)"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT Purchase_Order_Sub.Item_Code, ISNULL(Purchase_Order_Sub.Rate, '') AS Rate, Purchase_Order_Sub.Qty, ISNULL(Store_Items.Drug_Category, '') + ' ' + ISNULL(Store_Items.Item_Name, '') + ' ' + ISNULL(Store_Items.Potency, '') + ' ' + ISNULL(Store_Items.Unit, '') AS Item, Purchase_Order_Sub.DTL_Sample FROM Purchase_Order_Sub INNER JOIN Store_Items ON Purchase_Order_Sub.Item_Code = Store_Items.Item_Code INNER JOIN Purchase_Order_Main ON Purchase_Order_Sub.PO_ID = Purchase_Order_Main.PO_ID LEFT OUTER JOIN Store_Tender_Sub ON Purchase_Order_Main.Company_ID = Store_Tender_Sub.Company_ID AND Store_Items.Item_Code = Store_Tender_Sub.Med_Code WHERE (Purchase_Order_Sub.PO_ID = @PO_ID) AND (Purchase_Order_Main.Company_ID = @Company_ID) ORDER BY Purchase_Order_Sub.Entry_Date"
        UpdateCommand="Update_Purchase_Order" UpdateCommandType="StoredProcedure" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="hfPaymentToId" Name="Company_ID"
                PropertyName="Value" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="GridView1" Name="Item_Code" PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_QTY" Name="Qty" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Item_Code" Name="Item_Code" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_DTL_Sample" Name="DTL_Sample" PropertyName="Value" />
            <asp:Parameter Name="Subject" Type="String" />
            <asp:ControlParameter ControlID="TextBox_Temp_TermsAndCondition" Name="Term_and_Conditions"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_payment_Process" Name="Payment_Process"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="hfPaymentToId" Name="Company_ID" PropertyName="Value"
                Type="Int32" />
            <asp:Parameter DefaultValue="T12357" Name="Tender_ID" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_ItemRate" Name="Rate" PropertyName="Value"
                Type="Double" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Item_Code" Name="Item_Code" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Item_Qty" DefaultValue="10" Name="Qty"
                PropertyName="Value" />
            <asp:Parameter DefaultValue="10 ML" Name="DTL_Sample" />
            <asp:ControlParameter ControlID="HiddenField_ItemRate" DefaultValue="" Name="Rate"
                PropertyName="Value" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Item_Qty" runat="server" />
    <asp:HiddenField ID="HiddenField_ItemRate" runat="server" />
    <asp:HiddenField ID="HiddenField_ItemOrgRate" runat="server" />
    <asp:HiddenField ID="HiddenField_PODate" runat="server" />
    <asp:HiddenField ID="HiddenField_TotalAmt" runat="server" />
    <asp:HiddenField ID="HiddenField_TermsAndCondition" runat="server" />
    <asp:HiddenField ID="HiddenField_Item_Code" runat="server" />
    <asp:HiddenField ID="HiddenField_QTY" runat="server" />
    <asp:HiddenField ID="hdfPack" runat="server" />
    <asp:HiddenField ID="hdfUnitPack" runat="server" />
    <asp:HiddenField ID="hdfPackRate" runat="server" />
    <asp:HiddenField ID="HiddenFieldTender_ID" runat="server" />
    <asp:HiddenField ID="hf_ItemWiseExpense" runat="server" />
    <asp:HiddenField ID="hf_CostWiseExpense" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceTenderCompany" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="Select_Tender_Company"
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:TextBox ID="TextBox_Temp_TermsAndCondition" runat="server" TextMode="MultiLine"
        Visible="False"></asp:TextBox><br />

    <br />
    <br />
    <asp:Panel ID="pnlExpenseExclude" runat="server" CssClass="lightbox_bg" Visible="False">
        <div class="lightbox" style="width: 600px; height: 150px;">
            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right" width="30%">Expense Description :
                    </td>
                    <td>
                        <asp:CheckBoxList ID="cblExpenseItem" runat="server" DataSourceID="SQL_Item_Expense_Exclude"
                            RepeatLayout="Flow" DataTextField="Expense_Description" DataValueField="Expenses_ID"
                            RepeatColumns="3" RepeatDirection="Horizontal">
                        </asp:CheckBoxList>
                        <asp:SqlDataSource ID="SQL_Item_Expense_Exclude" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                            InsertCommand="INSERT INTO Item_Expense_Exclude
                      (Sub_ID, Expense_ID)
VALUES     (@Sub_ID,@Expense_ID)"
                            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                            SelectCommand="SELECT     aie.Expenses_ID, aie.Expense_Description
FROM         Admin_Item_Expense AS aie INNER JOIN
                      Purchase_Order_Item_Expenses AS poie ON aie.Expenses_ID = poie.Expenses_ID
WHERE poie.PO_ID = @PO_ID"
                            OnSelecting="SQL_Item_Expense_Exclude_Selecting">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="hf_POSub_ID" Name="Sub_ID" PropertyName="Value" />
                                <asp:ControlParameter ControlID="hf_Expense_Value_ID" Name="Expense_ID" PropertyName="Value" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hf_POID_Expense" Name="PO_ID" PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:HiddenField ID="hf_POID_Expense" runat="server" />
                        <asp:HiddenField ID="hf_Expense_Value_ID" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;
                    </td>
                    <td>
                        <asp:Button ID="btnExclude" runat="server" OnClick="btnExclude_Click" Text="Exclude Expense" />
                        <asp:Button ID="btnExcludeCancel" runat="server" OnClick="btnExcludeCancel_Click"
                            Text="Cancel" />
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
    <br />
    <asp:Panel ID="pnlNewExpense" runat="server" CssClass="lightbox_bg" Visible="False">
        <div class="lightbox" style="width: 600px; height: 250px;">
            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right" width="15%">Expense Name :
                    </td>
                    <td>
                        <asp:TextBox ID="txtExpenseNameNew" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">Expense Type :
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlNewExpenseType" runat="server" DataSourceID="SQL_Expense_Type"
                            DataTextField="Expense_Type" DataValueField="Expense_Type_ID">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">Charge To:
                    </td>
                    <td>
                        <asp:DropDownList ID="DDL_Compnay" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3"
                            DataTextField="Account_Title" DataValueField="Account_No" Style="margin-top: 0px">
                        </asp:DropDownList>
                        <br />
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                            SelectCommand="SELECT Account_No, Account_Title FROM Account_Titles"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right">Description:
                    </td>
                    <td>
                        <asp:TextBox ID="Txt_Expanse_Description" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:SqlDataSource ID="SQL_AddNewExpense" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                            InsertCommand="INSERT_Admin_Item_Expense" InsertCommandType="StoredProcedure"
                            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT     Admin_Item_Expense.Expanse_Name, Admin_Item_Expense_Type.Expense_Type, Admin_Item_Expense.Expense_Description, Account_Titles.Account_Title
FROM         Admin_Item_Expense INNER JOIN
                      Admin_Item_Expense_Type ON Admin_Item_Expense.Expense_Type_ID = Admin_Item_Expense_Type.Expense_Type_ID INNER JOIN
                      Account_Titles ON Admin_Item_Expense.Company_ID = Account_Titles.Account_No"
                            DeleteCommand="DELETE FROM Admin_Item_Expense WHERE (Expenses_ID = @Expanse_id)">
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="gv_new_Expanse" Name="Expanse_Name" PropertyName="SelectedValue" />
                            </DeleteParameters>
                            <InsertParameters>
                                <asp:ControlParameter ControlID="Txt_Expanse_Description" Name="Expense_Description"
                                    PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="ddlNewExpenseType" Name="Expense_Type_ID" PropertyName="SelectedValue"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="DDL_Compnay" Name="Company_ID" PropertyName="SelectedValue"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="txtExpenseNameNew" Name="Expanse_Name" PropertyName="Text"
                                    Type="String" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        &nbsp;
                    </td>
                    <td>
                        <asp:Button ID="btnSaveNewExpense" runat="server" OnClick="btnSaveNewExpense_Click"
                            Text="Save Expense" />
                        <asp:Button ID="btnCancelNewExpense" runat="server" OnClick="btnCancelNewExpense_Click"
                            Text="Cancel" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:GridView ID="gv_new_Expanse" runat="server" AutoGenerateColumns="False" DataSourceID="SQL_AddNewExpense"
                            EnableModelValidation="True" OnSelectedIndexChanged="gv_new_Expanse_SelectedIndexChanged">
                            <Columns>
                                <asp:CommandField ShowDeleteButton="True" />
                                <asp:BoundField DataField="Expanse_Name" HeaderText="Expanse Name" SortExpression="Expanse_Name" />
                                <asp:BoundField DataField="Expense_Type" HeaderText="Expense Type" SortExpression="Expense_Type" />
                                <asp:BoundField DataField="Expense_Description" HeaderText="Expense Description"
                                    SortExpression="Expense_Description" />
                                <asp:BoundField DataField="Account_Title" HeaderText="Company Name" SortExpression="Account_Title" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">&nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
    <br />
    <br />
    <table class="ui-accordion">
        <tr>
            <td>
                <asp:Panel ID="pnlPOExpenses" runat="server" Visible="False" Width="100%" CssClass="lightbox">
                    <div class="lightbox" style="width: 600px; height: 250px;">
                        <div class="bxmain">
                            <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                <tr>
                                    <td align="right" width="30%">Expense :
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlExpense" runat="server" DataSourceID="SQL_Expenses" DataTextField="Expense_Description"
                                            DataValueField="Expenses_ID">
                                        </asp:DropDownList>
                                        &nbsp;<asp:LinkButton ID="lbtnNewExpense" runat="server" OnClick="lbtnNewExpense_Click">Add New Expense</asp:LinkButton>
                                        <asp:SqlDataSource ID="SQL_Expenses" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                            InsertCommand="INSERT_Purchase_Order_Item_Expenses" InsertCommandType="StoredProcedure"
                                            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT Expense_Description, Expenses_ID FROM Admin_Item_Expense">
                                            <InsertParameters>
                                                <asp:ControlParameter ControlID="TextBox_PONo" Name="PO_ID" PropertyName="Text" Type="Int32" />
                                                <asp:Parameter DefaultValue="0" Name="PO_ID_Sub" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddlExpense" DefaultValue="" Name="Expenses_ID" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                                <asp:ControlParameter ControlID="txtExpenseCost" Name="Expense_Cost" PropertyName="Text"
                                                    Type="Int32" />
                                                <asp:Parameter DefaultValue="0" Name="Item_Qty" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddlExpenseType" Name="Expense_Type_ID" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                                <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text"
                                                    Type="String" />
                                                <asp:ControlParameter ControlID="DDL_Charge_To" Name="Company_Id" PropertyName="SelectedValue"
                                                    Type="Decimal" />
                                                <asp:Parameter Direction="Output" Name="Identity" Type="Int32" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" width="30%">Expense Type :
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlExpenseType" runat="server" DataSourceID="SQL_Expense_Type"
                                            DataTextField="Expense_Type" DataValueField="Expense_Type_ID">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SQL_Expense_Type" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT aiet.Expense_Type_ID,aiet.Expense_Type FROM Admin_Item_Expense_Type aiet"></asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Expense Cost :
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtExpenseCost" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Charge To:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="DDL_Charge_To" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource4"
                                            DataTextField="Account_Title" DataValueField="Company_ID">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                            SelectCommand="SELECT Account_Titles.Account_Title, Purchase_Order_Main.Company_ID FROM Account_Titles INNER JOIN Purchase_Order_Main ON Account_Titles.Account_No = Purchase_Order_Main.Company_ID"></asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">Description:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox_Description" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;
                                        <asp:SqlDataSource ID="SqlDataSource_save_expenses" runat="server"></asp:SqlDataSource>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnSaveExpense" runat="server" OnClick="btnSaveExpense_Click" Text="Save Expense" />
                                        <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Close"
                                            Width="79px" />
                                        <asp:HiddenField ID="hf_POSub_ID" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br />
                        <br />
                    </div>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <br />
    
</asp:Content>
