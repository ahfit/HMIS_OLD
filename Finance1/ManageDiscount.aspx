<%@ page title="" language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="Finance_ManageDiscount, App_Web_ymbcbbcj" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>

        <table align="center" class="table-form">
            <tr align="right">
                <td style="width:40%"><strong>Discount Type :</strong></td>
                <td align="left">
                    <asp:TextBox ID="txtAmountType" runat="server"></asp:TextBox>
                    
                </td>
            </tr>
            <tr>
                <td align="right"><strong>Discount Head :</strong></td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" style="text-align: left">

                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right"><strong>Amount : </strong></td>
                <td>
                    <asp:TextBox ID="txtAmount" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Save" OnClick="Button1_Click" />
                 <asp:Button ID="Button2" runat="server" Text="Update" OnClick="Button2_Click"/></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Label ID="lblmsg" runat="server" Text="Saved Successfully !" Visible="false"></asp:Label>
                     <asp:Label ID="Label1" runat="server" Text="Update Successfully !" Visible="false"></asp:Label>
                </td>
            </tr>
        </table>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" >
            <Columns>

                 <asp:TemplateField HeaderText="ID">
            <ItemTemplate>
            <asp:Label ID="lblname" Text='<%# Bind("ID") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

                        <asp:TemplateField HeaderText="E Code">
            <ItemTemplate>
            <asp:Label ID="lblname1" Text='<%# Bind("E_Code") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

     <asp:TemplateField HeaderText="Discount Type">
            <ItemTemplate>
            <asp:Label ID="lblname2" Text='<%# Bind("DiscountType") %>' runat="server" />
        </ItemTemplate>
    </asp:TemplateField>

                      <asp:TemplateField HeaderText="Amount">
            <ItemTemplate>
            <asp:Label ID="lblname3" Text='<%# Bind("Amount") %>' runat="server" />

                <asp:HiddenField  ID="hfamount" runat="server" Value='<%# Bind("Amount") %>' />
        </ItemTemplate>
    </asp:TemplateField>


                 <asp:TemplateField HeaderText="Edit">
             <ItemTemplate>
                    <asp:LinkButton ID="edit" Text="Edit" CommandName='<%# Bind("ID") %>' runat="server" OnClick="edit_Click" > </asp:LinkButton>
                </ItemTemplate>
           
                 </asp:TemplateField>

                  <asp:TemplateField HeaderText="Delete">
             <ItemTemplate>
                    <asp:LinkButton ID="del" Text="Delete" CommandName='<%# Bind("ID") %>' runat="server" OnClick="deleteRecord" > </asp:LinkButton>
                </ItemTemplate>
           
                 </asp:TemplateField>

               



            </Columns>

        </asp:GridView>

</div>
</asp:Content>

