<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PurchaseOrderNew.aspx.cs" Inherits="MasterPage" MasterPageFile="~/hacims_masterpage_admin.master" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.1, Version=6.1.20061.28, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

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
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td rowspan="4" valign="top" class="leftnav" >
                <div class="all_left">
                    <div class="bxmain inner_content" style="margin-right: 10px; width: 98%;">
                        <h2><span>Basic Details</span></h2>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
                            <tr>
                                <td align="right" width="35%">PO # :
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox_PONo" runat="server" Style="color: red; font-weight: bold;"
                                        Width="128px" Height="25px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">PO. Date :
                                </td>
                                <td>
                                    <igsch:WebDateChooser ID="WebDateChooser_PODate" runat="server" Width="135px" Height="25px">
                                        <CalendarLayout Culture="English (United Kingdom)">
                                        </CalendarLayout>
                                    </igsch:WebDateChooser>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">Distributor :
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlPaymentTo" Width="135px" Height="25px" AutoPostBack="True" OnSelectedIndexChanged="ddlPaymentTo_SelectedIndexChanged"></asp:DropDownList>

                                    <asp:HiddenField ID="hfPaymentToId" runat="server" Value="-1" />

                                </td>
                            </tr>
                            <tr>
                                <td align="right">FC :
                                </td>
                                <td>
                                    <asp:DropDownList ID="DDL_Other_Currency" runat="server" Width="135px" Height="25px" AutoPostBack="True"
                                        OnSelectedIndexChanged="DDL_Other_Currency_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">FC Rate :
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCurrencyRate" runat="server" Width="128px" Height="25px"
                                        OnTextChanged="txtCurrencyRate_TextChanged" SkinID="number" AutoPostBack="true"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">PO Type :
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_potype" runat="server" Width="135px" Height="25px">
                                         <asp:ListItem>Local Purchases</asp:ListItem>
                                        <asp:ListItem>Gift</asp:ListItem>
                                        <asp:ListItem>Donation</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">MOP :
                                </td>
                                <td>
                                    <asp:DropDownList ID="DropDownList_modeof_payment" runat="server" Width="135px" Height="25px">
                                        <asp:ListItem>Credit</asp:ListItem>
                                        <asp:ListItem>Cash</asp:ListItem>
                                        <asp:ListItem>Cheque</asp:ListItem>
                                        <asp:ListItem>Pay Order</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                             <tr>
                                <td align="right">Lead Time :
                                </td>
                                <td>
                                   <asp:TextBox ID="txtLeadTime" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <asp:HiddenField ID="HiddenField_PO_ID" runat="server" />
                        </table>
                    </div>
                </div>
            </td>
            <td rowspan="4" valign="top" class="leftnav" style="width:81%" >
                <div class="all_left">
                    <div class="bxmain inner_content" style="margin-right: 10px; width: 100%;">
                        <h2><span>Purchase Order Details</span></h2>
                        <table class="tbl_form" width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr style="width: 90%; text-align: center">
                                <td align="right">Date From :
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtDateFrom" runat="server" TextMode="Date" Width="187px"></asp:TextBox>
                                </td>
                                <td align="right">Date To : 
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtDateTo" runat="server" TextMode="Date" Width="187px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td  align="right">
                                    <b>Item Name :</b>
                                </td>
                                <td>
                                    <asp:TextBox CssClass="input_txt" ID="TextBox_specificItem" runat="server" Width="185px"
                                        ></asp:TextBox>
                                    <asp:AutoCompleteExtender ID="aceItems" runat="server" ServiceMethod="SearchItems"
                                        MinimumPrefixLength="1" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10"
                                        TargetControlID="TextBox_specificItem" FirstRowSelected="true" OnClientItemSelected="ClientItemSelected2"
                                        CompletionListCssClass="AutoExtender"
                                        CompletionListItemCssClass="AutoExtenderList" CompletionListHighlightedItemCssClass="AutoExtenderHighlight">
                                    </asp:AutoCompleteExtender>
                                    <asp:HiddenField ID="hfItemCode" runat="server" />
                                    </td>
                                <td></td>
                                <td align="left">
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                                    <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
                                </td>
                                </tr>
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:Label ID="lblMessage" runat="server" Font-Bold="true" style="font-size:12px"></asp:Label>
                                </td>
                            </tr>
                            <tr style="width: 95%; text-align: center">
                                <td colspan="4" style="margin-top: 10px;width:95%">
                                    <asp:UpdatePanel ID="updt" runat="server">
                                        <ContentTemplate>
                                    <asp:GridView ID="GridView1" runat="server" EmptyDataText="No Record Found" Width="100%" AutoGenerateColumns="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr #" ItemStyle-Width="40px">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                    <asp:HiddenField ID="hfItemCode" runat="server" Value='<%# Eval("Item_Code") %>' />
                                                </ItemTemplate>

                                            </asp:TemplateField>
                                            
                                            <asp:BoundField DataField="Position" HeaderText="Shelf" ItemStyle-Width="80px" />
                                            <asp:BoundField DataField="Item_Code" HeaderText="Item Code" ItemStyle-Width="70px" />
                                            <asp:BoundField DataField="Item_Name" HeaderText="Item Name" ItemStyle-Width="200px" />
                                            <asp:BoundField DataField="Stock" HeaderText="Stock" ItemStyle-Width="30px" />
                                            <asp:BoundField DataField="ConsumedQty" HeaderText="Consumed Qty" ItemStyle-Width="100px" />
                                            <asp:TemplateField ItemStyle-Width="70px" HeaderText="Order Qty">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtOrderQty" runat="server" Width="50px" Text='<%# Eval("OrderQty") %>' OnTextChanged="txtOrderQty_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="70px" HeaderText="FOC">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFOC" runat="server" Width="50px" Text='<%# Eval("FOC") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="70px" HeaderText="Unit Price FC">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtForeignRate" OnTextChanged="txtForeignRate_TextChanged" AutoPostBack="true" runat="server" Width="70px" Text='<%# Eval("ForeignRate","{0:0,00.00}") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="70px" HeaderText="Unit Price PKR">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtPrice_Unit" OnTextChanged="txtPrice_Unit_TextChanged" AutoPostBack="true" runat="server" Width="60px" Text='<%# Eval("Price_Unit") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Amount FC">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalAmountFC" Text='<%# Convert.ToDecimal(Eval("ForeignRate","{0:0,00.00}"))* Convert.ToDecimal(Eval("OrderQty","{0:0,00.00}")) %>' runat="server" ></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Amount PKR">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalAmountPKR" Text='<%# Convert.ToDecimal(Eval("Price_Unit","{0:0,00.00}"))* Convert.ToDecimal(Eval("OrderQty","{0:0,00.00}")) %>' runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="40px">
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="chkall" runat="server" OnCheckedChanged="chkall_CheckedChanged" AutoPostBack="true" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkbox" runat="server" OnCheckedChanged="chkbox_CheckedChanged" AutoPostBack="true"    />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                       
                            </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>

                            <tr align="right">
                                <td colspan="4">
                                    <asp:UpdatePanel ID="upVal" UpdateMode="Conditional" runat="server">
                                        <ContentTemplate>
                                        <table runat="server" id="tblCalculations" visible="false">
                                         <tr align="right" >
                                <td  >
                                    <span>Total Value : </span>
                                    <asp:TextBox Enabled="false" Width="30%" ID="lblGTotalFC" runat="server" Text="0"></asp:TextBox>
                                    <asp:TextBox Enabled="false" Width="30%" ID="lblGTotalPKR" runat="server" Text="0"></asp:TextBox>
                                </td>
                            </tr>
                            <tr align="right" >
                                <td >
                                    <span>Adjustment : </span>
                                    <asp:TextBox Width="30%" ID="FCAdjustment" OnTextChanged="FCAdjustment_TextChanged" AutoPostBack="true" runat="server" Text="0"></asp:TextBox>
                                    <asp:TextBox Width="30%" ID="PKRAdjustment" OnTextChanged="PKRAdjustment_TextChanged" AutoPostBack="true" runat="server" Text="0"></asp:TextBox>
                                </td>
                            </tr>
                            <tr align="right">
                                <td >
                                    <span>Net Value : </span>
                                    <asp:TextBox Enabled="false" Width="30%" ID="FCNetValue" runat="server" Text="0"></asp:TextBox>
                                    <asp:TextBox Enabled="false" Width="30%" ID="PKRNetValue" runat="server" Text="0"></asp:TextBox>
                                </td>
                            </tr>
                                    </table>
                                            
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    

                                </td>
                            </tr>
                            
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>

    <div style="width:90%;margin:auto;margin-top:30px">
        <div style="float:right">
            <asp:Button Text="Transfer" runat="server" Id="btnTransfer" OnClick="btnTransfer_Click" Visible="false" />

        </div>
        <asp:UpdatePanel ID="updtUp" runat="server">
            <ContentTemplate>
                
                <div style="width:100%;text-align:center">
                    <asp:Label ID="lblMessageForUpdate" runat="server" Font-Bold="true" ForeColor="Green" style="font-size:12px"></asp:Label>
                </div>
       <asp:GridView ID="GridViewUpdate" runat="server" EmptyDataText="No Record Found" Width="100%" AutoGenerateColumns="false" OnPreRender="GridViewUpdate_PreRender">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr #" ItemStyle-Width="40px">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex+1 %>
                                                    <asp:HiddenField ID="hfPO_Sub_Id" runat="server" Value='<%# Eval("PO_ID_Sub") %>' />
                                                    <asp:HiddenField ID="hfItemCode" runat="server" Value='<%# Eval("Item_Code") %>' />
                                                </ItemTemplate>

                                            </asp:TemplateField>
                                            
                                            <asp:BoundField DataField="Item_Code" HeaderText="Item Code" ItemStyle-Width="70px" />
                                            <asp:BoundField DataField="Item_Name" HeaderText="Item Name" ItemStyle-Width="200px" />
                                            <asp:BoundField DataField="Stock" HeaderText="Stock" ItemStyle-Width="30px" />
                                            <asp:BoundField DataField="ConsumedQty" HeaderText="Consumed Qty" ItemStyle-Width="100px" />
                                            <asp:TemplateField ItemStyle-Width="70px" HeaderText="Order Qty">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtOrderQty" runat="server" Width="50px" Text='<%# Eval("OrderQty") %>' OnTextChanged="txtOrderQty_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="70px" HeaderText="Unit Price FC">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtForeignRate" OnTextChanged="txtForeignRate_TextChanged" AutoPostBack="true" runat="server" Width="70px" Text='<%# Eval("RateFC","{0:0,00.00}") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ItemStyle-Width="70px" HeaderText="Unit Price PKR">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtPrice_Unit" OnTextChanged="txtPrice_Unit_TextChanged" AutoPostBack="true" runat="server" Width="60px" Text='<%# Eval("Rate") %>'></asp:TextBox>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Amount FC">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalAmountFC" Text='<%# Convert.ToDecimal(Eval("RateFC","{0:0,00.00}"))* Convert.ToDecimal(Eval("OrderQty","{0:0,00.00}")) %>' runat="server" ></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Amount PKR">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalAmountPKR" Text='<%# Convert.ToDecimal(Eval("Rate","{0:0,00.00}"))* Convert.ToDecimal(Eval("OrderQty","{0:0,00.00}")) %>' runat="server"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    
                                                     <asp:Button ID="updtBtn" runat="server" Text="Update" OnClick="updtBtn_Click"  Width="80px" />
                                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" Width="80px" CommandArgument='<%# Eval("PO_ID_Sub") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                           
                                        </Columns>
                                    </asp:GridView>
                
            </ContentTemplate>
        </asp:UpdatePanel>
                             
    </div>

</asp:Content>
