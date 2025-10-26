<%@ page language="C#" masterpagefile="~/hacims_masterpage_admin.master" autoeventwireup="true" inherits="subdepartment_Type, App_Web_olgkf540" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <h3 style="margin-left: 480px; font-family:'Times New Roman' ">Add Sub Department Type</h3>
    <div style="text-align: center; margin-left: 350px; margin-top: 10px">
        <table runat="server">
            <tr>
                <td style="text-align: right"><label style="font-size:medium">SubDept Name: </label></td>
                <td align="left">
                    <asp:TextBox ID="txtsubdept" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr colspan="2">
                <td></td>
                <td style="margin-left:10px">
                    <asp:Button ID="btnsave" Text="Save" OnClick="btnsave_Click2" runat="server" />
                </td>
            </tr>
        </table>
    </div>

    <div style="margin-top:40px;margin-left:350px; text-align:center; width:420px;height:150px"">
            <asp:GridView ID="grid" Width="400px" AutoGenerateColumns="false" runat="server">

                <Columns>
                    <asp:TemplateField HeaderStyle-Width="30px" HeaderText="SR #">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderStyle-Width="30px" HeaderText="Subdept_Type_Name">
                        <ItemTemplate>
                            <asp:Label ID="lblsubdept" runat="server" Text='<%# Eval("Subdept_Type_Name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-Width="30px" HeaderText="Delete">
                        <ItemTemplate>
                            <asp:LinkButton ID="btn_delete" Text="Delete" CommandArgument='<%#Eval("SubDept_Type_Id")%>' runat="server" OnClick="btn_delete_Click">

                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderStyle-Width="30px" HeaderText="Edit">
                        <ItemTemplate>
                            <asp:LinkButton ID="btn_edit" Text="Edit" CommandArgument='<%#Eval("SubDept_Type_Id")%>' runat="server" OnClick="btn_edit_Click"></asp:LinkButton>

                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>
    </div>
</asp:Content>
