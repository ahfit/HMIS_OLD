<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Blood_Bank_ExpiredBloodDetail, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager runat="server" ID="ScriptManager1" />
    <div class="blood_wrap" style="width:100%">
        <div class="bxmain inner_content" style="width:100%">
            <h2><span style="font-size: 25px !important">Expired Blood Bags Detail</span></h2>
            <table cellpadding="0" cellspacing="0" border="0" class="tbl_form">
                <tr align="right">
                    <td>
                    </td>
                    <td>
                        <asp:Button ID="btnExpired_All_Blood" runat="server" Text="Expire All Blood" onClick="btnExpired_All_Blood_Click"/>
                    </td>
                </tr>
            </table>
            <hr />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:TemplateField HeaderText="Product_Formation_Id">
                    <ItemTemplate>
                        <asp:Label ID="lbl_PF_ID" runat="server" Text='<%# Bind("Product_Formation_Id") %>' ToolTip='<%# Bind("Product_Formation_Id") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Blood_Group" HeaderText="Blood Group" />
                <asp:BoundField DataField="Bag_No" HeaderText="Bag No" />
                <asp:BoundField DataField="Bag_Name" HeaderText="Bag Name" />
                <asp:BoundField DataField="Component_Name" HeaderText="Component Name" />
                <asp:BoundField DataField="Product_Formation_Status" HeaderText="Product_Formation_Status" />
                <asp:BoundField DataField="Formation_DateTime" HeaderText="Formation_DateTime" />
                <asp:BoundField DataField="Expiry_DateTime" HeaderText="Expiry_DateTime" />

            </Columns>
        </asp:GridView>
         
    </div>
</asp:Content>

