<%@ page language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Store_Received_Tag_No, App_Web_tnnmgguv" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="cr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" class="tbl_form" width="100%">
        <tr>
            <td align="right" width="50%">
                <asp:Button ID="btn_Report" runat="server" Text="Show Report" OnClick="btn_Report_Click" />
            </td>
            <td align="left" width="50%">
                <asp:Button ID="btnGrid" runat="server" Text="Show Grid" OnClick="btnGrid_Click" />
                
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <asp:GridView ID="gvPoItems" runat="server" AutoGenerateColumns="false" Width="100%"
                    CssClass="Grid_1">
                    <AlternatingRowStyle CssClass="GridAltItem" />
                    <RowStyle CssClass="GridItem" />
                    <FooterStyle BorderColor="#C0C0FF" CssClass="GridPager" />
                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                    <HeaderStyle CssClass="GridHeader" />
                    <Columns>
                        <asp:BoundField DataField="Expr1" HeaderText="PO #" SortExpression="Expr1" />
                        <asp:BoundField DataField="Item_Name" HeaderText="Item Name" SortExpression="Item_Name" />
                        <asp:BoundField DataField="Order_No" HeaderText="Order #" SortExpression="Order_No" />
                        <asp:BoundField DataField="Serial_Tag_No" HeaderText="Serial Tag #" SortExpression="Serial_Tag_No" />
                        <asp:TemplateField HeaderText="Received Note" ItemStyle-Width="350px">
                        <HeaderTemplate>
                            Receive Notes / <asp:LinkButton ID="lnkUpdateNotes" runat="server" 
                                Text="Update Notes" onclick="lnkUpdateNotes_Click"></asp:LinkButton>
                        </HeaderTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtNote" runat="server" Width="340px" Text='<%# Eval("Remarks") %>'></asp:TextBox>
                                <asp:HiddenField ID="hdfID" runat="server" Value='<%# Eval("ID") %>' />
                                <asp:HiddenField ID="hdfSubID" runat="server" Value='<%# Eval("Sub_ID") %>' />
                                <asp:HiddenField ID="hdfSerialId" runat="server" Value='<%# Eval("Serial_NO_ID") %>' />
                                <asp:HiddenField ID="hdfItemCode" runat="server" Value='<%# Eval("Item_Code") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:CheckBox ID="chkReturnAll" runat="server" Width="20px" Height="20px" AutoPostBack="true"
                                    OnCheckedChanged="chkReturnAll_CheckedChanged" />
                                ( <asp:LinkButton ID="lnkReturnAll" runat="server" Text="Return" 
                                    onclick="lnkReturnAll_Click" ></asp:LinkButton> )
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkReturn" runat="server" Width="20px" Height="20px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
                    DisplayToolbar="False" EnableDatabaseLogonPrompt="False" EnableParameterPrompt="False" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="HiddenField_PO_ID" runat="server" />
    <asp:HiddenField ID="hdfConsumptionID" runat="server" Value="0" />
</asp:Content>
