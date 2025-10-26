<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_Demad_GenerateGRN, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="bxmain inner_content" style="width:100%; margin-bottom:5px;">
        <h2><span>Generate Good Received Note</span></h2>
        <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
            <tr>
                 <td align="right" width="25%">Delivery Challan #</td>
                <td align="left" width="25%">
                    <asp:TextBox ID="txtDCNumber" runat="server"></asp:TextBox>
                </td>
                <td align="right" width="25%">Invoice #</td>
                <td align="left" width="25%">
                    <asp:TextBox ID="txtInvNumber" runat="server"></asp:TextBox>
                </td>

            </tr>
        </table>
    </div> 
    <asp:GridView ID="gvReceivedItems" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="Item_Code" HeaderText="Item_Code" SortExpression="Item_Code" />
            <asp:BoundField DataField="Sub_Id" HeaderText="Sub_Id" SortExpression="Sub_Id" Visible="false" />
            <asp:BoundField DataField="Item_Name" HeaderText="Rate" SortExpression="Rate" />
            <asp:BoundField DataField="Specification" HeaderText="Specification" SortExpression="Specification" />
            <asp:BoundField DataField="PO_ID_Sub" HeaderText="PO_ID_Sub" SortExpression="PO_ID_Sub" Visible="False" />
            <asp:BoundField DataField="POQty" HeaderText="PO Qty" SortExpression="POQty" />
            <asp:BoundField DataField="RecQty" HeaderText="Received Qty" SortExpression="RecQty" />
            <asp:BoundField DataField="BalanceQty" HeaderText="Balance" SortExpression="BalanceQty" />
        </Columns>
    </asp:GridView>
</asp:Content>
