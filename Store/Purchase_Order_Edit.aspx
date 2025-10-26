<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" AutoEventWireup="true"
    CodeFile="Purchase_Order_Edit.aspx.cs" Inherits="Store_Purchase_Order_Edit" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .lightbox
        {
            left: 30%;
            top: 48%;
        }
    </style>
    <script src="../SpryAssets/mycollaps.js" type="text/javascript"></script>
    <link href="../SpryAssets/mycollaps.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <br />
    <asp:Label ID="Label1" runat="server" Text="" CssClass="err" Visible="False"></asp:Label>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td rowspan="4" valign="top" width="40%">
                <div class="bxmain inner_content" style="margin-right: 10px;">
                <h2><span>Purchase Order Select</span></h2>
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                        <tr>
                            <td style="text-align: right;">
                                Purchase Order # :
                            </td>
                            <td valign="top">
                                <asp:TextBox ID="Txt_PO_No" runat="server" Width="150px"></asp:TextBox>
                            </td>
                            <td style="text-align: left;">
                                <asp:ImageButton ID="btnFilterPO" runat="server" ImageUrl="~/Images/icon_filter_1.png"
                                    Width="27px" Height="27px" Text="Filter PO" OnClick="btnFilterPO_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle" width="175px">
                                Purchase Order # :
                            </td>
                            <td valign="middle" colspan="2">
                                <asp:DropDownList ID="DDL_PO_NO" runat="server" DataSourceID="SDS_Find_PO_No" DataTextField="DisplayText"
                                    DataValueField="PO_ID" OnSelectedIndexChanged="DDL_PO_NO_SelectedIndexChanged"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SDS_Find_PO_No" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                    SelectCommand=" Select 0 PO_ID,' --- Select --- ' DisplayText, 9999999999 OrderBy Union All SELECT [PO_ID], PO_ID DisplayText,Cast(PO_ID as Bigint) OrderBy FROM [Purchase_Order_Main] Where PO_ID Like '%' + @Param + '%' ORDER BY OrderBy DESC"
                                    OnSelecting="SDS_Find_PO_No_Selecting">
                                    <SelectParameters>
                                        <asp:Parameter Name="Param" DefaultValue="%" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">
                                PO. Date :
                            </td>
                            <td valign="middle" colspan="2">
                                <igsch:WebDateChooser ID="WebDateChooser_PODate" runat="server" Width="172px">
                                    <CalendarLayout Culture="English (United Kingdom)">
                                    </CalendarLayout>
                                </igsch:WebDateChooser>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">
                                Company :
                            </td>
                            <td valign="middle" colspan="2">
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceTenderCompany"
                                    DataTextField="Account_Title" DataValueField="Account_No" Width="172px">
                                </asp:DropDownList>
                                <asp:Button ID="Button_Company" runat="server" Visible="false" Text="Add" />
                                <a id="addlink" class="add_link box" runat="server" href="Add_New_Company.aspx">Add</a>
                            </td>
                        </tr>
                        <tr style="visibility:hidden;">
                            <td align="right" valign="middle">
                                Dollar Rate :
                            </td>
                            <td valign="middle" colspan="2">
                                <%--<asp:TextBox ID="txtCurrencyRate0" runat="server" AutoPostBack="True" 
                                            OnTextChanged="txtCurrencyRate_TextChanged"  
                                            Width="100px" Enabled="False" Text="1" ></asp:TextBox>--%>
                                <asp:TextBox ID="txtCurrencyRateNew" runat="server" AutoPostBack="True" OnTextChanged="txtCurrencyRate_TextChanged"
                                    Width="100px" Enabled="False" Text="1"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                    <div style="width: 98%; height: auto; overflow: auto;">
                        <asp:DataList ID="DataList_Items" runat="server" SelectedItemStyle-CssClass="selected_link"
                            RepeatLayout="Flow" DataKeyField="Item_Code" OnSelectedIndexChanged="DataList_Items_SelectedIndexChanged">
                            <HeaderTemplate>
                                <ul class="bullets_mega">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <li>
                                    <asp:LinkButton ID="LinkButton_Item_Name" CssClass="link_tree" runat="server" CommandName="Select"
                                        Text='<%# Eval("Item") %>'></asp:LinkButton>
                                </li>
                            </ItemTemplate>
                            <FooterTemplate>
                                </ul></FooterTemplate>
                        </asp:DataList>
                        <br />
                    </div>
                </div>
                <div class="bxmain" style="margin-right: 10px; margin-top: 8px;">
                    <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%" style="display: none">
                        <tr>
                            <td width="25%" align="right" valign="middle">
                                Item Name :
                            </td>
                            <td valign="middle">
                                <asp:TextBox CssClass="input_txt" ID="TextBox_specificItem" runat="server" Width="150px"
                                    OnTextChanged="TextBox_specificMedicine_TextChanged"></asp:TextBox>
                                <asp:TextBox ID="TextBoxItemName" runat="server" AutoPostBack="True" CssClass="input_txt"
                                    OnTextChanged="TextBox3_TextChanged" Width="150px" Visible="False"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">
                                Store Category :
                            </td>
                            <td>
                                <asp:DropDownList ID="DropDownList_Store_Category" runat="server" AutoPostBack="True"
                                    DataSourceID="SqlDataSource_Store_Item" DataTextField="Item_Category" DataValueField="Item_Category_ID"
                                    OnSelectedIndexChanged="DropDownList_Store_Category_SelectedIndexChanged" Width="162px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle">
                                Item Code :
                            </td>
                            <td>
                                <asp:TextBox ID="TextBox_ItemCode" runat="server" Width="150px" OnTextChanged="TextBox_ItemCode_TextChanged"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                            </td>
                            <td>
                                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Search" Width="65px" />
                                <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="ALL" />
                                <asp:TextBox ID="TextBox_Subject" runat="server" CssClass="input_txt" Width="300px"
                                    Visible="False"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td valign="top">
                <asp:Label ID="Label_Msg" runat="server" CssClass="err" ForeColor="Red" Visible="False"></asp:Label>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="99%"
                    DataSourceID="SqlDataSource2" DataKeyNames="Item_Code" OnPreRender="GridView1_PreRender"
                    ShowFooter="True" EnableModelValidation="True" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                    <RowStyle CssClass="GridItem" />
                    <HeaderStyle CssClass="GridHeader" />
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <Columns>
                        <asp:TemplateField HeaderText="Item &amp; Specification" SortExpression="Item">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Item") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label_Item" runat="server" Text='<%# Bind("Item") %>'></asp:Label>
                                <asp:TextBox ID="TextBox_Specification" runat="server" Height="35px" TextMode="MultiLine"
                                    Width="96%" Enabled="False"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" SortExpression="Rate">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" Width="100px" runat="server" Text='<%# Bind("Rate") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("URate","{0:#,##.##}") %>'
                                    Visible="False"></asp:Label>
                                <asp:TextBox ID="TextBox_Rate" runat="server" Text='<%# Eval("URate","{0:#,##.##}") %>' Width="100px"
                                    AutoPostBack="True" Enabled="False"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" Visible="False" />
                        <asp:TemplateField HeaderText="QTY">
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox_Qty" runat="server" Width="30px" Text='<%# Eval("Qty", "{0}") %>'
                                    AutoPostBack="True" Enabled="False"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox_Qty"
                                    ErrorMessage="RegularExpressionValidator" ValidationExpression="\d{1,8}">*</asp:RegularExpressionValidator>
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Eval("Item_Code", "{0}") %>' />
                                <asp:HiddenField ID="HfPO_ID_Sub" runat="server" Value='<%# Eval("PO_ID_Sub") %>' />
                            </ItemTemplate>
                            <FooterTemplate>
                                <strong>Total</strong>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount (Rs)">
                            <FooterTemplate>
                                <asp:Label ID="Label_GTotalAmount" runat="server"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label_Amount" runat="server" Text='<%# Eval("Amount","{0:#,##.##}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount (USD)" Visible="false">
                            <FooterTemplate>
                                <asp:Label ID="Label_GTotal_Other_Cost" runat="server"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label_Other_Cost" runat="server" Text='<%# Eval("Amount_Other_Currency","{0:#,##0.00}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Expense (Rs)">
                            <FooterTemplate>
                                <asp:Label ID="Label_TotalItem_Wise_Expense" runat="server"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
<%--                                <asp:Label ID="Label_Item_Wise_Expense" runat="server" Text='<%# Eval("ExpenseAmountWise","{0:#,##0.00}") %>'></asp:Label>--%>
                             <asp:TextBox ID="Label_Item_Wise_Expense"  Width="100px" Runat="server" Text='<%# Eval("ExpenseAmountWise","{0:#,##0.00}") %>' ></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" ">
                             
                            <ItemTemplate>
                            <asp:Button ID="btnaddexpense" runat="server" Text="Add Expense" OnClick="btnaddexpense_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Expense (USD)" Visible="false">
                            <FooterTemplate>
                                <asp:Label ID="Label_TotalCost_Wise_Expense" runat="server"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label_Cost_Wise_Expense" runat="server" Text='<%# Eval("ExpenseQtyWise","{0:#,##0.00}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="Cost Wise Expense">
                            <ItemTemplate>
                                <asp:Label ID="lblCostWiseExpense" runat="server"></asp:Label>
                                <asp:Label ID="lblExpenseAmountWise" runat="server" Text='<%# Eval("ExpenseAmountWise") %>'
                                    Visible="true"></asp:Label>
                                <asp:Label ID="lblExpenseQtyWise" runat="server" Visible="False" Text='<%# Eval("ExpenseQtyWise") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="With Currency Rate" Visible="false">
                            <FooterTemplate>
                                <asp:Label ID="lblCurrencyRateFooter" runat="server"></asp:Label>
                            </FooterTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCurrencyRate" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField Visible="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnExcludeExpense" runat="server" CommandArgument='<%# Eval("PO_ID_Sub") %>'
                                    OnClick="lbtnExcludeExpense_Click" CommandName='<%# Eval("PO_ID") %>'>Expense 
                                Exclude</asp:LinkButton>
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
                        <asp:TemplateField ShowHeader="False" Visible="false">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                    ImageUrl="~/images/deletebtn.png" OnClientClick="comfirm return('Do you want to delete this item'); "
                                    Text="Delete" />
                            </ItemTemplate>
                        </asp:TemplateField>
                          <asp:TemplateField ItemStyle-Width="20px">
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkall" runat="server" OnCheckedChanged="chkall_CheckedChanged" AutoPostBack="true" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkbox" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <div class="bxmain inner_content" style="margin-bottom: 8px; margin-top: 8px; width:99%;">
                <h2><span>Expenses Detail</span></h2>
                    <table width="100%" cellspacing="0" cellpadding="0" class="tbl_form">
                        <tr>
                            <td align="right" width="30%">
                                &nbsp;
                            </td>
                            <td>
                                <div style="float: right; margin-right: 10px; margin-top: 4px;">
                                    
                                    <asp:Button ID="Updatebtn" runat="server" Text="Update" OnClick="Updatebtn_Click" Visible="false" />
                                    <asp:Button ID="btnAddExpenses" runat="server" OnClick="btnAddExpenses_Click" Text="Add Expenses"
                                        Visible="False" /></div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" width="30%" colspan="2">
                                <asp:GridView ID="gvExpenseView" runat="server" AutoGenerateColumns="False" Width="98%"
                                    DataSourceID="SQL_Expense_GV" EnableModelValidation="True" DataKeyNames="PO_Expense_ID"
                                    ShowFooter="True" OnPreRender="gvExpenseView_PreRender">
                                    <Columns>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="LinkButton1" runat="server" CausesValidation="False" OnClientClick='return confirm("Do you want to delete this record?");'
                                                    OnClick="LinkButton1_Click" CommandName="Delete" ImageUrl="~/images/icon_delete.gif"
                                                    Text="Delete" />
                                                <%--  <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                                    CommandName="Delete" onclick="LinkButton1_Click" Text="Delete" 
                                                    onclientclick="return confirm(&quot;Do you want to delete this record?&quot;);"></asp:LinkButton>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Sr. No.">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Expense_Name" HeaderText="Expense" SortExpression="Expense_Name" />
                                        <asp:BoundField DataField="Expense_Type" HeaderText="Expense Type" SortExpression="Expense_Type" />
                                         <asp:BoundField DataField="Item_Code" HeaderText="Item Code" SortExpression="Item_Code" />
                                        <asp:BoundField DataField="Account_Title" HeaderText="Company" SortExpression="Account_Title" Visible="false" />
                                        <asp:TemplateField HeaderText="Description" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDesc" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label runat="server" Font-Bold="true" Text="Total : "></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Percentage" HeaderText="Percentage (%)" SortExpression="Percentage"
                                         DataFormatString="{0:##,###.00}" />
                                        <asp:TemplateField HeaderText="PKR Cost">
                                            <ItemTemplate>
                                                <asp:Label ID="lblExpenseCost" runat="server" Text='<%# Eval("Expense_Cost", "{0:##,###.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblTotalExpenseCost" runat="server" Font-Bold="true" Text=""></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="USD Rate" Visible="false">
                                            <FooterTemplate>
                                                <asp:Label ID="lblTotalCurrencyCost" runat="server" Font-Bold="True"></asp:Label>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblCurrencyCost" runat="server" Text='<%# Eval("Currency_Rate", "{0:##,###.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="USD Cost" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUSRate" runat="server" Text='<%# Eval("Other_Currency_Rate","{0:##,###.00}") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblTotalUSRate" runat="server" Font-Bold="true" Text=""></asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="View Voucher" Visible="False">
                                            <ItemTemplate>
                                                <asp:Button ID="BTN_Voucher" runat="server" Height="18px" OnClick="BTN_Voucher_Click"
                                                    Text="Add" />
                                                <asp:HiddenField ID="HD_PO_ID" runat="server" Value='<%# Eval("PO_ID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="display:none;">
                    <tr>
                        <td valign="top" width="60%">
                            <div class="bx_rad">
                                <ul id="tp1">
                                    <li>
                                        <h2>
                                            <span>Term and Conditions</span></h2>
                                    </li>
                                    <li>
                                        <div style="padding-left: 5px;">
                                            <asp:TextBox ID="WebHtmlEditor_TermsAndCondition" runat="server" TextMode="MultiLine"
                                                Height="300px" Width="495px"></asp:TextBox>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <br />
                            <div class="bx_rad">
                                <ul id="tp2">
                                    <li>
                                        <h2>
                                            <span>Payment Process</span></h2>
                                    </li>
                                    <li>
                                        <asp:TextBox ID="TextBox_payment_Process" runat="server" Height="50px" TextMode="MultiLine"
                                            Width="93%" Style="margin-left: 10px;"></asp:TextBox>
                                    </li>
                                </ul>
                            </div>
                            <br />
                            <asp:Panel ID="Panel_TaxDiscount" runat="server" Width="100%" CssClass="lightbox">
                                <div class="bx_rad">
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
                                                            DataTextField="Tax_Name" DataValueField="Tax_Id" Width="150px">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <strong>Amount :</strong>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="TextBox_TaxDiscountAmount" runat="server" Width="150px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="Button_SaveTaxDis" runat="server" Text="Save" OnClick="Button_SaveTaxDis_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:DataList ID="DataList_TAXDiscount" runat="server" DataSourceID="SqlDataSource_TAX_Discount_Insert"
                                                Width="103%" OnPreRender="DataList_TAXDiscount_PreRender">
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
                        <td valign="top" width="40%">
                            <div style="margin-left: 10px;">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" width="60%">
                            &nbsp;
                        </td>
                        <td valign="top" width="40%">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" width="60%">
                            &nbsp;
                        </td>
                        <td valign="top" width="40%">
                            &nbsp;
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td valign="top">
                &nbsp;
            </td>
        </tr>
    </table>
    <br />
    <asp:SqlDataSource ID="SQL_Expense_GV" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" OnDeleted="SQL_Expense_GV_Deleted"
        SelectCommand="SELECT        Purchase_Order_Item_Expenses.Percentage, Purchase_Order_Item_Expenses.PO_ID, Admin_Item_Expense.Expense_Name, Purchase_Order_Item_Expenses.Expense_Cost, Account_Titles.Account_Title, 
                         Purchase_Order_Item_Expenses.Description, Purchase_Order_Item_Expenses.PO_Expense_ID, Purchase_Order_Item_Expenses.Other_Currency_Rate, Purchase_Order_Item_Expenses.Currency_Rate, 
                         Admin_Item_Expense_Type.Expense_Type,isnull(Purchase_Order_Item_Expenses.Item_Code,'') Item_Code
FROM            Purchase_Order_Item_Expenses INNER JOIN
                         Admin_Item_Expense ON Purchase_Order_Item_Expenses.Expenses_ID = Admin_Item_Expense.Expenses_ID INNER JOIN
                         Admin_Item_Expense_Type ON Purchase_Order_Item_Expenses.Expense_Type_ID = Admin_Item_Expense_Type.Expense_Type_ID LEFT OUTER JOIN
                         Account_Titles ON Purchase_Order_Item_Expenses.Company_ID = Account_Titles.Account_No
WHERE        (Purchase_Order_Item_Expenses.PO_ID = @PO_ID)"
        DeleteCommand="Delete_Purchase_Order_Item_Expenses" UpdateCommand="UPDATE Purchase_Order_Item_Expenses SET Expense_Cost = @Expense_Cost, Description = @Description WHERE (PO_Expense_ID = @PO_Expense_ID)"
        DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDL_PO_NO" Name="PO_ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="DDL_PO_NO" Name="PO_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="gvExpenseView" Name="PO_Expense_ID" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="emp_id" SessionField="emp_id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="ddlExpenseType" Name="Expense_Cost" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TextBox_Description" Name="Description" PropertyName="Text" />
            <asp:Parameter Name="PO_Expense_ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:SqlDataSource ID="SqlDataSource_DDL_TAX" runat="server" ConnectionString="<%$ ConnectionStrings:Finance_ConnectionString %>"
        ProviderName="<%$ ConnectionStrings:Finance_ConnectionString.ProviderName %>"
        SelectCommand="SELECT Tax_Id, Tax_Name FROM Tax_Discount_HeadDetail ORDER BY Tax_Name">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_TAX_Discount_Insert" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="Insert_PO_Tax_Discount" InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
        SelectCommand="SELECT     Tax_Discount_HeadDetail.Tax_Name +' : ' as Tax_Name , PO_Tax_Discount.Amount&#13;&#10;FROM         PO_Tax_Discount INNER JOIN&#13;&#10;                      Tax_Discount_HeadDetail ON PO_Tax_Discount.Tax_ID = Tax_Discount_HeadDetail.Tax_Id&#13;&#10;WHERE     (PO_Tax_Discount.PO_ID = @PO_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDL_PO_NO" Name="PO_ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="DDL_PO_NO" Name="PO_ID" PropertyName="SelectedValue"
                Type="String" />
            <asp:ControlParameter ControlID="DropDownList_SelectTaxDiscount" Name="Tax_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_TaxDiscountAmount" DefaultValue="" Name="Amount"
                PropertyName="Text" Type="Decimal" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Store_Item" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        SelectCommand="SELECT     Item_Category_ID, Item_Category&#13;&#10;FROM         (SELECT     CONVERT(varchar, Item_Category_ID) AS Item_Category_ID, Item_Category&#13;&#10;                       FROM          Store_Item_Category&#13;&#10;                       WHERE      (Item_Category_ID IN(SELECT    distinct Store_Items.Category&#13;&#10;FROM         Store_Item_Department_Wise INNER JOIN&#13;&#10;                      Store_Items ON Store_Item_Department_Wise.Item_code = Store_Items.Item_Code&#13;&#10;where (Store_Item_Department_Wise.Dept_Id = @Dept_Id) and (Store_Item_Department_Wise.SubDept_Id = @SubDept_Id)&#13;&#10;)&#13;&#10;                                                  )&#13;&#10;                       UNION&#13;&#10;                       SELECT     '%' AS Item_Category_ID, 'All' AS Item_Category) AS CatView&#13;&#10;ORDER BY Item_Category_ID&#13;&#10;&#13;&#10;&#13;&#10;">
        <SelectParameters>
            <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptId" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Store_Category" runat="server"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Min_Alert" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="Store_Purchase_Item_Shortage_Alert"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
            <asp:SessionParameter Name="Dept_Id" SessionField="dept_id" />
            <asp:SessionParameter Name="ShiftID" SessionField="ShiftID" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Company_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_CompanyID" runat="server" />
    <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Specification" runat="server" />
    <asp:HiddenField ID="HiddenField_Company_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" InsertCommand="Insert_Purchase_Order_Main"
        DeleteCommand="DELETE FROM Purchase_Order_Sub WHERE (PO_ID = @PO_ID)" InsertCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Company_ID" PropertyName="SelectedValue"
                DefaultValue="" />
            <asp:ControlParameter ControlID="Label1" Name="Count" PropertyName="Text" />
            <asp:Parameter DefaultValue="letter No" Name="Letter_NO" />
            <asp:ControlParameter ControlID="TextBox_Subject" DefaultValue="" Name="Subject"
                PropertyName="Text" />
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
        DeleteCommand="Delete_Purchase_Order" DeleteCommandType="StoredProcedure" InsertCommand="Insert_Purchase_Order_Sub"
        InsertCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
        SelectCommand="SELECT Purchase_Order_Sub.Item_Code, Purchase_Order_Main.Other_Currency_Rate AS Rate, Purchase_Order_Sub.Qty, Purchase_Order_Sub.Rate AS URate, ISNULL(Store_Items.Drug_Category, '') + ' ' + ISNULL(Store_Items.Item_Name, '') + ' ' + ISNULL(Store_Items.Potency, '') + ' ' + ISNULL(Store_Items.Unit, '') AS Item, Purchase_Order_Sub.DTL_Sample,(Purchase_Order_Sub.Rate * Purchase_Order_Sub.Qty) AS Amount, Purchase_Order_Sub.PO_ID_Sub, Purchase_Order_Sub.Cost_Wise_Expense / Purchase_Order_Main.Other_Currency_Rate AS ExpenseQtyWise, Purchase_Order_Sub.Cost_Wise_Expense AS ExpenseAmountWise, Purchase_Order_Sub.PO_ID, CASE WHEN Purchase_Order_Main.Other_Currency_Rate != 0 THEN Purchase_Order_Sub.Rate / Purchase_Order_Main.Other_Currency_Rate ELSE 0 END AS Amount_Other_Currency FROM Purchase_Order_Sub INNER JOIN Purchase_Order_Main ON Purchase_Order_Sub.PO_ID = Purchase_Order_Main.PO_ID INNER JOIN Store_Items ON Purchase_Order_Sub.Item_Code = Store_Items.Item_Code LEFT OUTER JOIN Store_Tender_Sub ON Purchase_Order_Main.Company_ID = Store_Tender_Sub.Company_ID WHERE (Purchase_Order_Sub.PO_ID = @PO_ID) AND (Purchase_Order_Main.Company_ID = @Company_ID) ORDER BY Purchase_Order_Sub.Entry_Date DESC"
        UpdateCommand="Update_Purchase_Order" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Company_ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="GridView1" Name="Item_Code" PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_QTY" Name="Qty" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_DTL_Sample" Name="DTL_Sample" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Item_Code" Name="Item_Code" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="TextBox_Subject" Name="Subject" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_Temp_TermsAndCondition" Name="Term_and_Conditions"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_payment_Process" Name="Payment_Process"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Company_ID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter DefaultValue="T12357" Name="Tender_ID" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_ItemRate" Name="Rate" PropertyName="Value"
                Type="Double" />
            <asp:ControlParameter ControlID="HiddenField_Specification" Name="Specification"
                PropertyName="Value" Type="String" />
            <asp:ControlParameter ControlID="hf_ItemWiseExpense" Name="Item_Wise_Expense" PropertyName="Value"
                Type="Double" DefaultValue="0" />
            <asp:ControlParameter ControlID="hf_CostWiseExpense" Name="Cost_Wise_Expense" PropertyName="Value"
                Type="Double" DefaultValue="0" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Item_Code" Name="Item_Code" PropertyName="Value" />
            <asp:Parameter DefaultValue="1" Name="Qty" />
            <asp:Parameter DefaultValue="10 ML" Name="DTL_Sample" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_UpdateSub" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT Purchase_Order_Sub.Item_Code, ISNULL(Purchase_Order_Sub.Rate, '') AS Rate, Purchase_Order_Sub.Qty, ISNULL(Store_Items.Drug_Category, '') + ' ' + ISNULL(Store_Items.Item_Name, '') + ' ' + ISNULL(Store_Items.Potency, '') + ' ' + ISNULL(Store_Items.Unit, '') AS Item, Purchase_Order_Sub.DTL_Sample FROM Purchase_Order_Sub INNER JOIN Store_Items ON Purchase_Order_Sub.Item_Code = Store_Items.Item_Code INNER JOIN Purchase_Order_Main ON Purchase_Order_Sub.PO_ID = Purchase_Order_Main.PO_ID LEFT OUTER JOIN Store_Tender_Sub ON Purchase_Order_Main.Company_ID = Store_Tender_Sub.Company_ID AND Store_Items.Item_Code = Store_Tender_Sub.Med_Code WHERE (Purchase_Order_Sub.PO_ID = @PO_ID) AND (Purchase_Order_Main.Company_ID = @Company_ID) ORDER BY Purchase_Order_Sub.Entry_Date"
        UpdateCommand="UPDATE Purchase_Order_Sub SET Rate = @Rate, Qty = @Qty, Amount = @Amount, Specification = @Specification WHERE (PO_ID = @PO_ID) AND (Item_Code = @Item_Code)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Company_ID" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_TotalAmt" DefaultValue="" Name="Rate"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Item_Qty" Name="Qty" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Item_Code" Name="Item_Code" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Company_ID" Name="Amount" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Specification" Name="Specification"
                PropertyName="Value" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_PR_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSource_For_POPR" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="Delete_Purchase_Order" InsertCommand="INSERT INTO [STORE].[dbo].[Purchase_Order_Sub]&#13;&#10;           ([PO_ID],[Item_Code],[Rate],[Qty],[DTL_Sample])&#13;&#10;     VALUES&#13;&#10;           (@PO_ID&#13;&#10;           ,@Item_Code&#13;&#10;           ,@Rate&#13;&#10;           ,@Qty&#13;&#10;           ,@DTL_Sample)"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT Purchase_Order_Sub.Item_Code, ISNULL(Purchase_Order_Sub.Rate, '') AS Rate, Purchase_Order_Sub.Qty, ISNULL(Store_Items.Drug_Category, '') + ' ' + ISNULL(Store_Items.Item_Name, '') + ' ' + ISNULL(Store_Items.Potency, '') + ' ' + ISNULL(Store_Items.Unit, '') AS Item, Purchase_Order_Sub.DTL_Sample FROM Purchase_Order_Sub INNER JOIN Store_Items ON Purchase_Order_Sub.Item_Code = Store_Items.Item_Code INNER JOIN Purchase_Order_Main ON Purchase_Order_Sub.PO_ID = Purchase_Order_Main.PO_ID LEFT OUTER JOIN Store_Tender_Sub ON Purchase_Order_Main.Company_ID = Store_Tender_Sub.Company_ID AND Store_Items.Item_Code = Store_Tender_Sub.Med_Code WHERE (Purchase_Order_Sub.PO_ID = @PO_ID) AND (Purchase_Order_Main.Company_ID = @Company_ID) ORDER BY Purchase_Order_Sub.Entry_Date"
        UpdateCommand="Update_Purchase_Order" UpdateCommandType="StoredProcedure" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Company_ID" PropertyName="SelectedValue" />
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
            <asp:ControlParameter ControlID="TextBox_Subject" Name="Subject" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_Temp_TermsAndCondition" Name="Term_and_Conditions"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="TextBox_payment_Process" Name="Payment_Process"
                PropertyName="Text" Type="String" />
            <asp:ControlParameter ControlID="DropDownList1" Name="Company_ID" PropertyName="SelectedValue"
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
    <asp:HiddenField ID="HiddenField_PODate" runat="server" />
    <asp:HiddenField ID="HiddenField_TotalAmt" runat="server" />
    <asp:HiddenField ID="HiddenField_TermsAndCondition" runat="server" />
    <asp:HiddenField ID="HiddenField_Item_Code" runat="server" />
    <asp:HiddenField ID="HiddenField_QTY" runat="server" />
    <asp:HiddenField ID="HiddenFieldTender_ID" runat="server" />
    <asp:HiddenField ID="hf_ItemWiseExpense" runat="server" />
    <asp:HiddenField ID="hf_CostWiseExpense" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceTenderCompany" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="Select_Tender_Company"
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:TextBox ID="TextBox_Temp_TermsAndCondition" runat="server" TextMode="MultiLine"
        Visible="False"></asp:TextBox><br />
    <asp:DataList ID="DataList1" runat="server" DataKeyField="SR_NO" DataSourceID="SqlDataSource_Min_Alert"
        Width="100%" OnSelectedIndexChanged="DataList1_SelectedIndexChanged" CssClass="tbl_form"
        Visible="False">
        <ItemTemplate>
            <table border="0" cellpadding="0" cellspacing="0" style="margin-left: 10px; padding: 0px;"
                width="100%">
                <tr>
                    <td>
                        <br style="line-height: 5px;" />
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Select" CssClass="treelink"
                            Text='<%# Eval("Medicine", "{0}") %>'></asp:LinkButton><br />
                        Stock :
                        <asp:Label ID="StockLabel" runat="server" CssClass="err" Text='<%# Eval("Stock") %>'></asp:Label>
                    </td>
                </tr>
            </table>
            <span style="border-bottom: #999999 solid 1px; display: block; width: 100%; margin: 0px;
                padding: 0px; margin-top: -5px;"></span>
            <asp:HiddenField ID="HiddenFieldTen_ID" runat="server" Value='<%# Eval("Tender_ID", "{0}") %>' />
        </ItemTemplate>
    </asp:DataList>
    <br />
    <div align="center" style="clear: both;">
        <asp:Button ID="Button1" runat="server" CssClass="btn1" Visible="false" Text="Update" />
        <asp:Button ID="Button4" runat="server" CssClass="btn1" Text="Report" OnClick="Button4_Click" />
        <asp:Button ID="btnDistDetail" runat="server" CssClass="btn1" Text="Distribution Detail Report"
            OnClick="btnDistDetail_Click" Enabled="False" Visible="False" />
    </div>
    <br />
    <asp:Panel ID="pnlExpenseExclude" runat="server" CssClass="lightbox_bg" Visible="False">
        <div class="lightbox1" style="width: 600px; height: 150px;">
            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right" width="30%">
                        Expense Description :
                    </td>
                    <td>
                        <asp:CheckBoxList ID="cblExpenseItem" runat="server" DataSourceID="SQL_Item_Expense_Exclude"
                            RepeatLayout="Flow" DataTextField="Expense_Description" DataValueField="Expenses_ID"
                            RepeatColumns="3" RepeatDirection="Horizontal">
                            <asp:ListItem>Charges</asp:ListItem>
                            <asp:ListItem></asp:ListItem>
                        </asp:CheckBoxList>
                        <asp:SqlDataSource ID="SQL_Item_Expense_Exclude" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                            InsertCommand="INSERT INTO Item_Expense_Exclude
                      (Sub_ID, Expense_ID)
VALUES     (@Sub_ID,@Expense_ID)" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                            SelectCommand="SELECT     aie.Expenses_ID, aie.Expense_Description
FROM         Admin_Item_Expense AS aie INNER JOIN
                      Purchase_Order_Item_Expenses AS poie ON aie.Expenses_ID = poie.Expenses_ID
WHERE poie.PO_ID = @PO_ID">
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
                    <td>
                        &nbsp;
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
        <div class="lightbox11" style="width: 644px; height: 250px;">
            <table cellspacing="0" cellpadding="0" border="0" class="tbl_form">
                <tr>
                    <td align="right" width="15%">
                        Expense Name :
                    </td>
                    <td>
                        <asp:TextBox ID="txtExpenseNameNew" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Expense Type :
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlNewExpenseType" runat="server" AutoPostBack="True">
                            <asp:ListItem Value="General">General</asp:ListItem>
                            <asp:ListItem Value="Clearing">Clearing</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Cost To Purchases:
                    </td>
                    <td>
                        <asp:DropDownList ID="DDL_Compnay" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3"
                            DataTextField="Account_Title" DataValueField="Account_No" Style="margin-top: 0px">
                        </asp:DropDownList>
                        <asp:HiddenField ID="HF_Charge_To_Purchases" runat="server" />
                        <br />
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                            SelectCommand="SELECT Account_No, Account_Title FROM Account_Titles"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Description:
                    </td>
                    <td>
                        <asp:TextBox ID="Txt_Expanse_Description" runat="server"></asp:TextBox>
                        <asp:CheckBox ID="CheckBox1" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:SqlDataSource ID="SQL_AddNewExpense" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                            InsertCommand="INSERT_Admin_Item_Expense" InsertCommandType="StoredProcedure"
                            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT     Admin_Item_Expense.Expanse_Name, Admin_Item_Expense_Type.Expense_Type, Admin_Item_Expense.Expense_Description, Account_Titles.Account_Title
FROM         Admin_Item_Expense INNER JOIN
                      Admin_Item_Expense_Type ON Admin_Item_Expense.Expense_Type_ID = Admin_Item_Expense_Type.Expense_Type_ID INNER JOIN
                      Account_Titles ON Admin_Item_Expense.Company_ID = Account_Titles.Account_No" DeleteCommand="DELETE FROM Admin_Item_Expense WHERE (Expenses_ID = @Expanse_id)">
                            <DeleteParameters>
                                <asp:ControlParameter ControlID="gv_new_Expanse" Name="Expanse_id" PropertyName="SelectedValue" />
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
                                <asp:ControlParameter ControlID="ddlNewExpenseType" Name="Expense_Type" PropertyName="SelectedValue"
                                    Type="String" />
                                <asp:ControlParameter ControlID="HF_Charge_To_Purchases" Name="Cost_To_Purchases"
                                    PropertyName="Value" Type="Boolean" />
                                <asp:ControlParameter ControlID="HF_Charge_To_Purchases" Name="Expenses_ID" PropertyName="Value"
                                    Type="Int32" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                        &nbsp;
                    </td>
                    <td>
                        <asp:Button ID="btnSaveNewExpense" runat="server" OnClick="btnSaveNewExpense_Click"
                            Text="Save Expense" />
                        <asp:Button ID="btnCancelNewExpense" runat="server" OnClick="btnCancelNewExpense_Click"
                            Text="Cancel" CssClass="link_item" />
                        <asp:DropDownList ID="DropDownList2" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:GridView ID="gv_new_Expanse" runat="server" AutoGenerateColumns="False" DataSourceID="SQL_AddNewExpense"
                            EnableModelValidation="True" Visible="False" CssClass="lightbox_bg">
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
                    <td colspan="2">
                        &nbsp;
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
                <asp:Panel ID="pnlPOExpenses" runat="server" CssClass="lightbox" Visible="False">
                    <div class="lightbox">
                        <asp:HiddenField ID="hfditemcode" runat="server" />
                         <asp:HiddenField ID="hfdamount" runat="server" />
                        <div class="bxmain" style="width:100%;">
                            <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                                <tr>
                                    <td align="right" width="100px"> 
                                        Expense :
                                    </td>
                                    <td style="width: 450px;">
                                        <asp:DropDownList ID="ddlExpense" runat="server" DataSourceID="SQL_Expenses" DataTextField="Expense_Name"
                                            DataValueField="Expenses_ID">
                                        </asp:DropDownList>
                                        &nbsp;<asp:LinkButton ID="lbtnNewExpense" runat="server" OnClick="lbtnNewExpense_Click"
                                            OnClientClick="AddExpense.aspx">Add New Expense</asp:LinkButton>
                                        &nbsp;<asp:SqlDataSource ID="SQL_Expenses" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                            InsertCommand="INSERT_Purchase_Order_Item_Expenses" InsertCommandType="StoredProcedure"
                                            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT Expenses_ID, Expense_Name FROM Admin_Item_Expense">
                                            <InsertParameters>
                                                <asp:ControlParameter ControlID="DDL_PO_NO" Name="PO_ID" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                                <asp:Parameter DefaultValue="0" Name="PO_ID_Sub" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddlExpense" DefaultValue="" Name="Expenses_ID" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                                <asp:Parameter Name="Expense_Cost" Type="Double" />
                                                <asp:Parameter DefaultValue="0" Name="Item_Qty" Type="Int32" />
                                                <asp:ControlParameter ControlID="ddlExpenseType" Name="Expense_Type_ID" PropertyName="SelectedValue"
                                                    Type="Int32" />
                                                <asp:Parameter Direction="InputOutput" Name="Identity" Type="Int32" />
                                                <asp:ControlParameter ControlID="TextBox_Description" Name="Description" DefaultValue="" PropertyName="Text"
                                                    Type="String" />
                                                <asp:ControlParameter ControlID="DDL_Charge_To" Name="Company_Id" PropertyName="SelectedValue"
                                                    Type="Decimal" />
                                                <asp:ControlParameter ControlID="txtCurrencyRate" Name="Currency_Rate" PropertyName="Text"
                                                    Type="String" />
                                                <asp:ControlParameter ControlID="txtbox_CurrencyRate" Name="Other_Currency_Rate"
                                                    PropertyName="Text" Type="Double" />
                                                <asp:ControlParameter ControlID="rblAmountType" Name="CostType" 
                                                    PropertyName="SelectedValue" Type="String" />
                                                 <asp:ControlParameter ControlID="hfditemcode" Name="itemcode" 
                                                    PropertyName="Value" Type="String" />
                                                <asp:Parameter Name="Percentage" Type="Double" />
                                            </InsertParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td rowspan="8" style="visibility:hidden;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvBankAmount" Width="100%" DataSourceID="SqlDataSource5" AutoGenerateColumns="false"
                                                        ShowHeader="false" runat="server">
                                                        <Columns>
                                                            <asp:BoundField DataField="Amount_Head" HeaderText="" />
                                                            <asp:BoundField DataField="Amount" ItemStyle-CssClass="AmountAlign" DataFormatString="{0:#,#}"
                                                                HeaderText="" />
                                                        </Columns>
                                                    </asp:GridView>
                                                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                                        SelectCommand="usp_GetLCBankCharges" SelectCommandType="StoredProcedure">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="DDL_PO_NO" Name="PO_ID" PropertyName="SelectedValue"
                                                                Type="String" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Expense Type :
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlExpenseType" runat="server" DataSourceID="SQL_Expense_Type"
                                            DataTextField="Expense_Type" DataValueField="Expense_Type_ID">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SQL_Expense_Type" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT Expense_Type_ID, Expense_Type FROM Admin_Item_Expense_Type AS aiet ORDER BY Expense_Type">
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr style="display:none;">
                                    <td align="right">
                                        Dollar Rate :
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCurrencyRate" runat="server" AutoPostBack="True" OnTextChanged="txtCurrencyRate_TextChanged"
                                            SkinID="input_grid_num" Width="100px">1</asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        &nbsp;
                                    </td>
                                    <td>
                                         <asp:RadioButtonList ID="rblAmountType" runat="server" RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Text="Percentage" Value="Percentage"></asp:ListItem>
                                        <asp:ListItem Text="Amount" Value="Amount"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        Expense Cost :
                                    </td>
                                    <td>
                                       
                                        <asp:TextBox ID="txtExpenseCost" runat="server" AutoPostBack="True" OnTextChanged="txtExpenseCost_TextChanged"
                                            Width="70px"></asp:TextBox> 
                                        
                                    </td>
                                </tr>
                                <tr style="visibility:hidden;">
                                    <td align="right">
                                        Amount in Dollar :
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtbox_CurrencyRate" runat="server" AutoPostBack="True" OnTextChanged="txtbox_CurrencyRate_TextChanged"
                                            Width="70px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="display:none;">
                                    <td align="right">
                                        Charge To:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TXT_Party_Name" runat="server" AutoPostBack="True" OnTextChanged="TXT_Party_Name_TextChanged"></asp:TextBox>
                                        <asp:Label ID="LBL_Rec_MSG" runat="server"></asp:Label>
                                        <br />
                                        <asp:DropDownList ID="DDL_Charge_To" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource4"
                                            DataTextField="Party_Name" DataValueField="Party_Id">
                                        </asp:DropDownList>
                                        <a id="a1" class="add_link box" runat="server" href="Add_New_Company.aspx">Add</a>
                                        <asp:HiddenField ID="Hf_PARTY_NAME" runat="server" />
                                        <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:BasicDataInfoConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:BasicDataInfoConnectionString.ProviderName %>"
                                            SelectCommand="SELECT Party_Id, Party_Name FROM Parties
where party_name like @Par_name  ORDER BY Party_Name">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="Hf_PARTY_NAME" DefaultValue="%" Name="Par_name"
                                                    PropertyName="Value" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr style="display:none;">
                                    <td align="right">
                                        Description:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TextBox_Description" runat="server" TextMode="MultiLine" Height="59px"
                                            Width="212px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                        <asp:SqlDataSource ID="SqlDataSource_save_expenses" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                            ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"></asp:SqlDataSource>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnSaveExpense" runat="server" OnClick="btnSaveExpense_Click" Text="Save Expense" />
                                        <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Close"
                                            Width="79px" />
                                        <asp:Label ID="lbl_Message" runat="server" Font-Bold="True" ForeColor="#66FF66"></asp:Label>
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
    <script type="text/javascript">

        var cookies = Spry.Utils.Cookie("read", "tabbedpanels");
        if (cookies == "true") {
            var tp1 = new Spry.Widget.CollapsiblePanel("tp1", { contentIsOpen: false });
        } else { var tp1 = new Spry.Widget.CollapsiblePanel("tp1", { contentIsOpen: false }); }
        Spry.Utils.addUnLoadListener(function () { Spry.Utils.Cookie("create", "tabbedpanels", tp1.isOpen()); });

        var cookiesb = Spry.Utils.Cookie("read", "tabbedpanelsb");
        if (cookiesb == "true") {
            var tp2 = new Spry.Widget.CollapsiblePanel("tp2", { contentIsOpen: false });
        } else { var tp2 = new Spry.Widget.CollapsiblePanel("tp2", { contentIsOpen: false }); }
        Spry.Utils.addUnLoadListener(function () { Spry.Utils.Cookie("create", "tabbedpanelsb", tp2.isOpen()); });

        var cookies = Spry.Utils.Cookie("read", "tabbedpanelsc");
        if (cookies == "true") {
            var tp3 = new Spry.Widget.CollapsiblePanel("tp3", { contentIsOpen: false });
        } else { var tp3 = new Spry.Widget.CollapsiblePanel("tp3", { contentIsOpen: false }); }
        Spry.Utils.addUnLoadListener(function () { Spry.Utils.Cookie("create", "tabbedpanels", tp3.isOpen()); });
 
    </script>
</asp:Content>
