<%@ page language="C#" autoeventwireup="true" masterpagefile="~/hacims_masterpage_admin.master" inherits="Patient_Billing_PatientAdances_ServicesHistory, App_Web_okqm0ubs" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script type="text/javascript">
    $(document).bind("keyup keydown", function (e) {
        if (e.ctrlKey && e.keyCode == 80) {
            return false;
        }
    });
</script>
<style type="text/css" media="print">
    * { display: none; }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="text-align:center;color:Red;font-size:13px; font-weight:bold;">This report is only for view not for printing.</div>
    <div class="bxmain inner_content" style="width: 100%; margin-bottom: 5px;">
        <h2>
            <span>Patient Balance</span></h2>
        <table width="100%">
            <tr>
                <td width="33%" align="center">
                    <asp:Label Text="BALANCE: " runat="server"  Font-Size="XX-Large" />
                    <asp:Label runat="server" Text="0" ID="lblTotalBalance" Font-Bold="true" Font-Size="XX-Large"></asp:Label>
                </td>
                <td width="33%" align="center">
                    <asp:Label Text="ADVANCE: " runat="server"  Font-Size="XX-Large"  />
                    <asp:Label runat="server" Text="0" ID="lbltotalAdvances" Font-Bold="true" Font-Size="XX-Large"></asp:Label>
                </td>
                <td width="33%" align="center">
                    <asp:Label Text="UNPAID: " runat="server"  Font-Size="XX-Large"  />
                    <asp:Label runat="server" Text="0" ID="lblTotalUnPaid" Font-Bold="true" Font-Size="XX-Large"></asp:Label>
                </td>
                
            </tr>
        </table>
    </div>
    <table width="100%">
        <tr>
            <td width="65%">

                <div class="bxmain inner_content" style="width: 100%">
                    <h2><span>Unpaid Services</span></h2>
                </div>
                <asp:GridView runat="server" CssClass="Grid_1" ID="GridView_UnpaidServices" ShowFooter="True" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" EmptyDataText="No Unpaid Service(s) Found">
                    <Columns>
                        <asp:TemplateField HeaderStyle-Width="20" ItemStyle-Width="20">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Service">
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("S_Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date" HeaderStyle-Width="150" ItemStyle-Width="150">

                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("sdatetime") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label Text="Total" ID="lblUnpaid" runat="server" Font-Bold="true" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount" HeaderStyle-Width="150" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label Text="" ID="lblTotalUnPaidAmount" runat="server" Font-Bold="true" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Discount" HeaderStyle-Width="150" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Discount") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label Text="" ID="lblTotalUnPaidDiscount" runat="server" Font-Bold="true" />
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <div class="bxmain inner_content" style="width: 100%;visibility:hidden">
                    <h2><span>Paid Services</span></h2>
                </div>
                <asp:GridView runat="server" CssClass="Grid_1" Visible="false" ID="GridView_PaidServices" ShowFooter="True" AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" EmptyDataText="No Paid Service(s) Found">
                    <Columns>
                        <asp:TemplateField HeaderStyle-Width="20" ItemStyle-Width="20">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Service" DataField="S_Name" />
                        <asp:TemplateField HeaderText="Date" HeaderStyle-Width="150" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("sdatetime") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label Text="Total" ID="lblpaid" runat="server" Font-Bold="true" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount" HeaderStyle-Width="150" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label Text="" ID="lblTotalPaidAmount" runat="server" Font-Bold="true" />
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Discount" HeaderStyle-Width="150" ItemStyle-Width="150">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Discount") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label Text="" ID="lblTotalPaidDiscount" runat="server" Font-Bold="true" />
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
            <td width="5%"></td>
            <td width="30%" valign="top">
                <div class="bxmain inner_content" style="width: 100%">
                    <h2><span>Advances Detail</span></h2>
                </div>
                <asp:GridView runat="server" CssClass="Grid_1" ID="GridView_Advances" AutoGenerateColumns="False" ShowFooter="true" ShowHeaderWhenEmpty="true" EmptyDataText="No Advance(s) Found">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.#">
                            <ItemTemplate>
                                <%# Container.DataItemIndex+1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Pay_DateTime") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label runat="server" ID="advance" Text="Total Advances" Font-Bold="true"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label runat="server" ID="totalAdvance" Text="" Font-Bold="true"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
    <asp:GridView runat="server" CssClass="Grid_1" ID="GridView_BillingParties" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <%# Container.DataItemIndex+1 %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Party Name" DataField="Party_Name" />
            <asp:BoundField HeaderText="Party Phone" DataField="Party_Phone" />
            <asp:BoundField HeaderText="Contact Person" DataField="Contact_Person_Name" />
        </Columns>
    </asp:GridView>
</asp:Content>
