<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_POWiseGRN, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="bxmain inner_content" style="width: 100%;">
        <h2><span>PO wise GRN List</span></h2>
        <asp:GridView ID="gvGRN" runat="server" AutoGenerateColumns="false" Width="100%" CssClass="Grid_1"
            EmptyDataText="No Record(s) Found">
            <AlternatingRowStyle CssClass="GridAltItem" />
            <RowStyle CssClass="GridItem" />
            <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
            <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
            <HeaderStyle CssClass="GridHeader" />
            <Columns>
                <asp:TemplateField HeaderText="Sr. #">
                    <ItemTemplate>
                        <%#Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="GRN_No" HeaderText="GRN #" />
                <asp:BoundField DataField="IB_ID" HeaderText="PO #" />
                <asp:BoundField DataField="Receive_Date" HeaderText="Date" />
                <asp:BoundField DataField="ReceiveBy" HeaderText="Receive By" Visible="false" />
                <asp:BoundField DataField="DC_Inv" HeaderText="DC / Inv #" />
                <asp:BoundField DataField="POQTY" HeaderText="PO QTY" />
                <asp:BoundField DataField="TotalReceivedQty" HeaderText="Received QTY" />
                <asp:HyperLinkField DataNavigateUrlFields="Store_Receive_Main_ID,IB_ID" Target="_blank" Text="GRN Report"
                    DataNavigateUrlFormatString="PurchaseRecievingReport.aspx?RM_ID={0}&PO_ID={1}" />
                <asp:HyperLinkField DataNavigateUrlFields="Store_Receive_Main_ID,IB_ID" Target="_blank" Text="GRN With Rate Report"
                    DataNavigateUrlFormatString="PurchaseRecievingQty_RateReport.aspx?RM_ID={0}&PO_ID={1}" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

