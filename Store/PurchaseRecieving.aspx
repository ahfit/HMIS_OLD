<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PurchaseRecieving.aspx.cs" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="PurchaseRecieving" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style type="text/css">
        .style1 {
            width: 100%;
        }

        .style2 {
        }

        .btn1 {
            text-align: center;
        }

        .highlightInvalidSerial {
            background-color: orange;
        }

        .auto-style1 {
            font-weight: bold;
            width: 46%;
        }
        .btnabc{
            margin-top: 0em;
            padding: 0px 0px;
        }
    </style>
     <script type="text/javascript">
         $(document).ready(function () {
             debugger;
             $("[id$=TextBox_Lc_No]").focus();

         })
      
         </script>
   
    <script type="text/javascript">
       
        function CheckQuantityLimit(totalRemaining, demandQty, alreadyReceived, currentQty) {
            try {
                var maxAllow = parseInt(totalRemaining);
                var dQty = parseInt(demandQty);
                var arQty = parseInt(alreadyReceived);
                var txtCQty = document.getElementById(currentQty);
                if (maxAllow == 0) {
                    //alert('No remaining Qty is found');
                    //txtCQty.value = 0;
                    //txtCQty.focus();
                }
                else if (maxAllow < (parseInt(txtCQty.value))) {
                    //debugger;
                    alert('Current Qty is exceeding remaning Qty');
                    txtCQty.value = 0;
                    txtCQty.focus();
                }
                else if (demandQty < (arQty + parseInt(txtCQty.value))) {
                    alert('Current Qty is exceeding demand Qty');
                    txtCQty.value = 0;
                    txtCQty.focus();
                }
            }
            catch (e) {
                alert(e);
            }
        }
        function CheckTotals(totalDC, DcNo) {
            try {


                var totalDemand = document.getElementById('<%=((Label)GridView2.FooterRow.FindControl("lblTotalDemandQty")).ClientID %>');
                var totalRec = document.getElementById('<%=((Label)GridView2.FooterRow.FindControl("lblTotalReceivedQty")).ClientID %>');
                var total = document.getElementById(totalDC);
                var dc = document.getElementById(DcNo);
                var d = parseInt(totalDemand.innerHTML.replace(',', ''));
                var r = parseInt(totalRec.innerHTML.replace(',', ''));
                var t = parseInt(total.value);
                //alert(t + "     " + d + "       " + r);
                //debugger;
                if (dc.value == "") {
                    alert("Enter DC number first.");
                    dc.focus();
                }
                else if (t > d) {
                    alert("Quantity exceeding then demand quantity");
                    total.value = 0;
                    total.focus();

                }
                else if (t > (d - r)) {
                    alert("Quantity exceeding then avalibale balance");
                    total.value = 0;
                    total.focus();
                }
            }
            catch (e) {
                alert(e);
            }
        }
    </script>
    <script type="text/javascript">
        function checkDate(sender, args) {
            if (sender._selectedDate < new Date()) {
                alert("You cannot select a day earlier than today!");
                sender._selectedDate = new Date();
                // set the date back to the current date
                sender._textbox.set_Value(sender._selectedDate.format(sender._format))
            }

        }
    </script>

    <script type="text/javascript">
        function confirmationWrong() {
            if (confirm('Are you sure you want to mark wrong Receivings ?')) {
                return true;
            } else {
                return false;
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div class="container-fluid">
        <div class="bxmain inner_content col-md-12 ">
            <div class="row">
                <div class="col-md-2">
                    <h4>
                        <button style="background: no-repeat; box-shadow: none; border: none; font-size: 12px; font-weight: 700; color: #993366; margin-top: -9px; height: 0px;" type="button" data-toggle="collapse" data-target="#demo">
                            Receive Stock <i class="glyphicon glyphicon-chevron-down"></i>
                        </button>
                    </h4>
                </div>

                <div class="col-md-4">
                    <span><b>&nbsp; Company Name : </b>
                    </span>
                    <span>
                        <asp:Label ID="LabelCompanyName" runat="server" CssClass="err" Style="font-weight: bold;"></asp:Label>
                    </span>
                </div>
            </div>

            <div class="" id="demo">

                <table width="30%" border="0" cellspacing="0" cellpadding="0" class="tbl_form row table table-striped table-inverse">

                    <tr class="col-md-12">
                        <td align="right" class="auto-style1">DC # :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_Lc_No" runat="server" ForeColor="Black" BackColor="Pink" TabIndex="1"
                                AutoPostBack="true" OnTextChanged="TextBox_Lc_No_TextChanged"></asp:TextBox>

                        </td>
                    </tr>

                    <tr class="col-md-4">
                        <td align="right" class="auto-style1">Invoice # :
                        </td>
                        <td>
                            <%--  <asp:TemplateField HeaderText="Allow Serial">
                            <ItemTemplate>
                                <asp:CheckBox ID="CH_A_Serial" runat="server" AutoPostBack="True" Checked='<%# Bind("Allow_Serial") %>'
                                    OnCheckedChanged="CH_A_Serial_CheckedChanged" />
                                <asp:HiddenField ID="hf_item_code" runat="server" Value='<%# Eval("Item_Code") %>' />
                                <asp:HiddenField ID="hfPOSUBID" runat="server" Value='<%# Eval("PO_ID_Sub") %>' />

                            </ItemTemplate>
                        </asp:TemplateField>--%>
                            <asp:TextBox ID="TextBox_invoice_NO" Style="width: 11em;" runat="server" TabIndex="2" CssClass="input_txt"></asp:TextBox>
                            <asp:Button  ID="Button_ReciveOrder" runat="server" Text="Receive Complete" OnClick="Button_ReciveOrder_Click" />
                        </td>
                    </tr>

                    <tr class="col-md-4">
                        <td align="right" class="auto-style1">Attach :
                        </td>
                        <td>
                            <asp:FileUpload Style="background: #f0f0f0; border: #d6d6d6 solid 1px; width: 14em;" ID="FileUpload1" runat="server" />

                            <asp:Button ID="Button2"
                                runat="server" CssClass="btn1"  Text="Attach" OnClick="Button2_Click" />

                            <asp:HiddenField ID="HiddenField_file_URL" runat="server" />
                            <asp:HiddenField ID="HiddenField_File_Header" runat="server" />
                        </td>
                    </tr>

                    <tr class="col-md-4">
                        <td align="right" class="auto-style1">Total Received Qty :
                        </td>
                        <td width="78%">
                            <asp:TextBox Style="width: 11em;" ID="txtTotalRecQty" TabIndex="3" runat="server" BackColor="Pink" AutoPostBack="True"
                                OnTextChanged="txtTotalRecQty_TextChanged"></asp:TextBox>
                            <br />
                            <span><b>Remaning Qty : </b>
                                <asp:Label ID="lbltotalReceived" runat="server" Text="0"></asp:Label></span>
                            <br />
                            <asp:Button  ID="btnReceieveAll" runat="server"  OnClick="btnReceieveAll_Click" Text="Receive All" />



                            <asp:Button ID="Button_Purchase" runat="server" Text="Purchase Complete" OnClick="Button1_Click"
                                Enabled="False" /><br />

                        </td>
                        <td>Total Advance Tax :
                        </td>
                        <td>
                            <asp:TextBox Style="width: 11em;" ID="txtadvancetax" TabIndex="3" runat="server" AutoPostBack="True"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="col-md-4">
                        <td align="right" class="auto-style1">For Store :
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownListStore" TabIndex="4" runat="server" DataSourceID="SQL_ForSubDepartment"  onblur="dropdownchanged()"
                                Width="290px" DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="true" OnSelectedIndexChanged="DropDownListStore_SelectedIndexChanged">
                            </asp:DropDownList>

                           <%-- <asp:SqlDataSource ID="SQL_ForSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT        S.SubDept_Name, S.SubDept_Id
                                                FROM            SubDepartment AS S JOIN
                                                                         requisition_department_filter AS R ON S.SubDept_Id = R.sub_Subdept_ID
                                                WHERE        (R.Main_Subdept_ID = @SubDept_Id) and (R.Requisition_Type = 'Internal')">
                                <SelectParameters>
                                    <asp:SessionParameter Name="SubDept_Id" SessionField="SubDeptID" />
                                </SelectParameters>
                            </asp:SqlDataSource>--%>

                            <asp:SqlDataSource ID="SQL_ForSubDepartment" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"
                                 SelectCommand="SELECT S.SubDept_Name, S.SubDept_Id FROM SubDepartment AS S 
                                                Where S.SubDept_Id in (Select R.Main_Subdept_ID From requisition_department_filter AS R
                                                WHERE (R.EmpID = 228) And 
												(R.Requisition_Type='GRN') ) ORDER BY SubDept_Id">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Empid" SessionField="emp_id" />
                                   
                                </SelectParameters>
                            </asp:SqlDataSource>

                        </td>
                    </tr>

                    <tr>
                        <td align="center">
                            <strong>
                                <asp:Label ID="lbl_MSG" runat="server" ForeColor="Red" Font-Size="Medium"></asp:Label></strong>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="row" style="width:100%;">

            <div class="col-md-12">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top">
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" Style="margin-top: 0.5em;" Width="100%"
                                DataSourceID="SqlDataSource_PO" DataKeyNames="Item_Code" OnSelectedIndexChanged="GridView2_SelectedIndexChanged"
                                OnPreRender="GridView2_PreRender" OnRowDataBound="GridView2_RowDataBound"
                                ShowFooter="True">
                                <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr. #">
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex+1 %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Item_Code" HeaderText="Code" />
                                    <asp:ButtonField CommandName="Select" DataTextField="Medicine" HeaderText="Item"
                                        SortExpression="Medicine" Visible="false" />
                                    <asp:TemplateField HeaderText="Item" FooterStyle-HorizontalAlign="Right" HeaderStyle-Width="450px" ItemStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblItemName" runat="server" Text='<%# Eval("Medicine") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblFooterItem" runat="server" Text="Total"></asp:Label>
                                        </FooterTemplate>
<FooterStyle HorizontalAlign="Right"></FooterStyle>

<HeaderStyle Width="450px"></HeaderStyle>
                                    </asp:TemplateField>
                                    <%-- <asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate" Visible="False" />
                                    <asp:BoundField DataField="Qty" HeaderText="Demand Qty" SortExpression="Qty" />--%>
                                    <asp:TemplateField HeaderText="Demand Qty" FooterStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDemandQty" runat="server" Text='<%# Eval("Qty") %>'></asp:Label>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalDemandQty" runat="server" Text="0"></asp:Label>
                                        </FooterTemplate>

<FooterStyle HorizontalAlign="Right"></FooterStyle>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="DTL_Sample" HeaderText="DTL Sample" SortExpression="DTL_Sample"
                                        Visible="False" />
                                    <asp:BoundField DataField="Item_Code" HeaderText="Item Code" SortExpression="Item_Code" Visible="false" />
                                    <asp:BoundField DataField="Medicine" HeaderText="Medicine" SortExpression="Medicine" Visible="false" />
                                    <asp:TemplateField HeaderText="Received Qty" FooterStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelReceiveQty" runat="server" Text='<%# Eval("Recieve_Qty") %>'></asp:Label>
                                            <asp:HiddenField ID="HiddenField_is_Serial" runat="server" Value='<%# Bind("Allow_Serial") %>' />
                                            <asp:HiddenField ID="HF_Detail" runat="server" Value='<%# Eval("Specification") %>' />
                                            <asp:HiddenField ID="hdnQty" runat="server" Value='<%# Eval("Qty") %>' />
                                            <asp:HiddenField ID="hf_item_code" runat="server" Value='<%# Eval("Item_Code") %>' />
                                            <asp:HiddenField ID="hfPOSUBID" runat="server" Value='<%# Eval("PO_ID_Sub") %>' />
                                            <asp:HiddenField ID="hdfBalance" runat="server" Value='<%# Eval("Balance") %>' />
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalReceivedQty" runat="server" Text="0"></asp:Label>
                                        </FooterTemplate>

<FooterStyle HorizontalAlign="Right"></FooterStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Current Received Qty">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtCurRecQty" TabIndex='<%# Container.DataItemIndex+4 %>' Text='<%# Eval("Qty") %>' runat="server" AutoPostBack="false" 
                                                OnTextChanged="txtCurRecQty_TextChanged" Width="100px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Purchase Price" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPurchasePrice" TabIndex='<%# Container.DataItemIndex+5 %>' runat="server" Width="100px" Text='<%# Eval("PurchasePrice") %>' Enabled="false"></asp:TextBox>
                                        </ItemTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sale Price" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtSalePrice" TabIndex='<%# Container.DataItemIndex+5 %>' runat="server" Width="100px" AutoPostBack="true" Text='<%# Eval("SalePrice") %>' Enabled="true"></asp:TextBox>
                                        </ItemTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PackQty" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPackQty" TabIndex='<%# Container.DataItemIndex+5 %>' runat="server" Width="100px" Text='<%# Eval("PackSize") %>'  AutoPostBack="true" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Pack Sale Price" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPackPrice" TabIndex='<%# Container.DataItemIndex+5 %>' runat="server" Width="100px"  AutoPostBack="true" OnTextChanged="txtPackPrice_TextChanged"></asp:TextBox>
                                        </ItemTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Margin">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtmargin" TabIndex='<%# Container.DataItemIndex+5 %>' runat="server" Width="100px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Batch #">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtBatchNo" TabIndex='<%# Container.DataItemIndex+6 %>' runat="server" AutoPostBack="true" 
                                                OnTextChanged="txtBatchNo_TextChanged" Width="120px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="MFG. Date" Visible="false">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtMfgDate" runat="server" TextMode="Date" Width="120px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="EXP. Date">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtExpDate" runat="server" TextMode="Date" TabIndex='<%# Container.DataItemIndex+7 %>' Width="150px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="">
                                        <ItemTemplate>
                                            <asp:Button ID="btnGVReceive" runat="server" Text="Receive"
                                                CommandArgument='<%# Eval("PO_ID_Sub") %>' OnClick="btnGVReceive_Click" CausesValidation="false" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="QO_No" HeaderText="Quotation #" SortExpression="QO_No"
                                        Visible="False" />
                                    <asp:BoundField DataField="For_Customer" HeaderText="Customer" SortExpression="For_Customer"
                                        Visible="False" />
                                    <asp:BoundField DataField="Order_No" HeaderText="Order #" SortExpression="Order_No"
                                        Visible="False" />
                                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" SortExpression="Remarks"
                                        Visible="False" />
                                    <asp:TemplateField HeaderText="Detail" Visible="false">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lb_details" runat="server" CommandArgument='<%# Eval("PO_ID_Sub") %>'
                                                OnClick="lb_details_Click" Visible="false">View</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--  <asp:TemplateField HeaderText="Allow Serial">
                            <ItemTemplate>
                                <asp:CheckBox ID="CH_A_Serial" runat="server" AutoPostBack="True" Checked='<%# Bind("Allow_Serial") %>'
                                    OnCheckedChanged="CH_A_Serial_CheckedChanged" />
                                <asp:HiddenField ID="hf_item_code" runat="server" Value='<%# Eval("Item_Code") %>' />
                                <asp:HiddenField ID="hfPOSUBID" runat="server" Value='<%# Eval("PO_ID_Sub") %>' />

                            </ItemTemplate>
                        </asp:TemplateField>--%>
                                   <%-- <asp:TemplateField HeaderText="Select Location">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddl_Location"  TabIndex='<%# Container.DataItemIndex+8 %>' runat="server" DataSourceID="SDS_Location" DataTextField="Location" DataValueField="Location_ID">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:TemplateField>
                                        <HeaderTemplate>

                                            <asp:CheckBox ID="checkAll" runat="server" OnCheckedChanged="checkAll_CheckedChanged" AutoPostBack="true" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="checkboxRec" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="Wrong Receiving">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnk_WrongReceiving" runat="server" CommandArgument='<%# Eval("PO_ID_Sub") %>'
                                                OnClientClick="confirmationWrong();" OnClick="lnk_WrongReceiving_Click">Mark Wrong Receiving</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                </Columns>
                                <RowStyle CssClass="GridItem" />
                                <HeaderStyle CssClass="GridHeader" />
                                <AlternatingRowStyle CssClass="GridAltItem" />
                                <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SDS_Location" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="Select G.Godown_Name+'('+L.Location_Name+')' Location, l.Location_ID  from Godown G Inner Join GodownLocation L on g.Godown_ID = L.Godown_ID where G.Subdept_ID = @Subdept_ID" CancelSelectOnNullParameter="False">
                                <SelectParameters>
                                    <asp:ControlParameter Name="Subdept_ID" ControlID="DropDownListStore" PropertyName="SelectedValue" />
                                    <%--<asp:SessionParameter Name="Subdept_ID" SessionField="SubdeptID" />--%>
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <br />
                            <asp:HiddenField ID="HiddenFieldLocation" runat="server" />
                            <asp:HiddenField ID="HiddenFieldPOSub" runat="server" />
                            <asp:GridView ID="GV_Detail" runat="server" AutoGenerateColumns="False"
                                DataSourceID="SqlDataSource6">
                                <Columns>
                                    <asp:BoundField DataField="QTY" HeaderText="QTY" SortExpression="QTY" />
                                    <asp:BoundField DataField="For_Customer" HeaderText="For Customer"
                                        SortExpression="For_Customer" />
                                    <asp:BoundField DataField="Quotation" HeaderText="Quotation" SortExpression="Quotation" />
                                    <asp:BoundField DataField="Order" HeaderText="Order" SortExpression="BatchNo" />
                                    <asp:BoundField DataField="Item_Code" HeaderText="Item Code"
                                        SortExpression="Item_Code" />
                                    <asp:BoundField DataField="Detail" HeaderText="Detail" SortExpression="Detail" />
                                    <asp:BoundField DataField="Item_Name" HeaderText="Item Name"
                                        SortExpression="Item_Name" />
                                    <asp:BoundField DataField="For_Branch" HeaderText="For Branch"
                                        SortExpression="For_Branch" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
                                SelectCommand="Select Count(T.Item_Code) QTY,'' For_Customer, '' Quotation,Order_No [Order],T.Item_Code,'' Detail
	   ,I.Item_Name, '' For_Branch
From Store_Item_TagNo T INNER JOIN
	 Store_Items I On T.Item_Code=I.Item_Code
Where T.PO_ID_Sub=@PO_SubID
Group By Order_No,T.Item_Code,I.Item_Name"
                                UpdateCommand="UPDATE Store_Items SET Allow_Serial = @Allow_Serial WHERE (Item_Code = @Item_Code)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="HiddenField_POSubID" Name="PO_SubID" PropertyName="Value" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="HF_u_A_SERIAL" Name="Allow_Serial" PropertyName="Value" />
                                    <asp:ControlParameter ControlID="hf_item_code" Name="Item_Code" PropertyName="Value" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <asp:HiddenField ID="HiddenField_POSubID" runat="server" />
                            <br />

                            <asp:HiddenField ID="HiddenField_subID" runat="server" />
                            <asp:HiddenField ID="HF_u_A_SERIAL" runat="server" />
                            <br />
                            <asp:HiddenField ID="HiddenField_Serial_Allow" runat="server" />
                            <asp:HiddenField ID="hf_item_code" runat="server" />
                        </td>
                        
                    </tr>
                   
                </table>

            </div>

            <div class="bxmain col-md-4 col-md-offset-1" style="display: none;">
                <table cellpadding="0" cellspacing="0" width="30%" class="tbl_form">
                    <tr>
                        <td align="right">&nbsp;
                        </td>
                        <td>
                            <asp:CheckBox ID="Ck_Item_Detail" runat="server" AutoPostBack="True" OnCheckedChanged="Ck_Item_Detail_CheckedChanged"
                                Text="View Specification" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">&nbsp;
                        </td>
                        <td>
                            <asp:Panel ID="Pnl_Specificatiom" runat="server" Visible="False">
                                <table class="style1">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label_ItemDetail" runat="server"></asp:Label>
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Item Name :
                        </td>
                        <td>
                            <asp:Label ID="LabelItem" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Receive Qty :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_Receive_Qty" runat="server" CssClass="input_txt" AutoPostBack="True"
                                OnTextChanged="TextBoxReceiveQty_TextChanged">0</asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">MFG. Date:
                        </td>
                        <td>
                            <asp:TextBox ID="WebDateChooserMfg" runat="server" TextMode="Date"></asp:TextBox>
                            <%--  <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/calendar.gif"
                                    Height="20px" Width="20px" />
                                <asp:CalendarExtender ID="Calender1" runat="server" TargetControlID="WebDateChooserMfg"
                                    PopupButtonID="ImageButton1" Format="dd/MM/yyyy" PopupPosition="Right">
                                </asp:CalendarExtender>--%>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <span style="color: rgb(51, 51, 51); font-family: &quot; segoe ui&quot; , arial, sans-serif; font-size: 12px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; orphans: 2; text-align: -webkit-right; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(247, 247, 247); text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Batch #</span> :
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_Batch" runat="server" Text='<%# Bind("[Batch No]", "{0}") %>'
                                CssClass="input_txt" AutoPostBack="True" OnTextChanged="TextBoxBNo_TextChanged"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Expiry Date:
                        </td>
                        <td>
                            <asp:TextBox ID="WebDateChooser_EXP" runat="server" TextMode="Date"></asp:TextBox>
                            <%-- <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/calendar.gif"
                                    Height="20px" Width="20px" />
                                <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="WebDateChooser_EXP"
                                    PopupButtonID="ImageButton2" Format="dd/MM/yyyy" PopupPosition="Right" OnClientDateSelectionChanged="checkDate">
                                </asp:CalendarExtender>--%>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Other Information
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox_Pack" runat="server" Text='<%# Bind("[Packing Shape]", "{0}") %>'
                                CssClass="input_txt"></asp:TextBox>
                            <asp:TextBox ID="TextBox_Rate" runat="server" AutoPostBack="True" CssClass="input_txt"
                                Width="200px" Visible="False"></asp:TextBox>
                        </td>
                    </tr>
                </table>

                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_form">
                    <tr>
                        <td colspan="2">
                            <asp:HiddenField ID="HiddenField_OrderNo" runat="server" />
                            <asp:HiddenField ID="HiddenField_TagNo" runat="server" />
                            <asp:HiddenField ID="HiddenField_SerialID" runat="server" />
                            <asp:HiddenField ID="HiddenField_Quotation" runat="server" />
                            <br />
                            <asp:Button ID="ButtonSave" Style="margin-left: 10.4em;" runat="server" CssClass="btn1" OnClick="ButtonSave_Click"
                                Text="Save" />
                            <asp:Button ID="rollbackbtn" runat="server" Text="RollBack" CssClass="btn1" OnClick="rollbackbtn_Click" />
                            &nbsp;<asp:Button ID="Button_report" runat="server" Text="Tag Wise Report" OnClick="Button_report_Click"
                                Style="text-align: right" Visible="False" />
                            &nbsp;<asp:Button ID="Button_UpdateTag" runat="server" OnClick="Button_UpdateTag_Click"
                                Text="Update Tag #" Width="89px" Style="visibility: hidden; text-align: center" />
                            <br />
                            <asp:Button Style="visibility: hidden" ID="btn_report" runat="server" OnClick="btn_report_Click" Text="Receive Report" />

                            <asp:HyperLink ID="HYP_GRN" Style="visibility: hidden" runat="server" CssClass="tab_btn" NavigateUrl="~/store/PurchaseRecievingReport.aspx?RM_ID=" Target="_blank">Good Received Note</asp:HyperLink>
                            <asp:Button Style="visibility: hidden" ID="btnGenerateGRN" runat="server" Text="Generate GRN" OnClick="btnGenerateGRN_Click" />
                            <asp:Button Style="visibility: hidden" ID="btnGenerateGRNWithRate" runat="server" Text="Generate GRN With Rate" OnClick="btnGenerateGRNWithRate_Click" />
                            <br />
                            <asp:Button Style="visibility: hidden" ID="Button3_report" runat="server" OnClick="Button3_report_Click"
                                Text="Issue Report" Visible="False" />
                            <asp:Button Style="visibility: hidden" ID="btn_tag_wise_report" runat="server" OnClick="btn_tag_wise_report_Click"
                                Text="Tag Compare Report" Visible="False" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">&nbsp;
                        </td>
                        <td>
                            <asp:Button ID="Button6" runat="server" OnClick="Button6_Click" Text="Report To"
                                Visible="False" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style2">&nbsp;
                        </td>
                        <td></td>
                    </tr>
                </table>
            </div>



        </div>

    </div>


    <table style="display: none;">
        <tr>
            <td>

                <asp:Label ID="LBL_S_Order" runat="server" ForeColor="#003366"
                    Text="Enter Order #" Visible="False" Width="97px"></asp:Label>
                <asp:Label ID="lbl_S_O_S" runat="server" ForeColor="#003366"
                    Text="Starting Serial #" Visible="False" Width="92px"></asp:Label>
                <asp:Label ID="lbl_S_O_E" runat="server" ForeColor="#003366"
                    Text="Ending Serial #" Visible="False" Width="93px"></asp:Label>
                <br />
                <asp:TextBox ID="TextBox_MarkOrderNo" runat="server" Visible="False"
                    Width="143px"></asp:TextBox>
                <asp:TextBox ID="TextBox_FromSerial" runat="server" Visible="False"
                    Width="92px"></asp:TextBox>
                <asp:TextBox ID="TextBox_ToSerial" runat="server"
                    OnTextChanged="TextBox_ToSerial_TextChanged" Visible="False" Width="93px"></asp:TextBox>
                <asp:Button ID="Button_OrderNo" runat="server" OnClick="Button_OrderNo_Click"
                    Text="Order #" Visible="False" Width="95px" />
            </td>
            <td>
                <asp:Panel ID="pnlSerialSelection" CssClass="serialBox" runat="server" Visible="True">
                    <table>
                        <tr>
                            <td>Order #
                            </td>
                            <td>
                                <asp:TextBox ID="txtOrderForSerial" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Enter Serials
                            </td>
                            <td>
                                <asp:TextBox ID="txtSerialsForSelection" CssClass="input" Width="300px" Rows="4"
                                    runat="server" TextMode="MultiLine"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnSelectAllSerial" runat="server" Text="Serial #"
                                    OnClick="btnSelectAllSerial_Click" />
                                &nbsp;
                                    <asp:Button ID="btnClearSerial" runat="server" Text="Clear Serial #"
                                        OnClick="btnClearSerial_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblErrorMsg" CssClass="error" runat="server" Text="" Visible="false"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <asp:GridView ID="GridView_Detail" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceReceiveQtySub"
        OnSelectedIndexChanged="GridView_Detail_SelectedIndexChanged" Width="100%" OnDataBound="GridView_Detail_DataBound"
        ShowFooter="True" DataKeyNames="Serial_NO_ID" AllowPaging="True"
        PageSize="400">
        <Columns>
            <asp:TemplateField HeaderText="Sr. No.">
                <ItemTemplate>
                    <%# Container.DataItemIndex + 1 %>
                </ItemTemplate>
                <ItemStyle Width="50px"></ItemStyle>
            </asp:TemplateField>
            <asp:BoundField DataField="Item_Code" HeaderText="Item Code" SortExpression="Item_Code"></asp:BoundField>
            <asp:BoundField DataField="Item_Name" HeaderText="Item Name" SortExpression="Item_Name"></asp:BoundField>
            <asp:BoundField DataField="Mfg" HeaderText="Mfg" SortExpression="Mfg" ReadOnly="True"
                Visible="False"></asp:BoundField>
            <asp:BoundField DataField="Exp" HeaderText="Exp" SortExpression="Exp" ReadOnly="True"
                Visible="False"></asp:BoundField>
            <asp:BoundField DataField="Receive_Date" HeaderText="Receive_Date" SortExpression="Receive_Date"
                Visible="False" ReadOnly="True" />
            <asp:TemplateField HeaderText="LC_No" SortExpression="LC_No" Visible="False">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("LC_No") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("LC_No") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ID" SortExpression="ID" Visible="False">
                <ItemTemplate>
                    <asp:Label ID="lblID" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Quotation #" SortExpression="PR_NO" Visible="False">
                <ItemTemplate>
                    <asp:TextBox ID="TextBox_PR_NO" runat="server" Text='<%# Bind("PR_NO") %>'></asp:TextBox>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PR_NO") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Order #" SortExpression="SO_ID">
                <ItemTemplate>
                    <asp:TextBox ID="TextBox_OrderNo" runat="server" Text='<%# Bind("BatchNo") %>'
                        Enabled='<%# Eval("Enabled") %>'></asp:TextBox>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("SO_ID") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Serial / Tag #" SortExpression="Serial_No">
                <HeaderTemplate>
                    <asp:Label ID="Label_Head_tag" runat="server" Text="Serial /Tag #"></asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TextBox_TagNo" runat="server" Text='<%# Bind("Serial_NO_ID") %>'
                        Enabled='<%# Bind("Enabled") %>'></asp:TextBox>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Serial_No") %>' Enabled='<%# Bind("Allow_Serial") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Serial_NO_ID" InsertVisible="False" SortExpression="Serial_NO_ID"
                Visible="False">
                <ItemTemplate>
                    <asp:Label ID="LabelSerialId" runat="server" Text='<%# Bind("Serial_NO_ID") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Serial_NO_ID") %>' Enabled='<%# Eval("Allow_serial") %>'></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Sub_Id" InsertVisible="False" SortExpression="Sub_Id"
                Visible="False">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("Sub_Id") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("Sub_Id") %>'></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Specification">
                <ItemTemplate>
                    <asp:LinkButton ID="LB_Specification" runat="server" CommandArgument='<%# Eval("Item_Name") %>'
                        OnClick="LB_Specification_Click">Add</asp:LinkButton>
                    <asp:HiddenField ID="HF_Item_Code" runat="Server" Value='<%# Eval("Item_Code") %>'></asp:HiddenField>
                    <asp:TextBox ID="TXT_Specification" runat="server" SkinID="txt_height" TextMode="MultiLine"
                        Visible="False"></asp:TextBox>
                    <br />
                    <asp:Button ID="Btn_Update" runat="server" OnClick="Btn_Update_Click" Text="Save"
                        Visible="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:HiddenField runat="server" ID="hdfID" />
    &nbsp;<br />
    <asp:SqlDataSource ID="SqlDataSource_RO" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT IB_ID, InvoiceNo, CONVERT (varchar, Receive_Date, 103) AS Receive_Date, Store_Receive_Main_ID, IS_RO_Completed  FROM Store_Item_Received_Main WHERE (IB_ID = @IB_ID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="IB_ID" QueryStringField="PO_ID" Size="50" />
        </SelectParameters>
    </asp:SqlDataSource>

    <br />
    <asp:SqlDataSource ID="SqlDataSource_RO_Detail" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="[Select_Store_Purchase_Receive_Order]"
        SelectCommandType="StoredProcedure" InsertCommand="INSERT_Store_Item_Received_Serial_No"
        InsertCommandType="StoredProcedure" OnInserted="SqlDataSource_RO_Detail_Inserted">
        <InsertParameters>
            <asp:Parameter DefaultValue="0" Name="Sub_ID" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="Serial_No" Type="String" />
            <asp:Parameter DefaultValue="" Direction="Output" Name="Identity" Type="Int32" />
            <asp:Parameter DefaultValue="0" Name="SO_ID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="IB_ID" QueryStringField="PO_ID" Size="50" Type="String" />
            <asp:ControlParameter ControlID="HiddenField_RO_MID" DefaultValue="0" Name="Store_Receive_Main_ID"
                PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:HiddenField ID="HiddenField_RO_MID" runat="server" />
    <br />
    <asp:SqlDataSource ID="SqlDataSource_POEntry" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_DatalistTaxDis" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT     Tax_Discount_HeadDetail.Tax_Name, PO_Tax_Discount.Tax_ID, Tax_Discount_HeadDetail.Account_Head_ID, PO_Tax_Discount.Amount&#13;&#10;FROM         PO_Tax_Discount INNER JOIN&#13;&#10;                      Tax_Discount_HeadDetail ON PO_Tax_Discount.Tax_ID = Tax_Discount_HeadDetail.Tax_Id&#13;&#10;WHERE     (PO_Tax_Discount.PO_ID = @PO_ID)"
        UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="PO_ID" QueryStringField="PO_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSource_Receive_Qty" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" InsertCommand="[Insert_Store_Item_Receive_Main]"
        InsertCommandType="StoredProcedure" OnInserted="SqlDataSourceReceiveQty_Inserted">
        <InsertParameters>
            <asp:QueryStringParameter Name="IB_ID" QueryStringField="PO_ID" Type="String" />
            <asp:SessionParameter Name="Receive_Dept_Id" SessionField="dept_id" Type="Int32" />
            <asp:SessionParameter Name="Receive_Emp_Id" SessionField="emp_id" Type="Int32" />
            <asp:SessionParameter Name="Receive_Sub_dept_Id" SessionField="SubDeptID" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldReceive_Main_id" Direction="InputOutput"
                Name="Receive_Main_ID" PropertyName="Value" Type="Int32" />
            <asp:SessionParameter Name="ShiftID" SessionField="ShiftID" Type="Int32" />
            <asp:ControlParameter ControlID="TextBox_invoice_NO" Name="InvoiceNo" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_Inv_No" Direction="InputOutput" Name="Inv_No"
                PropertyName="Value" Size="50" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldReceive_Main_id" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceReceiveQtySub" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        InsertCommand="Insert_Store_Item_Receive_Sub_ByPO"
        InsertCommandType="StoredProcedure" UpdateCommand="[Update_SerialNo]"
        UpdateCommandType="StoredProcedure"
        SelectCommand="usp_SelectStoreItemTagNo" SelectCommandType="StoredProcedure">
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldReceive_Main_id" Name="Store_Receive_Main_ID"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Item_ID" Name="Item_Code" PropertyName="Value" />

            <asp:ControlParameter ControlID="HiddenField_Recieve_Qty" Name="Item_Qty" PropertyName="Value" />
            <asp:ControlParameter ControlID="hdfBatchNo" Name="BatchNo" PropertyName="Value"
                DefaultValue="Null" />
            <asp:QueryStringParameter Name="PO_ID" QueryStringField="PO_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="HiddenField_Exp" Name="exp" PropertyName="Value"
                Type="DateTime" />
            <asp:ControlParameter ControlID="HiddenField_Mfg_Date" Name="Mfg" PropertyName="Value"
                DefaultValue="" />
            <asp:ControlParameter ControlID="TextBox_Pack" Name="Pack" PropertyName="Text" />
            <asp:SessionParameter Name="Dept_ID" SessionField="Dept_ID" Type="Int32" />
            <asp:SessionParameter Name="Sub_Dept_ID" SessionField="SubDeptId" Type="Int32" />
            <asp:SessionParameter Name="Designation_Id" SessionField="DesignationID" Type="Int32" />
            <asp:SessionParameter Name="By_Emp_Id" SessionField="emp_id" Type="Int32" />
            <asp:ControlParameter ControlID="HiddenFieldPOSub" Name="POSub_ID" PropertyName="Value" Type="Int32" />
            <asp:ControlParameter ControlID="hdfSalePrice" Name="SalePrice" PropertyName="Value" Type="Decimal" />
            <asp:ControlParameter ControlID="hdfAdvanceTax" Name="Advance Tax" PropertyName="Value" Type="Decimal" />
            <asp:ControlParameter ControlID="HiddenFieldLocation" Name="LocationID" PropertyName="Value" Type="Int32" />
            <asp:Parameter Name="AdvanceTax" Type="Double" />
        </InsertParameters>

        <SelectParameters>
            <asp:ControlParameter ControlID="GridView2" Name="ItemCode" PropertyName="SelectedValue" />
            <asp:QueryStringParameter Name="PO_ID" QueryStringField="PO_ID" />
            <asp:SessionParameter Name="Receive_Sub_dept_Id" SessionField="SubDeptID" />
        </SelectParameters>

        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_SerialID" Name="Serial_NO_ID" PropertyName="Value"
                Type="Decimal" />
            <asp:ControlParameter ControlID="hdfID" Name="ID" PropertyName="Value"
                Type="Decimal" />
            <asp:ControlParameter ControlID="HiddenField_TagNo" Name="Serial_No" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_OrderNo" Name="BatchNo" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_Quotation" Name="PR_NO" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_Lc_No" Name="LC_No" PropertyName="Text"
                Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceUpdateRate" runat="server" UpdateCommand="UPDATE Purchase_Order_Sub SET Rate = @Rate WHERE (Item_Code = @Item_Code) AND (PO_ID = @PO_ID)"
        ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>" ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>">
        <UpdateParameters>
            <asp:ControlParameter ControlID="TextBox_Rate" Name="Rate" PropertyName="Text" />
            <asp:ControlParameter ControlID="GridView2" Name="Item_Code" PropertyName="SelectedValue" />
            <asp:QueryStringParameter Name="PO_ID" QueryStringField="PO_ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource_Update_PO" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" UpdateCommand="UPDATE Purchase_Order_Main SET Order_Complete = 1 WHERE (PO_ID = @PO_ID)">
        <UpdateParameters>
            <asp:QueryStringParameter Name="PO_ID" QueryStringField="PO_ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Mfg_Date" runat="server" />
    <asp:HiddenField ID="HiddenField_Batch" runat="server" />
    <asp:HiddenField ID="HiddenField_Exp" runat="server" />
    <asp:HiddenField ID="hdfSalePrice" runat="server" />
     <asp:HiddenField ID="hdfAdvanceTax" runat="server" />

    <asp:SqlDataSource ID="SqlDataSource_PO" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="usp_GetPOItemsForReceiving_new"
        SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE Purchase_Order_Main SET Status = @Status, Recieve_By_Emp_ID = @Recieve_By_Emp_ID, Recieve_By_Dept_ID = @Recieve_By_Dept_ID, Recieve_Date_Time = GETDATE(), Recieve_Invoice_NO = @Recieve_Invoice_NO, Amount = @Amount WHERE (PO_ID = @PO_ID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="PO_ID" QueryStringField="PO_ID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter DefaultValue="true" Name="Status" />
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="Recieve_By_Emp_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_Dept_ID" DefaultValue="" Name="Recieve_By_Dept_ID"
                PropertyName="Value" />
            <asp:ControlParameter ControlID="TextBox_invoice_NO" DefaultValue="" Name="Recieve_Invoice_NO"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_amount" DefaultValue="" Name="Amount" PropertyName="Text" />
            <asp:QueryStringParameter Name="PO_ID" QueryStringField="&quot;PO_ID&quot;" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Item_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_IB_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Recieve_Qty" runat="server" />
    <asp:HiddenField ID="HiddenFieldStore__issue_Main_id" runat="server" />
    <asp:HiddenField ID="HiddenField_PO_No" runat="server" />
    <asp:HiddenField ID="HiddenFieldStore__issue_id" runat="server" />
    <asp:HiddenField ID="HiddenField_PO_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Inv_No" runat="server" />
    <asp:HiddenField ID="hdfBatchNo" runat="server" />
    <asp:HiddenField ID="HF_Stock_Item_code" runat="server" />
    <asp:HiddenField ID="HF_Stock_Order" runat="server" />
    <asp:HiddenField ID="HF_Stock_Serial" runat="server" />
    <asp:HiddenField ID="HF_Stock_Specification" runat="server" />
    <asp:SqlDataSource ID="Sql_Stock_Specification" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT [Account_Title] FROM [Account_Titles]"
        UpdateCommand="Stock_Item_Specification_updation" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HF_Stock_Specification" Name="Specification" PropertyName="Value" />
            <asp:QueryStringParameter Name="PO_NO" QueryStringField="PO_ID" />
            <asp:SessionParameter Name="Modified_By" SessionField="EMP_ID" />
            <asp:SessionParameter Name="Modified_by_dept" SessionField="dept_id" />
            <asp:ControlParameter ControlID="HF_Stock_Item_code" Name="Item_Code" PropertyName="Value" />
            <asp:ControlParameter ControlID="HF_Stock_Order" Name="Order_No" PropertyName="Value" />
            <asp:ControlParameter ControlID="HF_Stock_Serial" Name="Serial_NO" PropertyName="Value" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" InsertCommand="INSERT INTO Purchase_Order_Documents(PO_ID, File_Header, File_Url, Delivery_Challan_No, Lc_No) VALUES (@PO_ID, @File_Header, @File_Url, @Delivery_Challan_No, @Lc_No)"
        SelectCommand="SELECT File_Header, File_Url FROM Purchase_Order_Documents WHERE (PO_ID = @PO_ID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="PO_ID" QueryStringField="PO_ID" />
        </SelectParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="PO_ID" QueryStringField="PO_ID" />
            <asp:ControlParameter ControlID="HiddenField_File_Header" Name="File_Header" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenField_file_URL" Name="File_Url" PropertyName="Value" />
            <asp:ControlParameter ControlID="TextBox_invoice_NO" Name="Delivery_Challan_No" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_Lc_No" Name="Lc_No" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        DeleteCommand="DELETE FROM [Purchase_Order_Documents] WHERE [PO_ID] = @PO_ID AND [File_Header] = @File_Header"
        InsertCommand="INSERT INTO Purchase_Order_Documents(PO_ID, File_Header, File_Url, Delivery_Challan_No, Lc_No) VALUES (@PO_ID, @File_Header, @File_Url, @Delivery_Challan_No, @Lc_No)"
        SelectCommand="SELECT [PO_ID], [File_Header], [File_Url] FROM [Purchase_Order_Documents] WHERE ([PO_ID] = @PO_ID)"
        UpdateCommand="UPDATE [Purchase_Order_Documents] SET [File_Url] = @File_Url WHERE [PO_ID] = @PO_ID AND [File_Header] = @File_Header">
        <DeleteParameters>
            <asp:Parameter Name="PO_ID" Type="String" />
            <asp:Parameter Name="File_Header" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="File_Url" Type="String" />
            <asp:Parameter Name="PO_ID" Type="String" />
            <asp:Parameter Name="File_Header" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="PO_ID" QueryStringField="PO_ID" Type="String" />
        </SelectParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenField_PO_ID" Name="PO_ID" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_File_Header" Name="File_Header" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="HiddenField_file_URL" Name="File_Url" PropertyName="Value"
                Type="String" />
            <asp:ControlParameter ControlID="TextBox_invoice_NO" Name="Delivery_Challan_No" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox_Lc_No" Name="Lc_No" PropertyName="Text" />
        </InsertParameters>
    </asp:SqlDataSource>



    <asp:Panel ID="pnlSerialDetails" runat="server" Visible="False">
        <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            SelectCommand="SELECT     Store_Items.Item_Name, Store_Item_Received_Sub.Item_Code, Store_Item_Received_Serial_No.Serial_No, Store_Item_Received_Serial_No.SO_ID
FROM         Store_Item_Received_Sub INNER JOIN
                      Store_Items ON Store_Item_Received_Sub.Item_Code = Store_Items.Item_Code INNER JOIN
                      Store_Item_Received_Serial_No ON Store_Item_Received_Sub.Sub_Id = Store_Item_Received_Serial_No.Sub_ID
"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource_JV_Finance" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
            InsertCommand="JV_Received_PO_Office_Voucher" InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:QueryStringParameter Name="PO_ID" QueryStringField="PO_ID" Type="Decimal" />
                <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="By_Emp_Id" PropertyName="Value"
                    Type="Int32" />
                <asp:SessionParameter Name="Designation_Id" SessionField="DesignationId" Type="Int32" />
                <asp:ControlParameter ControlID="HiddenField_Dept_ID" Name="By_Dept_Id" PropertyName="Value"
                    Type="Int32" />
                <asp:SessionParameter Name="By_SubDept_Id" SessionField="SubDeptId" Type="Int32" />
                <asp:ControlParameter ControlID="HiddenFieldReceive_Main_id" Name="Received_Main_Id"
                    PropertyName="Value" Type="Decimal" />
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
        <br />
        <asp:Label ID="lblItemSerialMessage" runat="server" Font-Bold="True"></asp:Label>
    </asp:Panel>

</asp:Content>
