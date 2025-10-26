<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Blood_Bank_BloodBagDispose, App_Web_k10uyj0r" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="blood_wrap" style="margin-left: 280px">
        <div class="bxmain inner_content">
            <h2><span style="font-size: 25px !important">Blood Bag Dispose</span></h2>
            <table cellpadding="0" cellspacing="0" border="0" class="tbl_form">
                <tr style="margin-top: 20px">
                    <td align="right"><b>Bag No :</b></td>
                    <td>
                        <asp:TextBox ID="TextBox_Bag_No" Placeholder="P-20170517-4" runat="server" CssClass="input_txt" Width="175px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnDispose" runat="server" OnClick="btnDispose_Click" Text="Dispose" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>

