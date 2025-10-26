<%@ page language="VB" autoeventwireup="false" masterpagefile="~/hacims_masterpage_admin.master" inherits="TestGroup, App_Web_c1jflpj3" enableEventValidation="false" theme="theme_hacims" viewStateEncryptionMode="Never" maintainScrollPositionOnPostBack="true" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="Label_message" runat="server"></asp:Label>
    <div class="bxmain">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbl_form">
            <tr>
                <td align="right" width="40%">Group Name : </td>
                <td>
                    <asp:TextBox ID="TextBoxGName" runat="server" CssClass="input_txt"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Fee :</td>
                <td>
                    <asp:TextBox ID="TextBoxFee" runat="server" CssClass="input_txt" Width="120px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">Department :</td>
                <td>
                    <asp:DropDownList ID="DropDownList_Department" DataTextField="Dept_Name" DataValueField="Dept_Id" OnSelectedIndexChanged="DropDownList_Department_SelectedIndexChanged" AutoPostBack="true" runat="server" Width="120px"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">Sub_Department :</td>
                <td>
                    <asp:DropDownList ID="DropDownList_Sub_Department" DataTextField="SubDept_Name" DataValueField="SubDept_Id" AutoPostBack="true" runat="server" Width="120px"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="right">&nbsp;</td>
                <td>
                    <asp:Button ID="Save" runat="server" Text="Save" /></td>
            </tr>
        </table>
    </div>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="TGID"
        DataSourceID="SqlDataSource1" Width="100%" AllowPaging="True">
        <Columns>
            <asp:BoundField DataField="TGID" HeaderText="Test Group Id" InsertVisible="False" ReadOnly="True"
                SortExpression="TGID" />
            <asp:BoundField DataField="TGName" HeaderText="Test Group " SortExpression="TGName" />
            <asp:BoundField DataField="Fee" HeaderText="Fee" SortExpression="Fee">
                <ItemStyle CssClass="toright" />
            </asp:BoundField>
            <asp:TemplateField>
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Update">Update</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Cancel">Cancel</asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Edit" OnClientClick="return confirmation_edit(this)">Edit</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Delete" OnClientClick="return confirmation(this)">Delete</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle CssClass="GridItem" />
        <PagerStyle CssClass="GridPager" />
        <HeaderStyle CssClass="GridHeader" />
        <AlternatingRowStyle CssClass="GridAltItem" />
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        DeleteCommand="DELETE FROM [TestGroup] WHERE [TGID] = @TGID" InsertCommand="INSERT INTO [TestGroup] ([TGName], [Fee],[DropDownList_Department],[ DropDownList_Sub_Department]) VALUES (@TGName, @Fee,@DropDownList_Department,@DropDownList_Sub_Department)"
        SelectCommand="SELECT * FROM [TestGroup]" UpdateCommand="UPDATE [TestGroup] SET [TGName] = @TGName, [Fee] = @Fee WHERE [TGID] = @TGID" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>">
        <DeleteParameters>
            <asp:Parameter Name="TGID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TGName" Type="String" />
            <asp:Parameter Name="Fee" Type="Int32" />
            <asp:Parameter Name="TGID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="TGName" Type="String" />
            <asp:Parameter Name="Fee" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTestGroupSave" runat="server" ConnectionString="<%$ ConnectionStrings:Admin_Path_ConnStr %>"
        InsertCommand="INSERT INTO TestGroup(TGName, Fee) VALUES (@TGName, @Fee)" ProviderName="<%$ ConnectionStrings:Admin_Path_ConnStr.ProviderName %>">
        <InsertParameters>
            <asp:ControlParameter ControlID="TextBoxGName" Name="TGName" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBoxFee" Name="Fee" PropertyName="Text" />


        </InsertParameters>
    </asp:SqlDataSource>


</asp:Content>
