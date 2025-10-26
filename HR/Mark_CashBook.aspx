<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="HR_Mark_CashBook, App_Web_5t2nflla" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 386px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <table class="style1">
        <tr>
            <td align="right" class="style2">
                <b>Enter ID :</b></td>
            <td>
                <asp:TextBox ID="TextBox_Cash" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right" class="style2">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                &nbsp;</td>
            <td>
                <asp:Button ID="btn_markCashBook" runat="server" Text="Mark Cashbook Rights" OnClick="btn_markCashBook_Click" />
                <asp:Label ID="lblmg" runat="server" Text=""></asp:Label>
            </td>
        </tr>
       
    </table>


 
    <div style=" margin-top:10px;  padding-top:10px;" >

    <asp:GridView ID="gridviewCash" runat="server" AutoGenerateColumns="false" >
        <Columns>
        <asp:TemplateField HeaderText="Name">
            <ItemTemplate>
            <asp:Label ID="lblid" Text='<%# Bind("Name") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>


    <asp:TemplateField HeaderText="Dept Name">
            <ItemTemplate>
            <asp:Label ID="lblname" Text='<%# Bind("Dept_Name") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>
            </Columns>

        </asp:GridView>
        </div>
       

</asp:Content>

