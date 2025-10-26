<%@ Page Language="VB" AutoEventWireup="false" Inherits="Store_UpdatePurchaseOrder"
    CodeFile="UpdatePurchaseOrder.aspx.vb" MasterPageFile="~/hacims_masterpage_admin.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        $(document).ready(function () {
            $(".openlink").colorbox({ width: "960px", height: "580px", iframe: true });
            $(".openlinline").colorbox({ width: "50%", inline: true, href: "#showit" });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="inner_content" style="width: 100%;">
        <h2>
            <span>Approve Purchase Order</span></h2>
    </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%"
        DataSourceID="SqlDataSource3" EnableModelValidation="True" EmptyDataText="No Record(s) Found.">
        <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
        <Columns>
            <asp:ButtonField CommandName="Purchase" DataTextField="PO_ID" HeaderText="Purchase Order No."
                SortExpression="PO_ID">
                <ControlStyle CssClass="openinline" />
            </asp:ButtonField>
            <asp:BoundField DataField="PO_ID" HeaderText="PO_ID" ReadOnly="True" SortExpression="PO_ID" />
            <asp:BoundField DataField="Account_Title" HeaderText="Company Name" SortExpression="Account_Title" />
            <asp:BoundField DataField="Order Date Time" HeaderText="Order Date Time" SortExpression="Order Date Time" />
            <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject" Visible="false" />
            <asp:CheckBoxField DataField="FAC_Complete" HeaderText="FAC_Complete" SortExpression="FAC_Complete"
                Visible="False" />
            <asp:HyperLinkField DataNavigateUrlFields="PO_ID" DataNavigateUrlFormatString="PurchaseOrderDetail.aspx?PO_ID={0}"
                HeaderText="Distribution Detail" Target="_blank" Text="Add" Visible="false" />
            <asp:HyperLinkField DataNavigateUrlFields="PO_ID" DataNavigateUrlFormatString="PurchaseOrder.aspx?PO_ID={0}"
                HeaderText="Edit PO" Target="_blank" Text="Edit"  />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkApprove" runat="server" Text="Approve" CommandArgument='<%# Eval("PO_ID") %>'
                         OnClick="lnkApprove_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkReject" runat="server" Text="Reject" CommandArgument='<%# Eval("PO_ID") %>'
                          OnClick="lnkReject_Click"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="GridItem" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT 
                      Purchase_Order_Main.PO_ID, CONVERT(varchar, Purchase_Order_Main.Date_Time, 105) AS [Order Date Time], Purchase_Order_Main.Subject, 
                      Purchase_Order_Main.FAC_Complete, Purchase_Order_Main.Tender_Id, AT_View.Account_Title
FROM         Purchase_Order_Main INNER JOIN
                          (SELECT     Account_No, Account_Title
                            FROM          Account_Titles
                            WHERE      (Entity_Type_Id = 2)) AS AT_View ON Purchase_Order_Main.Company_ID = AT_View.Account_No
WHERE     (Purchase_Order_Main.Status = 0) AND (Purchase_Order_Main.Dept_ID = @Dept_ID) AND (Purchase_Order_Main.FAC_Complete = 0) AND 
                      (Purchase_Order_Main.SubDept_ID = @SubDept_ID)
					  order by Purchase_Order_Main.PO_ID desc">
        <SelectParameters>
            <asp:SessionParameter Name="Dept_ID" SessionField="Dept_ID" />
            <asp:SessionParameter Name="SubDept_ID" SessionField="SubDeptID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <div>
        <div id="showit">
            <asp:ImageButton ID="ImageButton1" runat="server" Visible="False" ImageUrl="~/images/img_error.png" />
            <asp:GridView ID="GridViewPurchaseDetail" runat="server" AutoGenerateColumns="False"
                DataSourceID="SqlDataSourcePurchaseDetail" Width="100%" Visible="false">
                <Columns>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:LinkButton ID="lnkEditPO" runat="server" Text="Edit" OnClick="lnkEditPO_Click"
                                 CommandArgument='<%# Eval("PO_ID") %>'  Font-Bold="true" style="color:blue !important;"></asp:LinkButton>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblPONO" runat="server" Text='<%# Eval("PO_ID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="From Department" HeaderText="From Department" SortExpression="From Department" />
                    <asp:BoundField DataField="From Department" HeaderText="From Department" SortExpression="From Department" />
                    <asp:BoundField DataField="Item Name" HeaderText="Item Name" SortExpression="Item Name" />
                    <asp:BoundField DataField="Qty" HeaderText="Qty" SortExpression="Qty" />
                    <asp:BoundField DataField="Company_Name" HeaderText="Company Name" SortExpression="Company_Name" />
                    <asp:BoundField DataField="Rate" HeaderText="Rate" SortExpression="Rate" />
                </Columns>
                <HeaderStyle CssClass="GridHeader" />
                <AlternatingRowStyle CssClass="GridAltItem" />
            </asp:GridView>
        </div>
    </div>
    <asp:HiddenField ID="HiddenField_status" runat="server" />
    <asp:HiddenField ID="HiddenField_Tender_ID" runat="server" />
    <asp:HiddenField ID="HiddenField1" runat="server" />
    <asp:HiddenField ID="HiddenField2" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourcePurchaseDetail" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" SelectCommand="uspGetPurchaseOrderDetail"
         SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenFieldPO_ID" Name="PO_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField_Member_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Dept_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_Emp_ID" runat="server" />
    <asp:SqlDataSource ID="SqlDataSourceUpdatePurchaseOrder" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" UpdateCommand="uspPurchaseApproval"
        UpdateCommandType="StoredProcedure"
        InsertCommand="JV_Purchase_Voucher" InsertCommandType="StoredProcedure" SelectCommand="JV_Purchase_Voucher"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenFieldPO_ID" Name="PO_ID" PropertyName="Value"
                Type="Decimal" />
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="By_Emp_Id" PropertyName="Value"
                Type="Int32" />
            <asp:SessionParameter Name="Designation_Id" SessionField="DesignationID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenField_FAC" Name="FAC" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenFieldPO_ID" Name="PO_ID" PropertyName="Value" />
            <asp:Parameter Name="Approval_Remarks" Type="String" />
            <asp:Parameter Name="Subject" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter ControlID="HiddenFieldPO_ID" Name="PO_ID" PropertyName="Value"
                Type="Decimal" />
            <asp:ControlParameter ControlID="HiddenField_Emp_ID" Name="By_Emp_Id" PropertyName="Value"
                Type="Int32" />
            <asp:SessionParameter Name="Designation_Id" SessionField="DesignationID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenFieldPO_ID" runat="server" />
    <asp:HiddenField ID="HiddenField_FAC" runat="server" />
    <br />
    <asp:SqlDataSource ID="SqlDataSource_PurchaseOrderDiscount" runat="server" ConnectionString="<%$ ConnectionStrings:STOREConnectionString %>"
        ProviderName="<%$ ConnectionStrings:STOREConnectionString.ProviderName %>" UpdateCommand="Update_Purchase_Order_Discount"
        UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:ControlParameter ControlID="HiddenFieldPO_ID" Name="PO_ID" PropertyName="Value"
                Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <div align="center">
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Back to Main"
            Visible="False" /></div>
    <asp:Panel ID="pnlRemarks" runat="server" CssClass="lightbox" Visible="false">
        <div class="inner_content" style="width:100%;">
            <h2><asp:Label ID="lblPanelHeading" runat="server"></asp:Label></h2>
            <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
                <tr>
                    <td align="right" width="30%">
                        PO # : 
                    </td>
                    <td align="left" width="70%">
                        <asp:Label ID="lblPONo" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="30%">
                        Remarks : 
                    </td>
                    <td align="left" width="70%">
                        <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <td align="center" colspan="2">
                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" />
                        <asp:Button ID="btnClose" runat="server" Text="Close" OnClick="btnClose_Click" />
                        <br />
                        <asp:Label ID="lblMsg" runat="server" Text="" Visible="false" Font-Bold="true"></asp:Label>

                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
</asp:Content>
