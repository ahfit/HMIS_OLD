<%@ Page Title="" Language="C#" MasterPageFile="~/hacims_masterpage_admin.master" Inherits="Finance_BranchAdd" AutoEventWireup="true" CodeFile="BranchAdd.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="bxmain inner_content">
        <h3><span>Add Branch</span></h3>
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">

            <tr>
                <td align="right">Bank Name : </td>
                <td>
                          <asp:DropDownList ID="ddl_bank" AutoPostBack="true" OnSelectedIndexChanged="ddl_bank_SelectedIndexChanged"  runat="server" DataValueField="Bank_ID" DataTextField="Bank_Name">
                    </asp:DropDownList>
                </td>
            </tr>
              <tr>
                <td align="right">Branch Name : </td>
                <td>
                    <asp:TextBox runat="server"  Width="200px" ID="TextBranch"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Branch Address : </td>
                <td>
                    <asp:TextBox runat="server" Width="200px" ID="TextAddress"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Branch Phon : </td>
                <td>
                    <asp:TextBox runat="server" Width="200px" ID="TextPhon"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td align="right">
                    <!--DWLayoutEmptyCell-->
                </td>
                <td>
                    <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Save" />

                </td>

            </tr>
        </table>

    </div>

    <div>
        <asp:GridView ID="gride" Width="100%" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:TemplateField HeaderText="Sr. #">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Bank">
                    <ItemTemplate>
                        <asp:Label ID="labelBank" Text='<%# Bind("Bank_Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Branch">
                    <ItemTemplate>
                        <asp:Label ID="labelBranch" Text='<%# Bind("Branch_Name") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Address">
                    <ItemTemplate>
                        <asp:Label ID="labelAddress" Text='<%# Bind("Branch_address") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>

                  <asp:TemplateField HeaderText="Phon">
                    <ItemTemplate>
                        <asp:Label ID="labelPhon" Text='<%# Bind("Branch_phone") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField> 
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="del" Text="Delete" CommandName='<%# Bind("Branch_ID") %>' runat="server" OnClick="deleteRecord"> </asp:LinkButton>
                    </ItemTemplate>

                </asp:TemplateField>
            </Columns> 
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" /> 
        </asp:GridView>
 

    </div>

</asp:Content>

